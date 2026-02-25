dofile_once("mods/immortal_engines/files/scripts/utils.lua")

function AddSoul(amt)
    local player = EntityGetWithTag("player_unit")[1]

    local wand
	local inv_comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	if inv_comp then
		wand = ComponentGetValue2(inv_comp, "mActiveItem")
	end

    if wand ~= nil and EntityHasTag(wand, "wand") then
        local children = EntityGetAllChildren(wand, "card_action")
        for i=1,#children do
            if amt > 0 then
                local child = children[i]
                local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(child, "VariableStorageComponent", "immeng_soul_amt")
                local comp_soul_cap = EntityGetFirstComponentIncludingDisabled(child, "VariableStorageComponent", "immeng_soul_cap")
                if comp_soul_amt ~= nil then
                    local max_soul = ComponentGetValue2(comp_soul_cap, "value_float")
                    local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
                    soul_amt = soul_amt + amt
                    if soul_amt > max_soul then
                        amt = soul_amt - max_soul
                        soul_amt = max_soul
                    else
                        amt = 0
                    end
                    ComponentSetValue2(comp_soul_amt, "value_float", soul_amt)
                    local comp_item = EntityGetFirstComponentIncludingDisabled(child, "ItemComponent")
                    if comp_item ~= nil then
                        ComponentSetValue2(comp_item, "uses_remaining", math.max(math.ceil(soul_amt), 1))
                        --[[if soul_amt > 0 then
                            GamePrint("Soul: " .. soul_amt) --temporary
                        end]]
                    end
                end
            end
        end
    end
end

function RemoveSoul(amt)
    local player = EntityGetWithTag("player_unit")[1]

    local wand
	local inv_comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	if inv_comp then
		wand = ComponentGetValue2(inv_comp, "mActiveItem")
	end

    if wand ~= nil and EntityHasTag(wand, "wand") then
        local children = EntityGetAllChildren(wand, "card_action")
        for i=1,#children do
            if amt > 0 then
                local child = children[i]
                local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(child, "VariableStorageComponent", "immeng_soul_amt")
                if comp_soul_amt ~= nil then
                    local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
                    soul_amt = math.max(soul_amt - amt, 0)
                    ComponentSetValue2(comp_soul_amt, "value_float", soul_amt)
                    local comp_item = EntityGetFirstComponentIncludingDisabled(child, "ItemComponent")
                    if comp_item ~= nil then
                        ComponentSetValue2(comp_item, "uses_remaining", math.max(1, math.ceil(soul_amt)))
                        --[[if soul_amt > 0 then
                            GamePrint("Soul: " .. soul_amt) --temporary
                        end]]
                    end
                end
            end
        end
    end
end

function GetSoul()
    local player = EntityGetWithTag("player_unit")[1]

    local wand
	local inv_comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	if inv_comp then
		wand = ComponentGetValue2(inv_comp, "mActiveItem")
	end

    if wand ~= nil and EntityHasTag(wand, "wand") then
        local children = EntityGetAllChildren(wand, "card_action")
        for i=1,#children do
            local child = children[i]
            local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(child, "VariableStorageComponent", "immeng_soul_amt")
            if comp_soul_amt ~= nil then
                local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
                return soul_amt
            end
        end
    end
end

function ContraptionConnect(contraption)
    local comp_system_id = EntityGetFirstComponentIncludingDisabled(contraption, "VariableStorageComponent", "immeng_system_id")
    if comp_system_id == nil then
        comp_system_id = EntityAddComponent(contraption, "VariableStorageComponent", {
            _tags="immeng_system_id",
            name="immeng_system_id",
            value_string="-1"
        })
    end
    local system_id = tonumber(ComponentGetValue2(comp_system_id, "value_string"))
    --[[if system_id ~= -1 and not EntityGetIsAlive(system_id) then
        system_id = -1
        ComponentSetValue2(comp_system_id, "value_string", "-1")
    end]]
    if system_id == -1 then
        local x, y = EntityGetTransform(contraption)
        local targets = EntityGetInRadiusWithTag(x, y, 300, "immeng_contraption")
        if #targets > 0 then
            for _,target in ipairs(targets) do
                local target_x, target_y = EntityGetTransform(target)
                if math.abs(target_y - y) < 60 then
                    local target_comp_system_id = EntityGetFirstComponentIncludingDisabled(target, "VariableStorageComponent", "immeng_system_id")
                    if target_comp_system_id ~= nil then
                        local target_system_id = tonumber(ComponentGetValue2(target_comp_system_id, "value_string"))
                        if target_system_id ~= -1 then
                            ComponentSetValue2(comp_system_id, "value_string", tostring(target_system_id))
                            GamePrint("Connected!")
                            break
                        end
                    end
                end
            end
        else
            ComponentSetValue2(comp_system_id, "value_string", "-1")
        end
    else
        local x, y = EntityGetTransform(contraption)
        local contraptions = EntityGetInRadiusWithTag(x, y, 300, "immeng_contraption")
        if #contraptions >= 2 then
            local closest = EntityGetClosestWithTag(x, y, "immeng_contraption")
            local which = 1
            for i=1,#contraptions do
                if contraptions[i] ~= closest then
                    which = i
                    break
                end
            end
            local x_dos, y_dos = EntityGetTransform(contraptions[which])
            local dist_x = x_dos - x
            local dist_y = y_dos - y
            local step_count = 7
            --local steps = math.abs(math.ceil(dist_x / 6))
            for i=1,step_count do
                GameCreateCosmeticParticle("spark_blue", x + (dist_x / step_count) * i, y + (dist_y / step_count) * i, 10, -10 * math.sin(i), 30 * math.sin(i), nil, 0.2, 0.4)
            end
        end
    end
end

function GetSystemSoul(contraption)
    local comp_system_id = EntityGetFirstComponentIncludingDisabled(contraption, "VariableStorageComponent", "immeng_system_id")
    if comp_system_id ~= nil then
        local system_id = tonumber(ComponentGetValue2(comp_system_id, "value_string"))
        if system_id ~= -1 then
            local system_entity = EntityGetWithTag("immeng_system_id_" .. system_id)[1]
            local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(system_entity, "VariableStorageComponent", "immeng_soul_amt")
            if comp_soul_amt ~= nil then
                return ComponentGetValue2(comp_soul_amt, "value_float")
            end
        end
    end
    return 0
end

function AddSoulToSystem(contraption, amt)
    local comp_system_id = EntityGetFirstComponentIncludingDisabled(contraption, "VariableStorageComponent", "immeng_system_id")
    if comp_system_id ~= nil then
        local system_id = tonumber(ComponentGetValue2(comp_system_id, "value_string"))
        if system_id ~= -1 then
            local system_entity = EntityGetWithTag("immeng_system_id_" .. system_id)[1]
            local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(system_entity, "VariableStorageComponent", "immeng_soul_amt")
            if comp_soul_amt ~= nil then
                local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
                soul_amt = soul_amt + amt
                ComponentSetValue2(comp_soul_amt, "value_float", soul_amt)
            end
        end
    end
end