if Config.Framework ~= "standalone" then
    return
end

---@param source number
---@return string | nil
function GetIdentifier(source)
    for _, v in pairs(GetPlayerIdentifiers(source)) do
        if v:sub(1, #"license:") == "license:" then
            return v
        end
    end
end

---@param source number
---@param itemName string
function HasItem(source, itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search(source, "count", Config.Item.Name) or 0) > 0
    end

    return true
end

---Get a player's character name
---@param source any
---@return string # Firstname
---@return string # Lastname
function GetCharacterName(source)
    return GetPlayerName(source), ""
end

---Get an array of player sources with a specific job
---@param job string
---@return table # Player sources
function GetEmployees(job)
    return {}
end

---Get the bank balance of a player
---@param source any
---@return integer
function GetBalance(source)
    return 0
end

---Add money to a player's bank account
---@param source any
---@param amount integer
---@return boolean # Success
function AddMoney(source, amount)
    return true
end

---Remove money from a player's bank account
---@param source any
---@param amount integer
---@return boolean # Success
function RemoveMoney(source, amount)
    return true
end

---Send a message to a player
---@param source number
---@param message string
function Notify(source, message)
    TriggerClientEvent("chat:addMessage", source, {
        color = { 255, 255, 255 },
        multiline = true,
        args = { "Phone", message }
    })
end

-- GARAGE APP

---@param source number
---@return VehicleData[] vehicles An array of vehicles that the player owns
function GetPlayerVehicles(source)
    return {}
end

---Get a specific vehicle
---@param source number
---@param plate string
---@return table? vehicleData
function GetVehicle(source, plate)
end

function IsAdmin(source)
    return IsPlayerAceAllowed(source, "command.lbphone_admin") == 1
end

-- COMPANIES APP
function GetJob(source)
    return "unemployed"
end

function RefreshCompanies()
    return {}
end
