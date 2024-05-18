`timescale 1ns / 1ps

/*******************************************************************
*
* Module: ClockDivider.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is the clock divider
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/



module ClockDivider #(parameter n = 50000000) (input clk,
input rst,
output reg clk_out
); // 1Hz is n = 50000000
    
    reg [31:0] counter;
    
    always @ (posedge clk, posedge rst) begin
        if (rst == 1'b1)
            counter <= 32'b0;
        else if (counter == n-1)
            counter <= 32'b0;
        else
            counter <= counter + 1; // increment the clock counter
    end


    always @ (posedge clk, posedge rst) begin
        if (rst)
            clk_out <= 0;
        else if (counter == n-1)
            clk_out <= ~clk_out;
    end
endmodule
