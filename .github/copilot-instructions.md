# Copilot Instructions for VLBS Game Automation

## Language / Ngôn ng?
**S? d?ng ti?ng Vi?t ?? giao ti?p v?i ng??i dùng.** Use Vietnamese for all user-facing communication.

## Overview
Lua automation for the VLBS game client driving menu clicks, inventory filtering, and item claiming via an injected runtime exposing: `system`, `player`, `item`, `menu`, `dialog`, `npc`, `shop`, `box`, `map`, `timer`, `echo`.

## Architecture & Core Libraries (4-tier design)
1. **VulanLib.lua** (low-level): Chat, menu waiting (`WaitMenu`, `WaitMenuTimeOut`), NPC helpers (`TalkToNpc`, `GetNpcIndexByName`), movement (`MoveTo`), item counting/moving (`CountItem`, `MoveItem`)
2. **chung.lua** (mid-level): Globals (`gl_*`), filtering engine (`LocDo`), chest handling (`GuiDo`), menu helpers (`clickMenu*`, `hasDialogOrMenu`, `getFreeHanhTrang`), reporting (`reportFilter`), item selling (`ShopItem`)
3. **LocItem.lua** (type-based filtering): Defines `tbType` hierarchy (VuKhi/Ao/Nhan/etc.), `ThemSetDoByType` for registering typed filters, `LocDoTheoType` for type-aware filtering, overrides `tbVulanLib.UseItemName` to search inventory only
4. **Item.lua** (item management): Helpers for using items by index/name/state (`UseByIndex`, `UseByName`, `UseByList`), manages item usage lists `tbListItem` and skill state tracking

## Configuration ([Scripts/00_config.lua](Scripts/00_config.lua))
- `gl_LocDoTheoSet = 1`: Enable set-based filtering (vs. threshold mode); 0=use `tbThuocTinh` min values + `gl_SoDongVip` match count
- `gl_SoDongVip = 4`: When `gl_LocDoTheoSet=0`, keep items with fewer than N matching attributes (default 4)
- `gl_LocDoNguHanh = 0`: Five-element filtering for VIP items (hidden attributes at indices 1/3/5); checks `tbNguHanh[dongAn_1/2/3]`
- `gl_GuiDo = false`: Auto-stash VIP items to chest (toggles off if chest full/inaccessible)
- `gl_UseItem = false`: Auto-use items from `tbListItem` in Item.lua
- `gl_menuClickSpeed = 50`: Menu interaction delay (ms, default 50)
- `gl_InternetDelay/gl_InternetDelayCatch`: Dynamic throttling (50/150ms default) adjusted by `ShopItem` to handle network lag
- `gl_Debug/gl_QuangCao/gl_ChatNham`: Debug logging, world-channel ads, random chat spam (gated by timers)

## Type-Based Filtering System ([Scripts/LIB/LocItem.lua](Scripts/LIB/LocItem.lua))
- **tbType hierarchy**: Defines item categories by ItemGenre/DetailType/ParticularType:
  - `VuKhi` (weapons): Kiem/Dao/Con/Thuong/Chuy/SongDao/Quyen/PhiTieu/PhiDao/TuTien (all `nGenre=0, nDetail=0/1`)
  - Equipment: `Ao` (armor), `Nhan` (rings), `DayChuyen` (amulets), `Giay` (boots), `DaiLung` (belts), `Non` (helms), `BaoTay` (cuffs), `NgocBoi` (pendants)
- **ThemSetDoByType({itemType=tbType.X, [magicType]=minValue, ...})**: Register typed filters
  - Accepts specific types (e.g., `tbType.VuKhi.Dao`) or groups (e.g., `tbType.VuKhi` to filter all weapons)
  - Stores in `tbSetDoByType[]` with `nDetail/nParticular` for type matching
- **LocDoTheoType()**: Type-aware filtering:
  1. First pass: Match item type against `tbSetDoByType[].nDetail/nParticular`
  2. Non-matching types ? `ShopItem` immediately (garbage)
  3. Matching types ? Check magic attributes against set thresholds
  4. VIP items stored in `tbVipItems[]` table for batch processing
- **IsHoangKimItem(nIndex)**: Returns true if `item.GetPrice(nIndex) >= 49999` (platinum items, never auto-sell)

