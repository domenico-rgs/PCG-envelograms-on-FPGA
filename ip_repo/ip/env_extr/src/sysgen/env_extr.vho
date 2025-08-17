  sysgen_dut : entity xil_defaultlib.env_extr 
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
