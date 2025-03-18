QBCore, ESX = nil, nil
Framework = {
  Client = {},
  Server = {},
  Queries = {
    GetVehicles = "SELECT * FROM %s WHERE %s = ? AND job_vehicle = 0 AND gang_vehicle = 0",
    GetJobVehicles = "SELECT * FROM %s WHERE %s = ? AND job_vehicle = 1 AND job_vehicle_rank <= ?",
    GetGangVehicles = "SELECT * FROM %s WHERE %s = ? AND gang_vehicle = 1 AND gang_vehicle_rank <= ?",
    GetImpoundVehiclesWhitelist = "SELECT * FROM %s WHERE garage_id = ? AND impound = 1",
    GetImpoundVehiclesPublic = "SELECT * FROM %s WHERE garage_id = ? AND impound = 1 AND impound_retrievable = 1 AND (%s = ? OR %s = ? OR %s = ?)",
    GetVehicle = "SELECT * FROM %s WHERE %s = ? AND plate = ?",
    GetVehicleNoIdentifier = "SELECT * FROM %s WHERE plate = ?",
    GetVehiclePlateOnly = "SELECT plate FROM %s WHERE plate = ?",
    GetPrivateGarages = "SELECT * FROM player_priv_garages WHERE owners LIKE ?",
    StoreVehicle = "UPDATE %s SET in_garage = 1, garage_id = ?, fuel = ?, body = ?, engine = ?, damage = ? WHERE %s IN (?) AND plate = ?",
    SetInGarage = "UPDATE %s SET in_garage = 1 WHERE plate = ?",
    UpdateProps = "UPDATE %s SET %s = ? WHERE plate = ?",
    VehicleDriveOut = "UPDATE %s SET in_garage = 0 WHERE %s = ? AND plate = ?",
    UpdateGarageId = "UPDATE %s SET garage_id = ? WHERE %s = ? AND plate = ?",
    UpdatePlayerId = "UPDATE %s SET %s = ? WHERE %s = ? AND plate = ?",
    UpdateVehicleNickname = "UPDATE %s SET nickname = ? WHERE %s = ? AND plate = ?",
    UpdateVehiclePlate = "UPDATE %s SET plate = ?, %s = ? WHERE plate = ?",
    ImpoundVehicle = "UPDATE %s SET impound = 1, impound_retrievable = ?, impound_data = ?, garage_id = ?, fuel = ?, body = ?, engine = ?, damage = ? WHERE plate = ?",
    ImpoundReturnToGarage = "UPDATE %s SET impound = 0, impound_data = '', garage_id = ?, in_garage = ? WHERE plate = ?",
    SetJobVehicle = "UPDATE %s SET %s = ?, job_vehicle = 1, job_vehicle_rank = ? WHERE plate = ?",
    SetGangVehicle = "UPDATE %s SET %s = ?, gang_vehicle = 1, gang_vehicle_rank = ? WHERE plate = ?",
    SetSocietyVehicleAsPlayerOwned = "UPDATE %s SET %s = ?, job_vehicle = 0, gang_vehicle = 0 WHERE plate = ?",
    DeleteVehicle = "DELETE FROM %s WHERE plate = ?",
  }
}

if (Config.Framework == "auto" and GetResourceState("qbx_core") == "started") or Config.Framework == "Qbox" then
  Config.Framework = "Qbox"

  Framework.VehiclesTable = "player_vehicles"
  Framework.PlayerIdentifier = "citizenid"
  Framework.VehProps = "mods"
  Framework.PlayersTable = "players"
  Framework.PlayersTableId = "citizenid"
elseif (Config.Framework == "auto" and GetResourceState("qb-core") == "started") or Config.Framework == "QBCore" then
  QBCore = exports['qb-core']:GetCoreObject()
  Config.Framework = "QBCore"

  Framework.VehiclesTable = "player_vehicles"
  Framework.PlayerIdentifier = "citizenid"
  Framework.VehProps = "mods"
  Framework.PlayersTable = "players"
  Framework.PlayersTableId = "citizenid"

elseif (Config.Framework == "auto" and GetResourceState("es_extended") == "started") or Config.Framework == "ESX" then
  ESX = exports["es_extended"]:getSharedObject()
  Config.Framework = "ESX"

  Framework.VehiclesTable = "owned_vehicles"
  Framework.PlayerIdentifier = "owner"
  Framework.VehProps = "vehicle"
  Framework.PlayersTable = "users"
  Framework.PlayersTableId = "identifier"
else
  error("You need to set the Config.Framework to either \"QBCore\" or \"ESX\" or \"Qbox\"!")
end
