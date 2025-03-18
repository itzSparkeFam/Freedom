---@param _type? 'lockpick' | 'police'
function OpenApartmentMenu(_type)
    local apartmentDatas = TriggerServerCallbackSync('housing:getApartmentsData', CurrentHouse)
    if not apartmentDatas or not next(apartmentDatas) then return Notification(Lang('HOUSING_NOTIFICATION_NO_APARTMENTS'), 'error') end
    local data = {}
    for k, v in pairs(apartmentDatas) do
        local description = Lang('HOUSING_MENU_APARTMENT_SALES')
        local houseData = Config.Houses[v.house]
        if v.ownedByMe and v.haskey then
            description = Lang('HOUSING_MENU_APARTMENT_OWN')
        elseif v.haskey then
            description = Lang('HOUSING_MENU_APARTMENT_NO_KEY')
        elseif v.purchasable then
            description = Lang('HOUSING_MENU_APARTMENT_SALES')
        elseif v.rentable then
            description = Lang('HOUSING_MENU_APARTMENT_RENT')
        elseif not houseData.locked then
            description = Lang('HOUSING_MENU_APARTMENT_NOT_LOCKED')
        elseif v.isOwned then
            description = Lang('HOUSING_MENU_APARTMENT_OWNED')
        end
        table.insert(data, {
            title = v.ownedByMe and Lang('HOUSING_MENU_APARTMENT_SELECT_YOUR') .. k or Lang('HOUSING_MENU_APARTMENT_SELECT') .. k,
            description = description,
            onSelect = function(args)
                if _type == 'lockpick' then
                    LockPick(v.house)
                    return
                elseif _type == 'police' then
                    RamDoor(v.house)
                    return
                end
                if not v.isOwned or v.rentable or v.purchasable then
                    OpenApartmentBuyMenu(v)
                    return
                elseif v.haskey or not houseData.locked then
                    CurrentHouseData = v
                    CurrentHouse = v.house
                    TriggerEvent('qb-houses:client:EnterHouse', houseData.ipl, v.house, v)
                    return
                end
                Notification(Lang('HOUSING_NOTIFICATION_YOU_RING_DOOR'), 'inform')
                TriggerServerEvent('qb-houses:server:RingDoor', v.house)
            end,
            disabled = (_type == 'lockpick' or _type == 'police') and (not v.isOwned or not houseData.locked)
        })
    end
    lib.registerContext({
        id = 'apartment_menu',
        title = Lang('HOUSING_MENU_APARTMENT_TITLE'),
        options = data
    })
    lib.showContext('apartment_menu')
end

function OpenApartmentBuyMenu(apartment)
    local data = {}
    if apartment.rentable then
        table.insert(data, {
            title = Lang('HOUSING_MENU_APARTMENT_RENT_TITLE'),
            -- description = 'Rent',
            onSelect = function(args)
                CurrentApartment = apartment
                TriggerServerEvent('qb-houses:server:viewHouse', apartment.house, true)
            end
        })
    else
        table.insert(data, {
            title = Lang('HOUSING_MENU_APARTMENT_BUY_TITLE'),
            -- description = 'Buy',
            onSelect = function(args)
                CurrentApartment = apartment
                TriggerServerEvent('qb-houses:server:viewHouse', apartment.house)
            end
        })
    end
    local houseData = Config.Houses[apartment.house]
    table.insert(data, {
        title = Lang('HOUSING_MENU_APARTMENT_INSPECT_TITLE'),
        -- description = 'Inspect',
        onSelect = function(args)
            InspectHouse(houseData, apartment.house)
        end
    })
    lib.registerContext({
        id = 'apartment_buy_interactions',
        title = Lang('HOUSING_MENU_APARTMENT_INTERACTIONS'),
        options = data
    })
    lib.showContext('apartment_buy_interactions')
end

function OpenMyApartments()
    local apartmentDatas = TriggerServerCallbackSync('housing:getApartmentsData', CurrentHouse)
    if not apartmentDatas or not next(apartmentDatas) then return Notification(Lang('HOUSING_NOTIFICATION_NO_APARTMENTS'), 'error') end
    local data = {}
    for k, v in pairs(apartmentDatas) do
        if not v.ownedByMe then goto continue end
        local houseData = Config.Houses[v.house]
        table.insert(data, {
            title = Lang('HOUSING_MENU_APARTMENT_SELECT_YOUR') .. k,
            --- description = 'Your Apartment',
            onSelect = function(args)
                v.currentHouse = CurrentHouse
                v.currentHouseData = CurrentHouseData
                CurrentApartment = v
                CurrentHouse = v.house
                CurrentHouseData = v
                houseData.name = Lang('HOUSING_MENU_APARTMENT_SELECT_YOUR') .. k
                GetDecorations(CurrentHouse)
                OpenManagement(houseData)
            end,
        })
        ::continue::
    end
    if #data == 0 then return Notification(Lang('HOUSING_NOTIFICATION_NO_OWNED_APARTMENTS'), 'error') end
    lib.registerContext({
        id = 'my_apartment_menu',
        title = Lang('HOUSING_MENU_MY_APARTMENT'),
        options = data
    })
    lib.showContext('my_apartment_menu')
end

function OpenHireApartments()
    local apartmentDatas = TriggerServerCallbackSync('housing:getApartmentsData', CurrentHouse, true)
    if not apartmentDatas or not next(apartmentDatas) then return Notification(Lang('HOUSING_NOTIFICATION_NO_APARTMENTS'), 'error') end
    apartmentDatas = table.filter(apartmentDatas, function(v)
        return v.rented
    end)
    if #apartmentDatas == 0 then return Notification(Lang('HOUSING_NOTIFICATION_NO_RENTED_APARTMENTS'), 'error') end
    local data = {}
    for k, v in pairs(apartmentDatas) do
        table.insert(data, {
            title = Lang('HOUSING_MENU_HIRE_APARTMENT_NUMBER') .. ' ' .. k,
            onSelect = function(args)
                TriggerServerEvent('housing:hireRenter', v.house)
            end,
        })
    end
    if #data == 0 then return Notification(Lang('HOUSING_NOTIFICATION_NO_RENTED_APARTMENTS'), 'error') end
    lib.registerContext({
        id = 'hire_apartment_menu',
        title = Lang('HOUSING_MENU_HIRE_APARTMENT'),
        options = data
    })
    lib.showContext('hire_apartment_menu')
end
