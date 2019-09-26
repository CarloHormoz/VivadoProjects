`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
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


module Mux2to1#(parameter WL = 32) (input sel, [WL - 1:0] in1, in2, output reg [WL - 1:0] out);
    always @ (*) begin
        if (sel == 1) out = in2;
        else out = in1;
    end   // in1 is top wire on schematic, in2 is bottom. Defaults to in1 (in case of x, z)
endmodule
