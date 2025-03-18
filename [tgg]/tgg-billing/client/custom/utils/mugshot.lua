if not Config.MugshotEnabled then return end

local function takeMugShot()
    SetTimeout(250, function()
        if GetResourceState('MugShotBase64'):find('start') then
            Mugshot = exports["MugShotBase64"]:GetMugShotBase64(cache.ped, true)
        end
    end)
end

RegisterNetEvent(OnPlayerLoadedEvent, takeMugShot)
AddEventHandler('onResourceStart', takeMugShot)
