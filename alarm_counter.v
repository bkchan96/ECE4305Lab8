`timescale 1ns / 1ps

module alarm_counter(upsec, upmin, uphour, outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB);
    input upsec, upmin, uphour;
    output wire [3:0] outsecMSB, outsecLSB, outminMSB, outminLSB, outhourMSB, outhourLSB;

    baseTenIncrementer secLSB(.inc(upsec), .reset(reset), .incNext(incSecMSB), .value(outsecLSB));
    baseSixIncrementer secMSB(.inc(incSecMSB), .reset(reset), .incNext(incMinLSB), .value(outsecMSB));
    baseTenIncrementer minLSB(.inc(upmin), .reset(reset), .incNext(incMinMSB), .value(outminLSB));
    baseSixIncrementer minMSB(.inc(incMinMSB), .reset(reset), .incNext(incHourLSB), .value(outminMSB));
    baseFourIncrementer hourLSB(.inc(uphour), .reset(reset), .incNext(incHourMSB), .hourMSBvalue(outhourMSB), .value(outhourLSB));
    baseThreeIncrementer hourMSB(.inc(incHourMSB), .reset(reset), .incNext(), .value(outhourMSB));
    
endmodule