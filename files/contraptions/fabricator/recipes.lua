fabricator_recipes = {
    {
        id = "charger",
        name="Soul Charger", --unused
        desc="Charge engine spells with soul from your reservoir.", --unused
        input = {
            soul = 30,
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

            AddSoulToSystem(fabricator, -30)

            EntityLoad("mods/immortal_engines/files/contraptions/charger/deployer.xml", x, y - 10)
            GamePrint("Fabrication complete!")
        end,
        func_display_recipe = function(fabricator) 
            local x, y = EntityGetTransform(fabricator)

            -- last number in this function needs to align with how often contraption_update.lua is run
            GameCreateSpriteForXFrames("data/items_gfx/emerald_tablet.png", x, y-25, false, 0, 0, 1)
        end,
    },
    {
        id = "conduit",
        name="Soul Conduit", --unused
        desc="NYI", --unused
        input = {
            soul = 50,
        },
        func_do_recipe = function(fabricator)
            local x, y = EntityGetTransform(fabricator)

            AddSoulToSystem(fabricator, -50)

            EntityLoad("mods/immortal_engines/files/contraptions/conduit/deployer.xml", x, y - 10)
            GamePrint("Fabrication complete!")
        end,
        func_display_recipe = function(fabricator) 
            local x, y = EntityGetTransform(fabricator)
        end,
    },
    {
        id = "sludgemachine",
        name="Sludge Machine", --unused
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

            EntityLoad("mods/immortal_engines/files/contraptions/sludgemachine/deployer.xml", x, y - 10)
            GamePrint("Fabrication complete!")
        end,
        func_display_recipe = function(fabricator) 
            local x, y = EntityGetTransform(fabricator)

            -- last number in this function needs to align with how often contraption_update.lua is run
            GameCreateSpriteForXFrames("data/items_gfx/emerald_tablet.png", x, y-25, false, 0, 0, 1)
        end,
    },
    {
        id = "accelerator",
        name="Accelerator", --unused
        desc="NYI", --unused
        input = {
            soul = 60,
        },
        func_do_recipe = function(fabricator)
            local x, y = EntityGetTransform(fabricator)

            AddSoulToSystem(fabricator, -60)

            EntityLoad("mods/immortal_engines/files/contraptions/accelerator/deployer.xml", x, y - 10)
            GamePrint("Fabrication complete!")
        end,
        func_display_recipe = function(fabricator) 
            local x, y = EntityGetTransform(fabricator)
        end,
    },
}