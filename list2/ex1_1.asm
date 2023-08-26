#Armazene   uma   sequência   crescente   de   1000   valores   na   memória   a   partir   do   endereço
#0x1001 1234

		addi s0,zero,0
		addi s1,zero,999
		addi s2,zero,1
		li s3,0x10011234
		
loop:		sw s0,0(s3)
		addi s3,s3,4
		add s0,s0,s2
		bne s0,s1,loop
