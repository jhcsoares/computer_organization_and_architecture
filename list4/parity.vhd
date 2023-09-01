library ieee;
use ieee.std_logic_1164.all;

entity parity is
    port(
        b2, b1, b0: in std_logic;
        o: out std_logic
    );
end entity;

architecture behavioral of parity is
begin
    o<=(b2 and not(b1) and not(b0)) or        
    (not(b2) and not(b1) and b0)    or
    (b2 and b1 and b0)              or
    (not(b2) and b1 and not(b0));
end architecture;
