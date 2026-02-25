dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "immeng_soul_amt")

local engines = EntityGetInRadiusWithTag(x, y, 60, "immeng_soul_engine")

if #engines > 0 then
    for _,engine in ipairs(engines) do
        local engine_x, engine_y = EntityGetTransform(engine)
        if engine_y < y and EntityGetRootEntity(engine) == engine then
            local engine_comp_soul_amt = EntityGetFirstComponentIncludingDisabled(engine, "VariableStorageComponent", "immeng_soul_amt")
            local engine_soul_amt = ComponentGetValue2(engine_comp_soul_amt, "value_float")
            if engine_soul_amt > 0 then
                local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
                local transfer_amt = math.min(engine_soul_amt, 5)
                ComponentSetValue2(comp_soul_amt, "value_float", soul_amt + transfer_amt)
                ComponentSetValue2(engine_comp_soul_amt, "value_float", engine_soul_amt - transfer_amt)
                local engine_comp_item = EntityGetFirstComponentIncludingDisabled(engine, "ItemComponent")
                if engine_comp_item ~= nil then
                    ComponentSetValue2(engine_comp_item, "uses_remaining", math.max(math.ceil(engine_soul_amt - transfer_amt), 1))
                end
            end
        end
    end
end

local comp_item_cost = EntityGetFirstComponentIncludingDisabled(this, "ItemCostComponent")
ComponentSetValue2(comp_item_cost, "cost", ComponentGetValue2(comp_soul_amt, "value_float"))