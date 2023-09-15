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
            is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even, overflow: out std_logic
        );
    end component;

    signal operand_a, operand_b: unsigned(15 downto 0);
    signal op_selector: unsigned(1 downto 0);
    signal result: unsigned(15 downto 0);
    signal is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even, overflow: std_logic;

begin
    uut1: alu port map(
        operand_a, operand_b,
        op_selector,
        result,
        is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even, overflow
    );

    process
    begin
        --when op_selector="00" -> sum
        --when op_selector="01" -> subtraction
        --when op_selector="10" -> AND
        --when op_selector="11" -> OR

        --overflow
        op_selector<="00";
        operand_a<="1111111111111111";
        operand_b<="0000000000000010";
        wait for 50 ns;

        --a=b -> sum
        op_selector<="00";
        operand_a<="0000000010000001";
        operand_b<="0000000010000001";
        wait for 50 ns;
        
        --a>b -> normal sum
        op_selector<="00";
        operand_a<="0000000010000001";
        operand_b<="0000000010000000";
        wait for 50 ns;

        --a<b -> normal sum
        op_selector<="00";
        operand_a<="0000000000110010";
        operand_b<="0000000001100111";
        wait for 50 ns;

        --a=-32 b=32 -> subtraction
        op_selector<="01";
        operand_a<="1111111111100000";
        operand_b<="0000000000100000";
        wait for 50 ns;

        --a=32 b=-32 -> subtraction
        op_selector<="01";
        operand_a<="0000000000100000";
        operand_b<="1111111111100000";
        wait for 50 ns;

        --a=-32 b=-32 -> subtraction
        op_selector<="01";
        operand_a<="1111111111100000";
        operand_b<="1111111111100000";
        wait for 50 ns;


        --a=b -> subtraction
        op_selector<="01";
        operand_a<="0000000001100100";
        operand_b<="0000000001100100";
        wait for 50 ns;

        --a>b -> subtraction
        op_selector<="01";
        operand_a<="0000000001100100";
        operand_b<="0000000000110010";
        wait for 50 ns;

        --a<b -> subtraction
        op_selector<="01";
        operand_a<="0000000000110010";
        operand_b<="0000000001100100";
        wait for 50 ns;

        --and 
        op_selector<="10";
        operand_a<="0000000001100100";
        operand_b<="0000000000110010";
        wait for 50 ns;

        --and a=FFFF b=FFFF
        op_selector<="10";
        operand_a<="1111111111111111";
        operand_b<="1111111111111111";
        wait for 50 ns;

        --and a=0000 b=0000
        op_selector<="10";
        operand_a<="0000000000000000";
        operand_b<="0000000000000000";
        wait for 50 ns;

        --or
        op_selector<="11";
        operand_a<="0000000001100100";
        operand_b<="0000000000110010";
        wait for 50 ns;

        --or a=FFFF b=FFFF
        op_selector<="11";
        operand_a<="1111111111111111";
        operand_b<="1111111111111111";
        wait for 50 ns;

        --or a=0000 b=0000
        op_selector<="11";
        operand_a<="0000000000000000";
        operand_b<="0000000000000000";
        wait for 50 ns;
        wait;
    end process;
end architecture;
