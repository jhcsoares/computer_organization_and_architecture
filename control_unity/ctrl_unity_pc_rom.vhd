library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl_unity_pc_rom is
    port(
        clk: in std_logic
    );
end entity;

architecture behavioral of ctrl_unity_pc_rom is
    component control_unity
        port(
            instruction: in unsigned(15 downto 0);
            clk: in std_logic;
            rd_en: out std_logic;
            pc_wr: out std_logic;
            jump_en: out std_logic;
            jump_address: out unsigned(6 downto 0) 
        );
    end component;

    component pc 
        port(
            wr_en: in std_logic;
            clk: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0):="0000000"
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

    signal rd_en_s: std_logic;
    signal pc_wr_s: std_logic;
    signal jump_en_s: std_logic;
    signal jump_address_s: unsigned(6 downto 0); 
    signal data_in_pc: unsigned(6 downto 0);
    signal data_out_pc: unsigned(6 downto 0);
    signal rom_data_s: unsigned(15 downto 0);
    
begin
    control_unity0: control_unity port map(
        rom_data_s,
        clk,
        rd_en_s,
        pc_wr_s,
        jump_en_s,
        jump_address_s
    );
    
    pc0: pc port map(
        pc_wr_s,
        clk,
        data_in_pc,
        data_out_pc
    );

    rom0: rom port map(
        rd_en_s,
        clk,
        data_out_pc,
        rom_data_s
    );
    
    data_in_pc<=data_out_pc+"0000001" when jump_en_s='0' else
                jump_address_s when jump_en_s='1' else
                "0000000";
end architecture;
