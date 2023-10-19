library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_with_rom is
    port(
        wr_en: in std_logic;
        clk: in std_logic;
        data: out unsigned(15 downto 0)
    );
end entity;

architecture behavioral of pc_with_rom is
    component pc 
        port(
            wr_en: in std_logic;
            clk: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component rom 
        port(
            rd_en: in std_logic;
            clk: in std_logic;
            address: in unsigned(6 downto 0);
            data: out unsigned(15 downto 0)
        );
    end component;

    signal data_out_s: unsigned(6 downto 0);
    signal data_out_added_s: unsigned(6 downto 0);

begin
    pc0: pc port map(
        wr_en,
        clk,
        data_out_added_s,
        data_out_s
    );

    rom0: rom port map(
        '1',
        clk,
        data_out_s,
        data
    );

    data_out_added_s<=data_out_s+"0000001";
end architecture;
