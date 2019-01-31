
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:09 02/04/2012 
// Design Name: 
// Module Name:    ioTest 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Testing IO board.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ioTest (input  M_CLOCK,
					input  [3:0] btn,       // IO Board Pushbutton Switches 
					output [3:0] an, 	// IO Board Seven Segment Digits					
					output reg [7:0] seg   // 7=dp, 6=g, 5=f,4=e, 3=d,2=c,1=b, 0=a
					);         // Decimal point in the seven segment
					
					// active low				
					
					assign an = 4'b1110;
					
					always @ * begin
					
					   case (btn)
					       4'b0000: seg = 8'b11000000; //0
					       4'b0001: seg = 8'b11111001; //1
					       4'b0010: seg = 8'b10100100; //2
					       4'b0011: seg = 8'b10110000; //3
					       4'b0100: seg = 8'b10011001; //4
					       4'b0101: seg = 8'b10010010; //5
					       4'b0110: seg = 8'b10000010; //6
					       4'b0111: seg = 8'b11011000; //7
					       4'b1000: seg = 8'b10000000;
					        //8
					       
					       default: seg = 7'b1111111; //F
					
					   endcase
					
					end
endmodule
	