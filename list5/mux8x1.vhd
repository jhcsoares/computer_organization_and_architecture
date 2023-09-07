library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is
    port(
        i2, i4, i6: in std_logic;
        s: in std_logic_vector(2 downto 0);
        o: out std_logic
    );
end entity;

architecture behavioral of mux8x1 is
begin

    o   <=  '0'    when    s(2)='0' and s(1)='0' and s(0)='0'  else
            '0'    when    s(2)='0' and s(1)='0' and s(0)='1'  else
            i2     when    s(2)='0' and s(1)='1' and s(0)='0'  else
            '1'    when    s(2)='0' and s(1)='1' and s(0)='1'  else
            i4     when    s(2)='1' and s(1)='0' and s(0)='0'  else
            '0'    when    s(2)='1' and s(1)='0' and s(0)='1'  else
            i6     when    s(2)='1' and s(1)='1' and s(0)='0'  else
            '1'    when    s(2)='1' and s(1)='1' and s(0)='1'  else
            '0';
            
end architecture;
