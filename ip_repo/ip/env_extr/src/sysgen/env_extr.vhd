-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/FILTERING/steto_in_axis
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_steto_in_axis is
  port (
    in3 : in std_logic;
    steto_in_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    steto_in_axis_tvalid : in std_logic_vector( 1-1 downto 0 )
  );
end env_extr_steto_in_axis;
architecture structural of env_extr_steto_in_axis is 
  signal fifo_full_net : std_logic;
  signal steto_in_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal steto_in_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
begin
  fifo_full_net <= in3;
  steto_in_axis_tdata_net <= steto_in_axis_tdata;
  steto_in_axis_tvalid_net <= steto_in_axis_tvalid;
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/FILTERING
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_filtering is
  port (
    m_data_tready_1 : in std_logic;
    m_data_tready_2 : in std_logic;
    m_data_tready_3 : in std_logic;
    soc_tready : in std_logic_vector( 1-1 downto 0 );
    steto_in_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    steto_in_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_25000 : in std_logic;
    m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    m_data_tvalid : out std_logic;
    steto_in_axis_tready : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_filtering;
architecture structural of env_extr_filtering is 
  signal fir_compiler_7_2_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal steto_in_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal fifo_empty_net : std_logic;
  signal inverter_op_net : std_logic;
  signal we_ce_net : std_logic;
  signal fir_compiler_7_2_m_axis_data_tvalid_net : std_logic;
  signal psd_fifo_full : std_logic;
  signal hilbert_fifo_full : std_logic;
  signal clk_net : std_logic;
  signal fir_compiler_7_2_s_axis_data_tready_net : std_logic;
  signal swt_fifo_full : std_logic;
  signal logical_y_net : std_logic;
  signal fifo_full_net : std_logic_vector( 1-1 downto 0 );
  signal soc_tready_net : std_logic_vector( 1-1 downto 0 );
  signal steto_in_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
begin
  m_data_tdata <= fir_compiler_7_2_m_axis_data_tdata_real_net;
  m_data_tvalid <= fir_compiler_7_2_m_axis_data_tvalid_net;
  psd_fifo_full <= m_data_tready_1;
  hilbert_fifo_full <= m_data_tready_2;
  swt_fifo_full <= m_data_tready_3;
  soc_tready_net <= soc_tready;
  steto_in_axis_tdata_net <= steto_in_axis_tdata;
  steto_in_axis_tready <= fifo_full_net;
  steto_in_axis_tvalid_net <= steto_in_axis_tvalid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_25000;
  steto_in_axis : entity xil_defaultlib.env_extr_steto_in_axis 
  port map (
    in3 => fifo_full_net(0),
    steto_in_axis_tdata => steto_in_axis_tdata_net,
    steto_in_axis_tvalid => steto_in_axis_tvalid_net
  );
  fifo : entity xil_defaultlib.env_extr_xlfifogen_u 
  generic map (
    core_name0 => "env_extr_fifo_generator_i2",
    data_count_width => 8,
    data_width => 16,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => false,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    rst => '0',
    din => steto_in_axis_tdata_net,
    we => steto_in_axis_tvalid_net(0),
    re => fir_compiler_7_2_s_axis_data_tready_net,
    clk => clk_net,
    ce => ce_net,
    we_ce => we_ce_net,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net(0)
  );
  fir_compiler_7_2 : entity xil_defaultlib.xlfir_compiler_5373f2eb5aed6bab468b466770788779 
  port map (
    s_axis_data_tvalid => inverter_op_net,
    s_axis_data_tdata_real => fifo_dout_net,
    m_axis_data_tready => logical_y_net,
    src_clk => clk_net,
    src_ce => ce_net,
    clk => clk_net,
    ce => ce_net,
    s_axis_data_tready => fir_compiler_7_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_m_axis_data_tdata_real_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo_empty_net,
    clk => clk_net,
    ce => ce_net,
    op(0) => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_9183785409 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => psd_fifo_full,
    d1(0) => hilbert_fifo_full,
    d2(0) => swt_fifo_full,
    y(0) => logical_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HILBERT
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_hilbert is
  port (
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic;
    homo_fifo_full_tready : in std_logic;
    m_data_ready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_25000 : in std_logic;
    ce_25000 : in std_logic;
    m_data_tdata : out std_logic_vector( 24-1 downto 0 );
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_data_tready : out std_logic;
    hilbert_m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    hilbert_m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_hilbert;
architecture structural of env_extr_hilbert is 
  signal cordic_sqrt_m_axis_dout_tdata_real_net : std_logic_vector( 24-1 downto 0 );
  signal ce_net : std_logic;
  signal mult1_p_net : std_logic_vector( 24-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fast_fourier_transform_9_1_fft_s_axis_data_tready_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal we_ce_net : std_logic;
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal fifo3_full_net : std_logic;
  signal register1_q_net : std_logic_vector( 16-1 downto 0 );
  signal mult_p_net : std_logic_vector( 24-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal soc_tready_net : std_logic_vector( 1-1 downto 0 );
  signal fast_fourier_transform_9_2_ifft_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 28-1 downto 0 );
  signal clk_net : std_logic;
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal fast_fourier_transform_9_2_ifft_s_axis_data_tready_net : std_logic_vector( 1-1 downto 0 );
  signal cmult3_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal fast_fourier_transform_9_2_ifft_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 28-1 downto 0 );
  signal fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 28-1 downto 0 );
  signal fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 28-1 downto 0 );
  signal cmult6_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult4_p_net : std_logic_vector( 30-1 downto 0 );
  signal cmult5_p_net : std_logic_vector( 30-1 downto 0 );
  signal delay6_q_net : std_logic;
  signal mux3_y_net : std_logic_vector( 30-1 downto 0 );
  signal cordic_sqrt_m_axis_dout_tvalid_net : std_logic;
  signal mux2_y_net : std_logic_vector( 30-1 downto 0 );
  signal constant9_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant10_op_net : std_logic_vector( 11-1 downto 0 );
  signal concat1_y_net : std_logic_vector( 2-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 12-1 downto 0 );
  signal sel2_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant11_op_net : std_logic_vector( 16-1 downto 0 );
  signal constant5_op_net : std_logic_vector( 4-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal sel3_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant12_op_net : std_logic_vector( 7-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 16-1 downto 0 );
  signal constant7_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter4_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal fast_fourier_transform_9_1_fft_m_axis_data_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal fast_fourier_transform_9_1_fft_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal counter2_op_net : std_logic_vector( 7-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 16-1 downto 0 );
  signal fir_polyphase_decimator_4_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal counter1_op_net : std_logic_vector( 4-1 downto 0 );
  signal fir_polyphase_decimator_4_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal fifo_full_net : std_logic;
  signal fir_polyphase_decimator_4_s_axis_data_tready_net : std_logic;
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 28-1 downto 0 );
  signal fast_fourier_transform_9_2_ifft_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal logical6_y_net : std_logic;
  signal logical5_y_net : std_logic;
  signal delay7_q_net : std_logic_vector( 28-1 downto 0 );
  signal fifo_empty_net_x0 : std_logic;
  signal fast_fourier_transform_9_1_fft_m_axis_data_tuser_xk_index_net : std_logic_vector( 11-1 downto 0 );
  signal fast_fourier_transform_9_1_fft_event_data_in_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_s_axis_config_tready_net : std_logic;
  signal fast_fourier_transform_9_1_fft_event_tlast_missing_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_m_axis_data_tlast_net : std_logic;
  signal fast_fourier_transform_9_1_fft_event_status_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_event_tlast_unexpected_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_event_tlast_missing_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_event_data_in_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_event_status_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_event_frame_started_net : std_logic;
  signal fast_fourier_transform_9_2_ifft_event_data_out_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_1_fft_s_axis_config_tready_net : std_logic;
  signal fast_fourier_transform_9_1_fft_event_frame_started_net : std_logic;
  signal fast_fourier_transform_9_1_fft_event_data_out_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_1_fft_event_tlast_unexpected_net : std_logic;
  signal relational_op_net : std_logic;
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational8_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter2_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal c2 : std_logic_vector( 1-1 downto 0 );
  signal c0 : std_logic_vector( 1-1 downto 0 );
  signal c1 : std_logic_vector( 1-1 downto 0 );
begin
  m_data_tdata <= cordic_sqrt_m_axis_dout_tdata_real_net;
  m_data_tvalid <= logical3_y_net;
  m_data_tready <= fast_fourier_transform_9_1_fft_s_axis_data_tready_net;
  fifo_dout_net <= s_data_tdata;
  fifo_empty_net <= s_data_tvalid;
  fifo3_full_net <= homo_fifo_full_tready;
  soc_tready_net <= m_data_ready;
  hilbert_m_data_tdata <= register1_q_net;
  hilbert_m_data_tvalid <= logical8_y_net;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_25000;
  we_ce_net <= ce_25000;
  addsub : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 23,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 23,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "env_extr_c_addsub_v12_0_i0",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlUnsigned,
    s_bin_pt => 23,
    s_width => 24
  )
  port map (
    clr => '0',
    a => mult_p_net,
    b => mult1_p_net,
    en => delay5_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    s => addsub_s_net
  );
  cmult : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i0",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fifo_dout_net,
    en(0) => fast_fourier_transform_9_1_fft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 28,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 28,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 44,
    core_name0 => "env_extr_mult_gen_v12_0_i1",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fast_fourier_transform_9_2_ifft_m_axis_data_tdata_xn_re_0_net,
    en => delay5_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult1_p_net
  );
  cmult2 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 30,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 30,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 46,
    core_name0 => "env_extr_mult_gen_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux2_y_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult2_p_net
  );
  cmult3 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 28,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 28,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 44,
    core_name0 => "env_extr_mult_gen_v12_0_i1",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fast_fourier_transform_9_2_ifft_m_axis_data_tdata_xn_im_0_net,
    en => delay5_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult3_p_net
  );
  cmult4 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 28,
    b_bin_pt => 0,
    c_a_type => 0,
    c_a_width => 28,
    c_b_type => 1,
    c_b_width => 2,
    c_output_width => 30,
    core_name0 => "env_extr_mult_gen_v12_0_i3",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 2,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 30,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_re_0_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult4_p_net
  );
  cmult5 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 28,
    b_bin_pt => 0,
    c_a_type => 0,
    c_a_width => 28,
    c_b_type => 1,
    c_b_width => 2,
    c_output_width => 30,
    core_name0 => "env_extr_mult_gen_v12_0_i3",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 2,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 30,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_im_0_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult5_p_net
  );
  cmult6 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 30,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 30,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 46,
    core_name0 => "env_extr_mult_gen_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux3_y_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult6_p_net
  );
  cordic_sqrt : entity xil_defaultlib.xlcordic_feaafaf9df306a3526b6335cdfaa7bc0 
  port map (
    s_axis_cartesian_tvalid => delay6_q_net,
    s_axis_cartesian_tdata_real => addsub_s_net,
    en => delay5_q_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    m_axis_dout_tvalid => cordic_sqrt_m_axis_dout_tvalid_net,
    m_axis_dout_tdata_real => cordic_sqrt_m_axis_dout_tdata_real_net
  );
  concat1 : entity xil_defaultlib.sysgen_concat_ca27d70a25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => sel3_y_net,
    in1 => sel2_y_net,
    y => concat1_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_91ade5cb7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_dd32a5a1de 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant10 : entity xil_defaultlib.sysgen_constant_066e3ab4b5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant10_op_net
  );
  constant11 : entity xil_defaultlib.sysgen_constant_943f22f869 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant11_op_net
  );
  constant12 : entity xil_defaultlib.sysgen_constant_7a7f00444b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant12_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_dd32a5a1de 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_943f22f869 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  constant5 : entity xil_defaultlib.sysgen_constant_51253cd5ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant5_op_net
  );
  constant7 : entity xil_defaultlib.sysgen_constant_dd32a5a1de 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant7_op_net
  );
  constant9 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant9_op_net
  );
  counter : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter_op_net
  );
  counter1 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i1",
    op_arith => xlUnsigned,
    op_width => 4
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical4_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter1_op_net
  );
  counter2 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i2",
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    clr => '0',
    rst => inverter4_op_net,
    en => logical8_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter2_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_1_fft_m_axis_data_tvalid_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => inverter_op_net,
    en => fast_fourier_transform_9_1_fft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_1_fft_m_axis_data_tlast_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_4_m_axis_data_tvalid_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_4_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 128,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => logical1_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 5,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_2_ifft_m_axis_data_tvalid_net,
    en => delay5_q_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q(0) => delay6_q_net
  );
  delay7 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 28
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_re_0_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 28
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_im_0_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => logical1_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay9_q_net
  );
  fifo : entity xil_defaultlib.env_extr_xlfifogen_u 
  generic map (
    core_name0 => "env_extr_fifo_generator_i3",
    data_count_width => 8,
    data_width => 24,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => false,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    rst => '0',
    din => cordic_sqrt_m_axis_dout_tdata_real_net,
    we => logical5_y_net,
    re => logical1_y_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    we_ce => ce_net,
    re_ce => ce_net,
    dout => fifo_dout_net_x0,
    empty => fifo_empty_net_x0,
    full => fifo_full_net
  );
  fir_polyphase_decimator_4 : entity xil_defaultlib.xlfir_compiler_f7731ebff8781dce4a64f31711c75652 
  port map (
    s_axis_data_tvalid => logical6_y_net,
    s_axis_data_tdata_real => fifo_dout_net_x0,
    en => delay9_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_data_tready => fir_polyphase_decimator_4_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_polyphase_decimator_4_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_polyphase_decimator_4_m_axis_data_tdata_real_net
  );
  fast_fourier_transform_9_1_fft : entity xil_defaultlib.xlfast_fourier_transform_ecbdf524b4d4dd3a6b949938283653e4 
  port map (
    s_axis_config_tdata_fwd_inv => constant1_op_net,
    s_axis_config_tvalid => constant2_op_net(0),
    s_axis_data_tdata_xn_im_0 => constant4_op_net,
    s_axis_data_tdata_xn_re_0 => cmult_p_net,
    s_axis_data_tvalid => delay1_q_net(0),
    s_axis_data_tlast => relational_op_net,
    m_axis_data_tready => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_config_tready => fast_fourier_transform_9_1_fft_s_axis_config_tready_net,
    s_axis_data_tready => fast_fourier_transform_9_1_fft_s_axis_data_tready_net,
    m_axis_data_tdata_xn_im_0 => fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_im_0_net,
    m_axis_data_tdata_xn_re_0 => fast_fourier_transform_9_1_fft_m_axis_data_tdata_xn_re_0_net,
    m_axis_data_tuser_xk_index => fast_fourier_transform_9_1_fft_m_axis_data_tuser_xk_index_net,
    m_axis_data_tvalid => fast_fourier_transform_9_1_fft_m_axis_data_tvalid_net(0),
    m_axis_data_tlast => fast_fourier_transform_9_1_fft_m_axis_data_tlast_net(0),
    event_frame_started => fast_fourier_transform_9_1_fft_event_frame_started_net,
    event_tlast_unexpected => fast_fourier_transform_9_1_fft_event_tlast_unexpected_net,
    event_tlast_missing => fast_fourier_transform_9_1_fft_event_tlast_missing_net,
    event_data_in_channel_halt => fast_fourier_transform_9_1_fft_event_data_in_channel_halt_net,
    event_status_channel_halt => fast_fourier_transform_9_1_fft_event_status_channel_halt_net,
    event_data_out_channel_halt => fast_fourier_transform_9_1_fft_event_data_out_channel_halt_net
  );
  fast_fourier_transform_9_2_ifft : entity xil_defaultlib.xlfast_fourier_transform_df07c473e4ae5fc721e9ae943a45ae82 
  port map (
    s_axis_config_tdata_fwd_inv => constant3_op_net,
    s_axis_config_tvalid => constant7_op_net(0),
    s_axis_data_tdata_xn_im_0 => cmult2_p_net,
    s_axis_data_tdata_xn_re_0 => cmult6_p_net,
    s_axis_data_tvalid => delay_q_net(0),
    s_axis_data_tlast => delay2_q_net(0),
    m_axis_data_tready => delay5_q_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_config_tready => fast_fourier_transform_9_2_ifft_s_axis_config_tready_net,
    s_axis_data_tready => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net(0),
    m_axis_data_tdata_xn_im_0 => fast_fourier_transform_9_2_ifft_m_axis_data_tdata_xn_im_0_net,
    m_axis_data_tdata_xn_re_0 => fast_fourier_transform_9_2_ifft_m_axis_data_tdata_xn_re_0_net,
    m_axis_data_tvalid => fast_fourier_transform_9_2_ifft_m_axis_data_tvalid_net(0),
    m_axis_data_tlast => fast_fourier_transform_9_2_ifft_m_axis_data_tlast_net,
    event_frame_started => fast_fourier_transform_9_2_ifft_event_frame_started_net,
    event_tlast_unexpected => fast_fourier_transform_9_2_ifft_event_tlast_unexpected_net,
    event_tlast_missing => fast_fourier_transform_9_2_ifft_event_tlast_missing_net,
    event_data_in_channel_halt => fast_fourier_transform_9_2_ifft_event_data_in_channel_halt_net,
    event_status_channel_halt => fast_fourier_transform_9_2_ifft_event_status_channel_halt_net,
    event_data_out_channel_halt => fast_fourier_transform_9_2_ifft_event_data_out_channel_halt_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo_empty_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo3_full_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter1_op_net
  );
  inverter2 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo_empty_net_x0,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter2_op_net
  );
  inverter4 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip => soc_tready_net,
    clk => clk_net,
    ce => we_ce_net,
    op => inverter4_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1(0) => fast_fourier_transform_9_1_fft_s_axis_data_tready_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical2_y_net,
    d1 => inverter1_op_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => relational8_op_net,
    y => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => cordic_sqrt_m_axis_dout_tvalid_net,
    d1 => delay5_q_net,
    y => logical3_y_net
  );
  logical4 : entity xil_defaultlib.sysgen_logical_46ddf42584 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => fir_polyphase_decimator_4_m_axis_data_tvalid_net,
    d2 => relational1_op_net,
    y => logical4_y_net
  );
  logical5 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => cordic_sqrt_m_axis_dout_tvalid_net,
    d1 => delay5_q_net,
    y(0) => logical5_y_net
  );
  logical6 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter2_op_net,
    d1 => logical1_y_net,
    y(0) => logical6_y_net
  );
  logical8 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => register_q_net,
    d1 => logical1_y_net,
    y => logical8_y_net
  );
  mult : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i4",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 23,
    p_width => 24,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => cmult3_p_net,
    b => cmult3_p_net,
    en => delay5_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i4",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 23,
    p_width => 24,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => cmult1_p_net,
    b => cmult1_p_net,
    en => delay5_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mux2 : entity xil_defaultlib.sysgen_mux_2610cccfb0 
  port map (
    clr => '0',
    sel => concat1_y_net,
    d0 => delay8_q_net,
    d1 => cmult5_p_net,
    d2 => constant11_op_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => mux2_y_net
  );
  mux3 : entity xil_defaultlib.sysgen_mux_2610cccfb0 
  port map (
    clr => '0',
    sel => concat1_y_net,
    d0 => delay7_q_net,
    d1 => cmult4_p_net,
    d2 => constant11_op_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => mux3_y_net
  );
  register_x0 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => delay3_q_net,
    rst => relational1_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register_q_net
  );
  register1 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    d => delay4_q_net,
    rst => relational1_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register1_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_aeeadfefdb 
  port map (
    clr => '0',
    a => counter_op_net,
    b => constant_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op(0) => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_27403e1f5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter1_op_net,
    b => constant5_op_net,
    op => relational1_op_net
  );
  relational8 : entity xil_defaultlib.sysgen_relational_76adedebc4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter2_op_net,
    b => constant12_op_net,
    op => relational8_op_net
  );
  sel2 : entity xil_defaultlib.sysgen_logical_8b7cd53eab 
  port map (
    clr => '0',
    d0 => c0,
    d1 => c1,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => sel2_y_net
  );
  sel3 : entity xil_defaultlib.sysgen_logical_8b7cd53eab 
  port map (
    clr => '0',
    d0 => c0,
    d1 => c2,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => sel3_y_net
  );
  step_fun1 : entity xil_defaultlib.sysgen_relational_0d7d9e6573 
  port map (
    clr => '0',
    a => fast_fourier_transform_9_1_fft_m_axis_data_tuser_xk_index_net,
    b => constant9_op_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => c0
  );
  step_fun2 : entity xil_defaultlib.sysgen_relational_511c4515f5 
  port map (
    clr => '0',
    a => fast_fourier_transform_9_1_fft_m_axis_data_tuser_xk_index_net,
    b => constant10_op_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => c1
  );
  step_fun6 : entity xil_defaultlib.sysgen_relational_8165378c67 
  port map (
    clr => '0',
    a => fast_fourier_transform_9_1_fft_m_axis_data_tuser_xk_index_net,
    b => constant10_op_net,
    en => fast_fourier_transform_9_2_ifft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => c2
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/exp/explarge
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_explarge is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    ce : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 6-1 downto 0 )
  );
