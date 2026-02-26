fabricator_recipes = {
    {
        id = "charger",
        name="Soul Charger", --unused
        desc="Charge engine spells with soul from your reservoir.", --unused
        input = {
            soul = 50,
            entities_with_tag = {
                {
                    tag = "tablet",
                    count = 1,
                },
            },
        },
        func_do_recipe = function(fabricator)
            local x, y = EntityGetTransform(fabricator)

            local tablet = EntityGetInRadiusWithTag(x, y, 40, "tablet")[1]
            EntityKill(tablet)

            AddSoulToSystem(fabricator, -50)

            EntityLoad("mods/immortal_engines/files/contraptions/charger/deployer.xml", x, y - 10)
            GamePrint("Fabrication complete!")
        end,
        func_display_recipe = function(fabricator) 
            local x, y = EntityGetTransform(fabricator)

            -- last number in this function needs to align with how often contraption_update.lua is run
            GameCreateSpriteForXFrames("data/items_gfx/emerald_tablet.png", x, y-25, false, 0, 0, 1)
        end,
    },
}