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
                        ComponentSetValue2(comp_item, "uses_remaining", math.ceil(soul_amt))
                        if soul_amt > 0 then
                            GamePrint("Soul: " .. soul_amt) --temporary
                        end
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
                        if soul_amt > 0 then
                            GamePrint("Soul: " .. soul_amt) --temporary
                        end
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