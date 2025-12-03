# Gate-Level Netlist Directory

This directory contains the gate-level (post-synthesis) netlist for the CF_SRAM_8192x32 macro.

## Expected File

- `CF_SRAM_8192x32.v` - Verilog gate-level netlist

## Generation

This file should be generated from synthesis of the RTL design. It contains:
- Technology-mapped netlist using standard cells
- Post-synthesis representation of the design
- Used for gate-level simulation and formal verification

## Reference

See `CF_SRAM_4096x32/hdl/gl/CF_SRAM_4096x32.v` for the equivalent file in the 16KB SRAM macro.

