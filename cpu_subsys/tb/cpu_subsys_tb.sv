module cpu_subsys_tb;

    logic sys_clk;
    logic rst_n;

    // Peripheral memory bus
    logic periph_mem_valid;
	logic periph_mem_ready;
	logic [31:0] periph_mem_addr;
	logic [31:0] periph_mem_wdata;
	logic [3:0]	 periph_mem_wstrb;
	logic [31:0] periph_mem_rdata;

    cpu_subsys_top u_cpu_subsys_top (.*);

	assign periph_mem_rdata = '0;

	always_ff @(posedge sys_clk or negedge rst_n) begin
		if(~rst_n) begin
			periph_mem_ready <= 1'b0;
		end else begin
			if(periph_mem_valid && (periph_mem_addr == 32'h80000004) && periph_mem_wstrb[0]) begin
				$write("%c", periph_mem_wdata[7:0]);
			end

			periph_mem_ready <= periph_mem_valid;
		end
	end

    initial begin
        rst_n = 1'b0;
        #100;
        rst_n = 1'b1;
        #100000;
        $finish;
    end

    initial begin
        sys_clk = 1'b0;
        forever begin
            #10;
            sys_clk = ~sys_clk;
        end
    end

    initial begin
        $dumpfile("cpu_subsys_tb.vcd");
        $dumpvars();
    end

endmodule // cpu_subsys_tb
