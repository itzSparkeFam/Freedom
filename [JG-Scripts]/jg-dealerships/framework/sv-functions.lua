---@param src integer
---@param msg string
---@param type "success" | "warning" | "error"
function Framework.Server.Notify(src, msg, type)
  TriggerClientEvent("jg-dealerships:client:notify", src, msg, type, 5000)
end

---@param src integer
---@returns boolean
function Framework.Server.IsAdmin(src)
  return IsPlayerAceAllowed(tostring(src), "command") or false
end

-- 
-- Society
--

local usingNewQBBanking = GetResourceState("qb-banking") == "started" and tonumber(string.sub(GetResourceMetadata("qb-banking", "version", 0), 1, 3)) >= 2

---@param society string
---@param societyType "job"|"gang"
---@return number balance
function Framework.Server.GetSocietyBalance(society, societyType)
  if GetResourceState("okokBanking") == "started" then
    return exports["okokBanking"]:GetAccount(society)
  elseif GetResourceState("tgg-banking") == "started" then
    return exports["tgg-banking"]:GetSocietyAccountMoney(society)
  elseif GetResourceState("Renewed-Banking") == "started" then
    return exports["Renewed-Banking"]:getAccountMoney(society)
  elseif Config.Framework == "QBCore" then
    if usingNewQBBanking then
      return exports["qb-banking"]:GetAccountBalance(society)
    else
      if societyType == "job" then
        return exports["qb-management"]:GetAccount(society)
      elseif societyType == "gang" then
        return exports["qb-management"]:GetGangAccount(society)
      end
    end
  elseif Config.Framework == "ESX" then
    local balance = promise.new()

    TriggerEvent("esx_society:getSociety", society, function(data)
      if not data then return balance:resolve(0) end

      TriggerEvent("esx_addonaccount:getSharedAccount", data.account, function(account)
        return balance:resolve(account.money)
      end)
    end)

		return Citizen.Await(balance)
  end

  return 0
end

lib.callback.register("jg-dealerships:server:get-society-balance", function(_, society, type)
  return Framework.Server.GetSocietyBalance(society, type)
end)

---@param societyName string
---@param societyType "job"|"gang"
---@param amount number
function Framework.Server.RemoveFromSocietyFund(societyName, societyType, amount)
  if GetResourceState("okokBanking") == "started" then
    exports["okokBanking"]:RemoveMoney(societyName, amount)
  elseif GetResourceState("tgg-banking") == "started" then
    exports["tgg-banking"]:RemoveSocietyMoney(societyName, amount)
  elseif GetResourceState("Renewed-Banking") == "started" then
    exports["Renewed-Banking"]:removeAccountMoney(societyName, amount)
  elseif Config.Framework == "QBCore" then
    if usingNewQBBanking then
      exports["qb-banking"]:RemoveMoney(societyName, amount)
    else
      if societyType == "job" then
        exports["qb-management"]:RemoveMoney(societyName, amount)
      elseif societyType == "gang" then
        exports["qb-management"]:RemoveGangMoney(societyName, amount)
      end
    end
  elseif Config.Framework == "ESX" then
    TriggerEvent("esx_society:getSociety", societyName, function(society)
      TriggerEvent("esx_addonaccount:getSharedAccount", society.account, function(account)
        account.removeMoney(amount)
      end)
    end)
  end
end

