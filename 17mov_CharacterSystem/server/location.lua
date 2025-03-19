if Config.Framework ~= "QBCore" then return end

if Location.EnableApartments == true then
    Location.EnableApartments = 'qb-apartments'
end

Citizen.CreateThread(function()
    if Location.EnableApartments == 'qb-apartments' then
        local configContent = LoadResourceFile("qb-apartments", "config.lua")
        if configContent then
            local ApartmentsConfig = load(configContent)
            if ApartmentsConfig then
                ApartmentsConfig()
            end
        end
    elseif Location.EnableApartments == 'ps-housing' then

        local configContent = LoadResourceFile("ps-housing", "shared/config.lua")
        local pattern = "Config%.Apartments%s*=%s*(%b{})"
        local apartmentsString = configContent:match(pattern)
        if not apartmentsString then
            return error("FAILED TO LOAD CONFIG.APARTMENTS FROM PS-HOUSING")
        end
        
        Apartments = {
            Locations = load("return "..apartmentsString)()
        }
        for apartmentID, data in pairs(Apartments.Locations) do
            data.name = apartmentID
            data.coords = {enter = vec4(data.door.x, data.door.y, data.door.z, data.door.h)}
        end
    end
end)


Functions.RegisterServerCallback("17mov_CharacterSystem:getApartmentsConfiguration", function(_)
    ---@diagnostic disable-next-line: undefined-global
    return Apartments?.Locations
end)

Citizen.CreateThread(function()
    Core?.Functions.CreateCallback("ps-housing:cb:GetOwnedApartment", function(source, cb, cid)
        local result
        if cid ~= nil then
            local success, err = pcall(function()
                result = Core?.query.await('SELECT * FROM properties WHERE owner_citizenid = ? AND apartment IS NOT NULL AND apartment <> ""', { cid })
            end)
            if not success then
                print("Error querying database for owned apartment with cid: " .. cid .. " - " .. err)
                return cb(nil)
            end
        else
            local src = source
            local Player = Core?.Functions.GetPlayer(src)
            if not Player then
                print("Error: Player not found for source: " .. src)
                return cb(nil)
            end
            local success, err = pcall(function()
                result = MySQL.query.await('SELECT * FROM properties WHERE owner_citizenid = ? AND apartment IS NOT NULL AND apartment <> ""', { Player.PlayerData.citizenid })
            end)
            if not success then
                print("Error querying database for owned apartment with citizenid: " .. Player.PlayerData.citizenid .. " - " .. err)
                return cb(nil)
            end
        end
    
        if result and result[1] then
            return cb(result[1])
        else
            print("No owned apartment found for the given criteria.")
            return cb(nil)
        end
    end)
end)


RegisterNetEvent("apartments:server:setCurrentApartment", function()
    TriggerClientEvent("17mov_CharacterSystem:PlayerEnteredApartment", source)
end)