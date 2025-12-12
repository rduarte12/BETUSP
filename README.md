A instrução **POW** foi adicionada como operação aritmética da ISA (opcode 38) que calcula \(Rx \leftarrow (Ry)^{Rz}\) em inteiros de 16 bits, utilizando a ULA existente para multiplicação e subtração em dois ciclos por iteração (EXECUTE e EXECUTE2).  A instrução é destrutiva em `Rz`, que funciona como contador do expoente, enquanto `Ry` preserva a base durante todo o cálculo.[1]

## Definição da instrução e opcode

No cabeçalho da CPU, POW é declarada como instrução aritmética de 3 registradores:

```c
#define LMOD 37 // "100101" -- MOD Rx Ry Rz
#define POW  38 // "100110"; -- POW Rx Ry Rz -- Rx <- Ry POW Rz
// Format: < inst(6) | Rx(3) | Ry(3) | Rz(3) | x >
```


O formato é igual a ADD/SUB/MULT/DIV: 6 bits de opcode, 3 bits para Rx, Ry, Rz e 1 bit não usado.

## Decodificação (STATE_DECODE): inicialização da POW

No estado de decodificação, quando `opcode == POW`, a CPU prepara o estado interno:

```c
case POW:
    // Rx, Ry, Rz já foram extraídos de IR antes no loop
    reg[rx] = 1;                     // acumulador inicial = 1
    FR[ZERO] = 0;                    // limpa flag ZERO
    FR[ARITHMETIC_OVERFLOW] = 0;     // limpa flag de overflow aritmético
    // não mexe em Ry nem Rz: base e expoente vêm do programa
    state = STATE_EXECUTE;           // entra no fluxo multi-ciclo da POW
    break;
```


Após esse ciclo:

- `Rx` passa a ser o acumulador do resultado (começa em 1).  
- `Ry` contém a base.  
- `Rz` contém o expoente.  

## EXECUTE (STATE_EXECUTE): multiplicação e teste do expoente

No estado EXECUTE, a POW faz a multiplicação e decide se termina ou continua:

```c
case STATE_EXECUTE:
    switch(opcode){

    case POW:
        if (reg[rz] == 0) {
            // Terminei: resultado final está em Rx
            FR[ZERO] = (reg[rx] == 0);
            state = STATE_FETCH;          // próxima instrução
        } else {
            // 1º ciclo da iteração: Rx = Rx * Ry usando a ULA

            selM3 = rx;                  // M3 = reg[rx] (acumulador atual)
            selM4 = ry;                  // M4 = reg[ry] (base)
            OP    = MULT;                // operação de multiplicação
            carry = 0;

            selM2 = sULA;                // M2 recebe resultado da ULA
            LoadReg[rx] = 1;             // grava em Rx

            selM6 = sULA;                // flags da ULA → FR
            LoadFR = 1;

            // Próximo ciclo: decrementar expoente em STATE_EXECUTE2
            state = STATE_EXECUTE2;
        }
        break;

    /* demais cases... */
```


No final do loop principal:

- `resultadoUla = ULA(M3, M4, OP, carry)` calcula `result = reg[rx] * reg[ry]`.[1]
- `selM2 = sULA` faz `M2 = resultadoUla.result`.  
- O laço de escrita:

  ```c
  for (i=0; i<8; i++)
      if (LoadReg[i]) reg[i] = M2;
  ```

  grava o novo valor em `reg[rx]` porque `LoadReg[rx] = 1`.[1]

Se `reg[rz]` ainda for maior que zero, a execução passa para `STATE_EXECUTE2`.

## EXECUTE2 (STATE_EXECUTE2): decremento do expoente via ULA

No `STATE_EXECUTE2`, a POW consome 1 unidade do expoente usando a ULA em modo SUB:

```c
case STATE_EXECUTE2:
    switch(opcode){

    case POW:
        // 2º ciclo da iteração: Rz = Rz - 1 via ULA

        selM3 = rz;          // M3 = reg[rz] (expoente atual)
        selM4 = 8;           // M4 = 1 (literal via Mux4, como em INC)
        OP    = SUB;         // operação de subtração
        carry = 0;

        selM2 = sULA;        // M2 recebe resultadoUla.result
        LoadReg[rz] = 1;     // grava novo expoente em Rz

        selM6 = sULA;        // flags da ULA → FR (NEGATIVE/ZERO, etc.)
        LoadFR = 1;

        // Volta para EXECUTE para testar reg[rz] e decidir próxima iteração
        state = STATE_EXECUTE;
        break;

    /* demais cases... */
    }
    break;
```


Assim, cada iteração de POW usa dois ciclos:

1. EXECUTE: `Rx ← Rx * Ry`.  
2. EXECUTE2: `Rz ← Rz − 1`.  

Quando `Rz` chega a 0, o próximo EXECUTE termina a instrução e volta para FETCH.

## Exemplo de uso e teste (imprime '@')

O programa de teste configura base, expoente e combina o resultado com um código ASCII para imprimir o caractere `'@'` na tela:

```asm
; ... testes anteriores ...

; --------- Teste do POW ---------
; base = 2 em R1, expoente = 4 em R2, resultado em R0

loadn r1, #2          ; base = 2
loadn r2, #4          ; expoente = 4

; No .mif, este NOP foi substituído manualmente por POW R0, R1, R2
nop

; Usa o resultado R0 = 2^4 = 16 para gerar um caractere ASCII
loadn r3, #'0'        ; 48 decimal
add   r0, r0, r3      ; R0 = 16 + 48 = 64 -> '@' em ASCII
loadn r4, #32         ; linha 32 da tela
outchar r0, r4        ; imprime '@' na linha 32

Fim:
halt

Dado : var #1
static Dado + #0, #'B'
```


No arquivo `.mif` gerado pelo montador (Hello4.mif), o `nop` desse bloco foi substituído manualmente pela palavra binária da POW:

```text
164:1001100000010100;   -- POW R0, R1, R2
165:1110000110000000;
166:0000000000110000;   -- loadn r3, #'0' (48)
167:1000000000000110;   -- add r0, r0, r3
168:1110001000000000;
169:0000000000100000;   -- loadn r4, #32
170:1100100001000000;   -- outchar r0, r4
171:0011110000000000;   -- halt
```


Com essa configuração:

- POW calcula \(2^4 = 16\) em `R0` através de múltiplos ciclos EXECUTE/EXECUTE2.[2][1]
- `loadn r3, #'0'` carrega 48 em `R3`.[3]
- `add r0, r0, r3` soma 16 + 48 = 64, código ASCII de `'@'`.[1]
- `outchar r0, r4` imprime o caractere `'@'` na linha 32, confirmando visualmente que o valor numérico produzido pela POW está correto e foi combinado como esperado com o deslocamento ASCII.[3][2]
