`timescale 1ns / 1ps

module fourDigitDisplayDecoder(secMSB, secLSB, minMSB, minLSB, hourMSB, hourLSB, outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB);
    input [3:0] secMSB, secLSB, minMSB, minLSB, hourMSB, hourLSB;
    output reg [6:0] outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB;
    
    //SECONDS
    always @(secMSB)
    begin
        case (secMSB)
            0: outsecMSB = 7'b1000000;
            1: outsecMSB = 7'b1111001;
            2: outsecMSB = 7'b0100100;
            3: outsecMSB = 7'b0110000;
            4: outsecMSB = 7'b0011001;
            5: outsecMSB = 7'b0010010;
            6: outsecMSB = 7'b0000010;
            7: outsecMSB = 7'b1111000;
            8: outsecMSB = 7'b0000000;
            9: outsecMSB = 7'b0010000;
        endcase
    end
    
    always @(secLSB)
    begin
        case (secLSB)
            0: outsecLSB = 7'b1000000;
            1: outsecLSB = 7'b1111001;
            2: outsecLSB = 7'b0100100;
            3: outsecLSB = 7'b0110000;
            4: outsecLSB = 7'b0011001;
            5: outsecLSB = 7'b0010010;
            6: outsecLSB = 7'b0000010;
            7: outsecLSB = 7'b1111000;
            8: outsecLSB = 7'b0000000;
            9: outsecLSB = 7'b0010000;
        endcase
    end
    
    //MINUTES
    always @(minMSB)
    begin
        case (minMSB)
            0: outminMSB = 7'b1000000;
            1: outminMSB = 7'b1111001;
            2: outminMSB = 7'b0100100;
            3: outminMSB = 7'b0110000;
            4: outminMSB = 7'b0011001;
            5: outminMSB = 7'b0010010;
            6: outminMSB = 7'b0000010;
            7: outminMSB = 7'b1111000;
            8: outminMSB = 7'b0000000;
            9: outminMSB = 7'b0010000;
        endcase
    end
    
    always @(minLSB)
    begin
        case (minLSB)
            0: outminLSB = 7'b1000000;
            1: outminLSB = 7'b1111001;
            2: outminLSB = 7'b0100100;
            3: outminLSB = 7'b0110000;
            4: outminLSB = 7'b0011001;
            5: outminLSB = 7'b0010010;
            6: outminLSB = 7'b0000010;
            7: outminLSB = 7'b1111000;
            8: outminLSB = 7'b0000000;
            9: outminLSB = 7'b0010000;
        endcase
    end
    
    //HOURS
    always @(hourMSB)
    begin
        case (hourMSB)
            0: outhourMSB = 7'b1000000;
            1: outhourMSB = 7'b1111001;
            2: outhourMSB = 7'b0100100;
            3: outhourMSB = 7'b0110000;
            4: outhourMSB = 7'b0011001;
            5: outhourMSB = 7'b0010010;
            6: outhourMSB = 7'b0000010;
            7: outhourMSB = 7'b1111000;
            8: outhourMSB = 7'b0000000;
            9: outhourMSB = 7'b0010000;
        endcase
    end
    
    always @(hourLSB)
    begin
        case (hourLSB)
            0: outhourLSB = 7'b1000000;
            1: outhourLSB = 7'b1111001;
            2: outhourLSB = 7'b0100100;
            3: outhourLSB = 7'b0110000;
            4: outhourLSB = 7'b0011001;
            5: outhourLSB = 7'b0010010;
            6: outhourLSB = 7'b0000010;
            7: outhourLSB = 7'b1111000;
            8: outhourLSB = 7'b0000000;
            9: outhourLSB = 7'b0010000;
        endcase
    end
endmodule