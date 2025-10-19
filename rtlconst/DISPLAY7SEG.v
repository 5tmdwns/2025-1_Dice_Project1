module DISPLAY7SEG(/*AUTOARG*/
		   // Outputs
		   SEG,
		   // Inputs
		   OUT, PWM_ACT
		   );
   input [3:0] OUT;
   input       PWM_ACT;
   output reg [6:0] SEG;
   // Internal signal declarations

   // Combinational logic
   always @(*) begin
      case (OUT)
	4'h0 : SEG = (PWM_ACT) ? 7'b1000000 : 7'b1111111;
	4'h1 : SEG = (PWM_ACT) ? 7'b1111001 : 7'b1111111;
	4'h2 : SEG = (PWM_ACT) ? 7'b0100100 : 7'b1111111;
	4'h3 : SEG = (PWM_ACT) ? 7'b0110000 : 7'b1111111;
	4'h4 : SEG = (PWM_ACT) ? 7'b0011001 : 7'b1111111;
	4'h5 : SEG = (PWM_ACT) ? 7'b0010010 : 7'b1111111;
	4'h6 : SEG = (PWM_ACT) ? 7'b0000010 : 7'b1111111;
	4'h7 : SEG = (PWM_ACT) ? 7'b1111000 : 7'b1111111;
	4'h8 : SEG = (PWM_ACT) ? 7'b0000000 : 7'b1111111;
	4'h9 : SEG = (PWM_ACT) ? 7'b0010000 : 7'b1111111;
	default : SEG = 7'b1111111;
      endcase
   end
endmodule

