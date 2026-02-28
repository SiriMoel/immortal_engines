local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local player = EntityGetInRadiusWithTag(x, y, 20, "player_unit")[1]

if player ~= nil then
    local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
    if comp_controls ~= nil then
        if ComponentGetValue2(comp_controls, "mButtonDownKick") == true then
            local contraptions = EntityGetAllChildren(this, "immeng_contraption") or {}
            if #contraptions > 0 then
                for i,v in ipairs(contraptions) do
                    EntityRemoveFromParent(v)
                end
            end
            local px, py = EntityGetTransform(player)
            EntityLoad("mods/immortal_engines/files/contraptions/charger/deployer.xml", x, y+4)
            EntityKill(this)
        end
    end
end