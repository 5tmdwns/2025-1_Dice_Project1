module STOPWATCH(/*AUTOARG*/
		 // Outputs
		 SW_SEC, SW_MIN, SW_HOUR, SW_DAY,
		 // Inputs
		 CLK1K, RSTN, SW3, KEY3
		 );
   input CLK1K, RSTN, SW3, KEY3; // Text other ports
   output [7:0] SW_SEC, SW_MIN, SW_HOUR, SW_DAY;
   // Internal signal declarations
   reg [9:0] 	CNT, next_cnt;
   reg 		EN, next_en;
   reg 		STATE, next_state;
   reg [1:0] 	KEY3_SYNC, next_key3_sync;
   wire 	CARRY_SEC, CARRY_MIN, CARRY_HOUR, CARRY_DAY;

   localparam STOP = 1'b0;
   localparam START = 1'b1;

   SW_BCDCNTR #(.MAXL(4'h3), .MAXR(4'h1), .SETL(4'h0), .SETR(4'h0))
   SWDAY (/*AUTOINST*/
	  // Outputs
	  .BCD				(SW_DAY),
	  .CARRY			(CARRY_DAY),
	  // Inputs
	  .CLK1K			(CLK1K),
	  .RSTN				(RSTN),
	  .EN				(CARRY_HOUR));

   SW_BCDCNTR #(.MAXL(4'h2), .MAXR(4'h3), .SETL(4'h0), .SETR(4'h0))
   SWHOUR (/*AUTOINST*/
	   // Outputs
	   .BCD				(SW_HOUR),
	   .CARRY			(CARRY_HOUR),
	   // Inputs
	   .CLK1K			(CLK1K),
	   .RSTN			(RSTN),
	   .EN				(CARRY_MIN));
   
   SW_BCDCNTR #(.MAXL(4'h5), .MAXR(4'h9), .SETL(4'h0), .SETR(4'h0))
   SWMIN (/*AUTOINST*/
	  // Outputs
	  .BCD				(SW_MIN),
	  .CARRY			(CARRY_MIN),
	  // Inputs
	  .CLK1K			(CLK1K),
	  .RSTN				(RSTN),
	  .EN				(CARRY_SEC));
   
   SW_BCDCNTR #(.MAXL(4'h5), .MAXR(4'h9), .SETL(4'h0), .SETR(4'h0))
   SWSEC (/*AUTOINST*/
	  // Outputs
	  .BCD				(SW_SEC),
	  .CARRY			(CARRY_SEC),
	  // Inputs
	  .CLK1K			(CLK1K),
	  .RSTN				(RSTN),
	  .EN				(EN));

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 CNT <= 10'h0;
	 EN <= 1'h0;
	 STATE <= STOP;
	 KEY3_SYNC <= 2'b11;
	 // End of automatics
      end
      else begin
	 CNT <= next_cnt;
	 EN <= next_en;
	 STATE <= next_state;
	 KEY3_SYNC <= next_key3_sync;
      end
   end

   // Combinational logic
   always @(*) begin
      next_cnt = CNT;
      next_en = EN;
      next_state = STATE;
      next_key3_sync = {KEY3_SYNC[0], KEY3};
      if (KEY3_SYNC == 2'b10) begin
	 next_state = (STATE == START) ? STOP : START;
      end
      else begin
	 case (STATE)
	   STOP : begin
	      next_cnt = CNT;
	      next_en = EN;
	      next_state = STATE;
	   end
	   START : begin
	      if (SW3) begin
		 next_cnt = (CNT >= 10'd9) ? 10'd0 : CNT + 10'd1;
		 next_en = (CNT >= 10'd9) ? 1'd1 : 1'd0;
		 next_state = STATE;
	      end
	      else begin
		 next_cnt = (CNT >= 10'd998) ? 10'd0 : CNT + 10'd1;
		 next_en = (CNT >= 10'd998) ? 1'd1 : 1'd0;
		 next_state = STATE;
	      end
	   end
	 endcase
      end
   end
endmodule
