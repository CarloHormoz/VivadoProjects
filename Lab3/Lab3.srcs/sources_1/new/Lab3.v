`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Carlo Hormoz
// 
// Create Date: 02/11/2019 09:01:43 PM
// Design Name: 
// Module Name: Lab3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Lab2(input [4:0] IO_PB,
                input CLK,
                input [9:0] sw,
                output reg [11:0] led, 
				output [3:0] IO_SSEGD,
				output reg [7:0] IO_SSEG);
				
	  // Extract sum and logical operations of two 4 bit numbers from switches.
	  // For Parts B and C.			
	wire [3:0] sum, AND, OR, NOR, NAND;
	assign sum = sw[3:0] + sw[7:4];
    assign AND = sw[3:0] & sw[7:4];
    assign OR = sw[3:0] | sw[7:4];
    assign NOR = ~(sw[3:0] | sw[7:4]);
    assign NAND = ~(sw[3:0] & sw[7:4]);
    
	   // PART A and C) Show the value of the 4 LSB switches, in hex, when center button is pressed.
	   //               If 9th switch from right is flipped, show addition of switch [3:0] + switch [7:4] instead.
	   
	assign IO_SSEGD = IO_PB[4] == 1 ? 4'b1110 : 4'b1111;   // Turn on 7 segment when middle push button is pressed.
	always @ (*) begin
	 // If switch is not flipped -> Part A. Else -> Part C
        case(sw[8] == 0 ? sw[3:0] : sum)         
            1: IO_SSEG = 8'b11111001;
            2: IO_SSEG = 8'b10100100;
            3: IO_SSEG = 8'b10110000;
            4: IO_SSEG = 8'b10011001;
            5: IO_SSEG = 8'b10010010;
            6: IO_SSEG = 8'b10000010;
            7: IO_SSEG = 8'b11011000;
            8: IO_SSEG = 8'b10000000;
            9: IO_SSEG = 8'b10010000; 
            10: IO_SSEG = 8'b10001000;
            11: IO_SSEG = 8'b10000011;
            12: IO_SSEG = 8'b11000110;
            13: IO_SSEG = 8'b10100001;
            14: IO_SSEG = 8'b10000110;
            15: IO_SSEG = 8'b10001110;
            default: IO_SSEG = 8'b11000000;
        endcase
    end
    
	  // PART B) Logical op's on two 4 bit numbers from switches/
	  //         Clockwise from top button -> AND, OR, NOR, NAND
	  //         Displays on rightmost 4 LEDs.	
	always @ (*) begin
	   case(IO_PB[3:0]) // 4' Left Down Right Up
	       1: led[3:0] = AND;
	       2: led[3:0] = OR;
	       4: led[3:0] = NOR;
	       8: led[3:0] = NAND;
	       default: led[3:0] = 4'b0000;
	   endcase
	end
	
	  // Part C) Start timer when switch 10 is flipped on.
	reg [31:0] counter;
	always @ (posedge CLK) begin
	  // At clock pulse, add one to counter. Assigning only the 8 most 
	  // significant bits to the led to divide the clock.
	   if (sw[9]) begin
	       counter <= counter + 1;
	       led[11:4] <= counter[31:24];
	   end
	     // If switch is not flipped, reset variables at clock pulse.
	   else begin
	       counter <= 0;
	       led[11:4] <= 0;
	   end
	end
endmodule
