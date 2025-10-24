export RTL_TOP_NAME

.PHONY: synth
synth:
	vivado -mode batch -source ip/xilinx-flows/synth.tcl
