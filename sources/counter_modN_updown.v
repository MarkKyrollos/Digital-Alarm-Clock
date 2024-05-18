`timescale 1ns / 1ps

/*******************************************************************
*
* Module: counter_modN_updown.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: counter that counts up (till n-1) and down (till n=0)
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/



module counter_modN_updown #(parameter x = 3,parameter  n = 5) (input clk, reset, up, down, load,
 input[x-1:0] data,
 output reg [x-1:0] count
);


  always @(posedge clk, posedge reset) begin
    if (reset)  // reset the counter
         count <= 0;
    else if (load) // loading data
    	  count <= data;
    else if (up & count == n-1) // reset counter to 0 if n-1 is reached
        count <= 0;
    else if (down & count == 0) //reset counter to n-1 if 0 is reached
        count <= n-1;
    else if (up) 
       count <= count + 1; // incrementing the counter
    else if (down)
        count <= count - 1; // decrementing the counter
  end
endmodule
