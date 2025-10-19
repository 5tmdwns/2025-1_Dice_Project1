module FIRE_ALARM(/*AUTOARG*/
		       // Outputs
		       BUZ_OUT, FIRE_VALID,
		       // Inputs
		       CLK1K, RSTN, FIRE_ALARM, KNOCK
		       );
   input CLK1K, RSTN; // Text other ports
   input FIRE_ALARM, KNOCK;
   output reg BUZ_OUT, FIRE_VALID;

   // Internal signal declarations
   parameter IDLE = 1'b0;
   parameter BUZ = 1'b1;

   reg 	      STATE, next_state;
   reg 	      next_buz_out;
	reg         next_fire_valid;
   reg 	      CLK500, next_clk500;
   reg 	      KNOCK_D, next_knock_d;
   reg 	      KNOCK_FALL, next_knock_fall;
   reg [8:0]  BEEP_CNT, next_beep_cnt;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 BEEP_CNT <= 8'h0;
	 BUZ_OUT <= 1'h0;
	 FIRE_VALID <= 1'h0;
	 CLK500 <= 1'h0;
	 KNOCK_D <= 1'h0;
	 KNOCK_FALL <= 1'h0;
	 STATE <= 1'h0;
	 // End of automatics
      end
      else begin
	 STATE <= next_state;
	 BUZ_OUT <= next_buz_out;
	 FIRE_VALID <= next_fire_valid;
	 CLK500 <= next_clk500;
	 BEEP_CNT <= next_beep_cnt;
	 KNOCK_D <= next_knock_d;
	 KNOCK_FALL <= next_knock_fall;
      end
   end

   // Combinational logic
   always @(*) begin
      next_clk500 = ~CLK500;
      next_knock_d = KNOCK;
      next_knock_fall = KNOCK_D & ~KNOCK;
		next_fire_valid = FIRE_VALID;
      case (STATE) 
	IDLE : begin
	   if (FIRE_ALARM) begin
	      next_state = BUZ;
	      next_buz_out = 1'b0;
	      next_beep_cnt = 8'b0;
			next_fire_valid = 1'b1;
	   end
	   else begin
	      next_state = IDLE;
	      next_buz_out = 1'b0;
	      next_beep_cnt = 8'b0;
			next_fire_valid = 1'b0;
	   end
	end
	BUZ : begin
	   if (KNOCK_FALL) begin
	      next_state = IDLE;
	      next_buz_out = 1'b0;
	      next_beep_cnt = 8'd0;
			next_fire_valid = 1'b0;
	   end
	   else begin
	      if (BEEP_CNT >= 9'd256) begin
		 next_state = BUZ;
		 next_buz_out = CLK500;
		 next_beep_cnt = (BEEP_CNT == 8'd128) ? 8'd0 : BEEP_CNT + 8'd1;
	      end
	      else begin
		 next_state = BUZ;
		 next_buz_out = 1'b0;
		 next_beep_cnt = BEEP_CNT + 8'd1;
	      end
	   end
	end
	default : begin
	   next_state = IDLE;
	   next_buz_out = 1'b0;
	   next_beep_cnt = 8'd0;
	end
      endcase
   end
endmodule

