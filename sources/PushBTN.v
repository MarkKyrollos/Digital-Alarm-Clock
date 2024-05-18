`timescale 1ns / 1ps

/*******************************************************************
*
* Module: PushBTN.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: these are all 5 push buttons used
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/



module PushBTN(input clk,
input rst,
input in,
output out
);

    wire deb;
    wire sync;

    Debouncer d(clk, rst, in, deb);
    Synchronizer s(clk, rst, deb, sync);
    rise_edge_det rise(clk, rst, sync, out);  
endmodule
