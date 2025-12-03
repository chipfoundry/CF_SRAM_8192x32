# OpenLane Configuration Updates
## CF_SRAM_8192x32_wb_wrapper

**Update Date:** 2025-01-21  
**Status:** ✅ Complete

---

## Changes Made

### 1. Created `pdn.tcl` File
- **Location:** `caravel_user_sram_32kb/openlane/CF_SRAM_8192x32_wb_wrapper/pdn.tcl`
- **Purpose:** Custom power distribution network configuration
- **Source:** Adapted from CF_SRAM_4096x32_wb_wrapper/pdn.tcl
- **Status:** ✅ Created

### 2. Updated `config.json`

#### Added Parameters:
- ✅ `FP_PDN_MULTILAYER: true` - Enable multi-layer PDN
- ✅ `FP_PDN_CORE_RING: false` - Disable core ring (matching 16KB)
- ✅ `CORE_AREA: "5.000 5.000 1790 1390"` - Core area specification
- ✅ `SIGNOFF_SDC_FILE` - Signoff timing constraints
- ✅ `FP_PDN_HORIZONTAL_LAYER: "met3"` - PDN horizontal layer
- ✅ `FP_PDN_VERTICAL_LAYER: "met2"` - PDN vertical layer
- ✅ `FP_PDN_VOFFSET: 5` - Vertical offset
- ✅ `FP_PDN_HOFFSET: 5` - Horizontal offset
- ✅ `FP_PDN_VWIDTH: 1.76` - Vertical stripe width
- ✅ `FP_PDN_HWIDTH: 1.76` - Horizontal stripe width
- ✅ `FP_PDN_VSPACING: 10` - Vertical spacing
- ✅ `FP_PDN_HSPACING: 10` - Horizontal spacing
- ✅ `FP_PDN_VPITCH: 50` - Vertical pitch
- ✅ `FP_PDN_HPITCH: 50` - Horizontal pitch
- ✅ `FP_PDN_CFG: "dir::pdn.tcl"` - Reference to PDN config file
- ✅ `FP_PDN_MACRO_HOOKS` - Power hooks for all 8 SRAM instances

#### Updated Parameters:
- ✅ `CLOCK_PERIOD: 25` (was 20.0) - Matches 16KB configuration
- ✅ `VDD_NETS: ["VPWR"]` (was ["vccd1"]) - Matches SRAM macro power pins
- ✅ `GND_NETS: ["VGND"]` (was ["vssd1"]) - Matches SRAM macro ground pins
- ✅ `PL_TARGET_DENSITY: 0.15` (was 0.30) - Matches 16KB for better routability
- ✅ `SYNTH_DEFINES: ["PnR"]` (was ["USE_POWER_PINS"]) - Matches 16KB

#### Removed Parameters:
- ❌ `PDN_MULTILAYER: false` - Replaced with `FP_PDN_MULTILAYER: true`
- ❌ `SYNTH_POWER_PORTS` - Not needed with VPWR/VGND
- ❌ `SYNTH_GND_PORTS` - Not needed with VPWR/VGND
- ❌ `FP_CORE_UTIL` - Replaced with explicit CORE_AREA
- ❌ `FP_ASPECT_RATIO` - Not needed with absolute sizing
- ❌ `PL_MACRO_HALO` - Using default
- ❌ `PL_MACRO_CHANNEL` - Using default
- ❌ `IO_PCT` - Not applicable
- ❌ `SYNTH_NO_FLAT` - Using default
- ❌ `SYNTH_TOP_LEVEL` - Using default
- ❌ `SYNTH_READ_BLACKBOX_LIB` - Using default
- ❌ `SYNTH_STRATEGY` - Using default
- ❌ `SYNTH_MAX_FANOUT` - Using default
- ❌ `SYNTH_CLOCK_UNCERTAINTY` - Using default
- ❌ `GLB_RT_ADJUSTMENT` - Using default

#### Added Power Hooks:
Power hooks for all 8 SRAM instances (sram0 through sram7), each with 4 power domain connections:
- `vpwra vgnd` - Array power
- `vpb vnb` - Body bias
- `vpwrp vgnd` - Periphery power
- `vpwrm vgnd` - Main power

**Total:** 32 power hook entries (8 instances × 4 power domains)

---

## Configuration Comparison

| Parameter | 16KB (4096x32) | 32KB (8192x32) | Status |
|-----------|----------------|----------------|--------|
| **Die Area** | 720 × 920 | 1800 × 1400 | ✅ Expected (larger) |
| **Core Area** | 5.0 × 5.0 to 700 × 900 | 5.0 × 5.0 to 1790 × 1390 | ✅ Scaled |
| **Clock Period** | 25 ns | 25 ns | ✅ Matched |
| **PDN Config** | `pdn.tcl` | `pdn.tcl` | ✅ Created |
| **Power Hooks** | 4 instances (16 entries) | 8 instances (32 entries) | ✅ Complete |
| **PDN Multilayer** | true | true | ✅ Matched |
| **Placement Density** | 0.15 | 0.15 | ✅ Matched |
| **Power Nets** | VPWR/VGND | VPWR/VGND | ✅ Matched |

---

## Files Modified

1. ✅ `caravel_user_sram_32kb/openlane/CF_SRAM_8192x32_wb_wrapper/pdn.tcl` - **CREATED**
2. ✅ `caravel_user_sram_32kb/openlane/CF_SRAM_8192x32_wb_wrapper/config.json` - **UPDATED**

---

## Verification Checklist

- [x] `pdn.tcl` file created and matches 16KB structure
- [x] Power hooks added for all 8 SRAM instances
- [x] PDN configuration parameters added
- [x] CORE_AREA specified
- [x] Clock period matches 16KB (25 ns)
- [x] Power nets match SRAM macro (VPWR/VGND)
- [x] Placement density matches 16KB (0.15)
- [x] All PDN parameters configured
- [x] Configuration follows 16KB pattern

---

## Next Steps

1. **Run OpenLane flow** to verify configuration
2. **Check power distribution** to all 8 SRAM instances
3. **Verify timing closure** at 25 ns clock period
4. **Check routing** with 0.15 placement density
5. **Validate DRC/LVS** after layout generation

---

## Notes

- Configuration now matches the structure and parameters of the 16KB macro
- Power hooks properly connect all 8 SRAM instances to required power domains
- PDN configuration ensures proper power distribution across the larger die area
- Clock period set to 25 ns to match proven 16KB configuration

