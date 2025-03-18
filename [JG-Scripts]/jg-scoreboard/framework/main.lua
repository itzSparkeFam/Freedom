QBCore, ESX = nil, nil
Framework = {
  Client = {},
  Server = {}
}

if Config.Framework == "QBCore" then
  QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "ESX" then
  ESX = exports["es_extended"]:getSharedObject()
else
  error("You need to set the Config.Framework to either \"QBCore\" or \"ESX\"!")
end