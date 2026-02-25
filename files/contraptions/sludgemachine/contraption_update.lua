dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

ContraptionConnect(this)

--[[local comp_matinv = EntityGetFirstComponentIncludingDisabled(this, "MaterialInventoryComponent")
if comp_matinv ~= nil then
    local materials = ComponentGetValue2(comp_matinv, "count_per_material_type")
    GamePrint("hello!!! " .. materials[CellFactory_GetType("radioactive_liquid")])
end]]