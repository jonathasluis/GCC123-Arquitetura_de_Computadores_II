################# Segmento de dados #####################
.data
msgEntradaN: .asciiz "Digite um inteiro positivo N: "
msgEntradaI: .asciiz "Digite um inteiro positivo i: "
msgEntradaJ: .asciiz "Digite um inteiro positivo j: "
msgResultado: .asciiz "Múltiplos de i ou j ou de ambos: "
virgula: .asciiz ","
################# Segmento de código #####################
.text
.globl main
main: 
################################## Entrada ######################################
    la $a0,msgEntradaN # carrega msgEntrada em a0
    li $v0,4 # Imprime a string armazenada em a0
    syscall # Executa a operação especificada em v0 (no caso imprimir string)
    la $v0,5 # Leitura de inteiro em v0
    syscall 
    move $t0,$v0 # t0 = N
    
    la $a0,msgEntradaI
    li $v0,4 # Imprime a string armazenada em a0
    syscall # Executa a operação especificada em v0 (no caso imprimir string)
    la $v0,5 # Leitura de inteiro em v0
    syscall 
    move $t1,$v0 # t1 = i
    
    la $a0,msgEntradaJ
    li $v0,4 # Imprime a string armazenada em a0
    syscall # Executa a operação especificada em v0 (no caso imprimir string)
    la $v0,5 # Leitura de inteiro em v0
    syscall 
    move $t2,$v0 # t2 = j
   
################################# Variáveis #####################################
    # $s0 = numerador = 0
    # $t9 = contadorDeMultiplos = 0
################################## Função ######################################
    la $a0, msgResultado # carrega msgResultado em a0
    li $v0, 4 # Imprime a string armazenada em a0
    syscall 
Loop:
    move $s1,$t1 # s1 = i
    div $s0,$s1 # numerador/i
    mfhi $t3 # t3 = numerador%i
    bnez $t3,Else # Se numerador%i != 0 vai para Else
    j ImprimeMultiplo
    
    Else:
    move $s1, $t2 # s1 = j
    div $s0,$s1 # numerador/i
    mfhi $t3 # t3 = numerador%j
    beqz $t3,ImprimeMultiplo # Se numerador%j = 0 vai para ImprimeMultiplo
    
    VoltaLoop:
    addi $s0,$s0,1 # Incrementa o numerador += 1
    blt $t9, $t0, Loop # Se contadorDeMultiplos < N vai para o Loop
    
    j Saida
########################## Impressão dos Resultados #############################  
ImprimeMultiplo:
    move $a0, $s0 # a0 = numerador
    li $v0, 1 # Imprime o inteiro armazenada em a0
    syscall
    subi $t8, $t0, 1 # t8 = N - 1
    blt $t9, $t8, ImprimeVirgula # Se não é o último termo, então imprime vírgula
    VoltaImprimeMultiplo:
    addi $t9,$t9, 1 # Incrementa o contadorDeMultiplos += 1
    j VoltaLoop

ImprimeVirgula:
    la $a0,virgula
    li $v0,4 # Imprime a string armazenada em a0
    syscall # Executa a operação especificada em v0 (no caso imprimir string)
    j VoltaImprimeMultiplo
################################## Saída ######################################
Saida:
    li $v0, 10 # Sai do programa
    syscall
