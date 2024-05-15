`timescale 1ns / 1ps

module Debouncer(input clk, rst, in, output out);

reg q1,q2,q3;


// this block is triggered on the rising edge of clk or rst
always@(posedge clk, posedge rst) begin
 if(rst == 1'b1) begin // If reset is high
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
assign out = (rst) ? 0 : q1&q2&q3; // If reset is high, output is 0, else output is the AND of q1, q2, q3 together
endmodule
