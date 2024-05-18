`timescale 1ns / 1ps
/*******************************************************************
*
* Module: buzzer.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is the buzzer that activates when alarm time is reached
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/

module buzzer(input clk,
input enable, 
output sound);
    
    parameter clock_divider_frequency = 100000000/440/2;
    
    reg [23:0] buzzing;
    
    always @(posedge clk) begin
    buzzing <= buzzing + 1;
    end
    
    reg [14:0] basic_counter;
    
    
    always @(posedge clk)
    begin
  if (basic_counter == 0) basic_counter <= (buzzing[23] ? clock_divider_frequency - 1 : clock_divider_frequency / 2-1);
    
    else basic_counter <= basic_counter - 1;
end
    
    
    reg sound;
    always @(posedge clk) begin
        if (!enable) sound <= 0;
        else if (basic_counter == 0) sound <= ~sound;
    end
    
endmodule