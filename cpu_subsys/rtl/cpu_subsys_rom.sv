module cpu_subsys_rom (
    input logic			clk,
    input logic			rst_n,

    input logic			mem_a_valid,
    input logic [29:0]	mem_a_addr,
	input logic			mem_a_write,
    input logic [31:0]	mem_a_wdata,
    input logic [3:0]	mem_a_wstrb,
    output logic [31:0]	mem_a_rdata,
    output logic		mem_a_ready,

    input logic			mem_b_valid,
    input logic [29:0]	mem_b_addr,
	input logic			mem_b_write,
    input logic [31:0]	mem_b_wdata,
    input logic [3:0]	mem_b_wstrb,
    output logic [31:0]	mem_b_rdata,
    output logic		mem_b_ready);

    logic [31:0] rom [16384-1:0];

	// Port A
    always_ff @(posedge clk) begin
        if(mem_a_valid) begin
			mem_a_rdata <= rom[mem_a_addr[15:2]];
			mem_a_ready <= 1'b1;
        end else begin
			mem_a_ready <= 1'b0;
		end
    end // always_ff @ (posedge clk)

	// Port B
    always_ff @(posedge clk) begin
        if(mem_b_valid) begin
			mem_b_rdata <= rom[mem_b_addr[15:2]];
			mem_b_ready <= 1'b1;
        end else begin
			mem_b_ready <= 1'b0;
		end
    end // always_ff @ (posedge clk)

    initial $readmemh("../../firmware/fw.hex", rom);

endmodule // cpu_subsys_rom
