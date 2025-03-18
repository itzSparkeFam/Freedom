--[[
    Here you have the wardrobe configuration, you can modify it or even
    create your own! In case your inventory is not here, you can ask the
    creator to create a file following this example and add it!
]]

if Config.Wardrobe ~= 'qb-clothing' then
    return
end

function OpenClotheMenu()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end
