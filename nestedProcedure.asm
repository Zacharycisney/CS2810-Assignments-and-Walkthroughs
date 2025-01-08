# Author:
# Date:
# Description: learn about nested procedures
.data
# string constants
hello: .asciiz "Inside Hello procedure\n"
hola: .asciiz "Inside Hola procedure\n"
name: .asciiz "Hi Pedro\n "
close: .asciiz "\nNested Procedures are fun!!\n Have a great summer!!\n"



.text

	#call to hello
	la $a0, name
	jal hello_proc
	
	#call to hola
	la $a0, name
	jal hola_proc

end: 
	#print hello
	li $v0, 4 #prunt string
	la $a0, close
	syscall
	
	li $v0, 10 #exit
	syscall
###############################################################
# Print Hello String + name string
#
# $a0 - input, name string
# uses $s0 for input parameter (required)


hello_proc:
	#there is only one register to store the return address ($ra). It gets overwritten in the jump to hola_proc
	#save the register to the stack
	subu $sp, $sp, 32 #frame size is 32, (begins allocation)
	sw $ra, 28($sp)	 #preserve the return address (required) 
	sw $fp, 24($sp) # preserve the frame counter (required)
	sw $s0, 20($sp) #preserve register $s0, if needed
	### this is not need for our program ### sw $a1, 16($sp)#preserve $s1, if needed

	addu $fp, $sp, 32 #move frame point to the base frame (end allocation)
	

	# set return value
	move $s0, $a0 #storing name
	
	#print hello
	li $v0, 4 #print string
	la $a0, hello
	syscall
	
	move $a0, $s0
	syscall
	
	#getting confused about the value of $ra, when jumping BACK from hola_proc
	#anytime you call a procedure, you have to save value of $ra before jumping (line 41+)
	
	#call hola
	move $a0, $s0 #load the name into the argument
	jal hola_proc
	
	#load return address
	lw $ra, 28($sp) #restoring address (requiered)
	lw $fp, 24($sp) #restore frame counter (requiered)
	lw $s0, 20($sp) #restore $s0 if necessary
	#restore $s1 if necessary
	addu $sp, $sp, 32 #move frame pointer to base
	
end_hello_proc:
	jr $ra
	
	
	
	
hola_proc:
	# set return value
	move $s0, $a0
	
	#print hello
	li $v0, 4 #prunt string
	la $a0, hola
	syscall
	
	move $a0, $s0
	syscall
	
end_hola_proc:
	jr $ra
