module FIRE_DETECT(/*AUTOARG*/
		   // Outputs
		   FIRE_ALARM,
		   // Inputs
		   CLK1K, RSTN, SENSOR
		   );
   input CLK1K, RSTN; // Text other ports
   input SENSOR;
   output reg FIRE_ALARM;

   // Internal signal declarations
   reg 	  next_fire_alarm;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 FIRE_ALARM <= 1'h0;
	 // End of automatics
      end
      else begin
	 FIRE_ALARM <= next_fire_alarm;
      end
   end

   // Combinational logic
   always @(*) begin
      next_fire_alarm = (SENSOR) ? 1'b1 : 1'b0;
   end
endmodule

