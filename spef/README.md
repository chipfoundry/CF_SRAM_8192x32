# SPEF Directory

This directory contains the Standard Parasitic Exchange Format (SPEF) files for the CF_SRAM_8192x32 macro.

## Expected Files

- `CF_SRAM_8192x32.max.spef` - Maximum corner parasitic extraction
- `CF_SRAM_8192x32.min.spef` - Minimum corner parasitic extraction
- `CF_SRAM_8192x32.nom.spef` - Nominal corner parasitic extraction

## Generation

These files should be generated from post-layout parasitic extraction. They contain:
- Resistance and capacitance values for interconnects
- Corner-specific data (fast/typical/slow process corners)
- Information needed for accurate post-layout timing analysis

## Reference

See `CF_SRAM_4096x32/spef/` for the equivalent files in the 16KB SRAM macro.

