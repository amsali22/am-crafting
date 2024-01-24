Config = {}
Config.Target = "ox_target" -- you can use ox_target or qb-target (qb-target is not tested) but it will work XD.

Config.Debug = true         -- Enable debug mode will print some stuff on the console. (true = enable false = disable)

----** Crafting Config **----

--[[
    For inventory images i will add support later to use only item name and it will get the image
    For now you can use the path to the image in the qb-inventory. or your inventory. like this "https://cfx-nui-qb-inventory/html/images/burger.png"
    change the path to your inventory image path. on my case using qb-inventory its "https://cfx-nui-qb-inventory/html/images/burger.png"
    you can also use discord image links. like this "https://cdn.discordapp.com/attachments/123456789/123456789/burger.png" or else.
--]]

Config.Crafting = {

    ["bestburger"] = {                                                   --- Crafting table name (can be anything) just to identify the table.
        model = "prop_bbq_1",                                            --- bench model  jsut use this to get models https://gta-objects.xyz/objects or https://forge.plebmasters.de/objects/
        --jobs = { ["Burgershit"] = 0 },                                   --- Required jobs that can have access to the bench. (nil = everyone)
        label = 'lets make some burgirs',                                --- Target label its the text that will show when you target the crafting bench.
        icon = "fa fa-cutlery",                                          --- Target icon its the icon that will show when you target the crafting bench.
        coords = {                                                       -- Table Coords
            [1] = vector4(456.63, -1025.88, 28.45, 186.84),              --- coords of the bench it supports multiple coords.
        },
        items = {                                                        -- Items in the crafting table.
            {
                title = "small bourgir",                                 -- Title of the item.
                description = "1 bite bourgir",                          -- Description of the item. it can have the item requeriments.
                progressbar = "Making the smallest bourgir",             -- Progress bar text.
                image =
                "https://cfx-nui-qb-inventory/html/images/aluminum.png", --- image of the item. please read the comment on top.
                duration = 10000,                                        -- Duration to craft the item in ms.
                requireditems = {                                        -- Items required to craft.
                    { name = "copper", amount = 1 },                     -- you can add as many items as you want.
                },
                outputitems = {                                          -- Items that will be given after craft is done
                    { name = "aluminum", amount = 1 },                   -- you can add as many items as you want.
                },
            },
            {
                title = "big ass burger",                                -- Title of the item.
                description = "a lot of tomatoes",                       -- Description of the item.
                progressbar = "im not making this",                      -- Progress bar text.
                image =
                "https://cfx-nui-qb-inventory/html/images/aluminum.png", --- image of the item. please read the comment on top.
                duration = 10000,                                        -- Duration to craft the item in ms.
                requireditems = {                                        -- Items required to craft.
                    { name = "copper", amount = 75 },
                },
                outputitems = {                        -- Items that will be given after craft is done
                    { name = "aluminum", amount = 2 }, -- you can add as many items as you want.
                    { name = "aluminum", amount = 1 },
                },
            },

        },
    },

    --[[  you can add as many crafting tables as you want just copy and paste the table and change the name and items for your liking.
 ["notbestburgir"] = {                                                   --- Crafting table name (can be anything) just to identify the table.
        model = "prop_bbq_1",                                            --- bench model  jsut use this to get models https://gta-objects.xyz/objects or https://forge.plebmasters.de/objects/
        jobs = { ["burgershit"] = 0 },                                   --- Required jobs that can have access to the bench. (nil = everyone)
        label = 'lets make some burgirs',                                --- Target label its the text that will show when you target the crafting bench.
        icon = "fa fa-cutlery",                                          --- Target icon its the icon that will show when you target the crafting bench.
        coords = {                                                       -- Table Coords
            [1] = vector4(456.63, -1025.88, 28.45, 186.84),              --- coords of the bench it supports multiple coords.
            [2] = vector4(456.63, -1025.88, 28.45, 186.84),             --- coords of the bench it supports multiple coords.
        },
        items = {                                                        -- Items in the crafting table.
            {
                title = "small bourgir",                                 -- Title of the item.
                description = "1 bite bourgir",                          -- Description of the item. it can have the item requeriments.
                progressbar = "Making the smallest bourgir",             -- Progress bar text.
                image =
                "https://cfx-nui-qb-inventory/html/images/aluminum.png", --- image of the item. please read the comment on top.
                duration = 10000,                                        -- Duration to craft the item in ms.
                requireditems = {                                        -- Items required to craft.
                    { name = "copper", amount = 1 },                     -- you can add as many items as you want.
                },
                outputitems = {                        -- Items that will be given after craft is done
                    { name = "aluminum", amount = 1 }, -- you can add as many items as you want.
                },
            },
            {
                title = "Armour 75",                                     -- Title of the item.
                description = "75x Copper",                              -- Description of the item.
                progressbar = "Making armour 75",                        -- Progress bar text.
                image =
                "https://cfx-nui-qb-inventory/html/images/aluminum.png", --- image of the item. please read the comment on top.
                duration = 10000,                                        -- Duration to craft the item in ms.
                requireditems = {                                        -- Items required to craft.
                    { name = "copper", amount = 75 },
                },
                outputitems = {                        -- Items that will be given after craft is done
                    { name = "75armour", amount = 1 }, -- you can add as many items as you want.
                    { name = "75armour", amount = 1 },
                },
            },

        },
    },

]]

}
