library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_with_adder is
    port(
        wr_en: in std_logic;
        clk: in std_logic;
        result: out unsigned(6 downto 0)
    );
end entity;

architecture behavioral of pc_with_adder is
    component pc 
        port(
            wr_en: in std_logic;
            clk: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
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

    data_out_added_s<=data_out_s+"0000001";
    result<=data_out_added_s;
end architecture;
