dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local system_id = tonumber(GlobalsGetValue("immeng_system_id_upto", "0")) + 1

EntityAddComponent(this, "VariableStorageComponent", {
    _tags="immeng_system_id",
    name="immeng_system_id",
    value_string=tostring(system_id)
})

EntityAddTag(this, "immeng_system_id_" .. system_id)

GlobalsSetValue("immeng_system_id_upto", tostring(system_id))