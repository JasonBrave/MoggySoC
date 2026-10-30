/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off PINMISSING */

module cpu_subsys_top (
    // Clock and resets
    input logic			sys_clk,
    input logic			rst_n,
    // Peripheral memory bus
    output logic		periph_mem_valid,
    output logic [31:0]	periph_mem_addr,
	output logic		periph_mem_write,
    output logic [31:0]	periph_mem_wdata,
    output logic [3:0]	periph_mem_wstrb,
    input logic [31:0]	periph_mem_rdata,
    input logic			periph_mem_ready
);

    logic         instr_cpu_bus_valid;
    logic [31:0]  instr_cpu_bus_addr;
    logic [31:0]  instr_cpu_bus_wdata;
    logic [3:0]   instr_cpu_bus_wstrb;
    logic [31:0]  instr_cpu_bus_rdata;
    logic         instr_cpu_bus_ready;

    logic         instr_flash_bus_valid;
    logic [21:0]  instr_flash_bus_addr;
	logic		  instr_flash_bus_write;
    logic [31:0]  instr_flash_bus_wdata;
    logic [3:0]   instr_flash_bus_wstrb;
    logic [31:0]  instr_flash_bus_rdata;
    logic         instr_flash_bus_ready;

    logic         instr_itcm_bus_valid;
    logic [20:0]  instr_itcm_bus_addr;
	logic		  instr_itcm_bus_write;
    logic [31:0]  instr_itcm_bus_wdata;
    logic [3:0]   instr_itcm_bus_wstrb;
    logic [31:0]  instr_itcm_bus_rdata;
    logic         instr_itcm_bus_ready;

    logic         instr_dtcm_bus_valid;
    logic [20:0]  instr_dtcm_bus_addr;
	logic		  instr_dtcm_bus_write;
    logic [31:0]  instr_dtcm_bus_wdata;
    logic [3:0]   instr_dtcm_bus_wstrb;
    logic [31:0]  instr_dtcm_bus_rdata;
    logic         instr_dtcm_bus_ready;

    logic         instr_ahb_bus_valid;
    logic [31:0]  instr_ahb_bus_addr;
	logic		  instr_ahb_bus_write;
    logic [31:0]  instr_ahb_bus_wdata;
    logic [3:0]   instr_ahb_bus_wstrb;
    logic [31:0]  instr_ahb_bus_rdata;
    logic         instr_ahb_bus_ready;

    logic         data_cpu_bus_valid;
    logic         data_cpu_bus_ready;
    logic [31:0]  data_cpu_bus_addr;
    logic [31:0]  data_cpu_bus_wdata;
    logic         data_cpu_bus_we;
    logic [3:0]   data_cpu_bus_be;
    logic [31:0]  data_cpu_bus_rdata;

    logic         data_flash_bus_valid;
    logic [21:0]  data_flash_bus_addr;
	logic		  data_flash_bus_write;
    logic [31:0]  data_flash_bus_wdata;
    logic [3:0]   data_flash_bus_wstrb;
    logic [31:0]  data_flash_bus_rdata;
    logic         data_flash_bus_ready;

    logic         data_itcm_bus_valid;
    logic [20:0]  data_itcm_bus_addr;
	logic		  data_itcm_bus_write;
    logic [31:0]  data_itcm_bus_wdata;
    logic [3:0]   data_itcm_bus_wstrb;
    logic [31:0]  data_itcm_bus_rdata;
    logic         data_itcm_bus_ready;

    logic         data_dtcm_bus_valid;
    logic [20:0]  data_dtcm_bus_addr;
	logic		  data_dtcm_bus_write;
    logic [31:0]  data_dtcm_bus_wdata;
    logic [3:0]   data_dtcm_bus_wstrb;
    logic [31:0]  data_dtcm_bus_rdata;
    logic         data_dtcm_bus_ready;

    logic         data_ahb_bus_valid;
    logic [31:0]  data_ahb_bus_addr;
	logic		  data_ahb_bus_write;
    logic [31:0]  data_ahb_bus_wdata;
    logic [3:0]   data_ahb_bus_wstrb;
    logic [31:0]  data_ahb_bus_rdata;
    logic         data_ahb_bus_ready;

    ibex_top #(
		.RV32E(1'b0),
		.RV32M(ibex_pkg::RV32MSingleCycle),
		.RegFile(ibex_pkg::RegFileFPGA)
	) u_ibex_cpu_top (
        // Clock and reset
        .clk_i(sys_clk),
        .rst_ni(rst_n),
        .test_en_i(1'b0),
        .ram_cfg_i('0),

         // Configuration
        .hart_id_i(32'h00000001),
        .boot_addr_i(32'h00000000),

        // Instruction memory interface
        .instr_req_o(instr_cpu_bus_valid),
        .instr_gnt_i(instr_cpu_bus_valid),
        .instr_rvalid_i(instr_cpu_bus_ready),
        .instr_addr_o(instr_cpu_bus_addr),
        .instr_rdata_i(instr_cpu_bus_rdata),
        .instr_rdata_intg_i(7'b0000000),
        .instr_err_i(1'b0),

        // Data memory interface
        .data_req_o(data_cpu_bus_valid),
        .data_gnt_i(data_cpu_bus_valid),
        .data_rvalid_i(data_cpu_bus_ready),
        .data_we_o(data_cpu_bus_we),
        .data_be_o(data_cpu_bus_be),
        .data_addr_o(data_cpu_bus_addr),
        .data_wdata_o(data_cpu_bus_wdata),
        .data_wdata_intg_o(),
        .data_rdata_i(data_cpu_bus_rdata),
        .data_rdata_intg_i(7'h0),
        .data_err_i(1'b0),

        // Interrupt inputs
        .irq_software_i(1'b0),
        .irq_timer_i(1'b0),
        .irq_external_i(1'b0),
        .irq_fast_i(15'b000000000000000),
        .irq_nm_i(1'b0),

        // Scrambling Interface
        .scramble_key_valid_i(),
        .scramble_key_i(),
        .scramble_nonce_i(),
        .scramble_req_o(),
                     
        // Debug interface
        .debug_req_i            (1'b0),
        .crash_dump_o           (),
        .double_fault_seen_o    (),

        // Special control signals
        .fetch_enable_i         (ibex_pkg::IbexMuBiOn),
        .alert_minor_o          (),
        .alert_major_internal_o (),
        .alert_major_bus_o      (),
        .core_sleep_o           (),

        // DFT bypass controls
        .scan_rst_ni()
    );

    cpu_subsys_bus_bridge u_instr_bus_bridge (
        // Clock and reset
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        // CPU Memory Interface
        .cpu_mem_valid(instr_cpu_bus_valid),
        .cpu_mem_ready(instr_cpu_bus_ready),
        .cpu_mem_addr(instr_cpu_bus_addr),
        .cpu_mem_wdata(instr_cpu_bus_wdata),
        .cpu_mem_we(1'b0),
        .cpu_mem_be(4'b0000),
        .cpu_mem_rdata(instr_cpu_bus_rdata),
        // Flash Memory Interface
        .flash_mem_valid(instr_flash_bus_valid),
        .flash_mem_addr(instr_flash_bus_addr),
		.flash_mem_write(instr_flash_bus_write),
        .flash_mem_wdata(instr_flash_bus_wdata),
        .flash_mem_wstrb(instr_flash_bus_wstrb),
        .flash_mem_rdata(instr_flash_bus_rdata),
        .flash_mem_ready(instr_flash_bus_ready),
        // ITCM Memory Interface
        .itcm_mem_valid(instr_itcm_bus_valid),
        .itcm_mem_addr(instr_itcm_bus_addr),
		.itcm_mem_write(instr_itcm_bus_write),
        .itcm_mem_wdata(instr_itcm_bus_wdata),
        .itcm_mem_wstrb(instr_itcm_bus_wstrb),
        .itcm_mem_rdata(instr_itcm_bus_rdata),
        .itcm_mem_ready(instr_itcm_bus_ready),
        // DTCM Memory Interface
        .dtcm_mem_valid(instr_dtcm_bus_valid),
        .dtcm_mem_addr(instr_dtcm_bus_addr),
		.dtcm_mem_write(instr_dtcm_bus_write),
        .dtcm_mem_wdata(instr_dtcm_bus_wdata),
        .dtcm_mem_wstrb(instr_dtcm_bus_wstrb),
        .dtcm_mem_rdata(instr_dtcm_bus_rdata),
        .dtcm_mem_ready(instr_dtcm_bus_ready),
        // AHB Memory Interface
        .ahb_mem_valid(instr_ahb_bus_valid),
        .ahb_mem_addr(instr_ahb_bus_addr),
		.ahb_mem_write(instr_ahb_bus_write),
        .ahb_mem_wdata(instr_ahb_bus_wdata),
        .ahb_mem_wstrb(instr_ahb_bus_wstrb),
        .ahb_mem_rdata(instr_ahb_bus_rdata),
        .ahb_mem_ready(instr_ahb_bus_ready)
    );

    cpu_subsys_bus_bridge u_data_bus_bridge (
        // Clock and reset
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        // CPU Memory Interface
        .cpu_mem_valid(data_cpu_bus_valid),
        .cpu_mem_ready(data_cpu_bus_ready),
        .cpu_mem_addr(data_cpu_bus_addr),
        .cpu_mem_wdata(data_cpu_bus_wdata),
        .cpu_mem_we(data_cpu_bus_we),
        .cpu_mem_be(data_cpu_bus_be),
        .cpu_mem_rdata(data_cpu_bus_rdata),
        // Flash Memory Interface
        .flash_mem_valid(data_flash_bus_valid),
        .flash_mem_addr(data_flash_bus_addr),
		.flash_mem_write(data_flash_bus_write),
        .flash_mem_wdata(data_flash_bus_wdata),
        .flash_mem_wstrb(data_flash_bus_wstrb),
        .flash_mem_rdata(data_flash_bus_rdata),
        .flash_mem_ready(data_flash_bus_ready),
        // ITCM Memory Interface
        .itcm_mem_valid(data_itcm_bus_valid),
        .itcm_mem_addr(data_itcm_bus_addr),
		.itcm_mem_write(data_itcm_bus_write),
        .itcm_mem_wdata(data_itcm_bus_wdata),
        .itcm_mem_wstrb(data_itcm_bus_wstrb),
        .itcm_mem_rdata(data_itcm_bus_rdata),
        .itcm_mem_ready(data_itcm_bus_ready),
        // DTCM Memory Interface
        .dtcm_mem_valid(data_dtcm_bus_valid),
        .dtcm_mem_addr(data_dtcm_bus_addr),
		.dtcm_mem_write(data_dtcm_bus_write),
        .dtcm_mem_wdata(data_dtcm_bus_wdata),
        .dtcm_mem_wstrb(data_dtcm_bus_wstrb),
        .dtcm_mem_rdata(data_dtcm_bus_rdata),
        .dtcm_mem_ready(data_dtcm_bus_ready),
        // AHB Memory Interface
        .ahb_mem_valid(data_ahb_bus_valid),
        .ahb_mem_addr(data_ahb_bus_addr),
		.ahb_mem_write(data_ahb_bus_write),
        .ahb_mem_wdata(data_ahb_bus_wdata),
        .ahb_mem_wstrb(data_ahb_bus_wstrb),
        .ahb_mem_rdata(data_ahb_bus_rdata),
        .ahb_mem_ready(data_ahb_bus_ready)
    );

    cpu_subsys_flash u_flash (
        .clk(sys_clk),
		// Port A
		.mem_a_valid(data_flash_bus_valid),
        .mem_a_addr(data_flash_bus_addr),
        .mem_a_rdata(data_flash_bus_rdata),
        .mem_a_ready(data_flash_bus_ready),
		// Port B
        .mem_b_valid(instr_flash_bus_valid),
        .mem_b_addr(instr_flash_bus_addr),
        .mem_b_rdata(instr_flash_bus_rdata),
        .mem_b_ready(instr_flash_bus_ready)
    );

    cpu_subsys_tcm u_itcm (
        .clk(sys_clk),
		// Port A
        .mem_a_valid(data_itcm_bus_valid),
        .mem_a_addr(data_itcm_bus_addr),
		.mem_a_write(data_itcm_bus_write),
        .mem_a_wdata(data_itcm_bus_wdata),
        .mem_a_wstrb(data_itcm_bus_wstrb),
        .mem_a_rdata(data_itcm_bus_rdata),
        .mem_a_ready(data_itcm_bus_ready),
		// Port B
        .mem_b_valid(instr_itcm_bus_valid),
        .mem_b_addr(instr_itcm_bus_addr),
        .mem_b_rdata(instr_itcm_bus_rdata),
        .mem_b_ready(instr_itcm_bus_ready)
    );

    cpu_subsys_tcm u_dtcm (
        .clk(sys_clk),
		// Port A
        .mem_a_valid(data_dtcm_bus_valid),
        .mem_a_addr(data_dtcm_bus_addr),
		.mem_a_write(data_dtcm_bus_write),
        .mem_a_wdata(data_dtcm_bus_wdata),
        .mem_a_wstrb(data_dtcm_bus_wstrb),
        .mem_a_rdata(data_dtcm_bus_rdata),
        .mem_a_ready(data_dtcm_bus_ready),
		// Port B
        .mem_b_valid(instr_dtcm_bus_valid),
        .mem_b_addr(instr_dtcm_bus_addr),
        .mem_b_rdata(instr_dtcm_bus_rdata),
        .mem_b_ready(instr_dtcm_bus_ready)
    );

	assign periph_mem_valid = data_ahb_bus_valid;
	assign periph_mem_addr = data_ahb_bus_addr;
	assign periph_mem_write = data_ahb_bus_write;
	assign periph_mem_wdata = data_ahb_bus_wdata;
	assign periph_mem_wstrb = data_ahb_bus_wstrb;
	assign data_ahb_bus_rdata = periph_mem_rdata;
	assign data_ahb_bus_ready = periph_mem_ready;

endmodule // cpu_subsys_top
