library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unity is
    port(
        state: in unsigned(1 downto 0);
        clk: in std_logic;
        instruction: in unsigned(15 downto 0);
        pc_wr: out std_logic;
        jump_en: out std_logic;
        reg_rd: out std_logic;
        reg_wr: out std_logic;
        inst_wr: out std_logic;
        alu_wr_reg: out std_logic;
        alu_src_b: out std_logic;
        alu_op: out unsigned(1 downto 0);
        mem_rd: out std_logic
    );
end entity;

architecture behavioral of control_unity is
    signal opcode: unsigned(3 downto 0);
    signal jump_en_s: std_logic;

begin
    opcode<=instruction(15 downto 12);

    --main control signals

    pc_wr<='1' when (state="00") else
           '0';

    mem_rd<='1' when state="01" else
            '0';

    inst_wr<='1' when state="10" else
             '0';

    --signals controlled by opcode
    
    jump_en_s<='1' when opcode="0011" and state="11" else
               '0';
            
    jump_en<=jump_en_s;
    
    reg_wr<='1' when (opcode="0001" and state="11") or 
                     (opcode="0010" and state="11") or 
                     (opcode="0100" and state="11") or 
                     (opcode="0101" and state="11") or 
                     (opcode="0110" and state="11") else
            '0';

    reg_rd<='1' when state="11" else
            '0';
        
    alu_wr_reg<='1' when state="10" else
                '0';

    alu_src_b<='0' when (opcode="0001" and state="11") or 
                        (opcode="0101" and state="11") else
               '1'; 
    
    alu_op<="00" when (opcode="0001" and state="11") or
                      (opcode="0010" and state="11") or
                      (opcode="0000" and state="11") else
            "01" when (opcode="0110" and state="11") else
            "00";

end architecture;

