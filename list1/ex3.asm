#Faça um loop de 30 vezes repetindo a soma de 23 em um registrador. Ao final, o valor 30*23
#deverá ser carregado em s5

		addi s0,zero,0	#i=0
		addi s1,zero,30	#i=31
		addi s2,zero,1	#i++
		addi s3,zero,23 #23
		addi s5,zero,0	#accumulator
increment:	add s0,s0,s2	#increment
		add s5,s5,s3	
		bne s0,s1,increment
	
