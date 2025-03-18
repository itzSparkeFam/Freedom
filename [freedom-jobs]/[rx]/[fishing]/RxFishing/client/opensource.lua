--[[
BY RX Scripts © rxscripts.xyz
--]]

function ShowTextUI(text, opts)
    lib.showTextUI(text, opts)
end

function HideTextUI()
    lib.hideTextUI()
end

function AddFishingNPCTarget(ped)
    if OXTarget then
        OXTarget:addLocalEntity(ped, {
            {
                label = 'Open Fisherman',
                name = 'openFishingNPC',
                icon = 'fas fa-fish',
                distance = 2.5,
                onSelect = function(data)
                    OpenFishingUI()
                end,
            }
        })
    elseif QBTarget then
        QBTarget:AddTargetEntity(ped, {
            options = {
                {
                    label = 'Open Fisherman',
                    icon = 'fas fa-fish',
                    targeticon = 'fas fa-fish',
                    action = function(entity)
                        OpenFishingUI()
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
                label = 'Open Fishing Shop',
                name = 'openFishingShop',
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
                    label = 'Open Fishing Shop',
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
                label = 'Open Fishing Selling',
                name = 'openFishingSelling',
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
                    label = 'Open Fishing Selling',
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

function AddBoatRentalNPCTarget(npc, rentalName, locIndex)
    if OXTarget then
        OXTarget:addLocalEntity(npc, {
            {
                label = 'Open '..rentalName,
                name = 'openBoatRental',
                icon = 'fas fa-ship',
                distance = 2.5,
                onSelect = function(data)
                    OpenBoatRental(rentalName, locIndex)
                end,
            }
        })
    elseif QBTarget then
        QBTarget:AddTargetEntity(npc, {
            options = {
                {
                    label = 'Open '..rentalName,
                    icon = 'fas fa-ship',
                    targeticon = 'fas fa-ship',
                    action = function(entity)
                        OpenBoatRental(rentalName, locIndex)
                    end,
                }
            },
            distance = 2.5,
        })
    end
end

function RemoveShopNPCTarget(ped)
    if OXTarget then
        OXTarget:removeLocalEntity(ped, 'openFishingShop')
    elseif QBTarget then
        QBTarget:RemoveTargetEntity(ped, 'Open Fishing Shop')
    end
end

function RemoveSellNPCTarget(ped)
    if OXTarget then
        OXTarget:removeLocalEntity(ped, 'openFishingSelling')
    elseif QBTarget then
        QBTarget:RemoveTargetEntity(ped, 'Open Fishing Selling')
    end
end

function RemoveTarget(ent, name)
    if OXTarget then
        OXTarget:removeLocalEntity(ent, name)
    elseif QBTarget then
        QBTarget:RemoveTargetEntity(ent, name)
    end
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
    return FM.callback.sync('fishing:getItemsAmounts')
end

function StartFishingMinigame(reelPower, progressPenalty, progressIncrement, baitSpeed, fishSpeed, fishJumpRange, catchTime, baitName, fishName)
    local res = promise.new()

    SetNuiFocus(true, true)
    SendReactMessage('startFishing', {
        reelPower = reelPower,
        progressPenalty = progressPenalty,
        progressIncrement = progressIncrement,
        baitSpeed = baitSpeed,
        fishSpeed = fishSpeed,
        fishJumpRange = fishJumpRange,
        catchTime = catchTime,
        baitName = baitName,
        fishName = fishName,
    })

    return res
end

---@param type 'returnBoat' | 'returnNet'
function ShowMarker(type, coords)
    if type == 'returnBoat' then
        DrawMarker(35, coords, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 255, 100, 100, 100, false, true, 2, false, false, false, false)
    elseif type == 'returnNet' then
        DrawMarker(32, coords, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 100, 100, 255, 100, true, true, 2, false, false, false, false)
    end
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('helpNotification', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('helpNotification', false)
    else
        if beep == nil then
            beep = true
        end
        BeginTextCommandDisplayHelp('helpNotification')
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

local function notifyPolice(coords, msg)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_L('blip_suspicious_fishing_activity'))
    EndTextCommandSetBlipName(blip)

    FM.utils.notify(msg, 'error')

    Wait(20000)
    RemoveBlip(blip)
end

RegisterNetEvent('fishing:notifyPolice', function(coords, msg)
    notifyPolice(coords, msg)
end)