---@param purchaseType "society"|"personal"
---@param society? string
---@param societyType? string
---@param model string|integer
---@param plate string
---@param financed? boolean
---@param financeData? table
---@return integer|nil vehicleId
function Framework.Server.SaveVehicleToGarage(src, purchaseType, society, societyType, model, plate, financed, financeData)
  local vehicleId = nil
  local props = json.encode({
    model = convertModelToHash(model),
    plate = plate
  })

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local playerData = Framework.Server.GetPlayer(src).PlayerData
    local license = playerData.license
    local citizenid = playerData.citizenid

    if purchaseType == "society" then
      vehicleId = MySQL.insert.await(
        "INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, financed, finance_data, job_vehicle, job_vehicle_rank, gang_vehicle, gang_vehicle_rank) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        {license, society, model, joaat(model), props, plate, financed, json.encode(financeData), societyType == "job" and 1 or 0, 0, societyType == "gang" and 1 or 0, 0}
      )
    else
      vehicleId = MySQL.insert.await(
        "INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, financed, finance_data) VALUES(?, ?, ?, ?, ?, ?, ?, ?)",
        {license, citizenid, model, joaat(model), props, plate, financed, json.encode(financeData)}
      )
    end
  elseif Config.Framework == "ESX" then
    local identifier = Framework.Server.GetPlayerIdentifier(src)
    debugPrint("Saving vehicle to garage for "..identifier.. " type: "..purchaseType, "debug")
    if purchaseType == "society" and societyType == "job" then
      vehicleId = MySQL.insert.await(
        "INSERT INTO owned_vehicles (owner, plate, vehicle, financed, finance_data, job_vehicle, job_vehicle_rank) VALUES(?, ?, ?, ?, ?, ?, ?)",
        {society, plate, props, financed, json.encode(financeData), 1, 0}
      )
    else
      vehicleId = MySQL.insert.await(
        "INSERT INTO owned_vehicles (owner, plate, vehicle, financed, finance_data) VALUES(?, ?, ?, ?, ?)",
        {identifier, plate, props, financed, json.encode(financeData)}
      )
    end
  end

  return vehicleId
end

---@param vehicle boolean|QueryResult|unknown|{ [number]: { [string]: unknown  }|{ [string]: unknown }}
---@return string | number | false model
function Framework.Server.GetModelColumn(vehicle)
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return vehicle.vehicle or tonumber(vehicle.hash) or false
  elseif Config.Framework == "ESX" then
    if not vehicle or not vehicle.vehicle then return false end

    if type(vehicle.vehicle) == "string" then
      if not json.decode(vehicle.vehicle) then return false end
      return json.decode(vehicle.vehicle).model
    else
      return vehicle.vehicle.model
    end
  end

  return false
end

---@param vehicle integer
---@return string | false plate 
function Framework.Server.GetPlate(vehicle)
  local plate = GetVehicleNumberPlateText(vehicle)
  if not plate or plate == nil or plate == "" then return false end

  if GetResourceState("brazzers-fakeplates") == "started" then
    local originalPlate = MySQL.scalar.await("SELECT plate FROM player_vehicles WHERE fakeplate = ?", {plate})
    if originalPlate then plate = originalPlate end
  end

  local trPlate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
  return trPlate
end

