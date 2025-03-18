if Config.Housing ~= 'quasar-housing' then
    return
end

local identifierName = 'citizenid' -- Change this to identifier if you are using older version (ESX only)

function GetHouses(query)
    local houses = MySQL.Sync.fetchAll([[
        SELECT
            houselocations.id,
            houselocations.label,
            (
                SELECT
                    ]] .. citizens.name .. [[
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = player_houses.]] .. identifierName .. [[
            ) AS owner
        FROM
            houselocations
        LEFT JOIN
            player_houses ON houselocations.name = player_houses.house
        WHERE
            houselocations.label LIKE ?
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
            houselocations.id,
            houselocations.label,
            JSON_EXTRACT(houselocations.coords, '$.enter') AS coords,
            (
                SELECT
                    JSON_OBJECT(
                        'name', ]] .. citizens.name .. [[,
                        'identifier', ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[
                    )
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = player_houses.]] .. identifierName .. [[
            ) as owner,
            (
                SELECT
                    CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', id, 'createdAt', createdAt)), ']')
                FROM
                    mdt_warrants
                WHERE
                    mdt_warrants.house = houselocations.id
            ) AS warrants
        FROM
            houselocations
        LEFT JOIN
            player_houses ON houselocations.name = player_houses.house
        WHERE
            houselocations.id = ?
    ]], { id })

    
    if not house then
        return nil
    end
    
    house.owner = json.decode(house.owner)
    house.warrants = json.decode(house.warrants)
    house.coords = json.decode(house.coords)
    
    return house
end

function GetCitizenHouses(identifier)
    local houses = MySQL.Sync.fetchAll(
        replacePlaceholders([[
            SELECT
                houselocations.id,
                houselocations.label
            FROM
                houselocations
            LEFT JOIN
                player_houses ON houselocations.name = player_houses.house
            WHERE
                player_houses.$column = ?
        ]], {
            column = identifierName
        })
    , { identifier })

    return houses
end