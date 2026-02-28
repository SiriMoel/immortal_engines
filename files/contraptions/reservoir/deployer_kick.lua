dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

function kick()
    local this = GetUpdatedEntityID()

    if EntityGetRootEntity(this) == this then
        local player = EntityGetWithTag("player_unit")[1]
        local px, py = EntityGetTransform(player)

        if #EntityGetInRadiusWithTag(px, py - 50, 80, "immeng_contraption") > 0 then
            GamePrint("Too close to another contraption.")
        else
            EntityLoad("mods/immortal_engines/files/contraptions/reservoir/contraption.xml", math.floor(px), math.floor(py - 50))
            EntityKill(this)
        end
    end
end