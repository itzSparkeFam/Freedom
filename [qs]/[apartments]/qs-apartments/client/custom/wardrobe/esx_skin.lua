--[[
    Here you have the wardrobe configuration, you can modify it or even
    create your own! In case your inventory is not here, you can ask the
    creator to create a file following this example and add it!
]]

if Config.Wardrobe ~= 'esx_skin' then
    return
end

function OpenClotheMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
        title    = Lang('APARTMENTS_MENU_WARDROBE_TITLE'),
        align    = 'right',
        elements = {
            { label = Lang('APARTMENTS_MENU_WARDROBE_CLOTHES'), value = 'player_dressing' },
            { label = Lang('APARTMENTS_MENU_WARDROBE_DELETE'),  value = 'remove_cloth' }
        }
    }, function(data, menu)
        if data.current.value == 'player_dressing' then
            menu.close()
            TriggerServerCallback('apartments:server:getPlayerDressing', function(dressing)
                elements = {}

                for i = 1, #dressing, 1 do
                    table.insert(elements, {
                        label = dressing[i],
                        value = i
                    })
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
                    {
                        title    = Lang('APARTMENTS_MENU_PLAYER_DRESSING_TITLE'),
                        align    = 'right',
                        elements = elements
                    }, function(data2, menu2)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerServerCallback('apartments:server:getPlayerOutfit', function(clothes)
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                TriggerEvent('esx_skin:setLastSkin', skin)

                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerServerEvent('esx_skin:save', skin)
                                end)
                            end, data2.current.value)
                        end)
                    end, function(data2, menu2)
                        menu2.close()
                    end)
            end)
        elseif data.current.value == 'remove_cloth' then
            menu.close()
            TriggerServerCallback('apartments:server:getPlayerDressing', function(dressing)
                elements = {}

                for i = 1, #dressing, 1 do
                    table.insert(elements, {
                        label = dressing[i],
                        value = i
                    })
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
                    title    = Lang('APARTMENTS_MENU_REMOVE_CLOTH_TITLE'),
                    align    = 'right',
                    elements = elements
                }, function(data2, menu2)
                    menu2.close()
                    TriggerServerEvent('apartments:server:removeOutfit', data2.current.value)
                    SendTextMessage(Lang('APARTMENTS_NOTIFICATION_OUTFIT_DELETED'), 'inform')
                end, function(data2, menu2)
                    menu2.close()
                end)
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end
