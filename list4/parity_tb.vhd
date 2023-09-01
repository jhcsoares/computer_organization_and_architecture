library ieee;
use ieee.std_logic_1164.all;

entity parity_tb is
end entity;

architecture testbench of parity_tb is
    component parity 
        port(
            b2, b1, b0: in std_logic;
            o: out std_logic
        );
    end component;

    signal b2,b1,b0: std_logic;
    signal o: std_logic;

begin
    uut: parity port map(
        b2,
        b1,
        b0,
        o
    );

    process
    begin
        b2<='0';
        b1<='0';
        b0<='0';
        wait for 50 ns;

        b2<='0';
        b1<='0';
        b0<='1';
        wait for 50 ns;

        b2<='0';
        b1<='1';
        b0<='0';
        wait for 50 ns;

        b2<='0';
        b1<='1';
        b0<='1';
        wait for 50 ns;

        b2<='1';
        b1<='0';
        b0<='0';
        wait for 50 ns;

        b2<='1';
        b1<='0';
        b0<='1';
        wait for 50 ns;

        b2<='1';
        b1<='1';
        b0<='0';
        wait for 50 ns;

        b2<='1';
        b1<='1';
        b0<='1';
        wait for 50 ns;
        wait;
    end process;
end architecture;
