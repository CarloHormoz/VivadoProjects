`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
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


module TopData(input CLK, RST, RFWE_W, DMWE_M, Jump_D, Branch_D, StallF, StallD,
               ALUInSel_E, RFDSel_E, MtoRFSel_W, Flush_E, ForwardAD, ForwardBD,
               [2:0] ALUSel_E, [1:0] ForwardAE, [1:0] ForwardBE,
               output [5:0] opCode_D, funct_D, [4:0] rtd_E, rtd_M, rtd_W, rs_E, rt_E, rs_D, rt_D);
               
   // Mux and Reg wire lengths.
    parameter WL1 = 1;
    parameter WL5 = 5;
    parameter WL32 = 32;
    
/******************* Fields and Connecting Wires **************************/    
    wire [31:0] Inst;          // Connects to InstDecoder to be decoded into separate fields.
    wire [25:0] Jaddr;
    
   /***** Fetch Stage *****/
   
   // PC fields
    wire [31:0] PCin;
    wire [31:0] PC_F;          // Wire from PC to IM, and to adder -> PCp1_F.    
    wire [31:0] PCp1_F;
    wire [31:0] PCMux2Mux;     // Wire between two PC muxes.
    wire [31:0] PCJump;         // {PC[31:26], Jaddr}, goes into PCJumpMux and passes if jump = 1
    assign PCJump = {PCp1_F[31:26], Jaddr};
    assign PCp1_F = PC_F + 1;  // Will always be equal to pc+1, connecting to the PCin mux.  
    
   // Connecting wires
    wire [31:0] IMOut;         // Output of IM to register.
    
   /***** Decode Stage *****/
    wire [31:0] PCBranch_D;
    wire [31:0] PCp1_D;   
    wire PCSel_D;
    wire Equal_D;
    wire [31:0] RFRD1MuxOut, RFRD2MuxOut;
        
   // Inst fields
    wire [4:0]  rd_D, shamt_D;
    wire signed [31:0] SImm_D;  
    wire [31:0] RFOut1, RFOut2;  // Wires from RFRD1, RFRD2, to register.
    
    // Assign conecting wires
    assign PCBranch_D = PCp1_D + SImm_D;  // PCBranch constantly set to PCp1 + SImm.
    assign PCSel_D = (Branch_D && Equal_D) ? 1 : 0;    
    assign Equal_D = (RFRD1MuxOut == RFRD2MuxOut && RFRD1MuxOut != 0) ? 1 : 0;
    
   /***** Execute *****/   
   
   // Inst Fields
    wire [4:0] rd_E, shamt_E;
    wire signed [31:0] SImm_E;
    
   // PC fields   
    wire [31:0] PCp1_E;
        
    
   // Connecting wires
    wire signed [31:0] ALUIn1_E, ALUIn2_E;
    wire [31:0] DMdin_E;
    wire signed [31:0] ALUOut_E;        // ALU to register.
    
    wire [31:0] RFOut1ToMux;            // Connects to 1st data forwarding mux.
    wire [31:0] RFOut2ToMux;
    
   /***** Memory *****/  
    
    wire [31:0] ALUOut_M, DMdin_M;  
    wire [31:0] DMOut_M;        // DM output to reg.
    
   /***** WriteBack *****/
    wire [31:0] ALUOut_W, DMOut_W;    
    wire [31:0] Result_W;       // Output of writeback mux to RFWD.
    
/******************** Modules (Memories, PC, ALU, etc) ******************/
   /*** Fetch ***/
    PC U0 (.CLK(CLK), .RST(RST), .StallF(StallF), .PCin(PCin), .PC_F(PC_F));
    IM U1 (.IMA(PC_F), .IMRD(IMOut));
    
   /*** Decode ***/
    InstDecoder U2 (.Inst(Inst), .opCode(opCode_D), .rs(rs_D), .rt(rt_D), .rd(rd_D),
                    .funct(funct_D), .Jaddr(Jaddr), .shamt(shamt_D), .SImm(SImm_D));
                    
   // RF is more of a decode and writeback stage module                
    RF U3 (.CLK(CLK), .RFWE(RFWE_W), .RFRA1(rs_D), .RFRA2(rt_D), .RFWA(rtd_W), .RFWD(Result_W),
           .RFRD1(RFOut1), .RFRD2(RFOut2));
    
   /*** Execute ***/
    ALU U4 (.ALUSel(ALUSel_E), .shamt(shamt_E), .ALUIn1(ALUIn1_E), .ALUIn2(ALUIn2_E), 
            .ALUOutR(ALUOut_E));
    
   /*** Memory ***/
    DataMem U5 (.DMA(ALUOut_M), .DMWD(DMdin_M), .DMWE(DMWE_M), .CLK(CLK),
                .DMRD(DMOut_M));
   

/******************** Muxes and Registers ********************/
   
   /*** Fetch ***/
    Mux2to1 #(.WL(WL32)) PCSelMux (.sel(PCSel_D), .in1(PCp1_F), .in2(PCBranch_D), .out(PCMux2Mux));
    Mux2to1 #(.WL(WL32)) PCJumpMux(.sel(Jump_D), .in1(PCMux2Mux), .in2(PCJump), .out(PCin));
    
    StallRegister InstReg_FtoD (.CLK(CLK), .CLR(PCSel_D), .StallD(StallD), .in(IMOut), .out(Inst));
    StallRegister  PCp1Reg_FtoD (.CLK(CLK), .CLR(PCSel_D), .StallD(StallD), .in(PCp1_F), .out(PCp1_D));
    
   /*** Decode ***/
    Mux2to1 #(.WL(WL32)) RFRD1Mux (.sel(ForwardAD), .in1(RFOut1), .in2(ALUOut_M), .out(RFRD1MuxOut));
    Mux2to1 #(.WL(WL32)) RFRD2Mux (.sel(ForwardBD), .in1(RFOut2), .in2(ALUOut_M), .out(RFRD2MuxOut));
   
    FlushRegister #(.WL(WL32)) RFReg1_DtoE (.CLK(CLK), .CLR(Flush_E), .in(RFRD1MuxOut), .out(RFOut1ToMux));
    FlushRegister #(.WL(WL32)) RFReg2_DtoE (.CLK(CLK), .CLR(Flush_E), .in(RFRD2MuxOut), .out(RFOut2ToMux));
    FlushRegister #(.WL(WL5)) rtReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(rt_D), .out(rt_E));
    FlushRegister #(.WL(WL5)) rdReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(rd_D), .out(rd_E));
    FlushRegister #(.WL(WL5)) rsReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in (rs_D), .out(rs_E));
    FlushRegister #(.WL(WL32)) SImmReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(SImm_D), .out(SImm_E));
    FlushRegister #(.WL(WL5)) shamtReg_DtoE (.CLK(CLK), .CLR(Flush_E), .in(shamt_D), .out(shamt_E));
    
   /*** Execute ***/
    Mux2to1 #(.WL(WL5)) RFDMux (.sel(RFDSel_E), .in1(rt_E), .in2(rd_E), .out(rtd_E));
    Mux2to1 #(.WL(WL32)) ALUInSelMux (.sel(ALUInSel_E), .in1(DMdin_E), .in2(SImm_E), .out(ALUIn2_E));
    Mux4to1 #(.WL(WL32)) ForwardAEMux (.sel(ForwardAE), .in1(), .in2(ALUOut_M),
                                         .in3(Result_W), .in4(RFOut1ToMux), .out(ALUIn1_E));
    Mux4to1 #(.WL(WL32)) ForwardBEMux (.sel(ForwardBE), .in1(), .in2(ALUOut_M), .in3(Result_W),
                                       .in4(RFOut2ToMux), .out(DMdin_E));
    
    Register #(.WL(WL32)) ALUOutReg_EtoM (.CLK(CLK), .in(ALUOut_E), .out(ALUOut_M));
    Register #(.WL(WL32)) DMdinReg_EtoM (.CLK(CLK), .in(DMdin_E), .out(DMdin_M));
    Register #(.WL(WL5)) rtdReg_EtoM (.CLK(CLK), .in(rtd_E), .out(rtd_M));
  
   /*** Memory ***/
    Register #(.WL(WL32)) ALUOutReg_MtoW (.CLK(CLK), .in(ALUOut_M), .out(ALUOut_W));
    Register #(.WL(WL32)) DMOutReg_MtoW (.CLK(CLK), .in(DMOut_M), .out(DMOut_W));
    Register #(.WL(WL5)) rtdReg_MtoW (.CLK(CLK), .in(rtd_M), .out(rtd_W));
    
   /*** WriteBack ***/
    Mux2to1 #(.WL(WL32)) MtoRFMux (.sel(MtoRFSel_W), .in1(ALUOut_W), .in2(DMOut_W), .out(Result_W));
    
endmodule   
