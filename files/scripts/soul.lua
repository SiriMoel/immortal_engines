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
    local parent = EntityGetParent(contraption)
    if parent == contraption or parent == nil or not EntityGetIsAlive(parent) then
        local x, y = EntityGetTransform(contraption)
        local targets = EntityGetInRadiusWithTag(x, y, 150, "immeng_contraption")
        if #targets > 0 then
            for _,target in ipairs(targets) do
                if EntityHasTag(EntityGetRootEntity(target), "immeng_reservoir") then
                    local target_x, target_y = EntityGetTransform(target)
                    if math.abs(target_y - y) < 60 then
                        EntityAddChild(target, contraption)
                        GamePrint("Connected!")
                        break
                    end
                end
            end
        end
    end
    if parent ~= nil and parent ~= contraption then
        local x, y = EntityGetTransform(contraption)
        local x_dos, y_dos = EntityGetTransform(parent)
        local dist_x = x_dos - x
        local dist_y = y_dos - y
        local step_count = 21
        --local steps = math.abs(math.ceil(dist_x / 6))
        local mat = "spark_blue"
        if GetSystemSoul(contraption) <= 0 then
            mat = "spark_red"
        end
        for i=1,step_count do
            GameCreateCosmeticParticle(mat, x + (dist_x / step_count) * i, y + (dist_y / step_count) * i, 10, -10 * math.sin(i), 30 * math.sin(i), nil, 0.1, 0.2)
        end
    end
end

function GetSystemSoul(contraption)
    local root = EntityGetRootEntity(contraption)
    if EntityHasTag(root, "immeng_reservoir") then
        local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(root, "VariableStorageComponent", "immeng_soul_amt")
        if comp_soul_amt ~= nil then
            return ComponentGetValue2(comp_soul_amt, "value_float")
        end
    end
    return 0
end

function AddSoulToSystem(contraption, amt)
    local root = EntityGetRootEntity(contraption)
    if EntityHasTag(root, "immeng_reservoir") then
        local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(root, "VariableStorageComponent", "immeng_soul_amt")
        if comp_soul_amt ~= nil then
            local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
            soul_amt = soul_amt + amt
            ComponentSetValue2(comp_soul_amt, "value_float", soul_amt)
        end
    end
end