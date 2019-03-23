`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
// Design Name: 
// Module Name: TopData
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


module TopData(input CLK, RST, PCWE, RFWE, MWE, IRWE, RFDSel, MtoRFSel,
                ALUIn1Sel, Branch, IDSel, [1:0] ALUIn2Sel, PCSel, [2:0] ALUSel,
                output [5:0] OpCode, Funct);

 // Mux wire lengths.
    parameter WL5 = 5;
    parameter WL32 = 32;
               
    wire [31:0] PCtoMem; 
    wire [31:0] MemOut;
    wire [31:0] Inst;          // Connects to InstDecoder from IR and stores instruction to be decoded. 
    wire [31:0] DROut;         // Connects DR to RFWD
    wire [31:0] MtoRFOut;
    wire [31:0] ALUOut;
    wire [31:0] PCin;
    wire [4:0] RFDOut;
    
    wire signed [31:0] ALUIn1; // Connects RFRD1 to 1st ALU input.
    wire signed [31:0] ALUIn2; // Sign extended immediate to 2nd Alu input.
    wire [31:0] ALUOutR;        // Output of ALU
    wire Zero;                 // Zero Flag.
    
    wire [31:0] RegAIn, RegAOut;
    wire [31:0] RegBIn, RegBOut;
   
    wire [31:0] ALUDM;         // Output of Mux that selects ALUOut/DMOut.
    wire [4:0] rtd;           // Output of Mux that selects rt/rd for R-type
    
    wire PCEn;               // Enables write to PC when (Branch AND Zero) OR PCWE.
    assign PCEn = ((Branch && Zero) || PCWE) ? 1 : 0;
    
    // Declare variables to store fields of the instruction.
    wire [4:0] rs, rt, rd, shamt;
    wire signed [31:0] SImm;                    
    wire [25:0] Jaddr;
    wire [31:0] Adr;
    wire [31:0] PCJump;
    assign PCJump = {PCin[31:26], Jaddr};
    
    PC U0 (.CLK(CLK), .RST(RST), .PCEn(PCEn), .PCin(PCin), .PCout(PCtoMem)); // Prog Counter
    
    Mux2to1 #(.WL(WL32)) M2 (.sel(IDSel), .in1(ALUOutR), .in2(PCtoMem), .out(Adr));
   
    MEM U1 (.CLK(CLK), .MWE(MWE), .MRA(Adr), .MWD(RegBOut), .MRD(MemOut));   // Memory
    
    IR R0 (.CLK(CLK), .IRWE(IRWE), .MRD(MemOut), .Inst(Inst));      // Instruction Register to InstDecoder
    
    Register DR (.CLK(CLK), .in(MemOut), .out(DROut));      // Data Register to RegFile(RFWD)
    
    Mux2to1#(.WL(WL5)) RFDMux (.sel(RFDSel), .in1(rd), .in2(rt), .out(RFDOut));
    
    Mux2to1#(.WL(WL32)) MtoRFMux (.sel(MtoRFSel), .in1(DROut), .in2(ALUOutR), .out(MtoRFOut));
    
    InstDecoder ID (.Inst(Inst), .OpCode(OpCode),  // Decodes 32 bit instruction
                    .rs(rs), .rt(rt), .rd(rd),
                    .Funct(Funct), .shamt(shamt),
                    .Jaddr(Jaddr), .SImm(SImm));
                    
    RF U2 (.CLK(CLK), .RFWE(RFWE), .RFRA1(rs), .RFRA2(rt), .RFWA(RFDOut),   // Register File
           .RFWD(MtoRFOut), .RFRD1(RegAIn), .RFRD2(RegBIn));
    
    Register RA (.CLK(CLK), .in(RegAIn), .out(RegAOut));
    
    Register RB (.CLK(CLK), .in(RegBIn), .out(RegBOut));
    
    Mux2to1 # (.WL(WL32)) M0 (.sel(ALUIn1Sel), .in1(RegAOut), .in2(PCtoMem), .out(ALUIn1));
    
    Mux4to1 # (.WL(WL32)) M1 (.sel(ALUIn2Sel), .in1(), .in2(SImm), .in3(32'b1), .in4(RegBOut), .out(ALUIn2));
    
    ALU U3 (.ALUSel(ALUSel), .shamt(shamt), .ALUIn1(ALUIn1), 
             .ALUIn2(ALUIn2), .Zero(Zero), .ALUOutR(ALUOut));
             
    Register ALUReg (.CLK(CLK), .in(ALUOut), .out(ALUOutR));
    
    Mux4to1 #(.WL(WL32)) ALUMux (.sel(PCSel), .in1(), .in2(PCJump), .in3(ALUOutR), .in4(ALUOut), .out(PCin));
    
endmodule
