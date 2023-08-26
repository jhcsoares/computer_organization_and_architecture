	addi s3,zero,0x123456789 # as 3 são pseudoinstruções
	sw   s3,0x10010034       # <= observe o efeito na memória!
	lw   t2,0x10010001       # aqui vai falhar quando executar