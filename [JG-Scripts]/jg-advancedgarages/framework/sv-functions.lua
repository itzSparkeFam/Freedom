--
-- Core Functions
--

---@param src integer
---@param msg string
---@param type "success" | "warning" | "error"
function Framework.Server.Notify(src, msg, type)
  TriggerClientEvent("jg-advancedgarages:client:notify", src, msg, type, 5000)
end

---@param src integer
---@returns boolean
function Framework.Server.IsAdmin(src)
  return IsPlayerAceAllowed(tostring(src), "command") or false
end

function Framework.Server.PayIntoSocietyFund(jobName, money)
  local usingNewQBBanking = GetResourceState("qb-banking") == "started" and tonumber(string.sub(GetResourceMetadata("qb-banking", "version", 0), 1, 3)) >= 2

  if (Config.Banking == "auto" and GetResourceState("Renewed-Banking") == "started") or Config.Banking == "Renewed-Banking" then
    exports['Renewed-Banking']:addAccountMoney(jobName, money)
  elseif (Config.Banking == "auto" and GetResourceState("okokBanking") == "started") or Config.Banking == "okokBanking" then
    exports['okokBanking']:AddMoney(jobName, money)
  elseif (Config.Banking == "auto" and GetResourceState("fd_banking") == "started") or Config.banking == "fd_banking" then
    exports.fd_banking:AddMoney(jobName, money)
  elseif (Config.Banking == "auto" and (Config.Framework == "QBCore" or Config.Framework == "Qbox")) then
    if usingNewQBBanking then
      exports["qb-banking"]:AddMoney(jobName, money)
    else
      exports["qb-management"]:AddMoney(jobName, money)
    end
  elseif Config.Banking == "qb-banking" then
    exports["qb-banking"]:AddMoney(jobName, money)
  elseif Config.Banking == "qb-management" then
    exports["qb-management"]:AddMoney(jobName, money)
  elseif (Config.Banking == "auto" and Config.Framework == "ESX") or Config.Banking == "esx_addonaccount" then
    TriggerEvent("esx_society:getSociety", jobName, function(society)
      TriggerEvent("esx_addonaccount:getSharedAccount", society.account, function(account)
        account.addMoney(money)
      end)
    end)
  end
end

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

---@param src integer
---@return {name:string,label:string,grade:number} | false
function Framework.Server.GetPlayerJob(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    if not player.PlayerData then return false end

    return {
      name = player.PlayerData.job.name,
      label = player.PlayerData.job.label,
      grade = player.PlayerData.job.grade?.level or 0,
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.job.name,
      label = player.job.label,
      grade = player.job.grade
    }
  end

  return false
end

---@param src integer
---@return {name:string,label:string,grade:number} | false
function Framework.Server.GetPlayerGang(src)
  if (Config.Gangs == "auto" and GetResourceState("rcore_gangs") == "started") or Config.Gangs == "rcore_gangs"  then
    local gang = exports.rcore_gangs:GetPlayerGang(src)
    if not gang then return {} end

    return {
      name = gang.name,
      label = gang.name,
      grade = 0 -- rcore_gangs' grade system are only strings
    }
  elseif (Config.Gangs == "auto" and GetResourceState("qb-gangs") == "started") or Config.Gangs == "qb-gangs" or Config.Framework == "QBCore" or Config.Framework == "Qbox" then

    local player = Framework.Server.GetPlayer(src)
    if not player then return false end

    return {
      name = player.PlayerData.gang.name,
      label = player.PlayerData.gang.label,
      grade = player.PlayerData.gang.grade.level
    }
  elseif Config.Framework == "ESX" then
    -- To implement gangs in ESX, enable Config.GangEnableCustomESXIntegration & then add the necessary exports here.
    -- It must return the same data structure as QB/X above, with { name, label, grade }
    -- Heads up, you must also add the exports to cl-functions.lua -> Framework.Client.GetPlayerGang
    error("ESX does not natively support gangs.");
  end

  return false
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
function Framework.Server.GetSrcFromIdentifier(identifier)
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
end

---@param src integer
---@param type "cash" | "bank" | "money"
function Framework.Server.GetPlayerBalance(src, type)
  local player = Framework.Server.GetPlayer(src)
  if not player then return 0 end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
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
---@return boolean success
function Framework.Server.PlayerRemoveMoney(src, amount, account)
  local player = Framework.Server.GetPlayer(src)
  account = account or "bank"

  if Framework.Server.GetPlayerBalance(src, account) < amount then
    Framework.Server.Notify(src, Locale.notEnoughMoneyError, "error")
    return false
  end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.RemoveMoney(account, round(amount, 0))
  elseif Config.Framework == "ESX" then
    if account == "cash" then account = "money" end
    player.removeAccountMoney(account, round(amount, 0))
  end

  return true
end

---@return {id:number,identifier:string,name:string}[] players
function Framework.Server.GetPlayers()
  local players = {}

  for _, playerId in ipairs(GetPlayers()) do
    players[#players+1] = {
      id = tonumber(playerId),
      identifier = Framework.Server.GetPlayerIdentifier(tonumber(playerId, 10)),
      name = Framework.Server.GetPlayerInfo(tonumber(playerId, 10))?.name
    }
  end
  
  return players
end

---@return table | false jobs
function Framework.Server.GetJobs()
  if Config.Framework == "QBCore" then
    return QBCore.Shared.Jobs
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetJobs()
  elseif Config.Framework == "ESX" then
    return ESX.GetJobs()
  end

  return false
end

---@return table | false gangs
function Framework.Server.GetGangs()
  if (Config.Gangs == "auto" and GetResourceState("rcore_gangs") == "started") or Config.Gangs == "rcore_gangs" then
    local gangs = MySQL.query.await("SELECT name FROM gangs")
    return gangs or {}
  elseif (Config.Gangs == "auto" and GetResourceState("qb-gangs") == "started") or Config.Gangs == "qb-gangs" then 
    if Config.Framework == "QBCore" then
      return QBCore.Shared.Gangs
    elseif Config.Framework == "Qbox" then
      return exports.qbx_core:GetGangs()
    end
  elseif Config.Framework == "ESX" then
    error("ESX does not natively support gangs.");
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

--
-- ti_fuel
--

RegisterNetEvent("jg-advancedgarages:server:save-ti-fuel-type", function(plate, type)
  MySQL.query.await("ALTER TABLE " .. Framework.VehiclesTable .. " ADD COLUMN IF NOT EXISTS `ti_fuel_type` VARCHAR(100) DEFAULT '';")
  MySQL.update.await("UPDATE " .. Framework.VehiclesTable .. " SET ti_fuel_type = ? WHERE plate = ?", {type, plate});
end)

lib.callback.register("jg-advancedgarages:server:get-ti-fuel-type", function(src, plate)
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