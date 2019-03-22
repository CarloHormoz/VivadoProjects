`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2019 07:53:24 AM
// Design Name: 
// Module Name: tb_Lab
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


module tb_Lab;

    reg CLK, IO_PB;
    reg [7:0] IO_SW;
    wire JA2;
    wire [4:0] state;
    Lab4 UUT (.CLK(CLK), .IO_PB(IO_PB), .IO_SW(IO_SW), .JA2(JA2));
    assign state = UUT.state;
    always #5 CLK = ~CLK;
    
    initial begin
        CLK <= 0; IO_SW <= 8'b00101011; IO_PB <= 1;
        @ (posedge CLK);
        @ (posedge CLK);
    end
endmodule
