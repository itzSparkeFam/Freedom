local blips, zones = {}, {}

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

-- 
-- Create all mechanic mod menu zones
-- 

function createMechanicZonesAndBlips()
  -- Create shops & stashes
  createMechanicShops()
  createMechanicStashes()

  for _, zone in ipairs(zones) do zone:remove() end  -- Remove existing zones
  for _, blip in ipairs(blips) do RemoveBlip(blip) end -- Remove existing blips 

  -- 
  -- Mod/Tuning Menus
  --

  local mechanicsData = lib.callback.await("jg-mechanic:server:get-mechanic-locations-data", false)
  
  for _, mechanicData in pairs(mechanicsData) do
    local name, label = mechanicData.name, mechanicData.label -- from DB
    local mechanicConfig = Config.MechanicLocations[name] or {} -- from Config
    local locations, blip, mods = mechanicConfig.locations, mechanicConfig.blip, mechanicConfig.mods
    local isMechanicEmployee = lib.callback.await("jg-mechanic:server:is-mechanic-employee", false, name)

    if locations and type(locations) == "table" and #locations > 0 and mods then
      for _, location in ipairs(locations) do
        if not location.employeeOnly or isMechanicEmployee then
          zones[#zones+1] = lib.zones.box({
            coords = location.coords,
            size = vector3(location.size, location.size, location.size),
            debug = Config.Debug,
            onEnter = function() onEnterModsZone(name, label) end,
            onExit = onExitModsZone
          })
    
          if blip and location.showBlip then
            local blipName = Locale.mechanic
            local mechName = label ~= "" and label or name
            if Config.UniqueBlips then blipName = blipName .. ": " .. mechName end
            blips[#blips+1] = createBlip(blipName, location.coords, blip.id, blip.color, blip.scale)
          end
        end
      end
    end
  end

  -- 
  -- Car Lifts
  -- 

  local lifts, attempts, maxAttempts = false, 0, 3
  while not lifts and attempts < maxAttempts do
    lifts = lib.callback.await("jg-mechanic:server:get-created-lifts")
    attempts += 1
    Wait(2500)
  end

  if not lifts then return end

  for mechanicId, mechanicLifts in pairs(lifts) do
    if mechanicLifts and Config.MechanicLocations[mechanicId] then
      local mechanicType = Config.MechanicLocations[mechanicId].type
      local isMechanicEmployee = lib.callback.await("jg-mechanic:server:is-mechanic-employee", false, mechanicId)

      if mechanicType == "self-service" or (mechanicType == "owned" and isMechanicEmployee) then
        for _, lift in ipairs(mechanicLifts) do
          zones[#zones+1] = lib.zones.box({
            coords = lift.coords,
            size = vector3(5.5, 5.5, 5.5),
            rotation = lift.coords.w,
            debug = Config.Debug,
            onEnter = function() onEnterCarliftZone(lift) end,
            onExit = onExitCarliftZone
          })
        end
      end
    end
  end


end

RegisterNetEvent("jg-mechanic:client:refresh-mechanic-zones-and-blips", function()
  Wait(1000)
  createMechanicZonesAndBlips()
end)

CreateThread(function()
  Wait(1000)
  createMechanicZonesAndBlips()
end)