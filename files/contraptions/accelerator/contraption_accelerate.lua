dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

--ContraptionConnect(this)

if GetSystemSoul(this) > 0 then
    local targets = EntityGetInRadius(x+12, y-50, 60) or {}
    if #targets > 0 then
        local tags = {"player_unit", "tablet", "projectile"} --tablets don't seem to be accelerated
        for i=1,#targets do
            local target = targets[i]
            if EntityGetRootEntity(target) == target then
                local check_success = false
                local is_proj = false
                for ii=1,#tags do
                    if EntityHasTag(target, tags[ii]) then
                        check_success = true
                        if ii == 3 then
                            is_proj = true
                        end
                    end
                end
                if check_success then
                    local soul_consumed = 0.0
                    local comp = EntityGetFirstComponent(target, "CharacterDataComponent")
                    if comp == nil then
                        comp = EntityGetFirstComponent(target, "VelocityComponent")
                    end
                    if comp ~= nil then
                        local vel_x, vel_y = ComponentGetValue2(comp, "mVelocity")
                        vel_x = vel_x * 10
                        vel_y = (vel_y - 40) * 1.1
                        ComponentSetValue2(comp, "mVelocity", vel_x, vel_y)
                        soul_consumed = soul_consumed + 0.5
                    end
                    if is_proj then
                        local comp_proj = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent")
                        if comp_proj ~= nil then
                            local damage = ComponentGetValue2(comp_proj, "damage")
                            damage = damage + math.max(damage * 0.1, 0.2)
                            ComponentSetValue2(comp_proj, "damage", damage)
                            soul_consumed = soul_consumed + 0.5
                        end
                    end
                    AddSoulToSystem(this, -soul_consumed)
                end
            end
        end
    end
end