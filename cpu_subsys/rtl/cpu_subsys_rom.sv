module cpu_subsys_rom (
    input logic         clk,
    input logic         rst_n,
    input logic         mem_valid,
    output logic        mem_ready,
    input logic [31:0]  mem_addr,
    input logic [31:0]  mem_wdata,
    input logic [3:0]   mem_wstrb,
    output logic [31:0] mem_rdata);

    logic [31:0] rom [4096-1:0];

    assign mem_ready = 1'b1;
    assign mem_rdata = rom[mem_addr[15:2]];

    initial $readmemh("../../firmware/fw.hex", rom);

endmodule // cpu_subsys_rom
