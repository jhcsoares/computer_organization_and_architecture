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
        0=>B"0001_000_111_011110",  --addi 30,r0,r7
        1=>B"0010_000_011_000000",  --add r0,r3
        2=>B"0010_000_100_000000",  --add r0,r4
        3=>B"0010_011_100_000000",  --add r3,r4
        4=>B"0001_011_011_000001",  --addi 1,r3,r3
        5=>B"0100_111_011_000000",  --cmp r7,r3
        6=>B"0101_00000_1111101",   --blt -3
        7=>B"0010_100_101_000000",  --addi 0,r4,r5
        8=>B"0011_111_000000000",   --jmp r7
        others=>"0000000000000000"  --nop
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
