module MANSET(/*AUTOARG*/
	      // Outputs
	      SEC_SET, MIN_SET, HOUR_SET, DAY_SET,
	      // Inputs
	      CLK1K, RSTN, SW1, KEY1, KEY2, KEY3, PREV_SEC, PREV_MIN, PREV_HOUR,
	      PREV_DAY
	      );
   input CLK1K, RSTN; // Text other ports
   input SW1, KEY1, KEY2, KEY3;
   input [7:0] PREV_SEC, PREV_MIN, PREV_HOUR, PREV_DAY;
   output reg [7:0] SEC_SET, MIN_SET, HOUR_SET, DAY_SET;

   // Internal signal declarations
   reg [1:0] 	    SEL, next_sel;
   reg [7:0] 	    next_sec_set, next_min_set, next_hour_set, next_day_set;
   reg [1:0] 	    KEY1_SYNC, KEY2_SYNC, KEY3_SYNC;
   reg [1:0]  next_key1_sync, next_key2_sync, next_key3_sync;

   localparam SEC_SEL = 2'b00;
   localparam MIN_SEL = 2'b01;
   localparam HOUR_SEL = 2'b10;
   localparam DAY_SEL = 2'b11;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 DAY_SET <= 8'h1;
	 HOUR_SET <= 8'h0;
	 MIN_SET <= 8'h0;
	 SEC_SET <= 8'h0;
	 SEL <= 2'b00;
	 KEY1_SYNC <= 2'b11;
	 KEY2_SYNC <= 2'b11;
	 KEY3_SYNC <= 2'b11;
	 // End of automatics
      end
      else begin
	 DAY_SET <= next_day_set;
	 HOUR_SET <= next_hour_set;
	 MIN_SET <= next_min_set;
	 SEC_SET <= next_sec_set;
	 SEL <= next_sel;
	 KEY1_SYNC <= next_key1_sync;
	 KEY2_SYNC <= next_key2_sync;
	 KEY3_SYNC <= next_key3_sync;
      end
   end

   always @(*) begin
   next_key1_sync = {KEY1_SYNC[0], KEY1};
   next_key2_sync = {KEY2_SYNC[0], KEY2};
   next_key3_sync = {KEY3_SYNC[0], KEY3};
      if (SW1) begin
	  next_sel = SEL;
		next_sec_set = SEC_SET;
		next_min_set = MIN_SET;
		next_hour_set = HOUR_SET;
		next_day_set = DAY_SET;
	 if (KEY3_SYNC == 2'b10) begin
	    next_sel = (SEL == DAY_SEL) ? SEC_SEL : SEL + 2'b01;
	 end
	 else if (KEY2_SYNC == 2'b10) begin
	    case (SEL) 
	      SEC_SEL : begin
			if (SEC_SET[7:4] == 4'h5) begin
				if (SEC_SET[3:0] == 4'h9) begin
					next_sec_set[7:4] = 4'h0;
					next_sec_set[3:0] = 4'h0;
				end
				else begin
					next_sec_set[7:4] = SEC_SET[7:4];
					next_sec_set[3:0] = SEC_SET[3:0] + 4'h1;
				end
			end
			else begin
				if (SEC_SET[3:0] == 4'h9) begin
					next_sec_set[3:0] = 4'h0;
					next_sec_set[7:4] = SEC_SET[7:4] + 4'h1;
				end
				else begin
					next_sec_set[3:0] = SEC_SET[3:0] + 4'h1;
					next_sec_set[7:4] = SEC_SET[7:4];
				end
			end
		  end
	      MIN_SEL : begin
			if (MIN_SET[7:4] == 4'h5) begin
				if (MIN_SET[3:0] == 4'h9) begin
					next_min_set[7:4] = 4'h0;
					next_min_set[3:0] = 4'h0;
				end
				else begin
					next_min_set[7:4] = MIN_SET[7:4];
					next_min_set[3:0] = MIN_SET[3:0] + 4'h1;
				end
			end
			else begin
				if (MIN_SET[3:0] == 4'h9) begin
					next_min_set[3:0] = 4'h0;
					next_min_set[7:4] = MIN_SET[7:4] + 4'h1;
				end
				else begin
					next_min_set[3:0] = MIN_SET[3:0] + 4'h1;
					next_min_set[7:4] = MIN_SET[7:4];
				end
			end
		  end
	      HOUR_SEL : begin
			if (HOUR_SET[7:4] == 4'h2) begin
				if (HOUR_SET[3:0] == 4'h3) begin
					next_hour_set[7:4] = 4'h0;
					next_hour_set[3:0] = 4'h0;
				end
				else begin
					next_hour_set[7:4] = HOUR_SET[7:4];
					next_hour_set[3:0] = HOUR_SET[3:0] + 4'h1;
				end

			end
			else begin
				if (HOUR_SET[3:0] == 4'h9) begin
					next_hour_set[3:0] = 4'h0;
					next_hour_set[7:4] = HOUR_SET[7:4] + 4'h1;
				end
				else begin
					next_hour_set[3:0] = HOUR_SET[3:0] + 4'h1;
					next_hour_set[7:4] = HOUR_SET[7:4];
				end
			end
		  end
	      DAY_SEL : begin
			if (DAY_SET[7:4] == 4'h3) begin
				if (DAY_SET[3:0] == 4'h1) begin
					next_day_set[7:4] = 4'h0;
					next_day_set[3:0] = 4'h1;
				end
				else begin
					next_day_set[7:4] = DAY_SET[7:4];
					next_day_set[3:0] = DAY_SET[3:0] + 4'h1;
				end
			end
			else begin
				if (DAY_SET[3:0] == 4'h9) begin
					next_day_set[3:0] = 4'h0;
					next_day_set[7:4] = DAY_SET[7:4] + 4'h1;
				end
				else begin
					next_day_set[3:0] = DAY_SET[3:0] + 4'h1;
					next_day_set[7:4] = DAY_SET[7:4];
				end
			end
		  end
	    endcase
	 end
	 else if (KEY1_SYNC == 2'b10) begin
	    case (SEL) 
	      SEC_SEL : begin
			if (SEC_SET[7:4] == 4'h0) begin
				if (SEC_SET[3:0] == 4'h0) begin
					next_sec_set[7:4] = 4'h5;
					next_sec_set[3:0] = 4'h9;
				end
				else begin
					next_sec_set[7:4] = SEC_SET[7:4];
					next_sec_set[3:0] = SEC_SET[3:0] - 4'h1;
				end
			end
			else begin
				if (SEC_SET[3:0] == 4'h0) begin
					next_sec_set[3:0] = 4'h9;
					next_sec_set[7:4] = SEC_SET[7:4] - 4'h1;
				end
				else begin
					next_sec_set[3:0] = SEC_SET[3:0] - 4'h1;
					next_sec_set[7:4] = SEC_SET[7:4];
				end
			end
		  end
	      MIN_SEL : begin
			if (MIN_SET[7:4] == 4'h0) begin
				if (MIN_SET[3:0] == 4'h0) begin
					next_min_set[7:4] = 4'h5;
					next_min_set[3:0] = 4'h9;
				end
				else begin
					next_min_set[7:4] = MIN_SET[7:4];
					next_min_set[3:0] = MIN_SET[3:0] - 4'h1;
				end
			end
			else begin
				if (MIN_SET[3:0] == 4'h0) begin
					next_min_set[3:0] = 4'h9;
					next_min_set[7:4] = MIN_SET[7:4] - 4'h1;
				end
				else begin
					next_min_set[3:0] = MIN_SET[3:0] - 4'h1;
					next_min_set[7:4] = MIN_SET[7:4];
				end
			end
		  end
	      HOUR_SEL : begin
			if (HOUR_SET[7:4] == 4'h0) begin
				if (HOUR_SET[3:0] == 4'h0) begin
					next_hour_set[7:4] = 4'h2;
					next_hour_set[3:0] = 4'h3;
				end
				else begin
					next_hour_set[7:4] = HOUR_SET[7:4];
					next_hour_set[3:0] = HOUR_SET[3:0] - 4'h1;
				end
			end
			else begin
				if (HOUR_SET[3:0] == 4'h0) begin
					next_hour_set[3:0] = 4'h9;
					next_hour_set[7:4] = HOUR_SET[7:4] - 4'h1;
				end
				else begin
					next_hour_set[3:0] = HOUR_SET[3:0] - 4'h1;
					next_hour_set[7:4] = HOUR_SET[7:4];
				end
			end
		  end
	      DAY_SEL : begin
			if (DAY_SET[7:4] == 4'h0) begin
				if (DAY_SET[3:0] == 4'h1) begin
					next_day_set[7:4] = 4'h3;
					next_day_set[3:0] = 4'h1;
				end
				else begin
					next_day_set[7:4] = DAY_SET[7:4];
					next_day_set[3:0] = DAY_SET[3:0] - 4'h1;
				end
			end
			else begin
				if (DAY_SET[3:0] == 4'h0) begin
					next_day_set[3:0] = 4'h9;
					next_day_set[7:4] = DAY_SET[7:4] - 4'h1;
				end
				else begin
					next_day_set[3:0] = DAY_SET[3:0] - 4'h1;
					next_day_set[7:4] = DAY_SET[7:4];
				end
			end
		  end
	    endcase
	 end
      end
	  else begin
		next_sel = SEC_SEL;
		next_sec_set = PREV_SEC;
		next_min_set = PREV_MIN;
		next_hour_set = PREV_HOUR;
		next_day_set = PREV_DAY;
	  end
   end
endmodule
