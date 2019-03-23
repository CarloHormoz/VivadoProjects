`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2019 12:16:24 AM
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


module MainDecoder(input CLK, RST, [5:0] OpCode, output reg IDSel, ALUIn1Sel, RFDSel, MtoRFSel, Branch,
                   reg [1:0] ALUIn2Sel, PCSel, reg IRWE, MWE, PCWE, RFWE, reg [1:0] ALUOp);
        localparam s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, s4 = 4'b0100, s5 = 4'b0101,
                   s6 = 4'b0110, s7 = 4'b0111, s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011;
        reg [3:0] state = 4'b0;
        
        always @ (posedge CLK) begin
            if (RST) state <= s0;
            else begin
                case(state)
                    s0: state <= s1;
                    s1: begin
                        case(OpCode)
                            6'b100011: state <= s2;     // LW
                            6'b101011: state <= s2;     // SW
                            6'b000000: state <= s6;     // R-Type
                            6'b001000: state <= s9;
                            6'b000100: state <= s8;     // Beq
                            6'b000010: state <= s11;    // J
                            default: state <= s2;
                        endcase
                    end
                    s2: begin
                        if (OpCode == 6'b100011) state <= s3;   // LW
                        else state <= s5;                       // SW
                    end
                    s3: state <= s4;
                    s4: state <= s0;
                    s5: state <= s0;
                    s6: state <= s7;        // R-Type
                    s7: state <= s0;
                    s8: state <= s0;
                    s9: state <= s10;
                    s10: state <= s0;
                    s11: state <= s0;
                    default: state <= s0;
                endcase
            end            
        end
        
        always @ (*) begin
            case(state)
                s0: begin
                    MtoRFSel = 1'bx; RFDSel = 1'bx; IDSel = 0; PCSel = 2'b00; 
                    ALUIn1Sel = 0; ALUIn2Sel = 2'b01; ALUOp = 2'b00;
                    IRWE = 1; PCWE = 1; MWE = 0; Branch = 0; RFWE = 0;
                end
                s1: begin
                    PCWE = 0; IRWE = 0; ALUIn2Sel = 2'b10;
                end
                s2: begin
                    ALUIn1Sel = 1; ALUIn2Sel = 2'b10; ALUOp = 2'b00;
                end
                s3: begin
                    IDSel = 1;
                end
                s4: begin
                    RFWE = 1; RFDSel = 0; MtoRFSel = 1;
                end
                s5: begin
                    IDSel = 1; MWE = 1;
                end
                s6: begin
                    ALUIn1Sel = 1; ALUIn2Sel = 2'b00; ALUOp = 2'b10;
                end
                s7: begin
                    RFDSel = 1; MtoRFSel = 0; RFWE = 1;
                end
                s8: begin
                    ALUIn1Sel = 1; ALUIn2Sel = 2'b00; ALUOp = 2'b01;
                    PCSel = 2'b01; Branch = 1;
                end
                s9: begin
                    ALUIn1Sel = 1; ALUIn2Sel = 2'b10; ALUOp = 2'b00;
                end
                s10: begin
                    RFDSel = 0; MtoRFSel = 0; RFWE = 1;
                end
                s11: begin
                    PCSel = 2'b10;  PCWE = 1;
                end
            endcase
        end
endmodule
