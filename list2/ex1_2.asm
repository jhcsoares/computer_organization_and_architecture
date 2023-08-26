#Transfira 40 words de 32 bits a partir do endereço 0x1001 0100 para a região de memória
#iniciada em 0x1001 1100. Insira alguns dados para poder visualizar a simulação ocorrendo.

		addi s0,zero,0
		addi s1,zero,39
		addi s2,zero,1
		li s3,0x10010100
		
loop:		sw s0,0(s3)
		addi s3,s3,4
		add s0,s0,s2
		bne s0,s1,loop
		
		addi s0,zero,0
		addi s1,zero,39
		addi s2,zero,1
		li s3,0x10010100
		li s4,0x10011100
		
loop_transf:	lw s5,0(s3)
		sw s5,0(s4)
		addi s3,s3,4
		addi s4,s4,4
		add s0,s0,s2
		bne s0,s1,loop_transf
		
		