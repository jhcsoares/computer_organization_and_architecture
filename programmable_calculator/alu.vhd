library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        operand_a, operand_b: in unsigned(15 downto 0);
        op_selector: in unsigned(1 downto 0);
        result: out unsigned(15 downto 0);
        is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even, overflow: out std_logic
    );
end entity;

architecture behavioral of alu is
    component mux4x1 
        port(
            op_selector: in unsigned(1 downto 0);
            operation0: in unsigned(15 downto 0);
            operation1: in unsigned(15 downto 0);
            operation2: in unsigned(15 downto 0);
            operation3: in unsigned(15 downto 0);
            result: out unsigned(15 downto 0)
        );
    end component;
    
    signal sum: unsigned(15 downto 0);
    signal subtraction: unsigned(15 downto 0);
    signal and_signal: unsigned(15 downto 0);
    signal or_signal: unsigned(15 downto 0);
    signal overflow_sum: unsigned(16 downto 0);
    signal overflow_subtraction: unsigned(16 downto 0);
    signal overflow_signal: unsigned(16 downto 0);
    signal result_signal: unsigned(15 downto 0);

begin          
    sum<=operand_a+operand_b;
    subtraction<=operand_b-operand_a;
    and_signal<=operand_a and operand_b;
    or_signal<=operand_a or operand_b;
    overflow_sum<=('0' & operand_a) + ('0' & operand_b);
    overflow_subtraction<=('0' & operand_a) - ('0' & operand_b);

    uut1: mux4x1 port map(
        op_selector,
        sum,
        subtraction,
        and_signal,
        or_signal,
        result_signal
    );
    
    result<=result_signal;

    is_result_zero  <=  '1' when    result_signal="0000000000000000"    else
                        '0' when    result_signal/="0000000000000"   else
                        '0';
    
    is_a_bigger_than_b  <=  '0' when    operand_a<=operand_b    else
                            '1' when    operand_a>operand_b     else
                            '0';
    
    is_result_negative  <=  result_signal(15);

    is_result_even      <=  '0' when    result_signal(0)='1'   else
                            '1' when    result_signal(0)='0'   else
                            '0';
    
    overflow_signal     <=  overflow_sum    when    op_selector="00"    else
                            overflow_subtraction    when    op_selector="01"    else
                            "00000000000000000";
    
    overflow            <=  '1' when    overflow_signal>="10000000000000000"    else
                            '0' when    overflow_signal<"10000000000000000"    else
                            '0';
end architecture;
