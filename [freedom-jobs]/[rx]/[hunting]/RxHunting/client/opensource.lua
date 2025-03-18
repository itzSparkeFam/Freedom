--[[
BY RX Scripts © rxscripts.xyz
--]]

local cutTargetLabel = 'Cut'

function InitAnimalTargets(animals)
    local opts = {
        {
            label = cutTargetLabel,
            icon = 'fas fa-cut',
        }
    }

    if OXTarget then
        opts[1].name = 'cut' -- don't change this
        opts[1].onSelect = function(data)
            CutAnimal(data.entity)
        end
        opts[1].canInteract = function(entity, distance, coords, name, bone)
            local netId = NetworkGetNetworkIdFromEntity(entity)
            local canCutSpawned = (ZoneInside or Config.CutOutsideZone) and Animals[netId] ~= nil
            return not CutOnCd and IsEntityDead(entity) and (not Config.OnlySpawned or canCutSpawned)
        end
        opts[1].distance = 2.5

        OXTarget:addModel(animals, opts)
    elseif QBTarget then
        opts[1].action = function(entity)
            CutAnimal(entity)
        end
        opts[1].canInteract = function(entity, distance, data)
            local netId = NetworkGetNetworkIdFromEntity(entity)
            local canCutSpawned = (ZoneInside or Config.CutOutsideZone) and Animals[netId] ~= nil
            return not CutOnCd and IsEntityDead(entity) and (not Config.OnlySpawned or canCutSpawned)
        end

        QBTarget:AddTargetModel(animals, {
            options = opts,
            distance = 2.5,
        })
    end
end

function RemoveAnimalTargets(animals)
    if OXTarget then
        OXTarget:removeModel(animals, 'cut')
    elseif QBTarget then
        QBTarget:RemoveTargetModel(animals, cutTargetLabel)
    end
end

function AddHuntingNPCTarget(ped)
    if OXTarget then
        OXTarget:addLocalEntity(ped, {
            {
                label = 'Open Hunter',
                name = 'openHuntingNPC',
                icon = 'fas fa-hiking',
                distance = 2.5,
                onSelect = function(data)
                    OpenHuntingUI()
                end,
            }
        })
    elseif QBTarget then
        QBTarget:AddTargetEntity(ped, {
            options = {
                {
                    label = 'Open Hunter',
                    icon = 'fas fa-hiking',
                    targeticon = 'fas fa-hiking',
                    action = function(entity)
                        OpenHuntingUI()
                    end,
                }
            },
            distance = 2.5,
        })
    end
end

function AddShopNPCTarget(npc)
    if OXTarget then
        OXTarget:addLocalEntity(npc, {
            {
                label = 'Open Hunting Shop',
                name = 'openHuntingShop',
                icon = 'fas fa-shopping-cart',
                distance = 2.5,
                onSelect = function(data)
                    OpenShopNPC()
                end,
            }
        })
    elseif QBTarget then
        QBTarget:AddTargetEntity(npc, {
            options = {
                {
                    label = 'Open Hunting Shop',
                    icon = 'fas fa-shopping-cart',
                    targeticon = 'fas fa-shopping-cart',
                    action = function(entity)
                        OpenShopNPC()
                    end,
                }
            },
            distance = 2.5,
        })
    end
end

function AddSellNPCTarget(npc)
    if OXTarget then
        OXTarget:addLocalEntity(npc, {
            {
                label = 'Open Hunting Selling',
                name = 'openHuntingSelling',
                icon = 'fas fa-shopping-cart',
                distance = 2.5,
                onSelect = function(data)
                    OpenSellNPC()
                end,
            }
        })
    elseif QBTarget then
        QBTarget:AddTargetEntity(npc, {
            options = {
                {
                    label = 'Open Hunting Selling',
                    icon = 'fas fa-shopping-cart',
                    targeticon = 'fas fa-shopping-cart',
                    action = function(entity)
                        OpenSellNPC()
                    end,
                }
            },
            distance = 2.5,
        })
    end
end

function RemoveShopNPCTarget(ped)
    if OXTarget then
        OXTarget:removeLocalEntity(ped, 'openHuntingShop')
    elseif QBTarget then
        QBTarget:RemoveTargetEntity(ped, 'Open Hunting Shop')
    end
end

function RemoveSellNPCTarget(ped)
    if OXTarget then
        OXTarget:removeLocalEntity(ped, 'openHuntingSelling')
    elseif QBTarget then
        QBTarget:RemoveTargetEntity(ped, 'Open Hunting Selling')
    end
end

function RemoveHuntingNPCTarget(ped)
    if OXTarget then
        OXTarget:removeLocalEntity(ped, 'openHuntingNPC')
    elseif QBTarget then
        QBTarget:RemoveTargetEntity(ped, 'Open Hunter')
    end
end

function StartCutProgress(animalNetId, weaponHash)
    if FM.progress.start({
        label = 'Cutting..',
        time = 1000,
        canCancel = true,
        type = 'circle',
        failedLabel = 'Cutting failed!',
        completedLabel = 'Cutting completed!',
        anim = {
            dict = 'melee@knife@streamed_core',
            anim = 'ground_attack_on_spot',
        },
    }) then
        CutAnimalByProgress(animalNetId, weaponHash)
    else
        CutOnCd = false
    end
end

function GetFullPlayerName()
    return FM.callback.sync('hunting:getFullPlayerName')
end

function GetPlacingBaitCoords()
    local coords = GetEntityCoords(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    coords = coords + forward
    local ret, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0, false)
    coords = vector3(coords.x, coords.y, z)
  
    local heading = GetEntityHeading(PlayerPedId())

    return coords, heading
end

function PlayPlaceBaitAnim()
    FM.anim.play({
        anim = 'base',
        dict = 'amb@world_human_gardener_plant@male@base',
        duration = 3000,
    })
end

function GetItemsAmounts()
    return FM.inventory.getItemsAmounts()

    -- Remove above line and uncomment below if your inventory script doesnt sync the items correctly
    -- return FM.callback.sync('hunting:getItemsAmounts')
end

RegisterNetEvent('hunting:notifyPolice', function(coords, msg)
    NotifyPolice(coords, msg)
end)