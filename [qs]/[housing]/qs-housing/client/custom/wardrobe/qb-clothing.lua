if Config.Wardrobe ~= 'qb-clothing' then
    return
end

function openWardrobe()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end
