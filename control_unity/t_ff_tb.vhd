library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t_ff_tb is
end entity;

architecture tb of t_ff_tb is
    component t_ff 
        port(
            t: in std_logic;
            clk: in std_logic;
            reset: in std_logic;
            state: out std_logic:='0'
        );
    end component;

    constant period_time: time :=100 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk: std_logic;

    signal t: std_logic;
    signal reset: std_logic;
    signal state: std_logic;

begin
    uut: t_ff port map(
        t,
        clk,
        reset,
        state
    );

    sim_time_proc: process
    begin
        wait for 1 us;
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
        reset<='1';
        wait for 200 ns;

        reset<='0';
        t<='0';
        wait for 600 ns;

        t<='1';
        wait;
        
    end process;
end architecture;
