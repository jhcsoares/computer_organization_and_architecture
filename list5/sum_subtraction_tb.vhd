library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum_subtraction_tb is
end entity;

architecture tb of sum_subtraction_tb is
    
    component sum_subtraction 
        port(
            x, y: in unsigned(7 downto 0);
            sum, subtraction: out unsigned(7 downto 0);
            is_x_bigger, is_x_negative: out std_logic
        );
    end component;

    signal x, y: unsigned(7 downto 0);
    signal sum, subtraction: unsigned(7 downto 0);
    signal is_x_bigger, is_x_negative: std_logic;

begin

    uut: sum_subtraction port map(
        x, y,
        sum, subtraction,
        is_x_bigger, is_x_negative
    );

    process
    begin
        x<="00001000";
        y<="00000111";
        wait for 50 ns;
        x<="00010010";  --x=18
        y<="11111101";  --y=-3
        wait for 50 ns;
        x<="11001000";
        y<="11001000";
        wait for 50 ns;
        wait;
    end process;

end architecture;
