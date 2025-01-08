

.data
prompt: .asciiz "Please enter a number: "
grt: .asciiz " is greater than 100 and the result after multiplying by 8 is "
lst: .asciiz " is less than 100  and the result after adding 12 is "

#if (i > 100)
#	multiply by 8
#else
#	add 12
#
#registers: answer
#$s0 = answer,
#$s1 =  input,


.text
#print prompt
	li $v0, 4
	la $a0, prompt
	syscall

#read in integer (i)
	li $v0, 5
	syscall
	move $s1, $v0
	
#less than 100
slti $s0, $s1, 100

#checks if $s0 is 1 (which would mean that the input is less than 100)
	bne $s0, 1, then
	
	add $s0, $s1, 12# input + 12
	
	#print answer 
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, lst
	syscall
	
	#print answer after  
	li $v0, 1
	move $a0, $s0
	syscall
	
	j exit
	
then:
	
	mul $s0, $s1, 8# input * 8
	
	#print answer 
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, grt
	syscall
	
	#print answer after  
	li $v0, 1
	move $a0, $s0
	syscall

exit:	
#exit program
	li $v0, 10
	syscall
