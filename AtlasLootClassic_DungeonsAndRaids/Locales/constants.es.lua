local AL = _G.AtlasLoot.GetLocales("esES")

if not AL then return end

-- These localization strings are translated on Curseforge: https://www.curseforge.com/wow/addons/atlaslootclassic/localization
--@localization(locale="esES", format="lua_additive_table", table-name="AL", handle-unlocalized="comment", namespace="DungeonsAndRaids")@
if AtlasLoot:GameVersion_LT(AtlasLoot.BC_VERSION_NUM) then return end
--@localization(locale="esES", format="lua_additive_table", table-name="AL", handle-unlocalized="ignore", namespace="DungeonsAndRaidsTBC")@
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
--@localization(locale="esES", format="lua_additive_table", table-name="AL", handle-unlocalized="ignore", namespace="DungeonsAndRaidsWrath")@