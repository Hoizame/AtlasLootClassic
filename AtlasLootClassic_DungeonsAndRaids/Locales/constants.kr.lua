local AL = _G.AtlasLoot.GetLocales("koKR")

if not AL then return end

-- These localization strings are translated on Curseforge: https://www.curseforge.com/wow/addons/atlaslootclassic/localization
--@localization(locale="koKR", format="lua_additive_table", table-name="AL", handle-unlocalized="ignore", namespace="DungeonsAndRaids")@
if _G.AtlasLoot:GetGameVersion() < 2 then return end
--@localization(locale="koKR", format="lua_additive_table", table-name="AL", handle-unlocalized="ignore", namespace="DungeonsAndRaidsTBC")@