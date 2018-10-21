`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2018 07:02:41 PM
// Design Name: 
// Module Name: slow1hzClock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module slow1hzClock(clk, resetSW, outsignal);
    input clk;
    input resetSW;
    output outsignal;
    
    reg [26:0] counter;  
    reg outsignal;
    
    always @ (posedge clk)
    begin
        if (resetSW) begin
            counter=0;
            outsignal=0;
        end
        else begin
            counter = counter +1;
            if (counter == 50_000_000) begin
                outsignal=~outsignal;
                counter =0;
            end
        end
    end
endmodule

