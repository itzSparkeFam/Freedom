if (Config.Framework == "auto" and GetResourceState("es_extended") == "started") or Config.Framework == "ESX" then
  -- /admincar db insert
  RegisterNetEvent("jg-advancedgarages:server:set-vehicle-owned", function(vehicleProps)
    local src = source

    if not Framework.Server.IsAdmin(src) then
      return Framework.Server.Notify(src, "INSUFFICIENT_PERMISSIONS", "error")
    end

    local player = ESX.GetPlayerFromId(src)
    
    MySQL.insert.await("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)", {
      player.identifier, vehicleProps.plate, json.encode(vehicleProps)
    })

    Framework.Server.Notify(src, string.gsub(Locale.vehicleReceived, "%%{value}", vehicleProps.plate))
  end)

  -- /admincar command
  ESX.RegisterCommand("admincar", "admin", function(xPlayer)
    TriggerClientEvent("jg-advancedgarages:client:set-vehicle-owned", xPlayer.source)
  end, false)
end
