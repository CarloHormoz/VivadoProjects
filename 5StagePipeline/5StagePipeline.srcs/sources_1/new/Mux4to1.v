`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 10:06:47 PM
// Design Name: 
// Module Name: Mux4to1
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


module Mux4to1#(parameter WL = 32)(input [WL - 1:0] in1, in2, in3, in4, [1:0] sel, output reg [WL - 1:0] out);
    always @ (*) begin
        case(sel)
            2'b00: out = in4;
            2'b01: out = in3;
            2'b10: out = in2;
            2'b11: out = in1;
            default: out = in4;
        endcase
    end    
endmodule