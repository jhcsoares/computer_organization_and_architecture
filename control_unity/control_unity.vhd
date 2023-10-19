library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unity is
    port(
        instruction: in unsigned(15 downto 0);
        clk: in std_logic;
        rd_en: out std_logic:='1';
        pc_wr: out std_logic;
        jump_en: out std_logic;
        jump_address: out unsigned(6 downto 0)
    );
end entity;

architecture behavioral of control_unity is
    component t_ff 
        port(
            t: in std_logic;
            clk: in std_logic;
            reset: in std_logic;
            state: out std_logic
        );
    end component;

    signal state_s: std_logic;
    signal opcode: unsigned(8 downto 0);

begin
    t_ff0: t_ff port map(
        '1',
        clk,
        '0',
        state_s
    );

    process(clk)
    begin
        if rising_edge(clk) then
            if state_s='0' then
                rd_en<='1';
                pc_wr<='0';
            else
                rd_en<='0';
                pc_wr<='1';
            end if;
        end if;
    end process;

    -- rd_en<='1' when state_s='0' else
    --        '0' when state_s='1' else
    --        '0';
    
    -- pc_wr<='0' when state_s='0' else
    --        '1' when state_s='1' else
    --        '0';
     
    opcode<=instruction(15 downto 7);

    jump_en<='0' when opcode/="111111111" else
             '1' when opcode="111111111"  else
             '0';
    
    jump_address<=instruction(6 downto 0);
             
end architecture;
