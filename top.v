`timescale 1ns / 1ps

module top(clk, reset, upsec, upmin, uphour, ps2d, ps2c, displayOut, anodeOut, hsync, vsync, rgb);
    input clk, reset;
    input upsec, upmin, uphour;
    input ps2d, ps2c;
    output [6:0] displayOut;
    output [7:0] anodeOut;
    output hsync, vsync;
    output [11:0] rgb;
    
    ///////////////////////////////////////////////////////
    // Misc Section
    ///////////////////////////////////////////////////////
    
    

    ///////////////////////////////////////////////////////
    // Supplemental Section
    ///////////////////////////////////////////////////////
    
    // slow clock
    wire slowClock;
    
    // instantiate slow clock
    slow1hzClock u_slow1hzClock(.clk(clk), .resetSW(reset), .outsignal(slowClock));
    
    ///////////////////////////////////////////////////////
    // Keyboard Section
    ///////////////////////////////////////////////////////
    
    // keyboard connections (redundant)
    wire rx_done_tick;
    wire [7:0] scan_code;
    
    // instantiate keyboard inputs
    ps2_rx key_in(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c), .rx_en(1'b1), .rx_done_tick(rx_done_tick), .dout(scan_code));
    kb_controller kb_left(.clk(clk), .reset(reset), .scan_code_read(8'h1C), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(left_key));
    kb_controller kb_right(.clk(clk), .reset(reset), .scan_code_read(8'h23), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(right_key));
    kb_controller kb_up(.clk(clk), .reset(reset), .scan_code_read(8'h1D), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(up_key));
    kb_controller kb_down(.clk(clk), .reset(reset), .scan_code_read(8'h1B), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(down_key));
    
    ///////////////////////////////////////////////////////
    // Seven Segment Display Section
    ///////////////////////////////////////////////////////
    
    // 7-segment anodes
    wire [5:0] anodes;
    
    // assign anodes
    assign anodeOut = {2'b11, anodes};
    
    // 7-segment display wires
    wire [3:0] outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB;
    wire [6:0] decoderToDisplay0, decoderToDisplay1, decoderToDisplay2, decoderToDisplay3, decoderToDisplay4, decoderToDisplay5;
    
    
    // instantiate 7 segment display controllers
    fourDigitDisplayDecoder u_fourDigitDisplayDecoder(
        .secMSB(outsecMSB),
        .secLSB(outsecLSB), 
        .minMSB(outminMSB), 
        .minLSB(outminLSB),
        .hourMSB(outhourMSB),
        .hourLSB(outhourLSB),
        .outsecMSB(decoderToDisplay1),
        .outsecLSB(decoderToDisplay0),
        .outminMSB(decoderToDisplay3),
        .outminLSB(decoderToDisplay2),
        .outhourMSB(decoderToDisplay5),
        .outhourLSB(decoderToDisplay4));
    
    // instantitate display controller    
    displayController u_displayController(
        .clk(clk),
        .in0(decoderToDisplay0),
        .in1(decoderToDisplay1),
        .in2(decoderToDisplay2),
        .in3(decoderToDisplay3),
        .in4(decoderToDisplay4),
        .in5(decoderToDisplay5),
        .out(displayOut),
        .outan(anodes));
    
    ///////////////////////////////////////////////////////
    // Time-keeping Section
    ///////////////////////////////////////////////////////
    
    // instantiate current time counter
    counter u_counter(
        .clk(slowClock),
        .reset(reset),
        .upsec(upsec),
        .upmin(upmin),
        .uphour(uphour),
        .outsecMSB(outsecMSB),
        .outsecLSB(outsecLSB),
        .outminMSB(outminMSB),
        .outminLSB(outminLSB),
        .outhourMSB(outhourMSB),
        .outhourLSB(outhourLSB)
        );
    
    ///////////////////////////////////////////////////////
    // VGA display section
    ///////////////////////////////////////////////////////
    
    // signal declaration
    wire [9:0] pixel_x, pixel_y;
    wire video_on, pixel_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // instantiate vga sync circuit
    vga_sync u_vga_sync(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));
    
    // instantiate display module
    vga_out u_vga_out(
        .insecMSB(outsecMSB),
        .insecLSB(outsecLSB), 
        .inminMSB(outminMSB), 
        .inminLSB(outminLSB),
        .inhourMSB(outhourMSB),
        .inhourLSB(outhourLSB),
        .video_on(video_on),
        .pix_x(pixel_x),
        .pix_y(pixel_y),
        .graph_rgb(rgb_next));
    
    // assign output
    assign rgb = rgb_reg;
    
    // rgb buffer
    always @(posedge clk)
        if (pixel_tick)
            rgb_reg <= rgb_next;
    
endmodule