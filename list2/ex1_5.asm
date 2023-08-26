#Calcule a soma de todos os dados entre 0x1000 0000 e 0x1000 FFFC (inclusive).

		li	s0,0x10000000
		li	s1,0x1000FFFC
		addi	s2,zero,1
		
data_filling:	sw	s2,0(s0)
		addi	s0,s0,4
		addi	s2,s2,1
		ble	s0,s1,data_filling
		
		li	s0,0x10000000
		li	s1,0x1000FFFC
		addi	s2,zero,0
		
sum:		lw	s3,0(s0)
		add	s2,s2,s3
		addi	s0,s0,4
		ble	s0,s1,sum