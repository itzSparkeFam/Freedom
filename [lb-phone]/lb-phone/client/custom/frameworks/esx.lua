if Config.Framework ~= "esx" then
    return
end

debugprint("Loading ESX")
local export, obj = pcall(function()
    return exports.es_extended:getSharedObject()
end)

if export then
    ESX = obj
else
    while not ESX do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
        Wait(500)
    end
end

local isFirst = true
RegisterNetEvent("esx:playerLoaded", function(playerData)
    ESX.PlayerData = playerData
    ESX.PlayerLoaded = true

    if not isFirst then
        FetchPhone()
    end

    isFirst = false
end)

RegisterNetEvent("esx:onPlayerLogout", function()
    LogOut()
end)

while not ESX.PlayerLoaded do
    Wait(500)
end

RegisterNetEvent("esx:setJob", function(job)
    local oldJob = ESX.PlayerData.job

    ESX.PlayerData.job = job

    if oldJob.name ~= job.name or oldJob.grade ~= job.grade then
        SendReactMessage("services:setCompany", GetCompanyData())
    else
        SendReactMessage("services:setDuty", job.onDuty)
    end
end)

RegisterNetEvent("esx:setAccountMoney", function(account)
    if account.name ~= "bank" then
        return
    end

    SendReactMessage("wallet:setBalance", math.floor(account.money))
end)

debugprint("ESX loaded")
loaded = true

---@param itemName string
---@return boolean
function HasItem(itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", itemName) or 0) > 0
    elseif GetResourceState("qs-inventory") == "started" then
        return (exports["qs-inventory"]:Search(itemName) or 0) > 0
    end

    if ESX.SearchInventory then
        return (ESX.SearchInventory(itemName, 1) or 0) > 0
    end

    local inventory = ESX.GetPlayerData()?.inventory

    if not inventory then
        infoprint("warning", "Unsupported inventory, tell the inventory author to add support for it.")
        return false
    end

    debugprint("inventory", inventory)

    for i = 1, #inventory do
        local item = inventory[i]

        if item.name == itemName and item.count > 0 then
            return true
        end
    end

    return false
end

RegisterNetEvent("phone:usedPhoneVariation", function(variation)
    if not variation or not Config.Item.Names[variation] then
        return
    end

    phoneVariation = variation
    SetPhoneVariation(variation)
    ToggleOpen(true)
end)

---Check if the player has a job
---@param jobs table
---@return boolean
function HasJob(jobs)
    local job = ESX.PlayerData.job.name
    for i = 1, #jobs do
        if jobs[i] == job then
            return true
        end
    end
    return false
end

---Apply vehicle mods
---@param vehicle number
---@param vehicleData table
function ApplyVehicleMods(vehicle, vehicleData)
    if type(vehicleData.vehicle) == "string" then
        vehicleData.vehicle = json.decode(vehicleData.vehicle)
    end

    SetVehicleOnGroundProperly(vehicle)
    SetVehicleNumberPlateText(vehicle, vehicleData.vehicle.plate)

    ESX.Game.SetVehicleProperties(vehicle, vehicleData.vehicle)

    if vehicleData.damages and not Config.Valet.DisableDamages then
        SetVehicleEngineHealth(vehicle, vehicleData.damages.engineHealth)
        SetVehicleBodyHealth(vehicle, vehicleData.damages.bodyHealth)
    end

    if vehicleData.vehicle.fuel then
        SetVehicleFuelLevel(vehicle, vehicleData.vehicle.fuel)
    end

    if Config.Valet.FixTakeOut then
        SetVehicleFixed(vehicle)
    end
end

---Create a vehicle and apply vehicle mods
---@param vehicleData table
---@param coords vector3
---@return number? vehicle
function CreateFrameworkVehicle(vehicleData, coords)
    vehicleData.vehicle = json.decode(vehicleData.vehicle)
    if vehicleData.damages then
        vehicleData.damages = json.decode(vehicleData.damages)
    end

    local model = LoadModel(vehicleData.vehicle.model)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, 0.0, true, false)

    SetVehicleOnGroundProperly(vehicle)
    ApplyVehicleMods(vehicle, vehicleData)
    SetModelAsNoLongerNeeded(model)

    return vehicle
end

--#region Services app

