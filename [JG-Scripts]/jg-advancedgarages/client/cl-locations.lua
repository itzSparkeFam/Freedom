local GARAGE_ZONE_Z_DIST = 4.0
local inVehicle, blips, zones, peds = nil, {}, {}, {}
local cachedGarageLocations

function getAvailableGarageLocations()
  if not cachedGarageLocations then
    cachedGarageLocations = lib.callback.await("jg-advancedgarages:server:get-available-garage-locations", false)
  end

  return cachedGarageLocations or {}
end

---@param coords vector3
---@param marker table
function drawMarkerOnFrame(coords, marker)
  ---@diagnostic disable-next-line: missing-parameter
  DrawMarker(marker.id, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, marker.size.x,  marker.size.y, marker.size.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 0, marker.rotate, marker.drawOnEnts)
end

---@param name string
---@param coords vector3
---@param blipId integer
---@param blipColour integer
---@param blipScale number
local function createBlip(name, coords, blipId, blipColour, blipScale)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite(blip, blipId)
  SetBlipColour(blip, blipColour)
  SetBlipScale(blip, blipScale)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(name)
  EndTextCommandSetBlipName(blip)
  return blip
end

---@param garageId string
---@param coords vector3|vector4
---@param dist number
---@param marker? table | false | nil
---@param onEnter? function
---@param onExit? function
---@param inside? function
local function createLocation(garageId, coords, dist, marker, onEnter, onExit, inside)
  local point = lib.zones.box({
    coords = coords,
    size = vector3(dist, dist, GARAGE_ZONE_Z_DIST),
    rotation = coords.w or 0,
    garageId = garageId,
    onEnter = onEnter,
    onExit = onExit,
    inside = inside
  })
  
  zones[#zones+1] = point

  local markerPoint = lib.points.new({
    coords = coords,
    distance = dist * 4,
    garageId = garageId
  })

  if not marker then return end

  function markerPoint:nearby()
    drawMarkerOnFrame(coords, marker)
  end
  
  zones[#zones+1] = markerPoint
end

---Runs on tick while ped is in a garage zone
---@param garageId string
---@param garageType "car"|"sea"|"air"
---@param isImpound boolean
local function pedIsInGarageZone(garageId, garageType, isImpound)
  local pedIsInVehicle = cache.vehicle and GetPedInVehicleSeat(cache.vehicle, -1) == cache.ped
  local prompt = isImpound and Config.OpenImpoundPrompt or (pedIsInVehicle and Config.InsertVehiclePrompt or Config.OpenGaragePrompt)
  local action = function()
    if pedIsInVehicle then
      TriggerEvent("jg-advancedgarages:client:store-vehicle", garageId, garageType, false)
    else
      TriggerEvent("jg-advancedgarages:client:open-garage", garageId, garageType, false)
    end
  end

  if inVehicle ~= pedIsInVehicle then
    if Config.UseRadialMenu then
      Framework.Client.RadialMenuAdd(garageId, prompt, action)
    else
      Framework.Client.ShowTextUI(prompt)
    end

    inVehicle = pedIsInVehicle
  end
  
  if Config.UseRadialMenu then return end
  if IsControlJustPressed(0, isImpound and Config.OpenImpoundKeyBind or (pedIsInVehicle and Config.InsertVehicleKeyBind or Config.OpenGarageKeyBind)) then
    action()
  end
end

---@param garages table
local function createTargetZones(garages)
  for _, ped in ipairs(peds) do
    Framework.Client.RemoveTarget(ped)
  end

  for garageId, garage in pairs(garages) do
    for _, zone in ipairs(zones) do zone:remove() end  -- Remove existing zones

    entity = Framework.Client.RegisterTarget(false, garage.coords, garageId, garage.type, garage.garageType)

    peds[#peds+1] = entity
  end
end

---@param garages table
local function createZones(garages)
  for _, zone in ipairs(zones) do zone:remove() end  -- Remove existing zones

  for garageId, garage in pairs(garages) do
    if garage then
      -- Zone
      createLocation(
        garageId,
        garage.coords,
        garage.distance,
        not garage.hideMarkers and garage.markers or false,
        nil,
        function()
          if Config.UseRadialMenu then
            Framework.Client.RadialMenuRemove(garageId)
          else
            Framework.Client.HideTextUI()
          end
          inVehicle = nil
        end,
        function()
          pedIsInGarageZone(garageId, garage.type, garage.garageType == "impound")
        end
      )
    end
  end
end

local function createGarageZonesAndBlips()
  for _, blip in ipairs(blips) do RemoveBlip(blip) end -- Remove existing blips 
  
  local garages = getAvailableGarageLocations()

  if Config.UseTarget then
    createTargetZones(garages)
  else
    createZones(garages)
  end

  for garageId, garage in pairs(garages) do
    if garage then
      -- Blip
      if not garage.hideBlip then
        local blipName = garage.garageType == "impound" and Locale.impound or garage.garageType == "job" and Locale.jobGarage or garage.garageType == "gang" and Locale.gangGarage or Locale.garage
        if garage.uniqueBlips then blipName = blipName .. ": " .. garageId end
        local blip = createBlip(blipName, garage.coords, garage.blip.id, garage.blip.color, garage.blip.scale)
        blips[#blips + 1] = blip
      end
    end
  end
end

RegisterNetEvent("jg-advancedgarages:client:update-blips-text-uis", function()
  cachedGarageLocations = lib.callback.await("jg-advancedgarages:server:get-available-garage-locations", false)
  createGarageZonesAndBlips()
end)

CreateThread(function()
  Wait(2500)
  createGarageZonesAndBlips()
end)

-- Delete peds in case the script restarts
AddEventHandler("onResourceStop", function(resourceName)
  if (GetCurrentResourceName() == resourceName) then
    for _, ped in ipairs(peds) do DeleteEntity(ped) end
  end
end)