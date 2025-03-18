if Config.Garage ~= 'custom' then
    return
end

---Returns a list of vehicles related to the search query
---@param query string
---@return [{ plate: string, owner?: { identifier?: string, name: string } }, ...]
function GetVehicles(query)
    local vehicles = {
        {
            plate = 'ABC123',
            owner = {
                identifier = 'license:1234',
                name = 'Firstname Lastname'
            }
        }
    }

    return vehicles
end

---Returns a the house data
---@param plate string
---@return { plate: string, hash: string, notes?: string, image?: string, owner?: { identifier: string, name: string }, gallery: [...], incidents: [...], bolos: [...] }
function GetVehicleData(plate)
    local vehicle = {
        plate = 'ABC123',
        hash = '-986944621',
        notes = 'Color: Red Metalic, Type: Sport',
        image = nil,
        owner = {
            identifier = 'license:1234',
            name = 'Firstname Lastname' 
        },
        gallery = {{ id = 15, value = 'https://www.link.com/', description = 'Image description' }},
        incidents = {{ id = 2, createdAt = '2024-06-03 01:00:00' }},
        bolos = {{ id = 5, createdAt = '2024-06-03 01:00:00' }}
    }

    return vehicle
end