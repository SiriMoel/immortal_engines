GameRegenItemActionsInPlayer_original = GameRegenItemActionsInPlayer
function GameRegenItemActionsInPlayer(entity_id) 
	GameRegenItemActionsInPlayer_original(entity_id)
	local engines = EntityGetWithTag("immeng_soul_engine")
	for i,v in ipairs(engines) do
		local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(v, "VariableStorageComponent", "immeng_soul_amt")
		local comp_item = EntityGetFirstComponentIncludingDisabled(v, "ItemComponent")
        if comp_soul_amt ~= nil and comp_item ~= nil then
			local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
            ComponentSetValue2(comp_item, "uses_remaining", math.max(math.ceil(soul_amt), 1))
		end
	end
end