module moggysoc_top (
    // Clock and resets
	input logic		   sys_clk,
	input logic		   rst_n,
	// External IOs
	input logic [1:0]  switches,	 // SW0 - SW1
	input logic [3:0]  push_buttons, // BTN0 - BTN3
	output logic [3:0] leds,		 // LD0 - LD3
	output logic [2:0] rgb_led_ld4,	 // LD4
	output logic [2:0] rgb_led_ld5	 // LD5
);
	
    logic		 periph_mem_valid;
    logic [30:0] periph_mem_addr;
	logic		 periph_mem_write;
    logic [31:0] periph_mem_wdata;
    logic [3:0]	 periph_mem_wstrb;
    logic [31:0] periph_mem_rdata;
    logic		 periph_mem_ready;

	cpu_subsys_top u_cpu_subsys (
		.sys_clk(sys_clk),
		.rst_n(rst_n),
		.periph_mem_valid(periph_mem_valid),
		.periph_mem_addr(periph_mem_addr),
		.periph_mem_write(periph_mem_write),
		.periph_mem_wdata(periph_mem_wdata),
		.periph_mem_wstrb(periph_mem_wstrb),
		.periph_mem_rdata(periph_mem_rdata),
		.periph_mem_ready(periph_mem_ready)
	);

	gpio_subsys_top u_gpio_subsys (
		.sys_clk(sys_clk),
		.rst_n(rst_n),
		.bus_valid(periph_mem_valid),
		.bus_addr(periph_mem_addr),
		.bus_write(periph_mem_write),
		.bus_wdata(periph_mem_wdata),
		.bus_wstrb(periph_mem_wstrb),
		.bus_rdata(periph_mem_rdata),
		.bus_ready(periph_mem_ready),
		.switches(switches),
		.push_buttons(push_buttons),
		.leds(leds),
		.rgb_led_ld4(rgb_led_ld4),
		.rgb_led_ld5(rgb_led_ld5)
   );

endmodule
