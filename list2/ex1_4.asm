#Idem ao 2, mas invertendo a ordem dos dados no destino (a 1ª word se torna a última etc.).

		addi 	s0,zero,0
		addi 	s1,zero,39
		li	s3,0x10010100
		
loop:		sw 	s0,0(s3)
		addi 	s3,s3,4
		addi 	s0,s0,1
		bne 	s0,s1,loop
		
		li	s4,0x10011100
		addi	s4,s4,160
		li	s3,0x10010100
		
		addi 	s0,zero,0
		addi 	s1,zero,39

loop_transf:	lw	s5,0(s3)
		sw	s5,0(s4)
		addi	s4,s4,-4
		addi	s3,s3,4
		addi	s0,s0,1
		bne	s0,s1,loop_transf
		
		