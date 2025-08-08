module DIGITCLOCK(/*AUTOARG*/
		  // Outputs
		  SEC, MIN, HOUR, DAY,
		  // Inputs
		  CLK1K, RSTN, SW1, SW2, SW3, SEC_SET, MIN_SET, HOUR_SET, DAY_SET,
		  SW_SEC, SW_MIN, SW_HOUR, SW_DAY
		  );
   input CLK1K, RSTN, SW1, SW2, SW3; // Text other ports
   input [7:0] SEC_SET, MIN_SET, HOUR_SET, DAY_SET;
   input [7:0] SW_SEC, SW_MIN, SW_HOUR, SW_DAY;
   output [7:0] SEC, MIN, HOUR, DAY;
   // Internal signal declarations
   reg [9:0] 	CNT, next_cnt;
   reg 		EN, next_en;
   wire [7:0] 	NORMAL_SEC, NORMAL_MIN, NORMAL_HOUR, NORMAL_DAY;
   wire 	CARRY_SEC, CARRY_MIN, CARRY_HOUR, CARRY_DAY;

   assign DAY = (SW2 == 1'b1) ? SW_DAY : NORMAL_DAY;
   assign HOUR = (SW2 == 1'b1) ? SW_HOUR : NORMAL_HOUR;
   assign MIN = (SW2 == 1'b1) ? SW_MIN : NORMAL_MIN;
   assign SEC = (SW2 == 1'b1) ? SW_SEC : NORMAL_SEC;

   BCDCNTR #(.MAXL(4'h3), .MAXR(4'h1), .SETL(4'h0), .SETR(4'h1))
   UDAY (/*AUTOINST*/
	 // Outputs
	 .BCD				(NORMAL_DAY),
	 .CARRY				(CARRY_DAY),
	 // Inputs
	 .CLK1K				(CLK1K),
	 .RSTN				(RSTN),
	 .EN				(CARRY_HOUR),
	 .SW1				(SW1),
	 .BCD_SET			(DAY_SET));

   BCDCNTR #(.MAXL(4'h2), .MAXR(4'h3), .SETL(4'h0), .SETR(4'h0))
   UHOUR (/*AUTOINST*/
	  // Outputs
	  .BCD				(NORMAL_HOUR),
	  .CARRY			(CARRY_HOUR),
	  // Inputs
	  .CLK1K			(CLK1K),
	  .RSTN				(RSTN),
	  .EN				(CARRY_MIN),
	  .SW1				(SW1),
	  .BCD_SET			(HOUR_SET));
   
   BCDCNTR #(.MAXL(4'h5), .MAXR(4'h9), .SETL(4'h0), .SETR(4'h0))
   UMIN (/*AUTOINST*/
	 // Outputs
	 .BCD				(NORMAL_MIN),
	 .CARRY				(CARRY_MIN),
	 // Inputs
	 .CLK1K				(CLK1K),
	 .RSTN				(RSTN),
	 .EN				(CARRY_SEC),
	 .SW1				(SW1),
	 .BCD_SET			(MIN_SET));
   
   BCDCNTR #(.MAXL(4'h5), .MAXR(4'h9), .SETL(4'h0), .SETR(4'h0))
   USEC (/*AUTOINST*/
	 // Outputs
	 .BCD				(NORMAL_SEC),
	 .CARRY				(CARRY_SEC),
	 // Inputs
	 .CLK1K				(CLK1K),
	 .RSTN				(RSTN),
	 .EN				(EN),
	 .SW1				(SW1),
	 .BCD_SET			(SEC_SET));

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 CNT <= 10'h0;
	 EN <= 1'h0;
	 // End of automatics
      end
      else begin
	 CNT <= next_cnt;
	 EN <= next_en;
      end
   end

   // Combinational logic
   always @(*) begin
      if (SW1) begin
         next_cnt = CNT;
         next_en  = 1'b0;
      end
      else begin
	 if (SW3) begin
            next_cnt = (CNT >= 10'd9) ? 10'd0 : CNT + 10'd1;
            next_en  = (CNT >= 10'd9) ? 1'd1 : 1'd0;
	 end
	 else begin
            next_cnt = (CNT >= 10'd998) ? 10'd0 : CNT + 10'd1;
            next_en  = (CNT >= 10'd998) ? 1'd1 : 1'd0;
	 end
      end
   end
endmodule
