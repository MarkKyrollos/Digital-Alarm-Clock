#Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

#reset
set_property PACKAGE_PIN R2 [get_ports {rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst}]

#enable
set_property PACKAGE_PIN U1 [get_ports {enable}]
set_property IOSTANDARD LVCMOS33 [get_ports {enable}]


# 7-Segments
set_property PACKAGE_PIN W7 [get_ports {segment[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[0]}] 

set_property PACKAGE_PIN W6 [get_ports {segment[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[1]}] 

set_property PACKAGE_PIN U8 [get_ports {segment[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[2]}] 

set_property PACKAGE_PIN V8 [get_ports {segment[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[3]}] 

set_property PACKAGE_PIN U5 [get_ports {segment[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[4]}] 

set_property PACKAGE_PIN V5 [get_ports {segment[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[5]}] 

set_property PACKAGE_PIN U7 [get_ports {segment[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment[6]}] 


# the 4 Buttons - BTNC, BTNU, BTND, BTNL, BTNR

set_property PACKAGE_PIN U18 [get_ports {buttons_input[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons_input[0]}] 

set_property PACKAGE_PIN W19 [get_ports {buttons_input[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons_input[1]}] 

set_property PACKAGE_PIN T17 [get_ports {buttons_input[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons_input[2]}] 

set_property PACKAGE_PIN T18 [get_ports {buttons_input[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons_input[3]}] 

set_property PACKAGE_PIN U17 [get_ports {buttons_input[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons_input[4]}] 


# All 4 Anodes

set_property PACKAGE_PIN U2 [get_ports {anodes[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anodes[0]}] 


set_property PACKAGE_PIN U4 [get_ports {anodes[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {anodes[1]}] 

set_property PACKAGE_PIN V4 [get_ports {anodes[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {anodes[2]}]

set_property PACKAGE_PIN W4 [get_ports {anodes[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anodes[3]}] 

# all 4 LEDS LD12-15
set_property PACKAGE_PIN P3 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}] 

set_property PACKAGE_PIN N3 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}] 

set_property PACKAGE_PIN P1 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]

set_property PACKAGE_PIN L1 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}] 



# LD0 that blinks when reaching alarm time and ON during Adjust mode

set_property PACKAGE_PIN U16 [get_ports {led_mode}]

set_property IOSTANDARD LVCMOS33 [get_ports {led_mode}] 



# the decimal point on 7-segment display
set_property PACKAGE_PIN V7 [get_ports {seg_dec_point}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_dec_point}] 


#sound for buzzer

set_property PACKAGE_PIN M18 [get_ports {sound}]
set_property IOSTANDARD LVCMOS33 [get_ports {sound}]
set_property PULLUP TRUE [get_ports {sound}]