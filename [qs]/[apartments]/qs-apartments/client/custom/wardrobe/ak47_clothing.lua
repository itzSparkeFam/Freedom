--[[
    Here you have the wardrobe configuration, you can modify it or even
    create your own! In case your inventory is not here, you can ask the
    creator to create a file following this example and add it!
]]

if Config.Wardrobe ~= 'ak47_clothing' then
    return
end

function OpenClotheMenu()
    exports['ak47_clothing']:openOutfit() -- if it doesn't work with this export, u can replace by :
    -- TriggerEvent('ak47_clothing:openOutfitMenu') -- Use this only if the first export doesn't work, depend of you'r version
end
