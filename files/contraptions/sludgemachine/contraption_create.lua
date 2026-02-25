dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

EntityAddComponent(this, "VariableStorageComponent", {
    _tags="immeng_system_id",
    name="immeng_system_id",
    value_string="-1"
})

ContraptionConnect(this)