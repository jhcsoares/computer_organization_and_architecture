library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_tb is
end entity;

architecture tb of mux8x1_tb is

    component mux8x1 
        port(
            i2, i4, i6: in std_logic;
            s: in std_logic_vector(2 downto 0);
            o: out std_logic
        );
    end component;

    signal i2, i4,i6: std_logic;
    signal s: std_logic_vector(2 downto 0);
    signal o: std_logic;

begin
    uut: mux8x1 port map(
        i2=>i2,
        i4=>i4,
        i6=>i6,
        s=>s,
        o=>o
    );

    process
    begin
        s(0)<='0';
        s(1)<='0';
        s(2)<='0';
        wait for 50 ns;
        s(0)<='1';
        s(1)<='0';
        s(2)<='0';
        wait for 50 ns;
        s(0)<='0';
        s(1)<='1';
        s(2)<='0';
        i2<='0';
        wait for 50 ns;
        s(0)<='0';
        s(1)<='1';
        s(2)<='0';
        i2<='1';
        wait for 50 ns;
        s(0)<='1';
        s(1)<='1';
        s(2)<='0';
        wait for 50 ns;
        s(0)<='0';
        s(1)<='0';
        s(2)<='1';
        i4<='0';
        wait for 50 ns;
        s(0)<='0';
        s(1)<='0';
        s(2)<='1';
        i4<='1';
        wait for 50 ns;
        s(0)<='1';
        s(1)<='0';
        s(2)<='1';
        wait for 50 ns;
        s(0)<='0';
        s(1)<='1';
        s(2)<='1';
        i6<='0';
        wait for 50 ns;
        s(0)<='0';
        s(1)<='1';
        s(2)<='1';
        i6<='1';
        wait for 50 ns;
        s(0)<='1';
        s(1)<='1';
        s(2)<='1';
        wait for 50 ns;
        wait;
    end process;
end architecture;
