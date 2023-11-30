library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(
        rst: in std_logic;
        clk: in std_logic;
        a0, b0, c0, d0, e0, f0, g0, h0: out std_logic;
        a1, b1, c1, d1, e1, f1, g1, h1: out std_logic
    );
end entity;

architecture behavioral of top_level is
    component programmable_calculator
        port(
            rst: in std_logic;
            clk: in std_logic;
            prime_numbers: out unsigned(15 downto 0)
        );
    end component;

    component Timing_Reference 
        port(clk: in std_logic; 
            clk_2Hz: out std_logic);
    
    end component;

    component hex10_to_7seg_dec 
        port(
            dot : in std_logic;
            d: in unsigned(3 downto 0);
            a_s, b_s, c_s, d_s, e_s, f_s, g_s, h_s : out std_logic);
    end component;
    
    signal clk_s: std_logic;
    signal clk_f: std_logic;
    signal prime_numbers_s: unsigned(15 downto 0);

begin
    -- Timing_Reference0: Timing_Reference port map(
    --     clk,
    --     clk_s
    -- );

    programmable_calculator0: programmable_calculator port map(
        rst,
        clk,
        prime_numbers_s
    );

    clk_f<=not(rst) and clk_s;

    hex10_to_7seg_dec0: hex10_to_7seg_dec port map(
        '0',
        prime_numbers_s(3 downto 0),
        a0, b0, c0, d0, e0, f0, g0, h0
    );

    hex10_to_7seg_dec1: hex10_to_7seg_dec port map(
        '0',
        prime_numbers_s(7 downto 4),
        a1, b1, c1, d1, e1, f1, g1, h1
    );

end architecture;
