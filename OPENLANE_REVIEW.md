# OpenLane Configuration Review
## CF_SRAM_8192x32 (32KB) vs CF_SRAM_4096x32 (16KB)

**Review Date:** 2025-01-21  
**Base Reference:** CF_SRAM_4096x32_wb_wrapper (16KB) - Released

---

## 📊 Configuration File Comparison

### 1. Wrapper-Level Configuration (`user_project_wrapper/config.json`)

#### ✅ Common Settings (Both Match)
- **Design Name:** `user_project_wrapper`
- **Clock Period:** 25 ns
- **Clock Port:** `wb_clk_i`
- **Die Area:** `0 0 2920 3520` (Caravel standard)
- **PDN Core Ring:** Enabled with same dimensions
- **VDD/GND Nets:** Same power domains (vccd1/vccd2/vdda1/vdda2, vssd1/vssd2/vssa1/vssa2)
- **Hardening Strategy:** Both use 1-Macro-First Hardening (SYNTH_ELABORATE_ONLY: true)

#### ⚠️ Differences Found

##### 16KB (CF_SRAM_4096x32)
```json
{
  "VERILOG_FILES_BLACKBOX": [
    "dir::../../ip/CF_SRAM_4096x32/hdl/gl/CF_SRAM_4096x32.v"
  ],
  "EXTRA_LEFS": "dir::../../ip/CF_SRAM_4096x32/lef/CF_SRAM_4096x32.lef",
  "EXTRA_GDS_FILES": "dir::../../ip/CF_SRAM_4096x32/gds/CF_SRAM_4096x32.gds",
  "EXTRA_LIBS": "dir::../../ip/CF_SRAM_4096x32/lib/CF_SRAM_4096x32.lib",
  "EXTRA_SPEFS": [
    "CF_SRAM_4096x32",
    "dir::../../ip/CF_SRAM_4096x32/spef/CF_SRAM_4096x32.min.spef",
    "dir::../../ip/CF_SRAM_4096x32/spef/CF_SRAM_4096x32.nom.spef",
    "dir::../../ip/CF_SRAM_4096x32/spef/CF_SRAM_4096x32.max.spef"
  ],
  "FP_PDN_MACRO_HOOKS": "mprj vccd1 vssd1 VPWR VGND",
  "MACRO_PLACEMENT_CFG": "dir::macro.cfg"
}
```

##### 32KB (CF_SRAM_8192x32)
```json
{
  "MACROS": {
    "CF_SRAM_8192x32_wb_wrapper": {
      "gds": ["dir::../../gds/CF_SRAM_8192x32_wb_wrapper.gds"],
      "lef": ["dir::../../lef/CF_SRAM_8192x32_wb_wrapper.lef"],
      "instances": {
        "mprj": {
          "location": [60, 15],
          "orientation": "N"
        }
      },
      "nl": ["dir::../../verilog/gl/CF_SRAM_8192x32_wb_wrapper.v"],
      "spef": { "min_*": [...], "nom_*": [...], "max_*": [...] },
      "lib": { "*": "dir::../../lib/CF_SRAM_8192x32_wb_wrapper.lib" }
    }
  },
  "VERILOG_FILES_BLACKBOX": [
    "dir::../../verilog/gl/CF_SRAM_8192x32_wb_wrapper.v"
  ],
  "EXTRA_LEFS": "dir::../../lef/CF_SRAM_8192x32_wb_wrapper.lef",
  "EXTRA_GDS_FILES": "dir::../../gds/CF_SRAM_8192x32_wb_wrapper.gds",
  "EXTRA_LIBS": "dir::../../lib/CF_SRAM_8192x32_wb_wrapper.lib",
  "EXTRA_SPEFS": [...],
  "PDN_MACRO_CONNECTIONS": ["mprj vccd1 vssd1 vccd1 vssd1"]
}
```

**Key Differences:**
1. **Configuration Format:** 32KB uses newer `MACROS` section with structured format vs. 16KB's flat `EXTRA_*` approach
2. **Macro Placement:** 32KB specifies location `[60, 15]` in MACROS section; 16KB uses separate `macro.cfg` file
3. **PDN Connections:** 32KB uses `PDN_MACRO_CONNECTIONS`; 16KB uses `FP_PDN_MACRO_HOOKS`
4. **File Paths:** 32KB references `*_wb_wrapper` files; 16KB references base macro files

---

