export RTL_TOP_NAME
export FPGA_PART

# RTL file list
RTL_FLIST_IP_ARG := $(foreach ip, $(RTL_IP_DEP), $(addprefix -F ip/, $(addsuffix /rtl/source.f, $(ip))))
RTL_FLIST_REPO_ARG := $(foreach ip, $(RTL_REPO_DEP), $(addprefix -F ../, $(addsuffix /rtl/source.f, $(ip))))

RTL_FLIST_ARG := $(RTL_FLIST_IP_ARG) $(RTL_FLIST_REPO_ARG) -F rtl/source.f

vivado_rtl_filelist.tcl:
	$(dir $(lastword $(MAKEFILE_LIST)))/vivado_filelist.py $(RTL_FLIST_ARG) > vivado_rtl_filelist.tcl

.PHONY: synth
synth: vivado_rtl_filelist.tcl
	vivado -mode batch -source ip/xilinx-flows/synth.tcl

.PHONY: clean
clean:
	rm -rf vivado_rtl_filelist.tcl vivado*.jou vivado*.log tight_setup_hold_pins.txt clockInfo.txt .Xil
