`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2019 02:55:42 PM
// Design Name: 
// Module Name: Clock
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


module Clock(input [4:0] IO_PB,
                input CLK,
                input [10:0] sw,
				output reg [3:0] IO_SSEGD,
				output reg [7:0] IO_SSEG,
				output [4:0] led
				);
			
	reg [26:0] secondsIncrement = 0;     // Clock oscillates 100*10^6 times per second. Need 27 bits to store 101111101011110000011111111 = 99999999
	reg [5:0] seconds = 0;               // 6 bits to store up to the number 60.
    reg [5:0] minutes = 0;
    reg [5:0] alarmMinutes;
	reg [3:0] hours = 1;                 // Hours from 1 - 12.
	reg [3:0] alarmHours;
	reg [18:0] updateDisplay = 0;        // updateDisplay will count 500000 times, to 1111010000100011111, before switching which column to display. (Every 5 ms)
	   // The number (0-9) of each segment, where 1 is the right display and 2 is the left. (min1 = rightmost segment)
	wire [3:0] min1;     
	wire [3:0] min2; 
	wire [3:0] hour1;
	wire [3:0] hour2;
	reg decimal = 0;
	reg tempDecimal = 0;
	reg Am = 1;            // AM = 1, PM = 0;
	reg alarmSet;          // alarmSet can be set or turned off by using the rightmost push button. Led[1] will indicate if alarm is set.
	reg alarm = 0;         // When alarm is set to 1, led[4:2] will light incrementally. Snoozed with leftmost push button.
	reg [2:0] alarmLights = 0;
	reg [25:0] decimalCounter = 0;     // Counts to 10111110101111000010000000 (0.5 secs)
	assign min1 = minutes % 10;
	assign min2 = minutes >= 10 ? (minutes / 10) : 0;
	assign hour1 = hours % 10;
	assign hour2 = hours >= 10 ? 1 : 0;
	assign led[0] = ~Am;
	assign led[1] = alarmSet;
	assign led[4:2] = alarmLights;
	reg [7:0] temp = 0;
	
	always @ (posedge CLK) begin
	   secondsIncrement <= secondsIncrement + 1;
	   updateDisplay <= updateDisplay + 1;
	   decimalCounter <= decimalCounter + 1;
	    // Set alarm off if set and time is reached.
	   if (alarmSet && (alarmMinutes == minutes && alarmHours == hours))
	   begin
	       alarm <= 1;  // Trigger alarm, incrementing lights each second.
	   end
	     // Block to set the time using center push button and switches.
	   if (IO_PB[4]) begin
	       seconds <= 0;
	       if (sw[5:0] > 59) minutes <= 0;
	       else minutes <= sw[5:0];
	       if (sw[9:6] == 0 || sw[9:6] > 12) hours <= 1;
	       else hours <= sw[9:6];
	   end
	     // Block to set the alarm using rightmost push button and switches. Press button again to disarm. Shown by led[1] if active.
	   else if (IO_PB[1]) begin
	       alarmSet <= alarmSet ^ 1;
           if (sw[5:0] > 59) alarmMinutes <= 0;
           else alarmMinutes <= sw[5:0];
           if (sw[9:6] == 0 || sw[9:6] > 12) alarmHours <= 1;
           else alarmHours <= sw[9:6];
       end
        // Snooze alarm when active. (Left push button) 
       else if (IO_PB[3]) begin
           alarm <= 0;
           alarmLights <= 0;
       end
	       // Logic for updating seconds, minutes, hours, variables.
         // When a second has passed in terms of clock oscillations.
       if (secondsIncrement == 999999) begin    // Change to secondsIncrement == 100000000 for actual time.
           secondsIncrement <= 0;
           seconds <= seconds + 1;
           if (alarm) alarmLights <= alarmLights == 0 ? 1 : alarmLights << 1;   // If alarm is currently triggered, increment leds[4:2] every second.
       end
       if (seconds == 60) begin
           seconds <= 0;
           minutes <= minutes + 1;
       end
       if (minutes == 60) begin
           minutes <= 0;
           hours <= hours + 1;
       end
       if (hours == 13) begin
           hours <= 1;
       end
       if (hours == 12 && minutes == 0) begin
           Am <= Am ^ 1;
       end
         // Toggle decimal every 0.5 secs.
       if (decimalCounter == 50000000)
       begin
           decimalCounter <= 0;
           decimal <= decimal ^ 1;
       end
        // Every 5 ms, change column to display.
       if (updateDisplay == 19'b1111010000100011111) begin
           updateDisplay <= 0;
            if (IO_SSEGD == 4'b1110) begin
                IO_SSEGD <= 4'b1101;
                if (IO_PB[0]) begin
                   temp <= 0;
                end
                else if (IO_PB[2]) begin
                    temp <= alarmHours % 10;
                end
                else temp <= hour1;
                tempDecimal <= 1;
            end
            else if (IO_SSEGD == 4'b1101) begin
                IO_SSEGD <= 4'b1011;
                // If upper button pressed display seconds (0 in hours places)
                if (IO_PB[0]) begin
                   temp <= 0;
                end
                else if (IO_PB[2]) begin
                   temp <= alarmHours >= 10 ? 1 : 0;
                end               
                else temp <= hour2;
                tempDecimal <= 1;
            end
            else if (IO_SSEGD == 4'b1011) begin
                IO_SSEGD <= 4'b0111;
                 // If upper button pressed display seconds.
                if (IO_PB[0]) begin
                    temp <= seconds % 10;
                end
                else if (IO_PB[2]) begin
                    temp <= alarmMinutes % 10;
                end                
                else temp <= min1;
                tempDecimal <= decimal;
            end
            else begin
                IO_SSEGD <= 4'b1110;
                 // If upper button pressed display seconds.
                if (IO_PB[0]) begin
                    temp <= (seconds >= 10 ? (seconds / 10) : 0);
                end
                else if (IO_PB[2]) begin
                    temp <= alarmMinutes >= 10 ? (alarmMinutes / 10) : 0;
                end                
                else temp <= min2;
                tempDecimal <= 1;
            end
           // 7 Seg to decimal converter.
          case(temp)       
               1: IO_SSEG <= {tempDecimal, 7'b1111001};
               2: IO_SSEG <= {tempDecimal, 7'b0100100};
               3: IO_SSEG <= {tempDecimal, 7'b0110000};
               4: IO_SSEG <= {tempDecimal, 7'b0011001};
               5: IO_SSEG <= {tempDecimal, 7'b0010010};
               6: IO_SSEG <= {tempDecimal, 7'b0000010};
               7: IO_SSEG <= {tempDecimal, 7'b1011000};
               8: IO_SSEG <= {tempDecimal, 7'b0000000};
               9: IO_SSEG <= {tempDecimal, 7'b0010000}; 
               default: IO_SSEG <= {tempDecimal, 7'b1000000};
           endcase         
       end
	end
endmodule