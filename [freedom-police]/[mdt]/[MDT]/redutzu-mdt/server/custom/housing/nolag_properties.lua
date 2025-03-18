if Config.Housing ~= 'nolag_properties' then
    return
end

function GetHouses(query)
    local houses = MySQL.Sync.fetchAll([[
        SELECT
            properties.id,
            properties.label,
            (
                SELECT
                    ]] .. citizens.name .. [[
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = properties_owners.identifier
            ) AS owner
        FROM
            properties
        INNER JOIN
            properties_owners ON properties.ownerid = properties_owners.id
        WHERE
            properties.label LIKE ?
    ]], { '%' .. query .. '%' })

    for i = 1, #houses do
        if not houses[i].owner then
            houses[i].owner = 'No owner'
        end
    end

    return houses
end

function GetHouseData(id)
    local house = MySQL.Sync.fetchSingle([[
        SELECT
            properties.id,
            properties.label,
            CASE
                WHEN properties.type = 'MLO' THEN 
                    JSON_EXTRACT(properties.metadata, '$.yardZone.center')
                WHEN properties.buildingid IS NOT NULL THEN
                    JSON_EXTRACT(buildings.metadata, '$.enterData')
                ELSE
                    JSON_EXTRACT(properties.metadata, '$.enterData')
            END AS coords,
            (
                SELECT
                    JSON_OBJECT(
                        'name', ]] .. citizens.name .. [[,
                        'identifier', ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[
                    )
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = properties_owners.identifier
            ) as owner,
            (
                SELECT
                    CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', id, 'createdAt', createdAt)), ']')
                FROM
                    mdt_warrants
                WHERE
                    mdt_warrants.house = properties.id
            ) AS warrants
        FROM
            properties
        LEFT JOIN
            buildings ON properties.buildingId = buildings.id
        INNER JOIN
            properties_owners ON properties.ownerid = properties_owners.id
        WHERE
            properties.id = ?
    ]], { id })

    if not house then
        return nil
    end
    
    house.coords = json.decode(house.coords)
    house.owner = json.decode(house.owner)
    house.warrants = json.decode(house.warrants)

    return house
end

function GetCitizenHouses(identifier)
    local houses = MySQL.Sync.fetchAll([[
        SELECT
            properties.id,
            properties.label
        FROM
            properties
        INNER JOIN
            properties_owners ON properties.ownerid = properties_owners.id
        WHERE
            properties_owners.identifier = ?
    ]], { identifier })
    return houses
end