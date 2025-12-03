# Makefile Updates Applied
## caravel_user_sram_32kb

**Update Date:** 2025-01-21  
**Status:** ✅ Complete

---

## Changes Applied

### 1. OpenLane Makefile (`openlane/Makefile`)

#### Updated LibreLane Tag
```makefile
# Before
export CF_LIBRELANE_TAG := CC2509b

# After
export CF_LIBRELANE_TAG := CC2509c
```

**Status:** ✅ Updated to match 16KB

---

### 2. Root Makefile (`Makefile`)

#### Added CIEL_DATA_SOURCE
```makefile
# Added after ROOTLESS export
export CIEL_DATA_SOURCE=static-web:https://chipfoundry.github.io/ciel-releases
```

**Status:** ✅ Added to match 16KB

#### Updated OPEN_PDKS_COMMIT (sky130A)
```makefile
# Before
export OPEN_PDKS_COMMIT?=0fe599b2afb6708d281543108caf8310912f54af

# After
export OPEN_PDKS_COMMIT?=3e0e31dcce8519a7dbb82590346db16d91b7244f
```

**Status:** ✅ Updated to match 16KB

#### Updated OPEN_PDKS_COMMIT (sky130B)
```makefile
# Before
export OPEN_PDKS_COMMIT?=0fe599b2afb6708d281543108caf8310912f54af

# After
export OPEN_PDKS_COMMIT?=3e0e31dcce8519a7dbb82590346db16d91b7244f
```

**Status:** ✅ Updated to match 16KB

#### Removed SKYWATER_COMMIT
```makefile
# Before (had explicit setting)
SKYWATER_COMMIT=f70d8ca46961ff92719d8870a18a076370b85f6c

# After (removed, matches 16KB which doesn't have it)
```

**Status:** ✅ Removed to match 16KB

#### Updated run-precheck Dependencies
```makefile
# Before
run-precheck: check-pdk check-precheck enable-lvs-pdk

# After
run-precheck: check-pdk check-precheck
```

**Status:** ✅ Updated to match 16KB

---

## Summary of Changes

| File | Change | Status |
|------|--------|--------|
| `openlane/Makefile` | CF_LIBRELANE_TAG: CC2509b → CC2509c | ✅ Updated |
| `Makefile` | Added CIEL_DATA_SOURCE | ✅ Added |
| `Makefile` | OPEN_PDKS_COMMIT (sky130A): Updated | ✅ Updated |
| `Makefile` | OPEN_PDKS_COMMIT (sky130B): Updated | ✅ Updated |
| `Makefile` | Removed SKYWATER_COMMIT | ✅ Removed |
| `Makefile` | run-precheck: Removed enable-lvs-pdk | ✅ Updated |

---

## Verification

All changes have been applied and the 32KB Makefiles now match the 16KB configuration:

- ✅ LibreLane tag version aligned
- ✅ PDK commit versions aligned
- ✅ CIEL data source configured
- ✅ SKYWATER_COMMIT handling standardized
- ✅ run-precheck dependencies aligned

---

## Next Steps

1. **Test the configuration**
   - Run `make librelane` to verify LibreLane setup
   - Verify PDK installation works correctly
   - Test that all make targets function properly

2. **Commit the changes**
   - Commit the updated Makefiles
   - Document the version alignment in commit message

3. **Monitor for issues**
   - Watch for any PDK-related issues
   - Verify LibreLane runs correctly with new tag
   - Check that precheck still works correctly

---

## Notes

- All changes align 32KB with the proven 16KB configuration
- The removed `enable-lvs-pdk` dependency may need to be re-added if LVS checks fail
- If issues arise, the previous versions are documented in MAKEFILE_REVIEW.md

