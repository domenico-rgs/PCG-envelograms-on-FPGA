-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity env_extr_stub is
  port (
    soc_tready : in std_logic_vector( 1-1 downto 0 );
    steto_in_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    steto_in_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    steto_in_axis_tready : out std_logic_vector( 1-1 downto 0 );
    hilbert_m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    hilbert_m_data_tvalid : out std_logic_vector( 1-1 downto 0 );
    homo_m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    homo_m_data_tvalid : out std_logic_vector( 1-1 downto 0 );
    psd_m_data_tdata : out std_logic_vector( 32-1 downto 0 );
    psd_m_data_tvalid : out std_logic_vector( 1-1 downto 0 );
    swt_m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    swt_m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_stub;
architecture structural of env_extr_stub is 
begin
  sysgen_dut : entity xil_defaultlib.env_extr_0 
  port map (
    soc_tready => soc_tready,
    steto_in_axis_tdata => steto_in_axis_tdata,
    steto_in_axis_tvalid => steto_in_axis_tvalid,
    clk => clk,
    steto_in_axis_tready => steto_in_axis_tready,
    hilbert_m_data_tdata => hilbert_m_data_tdata,
    hilbert_m_data_tvalid => hilbert_m_data_tvalid,
    homo_m_data_tdata => homo_m_data_tdata,
    homo_m_data_tvalid => homo_m_data_tvalid,
    psd_m_data_tdata => psd_m_data_tdata,
    psd_m_data_tvalid => psd_m_data_tvalid,
    swt_m_data_tdata => swt_m_data_tdata,
    swt_m_data_tvalid => swt_m_data_tvalid
  );
end structural;
