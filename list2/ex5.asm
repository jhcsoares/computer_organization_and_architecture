#Reescreva   o   programa   inicial   (das   comparações   de   s1   e   s2)   utilizando  pelo menos uma
#instrução blez e pelo menos uma instrução beqz. Observe na aba Execute do RARS quais são
#as instruções nativas equivalentes que o montador gerou.

		addi s0,zero,32	#number 32
		addi s1,zero,-1
		addi s2,zero,31
		
		bgtz s1,s1_bgtz
		
		bgt s2,s0,s3_4
		beq s2,s0,s3_5
		addi s3,zero,6
		beq s3,s3,final
		
s3_4:		addi s3,zero,4
		beq s3,s3,final

s3_5:		addi s3,zero,5
		beq s3,s3,final
		
s1_bgtz:	bgt s2,s0,s3_1
		beq s2,s0,s3_2
		addi s3,zero,3
		beq s3,s3,final

s3_1:		addi s3,zero,1
		beq s3,s3,final

s3_2:		addi s3,zero,2
		beq s3,s3,final

final:		add s3,zero,s3
		