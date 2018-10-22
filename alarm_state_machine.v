`timescale 1ns / 1ps

module alarm_state_machine(clk, reset, left_key, right_key, up_key, upsec, upmin, uphour, state);
    input clk, reset;
    input left_key, right_key, up_key;
    output reg upsec, upmin, uphour;
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
    
//    always @(posedge up_key) begin
//        upsec = 0; upmin = 0; uphour = 0;
//        case (state)
//            0: upsec = 1;
//            1: upmin = 1;
//            2: uphour = 1;
//        endcase
//    end
    
endmodule