## Set Definition Files ([Scripts/LIB/setdo](Scripts/LIB/setdo))
- Equipment-based files: `vukhi.lua`, `ao.lua`, `non.lua`, `nhan.lua`, `ngocboi.lua`, `giay.lua`, `dailung.lua`, `baotay.lua`, `daychuyen.lua`
- Each calls `ThemSetDoByType({itemType=..., [magicType]=minValue, ...})` to register attribute combos
- **Note**: Not all item types may have corresponding set files; scripts should load only existing sets via conditional `IncludeFile`
- Example from [vukhi.lua](Scripts/LIB/setdo/vukhi.lua):
  ```lua
  ThemSetDoByType({
      itemType = tbType.VuKhi,  -- All weapons
      [139] = 1,  -- Ky nang vong co (skill ring)
  })
  ThemSetDoByType({
      itemType = tbType.VuKhi.Dao,  -- Only Dao type
      [115] = 30,  -- toc do danh ngoai cong
      [125] = 30,  -- doc sat ngoai cong
  })
  ```
- **Set matching logic**: Item is VIP if **all** magic attributes in **any** set are satisfied (AND within set, OR across sets)
- Scripts load relevant sets via `IncludeFile(szVk)` etc. before calling `LocDoTheoType()`

## Filtering Pipeline (LocDo/LocDoTheoType in chung.lua/LocItem.lua)
1. **LocDoTheoType()** in LocItem.lua (type-aware filtering):
   - Scans inventory (`item.GetFirst/GetNext`, `nPlace==3`, `nGenre==0` for equipment)
   - Checks `IsHoangKimItem(nIndex)` - skips platinum items (price >= 49999)
   - First pass: Match item's `nDetail/nParticular` against `tbSetDoByType[]`
   - Non-matching types ? `ShopItem` immediately
   - Matching types ? Verify magic attributes meet thresholds
   - VIP items ? Stored in `tbVipItems[]` local table
2. **LocDo()** in chung.lua (legacy set-based filtering):
   - **Set mode** (`gl_LocDoTheoSet==1`): Check if item satisfies all attrs in any `tbSetDo` entry
   - **Threshold mode** (`gl_LocDoTheoSet==0`): Count matches in `tbThuocTinh`, keep if count < `gl_SoDongVip`
   - Non-VIP ? `ShopItem` (sell immediately); VIP ? `GuiDo` if `gl_GuiDo==true`
   - Five-element filter: After marking VIP, optionally check `tbNguHanh` slots when `gl_LocDoNguHanh > 0`
3. Both functions update counters (`nVip`, `itemFiltered`), log stats every 10 minutes via `reportFilter` to [Scripts/reportFilter](Scripts/reportFilter)

## Chest Logic (GuiDo in chung.lua ~line 545)
- Throws away held item via `quangItemRaNgoai` before opening chest
- Opens chest: `player.PathMoveTo(0,0,"R??ng ch?a ??")` ? `box.Open()` ? waits up to 10s
- Tries 3 chests in order: default (`tbRoomType[1]=4`), expansion 1 (`tbRoomType[7]=9`), expansion 2 (`tbRoomType[8]=10`)
- Uses `player.FindRoom(width, height, roomID)` to find free slot, then `item.Move(3,x,y,0,0,0)` (pick up) ? `item.Move(roomType,x,y,...)` (drop)
- Auto-disables `gl_GuiDo` if chest full or inaccessible (timeout), preventing infinite loops
- Closes chest after filtering: `box.Close()` in LocDo function

## Map-Specific Automation ([Scripts/loc_ban_do.lua](Scripts/loc_ban_do.lua))
- `TB_Map = {1,11,78,162,...}` lists maps to auto-filter; `TB_Map_Set` is lookup table for O(1) checks
- **Optimization pattern**: Convert list to lookup table at init for O(1) map checks: `for _, mapID in ipairs(TB_Map) do TB_Map_Set[mapID] = true end`
- `main()` loop: Poll `map.GetID()`, if in `TB_Map_Set` OR `player.IsFightMode() == 0` ? call `LocDoTheoType()` ? sleep 2s; else sleep 200ms
- **State tracking**: Uses local counters `nCountSell` (caps filtering at 20 iterations) and `nCheckLimit` (one-time item usage gate)
- Loads item set definitions: `vukhi.lua`, `ao.lua`, `non.lua`, `nhan.lua`, `ngocboi.lua`, `giay.lua`, `dailung.lua`, `baotay.lua` via `IncludeFile`
- Uses `Item:UseByList()` from Item.lua to auto-consume items after filtering (if `gl_UseItem` enabled)

