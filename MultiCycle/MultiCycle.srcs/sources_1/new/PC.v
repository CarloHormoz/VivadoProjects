`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
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


module PC(input CLK, RST, PCEn, [31:0] PCin, output reg [31:0] PCout);
    initial PCout = 0;
    always @ (posedge CLK) begin
        if (PCEn) begin
            if (RST) PCout <= 0;
            else PCout <= PCin;
        end
    end
endmodule
