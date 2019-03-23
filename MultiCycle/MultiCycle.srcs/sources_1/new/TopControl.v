`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
// Design Name: 
// Module Name: TopControl
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


module TopControl(input CLK, RST, [5:0] OpCode, Funct, output PCWE, RFWE, MWE, IRWE, 
                  RFDSel, MtoRFSel, Branch, ALUIn1Sel, IDSel, [1:0] ALUIn2Sel, PCSel, [2:0] ALUSel);
                  
    wire [1:0] ALUOp;
    
    MainDecoder U0 (.CLK(CLK), .RST(RST), .OpCode(OpCode), .IDSel(IDSel), .ALUIn1Sel(ALUIn1Sel), .RFDSel(RFDSel), .PCSel(PCSel), .Branch(Branch),
                    .MtoRFSel(MtoRFSel), .ALUIn2Sel(ALUIn2Sel), .IRWE(IRWE), .MWE(MWE), .PCWE(PCWE), .RFWE(RFWE), .ALUOp(ALUOp));
    
    ALUDecoder U1 (.Funct(Funct), .ALUOp(ALUOp), .ALUSel(ALUSel));
    
endmodule
