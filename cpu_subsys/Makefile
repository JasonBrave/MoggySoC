# Name of the IP block
IP_NAME := cpu_subsys

# CSR Block Name
CSR_BLOCK_NAME := 

# Design IP dependency in 'ip' folder
RTL_IP_DEP := 

# Design IP dependency in same folder as current ip
RTL_REPO_DEP := 

# Verification IP dependency in 'ip' folder
VERIF_IP_DEP := 

# Verification IP dependency in same folder as current ip
VERIF_REPO_DEP := 

# RTL top level module name
RTL_TOP_NAME := cpu_subsys_top

# Testbench top level module name
VERIF_TOP_NAME := 

# Default testbench name
TB_NAME := cpu_subsys_tb

# Default UVM test name
TEST :=

# FPGA Part Number
FPGA_VENDOR := xilinx
FPGA_FAMILY := xc7
FPGA_PART := xc7z010clg400-1
# FPGA_PART := xc7z020clg400-1
# FPGA_PART := xc7a200t

ifeq ($(USE_VIVADO), 1)
include ip/xilinx-flows/fpga.mk
else
include ip/flows/fpga-subsystem.mk
endif
