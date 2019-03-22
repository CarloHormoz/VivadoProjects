`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 10:55:04 AM
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


module Mux2to1#(parameter WL = 32) (input sel, [WL - 1:0] in1, in2, output [WL - 1:0] out);
    assign out = sel ? in2 : in1;   // in1 is top wire on schematic, in2 is bottom.
endmodule
