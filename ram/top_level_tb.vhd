library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end entity;

architecture tb of top_level_tb is
    component top_level 
        port(
            rst: in std_logic;
            clk: in std_logic;
            a0, b0, c0, d0, e0, f0, g0, h0: out std_logic;
            a1, b1, c1, d1, e1, f1, g1, h1: out std_logic
        );
    end component;

    constant period_time: time :=100 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk: std_logic;

    signal rst: std_logic;
    signal a0, b0, c0, d0, e0, f0, g0, h0: std_logic;
    signal a1, b1, c1, d1, e1, f1, g1, h1: std_logic;

begin
    uut: top_level port map(
        rst,
        clk, 
        a0, b0, c0, d0, e0, f0, g0, h0,
        a1, b1, c1, d1, e1, f1, g1, h1
    );

    reset: process
    begin
        rst<='1';
        wait for 50 ns;
        rst<='0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 1000 us;
        finished<='1';
        wait;
    end process;

    global_clk: process
    begin
        while finished/='1' loop
            clk<='0';
            wait for period_time/2;
            clk<='1';
            wait for period_time/2;
        end loop;
        wait;
    end process;

    main_process: process
    begin
        wait;
        
    end process;
end architecture;
