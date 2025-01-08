#Zach Cisney
#Description: This program creates a multiplication table
#3/19/2023

.globl main, userInfo, multTable,
.data
#intro
info: .asciiz "Program 3 (multiplication table) created by Zach C. on 3/19/2023\n\n"
namePrompt: .asciiz "------------------------------------------------------------ \nEnter your name: "
name: .space 25
supPrompt: .asciiz "Sup "

#middle
numPrompt: .asciiz "------------------------------------------------------------ \n\nA multiplication table will be created based on your input (rows by colms). Enter a number: \n"
bars: .asciiz "------------------------------------------------------------ \n"  #formatting
extraSpace: .asciiz "	" #formatting
extraReturn: .asciiz "\n" #formatting
num: .word 0

#closing
byePrompt: .asciiz "\nGet lost punk"


.text
#Intro:
#	Print program info
#	Print name prompt
#	take name
#	print name
#	

#Middle:
#	Print table prompt
#	take number
#	process number
#
#	print table out:
#		Pseudocode for printing multiplication tables:
#			// Print Multiplication tables 1 to num
# 			for(i=1; i<num; i++)
# 	   		for(j=1; j<num; j++)
#          		print(i*j)
#          		print("\t")
# 	   		print("\n")
#
#Closing:
#	say goodbye
#	exit

main:

	jal userInfo

	jal multTable
	
	j exit
	


	
	
###  Functinos	 ###
	
userInfo:
	li $a1, 25 #buffer set
	
	#intro
	li $v0, 4
	la $a0, info
	syscall
	
	
	#greetings/hello
	li $v0, 4
	la $a0, namePrompt #print namePrompt
	syscall
	li $v0, 8 
	la $a0, name #storing name
	syscall
	li $v0 4
	la $a0, supPrompt #printing "sup"
	syscall
	la $a0, name #print name
	syscall

end_userInfo:
	jr $ra
	


	#######################   Table  Start ##########################	
#################################################################################
multTable:
	#table explanation
	li $v0 4
	la $a0, numPrompt #print table explanation
	syscall
	
	#get input
	li $v0, 5 
	syscall
	sw $v0 num #store in memory
		
	
	lw $s7, num
	addi $s7, $s7, 1 #adjustment for loops
	
	li $t1, 1 #row
	j row	
	
	row:
		beq $t1, $s7, exit #outer loop
		li $t0, 1 #column
		j column
 	
	column:	
		beq $t0, $s7, newRow #inner loop
		
		mul  $s1, $t0, $t1 #actual value
		
		li $v0, 1
		move $a0, $s1 
		syscall #print
	
		addi, $t0, $t0, 1 #setting for next int
	
		li $v0, 4
		la $a0, extraSpace 
		syscall #formatting

		j column

	newRow:	
		li $v0, 4
		la $a0, extraReturn
		syscall #formatting
	
		addi, $t1, $t1, 1 #setting for next int
		
		j row

end_multTable:
	jr $ra		
#################################################################################
	#######################   Table  End   ##########################
	


exit:
	#goodbye
	li $v0 4
	la $a0, byePrompt #print "get lost"
	syscall	
	
	li $v0, 10
	syscall
