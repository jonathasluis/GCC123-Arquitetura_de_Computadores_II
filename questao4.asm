####### Definindo os textos ######################################################################
.data
	inicio: .asciiz "Inicio do programa\n"
	fim: .asciiz "Fim do programa\n"
	endl: .asciiz "\n"
.text   
main:

####### Funcao #######################################################################

	li $t0, 1000 # Inicio t0 em 1000 (primeiro milhar com 4 algarismos)
  	la $a0, inicio # Imprime Inicio do Programa
	li $v0, 4 
	syscall 
	la $a0, endl # Imprime  \n
	syscall 
	
Loop:
	bgt $t0, 9999, Exit # Condicao do loop t0 <= 9999 (ultimo milhar com 4 algarismos)
	li $t3, 100
	div $t0,$t3 # faz a divisão de t0 por 100
	mfhi $t1 # t1 recece os dois ultimos algarismos (--XX) de t0
	mflo $t2 # t2 recebe os dois primeiros algarismos (XX--) de t0
	add $t1, $t1, $t2 # t1 + t2
	mul $t1, $t1, $t1 # (t1 + t2)^2
	beq $t0, $t1, print # Caso (t1 + t2)^2 == t0 imprime o valor na tela
	addi $t0, $t0, 1 # t0++
	j Loop 
	
Exit:
	la $a0, endl # Imprime  \n
	li $v0, 4 
	syscall
	la $a0, fim # Imprime fim do programa
	syscall 
	li $v0, 10 # Chamada para encerrar o programa
	syscall 
	
print:
	move $a0, $t0 # Imprime o valor de t0 em que a condicao do problema é atingida
	li $v0, 1 # 
	syscall #
	la $a0, endl # Imprime  \n
	li $v0, 4 
	syscall
	addi $t0, $t0, 1 # Imcremento do loop
	j Loop # Retorna ao loop

