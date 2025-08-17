# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set VHDL2008Support 1
	set AnalyzeTiming 1
	set AnalyzeTimingNumPaths {10000}
	set AnalyzeTimingPostImplementation 1
	set AnalyzeTimingPostSynthesis 0
	set BoardFileVersion {1.2}
	set BoardName {kv260_som}
	set BoardRevision {Rev_B01}
	set BoardVendor {xilinx.com}
	set Compilation {IP Catalog}
	set CompilationFlow {IP}
	set CreateInterfaceDocument {off}
	set DSPDevice {xck26}
	set DSPFamily {zynquplus}
	set DSPPackage {sfvc784}
	set DSPSpeed {-2LV-c}
	set FPGAClockPeriod 10
	set GenerateTestBench 0
	set HDLLanguage {vhdl}
	set IPOOCCacheRootPath {C:/Users/windows/AppData/Local/Xilinx/Sysgen/SysgenVivado/win64.o/ip}
	set IP_Auto_Infer {1}
	set IP_Categories_Text {Vitis Model Composer}
	set IP_Common_Repos {0}
	set IP_Description {}
	set IP_Dir {}
	set IP_Library_Text {VMC}
	set IP_LifeCycle_Menu {1}
	set IP_Logo {sysgen_icon_100.png}
	set IP_Name {env_extr}
	set IP_Revision {361126387}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {env_extr}
	set ProjectFiles {
		{{conv_pkg.vhd} -lib {xil_defaultlib}}
		{{synth_reg.vhd} -lib {xil_defaultlib}}
		{{synth_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{srl17e.vhd} -lib {xil_defaultlib}}
		{{srl33e.vhd} -lib {xil_defaultlib}}
		{{synth_reg_reg.vhd} -lib {xil_defaultlib}}
		{{single_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{xlclockdriver_rd.vhd} -lib {xil_defaultlib}}
		{{vivado_ip.tcl}}
		{{xpm_79bbae_vivado.mem}}
		{{xpm_134b5e_vivado.mem}}
		{{xpm_847733_vivado.mem}}
		{{xpm_2c8012_vivado.mem}}
		{{xpm_37e064_vivado.mem}}
		{{env_extr_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{env_extr.vhd} -lib {xil_defaultlib}}
		{{env_extr_clock.xdc}}
		{{env_extr.xdc}}
	}
	set SimPeriod 1e-08
	set SimTime 30
	set SimulationTime {30000000210.00000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {C:/Users/windows/Desktop/HSS/Q16_40840_optim/code2/ip/env_extr/src}
	set TopLevelModule {env_extr}
	set TopLevelSimulinkHandle 44.0001
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface steto_in_axis_tvalid Name {steto_in_axis_tvalid}
	dict set TopLevelPortInterface steto_in_axis_tvalid Type Bool
	dict set TopLevelPortInterface steto_in_axis_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface steto_in_axis_tvalid BinaryPoint 0
	dict set TopLevelPortInterface steto_in_axis_tvalid Width 1
	dict set TopLevelPortInterface steto_in_axis_tvalid DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_filtering_steto_in_axis_steto_.dat}
	dict set TopLevelPortInterface steto_in_axis_tvalid IconText {steto_in_axis_tvalid}
	dict set TopLevelPortInterface steto_in_axis_tvalid Direction in
	dict set TopLevelPortInterface steto_in_axis_tvalid Period 25000
	dict set TopLevelPortInterface steto_in_axis_tvalid Interface 0
	dict set TopLevelPortInterface steto_in_axis_tvalid InterfaceName {}
	dict set TopLevelPortInterface steto_in_axis_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface steto_in_axis_tvalid ClockDomain {env_extr}
	dict set TopLevelPortInterface steto_in_axis_tvalid Locs {}
	dict set TopLevelPortInterface steto_in_axis_tvalid IOStandard {}
	dict set TopLevelPortInterface steto_in_axis_tdata Name {steto_in_axis_tdata}
	dict set TopLevelPortInterface steto_in_axis_tdata Type Fix_16_15
	dict set TopLevelPortInterface steto_in_axis_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface steto_in_axis_tdata BinaryPoint 15
	dict set TopLevelPortInterface steto_in_axis_tdata Width 16
	dict set TopLevelPortInterface steto_in_axis_tdata DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_filtering_steto_in_axis_steto_.dat}
	dict set TopLevelPortInterface steto_in_axis_tdata IconText {steto_in_axis_tdata}
	dict set TopLevelPortInterface steto_in_axis_tdata Direction in
	dict set TopLevelPortInterface steto_in_axis_tdata Period 25000
	dict set TopLevelPortInterface steto_in_axis_tdata Interface 0
	dict set TopLevelPortInterface steto_in_axis_tdata InterfaceName {}
	dict set TopLevelPortInterface steto_in_axis_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface steto_in_axis_tdata ClockDomain {env_extr}
	dict set TopLevelPortInterface steto_in_axis_tdata Locs {}
	dict set TopLevelPortInterface steto_in_axis_tdata IOStandard {}
	dict set TopLevelPortInterface soc_tready Name {soc_tready}
	dict set TopLevelPortInterface soc_tready Type Bool
	dict set TopLevelPortInterface soc_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface soc_tready BinaryPoint 0
	dict set TopLevelPortInterface soc_tready Width 1
	dict set TopLevelPortInterface soc_tready DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_filtering_soc_tready.dat}
	dict set TopLevelPortInterface soc_tready IconText {soc_tready}
	dict set TopLevelPortInterface soc_tready Direction in
	dict set TopLevelPortInterface soc_tready Period 25000
	dict set TopLevelPortInterface soc_tready Interface 0
	dict set TopLevelPortInterface soc_tready InterfaceName {}
	dict set TopLevelPortInterface soc_tready InterfaceString {DATA}
	dict set TopLevelPortInterface soc_tready ClockDomain {env_extr}
	dict set TopLevelPortInterface soc_tready Locs {}
	dict set TopLevelPortInterface soc_tready IOStandard {}
	dict set TopLevelPortInterface steto_in_axis_tready Name {steto_in_axis_tready}
	dict set TopLevelPortInterface steto_in_axis_tready Type Bool
	dict set TopLevelPortInterface steto_in_axis_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface steto_in_axis_tready BinaryPoint 0
	dict set TopLevelPortInterface steto_in_axis_tready Width 1
	dict set TopLevelPortInterface steto_in_axis_tready DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_filtering_steto_in_axis_steto_in_axis_tready.dat}
	dict set TopLevelPortInterface steto_in_axis_tready IconText {steto_in_axis_tready}
	dict set TopLevelPortInterface steto_in_axis_tready Direction out
	dict set TopLevelPortInterface steto_in_axis_tready Period 1
	dict set TopLevelPortInterface steto_in_axis_tready Interface 0
	dict set TopLevelPortInterface steto_in_axis_tready InterfaceName {}
	dict set TopLevelPortInterface steto_in_axis_tready InterfaceString {DATA}
	dict set TopLevelPortInterface steto_in_axis_tready ClockDomain {env_extr}
	dict set TopLevelPortInterface steto_in_axis_tready Locs {}
	dict set TopLevelPortInterface steto_in_axis_tready IOStandard {}
	dict set TopLevelPortInterface hilbert_m_data_tdata Name {hilbert_m_data_tdata}
	dict set TopLevelPortInterface hilbert_m_data_tdata Type Fix_16_13
	dict set TopLevelPortInterface hilbert_m_data_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface hilbert_m_data_tdata BinaryPoint 13
	dict set TopLevelPortInterface hilbert_m_data_tdata Width 16
	dict set TopLevelPortInterface hilbert_m_data_tdata DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_hilbert_hilbert_m_data_tdata.dat}
	dict set TopLevelPortInterface hilbert_m_data_tdata IconText {hilbert_m_data_tdata}
	dict set TopLevelPortInterface hilbert_m_data_tdata Direction out
	dict set TopLevelPortInterface hilbert_m_data_tdata Period 1
	dict set TopLevelPortInterface hilbert_m_data_tdata Interface 0
	dict set TopLevelPortInterface hilbert_m_data_tdata InterfaceName {}
	dict set TopLevelPortInterface hilbert_m_data_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface hilbert_m_data_tdata ClockDomain {env_extr}
	dict set TopLevelPortInterface hilbert_m_data_tdata Locs {}
	dict set TopLevelPortInterface hilbert_m_data_tdata IOStandard {}
	dict set TopLevelPortInterface hilbert_m_data_tvalid Name {hilbert_m_data_tvalid}
	dict set TopLevelPortInterface hilbert_m_data_tvalid Type Bool
	dict set TopLevelPortInterface hilbert_m_data_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface hilbert_m_data_tvalid BinaryPoint 0
	dict set TopLevelPortInterface hilbert_m_data_tvalid Width 1
	dict set TopLevelPortInterface hilbert_m_data_tvalid DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_hilbert_hilbert_m_data_tvalid.dat}
	dict set TopLevelPortInterface hilbert_m_data_tvalid IconText {hilbert_m_data_tvalid}
	dict set TopLevelPortInterface hilbert_m_data_tvalid Direction out
	dict set TopLevelPortInterface hilbert_m_data_tvalid Period 1
	dict set TopLevelPortInterface hilbert_m_data_tvalid Interface 0
	dict set TopLevelPortInterface hilbert_m_data_tvalid InterfaceName {}
	dict set TopLevelPortInterface hilbert_m_data_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface hilbert_m_data_tvalid ClockDomain {env_extr}
	dict set TopLevelPortInterface hilbert_m_data_tvalid Locs {}
	dict set TopLevelPortInterface hilbert_m_data_tvalid IOStandard {}
	dict set TopLevelPortInterface homo_m_data_tdata Name {homo_m_data_tdata}
	dict set TopLevelPortInterface homo_m_data_tdata Type Fix_16_14
	dict set TopLevelPortInterface homo_m_data_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface homo_m_data_tdata BinaryPoint 14
	dict set TopLevelPortInterface homo_m_data_tdata Width 16
	dict set TopLevelPortInterface homo_m_data_tdata DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_homomorphic_homo_m_data_tdata.dat}
	dict set TopLevelPortInterface homo_m_data_tdata IconText {homo_m_data_tdata}
	dict set TopLevelPortInterface homo_m_data_tdata Direction out
	dict set TopLevelPortInterface homo_m_data_tdata Period 1
	dict set TopLevelPortInterface homo_m_data_tdata Interface 0
	dict set TopLevelPortInterface homo_m_data_tdata InterfaceName {}
	dict set TopLevelPortInterface homo_m_data_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface homo_m_data_tdata ClockDomain {env_extr}
	dict set TopLevelPortInterface homo_m_data_tdata Locs {}
	dict set TopLevelPortInterface homo_m_data_tdata IOStandard {}
	dict set TopLevelPortInterface homo_m_data_tvalid Name {homo_m_data_tvalid}
	dict set TopLevelPortInterface homo_m_data_tvalid Type Bool
	dict set TopLevelPortInterface homo_m_data_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface homo_m_data_tvalid BinaryPoint 0
	dict set TopLevelPortInterface homo_m_data_tvalid Width 1
	dict set TopLevelPortInterface homo_m_data_tvalid DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_homomorphic_homo_m_data_tvalid.dat}
	dict set TopLevelPortInterface homo_m_data_tvalid IconText {homo_m_data_tvalid}
	dict set TopLevelPortInterface homo_m_data_tvalid Direction out
	dict set TopLevelPortInterface homo_m_data_tvalid Period 1
	dict set TopLevelPortInterface homo_m_data_tvalid Interface 0
	dict set TopLevelPortInterface homo_m_data_tvalid InterfaceName {}
	dict set TopLevelPortInterface homo_m_data_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface homo_m_data_tvalid ClockDomain {env_extr}
	dict set TopLevelPortInterface homo_m_data_tvalid Locs {}
	dict set TopLevelPortInterface homo_m_data_tvalid IOStandard {}
	dict set TopLevelPortInterface psd_m_data_tdata Name {psd_m_data_tdata}
	dict set TopLevelPortInterface psd_m_data_tdata Type Fix_32_27
	dict set TopLevelPortInterface psd_m_data_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface psd_m_data_tdata BinaryPoint 27
	dict set TopLevelPortInterface psd_m_data_tdata Width 32
	dict set TopLevelPortInterface psd_m_data_tdata DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_psd_psd_m_data_tdata.dat}
	dict set TopLevelPortInterface psd_m_data_tdata IconText {psd_m_data_tdata}
	dict set TopLevelPortInterface psd_m_data_tdata Direction out
	dict set TopLevelPortInterface psd_m_data_tdata Period 1
	dict set TopLevelPortInterface psd_m_data_tdata Interface 0
	dict set TopLevelPortInterface psd_m_data_tdata InterfaceName {}
	dict set TopLevelPortInterface psd_m_data_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface psd_m_data_tdata ClockDomain {env_extr}
	dict set TopLevelPortInterface psd_m_data_tdata Locs {}
	dict set TopLevelPortInterface psd_m_data_tdata IOStandard {}
	dict set TopLevelPortInterface psd_m_data_tvalid Name {psd_m_data_tvalid}
	dict set TopLevelPortInterface psd_m_data_tvalid Type Bool
	dict set TopLevelPortInterface psd_m_data_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface psd_m_data_tvalid BinaryPoint 0
	dict set TopLevelPortInterface psd_m_data_tvalid Width 1
	dict set TopLevelPortInterface psd_m_data_tvalid DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_psd_psd_m_data_tvalid.dat}
	dict set TopLevelPortInterface psd_m_data_tvalid IconText {psd_m_data_tvalid}
	dict set TopLevelPortInterface psd_m_data_tvalid Direction out
	dict set TopLevelPortInterface psd_m_data_tvalid Period 1
	dict set TopLevelPortInterface psd_m_data_tvalid Interface 0
	dict set TopLevelPortInterface psd_m_data_tvalid InterfaceName {}
	dict set TopLevelPortInterface psd_m_data_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface psd_m_data_tvalid ClockDomain {env_extr}
	dict set TopLevelPortInterface psd_m_data_tvalid Locs {}
	dict set TopLevelPortInterface psd_m_data_tvalid IOStandard {}
	dict set TopLevelPortInterface swt_m_data_tdata Name {swt_m_data_tdata}
	dict set TopLevelPortInterface swt_m_data_tdata Type Fix_16_8
	dict set TopLevelPortInterface swt_m_data_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface swt_m_data_tdata BinaryPoint 8
	dict set TopLevelPortInterface swt_m_data_tdata Width 16
	dict set TopLevelPortInterface swt_m_data_tdata DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_swt_swt_m_data_tdata.dat}
	dict set TopLevelPortInterface swt_m_data_tdata IconText {swt_m_data_tdata}
	dict set TopLevelPortInterface swt_m_data_tdata Direction out
	dict set TopLevelPortInterface swt_m_data_tdata Period 1
	dict set TopLevelPortInterface swt_m_data_tdata Interface 0
	dict set TopLevelPortInterface swt_m_data_tdata InterfaceName {}
	dict set TopLevelPortInterface swt_m_data_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface swt_m_data_tdata ClockDomain {env_extr}
	dict set TopLevelPortInterface swt_m_data_tdata Locs {}
	dict set TopLevelPortInterface swt_m_data_tdata IOStandard {}
	dict set TopLevelPortInterface swt_m_data_tvalid Name {swt_m_data_tvalid}
	dict set TopLevelPortInterface swt_m_data_tvalid Type Bool
	dict set TopLevelPortInterface swt_m_data_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface swt_m_data_tvalid BinaryPoint 0
	dict set TopLevelPortInterface swt_m_data_tvalid Width 1
	dict set TopLevelPortInterface swt_m_data_tvalid DatFile {preproc_optimized_withcontrol_oc2_hilbtest_synchro_q16_optim_env_extr_swt_swt_m_data_tvalid.dat}
	dict set TopLevelPortInterface swt_m_data_tvalid IconText {swt_m_data_tvalid}
	dict set TopLevelPortInterface swt_m_data_tvalid Direction out
	dict set TopLevelPortInterface swt_m_data_tvalid Period 1
	dict set TopLevelPortInterface swt_m_data_tvalid Interface 0
	dict set TopLevelPortInterface swt_m_data_tvalid InterfaceName {}
	dict set TopLevelPortInterface swt_m_data_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface swt_m_data_tvalid ClockDomain {env_extr}
	dict set TopLevelPortInterface swt_m_data_tvalid Locs {}
	dict set TopLevelPortInterface swt_m_data_tvalid IOStandard {}
	dict set TopLevelPortInterface clk Name {clk}
	dict set TopLevelPortInterface clk Type -
	dict set TopLevelPortInterface clk ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clk BinaryPoint 0
	dict set TopLevelPortInterface clk Width 1
	dict set TopLevelPortInterface clk DatFile {}
	dict set TopLevelPortInterface clk Direction in
	dict set TopLevelPortInterface clk Period 1
	dict set TopLevelPortInterface clk Interface 6
	dict set TopLevelPortInterface clk InterfaceName {}
	dict set TopLevelPortInterface clk InterfaceString {CLOCK}
	dict set TopLevelPortInterface clk ClockDomain {env_extr}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project