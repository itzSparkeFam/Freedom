if Config.Housing ~= 'default' then
    return
end

if Config.Framework == 'qb-core' then
    debugPrint('Housing script is set to: qb-houses')
elseif Config.Framework == 'esx' then
    debugPrint('Housing script is set to: esx_property')
end

function GetHouses(query)
    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local houses = MySQL.Sync.fetchAll([[
            SELECT 
                houselocations.id,
                houselocations.label,
                IF(player_houses.id, (
                    SELECT
                        CONCAT(JSON_VALUE(charinfo, '$.firstname'), ' ', JSON_VALUE(charinfo, '$.lastname'))
                    FROM
                        players
                    WHERE
                        players.citizenid = player_houses.citizenid
                ), NULL) AS owner
            FROM 
                houselocations 
            LEFT JOIN
                player_houses ON houselocations.name = player_houses.house
            WHERE
                houselocations.label LIKE :query
            LIMIT :limit
        ]], {
            query = '%' .. query .. '%',
            limit = Config.Settings.MaximumResults
        })

        for i = 1, #houses do
            if not houses[i].owner then
                houses[i].owner = 'No owner'
            end
        end

        return houses
    elseif Config.Framework == 'esx' then
        local properties = exports['esx_property']:GetProperties()
        local houses = array.filter(properties, function(property, index)
            return match(query, tostring(index)) or match(query, property.Name)
        end)

        return array.map(houses, function(property, index)
            return {
                id = index,
                label = ('%s (#%s)'):format(property.Name, index),
                owner = property.Owned and property.OwnerName or 'No owner'
            }
        end)
    end
end

function GetHouseData(id)
    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local house = MySQL.Sync.fetchSingle([[
            SELECT 
                houselocations.id,
                houselocations.label,
                houselocations.coords,
                houselocations.owned,
                COALESCE(player_houses.citizenid, NULL) AS owner_identifier,
                CONCAT_WS(' ', JSON_VALUE(players.charinfo, '$.firstname'), JSON_VALUE(players.charinfo, '$.lastname')) AS owner_name,
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
                player_houses ON player_houses.house = houselocations.name AND houselocations.owned = 1
            LEFT JOIN 
                players ON player_houses.citizenid = players.citizenid
            WHERE 
                houselocations.id = ?
        ]], { id })

        if not house then
            return nil
        end

        house.coords = json.decode(house.coords)?.enter
        house.warrants = json.decode(house.warrants)
        
        if house.owned then
            house.owner = {
                name = house.owner_name,
                identifier = house.owner_identifier
            }
        end

        return house
    elseif Config.Framework == 'esx' then
        local properties = exports['esx_property']:GetProperties()
        local property = array.find(properties, function(prop, index)
            return tostring(index) == id
        end)
        
        if not property then
            return nil
        end

        local data = MySQL.Sync.fetchSingle([[
            SELECT CONCAT('[', GROUP_CONCAT(JSON_OBJECT('id', id, 'createdAt', createdAt)), ']') AS warrants
            FROM mdt_warrants WHERE mdt_warrants.house = ?
        ]], { id })

        return {
            id = id,
            label = property.Name,
            coords = property.Entrance,
            owner = property.Owned and {
                name = property.OwnerName,
                identifier = property.Owner
            } or nil,
            warrants = json.decode(data.warrants)
        }
    end
end

function GetCitizenHouses(identifier)
    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        return MySQL.Sync.fetchAll([[
            SELECT
                player_houses.id,
                (
                    SELECT
                        label
                    FROM
                        houselocations
                    WHERE
                        houselocations.name = player_houses.house
                ) AS label
            FROM
                player_houses
            WHERE
                player_houses.citizenid = ?
        ]], { identifier })
    elseif Config.Framework == 'esx' then
        local properties = exports['esx_property']:GetPlayerProperties(identifier)

        return array.map(properties, function(property, index)
            return {
                id = index,
                label = property.Name
            }
        end)
    end
end