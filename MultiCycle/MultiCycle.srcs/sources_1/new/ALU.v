`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
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
           output Zero, reg signed [31:0] ALUOutR);   
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
        endcase
    end
    assign Zero = ALUOutR == 0 ? 1 : 0;
endmodule
