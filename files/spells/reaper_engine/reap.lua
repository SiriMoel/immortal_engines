dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local parent = EntityGetRootEntity(this)

if EntityHasTag(parent, "destruction_target") then
    AddSoul(1)
end 

EntityKill(this)