module TOP(/*AUTOARG*/
	   // Outputs
	   SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7, LED, BUZ_OUT,
	   // Inputs
	   CLK50M, KEY1, KEY2, KEY3, SW0, SW1, SW2, SW3, SW4, SW5, KNOCK,
	   SENSOR, ROT_A, ROT_B
	   );
   input CLK50M, KEY1, KEY2, KEY3, SW0, SW1, SW2, SW3, SW4, SW5, KNOCK, SENSOR, ROT_A, ROT_B;
   output [6:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;
   output [17:0] LED;
   output 	 BUZ_OUT;

   // Internal signal declarations
   wire 	 CLK1K, CLK10K, CLEAN_KEY1, CLEAN_KEY2, CLEAN_KEY3, CLEAN_SW1, CLEAN_SW2, CLEAN_SW3, CLEAN_SW4, CLEAN_SW5, ALARM, FIRE_ALARM, FIRE_VALID, PWM_ACT, FIRE_BUZ, KNOCK_LED_BUZ;
   wire [7:0] 	 SEC, MIN, HOUR, DAY;
   wire [7:0] 	 SEC_SET, MIN_SET, HOUR_SET, DAY_SET;
   wire [7:0] 	 SW_SEC, SW_MIN, SW_HOUR, SW_DAY;

   assign BUZ_OUT = (FIRE_VALID) ? FIRE_BUZ : KNOCK_LED_BUZ;

   GENCLK1K
     UGENCLK1K
       (/*ANST*/
	// Outputs
	.RSTN				(SW0),
	.CLK1K				(CLK1K),
	// Inputs
	.CLK50M				(CLK50M));

   GENCLK10K
     UGENCLK10K
       (/*AINST*/
	// Outputs
	.RSTN					(SW0),
	.CLK10K				(CLK10K),
	// Inputs
	.CLK50M				(CLK50M));

   DEBOUNCE #(.SET(1'b1))
   UDEBOUNCE_KEY1
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_KEY1),
      // Inputs
      .KEY_IN				(KEY1),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));

   DEBOUNCE #(.SET(1'b1))
   UDEBOUNCE_KEY2
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_KEY2),
      // Inputs
      .KEY_IN				(KEY2),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));

   DEBOUNCE #(.SET(1'b1))
   UDEBOUNCE_KEY3
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_KEY3),
      // Inputs
      .KEY_IN				(KEY3),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));

   DEBOUNCE #(.SET(1'b0))
   UDEBOUNCE_SW1
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_SW1),
      // Inputs
      .KEY_IN				(SW1),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));

   DEBOUNCE #(.SET(1'b0))
   UDEBOUNCE_SW2
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_SW2),
      // Inputs
      .KEY_IN				(SW2),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));
   
   DEBOUNCE #(.SET(1'b0))
   UDEBOUNCE_SW3
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_SW3),
      // Inputs
      .KEY_IN				(SW3),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));
   
   DEBOUNCE #(.SET(1'b0))
   UDEBOUNCE_SW4
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_SW4),
      // Inputs
      .KEY_IN				(SW4),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));
   
   DEBOUNCE #(.SET(1'b0))
   UDEBOUNCE_SW5
     (/*ANST*/
      // Outputs
      .KEY_OUT				(CLEAN_SW5),
      // Inputs
      .KEY_IN				(SW5),
      .RSTN				(SW0),
      .CLK1K				(CLK1K));

   DIGITCLOCK
     UDIGITCLOCK
       (/*ANST*/
	// Outputs
	.SEC					(SEC[7:0]),
	.MIN					(MIN[7:0]),
	.HOUR					(HOUR[7:0]),
	.DAY					(DAY[7:0]),
	// Inputs
	.SEC_SET				(SEC_SET[7:0]),
	.MIN_SET				(MIN_SET[7:0]),
	.HOUR_SET				(HOUR_SET[7:0]),
	.DAY_SET				(DAY_SET[7:0]),
	.SW_SEC				(SW_SEC[7:0]),
	.SW_MIN				(SW_MIN[7:0]),
	.SW_HOUR				(SW_HOUR[7:0]),
	.SW_DAY				(SW_DAY[7:0]),
	.RSTN				(SW0),
	.CLK1K				(CLK1K),
	.SW1				(CLEAN_SW1),
	.SW2				(CLEAN_SW2),
	.SW3				(CLEAN_SW3));

   DISPLAY7SEG
     URSEC7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG0[6:0]),
	// Inputs
	.OUT				(SEC[3:0]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     ULSEC7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG1[6:0]),
	// Inputs
	.OUT				(SEC[7:4]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     URMIN7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG2[6:0]),
	// Inputs
	.OUT				(MIN[3:0]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     ULMIN7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG3[6:0]),
	// Inputs
	.OUT				(MIN[7:4]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     URHOUR7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG4[6:0]),
	// Inputs
	.OUT				(HOUR[3:0]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     ULHOUR7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG5[6:0]),
	// Inputs
	.OUT				(HOUR[7:4]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     URDAY7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG6[6:0]),
	// Inputs
	.OUT				(DAY[3:0]),
	.PWM_ACT			(PWM_ACT));

   DISPLAY7SEG
     ULDAY7SEG
       (/*AINST*/
	// Outputs
	.SEG				(SEG7[6:0]),
	// Inputs
	.OUT				(DAY[7:4]),
	.PWM_ACT			(PWM_ACT));
   
   MANSET
     UMANSET
       (/*ANST*/
	// Outputs
	.SEC_SET				(SEC_SET[7:0]),
	.MIN_SET				(MIN_SET[7:0]),
	.HOUR_SET				(HOUR_SET[7:0]),
	.DAY_SET				(DAY_SET[7:0]),
	// Inputs
	.KEY1					(CLEAN_KEY1),
	.KEY2					(CLEAN_KEY2),
	.KEY3					(CLEAN_KEY3),
	.PREV_SEC				(SEC[7:0]),
	.PREV_MIN				(MIN[7:0]),
	.PREV_HOUR				(HOUR[7:0]),
	.PREV_DAY				(DAY[7:0]),
	.RSTN				(SW0),
	.CLK1K				(CLK1K),
	.SW1				(CLEAN_SW1));

   STOPWATCH
     USTOPWATCH
       (/*ANST*/
	// Outputs
	.SW_SEC				(SW_SEC[7:0]),
	.SW_MIN				(SW_MIN[7:0]),
	.SW_HOUR				(SW_HOUR[7:0]),
	.SW_DAY				(SW_DAY[7:0]),
	// Inputs
	.KEY3					(CLEAN_KEY3),
	.RSTN (CLEAN_SW2),
	.CLK1K				(CLK1K),
	.SW3				(CLEAN_SW3));

   KNOCK_LED_ALARM
     UALARM
       (/*ANST*/
	// Outputs
	.BUZ_OUT			(KNOCK_LED_BUZ),
	// Inputs
	.CLK1K				(CLK1K),
	.RSTN					(SW0),
	.ALARM				(ALARM));

   KNOCK_LED
     UKNOCK
       (/*ANST*/
	// Outputs
	.LED					(LED[17:0]),
	.ALARM				(ALARM),
	// Inputs
	.CLK1K				(CLK1K),
	.RSTN					(CLEAN_SW4),
	.SW3				(CLEAN_SW3),
	.KNOCK				(KNOCK));

   FIRE_DETECT
     UFIRE_DETECT
       (/*AUTOINST*/
	// Outputs
	.FIRE_ALARM				(FIRE_ALARM),
	// Inputs
	.CLK1K					(CLK1K),
	.RSTN					(SW0),
	.SENSOR				(SENSOR));

   FIRE_ALARM
     UFIRE_ALARM
       (/*AUTOINST*/
	// Outputs
	.BUZ_OUT				(FIRE_BUZ),
	.FIRE_VALID       (FIRE_VALID),
	// Inputs
	.CLK1K					(CLK1K),
	.RSTN					(SW0),
	.FIRE_ALARM				(FIRE_ALARM),
	.KNOCK					(KNOCK));

   ROT_PWMGEN
     UROT_PWMGEN
       (/*AINST*/
	// Outputs
	.RSTN					(SW0),
	.PWM_ACT			(PWM_ACT),
	// Inputs
	.CLK10K				(CLK10K),
	.SW5				(CLEAN_SW5),
	.ROT_A				(ROT_A),
	.ROT_B				(ROT_B));

endmodule
