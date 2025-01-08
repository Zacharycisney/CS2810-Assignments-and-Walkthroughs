#Name: Zach Cisney
#Date: 2-20-2023
#Assingment: MIPS Program 2 (CS2810)
#Description: Select loop amount and phrase


#data segment
.data

Open:.asciiz "Zach Cisney wrote this program for CS2810. This is MIPS Program 2.\n" #opening statement
promptNum: .asciiz "Give a number that is greater than or equal to 10 which will dictate the loop amount.\n" #prompt loop number
promptGood: .asciiz " was a good choice. (more than 10)"
promptBad: .asciiz " was a bad choice. (less than 10)"
promptString: .asciiz "\n\nEnter a phrase: \n"
formatting: .asciiz ". "
variable: .space 64 #63 characters and a null terminator
Close: .asciiz "\n\nGet lost punk this program is over."

#text segment
.text

# Pseudocode:
#
#	print(Open)

#	print(promptNum)
#	loopNum = input
#	loopNum <= 10{
#		break
#	}else
#	i = 0
#	while(i<loopNum){
#	
#	}
#	print(Close)


#Registers:
#	$s0 = loopNum
#	$t0 = i
#	
	
	#SET VARIABLE:
	li $t0, 0 #i
	li $a1, 256 # set the size of the input buffer
	
	#OPENING STATEMENT:
	li $v0, 4
	la $a0, Open
	syscall
	
	
	#LOOP NUMBER:
	#prompt for loop num
	li $v0, 4
	la $a0, promptNum
	syscall
	
	#read the input
	li $v0, 5
	syscall
	move $s0, $v0 #save the input
	
	#EVALUATE NUMBER INPUT:
	slti $t0, $s0, 10
	beq $t0, 1, not10 #input >= 10
	
	#GOOD NUMBER
	li $v0, 1
	move $a0, $s0
	syscall#User input
	
	li $v0, 4
	la $a0, promptGood #Input is greater than (or equal to) 10
	syscall
	j is10
	
not10:
	#BAD NUMBER
	li $v0, 1
	move $a0, $s0
	syscall #User input
	
	li $v0, 4
	la $a0, promptBad #Input is less than 10
	syscall 
	j exit

is10:
	#STRING PROMPT:
	li $v0, 4
	la $a0, promptString
	syscall
	
	li $v0, 8 
	la $a0, variable #reads in a string
	syscall
		
loop:	
	beq $t0, $s0, exit
	
	addi, $t0, $t0, 1 #increment 	
	
	#TESTING LOOP/BETTER FORMATING: (Ignore)
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, formatting #Input is less than 10
	syscall 
	
	li $v0, 4
	la $a0, variable #Input is less than 10
	syscall 
	
	
	j loop #jump


exit:
	#graceful close (goodbye message)
	li $v0, 4
	la $a0, Close
	syscall
	
	li $v0, 10
	syscall
