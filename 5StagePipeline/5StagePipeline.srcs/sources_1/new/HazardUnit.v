`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 05:59:55 PM
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(input RFWE_E, RFWE_M, RFWE_W, MtoRFSel_E, MtoRFSel_M, Branch_D,
                  [4:0] rtd_E, rtd_M, rtd_W, rs_E, rt_E, rs_D, rt_D,
                  output reg StallF, StallD, Flush_E, ForwardAD, ForwardBD, reg [1:0] ForwardAE, ForwardBE);
    initial StallF = 0;
    initial StallD = 0;
    reg BRStall;
    
    always @ (*) begin
        if ((rs_E != 0) && RFWE_M && (rs_E == rtd_M)) ForwardAE = 2'b10;
        else if ((rs_E != 0) && RFWE_W && (rs_E == rtd_W)) ForwardAE = 2'b01;       
        else ForwardAE = 2'b00;
        
        if ((rt_E != 0) && RFWE_M && (rt_E == rtd_M)) ForwardBE = 2'b10;
        else if ((rt_E != 0) && RFWE_W && (rt_E == rtd_W)) ForwardBE = 2'b01;
        else ForwardBE = 2'b00;
        
        
        if ((rs_D != 0) && (rs_D == rtd_M) && RFWE_M) ForwardAD = 1;
        else ForwardAD = 0;
        if ((rt_D != 0) && (rt_D == rtd_M) && RFWE_M) ForwardBD = 1;
        else ForwardBD = 0;
        
        if (((rs_D == rtd_E || rt_D == rtd_E) && Branch_D && RFWE_E) ||
        ((rs_D == rtd_M || rt_D == rtd_M) && Branch_D && MtoRFSel_M)) BRStall = 1;
        else BRStall = 0;
        
        if ((MtoRFSel_E && ((rt_E == rs_D) || (rt_E == rt_D))) || BRStall) begin
            StallF = 1;
            StallD = 1;
            Flush_E = 1;
        end
        else begin
            StallF = 0;
            StallD = 0;
            Flush_E = 0;
        end
     end   
endmodule
