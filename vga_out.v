`timescale 1ns / 1ps

module vga_out
    (
        input settime,
        input [3:0] insecMSB, insecLSB, inminMSB, inminLSB, inhourMSB, inhourLSB,
        input [3:0] alarmsecMSB, alarmsecLSB, alarmminMSB, alarmminLSB, alarmhourMSB, alarmhourLSB,
        input wire video_on,
        input wire [9:0] pix_x, pix_y,
        output reg [11:0] graph_rgb
    );
    
    ///////////////////////////////////////////////////////
    // instantiate text display modules
    ///////////////////////////////////////////////////////
    
    // display each digit of current time
    digit_display d_secMSB (.value(insecMSB),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd350), .top_left_y(10'd232), .on(secMSB_on));
    digit_display d_secLSB (.value(insecLSB),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd370), .top_left_y(10'd232), .on(secLSB_on));
    digit_display d_minMSB (.value(inminMSB),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd310), .top_left_y(10'd232), .on(minMSB_on));
    digit_display d_minLSB (.value(inminLSB),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd330), .top_left_y(10'd232), .on(minLSB_on));
    digit_display d_hourMSB(.value(inhourMSB), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd270), .top_left_y(10'd232), .on(hourMSB_on));
    digit_display d_hourLSB(.value(inhourLSB), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd290), .top_left_y(10'd232), .on(hourLSB_on));
    
    // display "TIME"
    current_time_text u_current_time_text(.pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd180), .top_left_y(10'd232), .on(time_on));
    
    // display alarm
    digit_display alarm_d_secMSB (.value(alarmsecMSB ),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd350), .top_left_y(10'd262), .on(alarm_secMSB_on));
    digit_display alarm_d_secLSB (.value(alarmsecLSB ),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd370), .top_left_y(10'd262), .on(alarm_secLSB_on));
    digit_display alarm_d_minMSB (.value(alarmminMSB ),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd310), .top_left_y(10'd262), .on(alarm_minMSB_on));
    digit_display alarm_d_minLSB (.value(alarmminLSB ),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd330), .top_left_y(10'd262), .on(alarm_minLSB_on));
    digit_display alarm_d_hourMSB(.value(alarmhourMSB),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd270), .top_left_y(10'd262), .on(alarm_hourMSB_on));
    digit_display alarm_d_hourLSB(.value(alarmhourLSB),  .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(10'd290), .top_left_y(10'd262), .on(alarm_hourLSB_on));

    ///////////////////////////////////////////////////////
    // display dots
    ///////////////////////////////////////////////////////
    
    // declare on bit
    reg dot_on;
    
    // display dot conditions
    always @*
        if ((pix_y >= 237 && pix_y <= 238) || (pix_y >= 243 && pix_y <= 244))
            if((pix_x >= 245 && pix_x <= 246) || (pix_x >= 307 && pix_x <= 308) || (pix_x >= 347 && pix_x <= 348))
                dot_on = 1'b1;
            else
                dot_on = 1'b0;
        else
            dot_on = 1'b0;
            
    ///////////////////////////////////////////////////////
    // rgb multiplexing circuit
    ///////////////////////////////////////////////////////
    
    localparam BLACK    = 12'b000000000000;
    localparam WHITE    = 12'b111111111111;
    localparam RED      = 12'b111100000000;
    
    always @*
        if (~video_on)
             graph_rgb = 0; // blank
        else
            ///////////////////////////////////////////////
            // Current Time Enable and Color
            ///////////////////////////////////////////////
            if (dot_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (secMSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (secLSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (minMSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (minLSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (hourMSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (hourLSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (time_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            
            ///////////////////////////////////////////////
            // Current Time Enable and Color
            ///////////////////////////////////////////////
            
            else if (alarm_secMSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (alarm_secLSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (alarm_minMSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (alarm_minLSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (alarm_hourMSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            else if (alarm_hourLSB_on)
                if (~settime) graph_rgb = BLACK; else graph_rgb = RED;
            
            ///////////////////////////////////////////////
            // White Background Color
            ///////////////////////////////////////////////
            else
                graph_rgb = WHITE;
                
endmodule
