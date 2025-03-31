function OpenStash(stashName, owner)
    if Config.Core == "QBCore" and Config.Inventory ~= "ox" then
        if not Config.NewQBInventory then
            local other = {
                maxweight = 1000000,
                slots = 100,
            }
            TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, other)
            TriggerEvent("inventory:client:SetCurrentStash", stashName)
        else
            TriggerServerEvent("snipe-menu:server:OpenInventoryQBCompatibility", "stash", stashName)
        end
    elseif Config.Core == "ESX" and Config.Inventory == "qs" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
            maxweight = 1000000,
            slots = 100,
        })
        TriggerEvent("inventory:client:SetCurrentStash", stashName)
    elseif Config.Inventory == "ox" then
        if owner ~= "" then
            if not exports.ox_inventory:openInventory('stash', { id = stashName, owner = owner }) then
                TriggerServerEvent("snipe-menu:server:registerStash", stashName)
                exports.ox_inventory:openInventory('stash', { id = stashName, owner = owner })
            end
        else
            if not exports.ox_inventory:openInventory('stash', stashName) then
                TriggerServerEvent("snipe-menu:server:registerStash", stashName)
                exports.ox_inventory:openInventory('stash', stashName)
            end
        end
            -- exports.ox_inventory:openInventory('stash', stashName)
    elseif Config.Inventory == "qsv2" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
            maxweight = 1000000,
            slots = 100,
        })
        TriggerEvent("inventory:client:SetCurrentStash", stashName)
    elseif Config.Inventory == "chezza" then
        TriggerEvent('inventory:openInventory', {
            type = "stash", -- "type" in database
            id = stashName, -- "identifier" in database
            title = "Stash", 
            weight = 1000000, -- set to false for no weight,
            delay = 100,
            save = true -- save to database true or false
        })
    else
        print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' or qsv2 in config.lua")
    end
end

function OpenTrunk(vehicle, plate)
    if Config.Core == "QBCore" and Config.Inventory ~= "ox" then

        if not Config.NewQBInventory then
            local other = {
                maxweight = 120000,
                slots = 50,
            }
            TriggerServerEvent("inventory:server:OpenInventory", "trunk", plate, other)
            TriggerEvent("inventory:client:SetCurrentTrunk", plate)
        else
            TriggerServerEvent("snipe-menu:server:OpenInventoryQBCompatibility", "stash", "trunk-"..plate)
        end
        
    elseif Config.Core == "ESX" and Config.Inventory == "qs" then
        local other = {
            maxweight = 120000,
            slots = 50,
        }
        TriggerServerEvent("inventory:server:OpenInventory", "trunk", plate, other)
        TriggerEvent("inventory:client:SetCurrentTrunk", plate)
    elseif Config.Inventory == "ox" then
        -- doesnt work. need to fix (panel has been manually disabled for ox users)
        -- exports.ox_inventory:openInventory('trunk', {id='trunk'..plate})
        TriggerServerEvent("snipe-menu:server:forceOpenOxInventory", "trunk", {type = "trunk", id='trunk'..plate})
    elseif Config.Inventory == "qsv2" then
        local other = {
            maxweight = 120000,
            slots = 50,
        }
        TriggerServerEvent("inventory:server:OpenInventory", "trunk", plate, other)
        TriggerEvent("inventory:client:SetCurrentTrunk", plate)
    elseif Config.Inventory == "chezza" then
        TriggerEvent('inventory:openTrunkGlovebox', 'trunk', plate, 100)
    else
        print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' or qsv2 in config.lua")
    end
    
end

function OpenGlovebox(plate)
    if hasAdminPerms then
        if Config.Core == "QBCore" and Config.Inventory ~= "ox" then
            
            if not Config.NewQBInventory then
                local other = {
                    maxweight = 120000,
                    slots = 50,
                }
                TriggerServerEvent("inventory:server:OpenInventory", "glovebox", plate, other)
                TriggerEvent("inventory:client:SetCurrentGlovebox", plate)
            else
                TriggerServerEvent("snipe-menu:server:OpenInventoryQBCompatibility", "stash", "glovebox-"..plate)
            end
        elseif Config.Core == "ESX" and Config.Inventory == "qs" then
                TriggerServerEvent("inventory:server:OpenInventory", "glovebox", plate, other)
                TriggerEvent("inventory:client:SetCurrentGlovebox", plate)
        elseif Config.Inventory == "ox" then
                -- doesnt work. need to fix (panel has been manually disabled for ox users)
            -- exports.ox_inventory:openInventory('glovebox', {id='glove'..plate})
            TriggerServerEvent("snipe-menu:server:forceOpenOxInventory", "glovebox", {type = "glovebox", id='glove'..plate})
        elseif Config.Inventory == "qsv2" then
            TriggerServerEvent("inventory:server:OpenInventory", "glovebox", plate, other)
            TriggerEvent("inventory:client:SetCurrentGlovebox", plate)
        elseif Config.Inventory == "chezza" then
            TriggerEvent('inventory:openTrunkGlovebox', 'glovebox', plate, 10)
        else
            print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' or qsv2 in config.lua")
        end
    end
end

function openJobStash(data)
    if Config.Core == "QBCore" and Config.Inventory ~= "ox" then
        if not Config.NewQBInventory then
            local other = {
                maxweight = data.size,
                slots = data.slots,
            }
            TriggerServerEvent("inventory:server:OpenInventory", "stash", data.jobStashName, other)
            TriggerEvent("inventory:client:SetCurrentStash", data.jobStashName)
        else
            TriggerServerEvent("snipe-menu:server:OpenInventoryQBCompatibility", "stash", data.jobStashName, {maxweight = data.size, slots = data.slots})
        end
    elseif Config.Core == "ESX" and Config.Inventory == "qs" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", data.jobStashName, {
            maxweight = data.size,
            slots = data.slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", data.jobStashName)
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:openInventory('stash', data.jobStashName)
    elseif Config.Inventory == "qsv2" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", data.jobStashName, {
            maxweight = data.size,
            slots = data.slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", data.jobStashName)
    elseif Config.Inventory == "chezza" then
        TriggerEvent('inventory:openInventory', {
            type = "stash", -- "type" in database
            id = data.jobStashName, -- "identifier" in database
            title = "Stash", 
            weight = data.size, -- set to false for no weight,
            delay = 100,
            save = true -- save to database true or false
        })
    else
        print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' or qsv2 in config.lua")
    end
end


RegisterNetEvent("snipe-menu:client:openinventory", function(otherPlayer)
    if hasAdminPerms then
        if Config.Core == "QBCore" and Config.Inventory ~= "ox" then
            if not Config.NewQBInventory then
                local other = {
                    maxweight = 1000000,
                    slots = 100,
                }
                TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", otherPlayer)
            else
                TriggerServerEvent("snipe-menu:server:OpenInventoryQBCompatibility", "player", otherPlayer)
            end
            
        elseif Config.Core == "ESX" and Config.Inventory == "qs" then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", otherPlayer)
        elseif Config.Inventory == "ox" then
            TriggerServerEvent("snipe-menu:server:openInventory", otherPlayer)
        elseif Config.Inventory == "chezza" then
            TriggerEvent("inventory:openPlayerInventory", otherPlayer, false)
        else
            print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' in config.lua")
        end
    end
end)