end env_extr_explarge;
architecture structural of env_extr_explarge is 
  signal ln2_p_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 6-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal delay2_q_net : std_logic_vector( 6-1 downto 0 );
  signal x1 : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 6-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 6-1 downto 0 );
  signal concat_y_net : std_logic_vector( 2-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 6-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal c1 : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 6-1 downto 0 );
  signal c0 : std_logic_vector( 1-1 downto 0 );
  signal negate1_op_net : std_logic_vector( 8-1 downto 0 );
  signal negate_op_net : std_logic_vector( 17-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 7-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 10-1 downto 0 );
begin
  out1 <= mux_y_net;
  ln2_p_net <= in1;
  logical1_y_net <= ce;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 1,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 6,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 7,
    core_name0 => "env_extr_c_addsub_v12_0_i3",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 7,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 6
  )
  port map (
    clr => '0',
    a => constant2_op_net,
    b => slice_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  concat : entity xil_defaultlib.sysgen_concat_ca27d70a25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => x1,
    in1 => inverter_op_net,
    y => concat_y_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_dd32a5a1de 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 6
  )
  port map (
    rst => '0',
    d => slice_y_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 6
  )
  port map (
    rst => '0',
    d => addsub2_s_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_e6f34be9b2 
  port map (
    clr => '0',
    ip => c0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_8b7cd53eab 
  port map (
    clr => '0',
    d0 => c0,
    d1 => c1,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => x1
  );
  mux : entity xil_defaultlib.sysgen_mux_a511711ca8 
  port map (
    clr => '0',
    sel => concat_y_net,
    d0 => delay1_q_net,
    d1 => slice3_y_net,
    d2 => delay2_q_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  negate : entity xil_defaultlib.sysgen_negate_c494883037 
  port map (
    clr => '0',
    ip => ln2_p_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => negate_op_net
  );
  negate1 : entity xil_defaultlib.sysgen_negate_c0dcd036ea 
  port map (
    clr => '0',
    ip => slice2_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => negate1_op_net
  );
  relational : entity xil_defaultlib.sysgen_relational_de225c4424 
  port map (
    clr => '0',
    a => slice1_y_net,
    b => constant1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => c1
  );
  relational1 : entity xil_defaultlib.sysgen_relational_dd3152b4e9 
  port map (
    clr => '0',
    a => ln2_p_net,
    b => constant1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => c0
  );
  slice : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 10,
    new_msb => 15,
    x_width => 16,
    y_width => 6
  )
  port map (
    x => ln2_p_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 16,
    y_width => 10
  )
  port map (
    x => ln2_p_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 15,
    x_width => 17,
    y_width => 7
  )
  port map (
    x => negate_op_net,
    y => slice2_y_net
  );
  slice3 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 1,
    new_msb => 6,
    x_width => 8,
    y_width => 6
  )
  port map (
    x => negate1_op_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/exp/negative_shifter_2^n1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_negative_shifter_2_n1 is
  port (
    shift_amount : in std_logic_vector( 5-1 downto 0 );
    ce : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    x2_n : out std_logic_vector( 33-1 downto 0 )
  );
end env_extr_negative_shifter_2_n1;
architecture structural of env_extr_negative_shifter_2_n1 is 
  signal shift27_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift29_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift31_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift30_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift26_op_net : std_logic_vector( 33-1 downto 0 );
  signal delay_q_net : std_logic_vector( 5-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 5-1 downto 0 );
  signal constant_op_net : std_logic_vector( 33-1 downto 0 );
  signal mux_y_net : std_logic_vector( 33-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift22_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift23_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift10_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift24_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift11_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift28_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift25_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift14_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift12_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift13_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift16_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift15_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift17_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift18_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift19_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift20_op_net : std_logic_vector( 33-1 downto 0 );
  signal shift21_op_net : std_logic_vector( 33-1 downto 0 );
begin
  x2_n <= mux_y_net;
  delay_q_net_x0 <= shift_amount;
  logical1_y_net <= ce;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_ef1d50e417 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 5
  )
  port map (
    en => '1',
    rst => '0',
    d => delay_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_0ab87d94e8 
  port map (
    clr => '0',
    sel => delay_q_net,
    d0 => shift_op_net,
    d1 => shift1_op_net,
    d2 => shift2_op_net,
    d3 => shift3_op_net,
    d4 => shift4_op_net,
    d5 => shift5_op_net,
    d6 => shift6_op_net,
    d7 => shift7_op_net,
    d8 => shift8_op_net,
    d9 => shift9_op_net,
    d10 => shift10_op_net,
    d11 => shift11_op_net,
    d12 => shift12_op_net,
    d13 => shift13_op_net,
    d14 => shift14_op_net,
    d15 => shift15_op_net,
    d16 => shift16_op_net,
    d17 => shift17_op_net,
    d18 => shift18_op_net,
    d19 => shift28_op_net,
    d20 => shift19_op_net,
    d21 => shift20_op_net,
    d22 => shift21_op_net,
    d23 => shift22_op_net,
    d24 => shift23_op_net,
    d25 => shift24_op_net,
    d26 => shift25_op_net,
    d27 => shift26_op_net,
    d28 => shift27_op_net,
    d29 => shift29_op_net,
    d30 => shift30_op_net,
    d31 => shift31_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_3619f4964b 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_fe311d091a 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift10 : entity xil_defaultlib.sysgen_shift_2692c83063 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift10_op_net
  );
  shift11 : entity xil_defaultlib.sysgen_shift_8eebab1241 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift11_op_net
  );
  shift12 : entity xil_defaultlib.sysgen_shift_46b7989a40 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift12_op_net
  );
  shift13 : entity xil_defaultlib.sysgen_shift_1ba0cd09e9 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift13_op_net
  );
  shift14 : entity xil_defaultlib.sysgen_shift_b05c2cc1db 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift14_op_net
  );
  shift15 : entity xil_defaultlib.sysgen_shift_82aa0ce900 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift15_op_net
  );
  shift16 : entity xil_defaultlib.sysgen_shift_d5ad156bb5 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift16_op_net
  );
  shift17 : entity xil_defaultlib.sysgen_shift_eb7b6add05 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift17_op_net
  );
  shift18 : entity xil_defaultlib.sysgen_shift_0dd60416e8 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift18_op_net
  );
  shift19 : entity xil_defaultlib.sysgen_shift_64acbeb87a 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift19_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_cc7dc557f2 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift20 : entity xil_defaultlib.sysgen_shift_a4a191b74e 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift20_op_net
  );
  shift21 : entity xil_defaultlib.sysgen_shift_1264b1e51d 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift21_op_net
  );
  shift22 : entity xil_defaultlib.sysgen_shift_fd9f7e06f4 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift22_op_net
  );
  shift23 : entity xil_defaultlib.sysgen_shift_43d298fafa 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift23_op_net
  );
  shift24 : entity xil_defaultlib.sysgen_shift_6c00b250b0 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift24_op_net
  );
  shift25 : entity xil_defaultlib.sysgen_shift_2ec0a4a56b 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift25_op_net
  );
  shift26 : entity xil_defaultlib.sysgen_shift_681620d6c0 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift26_op_net
  );
  shift27 : entity xil_defaultlib.sysgen_shift_7620bb9624 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift27_op_net
  );
  shift28 : entity xil_defaultlib.sysgen_shift_d8a7426396 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift28_op_net
  );
  shift29 : entity xil_defaultlib.sysgen_shift_9846f8dae5 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift29_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_299310e380 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift30 : entity xil_defaultlib.sysgen_shift_5b57131a23 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift30_op_net
  );
  shift31 : entity xil_defaultlib.sysgen_shift_904bc73004 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift31_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_a8985e88cc 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_e8749ba12e 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_5b90d727fe 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_7991328c2d 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_721de049f3 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_1cca769cd0 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/exp/shifter_2^n
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_shifter_2_n is
  port (
    shift_amount : in std_logic_vector( 5-1 downto 0 );
    ce : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    x2_n : out std_logic_vector( 32-1 downto 0 )
  );
