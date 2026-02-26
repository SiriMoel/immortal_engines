dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

dofile_once("mods/immortal_engines/files/contraptions/fabricator/recipes.lua")

function interacting()
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local soul = GetSystemSoul(this)

    if soul > 0 then
        local comp_recipe = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "immeng_fabricator_selected_recipe")
        if comp_recipe ~= nil then
            local recipe = fabricator_recipes[ComponentGetValue2(comp_recipe, "value_int")]
            if recipe ~= nil then
                if soul > (recipe.input.soul or 0) then
                    local success = true

                    if recipe.input.entities_with_tag ~= nil then
                        for i=1,#recipe.input.entities_with_tag do
                            local v = recipe.input.entities_with_tag[i]
                            local targets = EntityGetInRadiusWithTag(x, y, 40, v.tag) or {}
                            if #targets < (v.count or 1) then
                                success = false
                                break
                            end
                        end
                    end

                    if success then
                        recipe.func_do_recipe(this)
                        --GameTriggerMusicFadeOutAndDequeueAll(3.0) --from hiisi anvil
	                    GameTriggerMusicEvent("music/oneshot/dark_01", true, x, y) --from hiisi anvil
                    end
                end
            end
        end
    end
end