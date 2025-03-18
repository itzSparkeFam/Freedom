-- A modified version of "VehicleDeformation" v1.0.1, by Kiminaze. Full credits go to him, so adibe by the license below.
-- Check out his other work: https://kiminazes-script-gems.tebex.io/
--
-- VehicleDeformation License:
--
--   Copyright (c) 2021 Philipp Decker /// FiveM: Kiminaze / Discord: Kiminaze#9097
--   By acquiring a copy of this code snippet for the "FiveM" modification for "Grand Theft 
--   Auto V" you are granted permission to use and modify all of its parts.
--   You are allowed to (re-)distribute and sell resources that have been created with the 
--   help of this code snippet. You have to include this license when doing so.
--   This code snippet is provided "as is" and the copyright holder of this code snippet can 
--   not be held accountable for any damages occuring during the usage or modification of 
--   this code snippet.

local MAX_DEFORM_ITERATIONS = 50 -- iterations for damage application
local DEFORMATION_DAMAGE_THRESHOLD = 0.05 -- the minimum damage value at a deformation point

function getVehicleDeformation(vehicle)
  assert(vehicle ~= nil and DoesEntityExist(vehicle), "Parameter \"vehicle\" must be a valid vehicle entity!")

  -- check vehicle size and pre-calc values for offsets
  local min, max = GetModelDimensions(GetEntityModel(vehicle))
  local X = (max.x - min.x) * 0.5
  local Y = (max.y - min.y) * 0.5
  local Z = (max.z - min.z) * 0.5
  local halfY = Y * 0.5

  -- offsets for deformation check
  local positions = {vector3(-X, Y, 0.0), vector3(-X, Y, Z), vector3(0.0, Y, 0.0), vector3(0.0, Y, Z), vector3(X, Y, 0.0), vector3(X, Y, Z), vector3(-X, halfY, 0.0), vector3(-X, halfY, Z), vector3(0.0, halfY, 0.0), vector3(0.0, halfY, Z), vector3(X, halfY, 0.0), vector3(X, halfY, Z),
                     vector3(-X, 0.0, 0.0), vector3(-X, 0.0, Z), vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, Z), vector3(X, 0.0, 0.0), vector3(X, 0.0, Z), vector3(-X, -halfY, 0.0), vector3(-X, -halfY, Z), vector3(0.0, -halfY, 0.0), vector3(0.0, -halfY, Z), vector3(X, -halfY, 0.0),
                     vector3(X, -halfY, Z), vector3(-X, -Y, 0.0), vector3(-X, -Y, Z), vector3(0.0, -Y, 0.0), vector3(0.0, -Y, Z), vector3(X, -Y, 0.0), vector3(X, -Y, Z)}

  -- get deformation from vehicle
  local deformationPoints = {}
  for i, pos in ipairs(positions) do
    -- translate damage from vector3 to a float
    local dmg = #(GetVehicleDeformationAtPos(vehicle, pos.x, pos.y, pos.z))
    if (dmg > DEFORMATION_DAMAGE_THRESHOLD) then
      table.insert(deformationPoints, {pos, dmg})
    end
  end

  return {
    deformation = deformationPoints,
    dirt = GetVehicleDirtLevel(vehicle)
  }
end

function setVehicleDeformation(vehicle, deformation)
  assert(vehicle ~= nil and DoesEntityExist(vehicle), "Parameter \"vehicle\" must be a valid vehicle entity!")
  assert(deformation ~= nil and type(deformation) == "table", "Parameter \"deformation\" must be a table!")

  local deformationPoints = deformation.deformation
  local dirt = deformation.dirt

  CreateThread(function()
    local handlingMult, damageMult = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDeformationDamageMult"), 20.0
		if handlingMult <= 0.55 then damageMult = 1000.0
		elseif handlingMult <= 0.65 then damageMult = 400.0
		elseif handlingMult <= 0.75 then damageMult = 200.0 end

    for _, def in ipairs(deformationPoints) do
      def[1] = vector3(def[1].x, def[1].y, def[1].z)
    end

    -- iterate over all deformation points and check if more than one application is necessary
    -- looping is necessary for most vehicles that have a really bad damage model or take a lot of damage (e.g. neon, phantom3)
    local deform = true
    local iteration = 0

    while deform and iteration < MAX_DEFORM_ITERATIONS do
      if not DoesEntityExist(vehicle) then return end

      deform = false

      for _, def in ipairs(deformationPoints) do
        if #(GetVehicleDeformationAtPos(vehicle, def[1].x, def[1].y, def[1].z)) < def[2] then
          local offset = def[1] * 2.0
          SetVehicleDamage(vehicle, offset.x, offset.y, offset.z, def[2] * damageMult, 1000.0, true)
          deform = true
        end
      end

      iteration = iteration + 1
      Wait(100)
    end

    SetVehicleDirtLevel(vehicle, dirt)
  end)
end