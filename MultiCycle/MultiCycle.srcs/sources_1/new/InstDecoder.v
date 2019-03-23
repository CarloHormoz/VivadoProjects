`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 11:25:51 PM
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


module InstDecoder(input [31:0] Inst, output [5:0] OpCode, [4:0] rs, [4:0] rt,
                    [4:0] rd, [5:0] Funct, [25:0] Jaddr, [4:0] shamt, signed [31:0] SImm);
    assign OpCode = Inst[31:26];     
    assign rs = Inst[25:21];
    assign rt = Inst[20:16];
    assign rd = Inst[15:11];
    assign Funct = Inst[5:0];
    assign Jaddr = Inst[25:0];
    assign shamt = Inst[10:6];
    assign SImm = {{16{Inst[15]}}, Inst[15:0]}; // Sign extend immediate to 32 bits.
    
endmodule
