`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2019 02:40:13 PM
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
                   Jump, RFDSel, RFWE, reg [1:0] ALUOp);
    always @ (*) begin
        case(opCode)
            6'b000000: begin    // R-type
                RFWE = 1; RFDSel = 1; ALUInSel = 0; Branch = 0;
                DMWE = 0; MtoRFSel = 0; Jump = 0; ALUOp = 2'b10;
            end
            6'b100011: begin    // LW
                RFWE = 1; RFDSel = 0; ALUInSel = 1; Branch = 0;
                DMWE = 0; MtoRFSel = 1; Jump = 0; ALUOp = 2'b00;
            end
            6'b101011: begin    // SW
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 1; Branch = 0;
                DMWE = 1; MtoRFSel = 1'bx; Jump = 0; ALUOp = 2'b00;
            end
            6'b000100: begin    // BEQ
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 0; Branch = 1;
                DMWE = 0; MtoRFSel = 1'bx; Jump = 0; ALUOp = 2'b01;
            end
            6'b001000: begin    // ADDI
                RFWE = 1; RFDSel = 0; ALUInSel = 1; Branch = 0;
                DMWE = 0; MtoRFSel = 0; Jump = 0; ALUOp = 2'b00;
            end
            6'b000010: begin    // J
                RFWE = 0; RFDSel = 1'bx; ALUInSel = 1'bx; Branch = 0;
                DMWE = 0; MtoRFSel = 1'bx; ALUOp = 2'bxx; Jump = 1;
            end
            default: begin
                RFWE = 1'bx; RFDSel = 1'bx; ALUInSel = 1'bx; Branch = 1'bx;
                DMWE = 1'bx; MtoRFSel = 1'bx; Jump = 1'bx; ALUOp = 2'bxx;
            end
        endcase
    end
endmodule
