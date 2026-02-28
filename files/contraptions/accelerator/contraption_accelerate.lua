dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

--ContraptionConnect(this)

if GetSystemSoul(this) > 0 then
    local targets = EntityGetInRadius(x+12, y-50, 60) or {}
    if #targets > 0 then
        local tags = {"player_unit", "tablet"}
        for i=1,#targets do
            local target = targets[i]
            if EntityGetRootEntity(target) == target then
                local check_success = false
                for ii=1,#tags do
                    if EntityHasTag(target, tags[ii]) then
                        check_success = true
                    end
                end
                if check_success then
                    local comp = EntityGetFirstComponent(target, "CharacterDataComponent")
                    if comp == nil then
                        comp = EntityGetFirstComponent(target, "VelocityComponent")
                    end
                    if comp ~= nil then
                        local vel_x, vel_y = ComponentGetValue2(comp, "mVelocity")
                        vel_x = vel_x * 10
                        vel_y = (vel_y - 40) * 1.1
                        ComponentSetValue2(comp, "mVelocity", vel_x, vel_y)
                        AddSoulToSystem(this, -0.5)
                    end
                end
            end
        end
    end
end