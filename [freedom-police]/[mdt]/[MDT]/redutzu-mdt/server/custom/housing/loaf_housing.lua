if Config.Housing ~= 'loaf_housing' then
    return
end

function GetHouses(query)
    local houses = MySQL.Sync.fetchAll([[
        SELECT
            loaf_properties.id,
            loaf_properties.propertyid,
            (
                SELECT
                    ]] .. citizens.name .. [[
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = loaf_properties.owner
            ) AS owner
        FROM
            loaf_properties
        WHERE
            loaf_properties.id LIKE ?
    ]], { '%' .. query .. '%' })

    for i = 1, #houses do
        local data = exports['loaf_housing']:GetHouse(houses[i].propertyid)

        houses[i].label = data?.label
        houses[i].propertyid = nil
    end
    
    return houses
end

function GetHouseData(id)
    local house = MySQL.Sync.fetchSingle([[
        SELECT
            loaf_properties.id,
            loaf_properties.propertyid,
            (
                SELECT
                    JSON_OBJECT(
                        'name', ]] .. citizens.name .. [[,
                        'identifier', ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[
                    )
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = loaf_properties.owner
            ) as owner,
            (
                SELECT
                    CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', id, 'createdAt', createdAt)), ']')
                FROM
                    mdt_warrants
                WHERE
                    mdt_warrants.house = loaf_properties.id
            ) AS warrants
        FROM
            loaf_properties
        WHERE
            loaf_properties.id = ?
    ]], { id })

    if not house then
        return nil
    end
    
    local data = exports['loaf_housing']:GetHouse(house.propertyid)

    house.propertyid = nil
    house.label = data?.label
    house.coords = { x = data.entrance.x,  y = data.entrance.y, z = data.entrance.z }
    house.owner = json.decode(house.owner)
    house.warrants = json.decode(house.warrants)

    return house
end

function GetCitizenHouses(identifier)
    local houses = MySQL.Sync.fetchAll('SELECT propertyid, id FROM loaf_properties WHERE owner = ?', { identifier })

    for i = 1, #houses do
        local label = exports['loaf_housing']:GetHouse(houses[i].propertyid)?.label
        
        houses[i].propertyid = nil
        houses[i].label = label
    end

    return houses
end