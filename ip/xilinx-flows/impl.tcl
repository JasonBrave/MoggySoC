# Initial setting
set_part $::env(FPGA_PART)

# Read SystemVerilog RTL source
source vivado_rtl_filelist.tcl

# Read XDC timing constraints
read_xdc synth/$::env(RTL_TOP_NAME).xdc

if { $::env(FPGA_TOP_LEVEL) == 1} {
	synth_design -top $::env(RTL_TOP_NAME) -verbose
} else {
	synth_design -mode out_of_context -top $::env(RTL_TOP_NAME) -verbose
}

opt_design -verbose

write_checkpoint dataout/synth/$::env(RTL_TOP_NAME).dcp
write_verilog dataout/synth/$::env(RTL_TOP_NAME).v

place_design -verbose
phys_opt_design -verbose

route_design -verbose
phys_opt_design -verbose

report_utilization -file dataout/impl/utilization.rpt
report_timing_summary -max_paths 10 -nworst 1 -file dataout/impl/timing.rpt
report_power -file dataout/impl/power.rpt

write_checkpoint dataout/impl/$::env(RTL_TOP_NAME).dcp
write_sdf dataout/impl/$::env(RTL_TOP_NAME).sdf
write_verilog dataout/impl/$::env(RTL_TOP_NAME).v

if { $::env(FPGA_TOP_LEVEL) == 1} {
	write_bitstream dataout/impl/$::env(RTL_TOP_NAME).bit
}
