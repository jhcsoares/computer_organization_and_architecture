library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_tb is
end entity;

architecture tb of mux4x1_tb is
    component mux4x1 
        port(
            op: in unsigned(1 downto 0);
            opcode: out unsigned(1 downto 0)
        );
    end component;

    signal op, opcode: unsigned(1 downto 0);

begin
    uut: mux4x1 port map(
        op,
        opcode
    );

    process
    begin
        op<="00";
        wait for 50 ns;
        
        op<="01";
        wait for 50 ns;

        op<="10";
        wait for 50 ns;

        op<="11";
        wait for 50 ns;

        wait;
    end process;
end architecture;
