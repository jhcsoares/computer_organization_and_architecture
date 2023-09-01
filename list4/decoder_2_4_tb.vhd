library ieee;
use ieee.std_logic_1164.all;

entity decoder_2_4_tb is
end entity;

architecture tb of decoder_2_4_tb is
    component decoder_2_4 
        port(
            a0, a1: in std_logic;
            b0, b1, b2, b3: out std_logic
        );
    end component;

    signal a0, a1: std_logic;
    signal b0, b1, b2, b3: std_logic;

begin
    uup: decoder_2_4 port map(
        a0=>a0,
        a1=>a1,
        b0=>b0,
        b1=>b1,
        b2=>b2,
        b3=>b3
    );

    process
    begin
        a0<='0';
        a1<='0';
        wait for 50 ns;

        a0<='0';
        a1<='1';
        wait for 50 ns;

        a0<='1';
        a1<='0';
        wait for 50 ns;

        a0<='1';
        a1<='1';
        wait for 50 ns;
        
        wait;
    end process;
end architecture;
