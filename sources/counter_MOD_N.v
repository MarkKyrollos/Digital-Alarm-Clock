`timescale 1ns / 1ps

/*******************************************************************
*
* Module: counter_MOD_N.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is a counter that counts up till the value N
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/




module counter_MOD_N #(parameter x = 3,parameter  n = 5) (input clk, rst, enable, load,
 input[x-1:0] data,
  output reg [x-1:0] count
  );
  
  
  always @(posedge clk, posedge rst) begin
    if (rst) // if reset button is enabled, reset the counter
        count <= 0;
    else if (load) 
        count <= data;
    else if (enable & count == n-1) //counter is reseted when count== n-1
        count <= 0;
    else if (enable) 
        count <= count + 1;   // increment the clock counter
  end
endmodule