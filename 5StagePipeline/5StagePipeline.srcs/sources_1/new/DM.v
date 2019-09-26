`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: DM
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


module DataMem(input [31:0] DMA, [31:0] DMWD, input DMWE, CLK,
               output [31:0] DMRD);
               
   // Initialize data memory.
    reg [31:0] Mem [0:103];
    initial $readmemb("Data.mem", Mem);
 
    always @ (posedge CLK) begin
       // If Write Enabled, read DMWD into Memory Address DMA on clock.
        if (DMWE)Mem[DMA] <= DMWD;
    end
       
    assign DMRD = Mem[DMA];
endmodule
