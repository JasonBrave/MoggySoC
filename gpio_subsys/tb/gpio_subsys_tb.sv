module gpio_subsys_tb;

    logic sys_clk;
    logic rst_n;

    logic		 bus_valid;
	logic [23:0] bus_addr;
	logic		 bus_write;
	logic [31:0] bus_wdata;
	logic [3:0]	 bus_wstrb;
	logic [31:0] bus_rdata;
	logic		 bus_ready;

    gpio_subsys_top u_gpio_subsys_top (.*);

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
        $dumpfile("gpio_subsys_tb.vcd");
        $dumpvars();
    end

endmodule // gpio_subsys_tb
