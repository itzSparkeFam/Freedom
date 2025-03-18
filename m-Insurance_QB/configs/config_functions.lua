local QBCore = exports[Config.Core]:GetCoreObject()

function Notify(text, type, time)
    if Config.Notify == "standalone" then
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(true, true)
    elseif Config.Notify == "qb" then
        QBCore.Functions.Notify(text, type, time)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert('Notification', text, time, type, true)
    elseif Config.Notify == "ox" then
        lib.notify({ title = 'Notification', description = text, type = type })
    elseif Config.Notify == "codem" then
        TriggerEvent('codem-notification:Create', text, type, 'Insurance', time)
    end
end

function OpenStash(weight, slots, name)
    if Config.Inventory == "oldqb" then
        TriggerEvent("inventory:client:SetCurrentStash", name)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", name, {
            maxweight = weight,
            slots = slots,
        })
    elseif Config.Inventory == "newqb" or Config.Inventory == "qs" then
        TriggerServerEvent("m-Insurance:Server:OpenStash", weight, slots, name)
    elseif Config.Inventory == "ox" then
       exports.ox_inventory:openInventory('stash', name)
    end
end

function MakeAnimation(animation)
    if Config.EmoteMenu == "dp" then
        TriggerEvent('animations:client:EmoteCommandStart', {animation})
    elseif Config.EmoteMenu == "rp" then
        exports["rpemotes"]:EmoteCommandStart(animation)
    elseif Config.EmoteMenu == "scully" then
        exports["scully_emotemenu"]:playEmoteByCommand(animation)
    elseif Config.EmoteMenu == "aty_emote" then
        exports.aty_emote:PlayEmote(animation)
    elseif Config.EmoteMenu == "cylex_animmenuv2" then
        exports['cylex_animmenuv2']:playEmote(animation)
    elseif Config.EmoteMenu == "r_animations" then
        exports['r_animations']:StartAnimationPlay(animation)
    else
        print("Missing or write wrong on: Config.EmoteMenu")
    end
end

function CancelAnimation()
    if Config.EmoteMenu == "dp" then
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    elseif Config.EmoteMenu == "rp" then
        exports["rpemotes"]:EmoteCommandStart("c")
    elseif Config.EmoteMenu == "scully" then
        exports["scully_emotemenu"]:cancelEmote()
    elseif Config.EmoteMenu == "aty_emote" then
        exports.aty_emote:CancelEmote()
    elseif Config.EmoteMenu == "cylex_animmenuv2" then
        exports['cylex_animmenuv2']:playEmote('c')
    elseif Config.EmoteMenu == "r_animations" then
        exports['r_animations']:StopAnimation()
    else
        print("Missing or write wrong on: Config.EmoteMenu")
    end
end