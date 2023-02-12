####### Definindo os textos ######################################################################
.data
	textoSaida1: .asciiz "x1 = "
	textoSaida2: .asciiz "\nx2 = "
	textoEntradaA: .asciiz "Digite o valor de A: "
	textoEntradaB: .asciiz "Digite o valor de B: "
	textoEntradaC: .asciiz "Digite o valor de C: "
	menosUm: .double -1.0
	dois: .double 2.0
	quatro: .double 4.0
.text   
main:
####### Print na tela A ###########################################################################
	la $a0, textoEntradaA # Carrega em a0 a string que sera printada
	li $v0, 4  # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall    # Realiza o syscall imprimindo na tela o texto em $a0
####### Le o  valor e guarde em f0 ##############################################################
	li $v0, 7  # Define em v0 que sera lido um int e colocado em f0
	syscall # Le o int digitado e coloca no registrador f0
	mov.d  $f2,$f0
####### Print na tela B ###########################################################################
	la $a0, textoEntradaB # Carrega em a0 a string que ser� printada
	li $v0, 4  # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall    # Realiza o syscall imprimindo na tela o texto em $a0
####### Le o  valor e guarde em f0 ##############################################################
	li $v0, 7  # Define em v0 que ser� lido um int e colocado em v0
	syscall # Le o int digitado e coloca no registrador v0
	mov.d $f4,$f0

####### Print na tela C ###########################################################################
	la $a0, textoEntradaC # Carrega em a0 a string que ser� printada
	li $v0, 4  # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall    # Realiza o syscall imprimindo na tela o texto em $a0
####### Le o  valor e guarde em f0 ##############################################################
	li $v0, 7  # Define em v0 que ser� lido um int e colocado em v0
	syscall # Le o int digitado e coloca no registrador v0
	
###### delta	
	l.d $f20,quatro
	mul.d $f6,$f4,$f4 #b*b
	mul.d $f8,$f2,$f0 #a * c
	mul.d $f8,$f8,$f20 #4*ac
	sub.d $f8,$f6,$f8 #(b*b) - 4ac
	
#######
	sqrt.d $f8,$f8 #raiz de delta
	
	l.d $f20, dois
	mul.d $f20,$f2,$f20 #2a
	
	l.d $f22, menosUm
	mul.d  $f4,$f4,$f22 #-b

###### X1
	add.d  $f6,$f4,$f8 # -b + raiz delta
	div.d $f12,$f6,$f20 # .../2a
	
	la $a0, textoSaida1 # Carrega em a0 a string que sera printada
	li $v0, 4 # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall # Realiza o syscall imprimindo na tela o texto em $a0
	li $v0, 3 # Define em v0 o valor 2(Printar um float colocado em $f12)
    	syscall #Printa na tela o float do registrador f12
    	
###### X2
    	sub.d  $f6,$f4,$f8 # -b - raiz delta
	div.d $f12,$f6,$f20 # .../2a

	la $a0, textoSaida2 # Carrega em a0 a string que ser� printada
	li $v0, 4 # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall # Realiza o syscall imprimindo na tela o texto em $a0
	li $v0, 3 # Define em v0 o valor 2(Printar um float colocado em $f12)
    	syscall #Printa na tela o float do registrador f12
    	
###### FIM
	li $v0, 10 # Define em em v0 o valor 10(Saida do programa)
	syscall #Finaliza o programa
