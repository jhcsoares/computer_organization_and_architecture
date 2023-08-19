				addi s0,zero,32	#const 32
				addi s1,zero,-1
				addi s2,zero,31
				
				bge s1,zero,s1_bge_zero
				
				bgt s2,s0,s3_4

				beq s2,s0,s3_5

				addi s3,zero,6
				beq s3,s3,final

	s1_bge_zero:		bgt s2,s0,s3_1

				beq s2,s0,s3_2
				
				addi s3,zero,3
				beq s3,s3,final

	s3_1:			addi s3,zero,1
				beq s3,s3,final

	s3_2:			addi s3,zero,2
				beq s3,s3,final

	s3_4:			addi s3,zero,4
				beq s3,s3,final

	s3_5:			addi s3,zero,5
				beq s3,s3,final

	final:			add s3,s3,zero
