module GENCLK10K(/*AUTOARG*/
		 // Outputs
		 CLK10K,
		 // Inputs
		 CLK50M, RSTN
		 );
   input CLK50M;
   input RSTN;
   output reg CLK10K;

   reg [11:0] CNT, next_cnt;
   reg        next_clk10k;

   always @(posedge CLK50M, negedge RSTN) begin
      if (!RSTN) begin
         CNT <= 12'd1;
         CLK10K <= 1'b0;
      end
      else begin
         CNT <= next_cnt;
         CLK10K <= next_clk10k;
      end
   end

   always @(*) begin
      next_cnt = (CNT == 12'd2499) ? 12'd1 : CNT + 12'd1;
      next_clk10k = (CNT == 12'd2499) ? ~CLK10K : CLK10K;
   end
endmodule
