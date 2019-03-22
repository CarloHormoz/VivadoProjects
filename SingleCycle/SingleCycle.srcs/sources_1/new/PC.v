`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 10:50:30 AM
// Design Name: 
// Module Name: PC
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


module PC(input RST, CLK, PCSel, Jump, signed [31:0] SImm,
          [25:0] Jaddr, output reg [31:0] PCout);

    always @ (posedge CLK) begin
        if (RST) PCout <= 0;
        else if (PCSel)         // Conditional Branch
        begin
            PCout <= PCout + 1;
            PCout <= PCout + SImm;
        end
        else if (Jump) begin    // Unconditional Jump
            PCout <= PCout + 1;
            PCout <= {PCout[31:26], Jaddr};
        end
        else PCout <= PCout + 1;
    end    
endmodule
