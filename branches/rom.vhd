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
        0=>"0001000111011110",
        1=>"0010000011000000",
        2=>"0010000100000000",
        3=>"0010011100000000",
        4=>"0001011011000001",
        5=>"0100111011000000",
        6=>"0101000000000110",
        7=>"0010100101000000",
        8=>"0011100000000000",
        others=>"0000000000000000"
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