end env_extr_shifter_2_n;
architecture structural of env_extr_shifter_2_n is 
  signal delay_q_net_x0 : std_logic_vector( 5-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal constant_op_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net : std_logic_vector( 5-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal shift_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift28_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift14_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift22_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift23_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift10_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift11_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift12_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift13_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift16_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift19_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift21_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift26_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift17_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift15_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift20_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift18_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift24_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift25_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift27_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift30_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift31_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift29_op_net : std_logic_vector( 32-1 downto 0 );
begin
  x2_n <= mux_y_net;
  delay_q_net_x0 <= shift_amount;
  logical1_y_net <= ce;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_ff1a8fb713 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 5
  )
  port map (
    en => '1',
    rst => '0',
    d => delay_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_51819bb2a2 
  port map (
    clr => '0',
    sel => delay_q_net,
    d0 => shift_op_net,
    d1 => shift1_op_net,
    d2 => shift2_op_net,
    d3 => shift3_op_net,
    d4 => shift4_op_net,
    d5 => shift5_op_net,
    d6 => shift6_op_net,
    d7 => shift7_op_net,
    d8 => shift8_op_net,
    d9 => shift9_op_net,
    d10 => shift10_op_net,
    d11 => shift11_op_net,
    d12 => shift12_op_net,
    d13 => shift13_op_net,
    d14 => shift14_op_net,
    d15 => shift15_op_net,
    d16 => shift16_op_net,
    d17 => shift17_op_net,
    d18 => shift18_op_net,
    d19 => shift28_op_net,
    d20 => shift19_op_net,
    d21 => shift20_op_net,
    d22 => shift21_op_net,
    d23 => shift22_op_net,
    d24 => shift23_op_net,
    d25 => shift24_op_net,
    d26 => shift25_op_net,
    d27 => shift26_op_net,
    d28 => shift27_op_net,
    d29 => shift29_op_net,
    d30 => shift30_op_net,
    d31 => shift31_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_82c252d578 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_fdf21cae4a 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift10 : entity xil_defaultlib.sysgen_shift_1d06aa4703 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift10_op_net
  );
  shift11 : entity xil_defaultlib.sysgen_shift_bc9f42bae5 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift11_op_net
  );
  shift12 : entity xil_defaultlib.sysgen_shift_78fb68b101 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift12_op_net
  );
  shift13 : entity xil_defaultlib.sysgen_shift_448817efdb 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift13_op_net
  );
  shift14 : entity xil_defaultlib.sysgen_shift_8b169920c6 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift14_op_net
  );
  shift15 : entity xil_defaultlib.sysgen_shift_53b7f93e1b 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift15_op_net
  );
  shift16 : entity xil_defaultlib.sysgen_shift_eab46df719 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift16_op_net
  );
  shift17 : entity xil_defaultlib.sysgen_shift_a267fcd6ce 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift17_op_net
  );
  shift18 : entity xil_defaultlib.sysgen_shift_388c6f2bf4 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift18_op_net
  );
  shift19 : entity xil_defaultlib.sysgen_shift_f8f7eae816 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift19_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_b5e129b49a 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift20 : entity xil_defaultlib.sysgen_shift_4b04d28623 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift20_op_net
  );
  shift21 : entity xil_defaultlib.sysgen_shift_4d6f626649 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift21_op_net
  );
  shift22 : entity xil_defaultlib.sysgen_shift_2fb6ef2563 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift22_op_net
  );
  shift23 : entity xil_defaultlib.sysgen_shift_283b34fe28 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift23_op_net
  );
  shift24 : entity xil_defaultlib.sysgen_shift_8e515d4da9 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift24_op_net
  );
  shift25 : entity xil_defaultlib.sysgen_shift_8bb204f528 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift25_op_net
  );
  shift26 : entity xil_defaultlib.sysgen_shift_9f094b9300 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift26_op_net
  );
  shift27 : entity xil_defaultlib.sysgen_shift_e21319c139 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift27_op_net
  );
  shift28 : entity xil_defaultlib.sysgen_shift_cf4ef08244 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift28_op_net
  );
  shift29 : entity xil_defaultlib.sysgen_shift_b4748ad6c0 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift29_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_2cbb90ecc6 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift30 : entity xil_defaultlib.sysgen_shift_fae01525c3 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift30_op_net
  );
  shift31 : entity xil_defaultlib.sysgen_shift_e575ad48ff 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift31_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_28f8b18912 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_814fce2747 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_02044f7d8d 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_a15b0202c2 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_e83d2288a0 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_1636dc93d1 
  port map (
    clr => '0',
    ip => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/exp
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_exp is
  port (
    s_data_tvalid : in std_logic;
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    m_data_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_data_tdata : out std_logic_vector( 16-1 downto 0 )
  );
end env_extr_exp;
architecture structural of env_extr_exp is 
  signal mux_y_net_x0 : std_logic_vector( 33-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal ln2_p_net : std_logic_vector( 16-1 downto 0 );
  signal r : std_logic_vector( 24-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_m_axis_data_tvalid_net : std_logic;
  signal clk_net : std_logic;
  signal cordic_exp_m_axis_dout_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 5-1 downto 0 );
  signal mux_y_net_x1 : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 6-1 downto 0 );
  signal ln2_p_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 17-1 downto 0 );
  signal cordic_exp_m_axis_dout_tdata_imag_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 5-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal q : std_logic_vector( 5-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 6-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal cordic_exp_m_axis_dout_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 6-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 6-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 64-1 downto 0 );
  signal negate_op_net : std_logic_vector( 5-1 downto 0 );
  signal slice_y_net : std_logic_vector( 5-1 downto 0 );
