#Calcule   30*1234  com  o  mínimo   de  instruções  que  você  conseguir.   Confirme   na   janela   de
#registradores o resultado. Não use instruções de multiplicação nem de branch.

		addi s0,zero,1234
		add s1,s0,s0	#2*1234
		add s1,s1,s1	#4*1234
		add s1,s1,s1	#8*1234
		add s1,s1,s1	#16*1234
		add s1,s1,s1	#32*1234
		addi s0,zero,-1234
		add s0,s0,s0
		add s1,s1,s0
		