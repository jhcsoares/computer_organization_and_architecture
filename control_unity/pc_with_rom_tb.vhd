library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_with_rom_tb is
end entity;

architecture tb of pc_with_rom_tb is
    component pc_with_rom 
        port(
            wr_en: in std_logic;
            clk: in std_logic;
            data: out unsigned(15 downto 0)
        );
    end component;

    constant period_time: time :=50 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk: std_logic;

    signal wr_en: std_logic;
    signal data: unsigned(15 downto 0);

begin
    uut: pc_with_rom port map(
        wr_en,
        clk,
        data
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
        wr_en<='1';
        wait;
        
    end process;
end architecture;
