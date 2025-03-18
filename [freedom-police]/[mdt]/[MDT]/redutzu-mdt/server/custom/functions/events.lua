---This event is fired when a record is created
---@param type string (incident, evidence, warrant, etc.)
---@param data table
---@param source number
RegisterNetEvent('redutzu-mdt:server:onCreate', function(type, data, source)

end)

---This event is fired when a record is updated
---@param type string (incident, evidence, warrant, etc.)
---@param identifier string | number (This is the id of the record)
---@param data table
---@param source number
RegisterNetEvent('redutzu-mdt:server:onUpdate', function(type, identifier, data, source)

end)

---This event is fired when a record is deleted
---@param type string (incident, evidence, warrant, etc.)
---@param id string | number (This is the id of the record)
---@param source number
RegisterNetEvent('redutzu-mdt:server:onDelete', function(type, id, source)

end)