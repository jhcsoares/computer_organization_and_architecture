library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        operand_a, operand_b: in unsigned(15 downto 0);
        opcode: in unsigned(1 downto 0);
        result: out unsigned(15 downto 0);
        is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even: out std_logic
    );
end entity;

architecture behavioral of alu is
begin
    result  <=  operand_a+operand_b     when    opcode="00" else
                operand_a-operand_b     when    opcode="01" else
                operand_a and operand_b when    opcode="10" else
                operand_a or operand_b  when    opcode="11" else
                "0000_0000_0000_0000";
    
    is_result_zero  <=  '0' when    result="0000_0000_0000_0000"    else
                        '1' when    result/="0000_0000_0000_0000"   else
                        '0';
    
    is_a_bigger_than_b  <=  '0' when    operand_a<=operand_b    else
                            '1' when    operand_a>operand_b     else
                            '0';
    
    is_result_negative  <=  '0';

    is_result_even      <=  '0' when    result(0)='1'   else
                            '1' when    result(1)='0'   else
                            '0';
end architecture;
