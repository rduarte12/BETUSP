
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
