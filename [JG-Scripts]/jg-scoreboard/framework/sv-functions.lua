function Framework.Server.CreateCallback(cbRef, cb)
  if Config.Framework == "QBCore" then
    return QBCore.Functions.CreateCallback(cbRef, function(...)
      cb(...)
    end)
  elseif Config.Framework == "ESX" then
    ESX.RegisterServerCallback(cbRef, function(...)
      cb(...)
    end)
  end
end

function Framework.Server.GetPlayers()
  local players = {}

  if Config.Framework == "QBCore" then
    for id, player in pairs(QBCore.Functions.GetQBPlayers()) do
      local name, playerData = "", player.PlayerData

      if Config.UseCharacterNames then
        name = playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname
      else
        name = playerData.name
      end

      table.insert(players, {
        id = id,
        name = name,
        jobName = playerData.job.name,
        jobLabel = playerData.job.label,
        jobOnDuty = playerData.job.onduty,
      })
    end
  elseif Config.Framework == "ESX" then
    for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
      local name, job = "", xPlayer.getJob()
  
      if Config.UseCharacterNames then
        name = xPlayer.getName()
      else
        name = GetPlayerName(xPlayer.source)
      end
  
      table.insert(players, {
        id = xPlayer.source,
        name = name,
        jobName = job.name,
        jobLabel = job.label,
        jobOnDuty = false
      })
    end
  end

  return players
end

function Framework.Server.IsStaff(src)
  if Config.Framework == "QBCore" then
    return QBCore.Functions.HasPermission(src, "command")
  elseif Config.Framework == "ESX" then
    return ESX.GetPlayerFromId(src).getGroup() == "admin"
  end
end