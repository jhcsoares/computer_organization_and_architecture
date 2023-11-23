library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity programmable_calculator is
    port(
        rst: in std_logic;
        clk: in std_logic
    );
end entity;

architecture behavioral of programmable_calculator is

    component rom 
        port(
            rd_en: in std_logic;
            clk: in std_logic;
            address: in unsigned(6 downto 0);
            data: out unsigned(15 downto 0)
        );
    end component;

    component pc 
        port(
            rst: in std_logic;
            clk: in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component instruction_register 
        port(
            clk: in std_logic;
            instruction: in unsigned(15 downto 0);
            inst_wr: in std_logic;
            data: out unsigned(15 downto 0)
        );
    end component;

    component control_unity 
        port(
            state: in unsigned(1 downto 0);
            clk: in std_logic;
            instruction: in unsigned(15 downto 0);
            jump_en: out std_logic;
            reg_rd: out std_logic;
            reg_wr: out std_logic;
            inst_wr: out std_logic;
            alu_src_b: out std_logic;
            alu_op: out unsigned(1 downto 0);
            mem_rd: out std_logic;
            jump_reg_wr_en: out std_logic;
            flags_wr_en: out std_logic;
            ram_wr_en: out std_logic;
            reg_wr_data_selector: out std_logic
        );
    end component;

    component registers_bank 
        port(
            read_enable: in std_logic;
            read_register_1: in unsigned(2 downto 0);
            read_register_2: in unsigned(2 downto 0);
            reg_write_address: in unsigned(2 downto 0);
            reg_write_data: in unsigned(15 downto 0);
            write_enable: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            read_register_1_data: out unsigned(15 downto 0);
            read_register_2_data: out unsigned(15 downto 0)
        );
    end component;

    component alu 
        port(
            operand_a, operand_b: in unsigned(15 downto 0);
            op_selector: in unsigned(1 downto 0);
            result: out unsigned(15 downto 0);
            is_result_negative, overflow: out std_logic
        );
    end component;

    component alu_reg
        port(
            rst: in std_logic;
            alu_result: in unsigned(15 downto 0);
            clk: in std_logic;
            wr_en: in std_logic;
            data: out unsigned(15 downto 0)
        );
    end component;

    component states_machine 
        port(
            rst: in std_logic;
            clk: in std_logic;
            state: out unsigned(1 downto 0)
        );
    end component;

    component jump_data_reg 
        port(
            rst: in std_logic;
            wr_en: in std_logic;
            clk: in std_logic;
            data_in: in std_logic;
            data_out: out std_logic
        );
    end component;

    component is_negative_register 
        port(
            rst: in std_logic;
            wr_en: in std_logic;
            clk: in std_logic;
            data_in: in std_logic;
            data_out: out std_logic
        );
    end component;

    component overflow_register
        port(
            rst: in std_logic;
            wr_en: in std_logic;
            clk: in std_logic;
            data_in: in std_logic;
            data_out: out std_logic
        );
    end component;

    component blt_register 
        port(
            rst: in std_logic;
            state: in unsigned(1 downto 0);
            clk: in std_logic;
            data_in: in std_logic;
            data_out: out std_logic
        );
    end component;

    component ram 
        port( 
            clk      : in std_logic;
            address  : in unsigned(6 downto 0);
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0) 
        );
     end component;

    signal mem_rd_s: std_logic;
    signal data_out_pc_s: unsigned(6 downto 0);
    signal pc_wr_s: std_logic;
    signal pc_wr_jump_s: std_logic;
    signal data_in_pc_s: unsigned(6 downto 0);
    signal data_in_pc_main: unsigned(6 downto 0);
    signal rom_data_s: unsigned(15 downto 0);
    signal inst_wr_s: std_logic;
    signal instruction: unsigned(15 downto 0);
    signal jump_en_s: std_logic;
    signal reg_rd_s: std_logic;
    signal reg_wr_s: std_logic;
    signal alu_src_b_s: std_logic;
    signal operand_b_s: unsigned(15 downto 0);
    signal alu_op_s: unsigned(1 downto 0);
    signal alu_result_reg_out_s: unsigned(15 downto 0);
    signal read_register_1_data_s: unsigned(15 downto 0);
    signal read_register_2_data_s: unsigned(15 downto 0);
    signal alu_result_s: unsigned(15 downto 0);
    signal imm_extended: unsigned(15 downto 0);
    signal imm_signal: std_logic;
    signal state_s: unsigned(1 downto 0);
    signal jump_reg_wr_en_s: std_logic;
    signal jump_reg_out_s: std_logic;
    signal is_negative_s: std_logic;
    signal overflow_s: std_logic;
    signal is_negative_reg_out: std_logic;
    signal overflow_reg_out: std_logic;
    signal blt: std_logic;
    signal blt_address: unsigned(6 downto 0);
    signal blt_reg_out: std_logic;
    signal flags_wr_en_s: std_logic;
    signal ram_wr_en_s: std_logic;    
    signal ram_data_out_s: unsigned(15 downto 0);
    signal reg_write_data_s: unsigned(15 downto 0);
    signal ram_address_s: unsigned(6 downto 0);
    signal reg_wr_data_selector_s: std_logic;