### 2. SRAM Wrapper Configuration (`CF_SRAM_*_wb_wrapper/config.json`)

#### ⚠️ Significant Differences

##### 16KB (CF_SRAM_4096x32_wb_wrapper)
```json
{
  "DESIGN_NAME": "CF_SRAM_4096x32_wb_wrapper",
  "DIE_AREA": "0.000 0.000 720 920",
  "CORE_AREA": "5.000 5.000 700 900",
  "CLOCK_PERIOD": 25,
  "FP_PDN_MULTILAYER": true,
  "FP_PDN_CORE_RING": false,
  "FP_PDN_VPITCH": 50,
  "FP_PDN_HPITCH": 50,
  "FP_PDN_VWIDTH": 1.76,
  "FP_PDN_HWIDTH": 1.76,
  "FP_PDN_VSPACING": 10,
  "FP_PDN_HSPACING": 10,
  "FP_PDN_CFG": "dir::pdn.tcl",
  "FP_PDN_MACRO_HOOKS": [
    "i_sram.sram0 VPWR VGND vpwra vgnd",
    "i_sram.sram0 VPWR VGND vpb vnb",
    "i_sram.sram0 VPWR VGND vpwrp vgnd",
    "i_sram.sram0 VPWR VGND vpwrm vgnd",
    // ... (repeated for sram1, sram2, sram3)
  ],
  "PL_TARGET_DENSITY": 0.15,
  "PL_ROUTABILITY_DRIVEN": true,
  "GLB_RESIZER_DESIGN_OPTIMIZATIONS": true,
  "GLB_RESIZER_TIMING_OPTIMIZATIONS": true
}
```

##### 32KB (CF_SRAM_8192x32_wb_wrapper)
```json
{
  "DESIGN_NAME": "CF_SRAM_8192x32_wb_wrapper",
  "DIE_AREA": "0 0 1800 1400",
  "CLOCK_PERIOD": 20.0,
  "PDN_MULTILAYER": false,
  "VDD_NETS": ["vccd1"],
  "GND_NETS": ["vssd1"],
  "SYNTH_POWER_PORTS": ["vccd1"],
  "SYNTH_GND_PORTS": ["vssd1"],
  "FP_CORE_UTIL": 30,
  "FP_ASPECT_RATIO": 1.0,
  "PL_TARGET_DENSITY": 0.30,
  "SYNTH_STRATEGY": "AREA 0",
  "SYNTH_MAX_FANOUT": 10,
  "SYNTH_CLOCK_UNCERTAINTY": 0.25,
  "GLB_RT_ADJUSTMENT": 0.1
}
```

**Critical Differences:**

1. **Die Area:**
   - 16KB: `720 × 920` (0.662 mm²)
   - 32KB: `1800 × 1400` (2.52 mm²) - **3.8× larger area**

2. **Clock Period:**
   - 16KB: `25 ns` (40 MHz)
   - 32KB: `20 ns` (50 MHz) - **Faster clock target**

3. **PDN Configuration:**
   - 16KB: `FP_PDN_MULTILAYER: true`, has `pdn.tcl` file, detailed macro hooks
   - 32KB: `PDN_MULTILAYER: false`, **missing `pdn.tcl` file**

4. **Power Nets:**
   - 16KB: Uses `VPWR/VGND` with multiple power domains (vpwra, vpwrp, vpwrm, vpb, vnb)
   - 32KB: Uses `vccd1/vssd1` only - **Simplified power structure**

5. **Placement Density:**
   - 16KB: `PL_TARGET_DENSITY: 0.15` (15%)
   - 32KB: `PL_TARGET_DENSITY: 0.30` (30%) - **Higher density**

6. **Missing in 32KB:**
   - ❌ `FP_PDN_CFG` / `pdn.tcl` file
   - ❌ `FP_PDN_MACRO_HOOKS` for individual SRAM instances
   - ❌ `CORE_AREA` specification
   - ❌ Detailed PDN parameters (VPITCH, HPITCH, VWIDTH, etc.)

---

### 3. Macro Placement Configuration (`macro.cfg`)

##### 16KB (CF_SRAM_4096x32_wb_wrapper)
```
i_sram.sram0 10.1 40 W
i_sram.sram1 360.1 40 W
i_sram.sram2 10.1 480 W
i_sram.sram3 360.1 480 W
```
- **4 SRAM instances** in 2×2 grid
- Orientation: All `W` (West)
- Spacing: ~350 μm between columns, ~440 μm between rows

