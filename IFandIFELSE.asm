#Zach
#Date: 2-14-2023
#Description: pratice If, If Else

.data
promptI: .asciiz "Enter a number: "
promptII: .asciiz "Enter another number: "
display: .asciiz "\nThe answer is "

#pseudocode
#print prompt
#read an integer (i)
#pring another prompt
#read integer (j)

#if (i==j)
#	f =  g + h
#else
#	f = g - h
#registers: f, g, h, i, j, k
#$s0 = f,
#$s1 =  g,
#$s2 = h,
#$s3 =  i,
#$s4 =  j,

.text


#set value of g and h
	li $s1, 12 #g
	li $s2, 15 #h

#print prompt
	li $v0, 4
	la $a0, promptI
	syscall

#read in integer (i)
	li $v0, 5
	syscall
	move $s3, $v0

#print prompt1
	li $v0, 4
	la $a0, promptII
	syscall

#read in integer (j)
	li $v0, 5
	syscall
	move $s4, $v0

#branching
#	bne $s3, $s4, exit #i and j
#	add $s0, $s1, $s2 #g and h
	
	bne $s3, $s4, not #i and j if equal then add together if not then subtract
	add $s0, $s1, $s2# g + h
	j exit #j is a jump statement

not:
	sub $s0, $s1, $s2 #g - h

exit:


	#print answer which is in $s0
	li $v0, 4
	la $a0, display
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	#exit program
	li $v0, 10
	syscall