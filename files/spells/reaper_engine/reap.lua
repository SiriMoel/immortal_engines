dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local parent = EntityGetRootEntity(this)

AddSoul(1)

EntityKill(this)