export RTL_TOP_NAME
export FPGA_PART
export FPGA_TOP_LEVEL

# RTL file list
RTL_FLIST_IP_ARG := $(foreach ip, $(RTL_IP_DEP), $(addprefix -F ip/, $(addsuffix /rtl/source.f, $(ip))))
RTL_FLIST_REPO_ARG := $(foreach ip, $(RTL_REPO_DEP), $(addprefix -F ../, $(addsuffix /rtl/source.f, $(ip))))

RTL_FLIST_ARG := $(RTL_FLIST_IP_ARG) $(RTL_FLIST_REPO_ARG) -F rtl/source.f

# Testbench file
TB_FILE := tb/$(TB_NAME).sv

vivado_rtl_filelist.tcl:
	$(dir $(lastword $(MAKEFILE_LIST)))/vivado_filelist.py $(RTL_FLIST_ARG) > vivado_rtl_filelist.tcl

xvlog_rtl_filelist.sh:
	$(dir $(lastword $(MAKEFILE_LIST)))/xvlog_filelist.py $(RTL_FLIST_ARG) > xvlog_rtl_filelist.sh

# Simple SystemVerilog Testbench Simulation
# Build simulation executable
sim/xsim.dir/work.$(TB_NAME)/xsimk: xvlog_rtl_filelist.sh
	mkdir -p sim
	bash xvlog_rtl_filelist.sh
	xvlog --sv $(TB_FILE) --work work=sim/xsim.dir/work
	cd sim ; xelab $(TB_NAME)

.PHONY: build-tb-sim
build-tb-sim: sim/xsim.dir/work.$(TB_NAME)/xsimk

.PHONY: run-tb-sim
run-tb-sim: sim/xsim.dir/work.$(TB_NAME)/xsimk
	cd sim ; xsim -R $(TB_NAME)

ifeq ($(GUI), 1)

.PHONY: synth
synth: vivado_rtl_filelist.tcl
	vivado -mode gui -source ip/xilinx-flows/synth.tcl

else

.PHONY: synth
synth: vivado_rtl_filelist.tcl
	vivado -mode batch -source ip/xilinx-flows/synth.tcl

endif

.PHONY: clean
clean:
	rm -rf vivado_rtl_filelist.tcl xvlog_rtl_filelist.sh vivado*.jou vivado*.log tight_setup_hold_pins.txt clockInfo.txt .Xil sim xvlog.* abc.history *.bit
