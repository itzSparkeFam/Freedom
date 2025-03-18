if Config.Housing ~= 'bcs_housing' then
    return
end

if Config.Framework ~= 'qb-core' and Config.Framework ~= 'esx' then
    Config.Housing = 'default'
    debugPrint('This housing script (bcs_housing) works only on QBCore and ESX')
end

function GetHouses(query)
    local houses = MySQL.Sync.fetchAll([[
        SELECT
            house.identifier AS id,
            house.name AS label,
            (
                SELECT
                    ]] .. citizens.name .. [[
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = house_owned.owner
            ) AS owner
        FROM
            house
        LEFT JOIN
            house_owned ON house_owned.identifier = house.identifier
        WHERE
            house.identifier LIKE ?
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
            house.identifier AS id,
            house.name AS label,
            house.entry AS coords,
            (
                SELECT
                    JSON_OBJECT(
                        'name', ]] .. citizens.name .. [[,
                        'identifier', ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[
                    )
                FROM
                    ]] .. citizens.table .. [[
                WHERE
                    ]] .. ('%s.%s'):format(citizens.table, citizens.identifier) .. [[ = house_owned.owner
            ) AS owner,
            (
                SELECT
                    CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', id, 'createdAt', createdAt)), ']')
                FROM
                    mdt_warrants
                WHERE
                    mdt_warrants.house = house.identifier
            ) AS warrants
        FROM
            house
        LEFT JOIN
            house_owned ON house_owned.identifier = house.identifier
        WHERE
            house.identifier = ?
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
            house.identifier AS id,
            house.name AS label
        FROM
            house_owned
        LEFT JOIN
            house ON house.identifier = house_owned.identifier COLLATE utf8mb4_unicode_ci
        WHERE
            house_owned.owner = ?
    ]], { identifier })

    return houses
end