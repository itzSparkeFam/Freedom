if Config.Framework ~= "qbox" then
    return
end

---@diagnostic disable: param-type-mismatch
debugprint("Loading Qbox")

QB = exports["qb-core"]:GetCoreObject()

local PlayerJob = {}
local PlayerData = {}

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

debugprint("Qbox loaded")

loaded = true

PlayerJob = QB.Functions.GetPlayerData().job
PlayerData = QB.Functions.GetPlayerData()

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}

    LogOut()
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QB.Functions.GetPlayerData()

    FetchPhone()
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)
    PlayerData = newData

    if not Config.Item.Require or Config.Item.Unique then
        return
    end

    Wait(500)

    if currentPhone and not HasPhoneItem() then
        OnDeath()
    end
end)

RegisterNetEvent("QBCore:Client:SetDuty", function(onDuty)
    PlayerJob.onduty = onDuty

    SendReactMessage("services:setDuty", onDuty)
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(jobInfo)
    local oldJob = PlayerJob

    PlayerJob = jobInfo

    if oldJob.name ~= PlayerJob.name or oldJob.grade?.level ~= PlayerJob.grade?.level then
        SendReactMessage("services:setCompany", GetCompanyData())
    end
end)

RegisterNetEvent("QBCore:Client:OnMoneyChange", function(moneyType)
    if moneyType ~= "bank" then
        return
    end

    SendReactMessage("wallet:setBalance", math.floor(PlayerData.money.bank))
end)

local phoneVariation

---@param itemName string
---@return boolean
function HasItem(itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search("count", itemName) or 0) > 0
    end

    return QB.Functions.HasItem(itemName)
end

RegisterNetEvent("phone:usedPhoneVariation", function(variation)
    if not variation or not Config.Item.Names[variation] then
        return
    end

    phoneVariation = variation
    SetPhoneVariation(variation)
    ToggleOpen(true)
end)

---@param jobs table
---@return boolean
function HasJob(jobs)
    local job = PlayerJob.name

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
    if type(vehicleData.mods) == "string" then
        vehicleData.mods = json.decode(vehicleData.mods)
    end

    SetVehicleNumberPlateText(vehicle, vehicleData.plate)

    QB.Functions.SetVehicleProperties(vehicle, vehicleData.mods)
    TriggerEvent("vehiclekeys:client:SetOwner", QB.Functions.GetPlate(vehicle))

    if GetResourceState("LegacyFuel") == "started" and vehicleData.fuel then
        exports.LegacyFuel:SetFuel(vehicle, vehicleData.fuel)
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
    local model = LoadModel(tonumber(vehicleData.hash))
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, 0.0, true, false)

    SetVehicleOnGroundProperly(vehicle)
    ApplyVehicleMods(vehicle, vehicleData)
    SetModelAsNoLongerNeeded(model)

    return vehicle
end

-- Company / services app
function GetCompanyData()
    local jobData = {
        job = PlayerJob.name,
        jobLabel = PlayerJob.label,
        isBoss = PlayerJob.isboss,
        duty = PlayerJob.onduty
    }

    if not jobData.isBoss then
        return jobData
    end

    jobData.balance = AwaitCallback("qbx:services:getAccount")
    jobData.employees = AwaitCallback("qbx:services:getEmployees")
    jobData.grades = {}

    for k, v in pairs(QB.Shared.Jobs[jobData.job].grades) do
        jobData.grades[#jobData.grades + 1] = {
            label = v.name,
            grade = tonumber(k)
        }
    end

    table.sort(jobData.grades, function(a, b)
        return a.grade < b.grade
    end)

    return jobData
end

function DepositMoney(amount)
    return AwaitCallback("qbx:services:addMoney", amount)
end

function WithdrawMoney(amount)
    return AwaitCallback("qbx:services:removeMoney", amount)
end

function HireEmployee(source)
    if not AwaitCallback("qbx:services:hireEmployee", source) then
        return false
    end

    return AwaitCallback("services:getPlayerData", source)
end

function FireEmployee(citizenid)
    return AwaitCallback("qbx:services:fireEmployee", citizenid)
end

function SetGrade(identifier, newGrade)
    local maxGrade = 0

    for grade, _ in pairs(QB.Shared.Jobs[PlayerJob.name].grades) do
        grade = tonumber(grade)

        if grade and grade > maxGrade then
            maxGrade = grade
        end
    end

    if newGrade > maxGrade then
        return false
    end

    return AwaitCallback("qbx:services:setGrade", identifier, newGrade)
end

function ToggleDuty()
    TriggerServerEvent("QBCore:ToggleDuty")
end

function CanOpenPhone()
    local metadata = QB.Functions.GetPlayerData().metadata

    if metadata.ishandcuffed or metadata.isdead or metadata.inlaststand then
        return false
    end

    return true
end
