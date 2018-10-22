`timescale 1ns / 1ps

module digit_display
    (
        input wire [3:0] value,
        input wire [9:0] pixel_x, pixel_y,
        input wire [9:0] top_left_x, top_left_y,
        output wire on
    );
    
    // load in and declare position and sizing of number
    localparam FOOTPRINT = 16;                                 
    wire [9:0] C_X_L = top_left_x;                   
    wire [9:0] C_Y_T = top_left_y;                  
    wire [9:0] C_X_R = C_X_L + FOOTPRINT - 1;
    wire [9:0] C_Y_B = C_Y_T + FOOTPRINT - 1;
    
    // declare signals to check
    wire [3:0] rom_addr, rom_col;
    wire rom_bit;
    wire sq_on;
    reg [0:15] rom_data;
    
    // check current position of pixel
    assign rom_addr = pixel_y[3:0] - C_Y_T[3:0];
    assign rom_col = pixel_x[3:0] - C_X_L[3:0];
    assign rom_bit = rom_data[rom_col];
    
    // enable on if within foot print
    assign sq_on =
       (C_X_L<=pixel_x) && (pixel_x<=C_X_R) &&
       (C_Y_T<=pixel_y) && (pixel_y<=C_Y_B);
    
    //enable
    assign on = sq_on & rom_bit;
    
    // determine number to output
    always @*
    begin
        if (value == 0)
            case (rom_addr)
            4'h0: rom_data =    16'b0011111111111100;
            4'h1: rom_data =    16'b0011111111111100;
            4'h2: rom_data =    16'b0011000000001100;
            4'h3: rom_data =    16'b0011000000001100;
            4'h4: rom_data =    16'b0011000000001100;
            4'h5: rom_data =    16'b0011000000001100;
            4'h6: rom_data =    16'b0011000000001100;
            4'h7: rom_data =    16'b0011000000001100;
            4'h8: rom_data =    16'b0011000000001100;
            4'h9: rom_data =    16'b0011000000001100;
            4'ha: rom_data =    16'b0011000000001100;
            4'hb: rom_data =    16'b0011000000001100;
            4'hc: rom_data =    16'b0011000000001100;
            4'hd: rom_data =    16'b0011000000001100;
            4'he: rom_data =    16'b0011111111111100;         
            4'hf: rom_data =    16'b0011111111111100;   
            endcase
        else if (value == 1)
            case (rom_addr)
            4'h0: rom_data =    16'b0000000110000000;
            4'h1: rom_data =    16'b0000001110000000;
            4'h2: rom_data =    16'b0000011110000000;
            4'h3: rom_data =    16'b0000000110000000;
            4'h4: rom_data =    16'b0000000110000000;
            4'h5: rom_data =    16'b0000000110000000;
            4'h6: rom_data =    16'b0000000110000000;
            4'h7: rom_data =    16'b0000000110000000;
            4'h8: rom_data =    16'b0000000110000000;
            4'h9: rom_data =    16'b0000000110000000;
            4'ha: rom_data =    16'b0000000110000000;
            4'hb: rom_data =    16'b0000000110000000;
            4'hc: rom_data =    16'b0000000110000000;
            4'hd: rom_data =    16'b0000000110000000;
            4'he: rom_data =    16'b0001111111111000;         
            4'hf: rom_data =    16'b0011111111111100;   
        endcase
        else if (value == 2)
            case (rom_addr)
            4'h0: rom_data =    16'b0000011111000000;
            4'h1: rom_data =    16'b0001111111110000;
            4'h2: rom_data =    16'b0011000000011000;
            4'h3: rom_data =    16'b0011000000011000;
            4'h4: rom_data =    16'b0000000000011000;
            4'h5: rom_data =    16'b0000000000110000;
            4'h6: rom_data =    16'b0000000001100000;
            4'h7: rom_data =    16'b0000000011000000;
            4'h8: rom_data =    16'b0000000110000000;
            4'h9: rom_data =    16'b0000001100000000;
            4'ha: rom_data =    16'b0000011000000000;
            4'hb: rom_data =    16'b0000110000000000;
            4'hc: rom_data =    16'b0001100000000000;
            4'hd: rom_data =    16'b0011000000000000;
            4'he: rom_data =    16'b0011111111111100;         
            4'hf: rom_data =    16'b0011111111111100;   
        endcase
        else if (value == 3)
            case (rom_addr)
            4'h0: rom_data =    16'b0000111111100000;
            4'h1: rom_data =    16'b0001111111110000;
            4'h2: rom_data =    16'b0011000000011000;
            4'h3: rom_data =    16'b0000000000001100;
            4'h4: rom_data =    16'b0000000000001100;
            4'h5: rom_data =    16'b0000000000001100;
            4'h6: rom_data =    16'b0000000000011000;
            4'h7: rom_data =    16'b0001111111110000;
            4'h8: rom_data =    16'b0001111111110000;
            4'h9: rom_data =    16'b0000000000011000;
            4'ha: rom_data =    16'b0000000000001100;
            4'hb: rom_data =    16'b0000000000001100;
            4'hc: rom_data =    16'b0000000000001100;
            4'hd: rom_data =    16'b0011000000011000;
            4'he: rom_data =    16'b0001111111110000;         
            4'hf: rom_data =    16'b0000111111100000;   
        endcase
        else if (value == 4)
            case (rom_addr)
            4'h0: rom_data =    16'b0000000000110000;
            4'h1: rom_data =    16'b0000000001110000;
            4'h2: rom_data =    16'b0000000011110000;
            4'h3: rom_data =    16'b0000000110110000;
            4'h4: rom_data =    16'b0000001100110000;
            4'h5: rom_data =    16'b0000011000110000;
            4'h6: rom_data =    16'b0000110000110000;
            4'h7: rom_data =    16'b0001100000110000;
            4'h8: rom_data =    16'b0011000000110000;
            4'h9: rom_data =    16'b0011111111111100;
            4'ha: rom_data =    16'b0011111111111100;
            4'hb: rom_data =    16'b0000000000110000;
            4'hc: rom_data =    16'b0000000000110000;
            4'hd: rom_data =    16'b0000000000110000;
            4'he: rom_data =    16'b0000000000110000;         
            4'hf: rom_data =    16'b0000000000110000;   
        endcase
        else if (value == 5)
            case (rom_addr)
            4'h0: rom_data =    16'b0011111111111100;
            4'h1: rom_data =    16'b0011111111111100;
            4'h2: rom_data =    16'b0011000000000000;
            4'h3: rom_data =    16'b0011000000000000;
            4'h4: rom_data =    16'b0011000000000000;
            4'h5: rom_data =    16'b0011000000000000;
            4'h6: rom_data =    16'b0011000000000000;
            4'h7: rom_data =    16'b0011000000000000;
            4'h8: rom_data =    16'b0011111111110000;
            4'h9: rom_data =    16'b0011111111111000;
            4'ha: rom_data =    16'b0000000000011000;
            4'hb: rom_data =    16'b0000000000001100;
            4'hc: rom_data =    16'b0000000000001100;
            4'hd: rom_data =    16'b0010000000011000;
            4'he: rom_data =    16'b0011111111110000;         
            4'hf: rom_data =    16'b0001111111100000;   
        endcase
        else if (value == 6)
            case (rom_addr)
            4'h0: rom_data =    16'b0000000110000000;
            4'h1: rom_data =    16'b0000011111100000;
            4'h2: rom_data =    16'b0000110000110000;
            4'h3: rom_data =    16'b0001100000000000;
            4'h4: rom_data =    16'b0011000000000000;
            4'h5: rom_data =    16'b0011000000000000;
            4'h6: rom_data =    16'b0011000000000000;
            4'h7: rom_data =    16'b0011001111000000;
            4'h8: rom_data =    16'b0011111111110000; 
            4'h9: rom_data =    16'b0011100000011000;
            4'ha: rom_data =    16'b0011100000011100;
            4'hb: rom_data =    16'b0011000000001100;
            4'hc: rom_data =    16'b0011100000011100;
            4'hd: rom_data =    16'b0001100000011000;
            4'he: rom_data =    16'b0000111111110000;         
            4'hf: rom_data =    16'b0000001111000000;   
        endcase
        else if (value == 7)
            case (rom_addr)
            4'h0: rom_data =    16'b0011111111111100;
            4'h1: rom_data =    16'b0011111111111100;
            4'h2: rom_data =    16'b0000000000001100;
            4'h3: rom_data =    16'b0000000000011000;
            4'h4: rom_data =    16'b0000000000110000;
            4'h5: rom_data =    16'b0000000001100000;
            4'h6: rom_data =    16'b0000000011000000;
            4'h7: rom_data =    16'b0000000110000000;
            4'h8: rom_data =    16'b0000001100000000;
            4'h9: rom_data =    16'b0000011000000000;
            4'ha: rom_data =    16'b0000110000000000;
            4'hb: rom_data =    16'b0001100000000000;
            4'hc: rom_data =    16'b0011000000000000;
            4'hd: rom_data =    16'b0011000000000000;
            4'he: rom_data =    16'b0011000000000000;         
            4'hf: rom_data =    16'b0011000000000000;   
        endcase
        else if (value == 8)
            case (rom_addr)
            4'h0: rom_data =    16'b0001111111111000;
            4'h1: rom_data =    16'b0011111111111100;
            4'h2: rom_data =    16'b0011100000011100;
            4'h3: rom_data =    16'b0011000000001100;
            4'h4: rom_data =    16'b0011000000001100;
            4'h5: rom_data =    16'b0011100000011100;
            4'h6: rom_data =    16'b0001111111111000;
            4'h7: rom_data =    16'b0001111111111000;
            4'h8: rom_data =    16'b0011100000011100;
            4'h9: rom_data =    16'b0011000000001100;
            4'ha: rom_data =    16'b0011000000001100;
            4'hb: rom_data =    16'b0011000000001100;
            4'hc: rom_data =    16'b0011000000001100;
            4'hd: rom_data =    16'b0011100000011100;
            4'he: rom_data =    16'b0011111111111100;         
            4'hf: rom_data =    16'b0001111111111000;   
        endcase
        else if (value == 9)
            case (rom_addr)
            4'h0: rom_data =    16'b0000001111000000;
            4'h1: rom_data =    16'b0001111111110000;
            4'h2: rom_data =    16'b0001100000011000;
            4'h3: rom_data =    16'b0011100000011100;
            4'h4: rom_data =    16'b0011000000001100;
            4'h5: rom_data =    16'b0011100000011100;
            4'h6: rom_data =    16'b0001100000011100;
            4'h7: rom_data =    16'b0000111111111100;
            4'h8: rom_data =    16'b0000001111001100;
            4'h9: rom_data =    16'b0000000000001100;
            4'ha: rom_data =    16'b0000000000001100;
            4'hb: rom_data =    16'b0000000000001100;
            4'hc: rom_data =    16'b0000000000011000;
            4'hd: rom_data =    16'b0000110000110000;
            4'he: rom_data =    16'b0000011111100000;        
            4'hf: rom_data =    16'b0000000110000000;   
        endcase
    end
    
endmodule
