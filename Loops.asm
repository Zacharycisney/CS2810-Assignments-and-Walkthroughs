#Zach Cisney
#Inclass 2-16-2023
#Description: Add up elements of an array

#lables
.data
fibs: .word 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 #an array of elements
total: .asciiz


#text segment for code
.text

#Pseudocode:
#	foreach(fib in fibs){
#		fib+= fibs[i]
#	}
#	
#Registers:
# 	fib = $t0
#	i = $t1
#	temp = $t2


	#initialize i to zero
	li $t1, 0
	li $t0, 0
	li $t2, 0
loop: 
	# loop condition, when to exit, when fib = 144
	beq $t0, 144, endLoop
	lw $t0, fibs($t1)	#fib = fibs[i]
	add $t2, $t2, $t0	#temp += fib
	
	#increment i, i++ (a word is 4 bytes)
	addi $t1, $t1, 4
	
	j loop
endLoop:
	sw $t2, total #zave the answer to total (format: sw want, location-saved
	
	#print the answer
	
	#print the integer
	li $v0, 1
	lw $a0, total
	syscall

#Exit
exit:
	li $v0, 10
	syscall
