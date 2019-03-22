`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Carlo Hormoz
// 
// Create Date: 02/13/2019 11:11:07 AM
// Design Name: 
// Module Name: Lab4
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


module Lab4(input CLK, IO_PB, [7:0] IO_SW, output reg JA2);
    
      // First create a counter to (100 M / 9600) = 10416.
      // 14 bit counter that will reset when equal to 10416.
    integer counter = 0;
    integer index = 7;
    reg [1:0] state = 0;

     // FSM iterates through until all bits are transmitted.
    always @ (posedge CLK) begin
        if (counter >= 10415) begin
            counter <= 0;
            case(state)
                 0: begin
                      // Standby state if button not pressed, else move state 1.
                    JA2 <= 1;
                    if (IO_PB) begin
                        state <= state + 1;
                        index = 7;
                    end
                 end
                   // Transmit data bit 8 times.
                 1: begin
                    JA2 <= IO_SW[index];
                    index <= index - 1;
                    if (index == 0) begin
                        state <= state + 1; 
                    end                   
                 end
                   // 9th Bit / Final (reset) state.
                 2: begin
                    JA2 <= 0;
                    state <= 0;
                 end
                 default: state <= 0;
            endcase 
        end       
        else counter <= counter + 1;      
    end
endmodule
