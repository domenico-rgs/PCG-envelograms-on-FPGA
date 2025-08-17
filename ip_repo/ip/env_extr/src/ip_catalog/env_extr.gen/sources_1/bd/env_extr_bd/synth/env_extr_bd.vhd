--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2023.2.2 (win64) Build 4126759 Thu Feb  8 23:53:51 MST 2024
--Date        : Tue Oct 29 16:53:55 2024
--Host        : DESKTOP-JHBES8T running 64-bit major release  (build 9200)
--Command     : generate_target env_extr_bd.bd
--Design      : env_extr_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity env_extr_bd is
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of env_extr_bd : entity is "env_extr_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=env_extr_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of env_extr_bd : entity is "env_extr_bd.hwdef";
end env_extr_bd;

architecture STRUCTURE of env_extr_bd is
  component env_extr_bd_env_extr_1_0 is
  port (
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
  end component env_extr_bd_env_extr_1_0;
  signal clk_1 : STD_LOGIC;
  signal env_extr_1_hilbert_m_data_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal env_extr_1_hilbert_m_data_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal env_extr_1_homo_m_data_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal env_extr_1_homo_m_data_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal env_extr_1_psd_m_data_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal env_extr_1_psd_m_data_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal env_extr_1_swt_m_data_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal env_extr_1_swt_m_data_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal soc_tready_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal steto_in_axis_1_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal steto_in_axis_1_TREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal steto_in_axis_1_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_BUSIF hilbert_m_data:homo_m_data:psd_m_data:steto_in_axis:swt_m_data, CLK_DOMAIN env_extr_bd_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of hilbert_m_data_tdata : signal is "xilinx.com:interface:axis:1.0 hilbert_m_data TDATA";
  attribute X_INTERFACE_PARAMETER of hilbert_m_data_tdata : signal is "XIL_INTERFACENAME hilbert_m_data, CLK_DOMAIN env_extr_bd_clk, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 13} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, PHASE 0.0, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of hilbert_m_data_tvalid : signal is "xilinx.com:interface:axis:1.0 hilbert_m_data TVALID";
  attribute X_INTERFACE_INFO of homo_m_data_tdata : signal is "xilinx.com:interface:axis:1.0 homo_m_data TDATA";
  attribute X_INTERFACE_PARAMETER of homo_m_data_tdata : signal is "XIL_INTERFACENAME homo_m_data, CLK_DOMAIN env_extr_bd_clk, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 14} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, PHASE 0.0, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of homo_m_data_tvalid : signal is "xilinx.com:interface:axis:1.0 homo_m_data TVALID";
  attribute X_INTERFACE_INFO of psd_m_data_tdata : signal is "xilinx.com:interface:axis:1.0 psd_m_data TDATA";
  attribute X_INTERFACE_PARAMETER of psd_m_data_tdata : signal is "XIL_INTERFACENAME psd_m_data, CLK_DOMAIN env_extr_bd_clk, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 27} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, PHASE 0.0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of psd_m_data_tvalid : signal is "xilinx.com:interface:axis:1.0 psd_m_data TVALID";
  attribute X_INTERFACE_INFO of soc_tready : signal is "xilinx.com:signal:data:1.0 DATA.SOC_TREADY DATA";
  attribute X_INTERFACE_PARAMETER of soc_tready : signal is "XIL_INTERFACENAME DATA.SOC_TREADY, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of steto_in_axis_tdata : signal is "xilinx.com:interface:axis:1.0 steto_in_axis TDATA";
  attribute X_INTERFACE_PARAMETER of steto_in_axis_tdata : signal is "XIL_INTERFACENAME steto_in_axis, CLK_DOMAIN env_extr_bd_clk, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 15} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, PHASE 0.0, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of steto_in_axis_tready : signal is "xilinx.com:interface:axis:1.0 steto_in_axis TREADY";
  attribute X_INTERFACE_INFO of steto_in_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 steto_in_axis TVALID";
  attribute X_INTERFACE_INFO of swt_m_data_tdata : signal is "xilinx.com:interface:axis:1.0 swt_m_data TDATA";
  attribute X_INTERFACE_PARAMETER of swt_m_data_tdata : signal is "XIL_INTERFACENAME swt_m_data, CLK_DOMAIN env_extr_bd_clk, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 8} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, PHASE 0.0, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of swt_m_data_tvalid : signal is "xilinx.com:interface:axis:1.0 swt_m_data TVALID";
begin
  clk_1 <= clk;
  hilbert_m_data_tdata(15 downto 0) <= env_extr_1_hilbert_m_data_TDATA(15 downto 0);
  hilbert_m_data_tvalid(0) <= env_extr_1_hilbert_m_data_TVALID(0);
  homo_m_data_tdata(15 downto 0) <= env_extr_1_homo_m_data_TDATA(15 downto 0);
  homo_m_data_tvalid(0) <= env_extr_1_homo_m_data_TVALID(0);
  psd_m_data_tdata(31 downto 0) <= env_extr_1_psd_m_data_TDATA(31 downto 0);
  psd_m_data_tvalid(0) <= env_extr_1_psd_m_data_TVALID(0);
  soc_tready_1(0) <= soc_tready(0);
  steto_in_axis_1_TDATA(15 downto 0) <= steto_in_axis_tdata(15 downto 0);
  steto_in_axis_1_TVALID(0) <= steto_in_axis_tvalid(0);
  steto_in_axis_tready(0) <= steto_in_axis_1_TREADY(0);
  swt_m_data_tdata(15 downto 0) <= env_extr_1_swt_m_data_TDATA(15 downto 0);
  swt_m_data_tvalid(0) <= env_extr_1_swt_m_data_TVALID(0);
env_extr_1: component env_extr_bd_env_extr_1_0
     port map (
      clk => clk_1,
      hilbert_m_data_tdata(15 downto 0) => env_extr_1_hilbert_m_data_TDATA(15 downto 0),
      hilbert_m_data_tvalid(0) => env_extr_1_hilbert_m_data_TVALID(0),
      homo_m_data_tdata(15 downto 0) => env_extr_1_homo_m_data_TDATA(15 downto 0),
      homo_m_data_tvalid(0) => env_extr_1_homo_m_data_TVALID(0),
      psd_m_data_tdata(31 downto 0) => env_extr_1_psd_m_data_TDATA(31 downto 0),
      psd_m_data_tvalid(0) => env_extr_1_psd_m_data_TVALID(0),
      soc_tready(0) => soc_tready_1(0),
      steto_in_axis_tdata(15 downto 0) => steto_in_axis_1_TDATA(15 downto 0),
      steto_in_axis_tready(0) => steto_in_axis_1_TREADY(0),
      steto_in_axis_tvalid(0) => steto_in_axis_1_TVALID(0),
      swt_m_data_tdata(15 downto 0) => env_extr_1_swt_m_data_TDATA(15 downto 0),
      swt_m_data_tvalid(0) => env_extr_1_swt_m_data_TVALID(0)
    );
end STRUCTURE;
