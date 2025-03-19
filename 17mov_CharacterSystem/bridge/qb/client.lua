if Config.Framework ~= "QBCore" then return end
if Config.Showcase then return end
if not Skin.Enabled then return end

exports('IsCreatingCharacter', function()
    return Skin.CameraEnabled
end)

RegisterNetEvent('qb-clothing:client:openMenu', function()
    if GetInvokingResource() == "qb-interior" or GetInvokingResource() == "qbx_properties" then
        return
    end

    Skin.OpenMenu({
        {
            label = _L("Skin.Button.Save"),
            type = "accent",
            action = "callback",
            actionData = {

                callbackName = "SkinSave"
            }
        }
    }, "creator")
end)


RegisterNetEvent('qb-clothing:client:openMenuCommand', function()
    Skin.OpenMenu({
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
        }
    }, "skinCommand")
end)

RegisterNetEvent('qb-clothes:client:CreateFirstCharacter', function()
    if GetInvokingResource() == "qb-interior" or GetInvokingResource() == "qbx_properties" then
        return
    end

    Core?.Functions.GetPlayerData(function(pData)
        Skin.OpenMenu({
            {
                label = _L("Skin.Button.Save"),
                type = "accent",
                action = "callback",
                actionData = {

                    callbackName = "SkinSave"
                }
            },
        }, "creator", true, pData.charinfo.gender == 1 and "male" or "female")
    end)
end)

RegisterNetEvent("qb-clothes:loadSkin", function(_, model, data)
    if model then
        model = tonumber(model) or model
    end

    local translatedSkin = TranslateSkinFromQB(data, model)
    Skin.SetOnPed(PlayerPedId(), translatedSkin)
end)

RegisterNetEvent('qb-clothing:client:loadPlayerClothing', function(data, ped)
    if ped == nil then ped = PlayerPedId() end

    local humanBased = TranslateToHuman(TranslateSkinFromQB(data))
    local current = TranslateToHuman(Skin.ConstructFromPed(ped))

    for k,v in pairs(humanBased) do
        current[k] = v
    end

    current["sex"] = GetEntityModel(ped)
    local targetSkin = TranslateToInternal(current)
    Skin.SetOnPed(PlayerPedId(), targetSkin)
end)

RegisterNetEvent('qb-clothing:client:loadOutfit', function(oData)
    local data = oData.outfitData or oData.skin
    local ped = PlayerPedId()

    if type(data) ~= "table" then data = json.decode(data) end
    local rawTranslate = TranslateSkinFromQB(data)
    local current = Skin.ConstructFromPed(ped)
    local blacklistedComponents = {
        [0] = true, -- head
        [2] = true, -- HAIR
    }
    
    for k,v in pairs(current.components) do
        if not blacklistedComponents[v.component] then
            for k2, v2 in pairs(rawTranslate.components) do
                if v2.component == v.component then
                    current.components[k] = v2
                end
            end
        end
    end

    for k,v in pairs(current.props) do
        for k2, v2 in pairs(rawTranslate.props) do
            if v2.prop == v.prop then
                current.props[k] = v2
            end
        end
    end

    current["model"] = GetEntityModel(ped)

    Skin.SetOnPed(ped, current)

    -- Accessory
    if data["accessory"] ~= nil then
        if Core?.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)
        end
    else
        if Core?.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, -1, 0, 2)
        end
    end
end)

RegisterNetEvent("qb-clothing:client:openOutfitMenu", function()
    Core?.Functions.TriggerCallback('qb-clothing:server:getOutfits', function(result)
        if GetResourceState("qb-menu") ~= "missing" then
            local data = {
                {
                    header = _L("Bridge.Wardrobe.SelectOutfit"),
                    isMenuHeader = true,
                }
            }
            for k,v in pairs(result) do
                table.insert(data, {
                    header = v.outfitname,
                    params = {
                        event = "17mov_CharacterSystem:ManageOutfit",
                        args = {
                            data = v,
                            myId = v.outfitId,
                            myName = v.outfitname
                        }
                    }
                })
            end

            exports["qb-menu"]:openMenu(data)
        else
            local options = {}
            for k, v in pairs(result) do
                table.insert(options, {
                    label = v.outfitname,
                    args = {
                        data = v,
                        myId = v.id,
                        myName = v.outfitname
                    }
                })
            end

            if #options > 0 then
                lib.registerMenu({
                    id = '17mov_CharacterSystem:openOutfitMenu',
                    title = _L("Bridge.Wardrobe.SelectOutfit"),
                    position = 'top-right',
                    options = options
                }, function (selected, scrollIndex, args, checked)
                    lib.hideMenu(false)
                    TriggerEvent("17mov_CharacterSystem:ManageOutfit", args) -- Runs whenever an option is selected
                end)
                lib.showMenu('17mov_CharacterSystem:openOutfitMenu')
            else
                lib.notify({
                    title = _L("OutfitChanger.NoOutfits"),
                    position = "bottom",
                    icon = "fa-solid fa-ban",
                    iconAnimation = "shake",
                    type = 'error'
                })
            end
        end
    end)
end)

RegisterNetEvent("17mov_CharacterSystem:LoadWardrobeOutfit", function(data)
    TriggerEvent("qb-clothing:client:loadOutfit", data)
    if Skin.RememberLastOutfit then
        Citizen.Wait(1000)
        TriggerEvent("17mov_CharacterSystem:SaveCurrentSkin")
    end
end)

RegisterNetEvent("17mov_CharacterSystem:ManageOutfit", function(data)
    if GetResourceState("qb-menu") ~= "missing" then
        local data = {
            {
                header = data.myName,
                isMenuHeader = true,
            },
            {
                header = _L("Bridge.Wardrobe.ChooseOutfit"),
                params = {
                    event = "17mov_CharacterSystem:LoadWardrobeOutfit",
                    args = data.data
                }
            },
            {
                header = _L("Bridge.Wardrobe.DeleteOutfit"),
                params = {
                    event = "qb-clothing:server:removeOutfit",
                    isServer = true,
                    args = {
                        name = data.myName,
                        id = data.myId,
                    }
                }
            }
        }

        exports["qb-menu"]:openMenu(data)
    else
        local options = {
            {
                label = _L("Bridge.Wardrobe.ChooseOutfit"),
                args = data.data
            },
            {
                label = _L("Bridge.Wardrobe.DeleteOutfit"),
                args = {
                    name = data.myName,
                    id = data.myId
                }
            }
        }

        lib.registerMenu({
            id = "17mov_CharacterSystem:manageOutfitMenu",
            title = data.myName,
            options = options,
            position = "top-right"
        }, function (selected, scrollIndex, args, checked)
            if selected == 1 then
                TriggerEvent("qb-clothing:client:loadOutfit", args)
            elseif selected == 2 then
                TriggerServerEvent("qb-clothing:server:removeOutfit", args)
            end
        end)
        lib.showMenu("17mov_CharacterSystem:manageOutfitMenu")
    end
end)