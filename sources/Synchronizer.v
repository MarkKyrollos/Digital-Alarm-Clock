`timescale 1ns / 1ps

module Synchronizer(input clk, reset, in, output reg out);
    reg q1;
    always@(posedge clk, posedge reset) begin
         if(reset == 1'b1) begin
            q1 <= 0;
         end
         else begin
             q1 <= in; // set q1 to input value
             out <= q1;  // set q1 to be the value for output
         end
    end
endmodule
