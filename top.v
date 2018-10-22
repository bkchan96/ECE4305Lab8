`timescale 1ns / 1ps

module top(clk, reset, vga_reset, alarm_reset, settime, upsec, upmin, uphour, ps2d, ps2c, displayOut, anodeOut, hsync, vsync, rgb, audioOut, aud_sd, alarm_match);
    input clk, reset, vga_reset, alarm_reset;
    input settime, upsec, upmin, uphour;
    input ps2d, ps2c;
    output [6:0] displayOut;
    output [7:0] anodeOut;
    output hsync, vsync;
    output [11:0] rgb;
    output audioOut, aud_sd;
    output reg alarm_match;
    
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
    wire left_key, right_key, up_key;
    
    // instantiate keyboard inputs
    ps2_rx key_in(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c), .rx_en(1'b1), .rx_done_tick(rx_done_tick), .dout(scan_code));
    
    // instantiate keyboard key control modules
    kb_controller kb_left(.clk(clk), .reset(reset), .scan_code_read(8'h1C), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(left_key));
    kb_controller kb_right(.clk(clk), .reset(reset), .scan_code_read(8'h23), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(right_key));
    kb_controller kb_up(.clk(clk), .reset(reset), .scan_code_read(8'h1D), .scan_done_tick(rx_done_tick),.scan_code(scan_code), .key(up_key));
    
    ///////////////////////////////////////////////////////
    // Alarm State Machine Section
    ///////////////////////////////////////////////////////
   
    // declare wires and registers
    wire [1:0] state;
    wire alarmupsec, alarmupmin, alarmuphour;
    
    // instantiate state machine
    alarm_state_machine u_alarm_state_machine(
        .left_key(left_key),
        .right_key(right_key),
        .state(state));
    
    // incrementation
    assign alarmupsec  = state == 0 ? up_key : 1'b0;
    assign alarmupmin  = state == 1 ? up_key : 1'b0;
    assign alarmuphour = state == 2 ? up_key : 1'b0;

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
    
    //instantiate wires
    wire [3:0] alarmsecMSB, alarmsecLSB, alarmminMSB, alarmminLSB, alarmhourMSB, alarmhourLSB;
    
    // instantiate current time counter
    counter current_time(
        .clk(slowClock),
        .reset(reset),
        .settime(settime),
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
    
    alarm_counter alarm_time(
        .reset(alarm_reset),
        .upsec (alarmupsec),
        .upmin (alarmupmin),
        .uphour(alarmuphour),
        .outsecMSB (alarmsecMSB),
        .outsecLSB (alarmsecLSB),
        .outminMSB (alarmminMSB),
        .outminLSB (alarmminLSB),
        .outhourMSB(alarmhourMSB),
        .outhourLSB(alarmhourLSB)
        );
    
    ///////////////////////////////////////////////////////
    // Alarm Section
    ///////////////////////////////////////////////////////
    
    // declare registers and wires
    reg alarm_match;
    wire sound_reset;
    assign sound_reset = reset || alarm_reset;
    
    // Alarm time vs current time checking logic
    always @* begin
        if (
        (outsecMSB == alarmsecMSB) &&
        (outsecLSB == alarmsecLSB) &&
        (outminMSB == alarmminMSB) &&
        (outminLSB == alarmminLSB) &&
        (outhourMSB == alarmhourMSB) &&
        (outhourLSB == alarmhourLSB))
            alarm_match <= 1;
        else
            alarm_match <= 0;
    end
    
    // instantiate song player
    SongPlayer u_song_player(
        .clock(clk),
        .reset(sound_reset),
        .playSound(alarm_match),
        .audioOut(audioOut),
        .aud_sd(aud_sd));
    
    ///////////////////////////////////////////////////////
    // VGA display section
    ///////////////////////////////////////////////////////
    
    // signal declaration
    wire [9:0] pixel_x, pixel_y;
    wire video_on, pixel_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // instantiate vga sync circuit
    vga_sync u_vga_sync(.clk(clk), .reset(~vga_reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));
    
    // instantiate display module
    vga_out u_vga_out(
        .state(state),
        .settime(settime),
        .insecMSB(outsecMSB),
        .insecLSB(outsecLSB), 
        .inminMSB(outminMSB), 
        .inminLSB(outminLSB),
        .inhourMSB(outhourMSB),
        .inhourLSB(outhourLSB),
        .alarmsecMSB (alarmsecMSB),
        .alarmsecLSB (alarmsecLSB),
        .alarmminMSB (alarmminMSB),
        .alarmminLSB (alarmminLSB),
        .alarmhourMSB(alarmhourMSB),
        .alarmhourLSB(alarmhourLSB),
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