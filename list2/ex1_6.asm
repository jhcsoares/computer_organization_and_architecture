#Quais são os maiores valores imediatos que podem ser usados em uma instrução addi? 
#(Por ex., addi s2,zero,0x123456 não funciona; o RARS diz “operand is out of range” porque a
#constante tem bits em excesso).

#https://github.com/TheThirdOne/rars/issues/5
#This is really an issue with user interface rather than the assembler.
#There are two possible ways to interpret 0xFFF as a 32 bit value. The sign extended 0xFFFF FFFF and 
#the unsigned value 0x00000FFF. In RARS, every value represented with hex is interpreted as an unsigned value.
#And 0x00000FFF is not actually representable as an immediate because the immediate field is sign extended. 
#So you would need to use 0xFFFFFFFF or -1 instead of 0xFFF.
#It would be possible to try the sign extended version if there was a error later down the line, but that is non-trivial to implement.
#I don't know an easy way to improve RARS to handle this more graciously (including even giving a more detailed error message), 
#but I do recognize that it is a problem.

		addi s0,zero,0xFFFFFFFF #0xFFF
		