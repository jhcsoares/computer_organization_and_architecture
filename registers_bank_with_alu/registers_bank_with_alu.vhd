library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers_bank_with_alu is
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
end entity;

architecture behavioral of registers_bank_with_alu is
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

    component alu 
        port(
            operand_a, operand_b: in unsigned(15 downto 0);
            op_selector: in unsigned(1 downto 0);
            result: out unsigned(15 downto 0);
            is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even, overflow: out std_logic
        );
    end component;

    signal alu_result_signal: unsigned(15 downto 0);
    signal read_register_1_data_signal: unsigned(15 downto 0);
    signal read_register_2_data_signal: unsigned(15 downto 0);
    signal operand_b_signal: unsigned(15 downto 0);

begin
    registers_bank_0: registers_bank port map(
        read_register_1=>read_register_1,
        read_register_2=>read_register_2,
        reg_write_data=>alu_result_signal,
        reg_write_address=>reg_write_address,
        write_enable=>write_enable,
        clk=>clk,
        rst=>rst,
        read_register_1_data=>read_register_1_data_signal,
        read_register_2_data=>read_register_2_data_signal
    );

    alu_0: alu port map(
        operand_a=>read_register_1_data_signal,
        operand_b=>operand_b_signal,
        op_selector=>alu_operation_selector,
        result=>alu_result_signal
    );

    operand_b_signal<=read_register_2_data_signal when operand_b_selector='0' else
                    imm_const when operand_b_selector='1' else
                    "0000000000000000";
    
    alu_result<=alu_result_signal;
end architecture;
