--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2023.2.2 (win64) Build 4126759 Thu Feb  8 23:53:51 MST 2024
--Date        : Tue Oct 29 16:53:51 2024
--Host        : DESKTOP-JHBES8T running 64-bit major release  (build 9200)
--Command     : generate_target env_extr_bd_wrapper.bd
--Design      : env_extr_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity env_extr_bd_wrapper is
  port (
    clk : in STD_LOGIC;
    hilbert_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hilbert_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    homo_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    homo_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    psd_m_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    psd_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    soc_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    steto_in_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    steto_in_axis_tready : out STD_LOGIC_VECTOR ( 0 to 0 );
    steto_in_axis_tvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    swt_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    swt_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end env_extr_bd_wrapper;

architecture STRUCTURE of env_extr_bd_wrapper is
  component env_extr_bd is
  port (
    clk : in STD_LOGIC;
    soc_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    hilbert_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hilbert_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    homo_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    homo_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    psd_m_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    psd_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    steto_in_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    steto_in_axis_tvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    steto_in_axis_tready : out STD_LOGIC_VECTOR ( 0 to 0 );
    swt_m_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    swt_m_data_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component env_extr_bd;
begin
env_extr_bd_i: component env_extr_bd
     port map (
      clk => clk,
      hilbert_m_data_tdata(15 downto 0) => hilbert_m_data_tdata(15 downto 0),
      hilbert_m_data_tvalid(0) => hilbert_m_data_tvalid(0),
      homo_m_data_tdata(15 downto 0) => homo_m_data_tdata(15 downto 0),
      homo_m_data_tvalid(0) => homo_m_data_tvalid(0),
      psd_m_data_tdata(31 downto 0) => psd_m_data_tdata(31 downto 0),
      psd_m_data_tvalid(0) => psd_m_data_tvalid(0),
      soc_tready(0) => soc_tready(0),
      steto_in_axis_tdata(15 downto 0) => steto_in_axis_tdata(15 downto 0),
      steto_in_axis_tready(0) => steto_in_axis_tready(0),
      steto_in_axis_tvalid(0) => steto_in_axis_tvalid(0),
      swt_m_data_tdata(15 downto 0) => swt_m_data_tdata(15 downto 0),
      swt_m_data_tvalid(0) => swt_m_data_tvalid(0)
    );
end STRUCTURE;
