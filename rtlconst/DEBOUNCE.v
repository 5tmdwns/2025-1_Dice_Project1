module DEBOUNCE #(parameter SET = 1'b1)(/*AUTOARG*/
		// Outputs
		KEY_OUT,
		// Inputs
		CLK1K, RSTN, KEY_IN
		);
   input CLK1K, RSTN; // Text other ports
   input KEY_IN;
   output reg KEY_OUT;

   // Internal signal declarations
   localparam STABLE_CNT = 50;
   reg [5:0]  CNT, next_cnt;
   reg 	      PREV_KEY_IN, next_key_out, next_prev_key_in;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 CNT <= 5'h0;
	 KEY_OUT <= SET;
	 PREV_KEY_IN <= SET;
	 // End of automatics
      end
      else begin
	 CNT <= next_cnt;
	 KEY_OUT <= next_key_out;
	 PREV_KEY_IN <= next_prev_key_in;
      end
   end

   // Combinational logic
   always @(*) begin
      next_cnt = CNT;
      next_key_out = KEY_OUT;
      next_prev_key_in = PREV_KEY_IN;
      if (KEY_IN == PREV_KEY_IN) begin
	 if (CNT < STABLE_CNT) begin
	    next_cnt = CNT + 5'd1;
	 end
	 else begin
	    next_key_out = KEY_IN;
	 end
      end
      else begin
	 next_prev_key_in = KEY_IN;
      end
   end
endmodule

