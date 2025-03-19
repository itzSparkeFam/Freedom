if Config.Framework ~= "ESX" then return end
if not Skin.Enabled then return end

-- esx_skin
local PlayerData = nil
local firstSpawn = true

CreateThread(function()
    while PlayerData == nil do
        PlayerData = Core?.GetPlayerData()
        Wait(100)
    end
end)

AddEventHandler("esx_skin:resetFirstSpawn", function()
    firstSpawn = true
    Skin.FirstSpawn = true
end)

AddEventHandler("esx_skin:playerRegistered", function()
    CreateThread(function()
        while not PlayerData do
            Wait(100)
        end

        if firstSpawn then
            Core?.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                if skin == nil then
                    Skin.OpenMenu({
                        {
                            label = _L("Skin.Button.Save"),
                            type = "accent",
                            action = "callback",
                            actionData = {
                                callbackName = "SkinSave"
                            }
                        },
                    }, "creator", true, PlayerData.sex == "m" and "male" or PlayerData.sex == 0 and "male" or "female")

                    Wait(100)
                else
                    TriggerEvent("skinchanger:loadSkin", skin)
                    Wait(100)
                end
            end)
        end
    end)
end)

RegisterNetEvent("esx:onPlayerSpawn", function()
    Functions.TriggerServerCallback("17mov_CharacterSystem:CheckForIlleniumSkin", function(skin)
        if skin then
            skin.isIllenium = true
            TriggerEvent("skinchanger:loadSkin", skin)
        end
    end)
end)

RegisterNetEvent("esx_skin:openMenu")
AddEventHandler("esx_skin:openMenu", function(submitCb, cancelCb)
    Skin.Callbacks.Submit = submitCb
    Skin.Callbacks.Cancel = cancelCb
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
    Skin.OpenMenu(buttons, "skinCommand")
end)

RegisterNetEvent("esx_skin:openRestrictedMenu")
AddEventHandler("esx_skin:openRestrictedMenu", function(submitCb, cancelCb, restrict)
    Skin.Callbacks.Submit = submitCb
    Skin.Callbacks.Cancel = cancelCb
    Skin.CurrentRestriction = restrict
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
    Skin.OpenMenu(buttons, "skinCommand")
end)

RegisterNetEvent("esx_skin:openSaveableMenu")
AddEventHandler("esx_skin:openSaveableMenu", function(submitCb, cancelCb)
    Skin.Callbacks.Submit = submitCb
    Skin.Callbacks.Cancel = cancelCb
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
    Skin.OpenMenu(buttons, "skinCommand")
end)

RegisterNetEvent("esx_skin:openSaveableRestrictedMenu")
AddEventHandler("esx_skin:openSaveableRestrictedMenu", function(submitCb, cancelCb, restrict)
    Skin.Callbacks.Submit = submitCb
    Skin.Callbacks.Cancel = cancelCb
    Skin.CurrentRestriction = restrict
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
    Skin.OpenMenu(buttons, "skinCommand")
end)

AddEventHandler("skinchanger:getSkin", function(cb)
    cb(TranslateSkinToESX(Skin.ConstructFromPed(PlayerPedId())))
end)

RegisterNetEvent("skinchanger:loadSkin")
AddEventHandler("skinchanger:loadSkin", function(skin, cb)
    local PlayerPed = PlayerPedId()
    local translatedSkin
    if skin.isIllenium or skin.components then
        translatedSkin = TranslateSkinFromIllenium(skin)
    else
        translatedSkin = TranslateSkinFromESX(skin)
    end

    Skin.SetOnPed(PlayerPed, translatedSkin)
end)

RegisterNetEvent("skinchanger:loadClothes")
AddEventHandler("skinchanger:loadClothes", function(playerSkin, clothesSkin)
    local data = clothesSkin
    local ped = PlayerPedId()

    if type(data) ~= "table" then data = json.decode(data) end
    local rawTranslate = TranslateSkinFromESX(data)
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
end)

RegisterNetEvent("17mov_CharacterSystem:OpenOutfitsMenu", function()
    Functions.TriggerServerCallback('17mov_CharacterSystem:FetchOutifts', function(result)
        local Elements = {}
        for k,v in pairs(result) do
            table.insert(Elements, {
                label = v.outfit_name, index = k
            })
        end

        if #Elements == 0 then
            table.insert(Elements, {
                label = _L("Bridge.Wardrobe.NoOutfits"), exit = true
            })
        end

        Core?.UI.Menu.Open("default", GetCurrentResourceName(), "Example_Menu", {
            title = _L("Bridge.Wardrobe.SelectOutfit"),
            align    = 'center',
            elements = Elements
        }, function(data,menu)
            menu.close();
            if data.current.exit then
                return menu.close()
            end
            Core?.UI.Menu.Open("default", GetCurrentResourceName(), "Example_Menu", {
                title = data.current.label,
                align    = 'center',
                elements = {
                    {label = _L("Bridge.Wardrobe.ChooseOutfit"), action = "select"},
                    {label = _L("Bridge.Wardrobe.DeleteOutfit"), action = "delete" }
                }
            }, function(data2, menu2)
                if data2.current.action == "select" then
                    local targetSkin = TranslateSkinToESX(result[data.current.index].skin)
                    TriggerEvent("skinchanger:loadClothes", nil, targetSkin)
                    if Skin.RememberLastOutfit then
                        Citizen.Wait(1000)
                        TriggerEvent("17mov_CharacterSystem:SaveCurrentSkin")
                    end
                else
                    TriggerServerEvent("17mov_CharacterSystem:Deleteoufit", data.current.label)
                end
                menu2.close()
            end, function(_, menu2)
                menu2.close()
            end)
        end, function(_, menu) -- Cancel Function
            menu.close()
        end)
    end)
end)

RegisterNetEvent("skinchanger:change", function(key, val)
    local PlayerPed = PlayerPedId()
    local currentSkin = TranslateSkinToESX(Skin.ConstructFromPed(PlayerPed))

    currentSkin[key] = val

    Skin.SetOnPed(PlayerPed, TranslateToInternal(currentSkin))
end)