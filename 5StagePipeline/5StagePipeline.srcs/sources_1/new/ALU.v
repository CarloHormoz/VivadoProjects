`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: ALU
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



module ALU(input [2:0] ALUSel, [4:0] shamt, signed [31:0] ALUIn1, signed [31:0] ALUIn2,
           output reg signed [31:0] ALUOutR); 
             
    initial ALUOutR = 0;        
    always @ (*) begin
        case (ALUSel)
            3'b000: ALUOutR = ALUIn1 & ALUIn2;
            3'b001: ALUOutR = ALUIn1 | ALUIn2;
            3'b010: ALUOutR = ALUIn1 + ALUIn2;
            3'b011: ALUOutR = ALUIn2 << shamt;
            3'b100: ALUOutR = ALUIn2 << ALUIn1[4:0];
            3'b101: ALUOutR = ALUIn2 >>> ALUIn1[4:0];
            3'b110: ALUOutR = ALUIn1 - ALUIn2;
            default: ALUOutR = ALUIn1 + ALUIn2;
        endcase
    end
endmodule
