`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 12:53:18 PM
// Design Name: 
// Module Name: ALU
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

// Module currently only takes addition for LW.
module ALU(input signed [31:0] in1, signed [31:0] in2,
           [2:0] ALUsel, [4:0] shamt,
            output Zero, reg signed [31:0] ALUOut);
    always @ (*) begin
        case (ALUsel)
            3'b000: ALUOut = in1 & in2;
            3'b001: ALUOut = in1 | in2;
            3'b010: ALUOut = in1 + in2;
            3'b011: ALUOut = in2 << shamt;
            3'b100: ALUOut = in2 << in1[4:0];
            3'b101: ALUOut = in2 >>> in1[4:0];
            3'b110: ALUOut = in1 - in2;
            default: ALUOut = 32'bx;
        endcase
    end
    assign Zero = ALUOut == 0 ? 1 : 0;
endmodule
