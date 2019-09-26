`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: MainDecoder
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

module MainDecoder(input [5:0] opCode, output reg MtoRFSel, DMWE, Branch, ALUInSel, 
                   Jump_D, RFDSel, RFWE, reg [1:0] ALUOp);
    always @ (*) begin
        case(opCode)
            6'b000000: begin    // R-type
                RFWE = 1; RFDSel = 1; ALUInSel = 0; Branch = 0;
                DMWE = 0; MtoRFSel = 0; Jump_D = 0; ALUOp = 2'b10;
            end
            6'b100011: begin    // LW
                RFWE = 1; RFDSel = 0; ALUInSel = 1; Branch = 0;
                DMWE = 0; MtoRFSel = 1; Jump_D = 0; ALUOp = 2'b00;
            end
            6'b101011: begin    // SW
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 1; Branch = 0;
                DMWE = 1; MtoRFSel = 0; Jump_D = 0; ALUOp = 2'b00;
            end
            6'b000100: begin    // BEQ
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 0; Branch = 1;
                DMWE = 0; MtoRFSel = 0; Jump_D = 0; ALUOp = 2'b01;
            end
            6'b001000: begin    // ADDI
                RFWE = 1; RFDSel = 0; ALUInSel = 1; Branch = 0;
                DMWE = 0; MtoRFSel = 0; Jump_D = 0; ALUOp = 2'b00;
            end
            6'b000010: begin    // J
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 1'bx; Branch = 0;
                DMWE = 0; MtoRFSel = 0; ALUOp = 2'bxx; Jump_D = 1;
            end
            default: begin
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 1'bx; Branch = 1'bx;
                DMWE = 0; Jump_D = 1'bx; ALUOp = 2'bxx; MtoRFSel = 0;
            end
        endcase
    end
endmodule

