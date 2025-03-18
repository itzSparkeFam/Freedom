if Config.Housing ~= 'custom' then
    return
end

---Returns a list of houses related to the search query
---@param query string
---@return [{ id: number, label: string, owner?: string }, ...]
function GetHouses(query)
    local houses = {
        { id = 1, label = 'House name', owner = 'Owner name' }
    }

    return houses
end

---Returns a the house data
---@param id string
---@return { id: number, label: string, coords: { x: number; y: number; z: number; }, owner?: { name: string; identifier: string; }, warrants?: [...] }
function GetHouseData(id)
    return {
        id = 1,
        label = 'House name',
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        owner = {
            name = 'Owner name',
            identifier = 'Owner identifier'
        },
        warrants = {}
    }
end

---Returns the houses of a citizen
---@param identifier string
---@return { id: number, label: string }
function GetCitizenHouses(identifier)
    return {
        { id = 1, label = 'House name' }
    }
end