local PlayerData = {}


QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

local spawnedObjects = {}

RegisterNetEvent('mar_crafting:thecrafting')
AddEventHandler('mar_crafting:thecrafting', function()
    for name, craftingData in pairs(Config.Crafting) do
        for _, coords in pairs(craftingData.coords) do
            if craftingData.model then
                local object = CreateObject(craftingData.model, coords.x, coords.y, coords.z - 1, true, false, false)
                SetEntityHeading(object, coords.w)
                table.insert(spawnedObjects, object) --- this will store reference to the spawned objects

                if Config.Target == 'ox_target' then
                    exports.ox_target:addLocalEntity(object, {
                        icon = craftingData.icon,
                        label = craftingData.label,
                        groups = craftingData.jobs,
                        event = 'mar_crafting:menu',
                        onSelect = function()
                            TriggerEvent("mar_crafting:menu", name)
                        end,
                        distance = 1,
                    })
                elseif Config.Target == 'qb-target' then
                    exports['qb-target']:AddTargetEntity(object, {
                        options = {
                            {
                                num = 1,
                                icon = craftingData.icon,
                                label = craftingData.label,
                                targeticon = craftingData.icon,
                                item = craftingData.item,
                                action = function()
                                    TriggerEvent("mar_crafting:menu", name)
                                end,
                                job = craftingData.jobs,
                            }
                        },
                        distance = 1,
                    })
                end
            else
                if Config.Target == 'ox_target' then
                    exports.ox_target:addSphereZone({
                        coords = vector4(coords.x, coords.y, coords.z, coords.w),
                        radius = 1,
                        debug = true,
                        options = {
                            {
                                icon = craftingData.icon,
                                label = craftingData.label,
                                groups = craftingData.jobs,
                                event = 'mar_crafting:menu',
                                onSelect = function()
                                    TriggerEvent("mar_crafting:menu", name)
                                end,
                                distance = 1,
                            }
                        }
                    })
                elseif Config.Target == 'qb-target' then
                    exports['qb-target']:AddBoxZone('crafting' .. name, vector3(coords.x, coords.y, coords.z), 1.5, 1.6,
                        {
                            name = 'crafting' .. name,
                            heading = coords.w,
                            debugPoly = Config.Debug,
                            minZ = 19,
                            maxZ = 219,
                        }, {
                            options = {
                                {
                                    num = 1,
                                    icon = craftingData.icon,
                                    label = craftingData.label,
                                    targeticon = craftingData.icon,
                                    item = craftingData.item,
                                    action = function()
                                        TriggerEvent("mar_crafting:menu", name)
                                    end,
                                    job = craftingData.jobs,
                                }
                            },
                            distance = 2.5,
                        })
                end
            end
        end
    end
end)

RegisterNetEvent('mar_crafting:menu')
AddEventHandler('mar_crafting:menu', function(craftingType)
    local craftingData = Config.Crafting[craftingType]

    local Options = {}

    for _, craftingOption in ipairs(craftingData.items) do
        local option = {
            title = craftingOption.title,
            description = craftingOption.description,
            image = craftingOption.image,
            onSelect = function()
                TriggerServerEvent('mar_crafting:giveitems', craftingType, craftingOption)
            end,
        }

        table.insert(Options, option)
    end

    lib.registerContext({
        id = 'craftmenu',
        title = "Crafting Menu",
        options = Options,
    })
    lib.showContext('craftmenu')
end)

lib.callback.register('mar_crafting:progress', function(src, text, time)
    -- Disable inventory access for the kids that use duplication glitches. fk u kids.
    LocalPlayer.state:set("inv_busy", true, true)

    -- Display progress bar
    local success = lib.progressBar({
        label = src,
        duration = text,
        canCancel = false,
        useWhileDead = false,
        allowRagdoll = false,
        allowCuffed = false,

        disable = {
            move = true,
            combat = true,
            car = true,
        },

        anim = { --- this is the animation that will play while crafting. you can get list of animations here https://alexguirre.github.io/animations-list/ or https://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm
            -- dict = 'anim@amb@business@meth@meth_monitoring_cooking@cooking@',  -- i prefer using scenario instead of animation. but you can use animation if you want.
            -- clip = 'look_around_v8_cooker',
            scenario = 'PROP_HUMAN_BBQ', -- this is the scenario that will play while crafting. you can get list of scenarios here https://wiki.rage.mp/index.php?title=Scenarios
        },
    })

    -- Re-enable inventory access after progress bar completes or is canceled
    LocalPlayer.state:set("inv_busy", false, true)

    return success
end)




function despawnAllObjects() -- this will despawn all objects when the resource is stopped.
    for _, object in ipairs(spawnedObjects) do
        DeleteEntity(object)
    end
    spawnedObjects = {}
end

CreateThread(function()
    TriggerEvent('mar_crafting:thecrafting')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        despawnAllObjects()
    end
end)
