dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

ContraptionConnect(this)

if GetSystemSoul(this) > 0 then
    local engines = EntityGetInRadiusWithTag(x, y, 60, "immeng_soul_engine")
    if #engines > 0 then
        for _,engine in ipairs(engines) do
            local engine_x, engine_y = EntityGetTransform(engine)
            if engine_y <= y and EntityGetRootEntity(engine) == engine then
                local engine_comp_soul_amt = EntityGetFirstComponentIncludingDisabled(engine, "VariableStorageComponent", "immeng_soul_amt")
                local engine_soul_amt = ComponentGetValue2(engine_comp_soul_amt, "value_float")
                local engine_comp_soul_cap = EntityGetFirstComponentIncludingDisabled(engine, "VariableStorageComponent", "immeng_soul_cap")
                local cap = -1
                if engine_comp_soul_cap ~= nil then
                    cap = ComponentGetValue2(engine_comp_soul_cap, "value_float")
                end
                local soul_amt = GetSystemSoul(this)
                if soul_amt > 0 and ((cap ~= -1 and engine_soul_amt < cap) or (cap == -1)) then
                    local transfer_amt = math.min(soul_amt, math.min(cap - engine_soul_amt, 3))
                    AddSoulToSystem(this, -transfer_amt)
                    ComponentSetValue2(engine_comp_soul_amt, "value_float", engine_soul_amt + transfer_amt)
                    local engine_comp_item = EntityGetFirstComponentIncludingDisabled(engine, "ItemComponent")
                    if engine_comp_item ~= nil then
                        ComponentSetValue2(engine_comp_item, "uses_remaining", math.max(math.ceil(engine_soul_amt + transfer_amt), 1))
                    end
                end
            end
        end
    end
end