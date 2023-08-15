#Faça um programa que calcula o fatorial de 8.

		addi s0,zero,8	#n
		
		addi s1,zero,1	#factor
		addi s2,zero,0	#accumulator
		
		addi s5,zero,1	#number 1
		
		add s0,s0,s5	#correcting s0 limit (s0=s0+1)
		
		#i loop definition
		addi s3,zero,1	#i=1
		add s4,zero,s0	#i<=n
		
i_loop_start:	addi s2,zero,0	#restarting accumulator iteration
		
		#j loop definition
		addi s6,zero,0	#j=0
		add s7,zero,s3	#j<=i
		
j_loop_start:	add s2,s2,s1	#accumulator+=factor
		
		add s6,s6,s5	#j++
		bne s6,s7,j_loop_start
		
		add s1,s2,zero	#factor=accumulator
		
		add s3,s3,s5	#i++
		bne s3,s4,i_loop_start
		
