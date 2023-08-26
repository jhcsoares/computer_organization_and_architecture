#Ordene 20 números inteiros. 
		
		#Generating numbers
		addi 	s0,zero,0
		addi 	s1,zero,18
		li	s3,0x10010004	
		
even_loop:	sw	s0,0(s3)
		addi	s3,s3,4
		addi	s0,s0,2
		ble	s0,s1,even_loop

		addi 	s0,zero,1
		addi 	s1,zero,19

odd_loop:	sw	s0,0(s3)
		addi	s3,s3,4
		addi	s0,s0,2
		ble	s0,s1,odd_loop
		
###################################################
		
		li	s3,0x10010004
		addi	s4,s3,76	#k=n-1
		addi	s5,s3,0		#i=0
		
k_loop:		addi	s5,s3,0		#i=0
		bgt	s4,s3,i_loop
		
		beqz	zero,final
		
		

i_loop:		lw	s6,0(s5)
		lw	s8,4(s5)
		bgt	s6,s8,swap
		
i_iteration:	addi	s5,s5,4
		blt	s5,s4,i_loop
		addi	s4,s4,-4
		
		beqz	zero,k_loop
		

swap:		lw	t0,0(s5)
		lw	t1,4(s5)
		sw	t0,4(s5)
		sw	t1,0(s5)
		
		beqz	zero,i_iteration
		
final:		nop
		
