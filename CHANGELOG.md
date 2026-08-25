# AtlasLootClassic

This mod is distributed under Version 2 of the GPL.  A copy of the GPL is included in this zip file with links to non-english translations.

[Changelog history](https://github.com/Hoizame/AtlasLootClassic/blob/master/AtlasLootClassic/Documentation/Release_Notes.md)

## v3.2.1 (Aug. 24, 2026)

- Fix addon not loading on Classic Era 1.15.9 / TBC Anniversary 2.5.6: `Data/ClassFilter.lua:62: table index is nil` (issues #481, #483). The `LE_ITEM_*` / `LE_EXPANSION_*` globals were removed from the client; new `Compat.lua` maps them from `Enum.*` and polyfills removed item/spell/addon API globals via `C_Item` / `C_Spell` / `C_AddOns`.
- Fix Favourites window error `Couldn't find inherited node "OptionsCheckButtonTemplate"` (issues #458, #472) - use `UICheckButtonTemplate`.
- Fix `bad argument #1 to 'SetJustifyV'` in faction tooltips and sound frame (issue #472) - `"CENTER"` -> `"MIDDLE"`.
- Update .toc Interface versions: Vanilla 11509, TBC 20506.

## v3.2.0 (Oct. 22, 2023)

- update .toc version
- fix lua error with companions
- Hallow's End update PR #416
- Fix epic blue gem id, add Ashen Verdict engineering PR #413
- Add Defiler Scourgestone Vendor
- Update Dalaran Vendor
- #397, #388 Update to use new Mount API
- #396 Added "Maiden of Grief" Missing items in Titan Rune Beta - Halls of Stone
- #395 Fixed "King Dred" Wrong loot in Titan Rune Beta - Drak'Tharon Keep
- #394 Fixed "The Prophet Tharon'ja" Wrong loot in Titan Rune Beta - Drak'Tharon Keep
- #393 Added Missing Leatherworking Fur Linings
- #391 Added Enchanting Cloak Resistances (Arcane, Fire, Frost, Nature, Shadow), Removed Duplicates
- #387 Fixed Incorrect Set Links for Death Knight Season 7 PvP Set
- #381 Added "Six Shared Loot Bosses" Missing items in Titan Rune Beta - Violet Hold
