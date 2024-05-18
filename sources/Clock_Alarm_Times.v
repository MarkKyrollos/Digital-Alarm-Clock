`timescale 1ns / 1ps

/*******************************************************************
*
* Module: Clock_Alarm_Times.v
* Project: Digital Alarm Clock
* Author: Mark Kyrollos - markgeorge99@aucegypt.edu
* Description: this is used to adjust the time and alarm settings of a digital clock
*
* Change history: 1/5/2024 – 18/5/2024
*
*
**********************************************************************/

module Clock_Alarm_Times( input clk, rst, en, input[4:0] buttons, 
                     input[4:0] in_time_hours, in_alarm_hours, input[5:0] in_time_minutes, in_alarm_minutes,
                     output[3:0] adj_min_units, adj_hr_units, output[2:0] adj_min_tens, adj_hr_tens, output[1:0] adj_status,
                     output[4:0] out_time_hours, out_alarm_hours, output[5:0] out_time_minutes, out_alarm_minutes, output reg[3:0] led);   
       
    wire[5:0] clk_time[1:0], alarm_time[1:0]; // 0: min_units, 1: min_tens, 2: hour_units, 3: hour_tens
    reg[5:0] adj_time[1:0];
    reg rst_time, rst_alarm;

    // Init states
    // States for moving right and left
    reg[2:0] state, nextstate;
    parameter[2:0] Initial = 3'b000, TimeHours = 3'b001, TimeMin = 3'b010, AlarmHours = 3'b011, AlarmMin = 3'b100;
    initial nextstate = Initial; 
    
    integer i;
    always @(state, buttons) begin
    case(state)
            Initial: nextstate = TimeHours;
            TimeHours:
                begin
                led = 4'b1000; 
                if(buttons[2]) nextstate = TimeMin; // move right
                else if(buttons[1]) nextstate = AlarmMin; // move left
                else nextstate = TimeHours; // don't move
                end   
            TimeMin:
                begin
                led = 4'b0100; 
                if(buttons[2]) nextstate = AlarmHours; // move right
                else if(buttons[1]) nextstate = TimeHours; // move left
                else nextstate = TimeMin; // don't move
                end
            AlarmHours:
                begin
                led = 4'b0010;
                if(buttons[2]) nextstate = AlarmMin; // move right
                else if(buttons[1]) nextstate = TimeMin; // move left
                else nextstate = AlarmHours; // don't move
                end
            AlarmMin:
                begin
                led = 4'b0001;
                if(buttons[2]) nextstate = TimeHours; // move right
                else if(buttons[1]) nextstate = AlarmHours; // move left
                else nextstate = AlarmMin; // don't move
                end
            default: nextstate = TimeHours;
        endcase
        
       if (state == TimeHours || state == TimeMin) 
            for (i = 0; i < 2; i = i + 1)
                adj_time[i] = clk_time[i];
        else if (state == AlarmHours || state == AlarmMin) 
            for (i = 0; i < 2; i = i + 1)
                adj_time[i] = alarm_time[i];
    end

    always @(posedge clk, posedge rst) begin
        if(rst) state <= Initial;
        else if(buttons[0]) state <= Initial;
        else state <= nextstate;    
    end
    
    // reset when reaching max of 23 hrs 59 minutes
    always @(posedge clk) begin
        if (clk_time[2] == 4 && clk_time[3] == 2) rst_time = 1;
        else rst_time = 0;
        
        if (alarm_time[2] == 4 && alarm_time[3] == 2) rst_alarm = 1;
        else rst_alarm = 0;
    end
    
    // Counters for time of clock
    
    // minutes 
    counter_modN_updown #(6, 60) time_min_mod_10(clk, rst, (state == TimeMin && buttons[3]==1), (state == TimeMin && buttons[4]==1), 
                                              (state == Initial), in_time_minutes , clk_time[0]);
    
    
    // hours digit
    counter_modN_updown #(5, 24) time_hour_mod_10(clk, rst, (state == TimeHours && buttons[3]==1), (state == TimeHours  && buttons[4]==1),
                                               (state == Initial), in_time_hours, clk_time[1]);



    // Counters for time of alarm
    // minutes digit

    counter_modN_updown #(6, 60) alarm_min_mod_10(clk, rst, (state == AlarmMin && buttons[3]==1), (state == AlarmMin && buttons[4]==1), 
                                               (state == Initial), in_alarm_minutes, alarm_time[0]);
    // hours digt
  
    counter_modN_updown #(5, 24) alarm_hour_mod_10(clk, rst, (state == AlarmHours  && buttons[3]==1), (state == AlarmHours  && buttons[4]==1),
                                                (state == Initial), in_alarm_hours, alarm_time[1]);

  
    // Output saved values
    assign adj_min_units = adj_time[0] % 10;
  
    assign adj_min_tens = adj_time[0] / 10;
  
    assign adj_hr_units = adj_time[1] % 10;
  
    assign adj_hr_tens = adj_time[1] / 10;
    
  
    assign out_time_hours = clk_time[1];
  
    assign out_time_minutes = clk_time[0];
  
    assign out_alarm_hours = alarm_time[1];
  
    assign out_alarm_minutes = alarm_time[0];
  
    assign adj_status = {(in_alarm_hours != out_alarm_hours || in_alarm_minutes != out_alarm_minutes), 
                       (in_time_hours != out_time_hours || in_time_minutes != out_time_minutes)};
endmodule