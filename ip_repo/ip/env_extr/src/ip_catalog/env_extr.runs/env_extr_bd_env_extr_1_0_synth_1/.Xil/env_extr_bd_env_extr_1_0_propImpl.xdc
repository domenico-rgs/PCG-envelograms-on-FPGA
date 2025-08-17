set_property SRC_FILE_INFO {cfile:c:/Users/windows/Desktop/HSS/Q16_40840_optim/code2/ip/env_extr/src/ip_catalog/env_extr.gen/sources_1/bd/env_extr_bd/ip/env_extr_bd_env_extr_1_0/constrs/env_extr.xdc rfile:../../../env_extr.gen/sources_1/bd/env_extr_bd/ip/env_extr_bd_env_extr_1_0/constrs/env_extr.xdc id:1 order:EARLY scoped_inst:U0} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl rfile:../../../../../../../../../../../../../Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl id:2 order:LATE scoped_inst:U0/env_extr_struct/homomorphic/log2/normalize_input/dual_port_ram/xpm_memory_tdpram_inst unmanaged:yes} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl rfile:../../../../../../../../../../../../../Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl id:3 order:LATE scoped_inst:U0/env_extr_struct/swt/shannone/log2/normalize_input/dual_port_ram/xpm_memory_tdpram_inst unmanaged:yes} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl rfile:../../../../../../../../../../../../../Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl id:4 order:LATE scoped_inst:U0/env_extr_struct/swt/shannone/log2/normalize_input/dual_port_ram3/xpm_memory_tdpram_inst unmanaged:yes} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl rfile:../../../../../../../../../../../../../Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl id:5 order:LATE scoped_inst:U0/env_extr_struct/homomorphic/log2/dual_port_ram/xpm_memory_tdpram_inst unmanaged:yes} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl rfile:../../../../../../../../../../../../../Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/tcl/xpm_memory_xdc.tcl id:6 order:LATE scoped_inst:U0/env_extr_struct/swt/shannone/log2/dual_port_ram/xpm_memory_tdpram_inst unmanaged:yes} [current_design]
current_instance U0
set_property src_info {type:SCOPED_XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
set_multicycle_path -from [get_cells -of [filter [all_fanout -flat -endpoints [get_pins {env_extr_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp/Q}]] IS_ENABLE]] -to [get_cells -of [filter [all_fanout -flat -endpoints [get_pins {env_extr_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp/Q}]] IS_ENABLE]] -hold 24999
current_instance
current_instance U0/env_extr_struct/homomorphic/log2/normalize_input/dual_port_ram/xpm_memory_tdpram_inst
set_property src_info {type:SCOPED_XDC file:2 line:55 export:INPUT save:NONE read:READ} [current_design]
set my_var [get_property dram_emb_xdc [get_cells -quiet -hier -filter {PRIMITIVE_SUBGROUP==LUTRAM || PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==uram || PRIMITIVE_SUBGROUP==BRAM}]]
current_instance
current_instance U0/env_extr_struct/swt/shannone/log2/normalize_input/dual_port_ram/xpm_memory_tdpram_inst
set_property src_info {type:SCOPED_XDC file:3 line:55 export:INPUT save:NONE read:READ} [current_design]
set my_var [get_property dram_emb_xdc [get_cells -quiet -hier -filter {PRIMITIVE_SUBGROUP==LUTRAM || PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==uram || PRIMITIVE_SUBGROUP==BRAM}]]
current_instance
current_instance U0/env_extr_struct/swt/shannone/log2/normalize_input/dual_port_ram3/xpm_memory_tdpram_inst
set_property src_info {type:SCOPED_XDC file:4 line:55 export:INPUT save:NONE read:READ} [current_design]
set my_var [get_property dram_emb_xdc [get_cells -quiet -hier -filter {PRIMITIVE_SUBGROUP==LUTRAM || PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==uram || PRIMITIVE_SUBGROUP==BRAM}]]
current_instance
current_instance U0/env_extr_struct/homomorphic/log2/dual_port_ram/xpm_memory_tdpram_inst
set_property src_info {type:SCOPED_XDC file:5 line:55 export:INPUT save:NONE read:READ} [current_design]
set my_var [get_property dram_emb_xdc [get_cells -quiet -hier -filter {PRIMITIVE_SUBGROUP==LUTRAM || PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==uram || PRIMITIVE_SUBGROUP==BRAM}]]
current_instance
current_instance U0/env_extr_struct/swt/shannone/log2/dual_port_ram/xpm_memory_tdpram_inst
set_property src_info {type:SCOPED_XDC file:6 line:55 export:INPUT save:NONE read:READ} [current_design]
set my_var [get_property dram_emb_xdc [get_cells -quiet -hier -filter {PRIMITIVE_SUBGROUP==LUTRAM || PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==uram || PRIMITIVE_SUBGROUP==BRAM}]]
