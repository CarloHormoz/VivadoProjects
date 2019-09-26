`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2019 10:45:13 PM
// Design Name: 
// Module Name: tb_pipeline
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


module tb_pipeline;

    reg CLK, RST;
   
    wire [31:0] out;

    Top DUT (.CLK(CLK), .RST(RST), .out(out));
    
    always #10 CLK <= ~CLK;
    
    initial begin
        RST <= 0; CLK <= 0;
        
        repeat(78) @(posedge CLK);
        $finish;
    end
endmodule
