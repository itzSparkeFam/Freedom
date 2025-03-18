local ActionTypesList = {
    [HEARTBEAT_EVENTS.PRISONER_LOADED] = PRISON_OUTFITS.PRISONER,
    [HEARTBEAT_EVENTS.PRISONER_NEW] = PRISON_OUTFITS.PRISONER,
    [HEARTBEAT_EVENTS.PRISONER_RELEASED] = PRISON_OUTFITS.CITIZEN,
}

NetworkService.EventListener('heartbeat', function(eventType, data)
    local actionType = ActionTypesList[eventType]

    if not actionType then
        return
    end

    if Config.DisableClothing then
        return
    end

    if actionType == PRISON_OUTFITS.CITIZEN then
        if not Config.Outfits.RestorePlayerOutfitOnRelease then
            return
        end

        RestoreCivilOutfit()
    elseif actionType == PRISON_OUTFITS.PRISONER then
        ApplyOutfit(Outfits)
    end
end)


function GetOutfitByGender(data)
    if not data then
        return
    end

    local plyPed = PlayerPedId()
    local model = GetEntityArchetypeName(plyPed)
    local isMale = 'mp_m_freemode_01' == model
    local gender = isMale and 'male' or 'female'

    return data[gender] or nil
end