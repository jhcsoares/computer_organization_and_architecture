library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is
    port(
        op: in unsigned(1 downto 0);
        opcode: out unsigned(1 downto 0)
    );
end entity;

architecture behavioral of mux4x1 is
begin
    opcode  <=  "00"    when    op="00" else
                "01"    when    op="01" else
                "10"    when    op="10" else
                "11"    when    op="11" else
                "00";        
end architecture;
