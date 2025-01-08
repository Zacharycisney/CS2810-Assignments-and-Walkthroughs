#Name: Zach Cisney
#Assingment: MIPS Program 2
#Description: Given the radius, approximate the area of a circle
#data segment

#data segment
.data

#data segment
.data
# prompt
promptR: .asciiz "Give a radius or 0 to quite: " # prompt for radius
result: .asciiz "Approximate area: " # results string
gClose: .asciiz "\n Get lost punk"

#text segment
.text

# Pseudocode
#	while (radius!=0) {
#	print the prompt
#	read radius
#	calculate area
#	print results
#	print area
#	}
#	print graceful close

#Registers:
#	$t0 = radius
#	$t1 = area

	li $t0, 0 #set i = 0
	li $t1, 3 #set limit

	

loop:
	#break out of the loop if(i = limit) branch to endloop
	beq $t0, $t1, endloop

	#print the prompt
	li $v0, 4
	la $a0, promptR
	syscall
	
	#read the input
	li $v0, 5
	syscall
	move $t0, $v0#save the input
	
	#if(radius =  0) break out to endloop
	beqz $t0, endloop #breaks out immediatley 
	
	j loop
	
endloop:




exit:
	#graceful close (goodbye message)j
	li $v0, 4
	la $a0, gClose
	syscall
	
	li $v0, 10
	syscall