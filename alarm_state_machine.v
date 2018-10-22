`timescale 1ns / 1ps

module alarm_state_machine(left_key, right_key, state);
    input left_key, right_key;
    output reg [1:0] state;
    
    wire trigger;
    assign trigger = left_key || right_key;
    
    
    always @(posedge trigger) begin
        if (left_key && state != 2) begin
            state = state + 1;
        end
        if (right_key && state != 0) begin
            state = state - 1;
        end
    end
    
endmodule
