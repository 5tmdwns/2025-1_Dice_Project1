module BCDCNTR #(parameter MAXL = 4'h5, parameter MAXR = 4'h9, parameter SETL = 4'h0, parameter SETR = 4'h0)(/*AUTOARG*/
													     // Outputs
													     BCD, CARRY,
													     // Inputs
													     CLK1K, RSTN, EN, SW1, BCD_SET
													     );
   input CLK1K, RSTN, EN, SW1; // Text other ports
   input [7:0] BCD_SET;
   output reg [7:0] BCD;
   output reg 	    CARRY;
   // Internal signal declarations
   reg [3:0] 	    next_left_bcd, next_right_bcd;
   reg 		    next_carry;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 BCD <= {SETL, SETR};
	 CARRY <= 1'h0;
	 // End of automatics
      end
      else begin
	 if (SW1) begin
	    BCD <= BCD_SET;
	    CARRY <= next_carry;
	 end
	 else begin
	    BCD <= {next_left_bcd, next_right_bcd};
	    CARRY <= next_carry;
	 end
      end
   end

   // Combinational logic
   always @(*) begin
      if (EN) begin
	 if (BCD[7:4] == MAXL) begin
	    if (BCD[3:0] == MAXR) begin
	       next_left_bcd = SETL;
	       next_right_bcd = SETR;
	       next_carry = 1'b1;
	    end
	    else begin
	       next_left_bcd = BCD[7:4];
	       next_right_bcd = BCD[3:0] + 4'h1;
		   next_carry = 1'b0;
	    end
	 end
	 else begin
	    if (BCD[3:0] == 4'h9) begin
	       next_right_bcd = 4'h0;
	       next_left_bcd = BCD[7:4] + 4'h1;
		   next_carry = 1'b0;
	    end
	    else begin
	       next_right_bcd = BCD[3:0] + 4'h1;
	       next_left_bcd = BCD[7:4];
		   next_carry = 1'b0;
	    end
	 end
      end
      else begin
	 next_right_bcd = BCD[3:0];
	 next_left_bcd = BCD[7:4];
	 next_carry = 1'b0;
      end
   end
endmodule
