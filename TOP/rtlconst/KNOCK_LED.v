module KNOCK_LED (/*AUTOARG*/
		  // Outputs
		  ALARM, LED,
		  // Inputs
		  CLK1K, RSTN, SW3, KNOCK
		  );
   input CLK1K, RSTN; // Text other ports
   input SW3, KNOCK;
   output reg ALARM;
   output reg [17:0] LED;

   // Internal signal declarations
   reg [9:0] 	     ONE_SEC_CNT, next_one_sec_cnt;
   reg [5:0] 	     SEC_CNT, next_sec_cnt;
   reg [4:0] 	     MIN_REMAIN, next_min_remain;
   reg 		     TIMER_EN, next_timer_en;
   reg 		     KNOCK_D, next_knock_d;
   reg 		     KNOCK_FALL, next_knock_fall;
   reg 		     ALARM_PULSE, next_alarm_pulse;
   reg 		     next_alarm;
   reg [17:0] 	     next_led;


   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 ALARM <= 1'h0;
	 KNOCK_D <= 1'h1;
	 KNOCK_FALL <= 1'h0;
	 LED <= 18'h0;
	 MIN_REMAIN <= 5'h0;
	 ONE_SEC_CNT <= 10'h0;
	 SEC_CNT <= 6'h0;
	 TIMER_EN <= 1'h0;
	 ALARM_PULSE <= 1'b0;
	 // End of automatics
      end
      else begin
	 ALARM <= next_alarm;
	 LED <= next_led;
	 ONE_SEC_CNT <= next_one_sec_cnt;
	 SEC_CNT <= next_sec_cnt;
	 MIN_REMAIN <= next_min_remain;
	 TIMER_EN <= next_timer_en;
	 KNOCK_D <= next_knock_d;
	 KNOCK_FALL <= next_knock_fall;
	 ALARM_PULSE <= next_alarm_pulse;
      end
   end

   // Combinational logic
   always @(*) begin
      next_knock_d = KNOCK;
      next_knock_fall = KNOCK_D & ~KNOCK;
      next_alarm = 1'b0;
	  next_led = (MIN_REMAIN == 5'd0) ? 18'd0 : (18'b1 << MIN_REMAIN) - 18'b1;
      next_one_sec_cnt = ONE_SEC_CNT;
      next_sec_cnt = SEC_CNT;
      next_min_remain = MIN_REMAIN;
      next_timer_en = TIMER_EN;
      next_alarm_pulse = 1'b0;

	  if (KNOCK_FALL) begin
		next_timer_en = 1'b1;
		next_min_remain = (MIN_REMAIN < 5'd19) ? MIN_REMAIN + 5'd1 : MIN_REMAIN;
	  end
	  else begin
		if (TIMER_EN) begin
			if (SW3) begin
				if (ONE_SEC_CNT >= 10'd9) begin
					if (MIN_REMAIN != 5'd0) begin
						if (SEC_CNT == 6'd00) begin
							next_sec_cnt = 6'd59;
							next_min_remain = MIN_REMAIN - 5'd1;
							next_one_sec_cnt = 10'd0;
						end
						else begin
							next_sec_cnt = SEC_CNT - 6'd1;
							next_one_sec_cnt = 10'd0;
						end
					end
					else begin
						if (SEC_CNT == 6'd00) begin
							next_timer_en = 1'b0;
							next_alarm_pulse = 1'b1;
							next_sec_cnt = 6'd0;
							next_one_sec_cnt = 10'd0;
						end
						else begin
							next_sec_cnt = SEC_CNT - 6'd1;
							next_one_sec_cnt = 10'd0;
						end
					end
				end
				else begin
					next_one_sec_cnt = ONE_SEC_CNT + 10'd1;
				end
			end
			else begin
				if (ONE_SEC_CNT >= 10'd999) begin
					if (MIN_REMAIN != 5'd0) begin
						if (SEC_CNT == 6'd00) begin
							next_sec_cnt = 6'd59;
							next_min_remain = MIN_REMAIN - 5'd1;
							next_one_sec_cnt = 10'd0;
						end
						else begin
							next_sec_cnt = SEC_CNT - 6'd1;
							next_one_sec_cnt = 10'd0;
						end
					end
					else begin
						if (SEC_CNT == 6'd00) begin
							next_timer_en = 1'b0;
							next_alarm_pulse = 1'b1;
							next_sec_cnt = 6'd0;
							next_one_sec_cnt = 10'd0;
						end
						else begin
							next_sec_cnt = SEC_CNT - 6'd1;
							next_one_sec_cnt = 10'd0;
						end
					end
				end
				else begin
					next_one_sec_cnt = ONE_SEC_CNT + 10'd1;
				end
			end
		end
		else begin
			next_alarm = (ALARM_PULSE == 1'b1) ? 1'b1 : 1'b0;
		end
	  end
   end
endmodule
