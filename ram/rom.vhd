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
        0=>B"0001_000_001_000111", --addi 7,r0,r1
        1=>B"0001_000_010_000100", --addi 4,r0,r2
        2=>B"0111_001_010_000000", --st.w r2,0(r1)
        3=>B"1000_001_011_000000", --lw.w 0(r1),r3
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
