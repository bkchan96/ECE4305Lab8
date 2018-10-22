`timescale 1ns / 1ps

module current_time_text
    (
    input wire [9:0] pixel_x, pixel_y,
    input wire [9:0] top_left_x, top_left_y,
    output wire on
    );
    
        // load in and declare position and sizing of number
    localparam H_FOOTPRINT = 64;
    localparam V_FOOTPRINT = 16;                                 
    wire [9:0] C_X_L = top_left_x;                   
    wire [9:0] C_Y_T = top_left_y;                  
    wire [9:0] C_X_R = C_X_L + H_FOOTPRINT - 1;
    wire [9:0] C_Y_B = C_Y_T + V_FOOTPRINT - 1;
    
    // declare signals to check
    wire [3:0] rom_addr;
    wire [5:0] rom_col;
    wire rom_bit;
    wire sq_on;
    reg [0:63] rom_data;
    
    // check current position of pixel
    assign rom_addr = pixel_y[3:0] - C_Y_T[3:0];
    assign rom_col = pixel_x[5:0] - C_X_L[5:0];
    assign rom_bit = rom_data[rom_col];
    
    // enable on if within foot print
    assign sq_on =
       (C_X_L<=pixel_x) && (pixel_x<=C_X_R) &&
       (C_Y_T<=pixel_y) && (pixel_y<=C_Y_B);
    
    //enable
    assign on = sq_on & rom_bit;
    
    // determine number to output
    always @*
        case (rom_addr)
        4'h0: rom_data =    64'b0011111111111100_0011111111111100_0011000000001100_0011111111111100;
        4'h1: rom_data =    64'b0011111111111100_0011111111111100_0011100000011100_0011111111111100;
        4'h2: rom_data =    64'b0000000110000000_0000000110000000_0011110000111100_0011000000000000;
        4'h3: rom_data =    64'b0000000110000000_0000000110000000_0011011001101100_0011000000000000;
        4'h4: rom_data =    64'b0000000110000000_0000000110000000_0011001111001100_0011000000000000;
        4'h5: rom_data =    64'b0000000110000000_0000000110000000_0011000110001100_0011000000000000;
        4'h6: rom_data =    64'b0000000110000000_0000000110000000_0011000110001100_0011111111111100;
        4'h7: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011111111111100;
        4'h8: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011000000000000;
        4'h9: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011000000000000;
        4'ha: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011000000000000;
        4'hb: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011000000000000;
        4'hc: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011000000000000;
        4'hd: rom_data =    64'b0000000110000000_0000000110000000_0011000000001100_0011000000000000;
        4'he: rom_data =    64'b0000000110000000_0011111111111100_0011000000001100_0011111111111100;         
        4'hf: rom_data =    64'b0000000110000000_0011111111111100_0011000000001100_0011111111111100;   
        endcase
    
endmodule
