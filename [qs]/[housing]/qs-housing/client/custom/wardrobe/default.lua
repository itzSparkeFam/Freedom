if Config.Wardrobe ~= 'default' then
    return
end

function openWardrobe()
    if Config.Framework == 'qb' then
        return TriggerEvent('qb-clothing:client:openOutfitMenu')
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
        title    = Lang('HOUSING_MENU_WARDROBE_DEFAULT_TITLE'),
        align    = 'right',
        elements = {
            { label = Lang('HOUSING_MENU_CLOTHES_MENU'),   value = 'player_dressing' },
            { label = Lang('HOUSING_MENU_DELETE_CLOTHES'), value = 'remove_cloth' }
        }
    }, function(data, menu)
        if data.current.value == 'player_dressing' then
            menu.close()
            TriggerServerCallback('qb-houses:server:getPlayerDressing', function(dressing)
                elements = {}

                for i = 1, #dressing, 1 do
                    table.insert(elements, {
                        label = dressing[i],
                        value = i
                    })
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
                    {
                        title    = Lang('HOUSING_MENU_WARDROBE_DEFAULT_TITLE'),
                        align    = 'right',
                        elements = elements
                    }, function(data2, menu2)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerServerCallback('qb-houses:server:getPlayerOutfit', function(clothes)
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
            TriggerServerCallback('qb-houses:server:getPlayerDressing', function(dressing)
                elements = {}

                for i = 1, #dressing, 1 do
                    table.insert(elements, {
                        label = dressing[i],
                        value = i
                    })
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
                    title    = Lang('HOUSING_MENU_DELETE_CLOTHES'),
                    align    = 'right',
                    elements = elements
                }, function(data2, menu2)
                    menu2.close()
                    TriggerServerEvent('qb-houses:server:removeOutfit', data2.current.value)
                    Notification(Lang('HOUSING_NOTIFICATION_OUTFIT_DELETE'), 'inform')
                end, function(data2, menu2)
                    menu2.close()
                end)
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end
