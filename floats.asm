#Zach Cisney
#date: 2-23-2023

.data
prompt: .asciiz "Enter a floating point number: "
bye: .asciiz "Thanks for visiting Floats R Us"
newLine: .asciiz "\n"

#easiest way to lload a FP (floating point) immediate is to load it from memory
const1: .float 15.0
const2: .float 6.0
const3: .float 19.25

.text
#all instructions for floats, single precision
# Pseusodosode:
	#divide two floats and print the answer
	#subtract a float from quotient and print answer
	# prompt for float
	#multiply the input and display the answer
#
#Registers:
	#$f16
	#$f18
	
#divide two floats and print the answer
	l.s $f16, const1 #load f16 = const1
	l.s $f18, const2 #load f18 = const2
	div.s $f16, $f16, $f18 # f16 = const1/const2

#print the answer
	li $v0, 2 #print float
	mov.s $f12, $f16 #set up the argument
	syscall	
	
	li $v0, 4
	la $a0, newLine
	syscall
	syscall

#subtract a float from quotient and print the answer
	#quotient in f16
	l.s $f18, const3
	sub.s $f16, $f16, $f18 #f16 = f16 - f18 (2.5 - 19.25)
	
	#print float on a new line
	li $v0, 2 #print float
	mov.s $f12, $f16 #set up the argument
	syscall	
	
	li $v0, 4
	la $a0, newLine
	syscall
	syscall

#prompt for float
	li $v0, 4
	la $a0, prompt
	syscall
	
#capture a float
	li $v0, 6 #read a float
	syscall
	mov.s $f18, $f0	 #move the answer into register f18

#multiply the input and display the answer
	mul.s $f16, $f16, $f18 #f16 = f16*f18
	
#display the answer
	li $v0, 2 #print float
	mov.s $f12, $f16 #float to print
	syscall
	
#new line
	li $v0, 4
	la $a0, newLine
	syscall
	syscall

exit: 
	li $v0, 4
	la $a0, bye
	syscall
	
	li $v0, 10
	syscall