begin
  m_data_tvalid <= logical_y_net_x0;
  m_data_tdata <= mult_p_net;
  fir_compiler_7_2_m_axis_data_tvalid_net <= s_data_tvalid;
  fir_compiler_7_2_m_axis_data_tdata_real_net <= s_data_tdata;
  logical_y_net <= m_data_tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  explarge : entity xil_defaultlib.env_extr_explarge 
  port map (
    in1 => ln2_p_net,
    ce => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => mux_y_net
  );
  negative_shifter_2_n1 : entity xil_defaultlib.env_extr_negative_shifter_2_n1 
  port map (
    shift_amount => delay_q_net,
    ce => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    x2_n => mux_y_net_x0
  );
  shifter_2_n : entity xil_defaultlib.env_extr_shifter_2_n 
  port map (
    shift_amount => delay_q_net,
    ce => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    x2_n => mux_y_net_x1
  );
  ln2 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 9,
    a_width => 16,
    b_bin_pt => 30,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 32,
    c_output_width => 48,
    core_name0 => "env_extr_mult_gen_v12_0_i6",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 10,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fir_compiler_7_2_m_axis_data_tdata_real_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => ln2_p_net
  );
  addsub : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 9,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 9,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i1",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 21,
    s_width => 24
  )
  port map (
    clr => '0',
    a => delay1_q_net,
    b => ln2_p_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => r
  );
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 17
  )
  port map (
    clr => '0',
    a => cordic_exp_m_axis_dout_tdata_imag_net,
    b => cordic_exp_m_axis_dout_tdata_real_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_43ad506e7d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 18,
    reg_retiming => 0,
    reset => 0,
    width => 5
  )
  port map (
    rst => '0',
    d => q,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 5,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => fir_compiler_7_2_m_axis_data_tdata_real_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 6
  )
  port map (
    rst => '0',
    d => mux_y_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 21,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => relational_op_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 20,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay5_q_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 6,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d(0) => fir_compiler_7_2_m_axis_data_tvalid_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical2_y_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_m_axis_data_tvalid_net,
    d1 => delay6_q_net,
    y => logical_y_net_x0
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_m_axis_data_tvalid_net,
    d1 => logical_y_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay4_q_net,
    d1 => cordic_exp_m_axis_dout_tvalid_net,
    y => logical2_y_net
  );
  mult : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 32,
    a_width => 64,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 17,
    c_a_type => 0,
    c_a_width => 64,
    c_b_type => 0,
    c_b_width => 17,
    c_baat => 64,
    c_output_width => 81,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i7",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux1_y_net,
    b => addsub1_s_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_23c13cbc93 
  port map (
    clr => '0',
    sel => relational_op_net,
    d0 => slice_y_net,
    d1 => negate_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => q
  );
  mux1 : entity xil_defaultlib.sysgen_mux_b6f4f85bde 
  port map (
    clr => '0',
    sel => delay3_q_net,
    d0 => mux_y_net_x1,
    d1 => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux1_y_net
  );
  negate : entity xil_defaultlib.sysgen_negate_89c8216ef7 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => negate_op_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_8bcc92ff4b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_8bcc92ff4b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux_y_net,
    output_port => reinterpret2_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_a7c275b6d1 
  port map (
    clr => '0',
    a => reinterpret2_output_port_net,
    b => constant1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  slice : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 4,
    x_width => 6,
    y_width => 5
  )
  port map (
    x => delay2_q_net,
    y => slice_y_net
  );
  cordic_exp : entity xil_defaultlib.xlcordic_a91af70539891ea03c96faa971b8fba8 
  port map (
    s_axis_phase_tvalid => delay5_q_net(0),
    s_axis_phase_tdata_phase => r,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    m_axis_dout_tvalid => cordic_exp_m_axis_dout_tvalid_net(0),
    m_axis_dout_tdata_imag => cordic_exp_m_axis_dout_tdata_imag_net,
    m_axis_dout_tdata_real => cordic_exp_m_axis_dout_tdata_real_net
  );
  ln2_x0 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 0,
    a_width => 6,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 6,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 22,
    core_name0 => "env_extr_mult_gen_v12_0_i8",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 9,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => reinterpret1_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => ln2_p_net_x0
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/log2/normalize_input/stage0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage0 is
  port (
    v_in : in std_logic_vector( 24-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 24-1 downto 0 );
    n_shift_out : out std_logic_vector( 4-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage0;
architecture structural of env_extr_stage0 is 
  signal ce_net : std_logic;
  signal shift2_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 24-1 downto 0 );
  signal fifo3_dout_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net : std_logic;
  signal shift8_op_net : std_logic_vector( 24-1 downto 0 );
  signal log2lut : std_logic_vector( 4-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 24-1 downto 0 );
  signal mux_y_net : std_logic_vector( 24-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 24-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 24-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 24-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 4-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 24-1 downto 0 );
begin
  v_out <= mux_y_net;
  n_shift_out <= delay1_q_net;
  mem_addr <= slice1_y_net;
  fifo3_dout_net <= v_in;
  log2lut <= mem_data_in;
  logical1_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 4
  )
  port map (
    rst => '0',
    d => log2lut,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_d865ddaabf 
  port map (
    clr => '0',
    sel => log2lut,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_974e525f69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => fifo3_dout_net,
    output_port => reinterpret_output_port_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_9cad776d86 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_d72ea20337 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_e085df984b 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_1283525248 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_2367981efc 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_6c4b0de53b 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_6f12e478be 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_057d0610f2 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_ce9c30224d 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 23,
    x_width => 24,
    y_width => 8
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/log2/normalize_input/stage1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage1 is
  port (
    v_in : in std_logic_vector( 24-1 downto 0 );
    n_shift_in : in std_logic_vector( 4-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 24-1 downto 0 );
    n_shift_out : out std_logic_vector( 5-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage1;
architecture structural of env_extr_stage1 is 
  signal mux_y_net : std_logic_vector( 24-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 5-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal delay2_q_net : std_logic_vector( 4-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 4-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 24-1 downto 0 );
  signal log2luti1 : std_logic_vector( 4-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 24-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  v_out <= mux_y_net;
  n_shift_out <= addsub1_s_net;
  mem_addr <= slice1_y_net;
  mux_y_net_x0 <= v_in;
  delay1_q_net <= n_shift_in;
  log2luti1 <= mem_data_in;
  logical1_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 4,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 4,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 5,
    core_name0 => "env_extr_c_addsub_v12_0_i8",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 5,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 5
  )
  port map (
    clr => '0',
    a => delay2_q_net,
    b => log2luti1,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 4
  )
  port map (
    rst => '0',
    d => delay1_q_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_d865ddaabf 
  port map (
    clr => '0',
    sel => log2luti1,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_9cad776d86 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_d72ea20337 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_e085df984b 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_1283525248 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_2367981efc 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_6c4b0de53b 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_6f12e478be 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_057d0610f2 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_ce9c30224d 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 23,
    x_width => 24,
    y_width => 8
  )
  port map (
    x => mux_y_net_x0,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/log2/normalize_input/stage3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage3 is
  port (
    v_in : in std_logic_vector( 24-1 downto 0 );
    n_shift_in : in std_logic_vector( 5-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 24-1 downto 0 );
    n_shift_out : out std_logic_vector( 7-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage3;
architecture structural of env_extr_stage3 is 
  signal reinterpret_output_port_net : std_logic_vector( 24-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 7-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net : std_logic_vector( 24-1 downto 0 );
  signal rom_data_net : std_logic_vector( 4-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net_x0 : std_logic_vector( 5-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 24-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 24-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 24-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 6-1 downto 0 );
begin
  v_out <= reinterpret_output_port_net;
  n_shift_out <= addsub1_s_net;
  mem_addr <= slice1_y_net;
  mux_y_net <= v_in;
  addsub1_s_net_x0 <= n_shift_in;
  rom_data_net <= mem_data_in;
  logical1_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 0,
    a_width => 6,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 4,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 7,
    core_name0 => "env_extr_c_addsub_v12_0_i9",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 7,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 7
  )
  port map (
    clr => '0',
    a => addsub2_s_net,
    b => rom_data_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 1,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 5,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 6,
    core_name0 => "env_extr_c_addsub_v12_0_i10",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 6,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 6
  )
  port map (
    clr => '0',
    a => constant1_op_net,
    b => addsub1_s_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_d865ddaabf 
  port map (
    clr => '0',
    sel => rom_data_net,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net_x0
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_974e525f69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux_y_net_x0,
    output_port => reinterpret_output_port_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_9cad776d86 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_d72ea20337 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_e085df984b 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_1283525248 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_2367981efc 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_6c4b0de53b 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_6f12e478be 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_057d0610f2 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_ce9c30224d 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 23,
    x_width => 24,
    y_width => 8
  )
  port map (
    x => mux_y_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/log2/normalize_input
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_normalize_input is
  port (
    data_in : in std_logic_vector( 24-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    data_out_x : out std_logic_vector( 24-1 downto 0 );
    data_out_n : out std_logic_vector( 7-1 downto 0 )
  );
end env_extr_normalize_input;
architecture structural of env_extr_normalize_input is 
  signal addsub1_s_net : std_logic_vector( 7-1 downto 0 );
  signal rom_data_net : std_logic_vector( 4-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 24-1 downto 0 );
  signal fifo3_dout_net : std_logic_vector( 24-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal slice1_y_net_x1 : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 5-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 4-1 downto 0 );
  signal mux_y_net : std_logic_vector( 24-1 downto 0 );
  signal ce_net : std_logic;
  signal log2luti1 : std_logic_vector( 4-1 downto 0 );
  signal log2lut : std_logic_vector( 4-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 4-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
begin
  data_out_x <= reinterpret_output_port_net;
  data_out_n <= addsub1_s_net;
  fifo3_dout_net <= data_in;
  logical1_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  stage0 : entity xil_defaultlib.env_extr_stage0 
  port map (
    v_in => fifo3_dout_net,
    mem_data_in => log2lut,
    en => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => mux_y_net_x0,
    n_shift_out => delay1_q_net,
    mem_addr => slice1_y_net_x1
  );
  stage1 : entity xil_defaultlib.env_extr_stage1 
  port map (
    v_in => mux_y_net_x0,
    n_shift_in => delay1_q_net,
    mem_data_in => log2luti1,
    en => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => mux_y_net,
    n_shift_out => addsub1_s_net_x0,
    mem_addr => slice1_y_net_x0
  );
  stage3 : entity xil_defaultlib.env_extr_stage3 
  port map (
    v_in => mux_y_net,
    n_shift_in => addsub1_s_net_x0,
    mem_data_in => rom_data_net,
    en => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => reinterpret_output_port_net,
    n_shift_out => addsub1_s_net,
    mem_addr => slice1_y_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_1356a16089 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  dual_port_ram : entity xil_defaultlib.env_extr_xltdpram 
  generic map (
    addr_width_a => 8,
    addr_width_b => 8,
    clocking_mode => "common_clock",
    data_width_a => 4,
    data_width_b => 4,
    latency => 1,
    mem_init_file => "xpm_134b5e_vivado.mem",
    mem_size => 1024,
    mem_type => "block",
    read_reset_a => "0",
    read_reset_b => "0",
    write_mode_a => "write_first",
    write_mode_b => "write_first"
  )
  port map (
    rsta => "0",
    rstb => "0",
    addra => slice1_y_net_x1,
    dina => constant3_op_net,
    wea => constant2_op_net,
    addrb => slice1_y_net_x0,
    dinb => constant3_op_net,
    web => constant2_op_net,
    ena => logical1_y_net,
    enb => logical1_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => log2lut,
    doutb => log2luti1
  );
  rom : entity xil_defaultlib.env_extr_xlsprom 
  generic map (
    c_address_width => 8,
    c_width => 4,
    latency => 1,
    mem_init_file => "xpm_134b5e_vivado.mem",
    mem_size => 1024,
    mem_type => "block",
    read_reset_val => "0"
  )
  port map (
    rst => "0",
    addr => slice1_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    data => rom_data_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC/log2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_log2 is
  port (
    s_data_tdata : in std_logic_vector( 24-1 downto 0 );
    s_data_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_data_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_data_tdata : out std_logic_vector( 16-1 downto 0 )
  );
end env_extr_log2;
architecture structural of env_extr_log2 is 
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 7-1 downto 0 );
  signal log2lut : std_logic_vector( 32-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 7-1 downto 0 );
  signal fifo3_dout_net : std_logic_vector( 24-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 9-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 8-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 32-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 9-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal log2luti1 : std_logic_vector( 32-1 downto 0 );
  signal constant_op_net : std_logic_vector( 8-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal high_byte_y_net : std_logic_vector( 8-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net : std_logic_vector( 8-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal r : std_logic_vector( 16-1 downto 0 );
  signal high_byte2_y_net : std_logic_vector( 8-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal log2lut_x0 : std_logic_vector( 8-1 downto 0 );
begin
  m_data_tvalid <= logical_y_net_x0;
  m_data_tdata <= addsub4_s_net;
  fifo3_dout_net <= s_data_tdata;
  inverter_op_net <= s_data_tvalid;
  logical_y_net <= m_data_tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  normalize_input : entity xil_defaultlib.env_extr_normalize_input 
  port map (
    data_in => fifo3_dout_net,
    en => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    data_out_x => reinterpret_output_port_net_x0,
    data_out_n => addsub1_s_net_x0
  );
  addsub : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 0,
    a_width => 7,
    b_arith => xlSigned,
    b_bin_pt => 31,
    b_width => 32,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 39,
    core_name0 => "env_extr_c_addsub_v12_0_i4",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 39,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 9,
    s_width => 16
  )
  port map (
    clr => '0',
    a => delay3_q_net,
    b => log2lut,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 31,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 31,
    b_width => 32,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 33,
    core_name0 => "env_extr_c_addsub_v12_0_i5",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 33,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlUnsigned,
    s_bin_pt => 15,
    s_width => 16
  )
  port map (
    clr => '0',
    a => log2luti1,
    b => log2lut,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 8,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 8,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 9,
    core_name0 => "env_extr_c_addsub_v12_0_i6",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 9,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 9
  )
  port map (
    clr => '0',
    a => high_byte_y_net,
    b => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 8,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 8,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 9,
    core_name0 => "env_extr_c_addsub_v12_0_i6",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 9,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 9
  )
  port map (
    clr => '0',
    a => high_byte_y_net,
    b => constant1_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  addsub4 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 6,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 9,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 20,
    core_name0 => "env_extr_c_addsub_v12_0_i7",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 20,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 9,
    s_width => 16
  )
  port map (
    clr => '0',
    a => mult_p_net,
    b => delay2_q_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_da4e5fe5aa 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_edeea19893 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_5a78060fb2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 16,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => inverter_op_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => reinterpret_output_port_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => addsub_s_net,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    rst => '0',
    d => addsub1_s_net_x0,
    en => logical1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  dual_port_ram : entity xil_defaultlib.env_extr_xltdpram 
  generic map (
    addr_width_a => 8,
    addr_width_b => 8,
    clocking_mode => "common_clock",
    data_width_a => 32,
    data_width_b => 32,
    latency => 1,
    mem_init_file => "xpm_79bbae_vivado.mem",
    mem_size => 4128,
    mem_type => "block",
    read_reset_a => "0",
    read_reset_b => "0",
    write_mode_a => "write_first",
    write_mode_b => "write_first"
  )
  port map (
    rsta => "0",
    rstb => "0",
    addra => mux1_y_net,
    dina => constant3_op_net,
    wea => constant2_op_net,
    addrb => mux_y_net,
    dinb => constant3_op_net,
    web => constant2_op_net,
    ena => logical1_y_net,
    enb => logical1_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => log2lut,
    doutb => log2luti1
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => delay_q_net,
    y => logical_y_net_x0
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => logical_y_net,
    y => logical1_y_net
  );
  mult : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 16,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 15,
    b_width => 16,
    c_a_type => 1,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 1,
    core_name0 => "env_extr_mult_gen_v12_0_i9",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 1,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 6,
    p_width => 16,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => delay1_q_net,
    b => addsub1_s_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_6d655f675c 
  port map (
    clr => '0',
    sel => relational_op_net,
    d0 => constant4_op_net,
    d1 => high_byte2_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_6d655f675c 
  port map (
    clr => '0',
    sel => relational_op_net,
    d0 => constant4_op_net,
    d1 => log2lut_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux1_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_a85b5b6c0e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => r,
    output_port => reinterpret_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_c6c4ab57e8 
  port map (
    clr => '0',
    a => high_byte_y_net,
    b => constant_op_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  high_byte : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 23,
    x_width => 24,
    y_width => 8
  )
  port map (
    x => reinterpret_output_port_net_x0,
    y => high_byte_y_net
  );
  high_byte1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 9,
    y_width => 8
  )
  port map (
    x => addsub2_s_net,
    y => log2lut_x0
  );
  high_byte2 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 9,
    y_width => 8
  )
  port map (
    x => addsub3_s_net,
    y => high_byte2_y_net
  );
  r_slice : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 24,
    y_width => 16
  )
  port map (
    x => reinterpret_output_port_net_x0,
    y => r
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/HOMOMORPHIC
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_homomorphic is
  port (
    s_data_tdata : in std_logic_vector( 24-1 downto 0 );
    s_data_tvalid : in std_logic;
    m_data_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_25000 : in std_logic;
    ce_25000 : in std_logic;
    s_data_tready : out std_logic_vector( 1-1 downto 0 );
    homo_m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    homo_m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_homomorphic;
architecture structural of env_extr_homomorphic is 
  signal clk_net_x0 : std_logic;
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal we_ce_net : std_logic;
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal fifo3_empty_net : std_logic;
  signal soc_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal fir_compiler_7_2_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal fifo3_dout_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net : std_logic;
  signal fir_compiler_7_2_m_axis_data_tvalid_net : std_logic;
  signal logical_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 16-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal inverter4_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_polyphase_decimator_2_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal constant_op_net : std_logic_vector( 4-1 downto 0 );
  signal counter_op_net : std_logic_vector( 4-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal fir_polyphase_decimator_2_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal constant12_op_net : std_logic_vector( 7-1 downto 0 );
  signal counter2_op_net : std_logic_vector( 7-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational8_op_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_s_axis_data_tready_net : std_logic;
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal fir_polyphase_decimator_2_s_axis_data_tready_net : std_logic;
begin
  s_data_tready <= logical_y_net;
  fifo3_dout_net <= s_data_tdata;
  fifo3_empty_net <= s_data_tvalid;
  soc_tready_net <= m_data_tready;
  homo_m_data_tdata <= register1_q_net;
  homo_m_data_tvalid <= logical8_y_net;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_25000;
  we_ce_net <= ce_25000;
  exp : entity xil_defaultlib.env_extr_exp 
  port map (
    s_data_tvalid => fir_compiler_7_2_m_axis_data_tvalid_net,
    s_data_tdata => fir_compiler_7_2_m_axis_data_tdata_real_net,
    m_data_tready => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    m_data_tvalid => logical_y_net_x0,
    m_data_tdata => mult_p_net
  );
  log2 : entity xil_defaultlib.env_extr_log2 
  port map (
    s_data_tdata => fifo3_dout_net,
    s_data_tvalid => inverter_op_net,
    m_data_tready => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    m_data_tvalid => logical_y_net_x1,
    m_data_tdata => addsub4_s_net
  );
  cmult1 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 9,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i5",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 10,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => addsub4_s_net,
    en => logical_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult1_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_26f67023a5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant12 : entity xil_defaultlib.sysgen_constant_7a7f00444b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant12_op_net
  );
  counter : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i1",
    op_arith => xlUnsigned,
    op_width => 4
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical1_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter_op_net
  );
  counter2 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i2",
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    clr => '0',
    rst => inverter4_op_net,
    en => logical8_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter2_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_2_m_axis_data_tvalid_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_2_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical_y_net_x1,
    en => logical_y_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay2_q_net
  );
  fir_compiler_7_2 : entity xil_defaultlib.xlfir_compiler_0df83b9355fb2a92daa40bd73a0070f8 
  port map (
    s_axis_data_tvalid => delay2_q_net(0),
    s_axis_data_tdata_real => cmult1_p_net,
    en => logical_y_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_data_tready => fir_compiler_7_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_m_axis_data_tdata_real_net
  );
  fir_polyphase_decimator_2 : entity xil_defaultlib.xlfir_compiler_426e477580e6ba6e6077d622db89efdf 
  port map (
    s_axis_data_tvalid => logical_y_net_x0(0),
    s_axis_data_tdata_real => mult_p_net,
    en => logical_y_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_data_tready => fir_polyphase_decimator_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_polyphase_decimator_2_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_polyphase_decimator_2_m_axis_data_tdata_real_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo3_empty_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter4 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip => soc_tready_net,
    clk => clk_net,
    ce => we_ce_net,
    op => inverter4_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => relational8_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_46ddf42584 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => fir_polyphase_decimator_2_m_axis_data_tvalid_net,
    d2 => relational_op_net,
    y => logical1_y_net
  );
  logical8 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => register_q_net,
    d1 => logical_y_net,
    y => logical8_y_net
  );
  register_x0 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => delay_q_net,
    rst => relational_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register_q_net
  );
  register1 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    d => delay1_q_net,
    rst => relational_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register1_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_27403e1f5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational8 : entity xil_defaultlib.sysgen_relational_76adedebc4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter2_op_net,
    b => constant12_op_net,
    op => relational8_op_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/PSD
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_psd is
  port (
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic;
    m_data_ready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_25000 : in std_logic;
    ce_25000 : in std_logic;
    s_data_tready : out std_logic_vector( 1-1 downto 0 );
    psd_m_data_tdata : out std_logic_vector( 32-1 downto 0 );
    psd_m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_psd;
architecture structural of env_extr_psd is 
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal fifo1_empty_net : std_logic;
  signal ce_net : std_logic;
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal psd : std_logic_vector( 24-1 downto 0 );
  signal psd_x0 : std_logic_vector( 48-1 downto 0 );
  signal we_ce_net : std_logic;
  signal fifo1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal soc_tready_net : std_logic_vector( 1-1 downto 0 );
  signal relational8_op_net : std_logic_vector( 1-1 downto 0 );
  signal fast_fourier_transform_9_1_m_axis_data_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal accumulator_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay14_q_net : std_logic_vector( 16-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 24-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 24-1 downto 0 );
  signal constant11_op_net : std_logic_vector( 12-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 7-1 downto 0 );
  signal cmult5_p_net : std_logic_vector( 16-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 16-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal constant10_op_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult4_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult3_p_net : std_logic_vector( 24-1 downto 0 );
  signal constant12_op_net : std_logic_vector( 7-1 downto 0 );
  signal constant5_op_net : std_logic_vector( 6-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 16-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 6-1 downto 0 );
  signal constant7_op_net : std_logic_vector( 6-1 downto 0 );
  signal counter1_op_net : std_logic_vector( 6-1 downto 0 );
  signal inverter2_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay17_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical7_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant8_op_net : std_logic_vector( 6-1 downto 0 );
  signal counter_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant13_op_net : std_logic_vector( 5-1 downto 0 );
  signal constant6_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant9_op_net : std_logic_vector( 6-1 downto 0 );
  signal logical9_y_net : std_logic_vector( 1-1 downto 0 );
  signal counter3_op_net : std_logic_vector( 7-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 1-1 downto 0 );
  signal counter2_op_net : std_logic_vector( 7-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 1-1 downto 0 );
  signal counter4_op_net : std_logic_vector( 7-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 6-1 downto 0 );
  signal fast_fourier_transform_9_1_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 29-1 downto 0 );
  signal inverter4_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter5_op_net : std_logic_vector( 5-1 downto 0 );
  signal delay_q_net : std_logic_vector( 29-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_polyphase_decimator_1_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 7-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 1-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal expression_dout_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 1-1 downto 0 );
  signal inverter3_op_net : std_logic_vector( 1-1 downto 0 );
  signal fir_polyphase_decimator_1_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 29-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 12-1 downto 0 );
  signal fir_resampling_s_axis_data_tready_net : std_logic;
  signal fir_resampling_m_axis_data_tvalid_net : std_logic;
  signal fast_fourier_transform_9_1_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 29-1 downto 0 );
  signal fir_resampling_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fast_fourier_transform_9_1_event_status_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_1_event_data_in_channel_halt_net : std_logic;
  signal relational2_op_net : std_logic;
  signal fast_fourier_transform_9_1_s_axis_config_tready_net : std_logic;
  signal fast_fourier_transform_9_1_s_axis_data_tready_net : std_logic;
  signal fast_fourier_transform_9_1_event_frame_started_net : std_logic;
  signal fir_polyphase_decimator_1_s_axis_data_tready_net : std_logic;
  signal fast_fourier_transform_9_1_m_axis_data_tuser_xk_index_net : std_logic_vector( 12-1 downto 0 );
  signal fast_fourier_transform_9_1_m_axis_data_tvalid_net : std_logic;
  signal fast_fourier_transform_9_1_event_tlast_unexpected_net : std_logic;
  signal fast_fourier_transform_9_1_event_data_out_channel_halt_net : std_logic;
  signal fast_fourier_transform_9_1_event_tlast_missing_net : std_logic;
  signal relational6_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical6_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical5_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational4_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational3_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational7_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational5_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 29-1 downto 0 );
  signal mux_y_net : std_logic_vector( 29-1 downto 0 );
  signal relational9_op_net : std_logic_vector( 1-1 downto 0 );
  signal rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
begin
  s_data_tready <= logical1_y_net;
  fifo1_dout_net <= s_data_tdata;
  fifo1_empty_net <= s_data_tvalid;
  soc_tready_net <= m_data_ready;
  psd_m_data_tdata <= register3_q_net;
  psd_m_data_tvalid <= logical8_y_net;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_25000;
  we_ce_net <= ce_25000;
  accumulator : entity xil_defaultlib.sysgen_accum_b582b4210d 
  port map (
    clr => '0',
    b => delay14_q_net,
    rst => inverter_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => accumulator_q_net
  );
  accumulator1 : entity xil_defaultlib.sysgen_accum_d9d316e0d6 
  port map (
    clr => '0',
    b => psd,
    rst => fast_fourier_transform_9_1_m_axis_data_tlast_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => psd_x0
  );
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 22,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 22,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "env_extr_c_addsub_v12_0_i0",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 22,
    s_width => 24
  )
  port map (
    clr => '0',
    a => mult1_p_net,
    b => mult2_p_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    s => psd
  );
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i1",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 15,
    s_width => 16
  )
  port map (
    clr => '0',
    a => delay1_q_net,
    b => register_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    s => addsub2_s_net
  );
  cmult3 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 22,
    a_width => 48,
    b_bin_pt => 23,
    c_a_type => 0,
    c_a_width => 48,
    c_b_type => 1,
    c_b_width => 24,
    c_output_width => 72,
    core_name0 => "env_extr_mult_gen_v12_0_i10",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 22,
    p_width => 24,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => psd_x0,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult3_p_net
  );
  cmult4 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i11",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => accumulator_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult4_p_net
  );
  cmult5 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i12",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux2_y_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => cmult5_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_943f22f869 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_368c4645b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant10 : entity xil_defaultlib.sysgen_constant_dd32a5a1de 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant10_op_net
  );
  constant11 : entity xil_defaultlib.sysgen_constant_fdfede7e6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant11_op_net
  );
  constant12 : entity xil_defaultlib.sysgen_constant_7a7f00444b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant12_op_net
  );
  constant13 : entity xil_defaultlib.sysgen_constant_f56de44490 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant13_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_943f22f869 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_1bba5eb0c0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_dd32a5a1de 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  constant5 : entity xil_defaultlib.sysgen_constant_3cc6e52edc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant5_op_net
  );
  constant6 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant6_op_net
  );
  constant7 : entity xil_defaultlib.sysgen_constant_a14c4f71df 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant7_op_net
  );
  constant8 : entity xil_defaultlib.sysgen_constant_7ca75cc400 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant8_op_net
  );
  constant9 : entity xil_defaultlib.sysgen_constant_a14c4f71df 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant9_op_net
  );
  counter : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i3",
    op_arith => xlUnsigned,
    op_width => 12
  )
  port map (
    rst => "0",
    clr => '0',
    en => delay17_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter_op_net
  );
  counter1 : entity xil_defaultlib.env_extr_xlcounter_limit 
  generic map (
    cnt_15_0 => 49,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "env_extr_c_counter_binary_v12_0_i4",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 6
  )
  port map (
    clr => '0',
    rst => inverter2_op_net,
    en => logical7_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter1_op_net
  );
  counter2 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i2",
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    clr => '0',
    rst => inverter4_op_net,
    en => logical8_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter2_op_net
  );
  counter3 : entity xil_defaultlib.env_extr_xlcounter_limit 
  generic map (
    cnt_15_0 => 99,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "env_extr_c_counter_binary_v12_0_i2",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    clr => '0',
    rst => delay15_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter3_op_net
  );
  counter4 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i2",
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical3_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter4_op_net
  );
  counter5 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i5",
    op_arith => xlUnsigned,
    op_width => 5
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical9_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter5_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 29
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_1_m_axis_data_tdata_xn_im_0_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 102,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay14_q_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay1_q_net
  );
  delay10 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => relational1_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay10_q_net
  );
  delay11 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 6
  )
  port map (
    rst => '0',
    d => counter1_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay11_q_net
  );
  delay12 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => expression_dout_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay12_q_net
  );
  delay13 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => inverter2_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay13_q_net
  );
  delay14 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => single_port_ram_data_out_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay14_q_net
  );
  delay15 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => relational1_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay15_q_net
  );
  delay16 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay15_q_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay16_q_net
  );
  delay17 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => logical2_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay17_q_net
  );
  delay18 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_1_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay18_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 7
  )
  port map (
    rst => '0',
    d => counter3_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 107,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay15_q_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 29
  )
  port map (
    rst => '0',
    d => fast_fourier_transform_9_1_m_axis_data_tdata_xn_re_0_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 8,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical4_y_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 114,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => inverter1_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 113,
    reg_retiming => 0,
    reset => 0,
    width => 12
  )
  port map (
    rst => '0',
    d => counter_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_1_m_axis_data_tvalid_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => inverter1_op_net,
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay9_q_net
  );
  expression : entity xil_defaultlib.sysgen_expr_891cb73c11 
  port map (
    clr => '0',
    a => inverter3_op_net,
    b => register1_q_net,
    c => delay10_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    dout => expression_dout_net
  );
  fir_resampling : entity xil_defaultlib.xlfir_compiler_bb64325c6783499a266f4dab40029360 
  port map (
    s_axis_data_tvalid => delay5_q_net(0),
    s_axis_data_tdata_real => cmult3_p_net,
    en => relational8_op_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_data_tready => fir_resampling_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_resampling_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_resampling_m_axis_data_tdata_real_net
  );
  fir_polyphase_decimator_1 : entity xil_defaultlib.xlfir_compiler_8f3c9977216b6af8df4f1fc50dcda152 
  port map (
    s_axis_data_tvalid => fir_resampling_m_axis_data_tvalid_net,
    s_axis_data_tdata_real => fir_resampling_m_axis_data_tdata_real_net,
    en => relational8_op_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_data_tready => fir_polyphase_decimator_1_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_polyphase_decimator_1_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_polyphase_decimator_1_m_axis_data_tdata_real_net
  );
  fast_fourier_transform_9_1 : entity xil_defaultlib.xlfast_fourier_transform_77676ad1157b4ef18d6fc4e5ba93e3c4 
  port map (
    s_axis_config_tdata_fwd_inv => constant4_op_net,
    s_axis_config_tvalid => constant10_op_net(0),
    s_axis_data_tdata_xn_im_0 => constant2_op_net,
    s_axis_data_tdata_xn_re_0 => cmult5_p_net,
    s_axis_data_tvalid => delay6_q_net(0),
    s_axis_data_tlast => relational2_op_net,
    m_axis_data_tready => constant10_op_net(0),
    en => relational8_op_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_config_tready => fast_fourier_transform_9_1_s_axis_config_tready_net,
    s_axis_data_tready => fast_fourier_transform_9_1_s_axis_data_tready_net,
    m_axis_data_tdata_xn_im_0 => fast_fourier_transform_9_1_m_axis_data_tdata_xn_im_0_net,
    m_axis_data_tdata_xn_re_0 => fast_fourier_transform_9_1_m_axis_data_tdata_xn_re_0_net,
    m_axis_data_tuser_xk_index => fast_fourier_transform_9_1_m_axis_data_tuser_xk_index_net,
    m_axis_data_tvalid => fast_fourier_transform_9_1_m_axis_data_tvalid_net,
    m_axis_data_tlast => fast_fourier_transform_9_1_m_axis_data_tlast_net(0),
    event_frame_started => fast_fourier_transform_9_1_event_frame_started_net,
    event_tlast_unexpected => fast_fourier_transform_9_1_event_tlast_unexpected_net,
    event_tlast_missing => fast_fourier_transform_9_1_event_tlast_missing_net,
    event_data_in_channel_halt => fast_fourier_transform_9_1_event_data_in_channel_halt_net,
    event_status_channel_halt => fast_fourier_transform_9_1_event_status_channel_halt_net,
    event_data_out_channel_halt => fast_fourier_transform_9_1_event_data_out_channel_halt_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_e6f34be9b2 
  port map (
    clr => '0',
    ip => delay15_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo1_empty_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter1_op_net
  );
  inverter2 : entity xil_defaultlib.sysgen_inverter_e6f34be9b2 
  port map (
    clr => '0',
    ip => delay10_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter2_op_net
  );
  inverter3 : entity xil_defaultlib.sysgen_inverter_e6f34be9b2 
  port map (
    clr => '0',
    ip => relational4_op_net,
    en => logical5_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter3_op_net
  );
  inverter4 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip => soc_tready_net,
    clk => clk_net,
    ce => we_ce_net,
    op => inverter4_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_8b7cd53eab 
  port map (
    clr => '0',
    d0 => relational_op_net,
    d1 => relational3_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => expression_dout_net,
    d1 => relational8_op_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational8_op_net,
    d1 => inverter1_op_net,
    y => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational8_op_net,
    d1 => relational5_op_net,
    y => logical3_y_net
  );
  logical4 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational7_op_net,
    d1(0) => fast_fourier_transform_9_1_m_axis_data_tvalid_net,
    y => logical4_y_net
  );
  logical5 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational8_op_net,
    d1 => relational6_op_net,
    y => logical5_y_net
  );
  logical6 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational8_op_net,
    d1 => relational5_op_net,
    y => logical6_y_net
  );
  logical7 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational8_op_net,
    d1 => delay9_q_net,
    y => logical7_y_net
  );
  logical8 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => register2_q_net,
    d1 => relational8_op_net,
    y => logical8_y_net
  );
  logical9 : entity xil_defaultlib.sysgen_logical_46ddf42584 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => fir_polyphase_decimator_1_m_axis_data_tvalid_net,
    d2 => relational9_op_net,
    y => logical9_y_net
  );
  mult : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i4",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => addsub2_s_net,
    b => rom_data_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 29,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 29,
    c_a_type => 0,
    c_a_width => 29,
    c_b_type => 0,
    c_b_width => 29,
    c_baat => 29,
    c_output_width => 58,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i13",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 22,
    p_width => 24,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux_y_net,
    b => mux_y_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 29,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 29,
    c_a_type => 0,
    c_a_width => 29,
    c_b_type => 0,
    c_b_width => 29,
    c_baat => 29,
    c_output_width => 58,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i13",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 22,
    p_width => 24,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux1_y_net,
    b => mux1_y_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    core_clk => clk_net_x0,
    core_ce => ce_net,
    p => mult2_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_4ef9946cad 
  port map (
    clr => '0',
    sel => logical_y_net,
    d0 => constant6_op_net,
    d1 => delay_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_4ef9946cad 
  port map (
    clr => '0',
    sel => logical_y_net,
    d0 => constant6_op_net,
    d1 => delay4_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => mux1_y_net
  );
  mux2 : entity xil_defaultlib.sysgen_mux_b944b2216d 
  port map (
    clr => '0',
    sel => delay3_q_net,
    d0 => constant_op_net,
    d1 => mult_p_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    y => mux2_y_net
  );
  rom : entity xil_defaultlib.env_extr_xlsprom 
  generic map (
    c_address_width => 7,
    c_width => 16,
    latency => 1,
    mem_init_file => "xpm_847733_vivado.mem",
    mem_size => 2048,
    mem_type => "block",
    read_reset_val => "0"
  )
  port map (
    rst => "0",
    addr => delay2_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    data => rom_data_net
  );
  register_x0 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    rst => "0",
    d => cmult4_p_net,
    en => delay16_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register_q_net
  );
  register1 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    rst => "0",
    d => relational4_op_net,
    en => logical6_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register1_q_net
  );
  register2 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => delay8_q_net,
    rst => relational9_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    d => delay18_q_net,
    rst => relational9_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register3_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_d7320cb393 
  port map (
    clr => '0',
    a => fast_fourier_transform_9_1_m_axis_data_tuser_xk_index_net,
    b => constant5_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_4b123f385c 
  port map (
    clr => '0',
    a => constant1_op_net,
    b => counter_op_net,
    en => delay17_q_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational1_op_net
  );
  relational2 : entity xil_defaultlib.sysgen_relational_e5cf6bc1b4 
  port map (
    clr => '0',
    a => delay7_q_net,
    b => constant11_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op(0) => relational2_op_net
  );
  relational3 : entity xil_defaultlib.sysgen_relational_edfb909170 
  port map (
    clr => '0',
    a => fast_fourier_transform_9_1_m_axis_data_tuser_xk_index_net,
    b => constant3_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational3_op_net
  );
  relational4 : entity xil_defaultlib.sysgen_relational_5eafccc14f 
  port map (
    clr => '0',
    a => counter_op_net,
    b => constant7_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational4_op_net
  );
  relational5 : entity xil_defaultlib.sysgen_relational_a2d6f3a851 
  port map (
    clr => '0',
    a => counter4_op_net,
    b => constant8_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational5_op_net
  );
  relational6 : entity xil_defaultlib.sysgen_relational_11786d7abd 
  port map (
    clr => '0',
    a => constant9_op_net,
    b => counter4_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational6_op_net
  );
  relational7 : entity xil_defaultlib.sysgen_relational_ddf771b5f9 
  port map (
    clr => '0',
    a => fast_fourier_transform_9_1_m_axis_data_tuser_xk_index_net,
    b => constant3_op_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational7_op_net
  );
  relational8 : entity xil_defaultlib.sysgen_relational_51e9be157d 
  port map (
    clr => '0',
    a => counter2_op_net,
    b => constant12_op_net,
    en => soc_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => relational8_op_net
  );
  relational9 : entity xil_defaultlib.sysgen_relational_f142f2c1d4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter5_op_net,
    b => constant13_op_net,
    op => relational9_op_net
  );
  single_port_ram : entity xil_defaultlib.env_extr_xlspram 
  generic map (
    init_value => b"0000000000000000",
    latency => 1,
    mem_init_file => "xpm_2c8012_vivado.mem",
    mem_size => 800,
    mem_type => "block",
    read_reset_val => "0",
    width => 16,
    width_addr => 6,
    write_mode_a => "write_first",
    xpm_lat => 1
  )
  port map (
    addr => delay11_q_net,
    data_in => fifo1_dout_net,
    we => delay12_q_net,
    rst => delay13_q_net,
    en => relational8_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    data_out => single_port_ram_data_out_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/Level-2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_level_2 is
  port (
    data_s_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_data_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_level_2;
architecture structural of env_extr_level_2 is 
  signal addsub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal cmult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub6_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult3_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
begin
  m_data_tdata <= addsub2_s_net;
  m_data_tvalid <= logical1_y_net;
  fifo2_dout_net <= data_s_tdata;
  inverter_op_net <= s_data_tvalid;
  logical_y_net_x0 <= m_data_tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub4_s_net,
    b => addsub6_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub4 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult_p_net,
    b => cmult1_p_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  addsub6 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult2_p_net,
    b => cmult3_p_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub6_s_net
  );
  cmult : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i14",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => fifo2_dout_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.sysgen_cmult_b5846fcf43 
  port map (
    clr => '0',
    a => delay3_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult1_p_net
  );
  cmult2 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i14",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => delay4_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult2_p_net
  );
  cmult3 : entity xil_defaultlib.sysgen_cmult_b5846fcf43 
  port map (
    clr => '0',
    a => delay5_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult3_p_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => inverter_op_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay1_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => fifo2_dout_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay3_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay4_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay2_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => logical_y_net_x0,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay6_q_net,
    d1 => inverter_op_net,
    y => logical1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/Level-3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_level_3 is
  port (
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_data_ready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_level_3;
architecture structural of env_extr_level_3 is 
  signal addsub7_s_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub4_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal cmult6_p_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub11_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub8_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal cmult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal cmult7_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult4_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub10_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult5_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult3_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub13_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay14_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
begin
  m_data_tdata <= addsub7_s_net;
  m_data_tvalid <= logical1_y_net_x0;
  addsub2_s_net <= s_data_tdata;
  logical1_y_net <= s_data_tvalid;
  logical_y_net_x0 <= m_data_ready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub10 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult2_p_net,
    b => cmult3_p_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub10_s_net
  );
  addsub11 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult5_p_net,
    b => cmult6_p_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub11_s_net
  );
  addsub13 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult7_p_net,
    b => cmult4_p_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub13_s_net
  );
  addsub3 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub8_s_net,
    b => addsub10_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  addsub4 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub13_s_net,
    b => addsub11_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  addsub7 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub3_s_net,
    b => addsub4_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub7_s_net
  );
  addsub8 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult_p_net,
    b => cmult1_p_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub8_s_net
  );
  cmult : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i14",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 13,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => addsub2_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.sysgen_cmult_a374b84dda 
  port map (
    clr => '0',
    a => delay7_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult1_p_net
  );
  cmult2 : entity xil_defaultlib.sysgen_cmult_a374b84dda 
  port map (
    clr => '0',
    a => delay8_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult2_p_net
  );
  cmult3 : entity xil_defaultlib.sysgen_cmult_a374b84dda 
  port map (
    clr => '0',
    a => delay9_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult3_p_net
  );
  cmult4 : entity xil_defaultlib.sysgen_cmult_a374b84dda 
  port map (
    clr => '0',
    a => delay12_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult4_p_net
  );
  cmult5 : entity xil_defaultlib.sysgen_cmult_a374b84dda 
  port map (
    clr => '0',
    a => delay13_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult5_p_net
  );
  cmult6 : entity xil_defaultlib.sysgen_cmult_a374b84dda 
  port map (
    clr => '0',
    a => delay14_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    p => cmult6_p_net
  );
  cmult7 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i14",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 13,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => delay10_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult7_p_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay11_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay10 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay9_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay10_q_net
  );
  delay11 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay6_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay11_q_net
  );
  delay12 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay10_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay12_q_net
  );
  delay13 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay12_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay13_q_net
  );
  delay14 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay13_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay14_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay1_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay2_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay3_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical1_y_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay5_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => addsub2_s_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay7_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay8_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay9_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical_y_net_x0,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay4_q_net,
    d1 => logical1_y_net,
    y => logical1_y_net_x0
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/Level-4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_level_4 is
  port (
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_data_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_level_4;
architecture structural of env_extr_level_4 is 
  signal addsub20_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub11_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub10_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult6_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult3_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult11_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub22_s_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub28_s_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal cmult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult5_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub13_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub18_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult4_p_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal cmult8_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult9_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult10_p_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal addsub7_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub30_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal cmult7_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub29_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub25_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult12_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub8_s_net : std_logic_vector( 16-1 downto 0 );
  signal addsub23_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult13_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub6_s_net : std_logic_vector( 16-1 downto 0 );
  signal cmult15_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay20_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult14_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay29_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay27_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay14_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay26_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay17_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay30_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay28_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay23_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay25_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay22_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay24_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay21_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
begin
  m_data_tdata <= addsub30_s_net;
  m_data_tvalid <= logical1_y_net_x0;
  addsub7_s_net <= s_data_tdata;
  logical1_y_net <= s_data_tvalid;
  logical_y_net <= m_data_tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub10 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult1_p_net,
    b => cmult2_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub10_s_net
  );
  addsub11 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult6_p_net,
    b => cmult5_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub11_s_net
  );
  addsub13 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult3_p_net,
    b => cmult4_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub13_s_net
  );
  addsub18 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult8_p_net,
    b => cmult9_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub18_s_net
  );
  addsub20 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult10_p_net,
    b => cmult11_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub20_s_net
  );
  addsub22 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 18,
    core_name0 => "env_extr_c_addsub_v12_0_i11",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 18,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub28_s_net,
    b => addsub18_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub22_s_net
  );
  addsub23 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub20_s_net,
    b => addsub29_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub23_s_net
  );
  addsub25 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub22_s_net,
    b => addsub23_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub25_s_net
  );
  addsub28 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlUnsigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult15_p_net,
    b => cmult7_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub28_s_net
  );
  addsub29 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult12_p_net,
    b => cmult13_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub29_s_net
  );
  addsub3 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub8_s_net,
    b => addsub10_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  addsub30 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub6_s_net,
    b => addsub25_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub30_s_net
  );
  addsub4 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 18,
    core_name0 => "env_extr_c_addsub_v12_0_i11",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 18,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub13_s_net,
    b => addsub11_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  addsub6 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => addsub3_s_net,
    b => addsub4_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub6_s_net
  );
  addsub8 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "env_extr_c_addsub_v12_0_i2",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 12,
    s_width => 16
  )
  port map (
    clr => '0',
    a => cmult14_p_net,
    b => cmult_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub8_s_net
  );
  cmult : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay7_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay8_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult1_p_net
  );
  cmult10 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay16_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult10_p_net
  );
  cmult11 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay18_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult11_p_net
  );
  cmult12 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay19_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult12_p_net
  );
  cmult13 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay20_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult13_p_net
  );
  cmult14 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i15",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 12,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => addsub7_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult14_p_net
  );
  cmult15 : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 16,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "env_extr_mult_gen_v12_0_i14",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 12,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => delay29_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult15_p_net
  );
  cmult2 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay9_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult2_p_net
  );
  cmult3 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay10_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult3_p_net
  );
  cmult4 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay12_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult4_p_net
  );
  cmult5 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay14_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult5_p_net
  );
  cmult6 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay13_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult6_p_net
  );
  cmult7 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay26_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult7_p_net
  );
  cmult8 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay27_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult8_p_net
  );
  cmult9 : entity xil_defaultlib.sysgen_cmult_63a0a657c5 
  port map (
    clr => '0',
    a => delay28_q_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => cmult9_p_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay30_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay10 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay9_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay10_q_net
  );
  delay11 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay6_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay11_q_net
  );
  delay12 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay10_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay12_q_net
  );
  delay13 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay12_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay13_q_net
  );
  delay14 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay13_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay14_q_net
  );
  delay15 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay11_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay15_q_net
  );
  delay16 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay28_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay16_q_net
  );
  delay17 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay23_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay17_q_net
  );
  delay18 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay16_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay18_q_net
  );
  delay19 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay18_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay19_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay1_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay20 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay19_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay20_q_net
  );
  delay21 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay17_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay21_q_net
  );
  delay22 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay21_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay22_q_net
  );
  delay23 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay4_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay23_q_net
  );
  delay24 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical1_y_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay24_q_net
  );
  delay25 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay24_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay25_q_net
  );
  delay26 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay29_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay26_q_net
  );
  delay27 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay26_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay27_q_net
  );
  delay28 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay27_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay28_q_net
  );
  delay29 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay14_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay29_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay2_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay30 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay25_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay30_q_net
  );
  delay4 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay3_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay22_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => delay5_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => addsub7_s_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay7_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => delay8_q_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay9_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical_y_net,
    y => logical_y_net_x0
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay15_q_net,
    d1 => logical1_y_net,
    y => logical1_y_net_x0
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE/log2/normalize_input/stage0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage0_x0 is
  port (
    v_in : in std_logic_vector( 32-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 32-1 downto 0 );
    n_shift_out : out std_logic_vector( 4-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage0_x0;
architecture structural of env_extr_stage0_x0 is 
  signal ce_net : std_logic;
  signal shift5_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 32-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 32-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 4-1 downto 0 );
  signal mult_p_net : std_logic_vector( 32-1 downto 0 );
  signal log2lut : std_logic_vector( 4-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal shift4_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
begin
  v_out <= mux_y_net;
  n_shift_out <= delay1_q_net;
  mem_addr <= slice1_y_net;
  mult_p_net <= v_in;
  log2lut <= mem_data_in;
  logical_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 4
  )
  port map (
    rst => '0',
    d => log2lut,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_84f5f08697 
  port map (
    clr => '0',
    sel => log2lut,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_fed05aa1a2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret_output_port_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_f31c6c86b4 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_b50d24da61 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_b99a1f83b9 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_c6d9fa88a0 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_900e723ce4 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_9a167c2012 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_8246a24e85 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_4240162ac4 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_74340a4c8e 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 31,
    x_width => 32,
    y_width => 8
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE/log2/normalize_input/stage1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage1_x0 is
  port (
    v_in : in std_logic_vector( 32-1 downto 0 );
    n_shift_in : in std_logic_vector( 4-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 32-1 downto 0 );
    n_shift_out : out std_logic_vector( 5-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage1_x0;
architecture structural of env_extr_stage1_x0 is 
  signal shift3_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 32-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 4-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal log2luti1 : std_logic_vector( 4-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 4-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal shift8_op_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 5-1 downto 0 );
begin
  v_out <= mux_y_net;
  n_shift_out <= addsub1_s_net;
  mem_addr <= slice1_y_net;
  mux_y_net_x0 <= v_in;
  delay1_q_net <= n_shift_in;
  log2luti1 <= mem_data_in;
  logical_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 4,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 4,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 5,
    core_name0 => "env_extr_c_addsub_v12_0_i8",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 5,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 5
  )
  port map (
    clr => '0',
    a => delay2_q_net,
    b => log2luti1,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 4
  )
  port map (
    rst => '0',
    d => delay1_q_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_84f5f08697 
  port map (
    clr => '0',
    sel => log2luti1,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_f31c6c86b4 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_b50d24da61 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_b99a1f83b9 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_c6d9fa88a0 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_900e723ce4 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_9a167c2012 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_8246a24e85 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_4240162ac4 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_74340a4c8e 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 31,
    x_width => 32,
    y_width => 8
  )
  port map (
    x => mux_y_net_x0,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE/log2/normalize_input/stage7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage7 is
  port (
    v_in : in std_logic_vector( 32-1 downto 0 );
    n_shift_in : in std_logic_vector( 5-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 32-1 downto 0 );
    n_shift_out : out std_logic_vector( 6-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage7;
architecture structural of env_extr_stage7 is 
  signal mux_y_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal log2luti1 : std_logic_vector( 4-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 5-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 6-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 32-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 5-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal shift3_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 32-1 downto 0 );
begin
  v_out <= mux_y_net;
  n_shift_out <= addsub1_s_net;
  mem_addr <= slice1_y_net;
  mux_y_net_x0 <= v_in;
  addsub1_s_net_x0 <= n_shift_in;
  log2luti1 <= mem_data_in;
  logical_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 5,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 4,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 6,
    core_name0 => "env_extr_c_addsub_v12_0_i15",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 6,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 6
  )
  port map (
    clr => '0',
    a => delay2_q_net,
    b => log2luti1,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 5
  )
  port map (
    rst => '0',
    d => addsub1_s_net_x0,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_84f5f08697 
  port map (
    clr => '0',
    sel => log2luti1,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_f31c6c86b4 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_b50d24da61 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_b99a1f83b9 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_c6d9fa88a0 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_900e723ce4 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_9a167c2012 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_8246a24e85 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_4240162ac4 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_74340a4c8e 
  port map (
    clr => '0',
    ip => mux_y_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 31,
    x_width => 32,
    y_width => 8
  )
  port map (
    x => mux_y_net_x0,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE/log2/normalize_input/stage8
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_stage8 is
  port (
    v_in : in std_logic_vector( 32-1 downto 0 );
    n_shift_in : in std_logic_vector( 6-1 downto 0 );
    mem_data_in : in std_logic_vector( 4-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    v_out : out std_logic_vector( 32-1 downto 0 );
    n_shift_out : out std_logic_vector( 8-1 downto 0 );
    mem_addr : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_stage8;
architecture structural of env_extr_stage8 is 
  signal clk_net : std_logic;
  signal log2lut : std_logic_vector( 4-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub2_s_net : std_logic_vector( 7-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 8-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 6-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift9_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 32-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 4-1 downto 0 );
  signal shift8_op_net : std_logic_vector( 32-1 downto 0 );
begin
  v_out <= reinterpret_output_port_net;
  n_shift_out <= addsub1_s_net;
  mem_addr <= slice1_y_net;
  mux_y_net <= v_in;
  addsub1_s_net_x0 <= n_shift_in;
  log2lut <= mem_data_in;
  logical_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 0,
    a_width => 7,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 4,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 8,
    core_name0 => "env_extr_c_addsub_v12_0_i16",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 8,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 8
  )
  port map (
    clr => '0',
    a => addsub2_s_net,
    b => log2lut,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 4,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 6,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 7,
    core_name0 => "env_extr_c_addsub_v12_0_i9",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 7,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 7
  )
  port map (
    clr => '0',
    a => constant1_op_net,
    b => addsub1_s_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_e65287780d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_84f5f08697 
  port map (
    clr => '0',
    sel => log2lut,
    d0 => shift9_op_net,
    d1 => shift2_op_net,
    d2 => shift3_op_net,
    d3 => shift4_op_net,
    d4 => shift5_op_net,
    d5 => shift6_op_net,
    d6 => shift7_op_net,
    d7 => shift8_op_net,
    d8 => shift1_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net_x0
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_256d1c6389 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux_y_net_x0,
    output_port => reinterpret_output_port_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_f31c6c86b4 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_b50d24da61 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_b99a1f83b9 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_c6d9fa88a0 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_900e723ce4 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_9a167c2012 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_8246a24e85 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
  shift8 : entity xil_defaultlib.sysgen_shift_4240162ac4 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift8_op_net
  );
  shift9 : entity xil_defaultlib.sysgen_shift_74340a4c8e 
  port map (
    clr => '0',
    ip => mux_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => shift9_op_net
  );
  slice1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 31,
    x_width => 32,
    y_width => 8
  )
  port map (
    x => mux_y_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE/log2/normalize_input
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_normalize_input_x0 is
  port (
    data_in : in std_logic_vector( 32-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    data_out_x : out std_logic_vector( 32-1 downto 0 );
    data_out_n : out std_logic_vector( 8-1 downto 0 )
  );
end env_extr_normalize_input_x0;
architecture structural of env_extr_normalize_input_x0 is 
  signal addsub1_s_net : std_logic_vector( 8-1 downto 0 );
  signal slice1_y_net_x1 : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal addsub1_s_net_x1 : std_logic_vector( 5-1 downto 0 );
  signal slice1_y_net_x2 : std_logic_vector( 8-1 downto 0 );
  signal ce_net : std_logic;
  signal log2luti1 : std_logic_vector( 4-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 4-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal log2lut_x0 : std_logic_vector( 4-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 6-1 downto 0 );
  signal log2luti1_x0 : std_logic_vector( 4-1 downto 0 );
  signal log2lut : std_logic_vector( 4-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net_x1 : std_logic_vector( 32-1 downto 0 );
  signal mult_p_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal constant3_op_net : std_logic_vector( 4-1 downto 0 );
  signal constant8_op_net : std_logic_vector( 4-1 downto 0 );
  signal constant7_op_net : std_logic_vector( 1-1 downto 0 );
begin
  data_out_x <= reinterpret_output_port_net;
  data_out_n <= addsub1_s_net;
  mult_p_net <= data_in;
  logical_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  stage0 : entity xil_defaultlib.env_extr_stage0_x0 
  port map (
    v_in => mult_p_net,
    mem_data_in => log2lut_x0,
    en => logical_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => mux_y_net_x0,
    n_shift_out => delay1_q_net,
    mem_addr => slice1_y_net_x1
  );
  stage1 : entity xil_defaultlib.env_extr_stage1_x0 
  port map (
    v_in => mux_y_net_x0,
    n_shift_in => delay1_q_net,
    mem_data_in => log2luti1,
    en => logical_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => mux_y_net_x1,
    n_shift_out => addsub1_s_net_x1,
    mem_addr => slice1_y_net_x2
  );
  stage7 : entity xil_defaultlib.env_extr_stage7 
  port map (
    v_in => mux_y_net_x1,
    n_shift_in => addsub1_s_net_x1,
    mem_data_in => log2luti1_x0,
    en => logical_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => mux_y_net,
    n_shift_out => addsub1_s_net_x0,
    mem_addr => slice1_y_net_x0
  );
  stage8 : entity xil_defaultlib.env_extr_stage8 
  port map (
    v_in => mux_y_net,
    n_shift_in => addsub1_s_net_x0,
    mem_data_in => log2lut,
    en => logical_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    v_out => reinterpret_output_port_net,
    n_shift_out => addsub1_s_net,
    mem_addr => slice1_y_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_1356a16089 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant7 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant7_op_net
  );
  constant8 : entity xil_defaultlib.sysgen_constant_1356a16089 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant8_op_net
  );
  dual_port_ram : entity xil_defaultlib.env_extr_xltdpram 
  generic map (
    addr_width_a => 8,
    addr_width_b => 8,
    clocking_mode => "common_clock",
    data_width_a => 4,
    data_width_b => 4,
    latency => 1,
    mem_init_file => "xpm_134b5e_vivado.mem",
    mem_size => 1024,
    mem_type => "block",
    read_reset_a => "0",
    read_reset_b => "0",
    write_mode_a => "write_first",
    write_mode_b => "write_first"
  )
  port map (
    rsta => "0",
    rstb => "0",
    addra => slice1_y_net_x1,
    dina => constant3_op_net,
    wea => constant2_op_net,
    addrb => slice1_y_net_x2,
    dinb => constant3_op_net,
    web => constant2_op_net,
    ena => logical_y_net,
    enb => logical_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => log2lut_x0,
    doutb => log2luti1
  );
  dual_port_ram3 : entity xil_defaultlib.env_extr_xltdpram 
  generic map (
    addr_width_a => 8,
    addr_width_b => 8,
    clocking_mode => "common_clock",
    data_width_a => 4,
    data_width_b => 4,
    latency => 1,
    mem_init_file => "xpm_134b5e_vivado.mem",
    mem_size => 1024,
    mem_type => "block",
    read_reset_a => "0",
    read_reset_b => "0",
    write_mode_a => "write_first",
    write_mode_b => "write_first"
  )
  port map (
    rsta => "0",
    rstb => "0",
    addra => slice1_y_net,
    dina => constant8_op_net,
    wea => constant7_op_net,
    addrb => slice1_y_net_x0,
    dinb => constant8_op_net,
    web => constant7_op_net,
    ena => logical_y_net,
    enb => logical_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => log2lut,
    doutb => log2luti1_x0
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE/log2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_log2_x0 is
  port (
    s_data_tdata : in std_logic_vector( 32-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tdata : out std_logic_vector( 24-1 downto 0 )
  );
end env_extr_log2_x0;
architecture structural of env_extr_log2_x0 is 
  signal addsub4_s_net : std_logic_vector( 24-1 downto 0 );
  signal mult_p_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub1_s_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 9-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 8-1 downto 0 );
  signal constant_op_net : std_logic_vector( 8-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 24-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 1-1 downto 0 );
  signal log2luti1 : std_logic_vector( 24-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 24-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 9-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal high_byte_y_net : std_logic_vector( 8-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 8-1 downto 0 );
  signal mult_p_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal log2lut_x0 : std_logic_vector( 24-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 24-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 8-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 24-1 downto 0 );
  signal log2lut : std_logic_vector( 8-1 downto 0 );
  signal reinterpret_output_port_net_x0 : std_logic_vector( 24-1 downto 0 );
  signal mux_y_net : std_logic_vector( 8-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal r : std_logic_vector( 24-1 downto 0 );
  signal high_byte2_y_net : std_logic_vector( 8-1 downto 0 );
begin
  m_data_tdata <= addsub4_s_net;
  mult_p_net <= s_data_tdata;
  logical_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  normalize_input : entity xil_defaultlib.env_extr_normalize_input_x0 
  port map (
    data_in => mult_p_net,
    en => logical_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    data_out_x => reinterpret_output_port_net,
    data_out_n => addsub1_s_net_x0
  );
  addsub : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 0,
    a_width => 8,
    b_arith => xlSigned,
    b_bin_pt => 23,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 32,
    core_name0 => "env_extr_c_addsub_v12_0_i12",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 32,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 17,
    s_width => 24
  )
  port map (
    clr => '0',
    a => delay3_q_net,
    b => log2lut_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  addsub1 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 23,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 23,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "env_extr_c_addsub_v12_0_i13",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 23,
    s_width => 24
  )
  port map (
    clr => '0',
    a => log2luti1,
    b => log2lut_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 8,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 8,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 9,
    core_name0 => "env_extr_c_addsub_v12_0_i6",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 9,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 9
  )
  port map (
    clr => '0',
    a => high_byte_y_net,
    b => constant_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 8,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 8,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 9,
    core_name0 => "env_extr_c_addsub_v12_0_i6",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 9,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 0,
    s_width => 9
  )
  port map (
    clr => '0',
    a => high_byte_y_net,
    b => constant1_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  addsub4 : entity xil_defaultlib.env_extr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 18,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 17,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 26,
    core_name0 => "env_extr_c_addsub_v12_0_i14",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 26,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 17,
    s_width => 24
  )
  port map (
    clr => '0',
    a => mult_p_net_x0,
    b => delay2_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_da4e5fe5aa 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_edeea19893 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_9a10bffb4b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_5eaad8c234 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 24
  )
  port map (
    rst => '0',
    d => reinterpret_output_port_net_x0,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 24
  )
  port map (
    rst => '0',
    d => addsub_s_net,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 8
  )
  port map (
    rst => '0',
    d => addsub1_s_net_x0,
    en => logical_y_net(0),
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  dual_port_ram : entity xil_defaultlib.env_extr_xltdpram 
  generic map (
    addr_width_a => 8,
    addr_width_b => 8,
    clocking_mode => "common_clock",
    data_width_a => 24,
    data_width_b => 24,
    latency => 1,
    mem_init_file => "xpm_37e064_vivado.mem",
    mem_size => 3096,
    mem_type => "block",
    read_reset_a => "0",
    read_reset_b => "0",
    write_mode_a => "write_first",
    write_mode_b => "write_first"
  )
  port map (
    rsta => "0",
    rstb => "0",
    addra => mux_y_net,
    dina => constant3_op_net,
    wea => constant2_op_net,
    addrb => mux1_y_net,
    dinb => constant3_op_net,
    web => constant2_op_net,
    ena => logical_y_net,
    enb => logical_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => log2lut_x0,
    doutb => log2luti1
  );
  mult : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 24,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 23,
    b_width => 24,
    c_a_type => 1,
    c_a_width => 24,
    c_b_type => 0,
    c_b_width => 24,
    c_baat => 24,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i19",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 18,
    p_width => 24,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => delay1_q_net,
    b => addsub1_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net_x0
  );
  mux : entity xil_defaultlib.sysgen_mux_6d655f675c 
  port map (
    clr => '0',
    sel => relational_op_net,
    d0 => constant4_op_net,
    d1 => log2lut,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_6d655f675c 
  port map (
    clr => '0',
    sel => relational_op_net,
    d0 => constant4_op_net,
    d1 => high_byte2_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mux1_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_974e525f69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => r,
    output_port => reinterpret_output_port_net_x0
  );
  relational : entity xil_defaultlib.sysgen_relational_c6c4ab57e8 
  port map (
    clr => '0',
    a => high_byte_y_net,
    b => constant_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  high_byte : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 31,
    x_width => 32,
    y_width => 8
  )
  port map (
    x => reinterpret_output_port_net,
    y => high_byte_y_net
  );
  high_byte1 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 9,
    y_width => 8
  )
  port map (
    x => addsub2_s_net,
    y => log2lut
  );
  high_byte2 : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 9,
    y_width => 8
  )
  port map (
    x => addsub3_s_net,
    y => high_byte2_y_net
  );
  r_slice : entity xil_defaultlib.env_extr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 23,
    x_width => 32,
    y_width => 24
  )
  port map (
    x => reinterpret_output_port_net,
    y => r
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT/shannonE
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_shannone is
  port (
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_data_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_shannone;
architecture structural of env_extr_shannone is 
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub30_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal negate_op_net : std_logic_vector( 16-1 downto 0 );
  signal mult_p_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 24-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 20-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
begin
  m_data_tdata <= negate_op_net;
  m_data_tvalid <= logical1_y_net_x0;
  addsub30_s_net <= s_data_tdata;
  logical1_y_net <= s_data_tvalid;
  logical_y_net <= m_data_tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  log2 : entity xil_defaultlib.env_extr_log2_x0 
  port map (
    s_data_tdata => mult_p_net,
    en => logical_y_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    m_data_tdata => addsub4_s_net
  );
  cmult : entity xil_defaultlib.env_extr_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 17,
    a_width => 24,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 24,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 40,
    core_name0 => "env_extr_mult_gen_v12_0_i16",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 9,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => addsub4_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_5d008414cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_943f22f869 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 17,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    rst => '0',
    d => mult_p_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    rst => '0',
    d => addsub30_s_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 26,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical1_y_net,
    en => logical_y_net_x0(0),
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical_y_net,
    d1 => logical1_y_net,
    y => logical_y_net_x0
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay2_q_net,
    d1 => logical1_y_net,
    y => logical1_y_net_x0
  );
  mult : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 15,
    a_width => 20,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 20,
    c_a_type => 0,
    c_a_width => 20,
    c_b_type => 0,
    c_b_width => 20,
    c_baat => 20,
    c_output_width => 40,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i17",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 27,
    p_width => 32,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => mux_y_net,
    b => mux_y_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.env_extr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 27,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 9,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 32,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 32,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "env_extr_mult_gen_v12_0_i18",
    en_arith => xlUnsigned,
    en_bin_pt => 0,
    en_width => 1,
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 9,
    p_width => 16,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    rst => "0",
    a => delay_q_net,
    b => cmult_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_0e1c8214ab 
  port map (
    clr => '0',
    sel => relational_op_net,
    d0 => delay1_q_net,
    d1 => constant_op_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  negate : entity xil_defaultlib.sysgen_negate_7ab9362e35 
  port map (
    clr => '0',
    ip => mult1_p_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    op => negate_op_net
  );
  relational : entity xil_defaultlib.sysgen_relational_5134ae3778 
  port map (
    clr => '0',
    a => constant1_op_net,
    b => addsub30_s_net,
    en => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr/SWT
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_swt is
  port (
    s_data_tdata : in std_logic_vector( 16-1 downto 0 );
    s_data_tvalid : in std_logic;
    m_data_ready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_25000 : in std_logic;
    ce_25000 : in std_logic;
    s_data_tready : out std_logic_vector( 1-1 downto 0 );
    swt_m_data_tdata : out std_logic_vector( 16-1 downto 0 );
    swt_m_data_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end env_extr_swt;
architecture structural of env_extr_swt is 
  signal we_ce_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub7_s_net : std_logic_vector( 16-1 downto 0 );
  signal fifo2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal absolute_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 4-1 downto 0 );
  signal constant12_op_net : std_logic_vector( 7-1 downto 0 );
  signal soc_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal addsub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal addsub30_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal negate_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net_x3 : std_logic_vector( 1-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo2_empty_net : std_logic;
  signal counter2_op_net : std_logic_vector( 7-1 downto 0 );
  signal inverter4_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal counter_op_net : std_logic_vector( 4-1 downto 0 );
  signal fir_polyphase_decimator_4_s_axis_data_tready_net : std_logic;
  signal fir_polyphase_decimator_4_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_polyphase_decimator_4_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational8_op_net : std_logic_vector( 1-1 downto 0 );
begin
  s_data_tready <= logical_y_net;
  fifo2_dout_net <= s_data_tdata;
  fifo2_empty_net <= s_data_tvalid;
  soc_tready_net <= m_data_ready;
  swt_m_data_tdata <= register_q_net;
  swt_m_data_tvalid <= logical8_y_net;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_25000;
  we_ce_net <= ce_25000;
  level_2 : entity xil_defaultlib.env_extr_level_2 
  port map (
    data_s_tdata => fifo2_dout_net,
    s_data_tvalid => inverter_op_net,
    m_data_tready => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    m_data_tdata => addsub2_s_net,
    m_data_tvalid => logical1_y_net
  );
  level_3 : entity xil_defaultlib.env_extr_level_3 
  port map (
    s_data_tdata => addsub2_s_net,
    s_data_tvalid => logical1_y_net,
    m_data_ready => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    m_data_tdata => addsub7_s_net,
    m_data_tvalid => logical1_y_net_x0
  );
  level_4 : entity xil_defaultlib.env_extr_level_4 
  port map (
    s_data_tdata => addsub7_s_net,
    s_data_tvalid => logical1_y_net_x0,
    m_data_tready => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    m_data_tdata => addsub30_s_net,
    m_data_tvalid => logical1_y_net_x1
  );
  shannone : entity xil_defaultlib.env_extr_shannone 
  port map (
    s_data_tdata => addsub30_s_net,
    s_data_tvalid => logical1_y_net_x1,
    m_data_tready => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    m_data_tdata => negate_op_net,
    m_data_tvalid => logical1_y_net_x3
  );
  absolute : entity xil_defaultlib.sysgen_abs_30fa818d57 
  port map (
    clr => '0',
    a => negate_op_net,
    en => logical_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => absolute_op_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_c47e91ab0f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant12 : entity xil_defaultlib.sysgen_constant_7a7f00444b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant12_op_net
  );
  counter : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i1",
    op_arith => xlUnsigned,
    op_width => 4
  )
  port map (
    rst => "0",
    clr => '0',
    en => logical1_y_net_x2,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter_op_net
  );
  counter2 : entity xil_defaultlib.env_extr_xlcounter_free 
  generic map (
    core_name0 => "env_extr_c_counter_binary_v12_0_i2",
    op_arith => xlUnsigned,
    op_width => 7
  )
  port map (
    clr => '0',
    rst => inverter4_op_net,
    en => logical8_y_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => counter2_op_net
  );
  delay : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    rst => '0',
    d => logical1_y_net_x3,
    en => logical_y_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_4_m_axis_data_tvalid_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.env_extr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => fir_polyphase_decimator_4_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => delay2_q_net
  );
  fir_polyphase_decimator_4 : entity xil_defaultlib.xlfir_compiler_e042276d3913bfdaaf22aa14f1f98a63 
  port map (
    s_axis_data_tvalid => delay_q_net(0),
    s_axis_data_tdata_real => absolute_op_net,
    en => logical_y_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net_x0,
    ce => ce_net,
    s_axis_data_tready => fir_polyphase_decimator_4_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_polyphase_decimator_4_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_polyphase_decimator_4_m_axis_data_tdata_real_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip(0) => fifo2_empty_net,
    clk => clk_net_x0,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter4 : entity xil_defaultlib.sysgen_inverter_c7add3f6ea 
  port map (
    clr => '0',
    ip => soc_tready_net,
    clk => clk_net,
    ce => we_ce_net,
    op => inverter4_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => relational8_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_46ddf42584 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => soc_tready_net,
    d1 => fir_polyphase_decimator_4_m_axis_data_tvalid_net,
    d2 => relational_op_net,
    y => logical1_y_net_x2
  );
  logical8 : entity xil_defaultlib.sysgen_logical_a462d696cf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => register1_q_net,
    d1 => logical_y_net,
    y => logical8_y_net
  );
  register_x0 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    d => delay2_q_net,
    rst => relational_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register_q_net
  );
  register1 : entity xil_defaultlib.env_extr_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => delay1_q_net,
    rst => relational_op_net,
    clk => clk_net_x0,
    ce => ce_net,
    q => register1_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_27403e1f5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational8 : entity xil_defaultlib.sysgen_relational_76adedebc4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter2_op_net,
    b => constant12_op_net,
    op => relational8_op_net
  );
end structural;
-- Generated from Simulink block preProc_optimized_withcontrol_OC2_hilbTest_synchro_Q16_optim/env_extr_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_struct is
  port (
    soc_tready : in std_logic_vector( 1-1 downto 0 );
    steto_in_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    steto_in_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_25000 : in std_logic;
    ce_25000 : in std_logic;
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
end env_extr_struct;
architecture structural of env_extr_struct is 
  signal soc_tready_net : std_logic_vector( 1-1 downto 0 );
  signal steto_in_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal register1_q_net : std_logic_vector( 16-1 downto 0 );
  signal register1_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal logical8_y_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal fifo_full_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical8_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal steto_in_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal logical8_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_m_axis_data_tvalid_net : std_logic;
  signal psd_fifo_full : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical8_y_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal cordic_sqrt_m_axis_dout_tdata_real_net : std_logic_vector( 24-1 downto 0 );
  signal fifo1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal fifo3_empty_net : std_logic;
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal we_ce_net : std_logic;
  signal fir_compiler_7_2_m_axis_data_tdata_real_net : std_logic_vector( 16-1 downto 0 );
  signal fifo1_empty_net : std_logic;
  signal fifo_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fifo3_full_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal fifo3_dout_net : std_logic_vector( 24-1 downto 0 );
  signal fast_fourier_transform_9_1_fft_s_axis_data_tready_net : std_logic;
  signal fifo_empty_net : std_logic;
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo2_empty_net : std_logic;
  signal fifo2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal hilbert_fifo_full : std_logic;
  signal swt_fifo_full : std_logic;
begin
  soc_tready_net <= soc_tready;
  steto_in_axis_tdata_net <= steto_in_axis_tdata;
  steto_in_axis_tready <= fifo_full_net;
  steto_in_axis_tvalid_net <= steto_in_axis_tvalid;
  hilbert_m_data_tdata <= register1_q_net;
  hilbert_m_data_tvalid <= logical8_y_net_x1;
  homo_m_data_tdata <= register1_q_net_x0;
  homo_m_data_tvalid <= logical8_y_net_x2;
  psd_m_data_tdata <= register3_q_net;
  psd_m_data_tvalid <= logical8_y_net_x0;
  swt_m_data_tdata <= register_q_net;
  swt_m_data_tvalid <= logical8_y_net;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_25000;
  we_ce_net <= ce_25000;
  filtering : entity xil_defaultlib.env_extr_filtering 
  port map (
    m_data_tready_1 => psd_fifo_full,
    m_data_tready_2 => hilbert_fifo_full,
    m_data_tready_3 => swt_fifo_full,
    soc_tready => soc_tready_net,
    steto_in_axis_tdata => steto_in_axis_tdata_net,
    steto_in_axis_tvalid => steto_in_axis_tvalid_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    ce_25000 => we_ce_net,
    m_data_tdata => fir_compiler_7_2_m_axis_data_tdata_real_net,
    m_data_tvalid => fir_compiler_7_2_m_axis_data_tvalid_net,
    steto_in_axis_tready => fifo_full_net
  );
  hilbert : entity xil_defaultlib.env_extr_hilbert 
  port map (
    s_data_tdata => fifo_dout_net,
    s_data_tvalid => fifo_empty_net,
    homo_fifo_full_tready => fifo3_full_net,
    m_data_ready => soc_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    clk_25000 => clk_net,
    ce_25000 => we_ce_net,
    m_data_tdata => cordic_sqrt_m_axis_dout_tdata_real_net,
    m_data_tvalid => logical3_y_net,
    m_data_tready => fast_fourier_transform_9_1_fft_s_axis_data_tready_net,
    hilbert_m_data_tdata => register1_q_net,
    hilbert_m_data_tvalid => logical8_y_net_x1
  );
  homomorphic : entity xil_defaultlib.env_extr_homomorphic 
  port map (
    s_data_tdata => fifo3_dout_net,
    s_data_tvalid => fifo3_empty_net,
    m_data_tready => soc_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    clk_25000 => clk_net,
    ce_25000 => we_ce_net,
    s_data_tready => logical_y_net_x0,
    homo_m_data_tdata => register1_q_net_x0,
    homo_m_data_tvalid => logical8_y_net_x2
  );
  psd : entity xil_defaultlib.env_extr_psd 
  port map (
    s_data_tdata => fifo1_dout_net,
    s_data_tvalid => fifo1_empty_net,
    m_data_ready => soc_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    clk_25000 => clk_net,
    ce_25000 => we_ce_net,
    s_data_tready => logical1_y_net,
    psd_m_data_tdata => register3_q_net,
    psd_m_data_tvalid => logical8_y_net_x0
  );
  swt : entity xil_defaultlib.env_extr_swt 
  port map (
    s_data_tdata => fifo2_dout_net,
    s_data_tvalid => fifo2_empty_net,
    m_data_ready => soc_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    clk_25000 => clk_net,
    ce_25000 => we_ce_net,
    s_data_tready => logical_y_net,
    swt_m_data_tdata => register_q_net,
    swt_m_data_tvalid => logical8_y_net
  );
  fifo : entity xil_defaultlib.env_extr_xlfifogen_u 
  generic map (
    core_name0 => "env_extr_fifo_generator_i0",
    data_count_width => 13,
    data_width => 16,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => false,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    rst => '0',
    din => fir_compiler_7_2_m_axis_data_tdata_real_net,
    we => fir_compiler_7_2_m_axis_data_tvalid_net,
    re => fast_fourier_transform_9_1_fft_s_axis_data_tready_net,
    clk => clk_net_x0,
    ce => ce_net,
    we_ce => ce_net,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => hilbert_fifo_full
  );
  fifo1 : entity xil_defaultlib.env_extr_xlfifogen_u 
  generic map (
    core_name0 => "env_extr_fifo_generator_i0",
    data_count_width => 13,
    data_width => 16,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => false,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    rst => '0',
    din => fir_compiler_7_2_m_axis_data_tdata_real_net,
    we => fir_compiler_7_2_m_axis_data_tvalid_net,
    re => logical1_y_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    we_ce => ce_net,
    re_ce => ce_net,
    dout => fifo1_dout_net,
    empty => fifo1_empty_net,
    full => psd_fifo_full
  );
  fifo2 : entity xil_defaultlib.env_extr_xlfifogen_u 
  generic map (
    core_name0 => "env_extr_fifo_generator_i0",
    data_count_width => 13,
    data_width => 16,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => false,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    rst => '0',
    din => fir_compiler_7_2_m_axis_data_tdata_real_net,
    we => fir_compiler_7_2_m_axis_data_tvalid_net,
    re => logical_y_net(0),
    clk => clk_net_x0,
    ce => ce_net,
    we_ce => ce_net,
    re_ce => ce_net,
    dout => fifo2_dout_net,
    empty => fifo2_empty_net,
    full => swt_fifo_full
  );
  fifo3 : entity xil_defaultlib.env_extr_xlfifogen_u 
  generic map (
    core_name0 => "env_extr_fifo_generator_i1",
    data_count_width => 13,
    data_width => 24,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => false,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    rst => '0',
    din => cordic_sqrt_m_axis_dout_tdata_real_net,
    we => logical3_y_net(0),
    re => logical_y_net_x0(0),
    clk => clk_net_x0,
    ce => ce_net,
    we_ce => ce_net,
    re_ce => ce_net,
    dout => fifo3_dout_net,
    empty => fifo3_empty_net,
    full => fifo3_full_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr_default_clock_driver is
  port (
    env_extr_sysclk : in std_logic;
    env_extr_sysce : in std_logic;
    env_extr_sysclr : in std_logic;
    env_extr_clk1 : out std_logic;
    env_extr_ce1 : out std_logic;
    env_extr_clk25000 : out std_logic;
    env_extr_ce25000 : out std_logic
  );
end env_extr_default_clock_driver;
architecture structural of env_extr_default_clock_driver is 
begin
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => env_extr_sysclk,
    sysce => env_extr_sysce,
    sysclr => env_extr_sysclr,
    clk => env_extr_clk1,
    ce => env_extr_ce1
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 25000,
    log_2_period => 15
  )
  port map (
    sysclk => env_extr_sysclk,
    sysce => env_extr_sysce,
    sysclr => env_extr_sysclr,
    clk => env_extr_clk25000,
    ce => env_extr_ce25000
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity env_extr is
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
end env_extr;
architecture structural of env_extr is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "env_extr,sysgen_core_2023_2,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplus,part=xck26,speed=-2LV-c,package=sfvc784,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=10,system_simulink_period=1e-08,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=30,abs=1,accum=2,addsub=48,cmult=42,concat=2,constant=54,cordic_v6_0=2,counter=13,delay=112,dpram=5,expr=1,fifo=6,fir_compiler_v7_2=7,inv=15,logical=41,mult=10,mux=22,negate=4,register=10,reinterpret=8,relational=26,shift=127,slice=20,spram=1,sprom=2,xfft_v9_1=3,}";
  signal ce_25000_net : std_logic;
  signal ce_1_net : std_logic;
  signal clk_25000_net : std_logic;
  signal clk_1_net : std_logic;
begin
  env_extr_default_clock_driver : entity xil_defaultlib.env_extr_default_clock_driver 
  port map (
    env_extr_sysclk => clk,
    env_extr_sysce => '1',
    env_extr_sysclr => '0',
    env_extr_clk1 => clk_1_net,
    env_extr_ce1 => ce_1_net,
    env_extr_clk25000 => clk_25000_net,
    env_extr_ce25000 => ce_25000_net
  );
  env_extr_struct : entity xil_defaultlib.env_extr_struct 
  port map (
    soc_tready => soc_tready,
    steto_in_axis_tdata => steto_in_axis_tdata,
    steto_in_axis_tvalid => steto_in_axis_tvalid,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_25000 => clk_25000_net,
    ce_25000 => ce_25000_net,
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
