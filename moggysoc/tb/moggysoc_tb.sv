module moggysoc_tb;

    logic sys_clk;
    logic rst_n;

	moggysoc_top u_dut (.*);

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
        $dumpfile("moggysoc_tb.vcd");
        $dumpvars();
    end

endmodule
