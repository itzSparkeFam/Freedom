if not Skin.Enabled then return end

-- Code taken and refactored from qb-core.
function AddBlip(coordinates, sprite, color, scale, label)
    local clothingShop = AddBlipForCoord(coordinates.x, coordinates.y, coordinates.z)

    SetBlipSprite(clothingShop, sprite)
    SetBlipColour(clothingShop, color)
    SetBlipScale(clothingShop, scale)
    SetBlipAsShortRange(clothingShop, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(clothingShop)
end

CreateThread(function()
    for k, v in pairs(Config.Stores) do
        if not v.hideBlip then
            AddBlip(v.coords, Config.StoresBlips[v.shopType].sprite, Config.StoresBlips[v.shopType].color, Config.StoresBlips[v.shopType].scale, _L(string.format("Store.%s.BlipLabel", v.shopType)))
        end

        if v.ped then
            CreateThread(function ()
                if type(v.ped) ~= "number" then
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    Config.Stores[k].ped = GetHashKey(v.ped)
                end

                Functions.LoadModel(v.ped)

                local ped = CreatePed(0, v.ped, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
                FreezeEntityPosition(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetEntityInvincible(ped, true)

                Config.Stores[k].spawnedPed = ped

                if Config.UseTarget then
                    while AddTargetStorePed == nil do
                        Wait(100)
                    end

                    AddTargetStorePed(ped, v.shopType, k)
                end
            end)
        end
    end

    while not Config.UseTarget do
        local PlayerPed = PlayerPedId()
        local myCoordinates = GetEntityCoords(PlayerPed)
        local sleep = 1000
        for k, v in pairs (Config.Stores) do
            if #(myCoordinates.xyz - v.coords.xyz) < (v?.radius or 3.0) and ShowHelpNotification then
                sleep = 0
                ShowHelpNotification(string.format(_L("Store.Use"), v.price))
                if IsControlJustReleased(0, 38) then
                    Functions.TriggerServerCallback("17mov_CharacterSystem:CheckIfHaveEnoughMoney", function(has)
                        if has then
                            TriggerEvent("17mov_CharacterSystem:OpenStore", {
                                shopType = v.shopType,
                                shopIndex = k,
                            })
                        else
                            Notify(_L("Store.NotEnoughMoney"))
                        end
                    end, k)
                end
            end
        end

        Wait(sleep)
    end
end)

RegisterNetEvent("17mov_CharacterSystem:OpenStore", function(data)
    local buttons = {
        {
            label = _L("Skin.Button.Cancel"),
            type = "danger",
            action = "callback",
            actionData = {
                callbackName = "SkinClose"
            }
        },
        {
            label = _L("Skin.Button.Save"),
            type = "accent",
            action = "callback",
            actionData = {
                callbackName = "SkinSave"
            }
        },
    }

    if data.shopType == "clothing" then
        table.insert(buttons,  {
            label = _L("Skin.Button.SaveWardrobe"),
            type = "accent",
            action = "saveModal",
        })
    end

    Skin.CurrentSessionStoreIndex = data.shopIndex
    Skin.OpenMenu(buttons, data.shopType, false)
end)

CreateThread(function()
    while true do
        local PlayerPed = PlayerPedId()
        local myCoordinates = GetEntityCoords(PlayerPed)
        local sleep = 1000
        for k, v in pairs (Config.OutfitChangers) do
            if #(myCoordinates.xyz - v.coords.xyz) < 2.0 and ShowHelpNotification then
                sleep = 0
                ShowHelpNotification(_L("OutfitChanger.Use"))
                if IsControlJustReleased(0, 38) then
                    if Config.Framework == "QBCore" then
                        TriggerEvent("qb-clothing:client:openOutfitMenu")
                    else
                        TriggerEvent("17mov_CharacterSystem:OpenOutfitsMenu")
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

local wearingJobOutfit = false
RegisterNetEvent("17mov_CharacterSystem:client:OpenClothingRoom", function(job, grade)
    local PlayerPed = PlayerPedId()
    if not wearingJobOutfit then
        local myGender = Skin.ConstructFromPed(PlayerPed).gender
        local targetSkins = Config.Outfits?[job]?[myGender]?[grade]
        if not targetSkins then
            Notify(_L("ClothingRoom.NoOutfit"))
            return
        end

        if Config.Framework == "QBCore" then
            if GetResourceState("qb-menu") == "started" then
                local data = {
                    {
                        header = _L("Bridge.Wardrobe.SelectOutfit"),
                        isMenuHeader = true,
                    }
                }
                for k,v in pairs(targetSkins) do
                    table.insert(data, {
                        header = v.outfitLabel,
                        params = {
                            event = "qb-clothing:client:loadOutfit",
                            args = {
                                skin = v.outfitData
                            }
                        }
                    })
                end

                exports["qb-menu"]:openMenu(data)
            else
                local options = {}
                for k, v in pairs(targetSkins) do
                    table.insert(options, {
                        label = v.outfitLabel,
                        args = {
                            skin = v.outfitData
                        }
                    })
                end

                if #options > 0 then
                    lib.registerMenu({
                        id = '17mov_CharacterSystem:OpenClothingRoom',
                        title = _L("Bridge.Wardrobe.SelectOutfit"),
                        position = 'top-right',
                        options = options
                    }, function (selected, scrollIndex, args, checked)
                        lib.hideMenu(false)
                        TriggerEvent("qb-clothing:client:loadOutfit", args) -- Runs whenever an option is selected
                    end)
                    lib.showMenu('17mov_CharacterSystem:OpenClothingRoom')
                end
            end
        elseif Config.Framework == "ESX" then
            local Elements = {}

            for k,v in pairs(targetSkins) do
                table.insert(Elements, {
                    label = v.outfitLabel, index = k
                })
            end

            Core?.UI.Menu.Open("default", GetCurrentResourceName(), "Example_Menu", {
                title = _L("Bridge.Wardrobe.SelectOutfit"),
                align    = 'center',
                elements = Elements
            }, function(data,menu) -- OnSelect Function
                local internal = TranslateSkinFromQB(targetSkins[data.current.index].outfitData)
                local human = TranslateToHuman(internal)
                local current = TranslateToHuman(Skin.ConstructFromPed(PlayerPedId()))
                for k,v in pairs(human) do
                    current[k] = v
                end

                current["sex"] = GetEntityModel(PlayerPedId())
                current["model"] = GetEntityModel(PlayerPedId())

                TriggerEvent("skinchanger:loadClothes", nil, TranslateSkinToESX(TranslateToInternal(current)))
                menu.close()
            end, function(data, menu) -- Cancel Function
                menu.close()
            end)
        end
    else
        if Config.Framework == "QBCore" then
            Core?.Functions.TriggerCallback("qb-clothing:server:getPlayerSkin", function(data)
                local skinToSet = TranslateSkinFromQB(data.skin, data.model)
                Skin.SetOnPed(PlayerPed, skinToSet)
            end)
        elseif Config.Framework == "ESX" then
            Core?.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                local skinToSet = TranslateSkinFromESX(skin)
                Skin.SetOnPed(PlayerPedId(), skinToSet)
            end)
        end
    end

    wearingJobOutfit = not wearingJobOutfit
end)

CreateThread(function()
    while true do
        local job = {name = "unknown", grade = 0}
        if Config.Framework == "QBCore" then
            local PlayerData = Core?.Functions.GetPlayerData()
            job.name = PlayerData?.job?.name
            job.grade = PlayerData?.job?.grade?.level
        elseif Config.Framework == "ESX" then
            local PlayerData = Core?.GetPlayerData()
            job.name = PlayerData?.job?.name
            job.grade = PlayerData?.job?.grade
        end

        local PlayerPed = PlayerPedId()
        local myCoordinates = GetEntityCoords(PlayerPed)
        local sleep = 1000
        for _, v in pairs (Config.ClothingRooms) do
            if job.name == v.requiredJob then
                if #(myCoordinates.xyz - v.coords.xyz) < 2.0 and ShowHelpNotification then
                    sleep = 0
                    ShowHelpNotification(_L("ClothingRoom.Use"))
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("17mov_CharacterSystem:client:OpenClothingRoom", job.name, job.grade)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)