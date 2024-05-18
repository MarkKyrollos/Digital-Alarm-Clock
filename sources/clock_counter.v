`timescale 1ns / 1ps

/*******************************************************************
*
* Module: clock_counter.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is the main clock used for the clock mode
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/




module clock_counter(input clk, reset, enable, load_out,
input [5:0] time_mins, 
input [4:0] time_hrs, 
output [3:0] sec_units, min_units, hour_units, 
output [2:0] sec_tens, min_tens, hour_tens);
    

    reg ResetCounter;
    
    wire clk_out;
    
    ClockDivider ck(clk, reset, clk_out);
    
    //reset time to 00:00 if we reached 23:59
    always @(posedge clk_out) begin
    if (sec_units == 9 & sec_tens == 5 & min_units == 9 & min_tens == 5 & hour_units == 3 & hour_tens == 2) ResetCounter = 1;
    else ResetCounter = 0;
    end

      // here we implement mod10 counters followed by mod6 counters, then a mod3 counter at the end to accomodate for the last hours of 20-23hours
      counter_MOD_N  #(4, 10) sec_mod_10(clk_out, reset | ResetCounter, enable, 0, 0, sec_units);
    
      counter_MOD_N  #(3, 6) sec_mod_6(clk_out, reset | ResetCounter, sec_units == 9, 0, 0, sec_tens);    
        
      counter_MOD_N  #(4, 10) min_mod_10(clk_out, reset | ResetCounter, (sec_units == 9 & sec_tens == 5), load_out, time_mins % 10 ,min_units);
    
      counter_MOD_N  #(3, 6) min_mod_6(clk_out, reset | ResetCounter, (sec_units == 9 & sec_tens == 5 & min_units == 9), load_out, time_mins / 10, min_tens);
    
      counter_MOD_N  #(4, 10) hour_mod_10(clk_out, reset | ResetCounter, (sec_units == 9 & sec_tens == 5 & min_units == 9 & min_tens == 5), load_out, time_hrs % 10, hour_units);
    
      counter_MOD_N  #(2, 3) hour_mod_6(clk_out, reset | ResetCounter, (sec_units == 9 & sec_tens == 5 & min_units == 9 & min_tens == 5 & hour_units == 9), load_out, time_hrs / 10, hour_tens);
      
endmodule

