`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 06:43:07 PM
// Design Name: 
// Module Name: StallRegister
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


module StallRegister(input CLK, CLR, StallD, [31:0] in, output reg [31:0] out);
    always @ (posedge CLK) begin
        if (CLR) out <= 0;
        else if (!StallD) out <= in;
    end   
endmodule
