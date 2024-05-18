`timescale 1ns / 1ps
/*******************************************************************
*
* Module: rise_edge_det.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: rising clock edge using FSM
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/


module rise_edge_det(input clk, rst, w, output z);

  reg[1:0] state, nextState;
  parameter[1:0] A = 2'b00, B = 2'b01, C = 2'b10;
  
// I used a Mealy FSM, output depends on present state AND Input w
  always @(w or state)

    case(state)
      A: if (w==0) nextState = A;
          else nextState = B;
      B: if (w==0) nextState = A;
          else nextState = C;
      C: if (w==0) nextState = A;
          else nextState = C;

      default: nextState = A;
  endcase
  
  always @ (posedge clk or posedge rst) begin
    if(rst) state <= A;
    else state <= nextState;
  end
  
  assign z = (state == B);
endmodule
