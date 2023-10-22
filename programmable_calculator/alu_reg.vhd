library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_reg is 
    port(
        rst: in std_logic;
        alu_result: in unsigned(15 downto 0);
        clk: in std_logic;
        wr_en: in std_logic;
        data: out unsigned(15 downto 0)
    );
end entity;

architecture behavioral of alu_reg is
begin
    process(clk, rst)
    begin
        if rst='1' then
            data<="0000000000000000";
        elsif rising_edge(clk) then
            if wr_en='1' then
                data<=alu_result;
            end if;
        end if;
    end process;
end architecture;
