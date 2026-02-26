dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

dofile_once("mods/immortal_engines/files/contraptions/fabricator/recipes.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

ContraptionConnect(this)