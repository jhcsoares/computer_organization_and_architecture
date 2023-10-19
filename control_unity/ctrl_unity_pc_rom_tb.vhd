library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl_unity_pc_rom_tb is
end entity;

architecture tb of ctrl_unity_pc_rom_tb is
    component ctrl_unity_pc_rom 
        port(
            clk: in std_logic
        );
    end component;

    constant period_time: time :=50 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk: std_logic;

begin
    uut: ctrl_unity_pc_rom port map(
        clk
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
        wait;
        
    end process;
end architecture;
