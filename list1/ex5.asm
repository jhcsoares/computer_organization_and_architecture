#Calcule   ∑i² para   i   de   1   a   20.   Resultado   no   registrador   s3.   Rode   e   confira.   Não   use
#instruções de multiplicação

		addi s0,zero,1	#i=1
		addi s1,zero,20	#i=20
		addi s2,zero,1	#i++
		addi s3,zero,1	#accumulator
increment_i:	add s0,s0,s2	#increment i
		add s4,zero,s0 #s4=current i
		addi s5,zero,1	#j
increment_j:	add s4,s4,s0	#s4=s4+i
		add s5,s5,s2	#j++
		bne s5,s0,increment_j
		add s3,s3,s4	#accumulate	
		bne s0,s1,increment_i