function GetCompanyData()
    local companyData = {
        job = ESX.PlayerData.job.name,
        jobLabel = ESX.PlayerData.job.label,
        isBoss = ESX.PlayerData.job.grade_name == "boss",
        duty = ESX.PlayerData.job.onDuty
    }

    if not companyData.isBoss then
        for cId = 1, #Config.Companies.Services do
            local company = Config.Companies.Services[cId]

            if company.job == companyData.job then
                if not company.bossRanks then
                    break
                end

                companyData.isBoss = table.contains(company.bossRanks, ESX.PlayerData.job.grade_name)

                break
            end
        end
    end

    if not companyData.isBoss then
        return companyData
    end

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
        companyData.balance = money
    end, companyData.job)

    ESX.TriggerServerCallback("esx_society:getEmployees", function(employees)
        for i = 1, #employees do
            local employee = employees[i]

            employees[i] = {
                name = employee.name,
                id = employee.identifier,

                gradeLabel = employee.job.grade_label,
                grade = employee.job.grade,

                canInteract = employee.job.grade_name ~= "boss"
            }
        end

        companyData.employees = employees
    end, companyData.job)

    ESX.TriggerServerCallback("esx_society:getJob", function(job)
        local grades = {}

        for i = 1, #job.grades do
            local grade = job.grades[i]

            grades[i] = {
                label = grade.label,
                grade = grade.grade
            }
        end

        companyData.grades = grades
    end, companyData.job)

    local timeout = GetGameTimer() + 2000

    while not companyData.balance or not companyData.employees or not companyData.grades do
        Wait(0)

        if GetGameTimer() > timeout then
            infoprint("error", "Failed to get company data (timed out after 2s)")
            print("balance: " .. tostring(companyData.balance))
            print("employees: " .. tostring(companyData.employees))
            print("grades: " .. tostring(companyData.grades))

            companyData.employees = companyData.employees or {}
            companyData.balance = companyData.balance or 0
            companyData.grades = companyData.grades or {}
            break
        end
    end

    return companyData
end

function DepositMoney(amount, cb)
    TriggerServerEvent("esx_society:depositMoney", ESX.PlayerData.job.name, amount)
    Wait(500) -- Wait for the server to update the balance

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", cb, ESX.PlayerData.job.name)
end

function WithdrawMoney(amount, cb)
    TriggerServerEvent("esx_society:withdrawMoney", ESX.PlayerData.job.name, amount)
    Wait(500) -- Wait for the server to update the balance

    ESX.TriggerServerCallback("esx_society:getSocietyMoney", cb, ESX.PlayerData.job.name)
end

function HireEmployee(source, cb)
    local playersPromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getOnlinePlayers", function(players)
        playersPromise:resolve(players)
    end)

    local players = Citizen.Await(playersPromise)
    local player

    for i = 1, #players do
        if players[i].source == source then
            player = players[i]
            break
        end
    end

    if not player then
        return false
    end

    local hirePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:setJob", function()
        hirePromise:resolve(true)
    end, player.identifier, ESX.PlayerData.job.name, 0, "hire")

    if not Citizen.Await(hirePromise) then
        return
    end

    return {
        id = player.identifier,
        name = player.name,
    }
end

function FireEmployee(identifier, cb)
    local firePomise = promise.new()

    ESX.TriggerServerCallback("esx_society:setJob", function()
        firePomise:resolve(true)
    end, identifier, "unemployed", 0, "fire")

    return Citizen.Await(firePomise)
end

function SetGrade(identifier, newGrade, cb)
    local promotePromise = promise.new()

    ESX.TriggerServerCallback("esx_society:getJob", function(jobData)
        if newGrade > #jobData.grades - 1 then
            return cb(false)
        end

        ESX.TriggerServerCallback("esx_society:setJob", function()
            promotePromise:resolve(true)
        end, identifier, ESX.PlayerData.job.name, newGrade, "promote")
    end, ESX.PlayerData.job.name)

    return Citizen.Await(promotePromise)
end

function ToggleDuty()
    TriggerServerEvent("phone:services:toggleDuty")
end

--#endregion

RegisterNetEvent("esx:removeInventoryItem", function(item, count)
    if not Config.Item.Require or Config.Item.Unique or item ~= Config.Item.Name or count > 0 then
        return
    end

    Wait(500)

    if not HasPhoneItem() then
        OnDeath()
    end
end)
