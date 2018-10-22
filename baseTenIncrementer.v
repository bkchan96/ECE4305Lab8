`timescale 1ns / 1ps

module baseTenIncrementer(inc, reset, incNext, value);
    input inc, reset;
    output reg incNext;
    output reg [3:0] value = 0;
    
    always @(posedge inc, posedge reset) begin
        incNext = 0;
        if (reset)
            value = 0;
        else begin
            if (value == 9) begin
                value = 0;
                incNext = 1;
            end
            else begin
                value = value + 1;
            end
        end
    end
endmodule

module baseSixIncrementer(inc, reset, incNext, value);
    input inc, reset;
    output reg incNext;
    output reg [3:0] value = 0;
    
    always @(posedge inc, posedge reset) begin
        incNext = 0;
        if (reset)
            value = 0;
        else begin
            if (value == 5) begin
                value = 0;
                incNext = 1;
            end
            else begin
                value = value + 1;
            end
        end
    end
endmodule

module baseThreeIncrementer(inc, reset, incNext, value);
    input inc, reset;
    output reg incNext;
    output reg [3:0] value = 0;
    
    always @(posedge inc, posedge reset) begin
        incNext = 0;
        if (reset)
            value = 0;
        else begin
            if (value == 2) begin
                value = 0;
                incNext = 1;
            end
            else begin
                value = value + 1;
            end
        end
    end
endmodule

module baseFourIncrementer(inc, reset, incNext, hourMSBvalue, value);
    input inc, reset;
    input [3:0] hourMSBvalue;
    output reg incNext;
    output reg [3:0] value = 0;
    
    always @(posedge inc, posedge reset) begin
        incNext = 0;
        if (reset)
            value = 0;
        else begin
            if ((value == 3 && hourMSBvalue == 2) || value == 9) begin
                value = 0;
                incNext = 1;
            end
            else begin
                value = value + 1;
            end
        end
    end
endmodule