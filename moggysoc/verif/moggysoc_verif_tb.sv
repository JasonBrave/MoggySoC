module moggysoc_verif_tb;

	import uvm_pkg::*;

    logic clk_125;

	logic [1:0] switches;
	logic [3:0] push_buttons;
	logic [3:0] leds;
	logic [2:0] rgb_led_ld4;
	logic [2:0] rgb_led_ld5;

	moggysoc_top u_dut (.*);

    initial begin
        push_buttons = 4'h0;
        #1ms;
		push_buttons = 4'h1;
		#1ms;
		push_buttons = 4'h0;
		for(int i = 0; i < 1000; i++) begin
			#10ms;
			`uvm_info("TIMEINFO", $sformatf("Time %dms, leds = %h", i*10, leds), UVM_LOW)
		end
        $finish;
    end

    initial begin
        clk_125 = 1'b0;
        forever begin
            #8ns;
            clk_125 = ~clk_125;
        end
    end

    initial begin
        $dumpfile("moggysoc_verif_tb.vcd");
        $dumpvars();
    end

endmodule
