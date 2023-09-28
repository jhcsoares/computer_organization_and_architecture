library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers_bank_with_alu_tb is
end entity;

architecture tb of registers_bank_with_alu_tb is
    component registers_bank_with_alu 
        port(
            read_register_1: in unsigned(2 downto 0);
            read_register_2: in unsigned(2 downto 0);
            reg_write_address: in unsigned(2 downto 0);
            write_enable: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            imm_const: in unsigned(15 downto 0);
            alu_operation_selector: in unsigned(1 downto 0);
            operand_b_selector: in std_logic;
            alu_result: out unsigned(15 downto 0)
        );
    end component;

    constant period_time: time :=100 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk, rst: std_logic;

    signal read_register_1: unsigned(2 downto 0);
    signal read_register_2: unsigned(2 downto 0);
    signal reg_write_address: unsigned(2 downto 0);
    signal write_enable: std_logic;
    signal imm_const: unsigned(15 downto 0);
    signal alu_operation_selector: unsigned(1 downto 0);
    signal operand_b_selector: std_logic;
    signal alu_result: unsigned(15 downto 0);

begin
    uut: registers_bank_with_alu port map(
        read_register_1,
        read_register_2,
        reg_write_address,
        write_enable,
        clk,
        rst,
        imm_const,
        alu_operation_selector,
        operand_b_selector,
        alu_result
    );

    initial_reset:process
    begin
        rst <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        rst <= '0';
        wait for 900 ns;
        rst <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        rst <= '0';
        wait;
    end process;

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
        --reseting registers
        wait for 200 ns;       

        read_register_1<="000"; --constant zero

        operand_b_selector<='1'; --selecting imm_const
        imm_const<="1111111111111110";

        alu_operation_selector<="00"; --sum

        write_enable<='1';
        reg_write_address<="010"; --writing "1111111111111110" at x2 register

        wait for 100 ns;

        --sum 1111111111111110 and 0000000000000001

        read_register_1<="010"; --getting "1111111111111110" 
        imm_const <="0000000000000001";

        reg_write_address<="001";   --writing "1111111111111111" at x1 register

        wait for 100 ns;

        read_register_1<="001"; --getting 1111111111111111
        read_register_2<="010"; --getting 1111111111111110
        operand_b_selector<='0'; --selecting read_register_2
        alu_operation_selector<="01"; --subtraction
        write_enable<='0';     --not saving the result
        
        wait for 100 ns;

        imm_const<="0000000000000000";
        operand_b_selector<='1'; --selecting imm_const
        alu_operation_selector<="10"; --and

        wait for 100 ns;

        imm_const<="0000000000000001";
        alu_operation_selector<="11"; --or
        write_enable<='1';
        reg_write_address<="111"; --writing "1111111111111111" at x7 register

        wait for 100 ns;
        read_register_2<="111"; --getting "1111111111111111"
        operand_b_selector<='1'; --selecting read_register_2
        alu_operation_selector<="11"; --and

        wait;
        
    end process;
end architecture;
