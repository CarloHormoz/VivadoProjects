`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 03:17:40 PM
// Design Name: 
// Module Name: tb_DataPath
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


module tb_DataPath;

    reg CLK, RST;
   
    wire [31:0] out;

    Top DUT (.CLK(CLK), .RST(RST), .out());
    assign out = DUT.U0.U2.regFile[16];    // test
    
    always #10 CLK <= ~CLK;
    initial begin
        RST <= 1; CLK <= 0;
        
        @(posedge CLK);  #5 RST <= 0;
        repeat(50) @(posedge CLK);
        $finish;
    end
endmodule
