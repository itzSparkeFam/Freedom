if Config.Wardrobe ~= 'raid_clothes' then
    return
end

function openWardrobe()
    TriggerEvent('raid_clothes:openmenu')
end
