local locale = SD.Locale.T

local isLooting = false

function TrolleySpawn()
    local AmountSpawned = 0
    local MaxAmount = math.random(Config.Rewards.Trays.MinTrayAmount, Config.Rewards.Trays.MaxTrayAmount)

    while AmountSpawned < MaxAmount do
        for k, v in pairs(Config.Trays) do
            if AmountSpawned < MaxAmount then
                local try = math.random(3)
                if try == 1 then
                    if not v.isSpawned then
                        local TrayChance = math.random(100)
                        if TrayChance <= 50 then
                            local loc = v.coords
                            local TrayLoot = math.random(100)
                            local TrayHash = 269934519
                            v.isSpawned = true
                            if TrayLoot <= Config.Rewards.Trays.GoldChance then TrayHash = 2007413986 end
                            local TrayObj = CreateObject(TrayHash, loc.x, loc.y, loc.z , 1, 0, 0)
                            local NetID = NetworkGetNetworkIdFromEntity(TrayObj)
                            v.netId = NetID
                            TriggerServerEvent('sd-pacificbank:server:VaultSync', "Trays", k, TrayHash, NetID)
                            SetEntityHeading(TrayObj, v.heading)
                            AmountSpawned = AmountSpawned + 1
                            if AmountSpawned == MaxAmount then break end
                        end
                    end
                end
            end
        end
    end
end

function DespawnTrays()
    for k, v in pairs(Config.Trays) do
        if v.netId then
            local entity = NetworkGetEntityFromNetworkId(v.netId)
            if DoesEntityExist(entity) then
                DeleteObject(entity)
            end
            v.isSpawned = false
            v.netId = nil
        end
    end
end

function ActivateTrayTargets(tray, hash, trayid)
    CreateThread(function()
        local options = {
            {
                name = "sdTray",
                event = "sd-pacificbank:client:GrabTrayLoot",
                icon = "fas fa-hand",
                label = locale('target.grab_loot'), 
                tray = tray,
                model = hash,
                trayid = trayid,
				canInteract = function()
					if not isLooting then
						return true
					end
                end
            }
        }


        local parameters = {
            options = options,
            distance = 1.5
        }

        exports.qtarget:AddTargetEntity(tray, parameters)
    end)
end

-- Disable Controls While Looting
function DisableControls()
    CreateThread(function ()
        while isLooting or isDrilling do
            DisableControlAction(0, 21, true) -- Sprinting
            DisableControlAction(0, 22, true) -- Jumping
            DisableControlAction(0, 23, true) -- Vehicle Entering
            DisableControlAction(0, 36, true) -- Ctrl
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 73, true) -- X key
            Wait(1)
        end
    end)
end

-- Get Cash
local function CashInHand(loot)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    SD.LoadModel(loot)
    local LootInHand = CreateObject(loot, pedCoords, true)

    FreezeEntityPosition(LootInHand, true)
    SetEntityInvincible(LootInHand, true)
    SetEntityNoCollisionEntity(LootInHand, ped)
    SetEntityVisible(LootInHand, false, false)
    AttachEntityToEntity(LootInHand, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local StartTime = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() < StartTime + 37000 do
            Wait(1)
            if HasAnimEventFired(ped, 726137971) then
                if not IsEntityVisible(LootInHand) then
                    SetEntityVisible(LootInHand, true, false)
                end
            end
            if HasAnimEventFired(ped, 3137358764) then
                if IsEntityVisible(LootInHand) then
                    SetEntityVisible(LootInHand, false, false)
                end
            end
        end
        isLooting = false
        DeleteObject(LootInHand)
    end)
end

-- Set Trolley 'grabbed' status
RegisterNetEvent('sd-pacificbank:client:UpdateTrayStatus')
AddEventHandler('sd-pacificbank:client:UpdateTrayStatus', function(trayId)
    Config.Trays[trayId].grabbed = true
end)

-- Tray Handle
RegisterNetEvent('sd-pacificbank:client:GrabTrayLoot', function(data)
    local trayId = data.trayid

    -- Check if tray ID is valid
    if not trayId or not Config.Trays[trayId] then return end

    local v = Config.Trays[trayId]

    -- Check if the tray has already been looted
    if v.grabbed then
        SD.ShowNotification(locale('error.cant_interact'), 'error')
        return
    end

    -- Mark the tray as looted and disable player controls
    TriggerServerEvent('sd-pacificbank:server:UpdateTrayStatus', trayId)
    isLooting = true
    DisableControls() -- Function to disable player controls (needs to be defined)

    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    local TrayHash = data.model
    local TrayLoot

    FreezeEntityPosition(ped, true) -- Freezes the player

    -- Determine the type of loot based on the model of the tray
    if TrayHash == 881130828 then
        TrayLoot = 'ch_prop_vault_dimaondbox_01a'
    elseif TrayHash == 2007413986 then
        TrayLoot = 'ch_prop_gold_bar_01a'
    else
        TrayLoot = 'hei_prop_heist_cash_pile'
    end

    local animDict = 'anim@heists@ornate_bank@grab_cash'
    SD.LoadAnim(animDict)
    SD.LoadModel(3350498815)

    -- Create objects and animations
    local Tray = GetClosestObjectOfType(v.coords, 1.5, TrayHash, 0, 0, 0)
    local bag = CreateObject(3350498815, pedCo, true, false, false)
    local coords, rot = GetEntityCoords(Tray), GetEntityRotation(Tray)

    -- Animation scenes setup
    local scene1 = NetworkCreateSynchronisedScene(coords, rot, 2, true, false, 1.0, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 1.5, 1, 1, 16, 1111111111, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 4.0, -8.0, 1)

    local scene2 = NetworkCreateSynchronisedScene(coords, rot, 2, true, false, 1.0, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'grab', 1.5, 1, 1, 16, 1111111111, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_grab', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(Tray, scene2, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

    local scene3 = NetworkCreateSynchronisedScene(coords, rot, 2, true, false, 1.0, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', 1.5, 1, 1, 16, 1111111111, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', 4.0, -8.0, 1)

    -- Starting the animations
    NetworkStartSynchronisedScene(scene1)
    Wait(1750) CashInHand(TrayLoot) 
    NetworkStartSynchronisedScene(scene2)
    Wait(37000) 
    NetworkStartSynchronisedScene(scene3) 
    Wait(2000)

    -- Cleanup after looting
    local newTrolly = CreateObject(769923921, v.coords, true, false, false)
    SetEntityHeading(newTrolly, v.heading)
    DeleteObject(Tray)
    DeleteObject(bag)

    FreezeEntityPosition(ped, false) -- Unfreezes the player

    -- Notify server about the loot
    TriggerServerEvent('sd-pacificbank:server:TrayLoot', TrayHash, data.loc)
end)

RegisterNetEvent('sd-pacificbank:client:DespawnTrays', DespawnTrays)

--Syncing Event
RegisterNetEvent('sd-pacificbank:client:VaultSync', function(type, trayid, arg1, arg2)
    if type == "Trays" then
        Wait(2000)
        local entity = NetworkGetEntityFromNetworkId(arg2)
        ActivateTrayTargets(entity, arg1, trayid)
    end
end)

RegisterNetEvent('sd-pacificbank:client:UpdateTrolleyState', function(trolleyId, spawned, netId)
    if Config.Trays[trolleyId] then
        Config.Trays[trolleyId].isSpawned = spawned
        Config.Trays[trolleyId].netId = netId
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DespawnTrays()
    end
end)