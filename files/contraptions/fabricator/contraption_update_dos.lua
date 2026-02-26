dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

dofile_once("mods/immortal_engines/files/contraptions/fabricator/recipes.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

--ContraptionConnect(this)

local soul = GetSystemSoul(this)

local player = EntityGetInRadiusWithTag(x, y, 40, "player_unit")[1]

if soul > 0 and player ~= nil then
    local comp_recipe = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "immeng_fabricator_selected_recipe")
    if comp_recipe ~= nil then
        local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
        local selected_recipe = ComponentGetValue2(comp_recipe, "value_int")
        if ComponentGetValue2(comp_controls, "mButtonDownChangeItemR") == true then
            if fabricator_recipes[selected_recipe + 1] ~= nil then
                selected_recipe = selected_recipe + 1
                ComponentSetValue2(comp_recipe, "value_int", selected_recipe)
            end
        end
        if ComponentGetValue2(comp_controls, "mButtonDownChangeItemL") == true then
            if fabricator_recipes[selected_recipe - 1] ~= nil then
                selected_recipe = selected_recipe - 1
                ComponentSetValue2(comp_recipe, "value_int", selected_recipe)
            end
        end
        local recipe = fabricator_recipes[selected_recipe]
        if recipe ~= nil then
            if recipe.func_display_recipe ~= nil then
                recipe.func_display_recipe(this)
            end
            local comp_item_cost = EntityGetFirstComponentIncludingDisabled(this, "ItemCostComponent")
            ComponentSetValue2(comp_item_cost, "cost", recipe.input.soul or 0)
        end
    end
end