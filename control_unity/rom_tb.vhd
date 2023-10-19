library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture tb of rom_tb is
    component rom 
        port(
            rd_en: in std_logic;
            clk: in std_logic;
            address: in unsigned(6 downto 0);
            data: out unsigned(15 downto 0)
        );
    end component;
    

    constant period_time: time :=100 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk: std_logic;

    signal rd_en: std_logic;
    signal address: unsigned (6 downto 0);
    signal data: unsigned (15 downto 0);

begin
    uut: rom port map(
        rd_en,
        clk,
        address,
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
        rd_en<='0';
        address<="0000000";
        wait for 100 ns;

        address<="0000001";
        wait for 100 ns;

        address<="0000010";
        wait for 100 ns;

        rd_en<='0';
        address<="0000011";
        wait for 100 ns;

        address<="1000000";
        wait for 100 ns;
        
        wait;
        
    end process;
end architecture;
