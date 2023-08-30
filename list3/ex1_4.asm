		addi	a0,zero,32
		addi	s0,zero,126
		addi	a7,zero,11
loop:		ecall
		addi	a0,a0,1
		ble	a0,s0,loop
		