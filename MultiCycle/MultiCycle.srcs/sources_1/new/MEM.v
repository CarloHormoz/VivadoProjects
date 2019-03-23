`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 08:40:59 PM
// Design Name: 
// Module Name: MEM
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


module MEM(input CLK, MWE, [31:0] MRA, [31:0] MWD, output [31:0] MRD);

    reg [31:0] Mem [0:400];
    initial $readmemb("Memory.mem", Mem);
    always @ (posedge CLK) begin
        if (MWE) Mem[MRA] <= MWD;
    end
         assign MRD = Mem[MRA];
endmodule
