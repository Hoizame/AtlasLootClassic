# AtlasLootClassic

[![Build Status](https://github.com/Hoizame/AtlasLootClassic/workflows/CI/badge.svg)](https://github.com/Hoizame/AtlasLootClassic/actions?workflow=CI)[![AtlasLootClassic Discord](https://img.shields.io/badge/discord-atlaslootclassic-7289DA)](https://discord.gg/vMUwzPc)

AtlasLootClassic is an UI mod allowing for loot tables of bosses to be browsed whenever needed within the game.

> **This fork (branch `fix/2026-classic-era`) fixes the addon for WoW Classic Era / Hardcore patch 1.15.9 (July 2026)**, where the original stopped loading with `ClassFilter.lua:62: table index is nil`. The fixes have been submitted upstream as [PR #485](https://github.com/Hoizame/AtlasLootClassic/pull/485). All credit for the original addon goes to its authors.

## Download (fixed version)

* **[Latest release zip](https://github.com/scotjam/AtlasLootClassic/releases/latest)** (manual install, see below)
* [CurseForge: AtlasLoot Classic Era Aug 2026](https://www.curseforge.com/wow/addons/atlasloot-classic-era-aug-2026) (pending moderation)

## Manual install

1. Close World of Warcraft.
2. Download the zip from the [latest release](https://github.com/scotjam/AtlasLootClassic/releases/latest).
3. Delete any existing `AtlasLootClassic*` folders from `World of Warcraft\_classic_era_\Interface\AddOns\` (other AtlasLoot versions use the same folder names and will conflict). Your favourites and settings are stored in `WTF\` and are **not** affected.
4. Extract the zip and copy all **8** `AtlasLootClassic*` folders into `World of Warcraft\_classic_era_\Interface\AddOns\`.
5. Start the game - you should see 8 AtlasLootClassic entries in the AddOns list. Open the loot browser with `/al` or the minimap button.

## Original download links (broken on Era 1.15.9)

[Curseforge](https://www.curseforge.com/wow/addons/atlaslootclassic)

[WoWInterface](https://www.wowinterface.com/downloads/info25185-AtlasLootClassic.html)

[WagoAddons](https://addons.wago.io/addons/atlaslootclassic)

## Features

* Loottables for Dungeons and Raids
* Crafting with informations about materials, created items and skill ranks
* Factions
* Collections with item sets and world events
* Favourites are the new wishlist

## Options

* Open with `Shift + Left Click` on MiniMap Button or with `/al options`

## Favourites

* Add items directly from AtlasLoot with `Alt + Left Click`
* Add notes to favourite items with `Alt + Right Click`
* Setup global and profile based lists
* Show on item tooltip if the item is on any active list
* Import and export your lists
* A GUI that let you plan your gear and shows a indicator if you already own an item

![image](https://media.forgecdn.net/attachments/260/125/atlasloot-fav-gui.png)![image](https://media.forgecdn.net/attachments/260/931/atlasloot-fav-tt.png)

## Favourites import/export format

`(type):(id):(note)` while the `:(note)` part is optional

This currently only supports items and notes

`"i:16703:First item note,i:16704,i:16698:Second item note,i:16699,i:11287"`

## Maps

[Atlas Classic WoW](https://www.curseforge.com/wow/addons/atlas-classicwow)

[Atlas Burning Crusade](https://www.curseforge.com/wow/addons/atlas-burningcrusade)

[Atlas Wrath of the Lich King](https://www.curseforge.com/wow/addons/atlas-wrathofthelichking)
