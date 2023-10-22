library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados_tb is
end entity;

architecture tb of maq_estados_tb is
    component maq_estados 
        port( clk,rst: in std_logic;
              estado: out unsigned(1 downto 0)
        );
     end component;

    constant period_time: time :=50 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk: std_logic;

    signal rst: std_logic;
    signal estado: unsigned(1 downto 0);

begin
    uut: maq_estados port map(
        clk,
        rst,
        estado
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
        rst<='1';
        wait for 200 ns;
        rst<='0';
        wait;
    end process;
end architecture;
