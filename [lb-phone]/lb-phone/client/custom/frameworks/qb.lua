if Config.Framework ~= "qb" then
    return
end

---@diagnostic disable: param-type-mismatch
debugprint("Loading QB")
QB = exports["qb-core"]:GetCoreObject()
local PlayerJob = {}
local PlayerData = {}

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

debugprint("QB loaded")
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

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(jobInfo)
    local oldJob = PlayerJob

    PlayerJob = jobInfo

    if oldJob.name ~= PlayerJob.name or oldJob.grade?.level ~= PlayerJob.grade?.level then
        SendReactMessage("services:setCompany", GetCompanyData())
    else
        SendReactMessage("services:setDuty", jobInfo.onduty)
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

---Check if the player has a job
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

    if GetResourceState("qb-management") ~= "started" then
        QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(money)
            jobData.balance = money
        end, jobData.job)
    else
        jobData.balance = AwaitCallback("services:getAccount")
    end

    QB.Functions.TriggerCallback("qb-bossmenu:server:GetEmployees", function(employees)
        for i = 1, #employees do
            local employee = employees[i]

            employees[i] = {
                name = employee.name,
                id = employee.empSource,

                gradeLabel = employee.grade.name,
                grade = employee.grade.level,

                canInteract = not employee.isboss
            }
        end

        jobData.employees = employees
    end, jobData.job)

    local timeout = GetGameTimer() + 2000

    while not jobData.balance or not jobData.employees do
        Wait(0)

        if GetGameTimer() > timeout then
            infoprint("error", "Failed to get company data (timed out after 2s)")
            print("balance: " .. tostring(jobData.balance))
            print("employees: " .. tostring(jobData.employees))

            jobData.employees = jobData.employees or {}
            jobData.balance = jobData.balance or 0
            break
        end
    end

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

function DepositMoney(amount, cb)
    if GetResourceState("qb-management") == "started" then
        return AwaitCallback("services:addMoney", amount)
    end

    TriggerServerEvent("qb-bossmenu:server:depositMoney", amount)
    Wait(500) -- Wait for the server to update the balance

    QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", cb, PlayerJob.name)
end

function WithdrawMoney(amount, cb)
    if GetResourceState("qb-management") == "started" then
        return AwaitCallback("services:removeMoney", amount)
    end

    TriggerServerEvent("qb-bossmenu:server:withdrawMoney", amount)
    Wait(500) -- Wait for the server to update the balance

    QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", cb, PlayerJob.name)
end

function HireEmployee(source)
    TriggerServerEvent("qb-bossmenu:server:HireEmployee", source)

    return AwaitCallback("services:getPlayerData", source)
end

function FireEmployee(source)
    TriggerServerEvent("qb-bossmenu:server:FireEmployee", source)

    return PlayerJob.isboss or false
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

    TriggerServerEvent("qb-bossmenu:server:GradeUpdate", {
        cid = identifier,
        grade = newGrade,
        gradename = QB.Shared.Jobs[PlayerJob.name].grades[tostring(newGrade)].name
    })

    return true
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

if Config.Crypto.QBit then
    function GetQBit()
        local promise = promise.new()

        QB.Functions.TriggerCallback("qb-crypto:server:GetCryptoData", function(cryptoData)
            promise:resolve(cryptoData)
        end, "qbit")

        return Citizen.Await(promise)
    end

    function BuyQBit(amount)
        local promise = promise.new()

        QB.Functions.TriggerCallback("qb-crypto:server:BuyCrypto", function(res)
            promise:resolve({ success = type(res) == "table" })
        end, {
            Coins = amount / GetQBit().Worth,
            Price = amount
        })

        return Citizen.Await(promise)
    end

    function SellQBit(amount)
        local promise = promise.new()

        QB.Functions.TriggerCallback("qb-crypto:server:SellCrypto", function(res)
            promise:resolve({ success = type(res) == "table" })
        end, {
            Coins = amount,
            Price = math.floor(amount * GetQBit().Worth + 0.5)
        })

        return Citizen.Await(promise)
    end

    function TransferQBit(amount, toNumber)
        local otherWallet = AwaitCallback("crypto:getOtherQBitWallet", toNumber)
        if not otherWallet then
            return { success = false }
        end

        local qbit = GetQBit()
        if qbit.Portfolio < amount then
            return { success = false }
        end

        local promise = promise.new()

        QB.Functions.TriggerCallback("qb-crypto:server:TransferCrypto", function(res)
            promise:resolve({ success = type(res) == "table" })
        end, {
            Coins = amount,
            WalletId = otherWallet
        })

        return Citizen.Await(promise)
    end
end
