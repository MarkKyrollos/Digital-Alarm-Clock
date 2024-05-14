`timescale 1ns / 1ps

module counter_MOD_N #(parameter x = 3,parameter  n = 5) (input clk, rst, enable,
input load,
input[x-1:0] data,
output reg [x-1:0] count);
  
always @(posedge clk, posedge rst) begin
    if (rst) // if reset button is enabled, reset the counter
        count <= 0;
    else if (load) 
        count <= data;
    else if (enable & count == n-1)   //counter set to zero again when reaching (n-1)
        count <= 0;
    else if (enable) 
        count <= count + 1; // increment the clock counter
  end
endmodule