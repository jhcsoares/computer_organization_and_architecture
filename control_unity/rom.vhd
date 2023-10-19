library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        rd_en: in std_logic;
        clk: in std_logic;
        address: in unsigned(6 downto 0);
        data: out unsigned(15 downto 0)
    );
end entity;

architecture behavioral of rom is
    type memory is array(0 to 127) of unsigned(15 downto 0);

    constant rom_content: memory:=(
        0=>"0000000000000000",
        1=>"0000000000000001",
        2=>"0000000000000010",
        3=>"0000000000000011",
        4=>"0000000000000100",
        5=>"1111111110000000",
        others=>"1111111111111111"
    );

    signal data_s: unsigned(15 downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rd_en='1' then
                data_s<=rom_content(to_integer(address));
            end if;
        end if;
    end process;

    data<=data_s;
end architecture;
