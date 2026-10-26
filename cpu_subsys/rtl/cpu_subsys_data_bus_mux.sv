module cpu_subsys_data_bus_mux (
    // Clock and reset
    input logic			sys_clk,
    input logic			rst_n,
    // CPU Memory Interface
    input logic			cpu_mem_valid,
    output logic		cpu_mem_ready,
    input logic [31:0]	cpu_mem_addr,
    input logic [31:0]	cpu_mem_wdata,
    input logic			cpu_mem_we,
    input logic [3:0]	cpu_mem_be,
    output logic [31:0]	cpu_mem_rdata,
    // Flash Memory Interface
    output logic		flash_mem_valid,
    output logic [21:0]	flash_mem_addr,
	output logic		flash_mem_write,
    output logic [31:0]	flash_mem_wdata,
    output logic [3:0]	flash_mem_wstrb,
    input logic [31:0]	flash_mem_rdata,
    input logic			flash_mem_ready,
    // ITCM Memory Interface
    output logic		itcm_mem_valid,
    output logic [20:0]	itcm_mem_addr,
	output logic		itcm_mem_write,
    output logic [31:0]	itcm_mem_wdata,
    output logic [3:0]	itcm_mem_wstrb,
    input logic [31:0]	itcm_mem_rdata,
    input logic			itcm_mem_ready,
    // DTCM Memory Interface
    output logic		dtcm_mem_valid,
    output logic [20:0]	dtcm_mem_addr,
	output logic		dtcm_mem_write,
    output logic [31:0]	dtcm_mem_wdata,
    output logic [3:0]	dtcm_mem_wstrb,
    input logic [31:0]	dtcm_mem_rdata,
    input logic			dtcm_mem_ready,
    // AHB Memory Interface
    output logic		ahb_mem_valid,
    output logic [31:0]	ahb_mem_addr,
	output logic		ahb_mem_write,
    output logic [31:0]	ahb_mem_wdata,
    output logic [3:0]	ahb_mem_wstrb,
    input logic [31:0]	ahb_mem_rdata,
    input logic			ahb_mem_ready
);

    // Pass-through signals
    assign flash_mem_addr = cpu_mem_addr[21:0];
    assign itcm_mem_addr = cpu_mem_addr[20:0];
    assign dtcm_mem_addr = cpu_mem_addr[20:0];
	assign ahb_mem_addr = cpu_mem_addr;

	assign flash_mem_write = cpu_mem_we;
	assign itcm_mem_write = cpu_mem_we;
	assign dtcm_mem_write = cpu_mem_we;
	assign ahb_mem_write = cpu_mem_we;
    
    assign flash_mem_wdata = cpu_mem_wdata;
    assign itcm_mem_wdata = cpu_mem_wdata;
    assign dtcm_mem_wdata = cpu_mem_wdata;
	assign ahb_mem_wdata = cpu_mem_wdata;

    assign flash_mem_wstrb = cpu_mem_be;
    assign itcm_mem_wstrb = cpu_mem_be;
    assign dtcm_mem_wstrb = cpu_mem_be;
	assign ahb_mem_wstrb = cpu_mem_be;

    // Decoder
    always_comb begin
        flash_mem_valid = 1'b0;
        itcm_mem_valid = 1'b0;
        dtcm_mem_valid = 1'b0;
		ahb_mem_valid = 1'b0;

        unique case (cpu_mem_addr[31:21])
            11'h00: begin
                flash_mem_valid = cpu_mem_valid;
            end
            11'h01: begin
                flash_mem_valid = cpu_mem_valid;
            end
            11'h02: begin
                itcm_mem_valid = cpu_mem_valid;
            end
            11'h03: begin
                dtcm_mem_valid = cpu_mem_valid;
            end
            default: begin
                ahb_mem_valid = cpu_mem_valid;
            end
        endcase // unique case (cpu_mem_addr[31:21])
    end

    logic muxed_ready;

    // Read Mux
    always_comb begin
        unique case (cpu_mem_addr[31:21])
            11'h00: begin
                muxed_ready = flash_mem_ready;
                cpu_mem_rdata = flash_mem_rdata;
            end
            11'h01: begin
                muxed_ready = flash_mem_ready;
                cpu_mem_rdata = flash_mem_rdata;
            end
            11'h02: begin
                muxed_ready = itcm_mem_ready;
                cpu_mem_rdata = itcm_mem_rdata;
            end
            11'h03: begin
                muxed_ready = dtcm_mem_ready;
                cpu_mem_rdata = dtcm_mem_rdata;
            end
            default: begin
                muxed_ready = ahb_mem_ready;
                cpu_mem_rdata = ahb_mem_rdata;
            end
        endcase // unique case (cpu_mem_addr[31:21])
    end // always_comb

    // Only assert ready when there's an outstanding transaction
    logic trans_active;
    always_ff @(posedge sys_clk or negedge rst_n) begin
        if(!rst_n) begin
            trans_active <= 1'b0;
        end else begin
            if(cpu_mem_valid) begin
                trans_active <= 1'b1;
            end else if(muxed_ready) begin
                trans_active <= 1'b0;
            end
        end
    end // always_ff @ (posedge sys_clk or negedge rst_n)

    assign cpu_mem_ready = muxed_ready & trans_active;

endmodule // cpu_subsys_host_bridge
