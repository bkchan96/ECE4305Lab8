`timescale 1ns / 1ps

module counter(clk, reset, settime, upsec, upmin, uphour, outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB);
    input clk, reset;
    input settime, upsec, upmin, uphour;
    output wire [3:0] outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB;
    
    wire incSec, incMin, incHour;
    assign incSec = settime ? upsec : clk;
    assign incMin = settime ? upmin : incMinLSB;
    assign incHour = settime ? uphour : incHourLSB;

    baseTenIncrementer secLSB(.inc(incSec), .reset(reset), .incNext(incSecMSB), .value(outsecLSB));
    baseSixIncrementer secMSB(.inc(incSecMSB), .reset(reset), .incNext(incMinLSB), .value(outsecMSB));
    baseTenIncrementer minLSB(.inc(incMin), .reset(reset), .incNext(incMinMSB), .value(outminLSB));
    baseSixIncrementer minMSB(.inc(incMinMSB), .reset(reset), .incNext(incHourLSB), .value(outminMSB));
    baseFourIncrementer hourLSB(.inc(incHour), .reset(reset), .incNext(incHourMSB), .hourMSBvalue(outhourMSB), .value(outhourLSB));
    baseThreeIncrementer hourMSB(.inc(incHourMSB), .reset(reset), .incNext(), .value(outhourMSB));
    
endmodule