if Config.Wardrobe ~= 'rcore_clothes' then
    return
end

function openWardrobe()
    TriggerEvent('rcore_clothes:openOutfits')
end
