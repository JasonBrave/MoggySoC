module cpu_subsys_flash (
    input logic			clk,

    input logic			mem_a_valid,
    input logic [21:0]	mem_a_addr,
    output logic [31:0]	mem_a_rdata,
    output logic		mem_a_ready,

    input logic			mem_b_valid,
    input logic [21:0]	mem_b_addr,
    output logic [31:0]	mem_b_rdata,
    output logic		mem_b_ready);

    logic [31:0] rom [2**16-1:0];

	// Port A
    always_ff @(posedge clk) begin
        if(mem_a_valid) begin
			mem_a_rdata <= rom[mem_a_addr[17:2]];
			mem_a_ready <= 1'b1;
        end else begin
			mem_a_ready <= 1'b0;
		end
    end // always_ff @ (posedge clk)

	// Port B
    always_ff @(posedge clk) begin
        if(mem_b_valid) begin
			mem_b_rdata <= rom[mem_b_addr[17:2]];
			mem_b_ready <= 1'b1;
        end else begin
			mem_b_ready <= 1'b0;
		end
    end // always_ff @ (posedge clk)

    initial $readmemh("../../firmware/fw.hex", rom);

endmodule // cpu_subsys_rom
