--[[
    Here you have the wardrobe configuration, you can modify it or even
    create your own! In case your inventory is not here, you can ask the
    creator to create a file following this example and add it!
]]

if Config.Wardrobe ~= 'illenium-appearance' then
    return
end

function OpenClotheMenu() -- If you choose the 'custom' option, you can add your clothes system here.
    TriggerEvent('illenium-appearance:client:openOutfitMenu')
end
