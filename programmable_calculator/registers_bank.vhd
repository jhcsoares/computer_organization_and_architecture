library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers_bank is
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
end entity;

architecture behavioral of registers_bank is
    component reg16bits 
        port(
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    signal wr_en_aux: std_logic_vector(7 downto 0);

    signal data_out_0: unsigned(15 downto 0);
    signal data_out_1: unsigned(15 downto 0);
    signal data_out_2: unsigned(15 downto 0);
    signal data_out_3: unsigned(15 downto 0);
    signal data_out_4: unsigned(15 downto 0);
    signal data_out_5: unsigned(15 downto 0);
    signal data_out_6: unsigned(15 downto 0);
    signal data_out_7: unsigned(15 downto 0);

    signal read_reg_1_data_aux: unsigned(15 downto 0);
    signal read_reg_2_data_aux: unsigned(15 downto 0);

begin
    data_out_0<="0000000000000000";
    
    reg0: reg16bits port map(
        clk,
        rst,
        wr_en_aux(0),
        "0000000000000000",
        data_out_0
    );

    reg1: reg16bits port map(
        clk,
        rst,
        wr_en_aux(1),
        reg_write_data,
        data_out_1
    );

    reg2: reg16bits port map(
        clk,
        rst,
        wr_en_aux(2),
        reg_write_data,
        data_out_2
    );

    reg3: reg16bits port map(
        clk,
        rst,
        wr_en_aux(3),
        reg_write_data,
        data_out_3
    );

    reg4: reg16bits port map(
        clk,
        rst,
        wr_en_aux(4),
        reg_write_data,
        data_out_4
    );

    reg5: reg16bits port map(
        clk,
        rst,
        wr_en_aux(5),
        reg_write_data,
        data_out_5
    );

    reg6: reg16bits port map(
        clk,
        rst,
        wr_en_aux(6),
        reg_write_data,
        data_out_6
    );

    reg7: reg16bits port map(
        clk,
        rst,
        wr_en_aux(7),
        reg_write_data,
        data_out_7
    );

    wr_en_aux(0) <= '1' when reg_write_address="000" and write_enable='1' else
                            '0';

    wr_en_aux(1) <= '1' when reg_write_address="001" and write_enable='1' else
                            '0';  

    wr_en_aux(2) <= '1' when reg_write_address="010" and write_enable='1' else
                            '0';  

    wr_en_aux(3) <= '1' when reg_write_address="011" and write_enable='1' else
                            '0';

    wr_en_aux(4) <= '1' when reg_write_address="100" and write_enable='1' else
                            '0';  

    wr_en_aux(5) <= '1' when reg_write_address="101" and write_enable='1' else
                            '0';  
    
    wr_en_aux(6) <= '1' when reg_write_address="110" and write_enable='1' else
                            '0';  

    wr_en_aux(7) <= '1' when reg_write_address="111" and write_enable='1' else
                            '0';   

    read_register_1_data <= data_out_0 when (read_register_1="000" and read_enable='1') else
                            data_out_1 when (read_register_1="001" and read_enable='1') else
                            data_out_2 when (read_register_1="010" and read_enable='1') else
                            data_out_3 when (read_register_1="011" and read_enable='1') else
                            data_out_4 when (read_register_1="100" and read_enable='1') else
                            data_out_5 when (read_register_1="101" and read_enable='1') else
                            data_out_6 when (read_register_1="110" and read_enable='1') else
                            data_out_7 when (read_register_1="111" and read_enable='1') else
                            "0000000000000000";
    
    read_register_2_data <= data_out_0 when (read_register_2="000" and read_enable='1') else
                            data_out_1 when (read_register_2="001" and read_enable='1') else
                            data_out_2 when (read_register_2="010" and read_enable='1') else
                            data_out_3 when (read_register_2="011" and read_enable='1') else
                            data_out_4 when (read_register_2="100" and read_enable='1') else
                            data_out_5 when (read_register_2="101" and read_enable='1') else
                            data_out_6 when (read_register_2="110" and read_enable='1') else
                            data_out_7 when (read_register_2="111" and read_enable='1') else
                            "0000000000000000";
end architecture;
