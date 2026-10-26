module cpu_subsys_tcm (
    input logic			clk,

    input logic			mem_a_valid,
    input logic [20:0]	mem_a_addr,
	input logic			mem_a_write,
    input logic [31:0]	mem_a_wdata,
    input logic [3:0]	mem_a_wstrb,
    output logic [31:0]	mem_a_rdata,
    output logic		mem_a_ready,

    input logic			mem_b_valid,
    input logic [20:0]	mem_b_addr,
    output logic [31:0]	mem_b_rdata,
    output logic		mem_b_ready);

    logic [31:0] mem [2**14-1:0];

    always_ff @(posedge clk) begin
        if(mem_a_valid) begin
			if(mem_a_write) begin
				if(mem_a_wstrb[0]) mem[mem_a_addr[15:2]][7:0] <= mem_a_wdata[7:0];
				if(mem_a_wstrb[1]) mem[mem_a_addr[15:2]][15:8] <= mem_a_wdata[15:8];
				if(mem_a_wstrb[2]) mem[mem_a_addr[15:2]][23:16] <= mem_a_wdata[23:16];
				if(mem_a_wstrb[3]) mem[mem_a_addr[15:2]][31:24] <= mem_a_wdata[31:24];
			end

			mem_a_rdata <= mem[mem_a_addr[15:2]];
			mem_a_ready <= 1'b1;
        end else begin
			mem_a_ready <= 1'b0;
		end // else: !if(mem_a_valid)

        if(mem_b_valid) begin
			mem_b_rdata <= mem[mem_b_addr[15:2]];
			mem_b_ready <= 1'b1;
        end else begin
			mem_b_ready <= 1'b0;
		end
    end

endmodule // cpu_subsys_sram
