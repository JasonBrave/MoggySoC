# RTL top level module name
RTL_TOP_NAME := moggysoc_top

# CSR Block Name
CSR_BLOCK_NAME := 

# Design IP dependency in 'ip' folder
RTL_IP_DEP := gpio_controller

# Design IP dependency in same folder as current ip
RTL_REPO_DEP := cpu_subsys gpio_subsys

# Verification IP dependency in 'ip' folder
VERIF_IP_DEP := 

# Verification IP dependency in same folder as current ip
VERIF_REPO_DEP := 

# Default testbench name
TB_NAME := moggysoc_tb

# Testbench top level module name
VERIF_TOP_NAME := 

# Default UVM test name
TEST := 

# FPGA Part Number
FPGA_VENDOR := xilinx
FPGA_FAMILY := xc7
FPGA_PART := xc7z010clg400-1
# FPGA_PART := xc7z020clg400-1
# FPGA_PART := xc7a200t

FPGA_TOP_LEVEL := 1

ifeq ($(USE_VIVADO), 1)
include ip/xilinx-flows/fpga.mk
else
include ip/flows/fpga-subsystem.mk
endif
