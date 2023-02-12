################# Segmento de dados #####################
.data
msgEntrada: .asciiz "Digite um inteiro positivo N: "
msgNumPerfeito: .asciiz " é um número perfeito."
msgNumImperfeito: .asciiz " não é um número perfeito."
################# Segmento de código #####################
.text
.globl main
main: 
################################## Entrada ######################################
    la $a0,msgEntrada # carrega msgEntrada em a0
    li $v0,4 # Imprime a string armazenada em a0
    syscall # Executa a operação especificada em v0 (no caso imprimir string)
    la $v0, 5 # Leitura de inteiro em v0
    syscall 
################################# Variáveis #####################################
    move $s0,$v0 # s0 = N
    li $s1,1 # i = s1 = Denominador = 1
    li $t0, 0 # somaDivisores
################################## Função ######################################
Loop:
    div $s0,$s1 # N/i
    mfhi $t1 # t1 = N % i
    beqz  $t1, Somador # Se resto igual a 0, soma i à somaDivisores
    Volta: 
    addi $s1, $s1, 1 # i += 1
    blt $s1, $s0, Loop # Mantém no Loop enquanto i < N

    j Verificador

Somador:
    add $t0, $t0, $s1 # somaDivisores += i
    j Volta
##################### Decide se é N é um número perfeito #########################
Verificador:
    move $a0,$s0 # carrega N em a0
    li $v0,1 # Imprime N
    syscall
    
    bne $t0, $s0, Else # Se SomaDivisore != N vai para Else
    la $a0,msgNumPerfeito # carrega msgNumPerfeito em a0
    li $v0,4 # Imprime a string armazenada em a0
    syscall
    j Saida
Else:
    la $a0,msgNumImperfeito # carrega msgNumImperfeito em a0
    li $v0,4 # Imprime a string armazenada em 
    syscall
################################## Saída ######################################
Saida:
    li $v0, 10 # Sai do programa
    syscall
