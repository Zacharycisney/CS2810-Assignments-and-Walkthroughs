#Zach C
#2-28-2023
#description: practice more bitwise operations

#list the name(s) of the procedures
.globl main

#data segment
.data

close: .asciiz "Thanks and have a great snow squall\n"
newLine: .asciiz "\n"
off: .asciiz "off"
on: .asciis "on"



#code segment
.text

#Pseudocode:
#	start with a byte
#	isolate one one of the bits
#	determine if bits are on or off
#	
#
#
#Registers
# a = $t0, b = $t1, c = t2
#
#	set a, b
#	a+b


main:
	li $t0, 0xAB #start with 1010 1011
	#check if bit 5 is on
	#andi $t0, $t1 but what should $t1 be?
	#0010 0000
	andi $t1, $t0, 0X20

	#$t10 should print 1
	
	#what if wanted to check the value
	#sift the 1 to the rigth, so it it's the least significant bit
	#0000 0001
	#how far do we shift it? (and what direction)
	
	srl $t2, $t1, 5
	
	#print the isolated bit
	li $v0, 1 #printing an int
	move $a0, $t2
	syscall
	
	#NEWLINE
	li $v0, 4
	la $a0, newLine
	syscall
	

	
##############################################
	#NEw HEX#
	li $t0, 0XDB
	andi $t1, $t0, 0XA0 #isolate 

	srl $t2, $t1, 5
	
	#li $v0, 11 #new line
	#li $a0, 0x0A
	#syscall

	#li $v0, 1 #printing an int
	#move $a0, $t1
	#syscall
	
	#NEWLINE
	li $v0, 4
	la $a0, newLine
	syscall
	
	beq $t1, 0xA0, they_on
		li $v0, 4
		la $a0, off
		syscall
		
	#NEWLINE
	li $v0, 4
	la $a0, newLine
	syscall
	syscall
		
	j end_main
	
they_on:
	li $v0, 4
	la $a0, on
	syscall

	#NEWLINE
	li $v0, 4
	la $a0, newLine
	syscall

end_main:
	#print graceful close and clean exit
	li $v0, 4
	la $a0, close
	syscall
	
	li $v0, 10 #clean exit
	syscall