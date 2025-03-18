local QBCore = exports[Config.Core]:GetCoreObject()

local function CheckAndSendDataToClient(src, allInsuranceData)
    if allInsuranceData.carInsurance and allInsuranceData.healthInsurance and allInsuranceData.homeInsurance then
        TriggerClientEvent("m-Insurance:Client:OpenMainInsuranceMenu", src, allInsuranceData)
    end
end

local function convertTimestampToDate(timestamp)
    if not timestamp then return "N/A" end
    local seconds = math.floor(timestamp / 1000)
    local date = os.date("!*t", seconds)
    return string.format("%02d/%02d/%04d", date.day, date.month, date.year)
end

-- Commands
if Config.carInsurance.needJob then
    QBCore.Commands.Add(Config.Commands["general"][1].command, Config.Commands["general"][1].description, {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        local allowed = false
        for _, job in ipairs(Config.Commands["general"][1].jobs) do
            if Player.PlayerData.job.name == job then
                allowed = true
                break
            end
        end

        if allowed then
            TriggerClientEvent('m-Insurance:Client:OpenInsuranceMenu', src)
        else
            TriggerClientEvent('m-Insurance:Client:Notify', src, 'You are not authorized to use this command.', 'error', 5000)
        end
    end)
end

if Config.healthInsurance.needJob then
    QBCore.Commands.Add(Config.Commands["general"][2].command, Config.Commands["general"][2].description, {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        local allowed = false
        for _, job in ipairs(Config.Commands["general"][2].jobs) do
            if Player.PlayerData.job.name == job then
                allowed = true
                break
            end
        end

        if allowed then
            TriggerClientEvent('m-Insurance:Client:OpenHealthInsuranceMenu', src)
        else
            TriggerClientEvent('m-Insurance:Client:Notify', src, 'You are not authorized to use this command.', 'error', 5000)
        end
    end)
end

if Config.homeInsurance.needJob then
    QBCore.Commands.Add(Config.Commands["general"][3].command, Config.Commands["general"][3].description, {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        local allowed = false
        for _, job in ipairs(Config.Commands["general"][3].jobs) do
            if Player.PlayerData.job.name == job then
                allowed = true
                break
            end
        end

        if allowed then
            TriggerClientEvent('m-Insurance:Client:OpenHomeInsuranceMenu', src)
        else
            TriggerClientEvent('m-Insurance:Client:Notify', src, 'You are not authorized to use this command.', 'error', 5000)
        end
    end)
end

QBCore.Commands.Add(Config.Commands["police"][1].command, Config.Commands["police"][1].description, {{ name = "Plate", help = "Insert the vehicle plate"}}, false, function(source, args)
    local plate = table.concat(args, " ")
    if not plate or plate == "" then
        TriggerClientEvent('m-Insurance:Client:Notify', source, 'Please provide a valid plate.', 'error', 5000)
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)

    local allowed = false
    for _, job in ipairs(Config.Commands["police"][1].jobs) do
        if Player.PlayerData.job.name == job then
            allowed = true
            break
        end
    end

    if not allowed then
        TriggerClientEvent('m-Insurance:Client:Notify', source, 'You are not authorized to use this command.', 'error', 5000)
        return
    end

    MySQL.Async.fetchAll("SELECT plate FROM player_vehicles WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(playerVehiclesResult)
        if not playerVehiclesResult[1] then
            TriggerClientEvent('m-Insurance:Client:Notify', source, 'This plate does not exist in the vehicle database.', 'error', 5000)
            return
        end

        local foundPlate = playerVehiclesResult[1].plate

        MySQL.Async.fetchAll("SELECT * FROM m_insurance_vehicles WHERE plate = @plate", {
            ['@plate'] = foundPlate
        }, function(insuranceResult)
            local owner_name = "Unknown"
            local stolen = false
            local suspended = false
            local insurance = false

            if insuranceResult[1] then
                owner_name = insuranceResult[1].owner_name or "Unknown"
                stolen = insuranceResult[1].stolen or false
                suspended = insuranceResult[1].documents_suspended or false
                insurance = true
            end

            MySQL.Async.fetchAll("SELECT * FROM m_insurance_registration WHERE plate = @plate", {
                ['@plate'] = foundPlate
            }, function(registrationResult)
                local registration = registrationResult[1] ~= nil

                local data = {
                    plate = foundPlate,
                    insurance = insurance,
                    registration = registration,
                    owner = owner_name,
                    stolen = stolen,
                    suspended = suspended,
                }
                
                TriggerClientEvent("m-Insurance:Client:OpenInsuranceMenuPolice", source, data)
            end)
        end)
    end)
end, 'user')


QBCore.Commands.Add(Config.Commands["general"][4].command, Config.Commands["general"][4].description, {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    local allInsuranceData = {}

    MySQL.Async.fetchAll('SELECT * FROM m_insurance_vehicles WHERE citizenid = @citizenid', {
        ['@citizenid'] = citizenid
    }, function(insuranceResult)
        if insuranceResult and #insuranceResult > 0 then
            local vehiclesData = {}
            for _, vehicle in ipairs(insuranceResult) do
                local plate = vehicle.plate
                local owner_name = vehicle.owner_name or "Unknown"
                local stolen = vehicle.stolen
                local suspended = vehicle.documents_suspended
                local insuranceExpire = convertTimestampToDate(vehicle.expire_date)

                MySQL.Async.fetchAll('SELECT * FROM m_insurance_registration WHERE plate = @plate', {
                    ['@plate'] = plate
                }, function(registrationResult)
                    local registrationExpire = registrationResult[1] and convertTimestampToDate(registrationResult[1].expire_date) or "N/A"
                    
                    local data = {
                        plate = plate,
                        insurance = true,
                        registration = registrationResult[1] ~= nil,
                        owner = owner_name,
                        stolen = stolen,
                        suspended = suspended,
                        insuranceExpire = insuranceExpire,
                        registrationExpire = registrationExpire
                    }
                    table.insert(vehiclesData, data)

                    if #vehiclesData == #insuranceResult then
                        allInsuranceData.carInsurance = vehiclesData
                        CheckAndSendDataToClient(src, allInsuranceData)
                    end
                end)
            end
        else
            allInsuranceData.carInsurance = {}
            CheckAndSendDataToClient(src, allInsuranceData)
        end
    end)

    MySQL.Async.fetchAll('SELECT * FROM m_insurance_health WHERE citizenid = @citizenid', {
        ['@citizenid'] = citizenid
    }, function(insuranceResult)
        if insuranceResult and #insuranceResult > 0 then
            local healthInsuranceData = {}
            for _, health in ipairs(insuranceResult) do
                local expirationDate = convertTimestampToDate(health.expire_date)
                table.insert(healthInsuranceData, {
                    owner_name = health.owner_name or "Unknown",
                    expire_date = expirationDate
                })
            end
            allInsuranceData.healthInsurance = healthInsuranceData
        else
            allInsuranceData.healthInsurance = {}
        end
        CheckAndSendDataToClient(src, allInsuranceData)
    end)

    MySQL.Async.fetchAll('SELECT * FROM m_insurance_home WHERE citizenid = @citizenid', {
        ['@citizenid'] = citizenid
    }, function(insuranceResult)
        if insuranceResult and #insuranceResult > 0 then
            local homeInsuranceData = {}
            for _, home in ipairs(insuranceResult) do
                local expirationDate = convertTimestampToDate(home.expire_date)
                table.insert(homeInsuranceData, {
                    owner_name = home.owner_name or "Unknown",
                    expire_date = expirationDate
                })
            end
            allInsuranceData.homeInsurance = homeInsuranceData
        else
            allInsuranceData.homeInsurance = {}
        end
        CheckAndSendDataToClient(src, allInsuranceData)
    end)
end)
