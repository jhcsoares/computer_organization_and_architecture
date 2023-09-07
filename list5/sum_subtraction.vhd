library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum_subtraction is
    port(
        x, y: in unsigned(7 downto 0);
        sum, subtraction: out unsigned(7 downto 0);
        is_x_bigger, is_x_negative: out std_logic
    );
end entity;

architecture behavioral of sum_subtraction is
begin
    sum<=x+y;
    subtraction<=x-y;

    is_x_bigger <=  '1' when    x>y     else
                    '0' when    x<=y    else
                    '0';
    
    is_x_negative<=x(7);
end architecture;
