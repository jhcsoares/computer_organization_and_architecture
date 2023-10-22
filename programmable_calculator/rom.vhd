library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        --rst: in std_logic;
        rd_en: in std_logic;
        clk: in std_logic;
        address: in unsigned(6 downto 0);
        data: out unsigned(15 downto 0)
    );
end entity;

architecture behavioral of rom is
    type memory is array(0 to 127) of unsigned(15 downto 0);

    constant rom_content: memory:=(
        0=>"0001000011000101",
        1=>"0101000100001000",
        2=>"0010011100000000",
        3=>"0100100101000000",
        4=>"0001000001000001",
        5=>"0110001101000000",
        6=>"0001000010010100",
        7=>"0011010000000000",
        20=>"0001101011000000",
        21=>"0001000111000010",
        22=>"0011111000000000",
        others=>"0000000000000000"
    );

    signal data_s: unsigned(15 downto 0);

begin
    process(clk)
    begin
        -- if rst='1' then
        --     data_s<=rom_content(to_integer(address));
        if rising_edge(clk) then
            if rd_en='1' then
                data_s<=rom_content(to_integer(address));
            end if;
        end if;
    end process;

    data<=data_s;
end architecture;
