QBCore = exports['qb-core']:GetCoreObject()

function GetItem(name, count, source)
    local src = source

    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.GetItemByName(name) ~= nil then
        if xPlayer.Functions.GetItemByName(name).amount >= count then
            return true
        else
            return false
        end
    else
        return false
    end
end

function AddItem(name, count, source)
    local src = source

    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddItem(name, count, nil, nil)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[name], "add", count)
end

function RemoveItem(name, count, source)
    local src = source

    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveItem(name, count, nil, nil)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[name], "remove", count)
end

RegisterNetEvent('mar_crafting:giveitems')
AddEventHandler('mar_crafting:giveitems', function(craftingType, craftingOption)
    local src = source
    local hasRequiredItems = true -- Assume true until proven otherwise
    local addedItems = {}         -- just a table to keep track of items we've already added to the player's inventory.
    local text = craftingOption.progressbar
    local time = craftingOption.duration

    --  Check if player has all required items for the item he will craft.
    for _, requiredItem in ipairs(craftingOption.requireditems) do
        local neededitem = requiredItem.name
        local neededitemcount = requiredItem.amount

        local inventoryItem = GetItem(neededitem, neededitemcount, src)
        if not inventoryItem then
            hasRequiredItems = false
            break -- No need to continue checking if we're missing an item, just stop here and notify the player
        end
    end

    if hasRequiredItems then
        lib.callback.await('mar_crafting:progress', src, text, time)
        -- Process crafting if all required items are present in the player's inventory.
        for _, requiredItem in ipairs(craftingOption.requireditems) do
            local neededitem = requiredItem.name
            local neededitemcount = requiredItem.amount
            --- debug prints
            if Config.Debug then
                print(neededitem)
                print(neededitemcount)
            end

            RemoveItem(neededitem, neededitemcount, src)
        end

        for _, itemname in ipairs(craftingOption.outputitems) do
            local itemtoadd = itemname.name
            local itemtoaddcount = itemname.amount
            --- debug prints
            if Config.Debug then
                print(itemtoadd)
                print(itemtoaddcount)
            end

            if not addedItems[itemtoadd] then
                AddItem(itemtoadd, itemtoaddcount, src)
                addedItems[itemtoadd] = true
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
