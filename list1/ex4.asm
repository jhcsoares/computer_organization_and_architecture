#Calcule a soma dos 40 primeiros números ímpares e a coloque no registrador s1.

		addi s0,zero,0	#i=0
		addi s5,zero,40	#i=40
		addi s2,zero,1	#i++
		addi s3,zero,1 #even registrer increment
		addi s4,zero,2 #2
		addi s1,zero,0	#accumulator
increment:	add s0,s0,s2	#increment
		add s1,s1,s3	
		add s3,s3,s4
		bne s0,s5,increment
	