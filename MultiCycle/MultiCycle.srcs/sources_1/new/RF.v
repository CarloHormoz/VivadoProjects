`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
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


module RF(input CLK, RFWE, [4:0] RFRA1, RFRA2, RFWA, [31:0] RFWD, output [31:0] RFRD1, RFRD2);

    reg [31:0] regFile [0:31];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1) regFile[i] = 32'b0;
    end
    
    assign RFRD1 = regFile[RFRA1];
    assign RFRD2 = regFile[RFRA2];
    
    always @ (posedge CLK) begin
        if (RFWE) regFile[RFWA] = RFWD;
    end

endmodule
