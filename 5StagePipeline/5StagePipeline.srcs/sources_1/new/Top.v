`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
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

    wire RFWE_E, RFWE_W, RFWE_M, DMWE_M, MtoRFSel_E, MtoRFSel_M, MtoRFSel_W, Branch_D, ALUInSel_E, RFDSel_E, Jump_D;
    wire StallF, StallD, Flush_E, ForwardAD, ForwardBD;
    wire [2:0] ALUSel_E;
    wire [5:0] opCode_D, funct_D;
    wire [1:0] ForwardAE, ForwardBE;
    wire [4:0] rtd_M, rtd_W, rs_E, rt_E, rt_D, rs_D, rtd_E;
    assign out = DMWE_M;
    
    TopData U0 (.CLK(CLK), .RST(RST), .StallF(StallF), .StallD(StallD), .RFWE_W(RFWE_W), .DMWE_M(DMWE_M), .Jump_D(Jump_D),
                .Branch_D(Branch_D), .ALUInSel_E(ALUInSel_E), .RFDSel_E(RFDSel_E), .ForwardAE(ForwardAE), .Flush_E(Flush_E),
                .ForwardBE(ForwardBE), .ForwardAD(ForwardAD), .ForwardBD(ForwardBD), 
                .MtoRFSel_W(MtoRFSel_W), .ALUSel_E(ALUSel_E), .rt_D(rt_D), .rs_D(rs_D),
                .opCode_D(opCode_D), .funct_D(funct_D), .rtd_E(rtd_E), .rtd_M(rtd_M), .rtd_W(rtd_W),
                .rs_E(rs_E), .rt_E(rt_E));
                
    TopControl U1 (.CLK(CLK), .Flush_E(Flush_E), .opCode_D(opCode_D), .funct_D(funct_D), .MtoRFSel_W(MtoRFSel_W), .MtoRFSel_M(MtoRFSel_M),
                   .DMWE_M(DMWE_M), .Branch_D(Branch_D), .ALUInSel_E(ALUInSel_E), .MtoRFSel_E(MtoRFSel_E),
                   .Jump_D(Jump_D), .RFDSel_E(RFDSel_E), .RFWE_E(RFWE_E), .RFWE_M(RFWE_M),
                   .RFWE_W(RFWE_W), .ALUSel_E(ALUSel_E));
    
    HazardUnit U2 (.RFWE_E(RFWE_E), .RFWE_M(RFWE_M), .RFWE_W(RFWE_W), .MtoRFSel_E(MtoRFSel_E), .Branch_D(Branch_D),
                   .rtd_E(rtd_E), .rtd_M(rtd_M), .rtd_W(rtd_W), .rs_E(rs_E), .Flush_E(Flush_E), .MtoRFSel_M(MtoRFSel_M),
                   .rs_D(rs_D), .rt_D(rt_D), .rt_E(rt_E), .ForwardAE(ForwardAE),
                   .ForwardBE(ForwardBE), .ForwardAD(ForwardAD), .ForwardBD(ForwardBD),
                   .StallF(StallF), .StallD(StallD));
endmodule
