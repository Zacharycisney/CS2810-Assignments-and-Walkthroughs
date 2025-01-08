#Creator: Zach Cisney
#Date: 2-9-2023

.data


.text

	li $s0, 0xFC000000 #set hex value
	#1111 1100 0000 0000 0000 0000 0000 0000
	
	#we want the six most siginificant bits
	#isolate bits 31-26
	srl $s0, $s0, 26
	#00 0000 0000 0000 0000 0000 0011 1111 = 3F
	

	li $t0 0xABCDEF12 
	#1010 1011 1100 1101 1110 1111 0001 0010
	
	#isolate the first bit, the 31st bit
	srl $t1, $t0, 31
	
	
	#isolate bits 30-23
	#need a 7F80 0000
	andi $t1, $t0, 0x7F800000
	
	
	#isolate bits 30-23
	srl $t2, $t1, 23
	#00010111 = 0000 0057
	
	
	#We want the least significant 23 bits
	#0000 0000 0111 1111 1111 1111 1111 1111
	andi $t3, $t0, 0x007FFFFF