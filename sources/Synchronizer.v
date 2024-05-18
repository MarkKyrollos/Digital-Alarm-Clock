`timescale 1ns / 1ps

/*******************************************************************
*
* Module: Synchronizer.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: synchronizer for push button
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/




module Synchronizer(input clk, reset, SIG, output reg SIG1);
    reg META;
    always@(posedge clk, posedge reset) begin
         if(reset == 1'b1) begin
            META <= 0;
         end
         else begin
             META <= SIG;
             SIG1 <= META;
         end
    end
endmodule
