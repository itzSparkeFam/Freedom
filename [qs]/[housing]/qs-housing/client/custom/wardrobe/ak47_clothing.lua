if Config.Wardrobe ~= 'ak47_clothing' then
    return
end

function openWardrobe()
    exports['ak47_clothing']:openOutfit() -- if it doesn't work with this export use other event
    -- TriggerEvent('ak47_clothing:openOutfitMenu') -- Use this only if the first export doesn't work, depend of you'r version
end
