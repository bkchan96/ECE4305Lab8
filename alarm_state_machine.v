`timescale 1ns / 1ps

module alarm_state_machine(clk, reset, left_key, right_key, up_key, upsec, upmin, uphour, selection);
    input clk, reset;
    input left_key, right_key, up_key;
    output reg upsec, upmin, uphour;
    output reg [1:0] selection;
    
    // declare state machine variables
    reg [1:0] state, next;
    
    // declare states
    localparam selectSec    = 0;
    localparam selectMin    = 1;
    localparam selectHour   = 2;
    
    // clk driver for state machine
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 0;
        else
            state <= next;
    end
    
    wire trigger;
    assign trigger = left_key || right_key || up_key;
    
    // state machine
    always @* begin
        case (state)
            selectSec: begin
                selection <= 2'b01;
                if (left_key)
                    next <= selectMin;
            end
            selectMin: begin
                selection <= 2'b10;
                if (left_key)
                    next <= selectHour;
                if (right_key)
                    next <= selectSec;
            end
            selectHour: begin
                selection <= 2'b11;
                if (right_key)
                    next <= selectMin;
            end
            default: next <= 0;
        endcase
    end
    
endmodule
