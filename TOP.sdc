#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "CLOCK50M" -period 20.000ns [get_ports {CLK50M}] -waveform {0.000 10.000}
create_generated_clock -name "CLOCK10K" -divide_by 2500 -source [get_ports {CLK50M}] [get_nets {UGENCLK10K|CLK10K}]
create_generated_clock -name "CLOCK1K" -divide_by 25000 -source [get_ports {CLK50M}] [get_nets {UGENCLK1K|CLK1K}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
#derive_clock_uncertainty
# Not supported for family Cyclone II

# tsu/th constraints

set_false_path -from [get_ports {SW0}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {KEY1}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {KEY1}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {KEY2}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {KEY2}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {KEY3}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {KEY3}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {SW1}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {SW1}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {SW2}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {SW2}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {SW3}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {SW3}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {SW4}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {SW4}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {SW5}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {SW5}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {KNOCK}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {KNOCK}]
set_input_delay -clock "CLOCK1K" -max 3ns [get_ports {SENSOR}]
set_input_delay -clock "CLOCK1K" -min 1ns [get_ports {SENSOR}]

set_input_delay -clock "CLOCK10K" -max 3ns [get_ports {ROT_A}]
set_input_delay -clock "CLOCK10K" -min 1ns [get_ports {ROT_A}]
set_input_delay -clock "CLOCK10K" -max 3ns [get_ports {ROT_B}]
set_input_delay -clock "CLOCK10K" -min 1ns [get_ports {ROT_B}]

# tco constraints

set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG0[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG0[6]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG1[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG1[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG2[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG2[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG3[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG3[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG4[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG4[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG5[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG5[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG6[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG6[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[0]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[1]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[1]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[2]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[2]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[3]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[3]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[4]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[4]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[5]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[5]}] 
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {SEG7[6]}] 
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {SEG7[6]}]

set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[0]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[0]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[1]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[1]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[2]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[2]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[3]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[3]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[4]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[4]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[5]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[5]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[6]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[6]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[7]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[7]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[8]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[8]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[9]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[9]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[10]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[10]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[11]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[11]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[12]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[12]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[13]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[13]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[14]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[14]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[15]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[15]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[16]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[16]}]
set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {LED[17]}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {LED[17]}]

set_output_delay -clock "CLOCK1K" -max 3ns [get_ports {BUZ_OUT}]
set_output_delay -clock "CLOCK1K" -min 1ns [get_ports {BUZ_OUT}]

# tpd constraints

