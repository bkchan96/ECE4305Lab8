`timescale 1ns / 1ps

module alarm_state_machine(clk, reset, left_key, right_key, up_key, upsec, upmin, uphour, state);
    input clk, reset;
    input left_key, right_key, up_key;
    output reg upsec, upmin, uphour;
    output reg [1:0] state;
    
    wire trigger;
    assign trigger = left_key || right_key;
    
    
    always @(trigger) begin
        if (left_key)
            if (state == 0)
                state = 1;
            else if (state == 1)
                state = 2;
        if (right_key)
            if (state == 1)
                state = 0;
            else if (state == 2)
                state = 1;
    end
    
endmodule
