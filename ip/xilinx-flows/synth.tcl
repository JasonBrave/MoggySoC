# Initial setting
set_part $::env(FPGA_PART)

# Read SystemVerilog RTL source
source vivado_rtl_filelist.tcl

# Read XDC timing constraints
read_xdc synth/$::env(RTL_TOP_NAME).xdc

if { $::env(FPGA_TOP_LEVEL) == 1} {
	synth_design -top $::env(RTL_TOP_NAME)
} else {
	synth_design -mode out_of_context -top $::env(RTL_TOP_NAME)
}

opt_design

place_design
power_opt_design
phys_opt_design

route_design
phys_opt_design

report_utilization
report_timing
report_power

if { $::env(FPGA_TOP_LEVEL) == 1} {
	write_bitstream $::env(RTL_TOP_NAME).bit
}
