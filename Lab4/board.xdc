## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

##Sch name = JA1

set_property PACKAGE_PIN L2 [get_ports JA2]
     set_property IOSTANDARD LVCMOS33 [get_ports JA2]
 
    
# Clock signal

set_property PACKAGE_PIN W5 [get_ports CLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]

	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]
	
## Switches

set_property PACKAGE_PIN V17 [get_ports {IO_SW[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[0]}]

set_property PACKAGE_PIN V16 [get_ports {IO_SW[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[1]}]

set_property PACKAGE_PIN W16 [get_ports {IO_SW[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[2]}]

set_property PACKAGE_PIN W17 [get_ports {IO_SW[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[3]}]

set_property PACKAGE_PIN W15 [get_ports {IO_SW[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[4]}]

set_property PACKAGE_PIN V15 [get_ports {IO_SW[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[5]}]

set_property PACKAGE_PIN W14 [get_ports {IO_SW[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[6]}]

set_property PACKAGE_PIN W13 [get_ports {IO_SW[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[7]}]

#set_property PACKAGE_PIN V2 [get_ports {IO_SW[8]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[8]}]

#set_property PACKAGE_PIN T3 [get_ports {IO_SW[9]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[9]}]

#set_property PACKAGE_PIN T2 [get_ports {IO_SW[10]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[10]}]

#set_property PACKAGE_PIN R3 [get_ports {IO_SW[11]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[11]}]

#set_property PACKAGE_PIN W2 [get_ports {IO_SW[12]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[12]}]

#set_property PACKAGE_PIN U1 [get_ports {IO_SW[13]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[13]}]

#set_property PACKAGE_PIN T1 [get_ports {IO_SW[14]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[14]}]

#set_property PACKAGE_PIN R2 [get_ports {IO_SW[15]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SW[15]}]


## LEDs

#set_property PACKAGE_PIN U16 [get_ports {led[0]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

#set_property PACKAGE_PIN E19 [get_ports {led[1]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

#set_property PACKAGE_PIN U19 [get_ports {led[2]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]

#set_property PACKAGE_PIN V19 [get_ports {led[3]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]

#set_property PACKAGE_PIN W18 [get_ports {led[4]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]

#set_property PACKAGE_PIN U15 [get_ports {led[5]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]

#set_property PACKAGE_PIN U14 [get_ports {led[6]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]

#set_property PACKAGE_PIN V14 [get_ports {led[7]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]

#set_property PACKAGE_PIN V13 [get_ports {led[8]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]

#set_property PACKAGE_PIN V3 [get_ports {led[9]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]

#set_property PACKAGE_PIN W3 [get_ports {led[10]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]

#set_property PACKAGE_PIN U3 [get_ports {led[11]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]

#set_property PACKAGE_PIN P3 [get_ports {led[12]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]

#set_property PACKAGE_PIN N3 [get_ports {led[13]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]

#set_property PACKAGE_PIN P1 [get_ports {led[14]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]

#set_property PACKAGE_PIN L1 [get_ports {led[15]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]
	
	
##7 segment display

#set_property PACKAGE_PIN W7 [get_ports {IO_SSEG[0]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[0]}]
	
#set_property PACKAGE_PIN W6 [get_ports {IO_SSEG[1]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[1]}]
	
#set_property PACKAGE_PIN U8 [get_ports {IO_SSEG[2]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[2]}]
	
#set_property PACKAGE_PIN V8 [get_ports {IO_SSEG[3]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[3]}]
	
#set_property PACKAGE_PIN U5 [get_ports {IO_SSEG[4]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[4]}]
	
#set_property PACKAGE_PIN V5 [get_ports {IO_SSEG[5]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[5]}]
	
#set_property PACKAGE_PIN U7 [get_ports {IO_SSEG[6]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEG[6]}]
	
#set_property PACKAGE_PIN V7 [get_ports IO_SSEG[7]]
	#set_property IOSTANDARD LVCMOS33 [get_ports IO_SSEG[7]]


	#U2 is the right most digit
#set_property PACKAGE_PIN U2 [get_ports {IO_SSEGD[0]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEGD[0]}]
	
#set_property PACKAGE_PIN U4 [get_ports {IO_SSEGD[1]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEGD[1]}]
	
#set_property PACKAGE_PIN V4 [get_ports {IO_SSEGD[2]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEGD[2]}]
	
#set_property PACKAGE_PIN W4 [get_ports {IO_SSEGD[3]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_SSEGD[3]}]


##Buttons

# Upper button
set_property PACKAGE_PIN T18 [get_ports {IO_PB}]
	set_property IOSTANDARD LVCMOS33 [get_ports {IO_PB}]

# Right button
#set_property PACKAGE_PIN T17 [get_ports {IO_PB[1]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_PB[1]}]
	
# Bottom button
#set_property PACKAGE_PIN U17 [get_ports {IO_PB[2]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_PB[2]}]
	
# Left button
#set_property PACKAGE_PIN W19 [get_ports {IO_PB[3]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {IO_PB[3]}]
	
# Center button
#set_property PACKAGE_PIN U18 [get_ports IO_PB[4]]
    #set_property IOSTANDARD LVCMOS33 [get_ports IO_PB[4]]