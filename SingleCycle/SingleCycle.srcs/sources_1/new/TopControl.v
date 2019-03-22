`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2019 02:39:38 PM
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


module TopControl(input [5:0] opCode, [5:0] Funct, output MtoRFSel, DMWE, Branch,
                  ALUInSel, Jump, RFDSel, RFWE, [2:0] ALUSel);
                  
    wire [1:0] ALUOp;
    
    MainDecoder U0 (.opCode(opCode), .MtoRFSel(MtoRFSel), .DMWE(DMWE),
                    .Branch(Branch), .ALUInSel(ALUInSel), .Jump(Jump),
                    .RFDSel(RFDSel), .RFWE(RFWE), .ALUOp(ALUOp));
                    
    ALUDecoder U1 (.ALUOp(ALUOp), .Funct(Funct), .ALUSel(ALUSel));
endmodule
