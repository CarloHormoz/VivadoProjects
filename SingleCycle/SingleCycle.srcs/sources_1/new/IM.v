`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 11:03:39 AM
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
    reg [31:0] Mem [0:20];
    initial $readmemb("Inst.mem", Mem);
    assign IMRD = Mem[IMA];
endmodule
