RegisterNetEvent('mar_crafting:giveitems')
AddEventHandler('mar_crafting:giveitems', function(craftingType, craftingOption)
    local src = source
    local hasRequiredItems = true -- Assume true until proven otherwise
    local addedItems = {}         -- just a table to keep track of items we've already added to the player's inventory.
    local text = craftingOption.progressbar
    local time = craftingOption.duration

    --  Check if player has all required items for the item he will craft.
    for _, requiredItem in ipairs(craftingOption.requireditems) do
        local needitem = requiredItem.name
        local needitemcount = requiredItem.amount

        local inventoryItem = GetItem(needitem, needitemcount, src)
        if not inventoryItem then
            hasRequiredItems = false
            break -- No need to continue checking if we're missing an item, just stop here and notify the player
        end
    end

    if hasRequiredItems then
        lib.callback.await('mar_crafting:progress', src, text, time)
        -- Process crafting if all required items are present in the player's inventory.
        for _, requiredItem in ipairs(craftingOption.requireditems) do
            local needitem = requiredItem.name
            local needitemcount = requiredItem.amount

            if Config.EnableDebug then
                print(needitem)
                print(needitemcount)
            end

            RemoveItem(needitem, needitemcount, src)
        end

        for _, itemname in ipairs(craftingOption.outputitems) do
            local additem = itemname.name
            local additemcount = itemname.amount

            if Config.EnableDebug then
                print(additem)
                print(additemcount)
            end

            if not addedItems[additem] then
                AddItem(additem, additemcount, src)
                addedItems[additem] = true
            end
        end
    else
        lib.notify(src, {
            title = "Crafting",
            description = "You don't have the required items to craft this item.",
            type = 'error'
        })
    end
end)
