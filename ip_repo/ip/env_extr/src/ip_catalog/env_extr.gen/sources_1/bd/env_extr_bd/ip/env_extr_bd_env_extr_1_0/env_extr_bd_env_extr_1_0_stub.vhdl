-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.2.2 (win64) Build 4126759 Thu Feb  8 23:53:51 MST 2024
-- Date        : Tue Oct 29 17:02:40 2024
-- Host        : DESKTOP-JHBES8T running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/windows/Desktop/HSS/Q16_40840_optim/code2/ip/env_extr/src/ip_catalog/env_extr.gen/sources_1/bd/env_extr_bd/ip/env_extr_bd_env_extr_1_0/env_extr_bd_env_extr_1_0_stub.vhdl
-- Design      : env_extr_bd_env_extr_1_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity env_extr_bd_env_extr_1_0 is
  Port ( 
    soc_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    steto_in_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    steto_in_axis_tvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC;
    steto_in_axis_tready : out STD_LOGIC_VECTOR ( 0 to 0 );
    hilbert_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hilbert_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    homo_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    homo_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    psd_m_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    psd_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    swt_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    swt_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end env_extr_bd_env_extr_1_0;

architecture stub of env_extr_bd_env_extr_1_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "soc_tready[0:0],steto_in_axis_tdata[15:0],steto_in_axis_tvalid[0:0],clk,steto_in_axis_tready[0:0],hilbert_m_data_tdata[15:0],hilbert_m_data_tvalid[0:0],homo_m_data_tdata[15:0],homo_m_data_tvalid[0:0],psd_m_data_tdata[31:0],psd_m_data_tvalid[0:0],swt_m_data_tdata[15:0],swt_m_data_tvalid[0:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "env_extr,Vivado 2023.2.2";
begin
end;