begin
    rom0: rom port map(
        rd_en=>mem_rd_s,
        clk=>clk,
        address=>data_out_pc_s,
        data=>rom_data_s
    );

    pc0: pc port map(
        rst=>rst,
        clk=>clk,
        wr_en=>pc_wr_s,
        data_in=>data_in_pc_main,
        data_out=>data_out_pc_s
    );

    instruction_register0: instruction_register port map(
        clk=>clk,
        instruction=>rom_data_s,
        inst_wr=>inst_wr_s,
        data=>instruction
    );

    control_unity0: control_unity port map(
        state=>state_s,
        clk=>clk,
        instruction=>instruction,
        jump_en=>jump_en_s,
        reg_rd=>reg_rd_s,
        reg_wr=>reg_wr_s,
        inst_wr=>inst_wr_s,
        alu_src_b=>alu_src_b_s,
        alu_op=>alu_op_s,
        mem_rd=>mem_rd_s,
        jump_reg_wr_en=>jump_reg_wr_en_s,
        flags_wr_en=>flags_wr_en_s,
        ram_wr_en=>ram_wr_en_s,
        reg_wr_data_selector=>reg_wr_data_selector_s
    );

    registers_bank0: registers_bank port map(
        read_enable=>reg_rd_s,
        read_register_1=>instruction(11 downto 9),
        read_register_2=>instruction(8 downto 6),
        reg_write_address=>instruction(8 downto 6),
        reg_write_data=>reg_write_data_s,
        write_enable=>reg_wr_s,
        clk=>clk,
        rst=>rst,
        read_register_1_data=>read_register_1_data_s,
        read_register_2_data=>read_register_2_data_s
    );

    alu0: alu port map(
        operand_a=>read_register_1_data_s, 
        operand_b=>operand_b_s,
        op_selector=>alu_op_s,
        result=>alu_result_s,
        is_result_negative=>is_negative_s,
        overflow=>overflow_s
    );

    states_machine0: states_machine port map(
        rst=>rst,
        clk=>clk,
        state=>state_s
    );

    jump_data_reg0: jump_data_reg port map(
        rst=>rst,
        wr_en=>jump_reg_wr_en_s,
        clk=>clk,
        data_in=>jump_en_s,
        data_out=>jump_reg_out_s
    );

    is_negative_register0: is_negative_register port map(
        rst=>rst,
        wr_en=>flags_wr_en_s,
        clk=>clk,
        data_in=>is_negative_s,
        data_out=>is_negative_reg_out
    );

    overflow_register0: overflow_register port map(
        rst=>rst,
        wr_en=>flags_wr_en_s,
        clk=>clk,
        data_in=>overflow_s,
        data_out=>overflow_reg_out
    );

    blt_register0: blt_register port map(
            rst=>rst,
            state=>state_s,
            clk=>clk,
            data_in=>blt,
            data_out=>blt_reg_out
    );
    
    ram0: ram port map(
        clk=>clk,      
        address=>ram_address_s, 
        wr_en=>ram_wr_en_s,    
        data_in=>read_register_2_data_s, 
        data_out=>ram_data_out_s 
    );

    blt<=is_negative_reg_out xor overflow_reg_out;

    pc_wr_s<='1' when (state_s="00" and jump_reg_out_s='0' and blt_reg_out='0') or 
                      (state_s="11" and jump_en_s='1')                          or
                      (state_s="11" and blt_reg_out='1')                        else
             '0';

    blt_address<=data_out_pc_s+instruction(6 downto 0);

    data_in_pc_s<=blt_address when jump_en_s='0' and blt_reg_out='1' else
                  --data_out_pc_s+1 when jump_en_s='0' else
                  read_register_1_data_s(6 downto 0) when jump_en_s='1' else
                  data_out_pc_s+1;

    data_in_pc_main<=data_in_pc_s when rst='0' else
                     "0000000";

    imm_signal<='0';--instruction(5);
    imm_extended<=imm_signal&imm_signal&imm_signal&imm_signal&imm_signal&
                  imm_signal&imm_signal&imm_signal&imm_signal&imm_signal&
                  instruction(5 downto 0);

    operand_b_s<=imm_extended when alu_src_b_s='0' else
                 read_register_2_data_s;

    reg_write_data_s<=ram_data_out_s when reg_wr_data_selector_s='1' else
                      alu_result_s;

    ram_address_s<=read_register_1_data_s(6 downto 0)+(instruction(5) & instruction(5 downto 0));
        
end architecture;
