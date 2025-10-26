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
	output logic		bus_ready
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

	gpio_controller u_gpio_ctrl (
		.clk(sys_clk),
		.rst_n(rst_n),

		.paddr(bus_addr),
		.pwrite(bus_write),
		.psel(bus_valid),
		.penable(penable),
		.pstrb(bus_wstrb),
		.pwdata(bus_wdata),
		.prdata(bus_rdata),
		.pready(bus_ready),
		.pslverr(),

		.interrupt(),

		.gpio_in_data('0),
		.gpio_out_data(),
		.gpio_out_enable()
);

endmodule // gpio_subsys_top
