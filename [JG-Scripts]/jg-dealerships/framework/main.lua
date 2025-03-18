QBCore, ESX = nil, nil
Framework = {
  Client = {},
  Server = {}
}

if (Config.Framework == "auto" and GetResourceState("qbx_core") == "started") or Config.Framework == "Qbox" then
  Config.Framework = "Qbox"

  Framework.VehiclesTable = "player_vehicles"
  Framework.VehProps = "mods"
  Framework.PlayerId = "citizenid"
  Framework.PlayersTable = "players"
  Framework.PlayersTableId = "citizenid"
elseif (Config.Framework == "auto" and GetResourceState("qb-core") == "started") or Config.Framework == "QBCore" then
  QBCore = exports['qb-core']:GetCoreObject()
  Config.Framework = "QBCore"

  Framework.VehiclesTable = "player_vehicles"
  Framework.VehProps = "mods"
  Framework.PlayerId = "citizenid"
  Framework.PlayersTable = "players"
  Framework.PlayersTableId = "citizenid"
elseif (Config.Framework == "auto" and GetResourceState("es_extended") == "started") or Config.Framework == "ESX" then
  ESX = exports["es_extended"]:getSharedObject()
  Config.Framework = "ESX"

  Framework.VehiclesTable = "owned_vehicles"
  Framework.VehProps = "vehicle"
  Framework.PlayerId = "owner"
  Framework.PlayersTable = "users"
  Framework.PlayersTableId = "identifier"
else
  error("You need to set the Config.Framework to either \"QBCore\" or \"ESX\" or \"Qbox\"!")
end