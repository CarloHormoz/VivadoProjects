`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 11:05:58 AM
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
    wire RFWE, DMWE, MtoRFSel, Branch, ALUInSel, RFDSel, Jump;
    wire [2:0] ALUSel;
    wire [5:0] opCode, Funct;
    assign out = DMWE;
    
    TopData U0 (.CLK(CLK), .RST(RST), .RFWE(RFWE), .DMWE(DMWE), .Jump(Jump),
                .Branch(Branch), .ALUInSel(ALUInSel), .RFDSel(RFDSel),
                .MtoRFSel(MtoRFSel), .ALUsel(ALUSel), .opCode(opCode), .Funct(Funct));
                
    TopControl U1 (.opCode(opCode), .Funct(Funct), .MtoRFSel(MtoRFSel),
                   .DMWE(DMWE), .Branch(Branch), .ALUInSel(ALUInSel),
                   .Jump(Jump), .RFDSel(RFDSel), .RFWE(RFWE), .ALUSel(ALUSel));
endmodule
