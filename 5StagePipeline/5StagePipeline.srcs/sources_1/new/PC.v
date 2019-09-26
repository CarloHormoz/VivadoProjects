`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: PC
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


module PC(input CLK, RST, StallF, [31:0] PCin, output reg [31:0] PC_F);
    initial PC_F = 0;
    always @ (posedge CLK) begin
        if (RST) PC_F <= 0;
        else if (!StallF) PC_F <= PCin;
    end
endmodule
