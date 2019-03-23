`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2019 01:11:54 AM
// Design Name: 
// Module Name: tb_multi
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


module tb_multi;

    reg CLK, RST;
   
    wire [31:0] out;

    Top DUT (.CLK(CLK), .RST(RST), .out());
    assign out = DUT.U0.U2.regFile[8];    // test
    
    always #10 CLK <= ~CLK;
    initial begin
        CLK <= 0; RST <= 1;
        
        @(posedge CLK); #1 RST <= 0;
        repeat(1500) @(posedge CLK);
        $finish;
    end
endmodule