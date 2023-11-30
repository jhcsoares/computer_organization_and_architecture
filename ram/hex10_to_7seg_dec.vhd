library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex10_to_7seg_dec is
	port(
		dot : in std_logic;
		d: in unsigned(3 downto 0);
		a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s : out std_logic);
end hex10_to_7seg_dec;

architecture arch_hex10_to_7seg_dec of hex10_to_7seg_dec is
	begin
		a_s <= 
			not((not(d(3)) and d(2) and d(0)) or 
			(d(3) and not(d(2)) and not(d(1))) or 
			(not(d(2)) and not(d(0))) or 
			(not(d(3)) and d(1)) or 
			(d(2) and d(1)) or 
			(d(3) and not(d(0))));
			
		b_s <= not((not(d(3)) and not(d(1)) and not(d(0))) or 
			(not(d(3)) and d(1) and d(0)) or 
			(d(3) and not(d(1)) and d(0)) or 
			(not(d(2)) and not(d(0))) or 
			(not(d(3)) and not(d(2))));
			
		c_s <= 
			not((not(d(3)) and not(d(1))) or 
			(not(d(3)) and d(2)) or 
			(not(d(1)) and d(0)) or 
			(d(3) and not(d(2))) or 
			(not(d(3)) and d(0)));
			
		d_s <= 
			not((d(2) and not(d(1)) and d(0)) or 
			(not(d(2)) and d(1) and d(0)) or 
			(not(d(3)) and not(d(2)) and not(d(0))) or 
			(d(2) and d(1) and not(d(0))) or 
			(d(3) and not(d(1)) and not(d(0))));
			
		e_s <= not((not(d(2)) and not(d(0))) or 
			(d(1) and not(d(0))) or 
			(d(3) and d(1)) or 
			(d(3) and d(2)));
			
		f_s <= not((not(d(3)) and d(2) and not(d(1))) or 
			(not(d(1)) and not(d(0))) or 
			(d(3) and not(d(2))) or 
			(d(3) and d(1)) or 
			(d(2) and not(d(0))));
			
		g_s <= not((not(d(2)) and d(1)) or
			(d(1) and not(d(0))) or 
			(d(3) and not(d(2))) or 
			(d(3) and d(0)) or 
			(not(d(3)) and d(2) and not(d(1))));
			
		h_s <= not(dot);
end arch_hex10_to_7seg_dec;
