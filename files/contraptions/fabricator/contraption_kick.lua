dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

function kick()
    local this = GetUpdatedEntityID()

    local player = EntityGetWithTag("player_unit")[1]
    local px, py = EntityGetTransform(player)

    EntityLoad("mods/immortal_engines/files/contraptions/fabricator/deployer.xml", px, py - 4)

    EntityKill(this)
end