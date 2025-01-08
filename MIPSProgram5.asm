# Author: Zach Cisney
# Date: 4/24/2023
# Description: Parse MIPS instructions based on opcode and print message
	

.globl main, decode_instruction, process_instruction, print_opcode_value		# Do not remove this line
	


.data
	process: .asciiz "\n\n Now processing instruction "
	opcode_num: .asciiz "\tThe opcode value is: "
	newLine: .asciiz "\n"
	

	# number of test cases
	CASES: .word 5
	# array of pointers (addresses) to the instructions
	instructions:	.word 0x01095020, 		# add $t2, $t0, $t1
			.word 0x1220002C,  		# beqz $s1, label
			.word 0x3C011001,		# lw $a0, label($s0)
			.word 0x24020004,		# li $v0, 4
			.word 0x08100002		# j label
		
	inst_0:		.asciiz "\tR-Type Instruction\n"
	inst_other:	.asciiz "\tUnsupported Instruction\n"
	inst_2_3:	.asciiz "\tUnconditional Jump\n"
	inst_4_5:	.asciiz "\tConditional Jump\n"
	

	#NOTE: This array style was taken from a different program becuase the pre-made array didn't work
	switch: .word case0, case1, case2, case3, case4, case5
	
	
	
	
.text
main:
	
	la $t0, instructions 			# $t0: increments $a1 at the end of each loop
	li $t7, 0 				# $t7: Governs loop starting point 
	
	
loop_array:
	
	# Task 1A: Loop over the array of instructions 
	beq $t7, 5, end_main			#for loop: i = 0; i < 24; i +4 (loops five times)
	addi $t7, $t7, 1			#incrementing loop
	
	# Set registers and call: print_hex_info
		la $a0, process 		#message to be printed
		lw $a1, ($t0) 			#loading next word from instructions for next procedure 
		
		addi $t0, $t0, 4 		#determing next word from instructions

		jal print_hex_info		#prints instruction
		
		
	#Prints type
		jal decode_instruction 	#prints instruction type
		
	# Print decode value
		jal print_opcode_value		#prints decode value
		

		
		
	
	


	j loop_array		# end of loop
	
		
end_main:
	li $v0, 10		# 10 is the exit program syscall
	syscall			# execute call
##############################################################################################################################





###############################################################
# Fetch  instruction to correct procedure based on opcode for
# instruction parsing.
# Argument parameters:
# $a0 - input, 32-bit instruction to process (required) *the input is already loaded into $a1 so I used that instead
# Return Value:
# $v0 - output, insturction opcode (bits 31-26) value (required)
# Uses:
# $s0: for input parameter (required) 
# $s1: for opcode value (required) 
###############################################################


#TASK 2:
decode_instruction:
 
 	#save the register to the stack
	subu $sp, $sp, 32 			#frame size is 32, (begins allocation)
	sw $ra, 28($sp)	 			#preserve the return address (required) 
	sw $fp, 24($sp) 			# preserve the frame counter (required)

	
 	#register $s0 can be manipulated
		move $s0, $a1 
 
 	# Isolate opcode (bits 31-26) 1111 1100 0000 0000 0000 0000 0000 0000
 		srl $s0, $s0, 26  # shift right by 26 bits, clearing

 	
 
	#code type prints in here (function in a function)
		jal process_instruction
		
		
 

 
 end_decode_instruction:
  # Restore register from stack
	lw $ra, 28($sp) #restoring address (requiered)
	lw $fp, 24($sp) #restore frame counter (requiered)
  
 	jr $ra
###############################################################


#TASK 3:
process_instruction:
	############   Registers  ############ 
	#
	# $t2 helps to find the corresct case
	# $t1 holds the address add finds the case	
	# $s0 holds the decode
	#
	###################################### 

		move $t3, $s0 # $t3 can be manipulated to find the correct case
	
		#branch to deafault
		blt $t3, 0, default #if n<0, branch to default
		bgt $t3, 5, default #if n>5, branch to default

		#calculate the case to jump to 
		mul $t1, $t3, 4 #temp = n +4
		lw $t1, switch($t1) #temp = temp(temp)					###    MAJIC HERE    ###
		jr $t1
		
case0:
	 la $a0, inst_0 #print inst_0
	 syscall
	 j end_process_instruction	

case2:
case3:
	la $a0, inst_2_3 #print inst_2_3
	syscall
	j end_process_instruction

case4:
case5:
	la $a0, inst_4_5 #print inst_4_5
	syscall
	j end_process_instruction
	
		
case1:
default:
	li $v0, 4 #print inst_other
	la $a0, inst_other
	syscall
	
end_process_instruction:
	jr $ra

	


print_opcode_value:
	
	#prints opcode number string
 		li $v0, 4				# print message
		la $a0, opcode_num
		syscall
 
 		li $v0, 34				# print address in hex value
		move $a0, $s0
		syscall


end_print_opcode_value:
	jr $ra



##############################################################################################################################
# Print Message based on opcode type
#
# $a0 - Message to print
# $a1 - Value to print
# Uses $s0: address of string for $a0 (required)
# Uses $s1: value from $a1 (required)
print_hex_info:
	##### Begin Save registers to Stack
	subi  $sp, $sp, 36
	sw   $ra, 32($sp)
	sw   $s0, 28($sp)
	sw   $s1, 24($sp)
	sw   $s2, 20($sp)
	sw   $s3, 16($sp)
	sw   $s4, 12($sp)
	sw   $s5, 8($sp)
	sw   $s6, 4($sp)
	sw   $s7, 0($sp)
	##### End Save registers to Stack
	

	# Now your function begins here
	move $s0, $a0
	move $s1, $a1
		
	li $v0, 4				# print message
	move $a0, $s0
	syscall
		
	li $v0, 34				# print address in hex value
	move $a0, $s1
	syscall
		
	li $v0, 4				# print message
	la $a0, newLine
	syscall
	

end_print_hex_info:
	##### Begin Restore registers from Stack
	lw   $ra, 32($sp)
	lw   $s0, 28($sp)
	lw   $s1, 24($sp)
	lw   $s2, 20($sp)
	lw   $s3, 16($sp)
	lw   $s4, 12($sp)
	lw   $s5, 8($sp)
	lw   $s6, 4($sp)
	lw   $s7, 0($sp)
	addi $sp, $sp, 36
	##### End Restore registers from Stack
		
    jr $ra
###############################################################
