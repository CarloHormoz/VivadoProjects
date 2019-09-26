`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
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


module TopControl(input CLK, Flush_E, [5:0] opCode_D, [5:0] funct_D, output Jump_D, DMWE_M, Branch_D,
                  ALUInSel_E, RFDSel_E, RFWE_E, RFWE_W, RFWE_M, MtoRFSel_W, MtoRFSel_E, MtoRFSel_M, [2:0] ALUSel_E);

   // Reg wire lengths.
    parameter WL1 = 1;
    parameter WL3 = 3;

/******************* Connecting Wires (Selects and Enables) **************************/   

    wire [1:0] ALUOp;
    
   /***** Decode Stage *****/
    
    wire DMWE_D, RFWE_D, ALUInSel_D, MtoRFSel_D, RFDSel_D;
    wire [2:0] ALUSel_D;     // For ALU decoder
   
   /***** Execute *****/ 
    wire DMWE_E; 
    
/******************* Control Modules ******************/

    MainDecoder U0 (.opCode(opCode_D), .MtoRFSel(MtoRFSel_D), .DMWE(DMWE_D), .Branch(Branch_D),
                    .ALUInSel(ALUInSel_D), .Jump_D(Jump_D), .RFDSel(RFDSel_D), .RFWE(RFWE_D), .ALUOp(ALUOp));

    ALUDecoder U1 (.ALUOp(ALUOp), .funct(funct_D), .ALUSel(ALUSel_D)); 

    
/******************** Registers ********************/
      
   /*** Decode -> Execute ***/
    FlushRegister #(.WL(WL1)) RFWEReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(RFWE_D), .out(RFWE_E));
    FlushRegister #(.WL(WL1)) MtoRFSelReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(MtoRFSel_D), .out(MtoRFSel_E));
    FlushRegister #(.WL(WL1)) DMWEReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(DMWE_D), .out(DMWE_E));
    FlushRegister #(.WL(WL1)) ALUInSelReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(ALUInSel_D), .out(ALUInSel_E));
    FlushRegister #(.WL(WL1)) RFDSelReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(RFDSel_D), .out(RFDSel_E));
    FlushRegister #(.WL(WL3)) ALUSelReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(ALUSel_D), .out(ALUSel_E));
    
   /*** Execute -> Mem ***/
    Register #(.WL(WL1)) RFWEReg_EtoM (.CLK(CLK), .in(RFWE_E), .out(RFWE_M));
    Register #(.WL(WL1)) MtoRFSelReg_EtoM (.CLK(CLK), .in(MtoRFSel_E), .out(MtoRFSel_M));
    Register #(.WL(WL1)) DMWEReg_EtoM (.CLK(CLK), .in(DMWE_E), .out(DMWE_M));
     
   /*** Memory -> WB ***/
    Register #(.WL(WL1)) RFWEReg_MtoW (.CLK(CLK), .in(RFWE_M), .out(RFWE_W));
    Register #(.WL(WL1)) MtoRFSelReg_MtoW (.CLK(CLK), .in(MtoRFSel_M), .out(MtoRFSel_W));
     
endmodule
