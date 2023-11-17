library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unity_tb is
end entity;

architecture tb of control_unity_tb is
    component control_unity 
        port(
            clk: in std_logic;
            instruction: in unsigned(15 downto 0);
            pc_wr: out std_logic;
            jump_en: out std_logic;
            reg_rd: out std_logic;
            reg_wr: out std_logic;
            inst_wr: out std_logic;
            alu_src_b: out std_logic;
            alu_op: out unsigned(1 downto 0);
            mem_rd: out std_logic
        );
    end component;

    constant period_time: time :=50 ns;    --clk period
    signal finished: std_logic :='0';
    signal clk_s: std_logic;

    signal instruction: unsigned(15 downto 0);
    signal rst: std_logic;
    signal pc_wr: std_logic;
    signal jump_en: std_logic;
    signal reg_rd: std_logic;
    signal reg_wr: std_logic;
    signal inst_wr: std_logic;
    signal alu_src_b: std_logic;
    signal alu_op: unsigned(1 downto 0);
    signal mem_rd: std_logic;
    
begin
    uut: control_unity port map(
        clk_s,
        instruction,
        pc_wr,
        jump_en,
        reg_rd,
        reg_wr,
        inst_wr,
        alu_src_b,
        alu_op,
        mem_rd
    );

    sim_time_proc: process
    begin
        wait for 1 us;
        finished<='1';
        wait;
    end process;

    global_clk: process
    begin
        while finished/='1' loop
            clk_s<='0';
            wait for period_time/2;
            clk_s<='1';
            wait for period_time/2;
        end loop;
        wait;
    end process;

    main_process: process
    begin
        wait;
        
    end process;
end architecture;
