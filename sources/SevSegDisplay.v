`timescale 1ns / 1ps

/*******************************************************************
*
* Module: SevSegDisplay.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: seven segment display
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/



module SevSegDisplay(input current_mode,
input[3:0] numbers,
input[1:0] sw,
input clk_sec,
input enable,
output reg[0:6] segment, 
output reg[3:0] anodes, 
output reg decimal_point);  
    
    always @ (numbers, sw, enable, clk_sec) begin

    if(!enable) begin // enable off
        anodes = 4'b1111; // all 4 anodes off
        decimal_point  = 1;
    end else if (sw == 2'b00) begin
        anodes = 4'b1110;
        decimal_point  = 1;
    end else if (sw == 2'b01) begin 
        anodes = 4'b1101;
        decimal_point  = 1;
    end else if (sw == 2'b10) begin
        anodes = 4'b1011;
        decimal_point = current_mode ? 1: clk_sec; // 2nd decimal point from the left
    end else begin
        anodes = 4'b0111;
        decimal_point  = 1;
    end

        
case(numbers)
    0: segment = 7'b0000001; //0
    1: segment = 7'b1001111; //1
    2: segment = 7'b0010010; //2
    3: segment = 7'b0000110; //3
    4: segment = 7'b1001100; //4
    5: segment = 7'b0100100; //5
    6: segment = 7'b0100000; //6
    7: segment = 7'b0001111; //7
    8: segment = 7'b0000000; //8
    9: segment = 7'b0000100; //9
            
    default: segment = 7'b0000001; // display 0 as default anodes
endcase
end

endmodule
