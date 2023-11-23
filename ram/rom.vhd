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
        0=>B"0001_000_010_100001", --addi 33,r0,r2 
        1=>B"0001_000_001_000000", --addi 0,r0,r1
        2=>B"0111_001_001_000000", --st.w r1,0(r1)
        3=>B"0001_001_001_000001", --addi 1,r1,r1
        4=>B"0100_010_001_000000", --cmp r2,r1
        5=>B"0101_00000_1111101", --blt -3

        6=>B"0001_000_111_000001", --addi 1,r0,r7

        7=>B"0001_000_010_100001", --addi 33,r0,r2 
        8=>B"0001_000_011_000010", --addi 2,r0,r3 
        9=>B"0010_011_101_000000", --add r3,r5
        10=>B"0010_011_101_000000", --add r3,r5
        11=>B"0111_101_000_000000", --st.w r0,0(r5)
        12=>B"0100_010_101_000000", --cmp r2,r5
        13=>B"0101_00000_1111101", --blt -3
        14=>B"0010_111_011_000000", --add r7,r3 
        15=>B"0001_000_101_000000", --addi 0,r0,r5 
        16=>B"0100_010_011_000000", --cmp r3,r2
        17=>B"0101_00000_1111000", --blt -8

        others=>"0000000000000000"  --nop
        -- 0=>B"0001_000_111_011110",  --addi 30,r0,r7
        -- 1=>B"0010_000_011_000000",  --add r0,r3
        -- 2=>B"0010_000_100_000000",  --add r0,r4
        -- 3=>B"0010_011_100_000000",  --add r3,r4
        -- 4=>B"0001_011_011_000001",  --addi 1,r3,r3
        -- 5=>B"0100_111_011_000000",  --cmp r7,r3
        -- 6=>B"0101_00000_1111101",  --blt -3
        -- 7=>B"0010_100_101_000000",  --addi 0,r4,r5
        -- --8=>B"0011_111_000000000",   --jmp r7
        -- 8=>B"0001_000_001_000111", --addi 7,r0,r1
        -- 9=>B"0001_000_010_000100", --addi 4,r0,r2
        -- 10=>B"0111_001_010_000000", --st.w r2,0(r1)
        -- 11=>B"0000000000000000", --nop
        -- 12=>B"1000_001_011_000000", --lw.w 0(r1),r3
        -- 13=>B"0001_000_110_111111", --addi FFFF,r0,r6
        -- 14=>B"0111_001_110_000000", --st.w r6,0(r1)
        -- 15=>B"0000000000000000", --nop
        -- 16=>B"1000_001_101_000000", --lw.w 0(r1),r5
        -- 17=>B"0001_000_100_001010", --addi A,r0,r4
        -- 18=>B"0111_101_100_000000", --st.w r4,0(r5)
        -- 19=>B"0111_101_100_111100", --st.w r4,-4(r5)
        -- 20=>B"0111_001_100_000101", --st.w r4,5(r1)
        -- 21=>B"1000_001_011_000101", --lw.w 5(r1),r3
        -- 22=>B"0011_011_000000000",   --jmp r3
        -- others=>"0000000000000000"  --nop
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
