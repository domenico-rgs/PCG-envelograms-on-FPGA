set rateCeenv_extr25000 env_extr_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsenv_extr25000 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeenv_extr25000/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsenv_extr25000 -to $rateCellsenv_extr25000 -setup 25000
set_multicycle_path -from $rateCellsenv_extr25000 -to $rateCellsenv_extr25000 -hold 24999
