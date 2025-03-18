if (Config.Framework == "auto" and GetResourceState("es_extended") == "started") or Config.Framework == "ESX" then
  -- Player data
  Globals.PlayerData = ESX.GetPlayerData()

  RegisterNetEvent("esx:playerLoaded")
  AddEventHandler("esx:playerLoaded", function(xPlayer)
    Globals.PlayerData = xPlayer
    TriggerEvent("jg-advancedgarages:client:update-blips-text-uis")
  end)

  RegisterNetEvent("esx:setJob")
  AddEventHandler("esx:setJob", function(job)
    Globals.PlayerData.job = job
    TriggerEvent("jg-advancedgarages:client:update-blips-text-uis")
  end)

  -- ESX admincar replacement
  RegisterNetEvent("jg-advancedgarages:client:set-vehicle-owned", function()
    local vehicle = cache.vehicle
    local vehicleProps = Framework.Client.GetVehicleProperties(vehicle)
    if not vehicleProps then return end

    if not vehicle or vehicle == 0 then
      return Framework.Client.Notify(Locale.notInsideVehicleError, "error")
    end

    local plate = vehicleProps.plate

    local veh = lib.callback.await("jg-advancedgarages:server:get-vehicle", false, plate)
    if veh then
      return Framework.Client.Notify(Locale.vehiclePlateExistsError, "error")
    end
    
    TriggerServerEvent("jg-advancedgarages:server:set-vehicle-owned", vehicleProps)
  end)
end
