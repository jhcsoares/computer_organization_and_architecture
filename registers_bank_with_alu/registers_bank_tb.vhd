library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers_bank_tb is
end entity;

architecture tb of registers_bank_tb is
    component registers_bank 
        port(
            read_register_1: in unsigned(2 downto 0);
            read_register_2: in unsigned(2 downto 0);
            reg_write_data: in unsigned(15 downto 0);
            reg_write_address: in unsigned(2 downto 0);
            write_enable: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            read_register_1_data: out unsigned(15 downto 0);
            read_register_2_data: out unsigned(15 downto 0)
        );
    end component;

    constant period_time: time :=100 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk, rst: std_logic;

    signal read_register_1: unsigned(2 downto 0);
    signal read_register_2: unsigned(2 downto 0);
    signal reg_write_data: unsigned(15 downto 0);
    signal reg_write_address: unsigned(2 downto 0);
    signal write_enable: std_logic;
    signal read_register_1_data: unsigned(15 downto 0);
    signal read_register_2_data: unsigned(15 downto 0);

begin
    uut: registers_bank port map(
        read_register_1,
        read_register_2,
        reg_write_data,
        reg_write_address,
        write_enable,
        clk,
        rst,
        read_register_1_data,
        read_register_2_data
    );

    initial_reset:process
    begin
        rst <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        rst <= '0';
        wait for 2300 ns;
        rst <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 2.5 us;
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
         --reseting registers
        wait for 200 ns;                                

        --registering data into register x1
        reg_write_data<="1010101010101010";
        reg_write_address<="001";
        write_enable<='1';

        --reading register x1 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_1<="001";

        --trying to register data into register x1 when write_enable='0'
        wait for 100 ns;
        reg_write_data<="1010101010001111";
        reg_write_address<="001";

        --reading register x1 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_1<="001";

        --registering data into register x1 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="1010101010001111";
        reg_write_address<="001";

        --trying to register data into register x5 when write_enable='0'
        wait for 100 ns;
        write_enable<='0';
        reg_write_data<="1111111111111111";
        reg_write_address<="101";

        --registering data into register x5 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="1111111111111111";
        reg_write_address<="101";

        --reading register x5 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_2<="101";

        --trying to insert data into register x0
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="1111111111111100";
        reg_write_address<="000";
        read_register_1<="000";
        read_register_2<="000";

        --trying to register data into register x2 when write_enable='0'
        wait for 100 ns;
        write_enable<='0';
        reg_write_data<="0000000000000001";
        reg_write_address<="010";

        --registering data into register x2 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="0000000000000001";
        reg_write_address<="010";

        --reading register x2 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_2<="010";

        --trying to register data into register x3 when write_enable='0'
        wait for 100 ns;
        write_enable<='0';
        reg_write_data<="0000000000000010";
        reg_write_address<="111";

        --registering data into register x3 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="0000000000000010";
        reg_write_address<="111";

        --reading register x3 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_2<="111";

        --trying to register data into register x4 when write_enable='0'
        wait for 100 ns;
        write_enable<='0';
        reg_write_data<="0000000000000011";
        reg_write_address<="100";

        --registering data into register x4 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="0000000000000011";
        reg_write_address<="100";

        --reading register x4 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_2<="100";

        --trying to register data into register x6 when write_enable='0'
        wait for 100 ns;
        write_enable<='0';
        reg_write_data<="0000000000000100";
        reg_write_address<="110";

        --registering data into register x6 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="0000000000000100";
        reg_write_address<="110";

        --reading register x6 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_2<="110";

        --trying to register data into register x7 when write_enable='0'
        wait for 100 ns;
        write_enable<='0';
        reg_write_data<="0000000000000101";
        reg_write_address<="111";

        --registering data into register x7 when write_enable='1'
        wait for 100 ns;
        write_enable<='1';
        reg_write_data<="0000000000000101";
        reg_write_address<="111";

        --reading register x7 data
        wait for 100 ns;    
        write_enable<='0';
        read_register_2<="111";

        --finishing testbench with general reset 

        wait;
    end process;
    
end architecture;
