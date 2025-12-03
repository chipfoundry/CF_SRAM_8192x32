// SPDX-FileCopyrightText: 2025 Umbralogic Technologies LLC d/b/a ChipFoundry and its Licensors, All Rights Reserved
// ========================================================================================
//
// This software is proprietary and protected by copyright and other intellectual property
// rights. Any reproduction, modification, translation, compilation, or representation
// beyond expressly permitted use is strictly prohibited.
//
// Access and use of this software are granted solely for integration into semiconductor
// chip designs created by you as part of ChipFoundry shuttles or ChipFoundry managed
// production programs. It is exclusively for Umbralogic Technologies LLC d/b/a ChipFoundry production purposes, and you may
// not modify or convey the software for any other purpose.
//
// DISCLAIMER: UMBRALOGIC TECHNOLOGIES LLC D/B/A CHIPFOUNDRY AND ITS LICENSORS PROVIDE THIS MATERIAL "AS IS," WITHOUT
// WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// Umbralogic Technologies LLC d/b/a ChipFoundry reserves the right to make changes without notice. Neither Umbralogic Technologies LLC d/b/a ChipFoundry nor its
// licensors assume any liability arising from the application or use of any product or
// circuit described herein. Umbralogic Technologies LLC d/b/a ChipFoundry products are not authorized for use as components
// in life-support devices.
//
// This license is subject to the terms of any separate agreement you have with Umbralogic Technologies LLC d/b/a ChipFoundry
// concerning the use of this software, which shall control in case of conflict.

`timescale 1 ns / 1 ps

`ifdef USE_POWER_PINS
    `define USE_PG_PIN
`endif

module CF_SRAM_8192x32 (
    output [31:0] DO,
    output ScanOutCC,
    input  [31:0] DI,
    input  [31:0] BEN,
    input  [12:0] AD,      // 13-bit address for 8192 words
    input  EN,
    input  R_WB,
    input  CLKin,
    input  WLBI,
    input  WLOFF,
    input  TM,
    input  SM,
    input  ScanInCC,
    input  ScanInDL,
    input  ScanInDR,
    input  vpwrac,
    input  vpwrpc,
`ifdef USE_POWER_PINS
    input  vgnd,
    input  vnb,
    input  vpb,
    input  vpwra,
    input  vpwrm,
    input  vpwrp
`endif
);

    parameter NB = 32;    // Number of Data Bits
    parameter NA = 13;    // Number of Address Bits (8192 = 2^13)
    parameter NW = 8192;  // Number of WORDS
    parameter SEED = 0;   // User can define SEED at memory instantiation

    // Address decoding for the eight 1024x32 SRAMs
    // The upper 3 bits of the address select the SRAM macro
    wire [9:0] sram_addr = AD[9:0];  // Lower 10 bits for each 1024x32 SRAM
    wire [7:0] sram_cs;

    assign sram_cs[0] = (AD[12:10] == 3'b000) && EN;
    assign sram_cs[1] = (AD[12:10] == 3'b001) && EN;
    assign sram_cs[2] = (AD[12:10] == 3'b010) && EN;
    assign sram_cs[3] = (AD[12:10] == 3'b011) && EN;
    assign sram_cs[4] = (AD[12:10] == 3'b100) && EN;
    assign sram_cs[5] = (AD[12:10] == 3'b101) && EN;
    assign sram_cs[6] = (AD[12:10] == 3'b110) && EN;
    assign sram_cs[7] = (AD[12:10] == 3'b111) && EN;

    // SRAM data outputs
    wire [31:0] sram_do_0, sram_do_1, sram_do_2, sram_do_3;
    wire [31:0] sram_do_4, sram_do_5, sram_do_6, sram_do_7;
    wire [31:0] sram_do;

    // Scan chain outputs
    wire sram_scan_out_cc_0, sram_scan_out_cc_1, sram_scan_out_cc_2, sram_scan_out_cc_3;
    wire sram_scan_out_cc_4, sram_scan_out_cc_5, sram_scan_out_cc_6, sram_scan_out_cc_7;

    // Instantiate the eight 1024x32 SRAM macros
    CF_SRAM_1024x32 sram0 (
        .DO(sram_do_0),
        .ScanOutCC(sram_scan_out_cc_0),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[0]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram1 (
        .DO(sram_do_1),
        .ScanOutCC(sram_scan_out_cc_1),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[1]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram2 (
        .DO(sram_do_2),
        .ScanOutCC(sram_scan_out_cc_2),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[2]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram3 (
        .DO(sram_do_3),
        .ScanOutCC(sram_scan_out_cc_3),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[3]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram4 (
        .DO(sram_do_4),
        .ScanOutCC(sram_scan_out_cc_4),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[4]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram5 (
        .DO(sram_do_5),
        .ScanOutCC(sram_scan_out_cc_5),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[5]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram6 (
        .DO(sram_do_6),
        .ScanOutCC(sram_scan_out_cc_6),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[6]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    CF_SRAM_1024x32 sram7 (
        .DO(sram_do_7),
        .ScanOutCC(sram_scan_out_cc_7),
        .AD(sram_addr),
        .BEN(BEN),
        .CLKin(CLKin),
        .DI(DI),
        .EN(sram_cs[7]),
        .R_WB(R_WB),
        .ScanInCC(ScanInCC),
        .ScanInDL(ScanInDL),
        .ScanInDR(ScanInDR),
        .SM(SM),
        .TM(TM),
        .WLBI(WLBI),
        .WLOFF(WLOFF),
`ifdef USE_POWER_PINS
        .vgnd(vgnd),
        .vnb(vnb),
        .vpb(vpb),
        .vpwra(vpwra),
        .vpwrm(vpwrm),
        .vpwrp(vpwrp),
`endif
        .vpwrac(vpwrac),
        .vpwrpc(vpwrpc)
    );

    // Mux the read data from the eight SRAMs
    assign sram_do = sram_cs[0] ? sram_do_0 :
                     sram_cs[1] ? sram_do_1 :
                     sram_cs[2] ? sram_do_2 :
                     sram_cs[3] ? sram_do_3 :
                     sram_cs[4] ? sram_do_4 :
                     sram_cs[5] ? sram_do_5 :
                     sram_cs[6] ? sram_do_6 :
                                  sram_do_7;

    // Mux the scan chain output
    assign ScanOutCC = sram_cs[0] ? sram_scan_out_cc_0 :
                       sram_cs[1] ? sram_scan_out_cc_1 :
                       sram_cs[2] ? sram_scan_out_cc_2 :
                       sram_cs[3] ? sram_scan_out_cc_3 :
                       sram_cs[4] ? sram_scan_out_cc_4 :
                       sram_cs[5] ? sram_scan_out_cc_5 :
                       sram_cs[6] ? sram_scan_out_cc_6 :
                                    sram_scan_out_cc_7;

    // Output assignment
    assign DO = sram_do;

endmodule

