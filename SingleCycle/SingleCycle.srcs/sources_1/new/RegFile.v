`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 09:52:05 AM
// Design Name: 
// Module Name: RegFile
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


module RegFile(input [4:0] RFRA1, [4:0] RFRA2, [4:0] RFWA, [31:0] RFWD, input RFWE, CLK,
    output [31:0] RFRD1, [31:0] RFRD2);
      // Create 32 registers, 32 bits each.
    reg [31:0] regFile [0:31];
      // Initialize all registers to 0.
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) regFile[i] = 32'b0;
    end
    
      // Read data into RFRD1 and 2 from the file.
    assign RFRD1 = regFile[RFRA1];
    assign RFRD2 = regFile[RFRA2];
 
      // Write to the register file if write enabled.
    always @ (posedge CLK) begin
        if (RFWE) begin
            regFile[RFWA] <= RFWD;
        end
    end
endmodule