##### 32KB (CF_SRAM_8192x32_wb_wrapper)
```
u_sram/gen_banks[0]/u_bank N 60 60
u_sram/gen_banks[1]/u_bank N 500 60
u_sram/gen_banks[2]/u_bank N 940 60
u_sram/gen_banks[3]/u_bank N 1380 60
u_sram/gen_banks[4]/u_bank N 500 420
u_sram/gen_banks[5]/u_bank N 500 420
u_sram/gen_banks[6]/u_bank N 940 420
u_sram/gen_banks[7]/u_bank N 1380 420
```
- **8 SRAM instances** in 4×2 grid
- Orientation: All `N` (North)
- Spacing: ~440 μm between columns, ~360 μm between rows
- **Different instance naming:** Uses `gen_banks[*]/u_bank` vs `i_sram.sram*`

---

### 4. Power Distribution Network (PDN)

#### 16KB Has `pdn.tcl` File
- Custom PDN configuration
- Multi-layer power distribution
- Detailed macro power hooks for all 4 SRAM instances
- Core ring configuration
- Met4 layer stripes

#### 32KB Missing `pdn.tcl` File
- ❌ **No custom PDN configuration**
- Uses default OpenLane PDN
- May not properly connect power to all 8 SRAM instances

---

## 🚨 Issues and Recommendations

### Critical Issues

1. **Missing PDN Configuration**
   - **Issue:** 32KB wrapper missing `pdn.tcl` file
   - **Impact:** Power may not be properly distributed to all 8 SRAM instances
   - **Fix:** Create `pdn.tcl` similar to 16KB but adapted for 8 instances

2. **Missing Macro Power Hooks**
   - **Issue:** 32KB doesn't specify `FP_PDN_MACRO_HOOKS` for individual SRAM instances
   - **Impact:** Power connections to embedded SRAMs may be incorrect
   - **Fix:** Add power hooks for all 8 instances (similar to 16KB's 4 instances)

3. **Inconsistent Power Net Names**
   - **Issue:** 32KB uses `vccd1/vssd1` while 16KB uses `VPWR/VGND` with multiple domains
   - **Impact:** May cause power connection issues if SRAMs require specific power domains
   - **Fix:** Verify SRAM power requirements and align configuration

4. **Missing CORE_AREA**
   - **Issue:** 32KB doesn't specify `CORE_AREA`
   - **Impact:** May affect placement and routing
   - **Fix:** Add `CORE_AREA` based on die area and IO requirements

### Moderate Issues

5. **Clock Period Mismatch**
   - **Issue:** 32KB targets 50 MHz vs 16KB's 40 MHz
   - **Impact:** May be too aggressive for larger design
   - **Recommendation:** Verify timing closure at 50 MHz, consider 40 MHz if issues

6. **Higher Placement Density**
   - **Issue:** 32KB uses 30% vs 16KB's 15%
   - **Impact:** May cause routing congestion
   - **Recommendation:** Monitor routing and adjust if needed

7. **Different Configuration Format**
   - **Issue:** 32KB uses newer `MACROS` format vs flat `EXTRA_*` format
   - **Impact:** None if properly configured, but inconsistent with 16KB
   - **Recommendation:** Both formats are valid, but consider standardizing

### Recommendations

1. **Create `pdn.tcl` for 32KB wrapper**
   - Copy from 16KB and adapt for 8 instances
   - Update power hooks for all 8 SRAM banks

2. **Add Power Hooks**
   - Specify power connections for all 8 SRAM instances
   - Match the pattern from 16KB but extend to 8 instances

3. **Verify Power Requirements**
   - Check if 32KB SRAM needs multiple power domains like 16KB
   - Update configuration accordingly

4. **Add CORE_AREA**
   - Calculate appropriate core area based on die size
   - Leave room for IO and routing

5. **Standardize Configuration**
   - Consider using same format (MACROS vs EXTRA_*) for consistency
   - Or document why different formats are used

---

## ✅ Summary

**16KB Configuration:** ✅ Complete and tested
- Has custom PDN configuration
- Proper power hooks for all instances
- Detailed placement configuration

**32KB Configuration:** ⚠️ Incomplete
- Missing critical PDN configuration
- Missing power hooks for SRAM instances
- Different power net structure
- Needs verification and completion

**Overall Status:** 32KB configuration needs completion before tapeout

