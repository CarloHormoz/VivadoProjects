`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 09:35:33 PM
// Design Name: 
// Module Name: DataMem
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
               output reg [31:0] DMRD);
               
        // Initialize data memory.
    reg [31:0] Mem [0:1023];
    initial $readmemb("Data.mem", Mem);
 
    always @ (posedge CLK) begin
          // If Write Enabled, read DMWD into Memory Address DMA on clock.
        if (DMWE) begin
            Mem[DMA] <= DMWD;
        end
    end         
          // If write enabled = 0, read DMRD from Memory Adress DMA immediately. 
    always @ (*) begin
          // Latch?
        if (DMWE == 0) begin
            DMRD = Mem[DMA];
        end
    end
endmodule
