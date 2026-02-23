dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

local new_actions = {
    {
		id = "REAPER_ENGINE", --very wip
		name = "$action_immeng_reaper_engine",
		description = "$actiondesc_immeng_reaper_engine",
		sprite = "mods/immortal_engines/files/spells/reaper_engine/icon.png",
		custom_xml_file = "mods/immortal_engines/files/spells/reaper_engine/card.xml",
        related_extra_entities = { "mods/immortal_engines/files/spells/reaper_engine/reap_hit.xml" },
		type = ACTION_TYPE_OTHER,
		spawn_level = "10",
		spawn_probability = "0",
		price = 100,
		mana = 0,
        max_uses = 300,
        uses_remaining = 1,
        custom_uses_logic = true,
		ai_never_uses = true,
		action = function()
            if not reflecting then
                local soul_amt = GetSoul()
                if soul_amt >= 0 then
                    local mana_cost = 0
                    for i=1,#deck do
                        local card = deck[i]
                        if card.immeng_mana_original == nil then
                            card.immeng_mana_original = card.mana
                        end
                        mana_cost = mana_cost + card.immeng_mana_original
                        if soul_amt >= mana_cost / 60 then
                            card.mana = 0
                        end
                    end
                    local soul_cost = mana_cost / 60
                    RemoveSoul(soul_cost)
                    c.extra_entities = c.extra_entities .. "mods/immortal_engines/files/spells/reaper_engine/reap_hit.xml,"
                end
            end
			draw_actions(1, true)
		end,
	},
}

local actions_to_insert = {}

local action_ids_in_order = {
    "REAPER_ENGINE",
}

for i,id in ipairs(action_ids_in_order) do
	for ii=1,#new_actions do
		local action = new_actions[ii]
		if action.id == id then
			table.insert(actions_to_insert, action)
		end
	end
end

for i,action in ipairs(actions_to_insert) do
	action.id = "IMMENG_" .. action.id
	table.insert(actions, action)
end