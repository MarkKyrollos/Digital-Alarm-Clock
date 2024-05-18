`timescale 1ns / 1ps

/*******************************************************************
*
* Module: rise_edge_det_ext.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: rising clock edge detector
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/




module rise_edge_det_ext #(parameter n = 2) (input clk, rst, in, output reg out);
    reg[1:0] shiftReg;
    reg[31:0] count;

    always @(posedge clk) begin
        if (rst) begin 
        shiftReg <= 0;
        count <= 0;
        out <= 0;
        end
        
	else begin 
	shiftReg <= (shiftReg << 1) + in;
        if (count == n - 1) begin
           count <= 0;
           out <= 0;
          end
            else count <= count + 1;
        
            if (shiftReg == 1) begin
            count <= 0;
            out <= 1;
            end
        end
    end    
endmodule
