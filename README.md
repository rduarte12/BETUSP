https://youtu.be/sGQLHYy7X4M
### Implementação de intrução nova em processador
A instrução **POW** foi adicionada como uma operação aritmética da ISA (opcode 38) que calcula \(Rx \leftarrow (Ry)^{Rz}\) em inteiros de 16 bits, usando a própria ULA de multiplicação em vários ciclos do estado `STATE_EXECUTE`.  A implementação é multi‑ciclo: o decode apenas inicializa o acumulador, e o laço de execução fica modelado na própria máquina de estados, repetindo `STATE_EXECUTE` até o expoente zerar.[1]

### Intuição do jogo
O jogo em essência é um simulador de apostas de caça-níquel, onde a ideia é fazer pares ou trios de números para duplicar a aposta do personagem, o qual pode apostar fichas de unidades, dezena e por aí vai. O jogo foi projetado em linguagem Assembly, sendo executado diretamente sobre o hardware, e conta com quatro funções principais.

### FUNÇÕES ARQUITETURAIS CHAVE
1. Rotina: _takeCommand (Controle e Decodificação de E/S)
Esta rotina atua como o Driver de Entrada/Unidade de Decodificação de Comandos. Sua função primária é gerenciar a E/S Mapeada em Memória através do inchar r0, lendo o valor ASCII da tecla. Ela emprega o método de Polling ativo (_takeCommand_Loop) e utiliza CMP e JEQ para decodificar qual comando foi dado. Crucialmente, ela manipula o Carry Flag (setc/clearc) antes de retornar, sinalizando o GameLoop se o jogo deve parar ou continuar. 

#### Polling Ativo, Decodificação de Comandos e Sinalização do Carry Flag (FR)
```
_takeCommand_Loop:
  inchar r0               ; [1] Lê o valor ASCII do teclado (E/S Mapeada)
  cmp r0, r1              ; Compara com o valor #255 (tecla não pressionada)
  jne _takeCommand_LoopExit ; Se diferente, sai do loop de Polling.
  inc r3                  ; Se igual, continua o loop ativo.
  mod r3, r3, r4
  jmp _takeCommand_Loop
;
_takeCommand_LoopExit:
  loadn r1, #13           ; Código ASCII para <Enter>
  cmp r0, r1
  jeq _takeCommand_Enter  ; Salta para a rotina de Aposta (Wager)
;
_takeCommand_Space:
  ; Stop
  jmp _takeCommand_ClearC ; Salta para a rotina de parada.
;
_takeCommand_ClearC:
  clearc                  ; [2] Limpa o Carry Flag para sinalizar FIM de JOGO
  jmp _takeCommand_Exit
;
_takeCommand_SetC:
  setc                    ; [3] Seta o Carry Flag para sinalizar CONTINUA
  jmp _takeCommand_Exit
```



2. Rotina: wager (Lógica Central e ULA)
Esta é a Unidade de Processamento Financeiro do jogo. Ela utiliza extensivamente a ULA (Unidade Lógica e Aritmética) com instruções como mod, div, e mul para determinar o multiplicador de ganho. No bloco waget_CalMoney, ela calcula o novo saldo (Money -= Chips; Money += Chips * Multiplicador) e, vitalmente, inclui o Check de Overflow/Limite (cmp r0, r3 e jgr waget_Overflow) contra a variável Limit antes de finalizar a operação e usar store Money, r1 para atualizar o estado.

#### Uso da ULA (MOD, MUL, SUB, ADD) e Checagem de Overflow/Limite.

```
; Trecho de Cálculo do Multiplicador (Lógica da ULA)
loadn r1, #111
mod r2, r0, r1          ; Verifica se é um Trio de Dígitos (r0 % 111 == 0)
jz wager_Triple         ; Salta se o Zero Flag estiver setado

; Trecho de Cálculo e Checagem de Overflow
waget_CalMoney:
  call getChips         ; [r0] = Chips
  load r1, Money        ; [r1] = Money
  load r3, Limit        ; [r3] = Limit

  sub r1, r1, r0        ; [1] Money -= Chips (Subtrai o valor apostado)
  mul r0, r0, r2        ; [2] Chips *= [r2] (Calcula o lucro)

  sub r3, r3, r1        ; [3] Calcula margem: Limit - (Money - Chips)
  cmp r0, r3
  jgr waget_Overflow    ; [4] Salta se o lucro excede a margem (Overflow)

  add r1, r0, r1        ; [5] Money += Lucro
  jmp waget_Store
```