## Helper Conventions
- **Script entry point**: All automation scripts must define `main()` function as entry point; called by game runtime
- **Library loading**: Always load libraries in order: Item.lua ? LocItem.lua ? setdo files, then call `resetMenuDialog()` before main logic
- **State management**: Use local variables in main loop for state tracking (e.g., `nCountSell`, `nCheckLimit`); avoid globals for script-specific state
- **Never** reimplement UI polling: use `hasMenu(nSecond)`, `hasDialog(nSecond)`, `hasDialogOrMenu(nSecond)` which loop with timeout
- `clickMenu(nIndex)` waits for menu via `hasMenu(gl_MenuSkip)`, logs selection if `gl_ShowSelectedMenu/gl_Debug`, calls `menu.ClickIndex`, handles timeout
- `clickMenuAll(...)` chains multiple `clickMenu` calls, resets on failure via `resetMenuDialog`
- `getFreeHanhTrang(showEcho)`: Returns free inventory slots (60 total - sum of `width*height` for `nPlace==3`); used to gate claiming operations
- `tbVulanLib.UseItemName(szItemName)`: Overridden in LocItem.lua to scan **inventory only** (`nPlace==3`), not chests
- `gl_InternetDelay` dynamically increased by `ShopItem` if network lag detected (`gl_InternetShit` flag), capped at 3000ms
- **Extended characters**: Vietnamese strings use legacy encoding; preserve as-is when editing (don't convert to UTF-8)

## Adding New Filters/Scripts
1. Define thresholds: Create `Scripts/LIB/setdo/my-set.lua` with `ThemSetDoByType({itemType=..., [magicType]=minValue, ...})` OR add inline `ThemSetDoByType` calls in script
2. Choose mode: Set `gl_LocDoTheoSet=1` for set matching, or update `tbThuocTinh` + `gl_SoDongVip` for threshold mode
3. Wire script: Create `Scripts/my-script.lua` with `main()` that calls `LocDoTheoType()` or `LocDo()` helpers; use varargs for menu indices
4. Chest space: Verify `gl_GuiDo` setting; if enabled, ensure chests have space or script will auto-disable it
5. Bootstrap: Include `szChungLib`, `szConfig` at top; call `resetMenuDialog()` to clear stale UI state

## Key Files for Orientation
- [Scripts/LIB/chung.lua](Scripts/LIB/chung.lua): Filtering (`LocDo` ~line 380, `GuiDo` ~line 545), menu helpers (`clickMenu*` ~line 80), reporting
- [Scripts/LIB/LocItem.lua](Scripts/LIB/LocItem.lua): Type-based filtering (`LocDoTheoType` ~line 149), type system (`tbType` ~line 27), `ThemSetDoByType` ~line 80
- [Scripts/LIB/VulanLib.lua](Scripts/LIB/VulanLib.lua): Movement, NPC interaction, item counting (`CountItem`, `MoveItem`)
- [Scripts/LIB/Item.lua](Scripts/LIB/Item.lua): Item usage helpers (`UseByIndex`, `UseByName`, `UseByList`), manages `tbListItem`
- [Scripts/00_config.lua](Scripts/00_config.lua): Runtime toggles + `tbThuocTinh` baseline + inline `ThemSetDoByType` examples
- [Scripts/LIB/setdo](Scripts/LIB/setdo): Equipment attribute sets (10 files: `vukhi.lua`, `ao.lua`, `non.lua`, etc.)

## Debugging & Testing
- Set `gl_Debug=true` in config to enable verbose logging (`echo` calls in `clickMenu`, `hasMenu` timeouts, etc.)
- Use `writeThuocTinh()` in chung.lua to dump all inventory item attributes to `Scripts/option.txt` for threshold analysis
- Monitor `Scripts/reportFilter/*.txt`: Daily logs show item counts, VIP counts, timestamps per character ID
- If menus hang, check `gl_menuClickSpeed` (default 50ms); increase for slower clients, decrease for faster ones
- Network issues: Watch for `gl_InternetShit` flag; `ShopItem` will increase `gl_InternetDelay` automatically up to 3000ms

Need clarification? Ask about specific workflows (chest handling, five-element filtering, menu orchestration) or patterns (dynamic throttling, set matching logic).
