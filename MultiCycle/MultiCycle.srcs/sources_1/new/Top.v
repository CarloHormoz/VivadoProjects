`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
// Design Name: 
// Module Name: Top
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


module Top(input CLK, RST, output out);
    wire PCWE, RFWE, MWE, IRWE, ALUIn1Sel, IDSel, RFDSel, MtoRFSel, Branch;
    wire [1:0] ALUIn2Sel, PCSel;
    wire [2:0] ALUSel;
    wire [5:0] OpCode, Funct;
    
    assign out = PCWE;
    
    TopData U0 (.CLK(CLK), .RST(RST), .PCWE(PCWE), .RFWE(RFWE), .MWE(MWE), .MtoRFSel(MtoRFSel),
                .IRWE(IRWE), .RFDSel(RFDSel), .ALUIn1Sel(ALUIn1Sel), .ALUIn2Sel(ALUIn2Sel),
                .IDSel(IDSel), .PCSel(PCSel), .ALUSel(ALUSel), .Branch(Branch), .OpCode(OpCode), .Funct(Funct));
                
    TopControl U1(.CLK(CLK), .RST(RST), .OpCode(OpCode), .Funct(Funct), .PCWE(PCWE), .RFWE(RFWE), .MWE(MWE),
                  .IRWE(IRWE), .ALUIn1Sel(ALUIn1Sel), .RFDSel(RFDSel), .MtoRFSel(MtoRFSel), .ALUIn2Sel(ALUIn2Sel),
                  .PCSel(PCSel), .Branch(Branch), .IDSel(IDSel), .ALUSel(ALUSel));    
                  
endmodule
