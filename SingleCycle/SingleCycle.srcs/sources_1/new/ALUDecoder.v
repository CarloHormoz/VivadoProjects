`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2019 02:40:28 PM
// Design Name: 
// Module Name: ALUDecoder
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


module ALUDecoder(input [1:0] ALUOp, [5:0] Funct, output reg [2:0] ALUSel);
    
    always @ (*) begin
        casex(ALUOp)
            0: begin
                ALUSel = 3'b010;    // ADD
            end
            1: begin
                ALUSel = 3'b110;    // SUBTRACT
            end
            2'b1x: begin    // 2 or 3 -> Look at funct
                case(Funct)
                    6'b000000: begin
                        ALUSel = 3'b011;    // SHIFT LEFT
                    end
                    6'b100000: begin
                        ALUSel = 3'b010;    // ADD
                    end
                    6'b100010: begin
                        ALUSel = 3'b110;    // SUBTRACT
                    end
                    6'b100100: begin
                        ALUSel = 3'b000;    // AND
                    end
                    6'b100101: begin
                        ALUSel = 3'b001;    // OR
                    end
                    6'b101010: begin
                        ALUSel = 3'b111;    // SLT
                    end
                    6'b000100: begin
                        ALUSel = 3'b100;    // SLLV
                    end
                    6'b000111: begin
                        ALUSel = 3'b101;    // SRAV
                    end
                    default: ALUSel = 3'bxxx;
                endcase
            end
            default: ALUSel = 3'bxxx;
        endcase
    end
    
endmodule
