####### Definindo os textos ######################################################################
.data
	textoSaida: .asciiz "O resultado do cálculo é igual a "
	textoEntrada: .asciiz "Digite o valor de N: "
.text   
main:
####### Print na tela ###########################################################################
	la $a0, textoEntrada # Carrega em a0 a string que será printada
	li $v0, 4  # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall    # Realiza o syscall imprimindo na tela o texto em $a0
####### Le o  valor e guarde em f0 ##############################################################
	li $v0, 5  # Define em v0 que será lido um int e colocado em v0
	syscall # Lê o int digitado e coloca no registrador v0
####### Funcao #######################################################################
	mtc1 $zero, $f12 # Inicia f12(resultado da soma) com zero
	li $t0,1 # Inicio t0 com 1, sera passado para a unidade de float
	mtc1 $t0,$f0 # Passa 1 para o numerador
	mtc1 $v0, $f2 # Passa o valor digitado para o divisor
	mtc1 $t0,$f4 # Coloca um no registrador para a soma e subtracao   
Loop:
	div.s $f6, $f0, $f2 # Realiza o divisão 
	add.s $f0,$f0, $f4 # Soma a divisão no resultado
	sub.s $f2,$f2,$f4 # Diminui o divisor em 1
	add.s $f12,$f12,$f6 # Aumenta o divisor em 1
	c.lt.s $f2, $f4 # Caso o denominador seja menor que 1 ele sai do loop
	bc1f Loop

####### Imprimindo os dados na tela #############################################################
IMPRIME:
	la $a0, textoSaida # Carrega em a0 a string que será printada
	li $v0, 4 # Define em em v0 o valor 4(Printar uma string, lendo o valor de $a0)
	syscall # Realiza o syscall imprimindo na tela o texto em $a0
	li $v0, 2 # Define em v0 o valor 2(Printar um float colocado em $f12)
    	syscall #Printa na tela o float do registrador f12
	li $v0, 10 # Define em em v0 o valor 10(Saida do programa)
	syscall #Finaliza o programa