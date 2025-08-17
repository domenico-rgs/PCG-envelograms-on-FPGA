-- (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- (c) Copyright 2022-2024 Advanced Micro Devices, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: User_Company:VMC:env_extr:1.0
-- IP Revision: 361126387

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY xil_defaultlib;
USE xil_defaultlib.env_extr;

ENTITY env_extr_bd_env_extr_1_0 IS
  PORT (
    soc_tready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    steto_in_axis_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    steto_in_axis_tvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    clk : IN STD_LOGIC;
    steto_in_axis_tready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    hilbert_m_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    hilbert_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    homo_m_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    homo_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    psd_m_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    psd_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    swt_m_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    swt_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END env_extr_bd_env_extr_1_0;

ARCHITECTURE env_extr_bd_env_extr_1_0_arch OF env_extr_bd_env_extr_1_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF env_extr_bd_env_extr_1_0_arch: ARCHITECTURE IS "yes";
  COMPONENT env_extr IS
    PORT (
      soc_tready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      steto_in_axis_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      steto_in_axis_tvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      clk : IN STD_LOGIC;
      steto_in_axis_tready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      hilbert_m_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      hilbert_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      homo_m_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      homo_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      psd_m_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      psd_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      swt_m_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      swt_m_data_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
  END COMPONENT env_extr;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF env_extr_bd_env_extr_1_0_arch: ARCHITECTURE IS "env_extr,Vivado 2023.2.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF env_extr_bd_env_extr_1_0_arch : ARCHITECTURE IS "env_extr_bd_env_extr_1_0,env_extr,{}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF env_extr_bd_env_extr_1_0_arch: ARCHITECTURE IS "sysgen";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk: SIGNAL IS "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF hilbert_m_data:homo_m_data:psd_m_data:steto_in_axis:swt_m_data, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN env_extr_bd_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 clk CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF hilbert_m_data_tdata: SIGNAL IS "XIL_INTERFACENAME hilbert_m_data, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} m" & 
"aximum {}} value 13} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN env_extr_bd_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF hilbert_m_data_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 hilbert_m_data TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF hilbert_m_data_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 hilbert_m_data TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF homo_m_data_tdata: SIGNAL IS "XIL_INTERFACENAME homo_m_data, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maxi" & 
"mum {}} value 14} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN env_extr_bd_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF homo_m_data_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 homo_m_data TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF homo_m_data_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 homo_m_data TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF psd_m_data_tdata: SIGNAL IS "XIL_INTERFACENAME psd_m_data, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maxim" & 
"um {}} value 27} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN env_extr_bd_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF psd_m_data_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 psd_m_data TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF psd_m_data_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 psd_m_data TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF soc_tready: SIGNAL IS "XIL_INTERFACENAME soc_tready, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum" & 
" {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  ATTRIBUTE X_INTERFACE_INFO OF soc_tready: SIGNAL IS "xilinx.com:signal:data:1.0 soc_tready DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF steto_in_axis_tdata: SIGNAL IS "XIL_INTERFACENAME steto_in_axis, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} ma" & 
"ximum {}} value 15} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN env_extr_bd_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF steto_in_axis_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 steto_in_axis TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF steto_in_axis_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 steto_in_axis TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF steto_in_axis_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 steto_in_axis TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF swt_m_data_tdata: SIGNAL IS "XIL_INTERFACENAME swt_m_data, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maxim" & 
"um {}} value 8} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN env_extr_bd_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF swt_m_data_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 swt_m_data TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF swt_m_data_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 swt_m_data TVALID";
BEGIN
  U0 : env_extr
    PORT MAP (
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
END env_extr_bd_env_extr_1_0_arch;
