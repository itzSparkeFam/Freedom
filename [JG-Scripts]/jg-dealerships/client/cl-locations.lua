local blips, points = {}, {}

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

---@param coords vector3
---@param marker table
local function drawMarkerOnFrame(coords, marker)
  ---@diagnostic disable-next-line: missing-parameter
  DrawMarker(marker.id, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, marker.size.x,  marker.size.y, marker.size.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 0, marker.rotate, marker.drawOnEnts)
end

---@param coords vector3
---@param dist number
---@param marker table | false | nil
---@param onEnter function
---@param onExit function
---@param nearby function | nil
local function createLocation(coords, dist, marker, onEnter, onExit, nearby)
  local point = lib.points.new({
    coords = coords,
    distance = dist,
  })

  function point:onEnter() onEnter(self) end
  function point:onExit() onExit(self) end
  if nearby then function point:nearby() nearby(self) end end
  points[#points+1] = point
  
  if not marker then return end

  local markerPoint = lib.points.new({
    coords = coords,
    distance = dist * 4,
  })

  function markerPoint:nearby() drawMarkerOnFrame(coords, marker) end
  points[#points+1] = markerPoint
end


-- New code

local function createDealershipZonesAndBlips()
  for _, point in ipairs(points) do point:remove() end  -- Remove existing zones
  for _, blip in ipairs(blips) do RemoveBlip(blip) end -- Remove existing blips 

  local dealerships = lib.callback.await("jg-dealerships:server:get-locations-data", false)

  for _, dealer in ipairs(dealerships) do
    if dealer and dealer.config then
      if isShowroomAccessAllowed(dealer.name) or (dealer.type == "owned" and dealer.managementAccess) then
        -- Showroom location
        createLocation(
          dealer.config.openShowroom?.coords or dealer.config.openShowroom,
          dealer.config.openShowroom?.size or 5,
          not dealer.config.hideMarkers and dealer.config.markers or false,
          function() Framework.Client.ShowTextUI(Config.OpenShowroomPrompt) end,
          function() Framework.Client.HideTextUI() end,
          function()
            if IsControlJustPressed(0, Config.OpenShowroomKeyBind) then
              TriggerEvent("jg-dealerships:client:open-showroom", dealer.name)
            end
          end
        )

        -- Sell vehicle location (if enabled)
        if dealer.config.enableSellVehicle then
          createLocation(
            dealer.config.sellVehicle?.coords or dealer.config.sellVehicle,
            dealer.config.sellVehicle?.size or 5,
            not dealer.config.hideMarkers and dealer.config.markers or false,
            function() Framework.Client.ShowTextUI(Config.SellVehiclePrompt) end,
            function() Framework.Client.HideTextUI() end,
            function()
              if IsControlJustPressed(0, Config.SellVehicleKeyBind) then
                TriggerEvent("jg-dealerships:client:sell-vehicle", dealer.name)
              end
            end
          )
        end

        -- Blip
        if not dealer.config.hideBlip then
          local blipName = Locale.dealership .. ": " .. dealer.label
          local blip = createBlip(
            blipName,
            dealer.config.openShowroom?.coords or dealer.config.openShowroom,
            dealer.config.blip.id,
            dealer.config.blip.color,
            dealer.config.blip.scale
          )
          
          blips[#blips + 1] = blip
        end
      end
    
      -- Management location
      if dealer.type == "owned" and dealer.managementAccess then
        createLocation(
          dealer.config.openManagement?.coords or dealer.config.openManagement,
          dealer.config.openManagement?.size or 5,
          not dealer.config.hideMarkers and dealer.config.markers or false,
          function() Framework.Client.ShowTextUI(Config.OpenManagementPrompt) end,
          function() Framework.Client.HideTextUI() end,
          function()
            if IsControlJustPressed(0, Config.OpenManagementKeyBind) then
              TriggerEvent("jg-dealerships:client:open-management", dealer.name)
            end
          end
        )
      end
    end
  end
end

RegisterNetEvent("jg-dealerships:client:update-blips-text-uis", function()
  Wait(1000)
  createDealershipZonesAndBlips()
  spawnAllDealershipDisplayVehicles()
end)

CreateThread(function()
  Wait(1000)
  createDealershipZonesAndBlips()
  spawnAllDealershipDisplayVehicles()
end)