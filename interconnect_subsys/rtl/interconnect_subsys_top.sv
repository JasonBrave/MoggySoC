module interconnect_subsys_top (
	// Clock and reset
	input logic			sys_clk,
	input logic			rst_n,
	// Host Interface
	input logic			host_valid,
    input logic [30:0]	host_addr,
	input logic			host_write,
    input logic [31:0]	host_wdata,
    input logic [3:0]	host_wstrb,
    output logic [31:0]	host_rdata,
    output logic		host_ready,
	// GPIO
	output logic		gpio_valid,
    output logic [23:0]	gpio_addr,
	output logic		gpio_write,
    output logic [31:0]	gpio_wdata,
	output logic [3:0]	gpio_wstrb,
	input logic [31:0]	gpio_rdata,
	input logic			gpio_ready
);

	assign gpio_valid = host_valid;
	assign gpio_addr = host_addr[23:0];
	assign gpio_write = host_write;
	assign gpio_wdata = host_wdata;
	assign gpio_wstrb = host_wstrb;
	assign host_rdata = gpio_rdata;
	assign host_ready = gpio_ready;

endmodule
