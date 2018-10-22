`timescale 1ns / 1ps

module alarm_state_machine(clk, reset, left_key, right_key, up_key, upsec, upmin, uphour, state);
    input clk, reset;
    input left_key, right_key, up_key;
    output reg upsec, upmin, uphour;
    output reg [1:0] state;
    
    wire trigger;
    assign trigger = left_key || right_key;
    
    
    always @(posedge trigger) begin
        if (left_key) begin
            if (state == 0)
                state <= 1;
            if (state == 1)
                state <= 2;
        end
        if (right_key) begin
            if (state == 1)
                state <= 0;
            if (state == 2)
                state <= 1;
        end
    end
    
endmodule
