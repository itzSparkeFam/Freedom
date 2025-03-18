if Config.Housing ~= 'ps-housing' then
    return
end

if Config.Framework ~= 'qb-core' then
    Config.Housing = 'default'
    debugPrint('This housing script (ps-housing) works only on QBCore')
end

function GetHouses(query)
    local houses = MySQL.Sync.fetchAll([[
        SELECT
            properties.property_id AS id,
            properties.street AS label,
            (
                SELECT
                    CONCAT(JSON_VALUE(charinfo, '$.firstname'), ' ', JSON_VALUE(charinfo, '$.lastname'))
                FROM
                    players
                WHERE
                    players.citizenid = properties.owner_citizenid
            ) AS owner
        FROM
            properties
        WHERE
            properties.street LIKE ?
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
            properties.property_id AS id,
            properties.street AS label,
            properties.door_data AS coords,
            (
                SELECT
                    JSON_OBJECT(
                        'name', CONCAT(JSON_VALUE(charinfo, '$.firstname'), ' ', JSON_VALUE(charinfo, '$.lastname')),
                        'identifier', players.citizenid
                    )
                FROM
                    players
                WHERE
                    players.citizenid = properties.owner_citizenid
            ) as owner,
            (
                SELECT
                    CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', id, 'createdAt', createdAt)), ']')
                FROM
                    mdt_warrants
                WHERE
                    mdt_warrants.house = properties.property_id
            ) AS warrants
        FROM
            properties
        WHERE
            properties.property_id = ?
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
    local houses = MySQL.Sync.fetchAll('SELECT property_id AS id, street AS label FROM properties WHERE owner_citizenid = ?', { identifier })
    return houses
end