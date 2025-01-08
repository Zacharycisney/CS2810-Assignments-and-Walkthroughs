#Zach C
#2-28-2023
#description: expanded template format


#names of the proceders (functinos) used
.globl main


#variables
.data
close: .asciiz "Thanks and have a great snow squall\n"


.text

#Pseudocode:
#	c = (a < b) || (a + b) == 10 
#
#
#
#Registers
# a = $t0, b = $t1, c = t2
#
#	set a, b
#	a+b

main:
	#SETTING
	li $t0, 10 
	li $t1,  12
	
	add $t3, $t0, $t1 #a+b
	li $t4, 10
	seq $t3, $t3, $t4 #if (t3 == t4) then t3
	
	#print the value of $t3
	li $v0, 1
	move $a0, $t3
	syscall


	slt $t2, $t0, $t1 # t2 =  a < b 
	or $t2, $t3, $t2 # c = c | temp

	li $v0, 1
	move $a0, $t2
	syscall

end_main:
	#print graceful close and clean exit
	li $v0, 4
	la $a0, close
	syscall
	
	li $v0, 10 #clean exit
	syscall
