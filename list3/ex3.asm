start: 		beq zero,zero,final
		nop
		nop
		bge zero,zero,start
final:  	bne s1,s2,final