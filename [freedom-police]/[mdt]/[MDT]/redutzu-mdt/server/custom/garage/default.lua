if Config.Garage ~= 'default' then
    return
end

function GetVehicles(searchQuery)
    local query = replacePlaceholders([[
        SELECT
            $plate,
            (
                SELECT
                    JSON_OBJECT(
                        'identifier', $identifier,
                        'name', $name
                    )
                FROM
                    $citizens
                WHERE
                    $identifier = $owner
            ) AS owner
        FROM
            $table
        WHERE
            $plate LIKE :query
        LIMIT :limit
    ]], {
        plate = ('%s.%s'):format(vehicles.table, vehicles.identifier),
        identifier = ('%s.%s'):format(citizens.table, citizens.identifier),
        owner = ('%s.%s'):format(vehicles.table, vehicles.ownerColumn),
        name = citizens.name,
        citizens = citizens.table,
        table = vehicles.table
    })

    local vehicles = MySQL.Sync.fetchAll(query, {
        query = '%' .. searchQuery .. '%',
        limit = Config.Settings.MaximumResults
    })

    for i = 1, #vehicles do
        -- Only decode if there is an owner
        if type(vehicles[i].owner) == 'string' then
            vehicles[i].owner = json.decode(vehicles[i].owner)
        elseif not vehicles[i].owner then
            vehicles[i].owner = {
                name = '', -- You can change this if you want to show something if the vehicle is not owned
                identifier = nil
            }
        end
    end

    return vehicles
end

function GetVehicleData(plate)
    if not plate then
        print('Missing Parameter - The "plate" parameter is required.')
        return
    end

    local hash = 'mdt_vehicles.model AS hash'
    local notes = 'mdt_vehicles.notes'
    local image = 'mdt_vehicles.image'

    if Config.UseExistentValues then
        if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
            hash = 'player_vehicles.hash'
            notes = 'player_vehicles.mdt_notes AS notes'
            image = 'player_vehicles.mdt_image AS image'
        elseif Config.Framework == 'esx' then
            hash = 'JSON_VALUE(owned_vehicles.vehicle, \'$.model\') AS hash'
            notes = 'owned_vehicles.mdt_notes AS notes'
            image = 'owned_vehicles.mdt_image AS image'
        end
    end

    local query = replacePlaceholders([[
        SELECT
            $plate,
            $hash,
            $notes,
            $image,
            (
                SELECT
                    JSON_OBJECT('identifier', $citizenIdentifier, 'name', $citizenName)
                FROM
                    $citizens
                WHERE
                    $citizenIdentifier = $owner
            ) AS owner,
            (
                SELECT
                    CONCAT('[',
                        GROUP_CONCAT(
                            JSON_OBJECT(
                                'id', mdt_gallery.id,
                                'value', mdt_gallery.value,
                                'description', mdt_gallery.description
                            )
                        ),
                    ']')
                FROM
                    mdt_gallery
                WHERE
                    mdt_gallery.identifier = $plate
                AND
                    mdt_gallery.type = 'vehicle'
            ) AS gallery,
            (
                SELECT
                    CONCAT('[',
                        GROUP_CONCAT(
                            JSON_OBJECT(
                                'id', mdt_incidents.id,
                                'createdAt', mdt_incidents.createdAt
                            )
                        ),
                    ']')
                FROM
                    mdt_incidents
                WHERE
                    JSON_CONTAINS(mdt_incidents.vehicles, JSON_QUOTE($plate))
            ) AS incidents,
            (
                SELECT
                    CONCAT('[',
                        GROUP_CONCAT(
                            JSON_OBJECT(
                                'id', mdt_bolos.id,
                                'createdAt', mdt_bolos.createdAt
                            )
                        ),
                    ']')
                FROM
                    mdt_bolos
                WHERE
                    mdt_bolos.vehicle = $plate
            ) AS bolos
        FROM
            $table
        WHERE
            $plate = ?
    ]], {
        citizens = citizens.table,
        citizenName = citizens.name,
        citizenIdentifier = ('%s.%s'):format(citizens.table, citizens.identifier),
        plate = ('%s.%s'):format(vehicles.table, vehicles.identifier),
        owner = ('%s.%s'):format(vehicles.table, vehicles.ownerColumn),
        table = vehicles.table,
        hash = hash,
        notes = notes,
        image = image
    })

    local vehicle = MySQL.Sync.fetchSingle(query, { plate })

    if not vehicle then
        print('The vehicle with the specified plate was not found.')
        return
    end

    if not Config.UseExistentValues then
        vehicle.hash = GetHashKey(vehicle.hash)
    elseif Config.Framework ~= 'standalone' then
        vehicle.hash = tonumber(vehicle.hash)
    end

    if type(vehicle.owner) == 'string' then
        vehicle.owner = json.decode(vehicle.owner)
    end

    vehicle.insurance = GetVehicleInsurance(vehicle.plate)
    vehicle.images = json.decode(vehicle.gallery) or {}
    vehicle.incidents = json.decode(vehicle.incidents) or {}
    vehicle.bolos = json.decode(vehicle.bolos) or {}

    return vehicle
end