module prim_clock_gating (
  input  clk_i,
  input  en_i,
  input  test_en_i,
  output clk_o
);

	assign clk_o = clk_i;

endmodule
