library ieee;
use ieee.std_logic_1164.all;

entity decoder_2_4 is
    port(
        a0, a1: in std_logic;
        b0, b1, b2, b3: out std_logic
    );
end entity;

architecture behavioral of decoder_2_4 is
begin
    b0<=not(a1) and not(a0);
    b1<=not(a1) and a0;
    b2<=a1 and not(a0);
    b3<=a1 and a0;
end architecture;
