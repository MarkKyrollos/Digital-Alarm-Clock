`timescale 1ns / 1ps

/*******************************************************************
*
* Module: Debouncer.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is the debouncer used for the interactive push buttons
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/




module Debouncer(input clk, reset, in, output out);
    reg q1,q2,q3;
    always@(posedge clk, posedge reset) begin
        if(reset == 1'b1) begin
            q1 <= 0;
            q2 <= 0;
            q3 <= 0;
        end
        else begin
            q1 <= in;
            q2 <= q1;
            q3 <= q2;
        end
    end
    assign out = (reset) ? 0:q1&q2&q3;
endmodule
