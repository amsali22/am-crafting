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
