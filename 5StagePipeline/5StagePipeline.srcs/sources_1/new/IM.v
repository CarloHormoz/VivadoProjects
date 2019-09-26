`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: IM
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


module IM(input [31:0] IMA, output [31:0] IMRD);
            // Initialize Instruction memory.
    reg [31:0] Mem [0:255];
    initial $readmemb("Inst.mem", Mem);
    assign IMRD = Mem[IMA];
endmodule