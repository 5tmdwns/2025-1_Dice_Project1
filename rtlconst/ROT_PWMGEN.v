module ROT_PWMGEN (/*AUTOARG*/
		   // Outputs
		   PWM_ACT,
		   // Inputs
		   CLK10K, RSTN, SW5, ROT_A, ROT_B
		   );
   input CLK10K, RSTN, SW5;
   input ROT_A, ROT_B;
   output reg PWM_ACT;

   reg [7:0]  brightness;
   reg [1:0]  prev_state;
   reg [7:0]  pwm_counter;
   wire [1:0] current_state = {ROT_A, ROT_B};

   always @(posedge CLK10K or negedge RSTN) begin
		if (!RSTN) begin
			brightness <= 8'd255;
		end
		else begin
		if (SW5) begin
      case ({prev_state, current_state})
        4'b0001, 4'b0111, 4'b1110, 4'b1000: begin
           if (brightness <= 8'd247)
             brightness <= brightness + 8'd8;
           else
             brightness <= 8'd255;
        end
        4'b0010, 4'b0100, 4'b1101, 4'b1011: begin
           if (brightness >= 8'd8)
             brightness <= brightness - 8'd8;
           else
             brightness <= 8'd0;
        end
        default: brightness <= brightness;
      endcase
		end
		else begin
			brightness <= brightness;
		end
      prev_state <= current_state;
		end
   end

   always @(posedge CLK10K or negedge RSTN) begin
      if (!RSTN) begin
	 pwm_counter <= 8'b0;
      end
      else begin
	 pwm_counter <= (pwm_counter == 8'd255) ? 8'd0 : pwm_counter + 8'd1;
      end
   end

   always @(posedge CLK10K or negedge RSTN) begin
      if (!RSTN) begin
	 PWM_ACT <= 1'b1;
      end
      else begin
	 if (pwm_counter < brightness) PWM_ACT <= 1'b1;
	 else PWM_ACT <= 1'b0;
      end
   end

endmodule