---Generate a plate based on a seed
---@param seed string
---@param checkIfExists? boolean Check if the plate exists in the DB
---@return string|false generatedPlate
function Framework.Server.VehicleGeneratePlate(seed, checkIfExists)
  seed = seed or "1AA111AA"

  local CHARSET_NUMBERS, CHARSET_LETTERS = "0123456789", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local attempts = 0

  while attempts < 20 do
    local i, plate = 0, ""

    while i <= seed:len() do
      local char = seed:sub(i, i)

      if char == "A" then
        local randLetterPos = math.random(1, #CHARSET_LETTERS)
        local randLetter = CHARSET_LETTERS:sub(randLetterPos, randLetterPos)
        plate = plate .. randLetter
      elseif char == "1" then
        local randNumberPos = math.random(1, #CHARSET_NUMBERS)
        local randNumber = CHARSET_NUMBERS:sub(randNumberPos, randNumberPos)
        plate = plate .. randNumber
      elseif char == "^" then
        i = i + 1
        if i <= seed:len() then plate = plate .. seed:sub(i, i) end
      else
        plate = plate .. char
      end

      i = i + 1
    end

    plate = plate:upper()

    if plate:len() > 8 then
      error("^1[ERROR] You are generating a plate with more than 8 characters.")
      return false
    end

    if not checkIfExists then
      return plate
    end

    local result = MySQL.scalar.await("SELECT plate FROM " .. Framework.VehiclesTable .. " WHERE plate = ?", {plate})
    if not result then return plate end

    attempts = attempts + 1
  end

  return false
end

lib.callback.register("jg-dealerships:server:vehicle-generate-plate", function(_, ...)
  return Framework.Server.VehicleGeneratePlate(...)
end)

exports("generatePlate", Framework.Server.VehicleGeneratePlate)

--
-- Player Functions
--

---@param src integer
function Framework.Server.GetPlayer(src)
  if Config.Framework == "QBCore" then
    return QBCore.Functions.GetPlayer(src)
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayer(src)
  elseif Config.Framework == "ESX" then
    return ESX.GetPlayerFromId(src)
  end
end

---@param src integer
function Framework.Server.GetPlayerInfo(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return {
      name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.getName()
    }
  end
end

---@param identifier string
function Framework.Server.GetPlayerInfoFromIdentifier(identifier)
  local player = MySQL.single.await("SELECT * FROM " .. Framework.PlayersTable .. " WHERE " .. Framework.PlayersTableId .. " = ?", {identifier})
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local charinfo = json.decode(player.charinfo)
    return {
      name = charinfo.firstname .. " " .. charinfo.lastname
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.firstname .. " " .. player.lastname
    }
  end
end

---@param src integer
function Framework.Server.GetPlayerIdentifier(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return player.PlayerData.citizenid
  elseif Config.Framework == "ESX" then
    return player.getIdentifier()
  end
end

---@param identifier string
---@return integer | false src
function Framework.Server.GetPlayerFromIdentifier(identifier)
  if Config.Framework == "QBCore" then
    local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
  elseif Config.Framework == "Qbox" then
    local player = exports.qbx_core:GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
  elseif Config.Framework == "ESX" then
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then return false end
    return xPlayer.source
  end

  return false
end

-- 
-- Player Money
--

---@param src integer
---@param type "cash" | "bank" | "money"
function Framework.Server.GetPlayerBalance(src, type)
  local player = Framework.Server.GetPlayer(src)
  if not player then return 0 end

  if type == "custom" then
    -- Add your own custom balance system here
  elseif Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return player.PlayerData.money[type]
  elseif Config.Framework == "ESX" then
    if type == "cash" then type = "money" end

    for i, acc in pairs(player.getAccounts()) do
      if acc.name == type then
        return acc.money
      end
    end

    return 0
  end
end

---@param src integer
---@param amount number
---@param account "cash" | "bank" | "money"
function Framework.Server.PlayerAddMoney(src, amount, account)
  local player = Framework.Server.GetPlayer(src)
  account = account or "bank"

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.AddMoney(account, round(amount, 0))
  elseif Config.Framework == "ESX" then
    if account == "cash" then account = "money" end
    player.addAccountMoney(account, round(amount, 0))
  end
end

---@param src integer
---@param amount number
---@param account "cash" | "bank" | "money"
function Framework.Server.PlayerRemoveMoney(src, amount, account)
  local player = Framework.Server.GetPlayer(src)
  account = account or "bank"

  if account == "custom" then
    -- Add your own custom balance system here
  elseif Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.RemoveMoney(account, round(amount, 0))
  elseif Config.Framework == "ESX" then
    if account == "cash" then account = "money" end
    player.removeAccountMoney(account, round(amount, 0))
  end
end

--
-- Player Job
--

---@param src integer
---@param job string
---@param role "sales" | "supervisor" | "manager" | number
function Framework.Server.PlayerSetJob(src, job, role)
  local player = Framework.Server.GetPlayer(src)

  -- Adjust this as necessary for your job setup
  local rank = 1 -- sales
  if role == "supervisor" then rank = 2 end
  if role == "manager" then rank = 3 end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.SetJob(job, rank)
  elseif Config.Framework == "ESX" then
    player.setJob(job, rank)
  end
end

---@param identifier string
---@param job string
---@param role "sales" | "supervisor" | "manager" | number
function Framework.Server.PlayerSetJobOffline(identifier, job, role)
  -- Adjust this as necessary for your job setup
  local rank = 1 -- sales
  if role == "supervisor" then rank = 2 end
  if role == "manager" then rank = 3 end
  
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local jobsList = {}
    if Config.Framework == "QBCore" then jobsList = QBCore.Shared.Jobs
    elseif Config.Framework == "Qbox" then jobsList = exports.qbx_core:GetJobs() end
    
    if not jobsList[job] then return false end

    local jobData = {
      name = job,
      label = jobsList[job].label,
      onduty = jobsList[job].defaultDuty,
      type = jobsList[job].type or "none",
      grade = {
        name = "No Grades",
        level = 0,
      },
      payment = 30,
      isboss = false
    }
    if jobsList[job].grades[tostring(rank)] then
      local jobgrade = jobsList[job].grades[tostring(rank)]
      jobData.grade = {}
      jobData.grade.name = jobgrade.name
      jobData.grade.level = rank
      jobData.payment = jobgrade.payment or 30
      jobData.isboss = jobgrade.isboss or false
    end

    MySQL.update.await("UPDATE players SET job = ? WHERE citizenid = ?", {json.encode(jobData), identifier})
  elseif Config.Framework == "ESX" then
    MySQL.update.await("UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?", {job, rank, identifier})
  end
end

function Framework.Server.GetPlayers()
  local players = {}
  if Config.Framework == "QBCore" then
    players = QBCore.Functions.GetQBPlayers()
  elseif Config.Framework == "Qbox" then
    players = exports.qbx_core:GetQBPlayers()
  elseif Config.Framework == "ESX" then
    players = ESX.GetExtendedPlayers()
  end

  for id, player in pairs(players) do
    if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
      players[id].player_id = player.PlayerData.source
    elseif Config.Framework == "ESX" then
      players[id].player_id = player.source
    end
  end

  return players
end

function Framework.Server.GetJobs()
  if Config.Framework == "QBCore" then
    return QBCore.Shared.Jobs
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetJobs()
  elseif Config.Framework == "ESX" then
    return ESX.GetJobs()
  end
end

--
-- ti_fuel
--

RegisterNetEvent("jg-dealerships:server:save-ti-fuel-type", function(plate, type)
  MySQL.query.await("ALTER TABLE " .. Framework.VehiclesTable .. " ADD COLUMN IF NOT EXISTS `ti_fuel_type` VARCHAR(100) DEFAULT '';")
  MySQL.update.await("UPDATE " .. Framework.VehiclesTable .. " SET ti_fuel_type = ? WHERE plate = ?", {type, plate});
end)

lib.callback.register("jg-dealerships:server:get-ti-fuel-type", function(src, plate)
  MySQL.query.await("ALTER TABLE " .. Framework.VehiclesTable .. " ADD COLUMN IF NOT EXISTS `ti_fuel_type` VARCHAR(100) DEFAULT '';")
  return MySQL.scalar.await("SELECT ti_fuel_type FROM  " .. Framework.VehiclesTable .. " WHERE plate = ?", {plate}) or false
end)

--
-- Brazzers-FakePlates
--

lib.callback.register("brazzers-fakeplates:getPlateFromFakePlate", function(_, fakeplate)
  local result = MySQL.scalar.await("SELECT plate FROM player_vehicles WHERE fakeplate = ?", {fakeplate})
  if result then return result end
  return false
end)

lib.callback.register("brazzers-fakeplates:getFakePlateFromPlate", function(_, plate)
  local result = MySQL.scalar.await("SELECT fakeplate FROM player_vehicles WHERE plate = ?", {plate})
  if result then return result end
  return false
end)