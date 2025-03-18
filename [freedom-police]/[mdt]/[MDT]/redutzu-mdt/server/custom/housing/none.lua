-- This file disables the housing script in your MDT
if Config.Housing ~= 'none' then
    return
end

-- NOTE: Go to "config/config.lua", search for Config.Pages and set disabled to true for "houses"
-- Defining the functions as placeholders

function GetHouses()
    return {}
end

function GetHouseData()
    return nil
end

function GetCitizenHouses()
    return {}
end