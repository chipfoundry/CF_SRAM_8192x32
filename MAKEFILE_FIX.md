# Makefile Fix Applied
## cocotb Setup Script Fix

**Date:** 2025-01-21  
**Issue:** `ModuleNotFoundError: No module named 'click'` during `make setup`

---

## Problem

When running `make setup`, the `setup-cocotb-env` target was failing with:
```
ModuleNotFoundError: No module named 'click'
```

**Root Cause:**
- The `setup-cocotb.py` script requires the `click` module
- `click` is installed in `venv-cocotb` (via `install-caravel-cocotb`)
- The Makefile was calling the script with system `python3`, which doesn't have `click`

---

## Solution

Updated `setup-cocotb-env` target to use the venv-cocotb Python interpreter:

```makefile
# Before
setup-cocotb-env:
	@(python3 $(PROJECT_ROOT)/verilog/dv/setup-cocotb.py ...)

# After
setup-cocotb-env:
	@($(PROJECT_ROOT)/venv-cocotb/bin/python3 $(PROJECT_ROOT)/verilog/dv/setup-cocotb.py ...)
```

---

## File Modified

- `caravel_user_sram_32kb/Makefile` line 325

---

## Status

✅ **Fixed** - The script now uses the correct Python interpreter with click installed

---

## Note

The 16KB version also uses system `python3` for this script, but it may work if click is installed system-wide. The fix ensures it works regardless of system Python configuration.

