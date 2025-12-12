A instrução **POW** foi adicionada como uma operação aritmética da ISA (opcode 38) que calcula \(Rx \leftarrow (Ry)^{Rz}\) em inteiros de 16 bits, usando a própria ULA de multiplicação em vários ciclos do estado `STATE_EXECUTE`.  A implementação é multi‑ciclo: o decode apenas inicializa o acumulador, e o laço de execução fica modelado na própria máquina de estados, repetindo `STATE_EXECUTE` até o expoente zerar.[1]

## Código adicionado no processador

1. Definição do opcode no cabeçalho de instruções:

```c
#define LMOD 37 // "100101"
#define POW  38 // "100110"; -- POW Rx Ry Rz -- Rx <- Ry POW Rz
// Format: < inst(6) | Rx(3) | Ry(3) | Rz(3) | x >
```


2. Tratamento no `STATE_DECODE`: inicializa o acumulador e entra em execução multi‑ciclo:

```c
case POW:
    // Rx, Ry, Rz já foram extraídos de IR antes no loop
    reg[rx] = 1;                     // acumulador inicial = 1
    FR[ZERO] = 0;                    // limpa flag de ZERO (provisório)
    FR[ARITHMETIC_OVERFLOW] = 0;     // limpa overflow
    // não mexe em Ry nem Rz: base e expoente vêm do programa
    state = STATE_EXECUTE;           // vamos iterar em EXECUTE
    break;
```


3. Tratamento no `STATE_EXECUTE`: um passo de multiplicação por ciclo, decrementando o expoente em registrador:

```c
case STATE_EXECUTE:
    switch(opcode) {

    case POW:
        if (reg[rz] == 0) {
            // Terminei: resultado final está em Rx
            FR[ZERO] = (reg[rx] == 0);
            state = STATE_FETCH;           // próxima instrução
        } else {
            // Um passo: Rx = Rx * Ry usando a ULA
            selM3 = rx;                    // M3 = reg[rx] (acc)
            selM4 = ry;                    // M4 = reg[ry] (base)
            OP    = MULT;                  // operação de multiplicação
            carry = 0;
            selM2 = sULA;                  // M2 recebe resultado da ULA
            LoadReg[rx] = 1;               // grava em Rx
            selM6 = sULA;                  // flags da ULA → FR
            LoadFR = 1;

            reg[rz]--;                     // expoente-- (destrutivo)
            state = STATE_EXECUTE;         // continua a mesma instrução POW
        }
        break;

    /* demais cases: LOAD, STORE, CALL, POP, RTS, ... */
}
```


Nesse arranjo, `Rx` funciona como acumulador do resultado parcial, `Ry` guarda a base fixa e `Rz` é consumido como contador de expoente; cada ciclo de `STATE_EXECUTE` faz, via ULA, uma multiplicação `Rx * Ry` (operador `MULT`) e decrementa `Rz` até que `Rz == 0`, quando o controle sai da POW e volta para o ciclo normal de busca.[1]

## Exemplo de código e teste funcional

Para testar a instrução, foi acrescentado ao programa `TesteCPU.asm` um bloco no final que calcula \(2^4\) e converte o resultado em caractere ASCII para ser impresso:

```asm
; --------- Teste do POW ---------
; base = 2 em R1, expoente = 4 em R2, resultado em R0

loadn r1, #2          ; base = 2
loadn r2, #4          ; expoente = 4

nop                   ; placeholder que é substituído por POW R0, R1, R2 no .mif

; Usa o resultado em R0 (2^4 = 16) para gerar um caractere de teste
loadn r3, #64         ; constante escolhida para obter 'P' (80) após a soma
add   r0, r0, r3      ; R0 = 16 + 64 = 80 -> 'P'
loadn r4, #32         ; linha 32 da tela
outchar r0, r4        ; imprime 'P' na linha 32

Fim:
halt
```


No arquivo `.mif` gerado pelo montador, o `nop` desse bloco foi substituído manualmente pela palavra binária `1001100000010100` na posição 164, que codifica a instrução `POW R0, R1, R2` (opcode 38, Rx=0, Ry=1, Rz=2).  Na execução do simulador, o fluxo passa por `LOADN R1,#2` e `LOADN R2,#4`, executa a POW multi‑ciclo até produzir 16 em `R0`, soma esse valor com o imediato 64 carregado em `R3` e, por fim, `OUTCHAR` imprime o caractere `'P'` na linha 32, confirmando visualmente que a instrução POW está funcionando como esperado.[2][1]
