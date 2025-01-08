#Zach Cisney
#Date: 2-16-2023
#Description: echo users input

#data segment
.data
# prompt
intro: .asciiz "Say something to the parrot and it'll say it back!\n\n"# introduction
prompt: .asciiz "you say: " # parrot string
parrot: .asciiz "parrot says: "
text: .space 256 # text (save space for 255 characters plus the null character
gClose: .asciiz "\n Get lost punk"

#text segment
.text

# Pseudocode
# 	print intro
#	while(i != limit) {
#		print prompt
#		read string
#		print parrot string
#		print string
#
#		increment i
#	}

#Registers:
#	$t0 = i
#	$t1 = limit

	li $t0, 0 #set i = 0
	li $t1, 3 #set limit
	li $a1, 256 # set the size of the input beffer
	
	#print the into
	li $v0, 4
	la $a0, intro
	syscall
	

loop:
	#break out of the loop if(i = limit) branch to endloop
	beq $t0, $t1, endloop

	#print the prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	#read the input
	li $v0, 8 
	la $a0, text #reads in a string
	syscall
	
	#print the parrot
	li $v0, 4
	la $a0, parrot
	syscall
	
	#print the input
	li $v0, 4
	la $a0, text
	syscall
	
	#increment i
	addi, $t0, $t0, 1

	j loop
	
endloop:




exit:
	#graceful close (goodbye message)j
	li $v0, 4
	la $a0, gClose
	syscall
	
	li $v0, 10
	syscall