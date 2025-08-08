module KNOCK_LED_ALARM(/*AUTOARG*/
	     // Outputs
	     BUZ_OUT,
	     // Inputs
	     CLK1K, RSTN, ALARM
	     );
   input CLK1K, RSTN; // Text other ports
   input ALARM;
   output reg BUZ_OUT;

   // Internal signal declarations
   parameter IDLE = 1'b0;
   parameter BUZ = 1'b1;

   reg 	      STATE, next_state;
   reg 	      next_buz_out;
   reg 	      CLK500, next_clk500;
   reg [6:0]  BEEP_CNT1, next_beep_cnt1;
   reg [8:0]  BEEP_CNT2, next_beep_cnt2;
   reg [2:0]  ALARM_DONE, next_alarm_done;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 ALARM_DONE <= 3'h0;
	 BEEP_CNT1 <= 7'h0;
	 BEEP_CNT2 <= 9'h0;
	 BUZ_OUT <= 1'h0;
	 CLK500 <= 1'h0;
	 STATE <= 1'h0;
	 // End of automatics
      end
      else begin
	 STATE <= next_state;
	 BUZ_OUT <= next_buz_out;
	 CLK500 <= next_clk500;
	 BEEP_CNT1 <= next_beep_cnt1;
	 BEEP_CNT2 <= next_beep_cnt2;
	 ALARM_DONE <= next_alarm_done;
      end
   end

   // Combinational logic
   always @(*) begin
      next_clk500 = ~CLK500;
      case (STATE) 
	IDLE : begin
	   if (ALARM) begin
	      next_state = BUZ;
	      next_buz_out = 1'b0;
	      next_beep_cnt1 = 7'b0;
	      next_beep_cnt2 = 9'd0;
	      next_alarm_done = 3'd0;
	   end
	   else begin
	      next_state = IDLE;
	      next_buz_out = 1'b0;
	      next_beep_cnt1 = 7'b0;
	      next_beep_cnt2 = 8'b0;
	      next_alarm_done = 3'd0;
	   end
	end
	BUZ : begin
	   if (ALARM_DONE == 3'd4) begin
	      next_state = IDLE;
	      next_buz_out = 1'b0;
	      next_beep_cnt1 = 7'd0;
	      next_beep_cnt2 = 9'd0;
	      next_alarm_done = 3'd0;
	   end
	   else begin
	      if (BEEP_CNT2 >= 9'd4) begin
		 next_state = BUZ;
		 next_buz_out = 1'b0;
		 next_beep_cnt1 = 7'd0;
		 next_beep_cnt2 = (BEEP_CNT2 == 9'd511) ? 9'd0 : BEEP_CNT2 + 9'd1;
		 next_alarm_done = (BEEP_CNT2 == 9'd511) ? ALARM_DONE + 3'd1 : ALARM_DONE;
	      end
	      else begin
		 if (BEEP_CNT1 >= 7'd64) begin
		    next_state = BUZ;
		    next_buz_out = CLK500;
		    next_beep_cnt1 = (BEEP_CNT1 == 7'd127) ? 7'd0 : BEEP_CNT1 + 7'd1;
		    next_beep_cnt2 = (BEEP_CNT1 == 7'd127) ? BEEP_CNT2 + 9'd1 : BEEP_CNT2;
		    next_alarm_done = ALARM_DONE;
		 end
		 else begin
		    next_state = BUZ;
		    next_buz_out = 1'b0;
		    next_beep_cnt1 = BEEP_CNT1 + 7'd1;
		    next_beep_cnt2 = BEEP_CNT2;
		    next_alarm_done = ALARM_DONE;
		 end
	      end
	   end
	end
	default : begin
	   next_state = IDLE;
	   next_buz_out = 1'b0;
	   next_beep_cnt1 = 7'd0;
	   next_beep_cnt2 = 3'd0;
	   next_alarm_done = 1'b0;
	end
      endcase
   end
endmodule

