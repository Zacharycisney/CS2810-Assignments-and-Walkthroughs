# Author: Zach Cisney
# Date: 4-8-2023
# Description: This program stores a single floating point input from the user and then performs bit operartions to determine attributes of the floating point
.macro print_str (%string)
	la $a0, %string
	li $v0, 4
	syscall
.end_macro
.globl read_float, print_sign, print_exp, print_significand, print_ieee, main 
	#Do not remove this line
	
# Data for the program goes here
.data
ieee: .word 0 # store your input here
again: .asciiz "Do you want to do it again?"
prompt: .asciiz "Enter an IEEE 754 floating point number in decimal form: "
res_sign: .asciiz "\n\n\nThe sign is: "
new_line: .asciiz "\n"
new_space: .asciiz " "
expoBias: .asciiz "\nExpo with bias: "
expoNoBias: .asciiz "\nExpo without bias: "
manti: .asciiz "\nMantissa: "
sieee: .asciiz "\nIEEE-754 Single Prec: "

.text	# Code goes here
main:
loop:	
	
	jal  read_float
	
	jal print_sign

	jal print_exp

	jal print_significand
	
	jal print_ieee
	
	
	
	# Task 1: Try again pop-up
	li $v0, 50 #dialog box
	li $a1, 1 #type of message
	la $a0, again
	syscall
	
	beqz $a0, loop #response in $a0 yes(0), no(1), cancel(2)
	
exit_main:
li $v0, 10 	# 0 is the exit program syscall
syscall 	# execute call
## end of ca.asm








read_float:

	################################################################
	# Procedure void read_float()
	# Functional Description: Reads input from user using a pop up
	# gui. It stores the capture value in ieee memory space
	# Argument parameters: None
	# Return Value: None
	#########################################################`#######
	
	# Register Usage: 
	#	$f0 takes in float
	#	$t0 stores float temporarilly 
	
##### Task 2: Call read_float() ######
	#GUI and Prompt
	li $v0, 52
	li $a1, 1
	la $a0, prompt
	syscall
	
	#Floating-point to temp reg
	mfc1 $t0, $f0 # copy register $f0 to $t0				<---
	
	#Temp register to ieee
	sw  $t0, ieee

read_float_ret:
	jr $ra


print_sign:

	################################################################
	# Procedure void print_sign(ieee)
	# Functional Description: Extracts the sign bit from the input param
	# and prints it to the screen with a corresponding message
	# Argument parameters:
	# $a0: ieee single precession value
	# Return Value: None
	#
	# Note: sign character: 0x2B = '+', 0x2D = '-'
	################################################################
	# Register Usage:
	#	ieee has our stored number
	#	$t0 for manipulation without ruining our input
	
# Task 3: Call print_sign(ieee)

	#resetting manipulation register
	lw  $t0, ieee
	
	#printing the sign tag
	li $v0, 4
	la $a0, res_sign 
	syscall 
	
	# The sign bit is the most significand bit	
	srl $t0, $t0, 31  # shift right by 31 bits, clearing
	sll $t0, $t0, 31  # shift left by 31 bits, isolating the 31st bit	
	
	bgez $t0, positive #if zero negative
	li $a0, 45 #negative
	li $v0, 11 #print
	syscall
	j end_print_sign

	positive:
	li $a0, 43 #positive
	li $v0, 11 #print
	syscall
 	
end_print_sign:
	jr $ra


print_exp:
	################################################################
	# Procedure void print_exp(ieee)
	# Functional Description: Extracts the exponent bits from the input param
	# and prints it to the screen with a corresponding message
	# Argument parameters:
	# $a0: ieee single precession value
	# Return Value: None
	################################################################
	# Register Usage:
	#	ieee has our stored number
	#	$t0 for manipulation without ruining our input (with no bias)
	#	$t1 with bias
# Task 4: Call print_exp(ieee)
	
	lw  $t0, ieee #fresh input

	# clear all but bits 30-23
	sll $t0, $t0, 1  # removes bit 31
	srl $t0, $t0, 24  # shift right by 24 bits, isolating the bit	s 23-30	

	# subtract bias (hex)
	subi $t1, $t0, 127
	
	# print_str(expoBias)
	li $v0, 4
	la $a0, expoBias 
	syscall 
	
	# print exponent with bias (hex)
	#li $v0, 1 #DECIMAL
	li $v0, 34 #HEX
	move $a0, $t0
	syscall 
	
	# print_str(expoNoBias)
	li $v0, 4
	la $a0, expoNoBias 
	syscall 
	
	# print exponent with no bias (hex)
	#li $v0, 1 #DECIMAL
	li $v0, 34 #HEX
	move $a0, $t1 
	syscall 
	
end_print_exp:
jr $ra



print_significand:
	# Task 5: Call print_significand(ieee)
	################################################################
	# Procedure void print_significand(ieee)
	# Functional Description: Extracts the significand bits from the input param
	# and prints it to the screen with a corresponding message
	# Argument parameters:
	# $a0: ieee single precession value
	# Return Value: None
	################################################################
	# Register Usage:
	#	ieee has our stored number
	#	$t0 for manipulation without ruining our input
	# clear all but bits 22-0

	lw  $t0, ieee #fresh input

	# print_str significand
	li $v0, 4
	la $a0, manti
	syscall 
				
	sll  $t0, $t0, 9  # removes bit 30-23
	srl $t0, $t0, 9  # moving to the front of the hex number

	#li $v0, 1 #DECIMAL
	li $v0, 34 #HEX
	move $a0, $t0
	syscall 
	

end_print_significand:
jr $ra


print_ieee:
	# Task 6: Print IEEE number in hex

	lw  $t0, ieee #fresh input

	# print_str ieee
	li $v0, 4
	la $a0, sieee
	syscall 

	#li $v0, 1 #DECIMAL
	li $v0, 34 #HEX
	move $a0, $t0
	syscall 

end_print_ieee:
	jr $ra

