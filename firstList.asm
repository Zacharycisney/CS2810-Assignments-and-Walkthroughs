#name: Zach C
#description: this si practing arrays in MIPS


.data



prompt: .asciiz "Enter a one digit number: "
zero: .asciiz "n is zero\n"
even: .asciiz "n is even\n"
square: .asciiz "n is square\n"
prime: .asciiz "n is prime\n"
bad: .asciiz "out of range\n"

#switch block jump table
switch: .word case0, case1, case2, case3, case4, case5, case6, case7, case8, case9
#what is the index of each word
#index		0 	1 	2...
#how big is each element? word, which is 4 bytes
#So we have to move 4 bytes to get to the 'next' on
#index		0*4	1*4	2*4
# n = index	n=0*4, n=1*4


.text
	
	#prompt for one digit number
	li $v0, 4 #print prompt
	la $a0, prompt
	syscall
	
	#read in the number
	li $v0, 5 #read int
	syscall
	move $t0, $v0 #move  the input into t0
	
	#print the number
#	li $v0, 1
#	move $a0, $t0
#	syscall


#set up the switch
	
		#set up to print ***permanent for code cases***
		li $v0, 4
	
		#branch to deafault
		blt $t0, 0, default #if n<0, branch to default
		bgt $t0, 9, default #if n>9, branch to default

		#calculate the case to jump to 
		mul $t1, $t0, 4 #temp = n +4
		lw $t1, switch($t1) #temp = temp(temp)					###    MAJIC HERE    ###
		jr $t1
		
case0:
	 la $a0, zero
	 syscall
	 j exit

case4: #4 drops into case 9 prime
	la $a0, even
	syscall	 
case1: #1 drops into case 9 prime
case9:	 
	la $a0, square
	syscall
	j exit
	
case2:
	la $a0, even
	syscall
	j exit
	
case3:
	la $a0, prime
	syscall
	j exit
	
case5:
	la $a0, prime
	syscall
	j exit
	
case6:
	la $a0, even
	syscall
	j exit 
	
case7:
	la $a0, prime
	syscall
	j exit
	
case8:
	la $a0, even
	syscall
	j exit
	

default:
	#li $v0, 4 #print bad when  input bad
	la $a0, bad
	syscall

exit: 
	li $v0, 10
	syscall

