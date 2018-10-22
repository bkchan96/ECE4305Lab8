module SongPlayer
(
    input clock,
    input reset,
    input playSound,
    output reg audioOut,
    output wire aud_sd
);
    // declare wires and registers
    reg [19:0] counter;
    reg [31:0] time1, noteTime;
    reg [9:0] msec;
    reg [9:0] number;	//millisecond counter, and sequence number of musical note.
    wire [4:0] note, duration;
    wire [19:0] notePeriod;
    
    // declare clock frequency which controlls the speed of the song
    parameter clockFrequency = 130_000_000;	//50 MHz
    
    // made aud_sd high to allow output
    assign aud_sd = 1'b1;
    
    // instantitate sheet music
    MusicSheet 	mysong(
        .number(number), 
        .note(notePeriod),
        .duration(duration),
        .done(done));
    
    // declare stop wiring
    reg enable;
    wire done;
    wire stop;
    wire trigger;
    assign stop = done || reset;
    assign trigger = stop || playSound;    
    
    // trigger state
    always @ (posedge trigger)
    begin
        if (stop)
            enable <= 1'b0;
        else
            enable <= 1'b1;
    end   
    
    // state machine
    always @ (posedge clock) 
    begin
        if(~enable) 
            begin 
              counter <=0;  
              time1<=0;  
              number <=0;  
              audioOut <=1;	
            end
        else 
        begin
            counter <= counter + 1; 
            time1<= time1+1;
            if( counter >= notePeriod) 
            begin
                counter <=0;  
                audioOut <= ~audioOut ; 
            end	//toggle audio output 	
            if( time1 >= noteTime) 
            begin	
                time1 <=0;  
                number <= number + 1; 
            end  //play next note
        end
    end
    
    // calculate number of FPGA clock periods in one note
    always @(duration) noteTime = duration * clockFrequency / 16;
endmodule
