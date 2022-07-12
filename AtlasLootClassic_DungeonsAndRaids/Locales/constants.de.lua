local AL = _G.AtlasLoot.GetLocales("deDE")

if not AL then return end

-- These localization strings are translated on Curseforge: https://www.curseforge.com/wow/addons/atlaslootclassic/localization
--@localization(locale="deDE", format="lua_additive_table", table-name="AL", handle-unlocalized="ignore", namespace="DungeonsAndRaids")@
if _G.AtlasLoot:GetGameVersion() < AtlasLoot.BC_VERSION_NUM then return end
--@localization(locale="deDE", format="lua_additive_table", table-name="AL", handle-unlocalized="ignore", namespace="DungeonsAndRaidsTBC")@