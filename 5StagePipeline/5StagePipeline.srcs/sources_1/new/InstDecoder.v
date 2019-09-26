`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: InstDecoder
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


module InstDecoder(input [31:0] Inst, output [5:0] opCode, [4:0] rs, [4:0] rt,
               [4:0] rd, [5:0] funct, [25:0] Jaddr, [4:0] shamt, signed [31:0] SImm);
               
       // Extract the fields of instruction taken from Instruction Memory Module.
        assign opCode = Inst[31:26];     
        assign rs = Inst[25:21];
        assign rt = Inst[20:16];
        assign rd = Inst[15:11];
        assign funct = Inst[5:0];
        assign Jaddr = Inst[25:0];
        assign shamt = Inst[10:6];
        assign SImm = {{16{Inst[15]}}, Inst[15:0]}; // Sign extend immediate to 32 bits.
endmodule
