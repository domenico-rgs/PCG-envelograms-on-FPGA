// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2.2 (win64) Build 4126759 Thu Feb  8 23:53:51 MST 2024
// Date        : Tue Oct 29 17:02:40 2024
// Host        : DESKTOP-JHBES8T running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/windows/Desktop/HSS/Q16_40840_optim/code2/ip/env_extr/src/ip_catalog/env_extr.gen/sources_1/bd/env_extr_bd/ip/env_extr_bd_env_extr_1_0/env_extr_bd_env_extr_1_0_stub.v
// Design      : env_extr_bd_env_extr_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "env_extr,Vivado 2023.2.2" *)
module env_extr_bd_env_extr_1_0(soc_tready, steto_in_axis_tdata, 
  steto_in_axis_tvalid, clk, steto_in_axis_tready, hilbert_m_data_tdata, 
  hilbert_m_data_tvalid, homo_m_data_tdata, homo_m_data_tvalid, psd_m_data_tdata, 
  psd_m_data_tvalid, swt_m_data_tdata, swt_m_data_tvalid)
/* synthesis syn_black_box black_box_pad_pin="soc_tready[0:0],steto_in_axis_tdata[15:0],steto_in_axis_tvalid[0:0],steto_in_axis_tready[0:0],hilbert_m_data_tdata[15:0],hilbert_m_data_tvalid[0:0],homo_m_data_tdata[15:0],homo_m_data_tvalid[0:0],psd_m_data_tdata[31:0],psd_m_data_tvalid[0:0],swt_m_data_tdata[15:0],swt_m_data_tvalid[0:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input [0:0]soc_tready;
  input [15:0]steto_in_axis_tdata;
  input [0:0]steto_in_axis_tvalid;
  input clk /* synthesis syn_isclock = 1 */;
  output [0:0]steto_in_axis_tready;
  output [15:0]hilbert_m_data_tdata;
  output [0:0]hilbert_m_data_tvalid;
  output [15:0]homo_m_data_tdata;
  output [0:0]homo_m_data_tvalid;
  output [31:0]psd_m_data_tdata;
  output [0:0]psd_m_data_tvalid;
  output [15:0]swt_m_data_tdata;
  output [0:0]swt_m_data_tvalid;
endmodule
