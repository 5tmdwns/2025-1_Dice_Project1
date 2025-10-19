module GENCLK1K(/*AUTOARG*/
		// Outputs
		CLK1K,
		// Inputs
		CLK50M, RSTN
		);
   input CLK50M, RSTN;
   output reg CLK1K;

   reg [14:0] CNT, next_cnt;
   reg next_clk1k;

   // Sequential logic
   always @(posedge CLK50M or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 CLK1K <= 1'h0;
	 CNT <= 15'h0;
	 // End of automatics
      end
      else begin
	 CNT <= next_cnt;
	 CLK1K <= next_clk1k;
      end
   end

   // Combinational logic
   always @(*) begin
	next_cnt = (CNT == 15'd24999) ? 15'd0 : CNT + 15'd1;
	next_clk1k = (CNT == 15'd24999) ? ~CLK1K : CLK1K;
   end
endmodule
