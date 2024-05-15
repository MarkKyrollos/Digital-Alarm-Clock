`timescale 1ns / 1ps

module Synchronizer(input SIG, clk, output reg SIG1);
reg META;

always @ (posedge clk) begin
META <= SIG;
SIG1 <= META;
end
endmodule
