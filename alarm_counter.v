`timescale 1ns / 1ps

module alarm_counter(reset, upsec, upmin, uphour, outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB);
    input reset;
    input upsec, upmin, uphour;
    output wire [3:0] outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB;
    
    wire incSecMSB, incMinMSB, incHourMSB;

    baseTenIncrementer secLSB(.inc(upsec), .reset(reset), .incNext(incSecMSB), .value(outsecLSB));
    baseSixIncrementer secMSB(.inc(incSecMSB), .reset(reset), .incNext(), .value(outsecMSB));
    baseTenIncrementer minLSB(.inc(upmin), .reset(reset), .incNext(incMinMSB), .value(outminLSB));
    baseSixIncrementer minMSB(.inc(incMinMSB), .reset(reset), .incNext(), .value(outminMSB));
    baseFourIncrementer hourLSB(.inc(uphour), .reset(reset), .incNext(incHourMSB), .hourMSBvalue(outhourMSB), .value(outhourLSB));
    baseThreeIncrementer hourMSB(.inc(incHourMSB), .reset(reset), .incNext(), .value(outhourMSB));
    
endmodule