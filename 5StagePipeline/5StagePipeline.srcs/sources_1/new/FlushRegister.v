`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 11:16:20 AM
// Design Name: 
// Module Name: FlushRegister
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


module FlushRegister# (parameter WL = 32)(input CLK, CLR, [WL-1:0] in, output reg [WL-1:0] out);
    always @ (posedge CLK) begin
        if (CLR) out <= 0;
        else  out <= in;
    end   
endmodule
