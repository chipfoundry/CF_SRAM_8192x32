# CF_SRAM_8192x32 Datasheet

## Overview
The CF_SRAM_8192x32 is a 32KB (8192 words × 32 bits) single-port SRAM macro with a Wishbone B4 compliant slave interface.

## Features
- **Capacity**: 8192 words × 32 bits = 32KB
- **Address Width**: 13 bits (8192 = 2^13)
- **Data Width**: 32 bits
- **Interface**: Wishbone B4 compliant slave
- **Byte Enable**: Supports byte-level writes using wbs_sel_i[3:0]
- **Scan Chain**: Includes scan chain support for testing

## Physical Specifications
- **Width**: 1440 μm
- **Height**: 920 μm
- **Technology**: Sky130
- **Supply Voltage**: 1.8V
- **Clock Frequency**: Up to 100 MHz

## Pin Descriptions
See the main README.md for detailed pin descriptions.

## Timing Specifications
See the timing library files in `timing/lib/` for detailed timing information.

## Dependencies
This macro depends on the CF_SRAM_1024x32 macro, which must be available in your design.

