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
            --rst: in std_logic;
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
            --rst: in std_logic;
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
            is_result_zero, is_a_bigger_than_b, is_result_negative, is_result_even, overflow: out std_logic
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

    signal mem_rd_s: std_logic;
    signal data_out_pc_s: unsigned(6 downto 0);
    signal pc_wr_s: std_logic;
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
    signal alu_wr_reg_s: std_logic;
    signal alu_result_reg_out_s: unsigned(15 downto 0);
    signal read_register_1_data_s: unsigned(15 downto 0);
    signal read_register_2_data_s: unsigned(15 downto 0);
    signal alu_result_s: unsigned(15 downto 0);
    signal imm_extended: unsigned(15 downto 0);
    signal imm_signal: std_logic;
    signal state_s: unsigned(1 downto 0);

begin
    rom0: rom port map(
        --rst=>rst,
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
        --rst=>rst,
        clk=>clk,
        instruction=>rom_data_s,
        inst_wr=>inst_wr_s,
        data=>instruction
    );

    control_unity0: control_unity port map(
        state=>state_s,
        clk=>clk,
        instruction=>instruction,
        pc_wr=>pc_wr_s,
        jump_en=>jump_en_s,
        reg_rd=>reg_rd_s,
        reg_wr=>reg_wr_s,
        inst_wr=>inst_wr_s,
        alu_wr_reg=>alu_wr_reg_s,
        alu_src_b=>alu_src_b_s,
        alu_op=>alu_op_s,
        mem_rd=>mem_rd_s
    );

    registers_bank0: registers_bank port map(
        read_enable=>reg_rd_s,
        read_register_1=>instruction(11 downto 9),
        read_register_2=>instruction(8 downto 6),
        reg_write_address=>instruction(8 downto 6),
        reg_write_data=>alu_result_s,
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
        result=>alu_result_s
    );

    alu_reg0: alu_reg port map(
        rst=>rst,
        alu_result=>alu_result_s,
        clk=>clk,
        wr_en=>alu_wr_reg_s,
        data=>alu_result_reg_out_s
    );

    states_machine0: states_machine port map(
        rst=>rst,
        clk=>clk,
        state=>state_s
    );

    data_in_pc_s<=data_out_pc_s+1 when jump_en_s='0' else
                  read_register_1_data_s(6 downto 0);

    data_in_pc_main<=data_in_pc_s when rst='0' else
                     "0000000";

    imm_signal<=instruction(5);
    imm_extended<=imm_signal&imm_signal&imm_signal&imm_signal&imm_signal&
                  imm_signal&imm_signal&imm_signal&imm_signal&imm_signal&
                  instruction(5 downto 0);

    operand_b_s<=imm_extended when alu_src_b_s='0' else
                 read_register_2_data_s;
        
end architecture;
