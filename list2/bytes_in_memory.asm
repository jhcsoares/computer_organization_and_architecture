		
		li  	t5,0x12345678
		li  	s2,0x10010034
		sw	t5,0(s2)
		
		addi	s0,zero,0
		addi	s1,zero,3
		
		li	s3,0x10010038
		
loop:		lb	s5,0(s2)
		sb	s5,0(s3)
		addi	s3,s3,1
		addi	s2,s2,0x1
		addi	s0,s0,1
		ble	s0,s1,loop
		