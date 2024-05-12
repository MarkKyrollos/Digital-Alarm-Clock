`timescale 1ns / 1ps

module ClockDivider #(parameter n = 50000000) (input clk, rst, output reg clk_out);
    
reg [31:0] count;
    
    always @ (posedge clk, posedge rst) begin
        if (rst == 1'b1) // this is an asynchronous reset
            count <= 32'b0;
        else if (count == n-1)
            count <= 32'b0;
        else
            count <= count + 1; // increment the clock counter
    end

    always @ (posedge clk, posedge rst) begin
        if (rst)
            clk_out <= 0;
        else if (count == n-1)
            clk_out <= ~clk_out;
    end
endmodule