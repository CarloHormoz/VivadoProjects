`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:36:43 PM
// Design Name: 
// Module Name: Mux2to1
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


module Mux2to1#(parameter WL = 32)(input sel, [WL - 1:0] in1, [WL - 1:0] in2, output [WL - 1:0] out);
    assign out = sel ? in1 : in2;   // in2 corresponds with upper input on schematic. in1 is lower input
endmodule
