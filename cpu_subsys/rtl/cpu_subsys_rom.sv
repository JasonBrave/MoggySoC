module cpu_subsys_rom (
    input logic         clk,
    input logic         rst_n,
    input logic         mem_valid,
    output logic        mem_ready,
    input logic [31:0]  mem_addr,
    input logic [31:0]  mem_wdata,
    input logic [3:0]   mem_wstrb,
    output logic [31:0] mem_rdata);

    logic [31:0] mem [4096-1:0];

    always_ff @(posedge clk) begin
        if(mem_valid) begin
			mem_rdata <= mem[mem_addr[13:2]];
			mem_ready <= 1'b1;
        end else begin
			mem_ready <= 1'b0;
		end
    end // always_ff @ (posedge clk)

    initial $readmemh("../../firmware/fw.hex", mem);

endmodule // cpu_subsys_rom