3. Rotina: printMoney (Conversão de Dados e Display)
Esta rotina funciona como um Conversor Decimal e Driver de Display. O dinheiro é armazenado em binário, mas precisa ser exibido em decimal; a rotina usa o algoritmo de divisão e módulo por #10 (div e mod) de forma repetitiva para extrair cada dígito decimal. Ela utiliza a Pilha (PUSH/POP) como memória temporária para corrigir a ordem de impressão. Após a conversão, ela adiciona o código de cor (#560) e usa outchar r2, r4 para realizar a escrita no buffer de memória de vídeo.

#### 
```
_takeCommand_Loop:
  inchar r0               ; [1] Lê o valor ASCII do teclado (E/S Mapeada)
  cmp r0, r1              ; Compara com o valor #255 (tecla não pressionada)
  jne _takeCommand_LoopExit ; Se diferente, sai do loop de Polling.
  inc r3                  ; Se igual, continua o loop ativo.
  mod r3, r3, r4
  jmp _takeCommand_Loop
;
_takeCommand_LoopExit:
  loadn r1, #13           ; Código ASCII para <Enter>
  cmp r0, r1
  jeq _takeCommand_Enter  ; Salta para a rotina de Aposta (Wager)
;
_takeCommand_Space:
  ; Stop
  jmp _takeCommand_ClearC ; Salta para a rotina de parada.
;
_takeCommand_ClearC:
  clearc                  ; [2] Limpa o Carry Flag para sinalizar FIM de JOGO
  jmp _takeCommand_Exit
;
_takeCommand_SetC:
  setc                    ; [3] Seta o Carry Flag para sinalizar CONTINUA
  jmp _takeCommand_Exit
```

4. Rotina: _showInitialScreen (Fluxo de Controle e Integridade)
Esta rotina gerencia o Ciclo de Controle Inicial e Desvio Condicional da tela de abertura. Ela demonstra o uso de Loops de Controle (_showInitialScreen_Loop) e do polling de entrada (call IncharDelay) para esperar ativamente por um comando. A rotina usa o CMP para comparar a entrada do teclado com os códigos #13 (Enter) e #63 ('?'), e um salto condicional (jeq) para controlar a transição para o GameStart ou o tutorial. Mais importante, ela é um exemplo de Administração de Pilha (PUSH/POP/RTS), salvando e restaurando o contexto dos registradores.

#### Conversão Binário $\to$ Decimal, uso da Pilha (PUSH/POP) para reversão de ordem e E/S Mapeada. 
```
printMoney_PUSH:
		
		mod r2, r1, r0      ; [1] Extrai o último dígito (r2 = r1 % 10)
		
		push r2             ; [2] Usa a Pilha para armazenar o dígito
		inc r3
    dec r6
		
		div r1, r1, r0      ; [3] Remove o dígito (r1 = r1 / 10)
		
		jnz printMoney_PUSH ; Repete até que r1 seja zero
	;
	
	printMoney_POP:
		
		pop r2              ; [4] Recupera o dígito da Pilha na ordem correta
	
		add r2, r2, r5      ; [5] Adiciona o código de cor + ASCII '0'
		
		outchar r2, r4      ; [6] Envia o caractere colorido para o VÍDEO (E/S)

		inc r4
		dec r3
		jnz printMoney_POP
```


## Código adicionado no processador
=======
A instrução **POW** foi adicionada como operação aritmética da ISA (opcode 38) que calcula \(Rx \leftarrow (Ry)^{Rz}\) em inteiros de 16 bits, utilizando a ULA existente para multiplicação e subtração em dois ciclos por iteração (EXECUTE e EXECUTE2).  A instrução é destrutiva em `Rz`, que funciona como contador do expoente, enquanto `Ry` preserva a base durante todo o cálculo.[1]

## Definição da instrução e opcode
>>>>>>> 436ade854c12e44d8dfe008ae0bcfa1b440bca2b

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
        if (reg[rz] <= 0) {
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
