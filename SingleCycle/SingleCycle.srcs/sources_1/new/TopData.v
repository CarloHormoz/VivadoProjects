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


module TopData(input CLK, RST, RFWE, DMWE, Jump, Branch,
               ALUInSel, RFDSel, MtoRFSel, [2:0] ALUsel,
               output [5:0] opCode, Funct);
      // Mux wire lengths.
    parameter WL5 = 5;
    parameter WL32 = 32;
               
    wire [31:0] PCtoIM;
    wire [31:0] Inst;          // Connects to IM and stores instruction to be decoded.  
    wire [31:0] DMOut;         // Connects DMRD to RFWD
    wire [31:0] DMdin;         // Connects DMWD to RFRD2
    
    wire signed [31:0] ALUin1; // Connects RFRD1 to 1st ALU input.
    wire signed [31:0] ALUin2; // Sign extended immediate to 2nd Alu input.
    wire [31:0] ALUOut;        // Output of ALU to DMA.
    wire Zero;                 // Zero Flag.
    
   
    wire [31:0] ALUDM;         // Output of Mux that selects ALUOut/DMOut.
    wire [4:0] rtd;           // Output of Mux that selects rt/rd for R-type
    wire PCSel;                      // Selector for Mux before program counter.
    assign PCSel = Branch & Zero;    // Chooses between PC + 1 or PC + 1 + offset.
    // Declare variables to store fields of the instruction.
    wire [4:0] rs, rt, rd, shamt;
    wire [25:0] Jaddr;        // 24 bit jump address for unconditional branch.
    wire signed [31:0] SImm;                    
    
    
    PC U0 (.RST(RST), .CLK(CLK), .Jaddr(Jaddr),               // Prog Counter
           .PCSel(PCSel), .Jump(Jump), .SImm(SImm), .PCout(PCtoIM));
    
    IM U1 (.IMA(PCtoIM), .IMRD(Inst));   // Instruction Memory
    
    RegFile U2 (.RFRA1(rs), .RFRA2(rt),             // Register File
                .RFWA(rtd), .RFWD(ALUDM), .RFWE(RFWE),
                .CLK(CLK), .RFRD1(ALUin1), .RFRD2(DMdin));
      
    Mux2to1 #(.WL(WL5)) M1(.sel(RFDSel), .in1(rt),     // rtd Mux connecting to RFWA.
                .in2(rd), .out(rtd));
    
    Mux2to1 # (.WL(WL32)) M2 (.sel(ALUInSel), .in1(DMdin), // ALUIn2 Mux between RF/ALU
                .in2(SImm), .out(ALUin2));
    
    ALU U3 (.in1(ALUin1), .in2(ALUin2), .ALUsel(ALUsel),    // AL Unit
            .shamt(shamt), .Zero(Zero), .ALUOut(ALUOut));
            
    DataMem U4 (.DMA(ALUOut), .DMWD(DMdin),  // Data Memory
                .DMWE(DMWE), .CLK(CLK), .DMRD(DMOut));
    
    Mux2to1 # (.WL(WL32)) M3 (.sel(MtoRFSel), .in1(ALUOut),      // ALUtoDM Mux
                .in2(DMOut), .out(ALUDM));
                
    InstDecoder U5 (.Inst(Inst), .opCode(opCode),  // Decodes 32 bit instruction
                    .rs(rs), .rt(rt), .rd(rd),
                    .Funct(Funct), .shamt(shamt),
                    .Jaddr(Jaddr), .SImm(SImm));
                
endmodule
