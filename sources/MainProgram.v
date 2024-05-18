`timescale 1ns / 1ps

/*******************************************************************
*
* Module: MainProgram.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is my main program where all modules are instantiated here
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/



module MainProgram(input clk, rst, enable,
input[4:0] buttons_input,
output[0:6] segment,
output[3:0] anodes,
output reg led_mode,
output seg_dec_point,
output [3:0] led,
output sound);


    
    reg[3:0] numbers;
    reg[4:0] alarm_hrs, clockLoadHours;
    reg[5:0] alarm_minutes, clockLoadMins;
    reg load_value, current_mode, nextMode, alarm, alarm_flag; // for our current_mode, 0 for clock mode and 1 for adjust mode
    wire[4:0] adjustedAlarm_hrs, adjustedTime_hrs, BTN_OUT; 
    wire[5:0] adjustedAlarm_mins, adjustedTime_mins;
    wire[1:0] adj, sw;
    wire clk_out, clk_sec, load_out;
    wire[3:0] led_adjust;
    wire[3:0] clk_time[3:0], adj_time[3:0];
    wire[3:0] seconds_time[1:0];
    reg[3:0] min_display[3:0];
    

    generate for (genvar i = 0; i < 5; i = i + 1) begin
        PushBTN btn(clk, rst, buttons_input[i], BTN_OUT[i]); // instantiating all 5 buttons: BTNC, BTNU, BTND, BTNL, BTNR
    end
    endgenerate


    // clock divider
    ClockDivider #(50000000) Clock_Divider(clk, rst, clk_sec);
    
    // Calculating minutes and hours digits using Mod10, Mod6, and Mod3 counters
    clock_counter clockCounter(clk, rst, enable, load_out, clockLoadMins, clockLoadHours, seconds_time[0], clk_time[0], clk_time[2], seconds_time[1], clk_time[1], clk_time[3]);
    
    // entering adjust mode
    Clock_Alarm_Times alarm_times(clk, rst, enable, BTN_OUT,

    clk_time[3] * 10 + clk_time[2], alarm_hrs, 

    clk_time[1] * 10 + clk_time[0], alarm_minutes, 

    adj_time[0], adj_time[2], adj_time[1], adj_time[3],

    adj, adjustedTime_hrs, adjustedAlarm_hrs, adjustedTime_mins, adjustedAlarm_mins, led_adjust);

    
    // 7-Segment Display
    SevSegDisplay Seven_Segment(current_mode, numbers, sw, clk_sec, enable, segment, anodes, seg_dec_point);

    ClockDivider #(250000) clockDiv(clk, rst, clk_out);

    counter_MOD_N  #(2, 4) counter_mod_N(clk_out, rst, enable, 0, 0, sw);

    integer k;
    
    always @(posedge clk) begin
    if (rst) begin
    load_value <= 0;
    current_mode <= 0;
    alarm_hrs <= 0;
    alarm_minutes <= 0;              
    end
    else begin

    if (current_mode == 1) begin // adjust mode
    for (k = 0; k < 4; k = k + 1)
        min_display[k] = adj_time[k]; // displaying the adjust times
    end
            
    else begin // clock/alarm mode
    for(k = 0; k < 4; k = k + 1)
        min_display[k] = clk_time[k]; // displaying the clock times
    end
            
    numbers = min_display[sw]; // connecting all 4 inputs of 7-segment to the anodes
    current_mode <= nextMode; // updating the next state mode
            
    if(BTN_OUT[0]) begin
    if(current_mode == 1) begin
    if(adj[0]) 
        {clockLoadMins, clockLoadHours} <= {adjustedTime_mins, adjustedTime_hrs};
    
    if(adj[1])            
        {alarm_minutes, alarm_hrs} <= {adjustedAlarm_mins, adjustedAlarm_hrs};
     end
     end        
     end
     end


    // mode state
    always @(BTN_OUT[0]) begin
        case(BTN_OUT[0])
            0: nextMode = current_mode;
            1: nextMode = ~current_mode;
            default: nextMode = current_mode; // we always start in clock/alarm state (mode 0) 
        endcase
    end
    
    rise_edge_det_ext #(100000000) ris(clk, rst, BTN_OUT[0] & current_mode & adj[0], load_out);  
    
    reg[6:0] last_alarm[1:0];
    always @(posedge clk) begin
        if (rst) alarm_flag <= 0;
        else if (BTN_OUT != 0) alarm_flag <= 0;
        else if (current_mode == 0 && clk_time[1] * 10 + clk_time[0] == alarm_minutes && clk_time[3] * 10 + clk_time[2] == alarm_hrs && {seconds_time[0], seconds_time[1]} == 0)
        // if clock time reaches the alarm time, we update the alarm flag to show that the alarm time was indeed reached, we do this by comparing every minutes and hours of both current and alarm times
        alarm_flag <= 1;    
        else if(current_mode == 1)
            alarm_flag <= 0;
            
    end
    
    always @(posedge clk_sec) begin
        if(alarm_flag == 1)
            led_mode <= ~led_mode;
        else if (current_mode == 0)
            led_mode <= 0;
        else if (current_mode == 1)
            led_mode <= 1;
    end
    
    buzzer buzzer_b(clk, (alarm_flag  ? led_mode : 0), sound);
    //assign sound = alarm;
    assign led = (current_mode == 0) ? 0 : led_adjust;
    
    
endmodule