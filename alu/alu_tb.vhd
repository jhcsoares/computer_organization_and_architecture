library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture tb of alu_tb is

    component alu 
        port(
            operand_a, operand_b: in unsigned(15 downto 0);
            op_selector: in unsigned(1 downto 0);
            result: out unsigned(15 downto 0);
            is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even: out std_logic
        );
    end component;

    signal operand_a, operand_b: unsigned(15 downto 0);
    signal op_selector: unsigned(1 downto 0);
    signal result: unsigned(15 downto 0);
    signal is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even: std_logic;

begin
    uut1: alu port map(
        operand_a, operand_b,
        op_selector,
        result,
        is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even
    );

    process
    begin
        op_selector<="00";
        operand_a<="0000000001100111";
        operand_b<="0000000000110010";
        wait for 50 ns;

        op_selector<="01";
        operand_a<="0000000001100100";
        operand_b<="0000000001100100";
        wait for 50 ns;

        op_selector<="01";
        operand_a<="0000000000110010";
        operand_b<="0000000001100100";
        wait for 50 ns;

        op_selector<="10";
        operand_a<="0000000001100100";
        operand_b<="0000000000110010";
        wait for 50 ns;

        op_selector<="11";
        operand_a<="0000000001100100";
        operand_b<="0000000000110010";
        wait for 50 ns;
        wait;
    end process;
end architecture;
