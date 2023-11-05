library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_register is
    port(
        --rst: in std_logic;
        clk: in std_logic;
        instruction: in unsigned(15 downto 0);
        inst_wr: in std_logic;
        data: out unsigned(15 downto 0)
    );
end entity;

architecture behavioral of instruction_register is

begin
    process(clk)
    begin
        --if rst='1' then
        --    data<="0000000000000000";
        if rising_edge(clk) then
            if inst_wr='1' then
                data<=instruction;
            end if;
        end if;
    end process;
end architecture;
