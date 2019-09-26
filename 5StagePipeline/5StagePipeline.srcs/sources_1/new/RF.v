`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:46:16 PM
// Design Name: 
// Module Name: RF
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


module RF(input CLK, RFWE, [4:0] RFRA1, RFRA2, RFWA, [31:0] RFWD, output reg [31:0] RFRD1, RFRD2);

    reg [31:0] regFile [0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) regFile[i] = 32'b0;
    end
    
    
    always @ (negedge CLK) begin
        if (RFWE) regFile[RFWA] <= RFWD;
    end
    always @ (*) begin
        RFRD1 = RFRA1 == 0 ? 0 : regFile[RFRA1];
        RFRD2 = RFRA2 == 0 ? 0 : regFile[RFRA2];
    end
endmodule
