/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off PINMISSING */

module gpio_subsys_top (
    // Clock and resets
    input logic			sys_clk,
    input logic			rst_n,
    // Peripheral memory bus
    input logic			bus_valid,
    input logic [23:0]	bus_addr,
	input logic			bus_write,
    input logic [31:0]	bus_wdata,
	input logic [3:0]	bus_wstrb,
	output logic [31:0]	bus_rdata,
	output logic		bus_ready,
	// External IOs
	input logic [1:0]	switches,	  // SW0 - SW1
	input logic [3:0]	push_buttons, // BTN0 - BTN3
	output logic [3:0]	leds,		  // LD0 - LD3
	output logic [2:0]	rgb_led_ld4,  // LD4
	output logic [2:0]	rgb_led_ld5,  // LD5
	// Interrupt
	output logic		interrupt
);

	logic penable;

	always_ff @(posedge sys_clk or negedge rst_n) begin
		if(~rst_n) begin
			penable <= 1'b0;
		end else begin
			if(bus_ready == 1'b1) begin
				penable <= 1'b0;
			end else if(bus_valid == 1'b1) begin
				penable <= 1'b1;
			end
		end
	end

	logic [255:0] gpio_out;

	gpio_controller u_gpio_ctrl (
		.clk(sys_clk),
		.rst_n(rst_n),

		.paddr(bus_addr[10:0]),
		.pwrite(bus_write),
		.psel(bus_valid),
		.penable(penable),
		.pstrb(bus_wstrb),
		.pwdata(bus_wdata),
		.prdata(bus_rdata),
		.pready(bus_ready),
		.pslverr(),

		.interrupt(interrupt),

		.gpio_in_data({192'h0, {30'h0, switches}, {28'h0, push_buttons}}), // Note gpio_controller have built-in synchronizers
		.gpio_out_data(gpio_out),
		.gpio_out_enable()
	);

	assign leds = gpio_out[64+:4];
	assign rgb_led_ld4 = gpio_out[96+:3];
	assign rgb_led_ld5 = gpio_out[128+:3];

endmodule // gpio_subsys_top
