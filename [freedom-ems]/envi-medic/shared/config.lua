Config = {}

-- UPDATE 1.7.0 --
-- ADDED Config.CallAnimDisabled
-- ADDED Config.HideOnRevive (for sync issues)

-- Default Commands: 
--            /callmedic [server id] - e.g. (callmedic 1) (when SelfRevive is set to false)   -- IF NO SERVER ID IS PROVIDED IT WILL CALL FOR THE PLAYER WHO RAN THE COMMAND
--           /callmedic (when SelfRevive is set to true)
--          /cancelmedic (to cancel the ambulance if it is on the way to you)

Config.CallMedicCommand = 'callmedic' -- Command to call the ambulance
Config.CancelMedicCommand = 'cancelmedic' -- Command to cancel the ambulance if it is on the way to you

-- Client Exports:
--                exports['envi-medic']:SendHelp()       -- sends an ambulance to the player
--                exports['envi-medic']:CancelHelp()     -- cancels the ambulance if it is on the way to the player
--                exports['envi-medic']:IsWalkingToAmbulance()  -- returns true if the player is walking to the back of ambulance
--                exports['envi-medic']:IsInAmbulance()  -- returns true if the player is in the ambulance
--                exports['envi-medic']:IsOnCooldown()   -- returns true if the player is on cooldown
--                exports['envi-medic']:GetMedicPedNetID() -- returns the net id of the medic ped
--                exports['envi-medic']:GetAmbulanceNetID() -- returns the net id of the ambulance


Config.DebugZones = false -- Set to true if you want to see the zones for testing
Config.CommandsDisabled = false -- Set to true if you want to disable the commands - (useful if you want to code your own logic using exports)
Config.FailSafeMode = true  -- Set to true if you want to use FAILSAFE MODE - this will add timeouts to every action to make sure if the player/ the ambulance sets stuck, it will skip to the next stage
                            -- Long story short, AI is dumb and sometimes gets stuck/ lost, this will make sure it doesn't get stuck for too long - (immersion may vary)

-- FAILSAFE MODE SETTINGS --
Config.FailSafeArriveTimeout = 10 -- Time in MINS before the ambulance will skip to the next stage if it is stuck on the way to the player  -- Set To false To Disable
Config.FailSafeRunToPatientTimeout = 25 -- Time in SECONDS before the medic will be teleported to the player if they are stuck on the way to the player (on foot after arriving) -- Set To false To Disable
Config.FailSafeGetInAmbulanceTimeout = 30 -- Time in SECONDS before the player will be teleported into the ambulance if they are stuck on the way to the ambulance -- Set To false To Disable
Config.FailSafeDriveToHospitalTimeout = 5 -- Time in MINS before the ambulance will skip to the the final revive stage if it is stuck on the way to the hospital -- Set To false To Disable

Config.AutoMedicCleanUp = true -- Auto Delete the medic and Ambulances after a certain amount of time - To Prevent Stray Ambulances and Medics
Config.AutoMedicCleanUpTime = 15 -- Time in MINS after the ambulance for the ambulance to force despawn
Config.UltimateTimeOut = true -- Set to true if you want to use the ultimate timeout - this will force the ambulance to despawn -and a MAGIC PED will revive the player
Config.UltimateTimeOutTime = 15 -- Time in MINS before the ambulance will force despawn and a MAGIC PED will revive the player
                              -- Long story short, AI is dumb and sometimes gets stuck/ lost, this will act like the ultimate failsafe - (immersion may vary)
Config.MagicPedModel = `ig_chrisformage` -- Model to spawn for the magic ped [ must be in `ticks` like `s_m_y_blackops_01` (not 's_m_y_blackops_01') ]

Config.RemoveAllItemsOnMedicRevive = false -- Set to true if you want to remove items from the player when the medic revives the player

Config.ItemsToKeep = { -- Items that will be kept on the player when the medic revives the player
    'money',
    'phone',
    'id_card',
    'driver_license',
}

Config.RemoveCertainItemsOnMedicRevive = false -- Set to true if you want to remove certain items from the player when they are revived
                                               -- ONLY USE THIS IF Config.RemoveAllItemsOnMedicRevive IS SET TO FALSE

Config.ItemsToRemove = { -- list of items to remove when the player is revived
  'weapon_carbinerifle',
  'weapon_pistol',
  'weapon_pumpshotgun',
  'weapon_smg',
}   


-- NEW --

Config.HospitalSlowDownAreaRadius = 40.0 -- Radius to check for the ambulance arriving at the hospital - if the player enters this radius the ambulance will slow down
Config.HospitalParkingAreaRadius = 15.0 -- Radius to check for the ambulance pulling into the hospital - if the player enters this radius they will revive (should be smaller than the slow down radius)

-- WASABI CRUTCH SETTINGS --

Config.WasabiCrutch = {
  enabled = false, -- Set to true if you want to use the wasabi-crutch system on final revive (edit in ReviveEvent below)
  type = 'crutch', -- 'crutch' or 'chair'
  time = 10, -- Time in mins before the crutch/chair despawns
}

----------------------------

Config.DisablePlayerControls = true -- Set to true if you want to disable player controls when they are being revived and transported to the hospital
                                    -- Set to false if you want to allow players to move around when they are being transported to the hospital

Config.Timeout = 10 -- Time in mins before the ambulance is despawned if it is does not arrive
Config.Cooldown = 60 -- Time in mins before you can call the ambulance again

Config.SpawnDistance = 400.0 -- How far away you want the ambulance to spawn from the player
Config.SafeDistance = 30.0 -- Distance to check for players when spawning Ambulance - to prevent it spawning infront of people
Config.DispatchDelay = 15 -- Time in seconds before the ambulance starts driving to the location

Config.ArrivalZoneRadius = 100.0 -- Radius to check for the ambulance arriving at the player - if the player leaves this radius the ambulance will leave -- [[ MUST HAVE THE .0 AT THE END ]]
Config.ArrivalDistance = 18.0 -- How close the ambulance needs to be to the player before it stops and the medic gets out

Config.AmbulanceModel = `sandbulance` -- Model to spawn for the ambulance [ must be in `ticks` like `ambulance` (not 'ambulance') ]
Config.MedicModel = `s_m_m_paramedic_01` -- Model to spawn for the medic [ must be in `ticks` like `s_m_m_paramedic_01` (not 's_m_m_paramedic_01') ]
Config.InvincibleMedic = true -- Set to true if you want the medic/ambulance to be invincible

Config.AmbulanceDriveFlag = 787004 -- Driving style for the ambulance to get to the player -- see more here: https://vespura.com/fivem/drivingstyle/   -- [[ NEW - UPDATED FLAG ]]


Config.DropOffSpots = {  -- Where the ambulance will take you - it should always find the closest one
  --['St Feiacre Hospital'] = { dropOff = vec4(1140.0322, -1446.7982, 34.3813, 192.7532), respawnSpot = vec4(1125.2919, -1527.3180, 35.3501, 258.0274)},
  ['Pillbox Medical Hospital']   = { dropOff = vector4(292.231, -582.759, 43.184, 248.963), respawnSpot = vector4(314.577, -584.12, 44.204, 339.934)}, 

}

Config.BlacklistAreas = {  -- Areas that are blacklisted, ambulance will NOT come to a player in these areas
  ['Hospital Area'] = { area = vector4(-501.289, -1002.689, 22.996, 357.941), radius = 50.0 },
  ['Cayo Perico']   = { area = vec4(5034.0801, -5110.3999, 4.9121, 258.0274), radius = 1500.0 }, 

}

Config.SelfRevive = false -- Set to true if you want anyone to be able to use /callmedic to call help for THEMSELVES
                          -- If set to false it will allow players to call EMS for OTHER PLAYERS
                          -- USAGE:
                          -- true:  /callmedic
                          -- false: /callmedic 1    (also needs the players server ID or will just call for the player who ran the command)

Config.JobLocked = false -- Set to true if you want to lock the command to only allow jobs in the Config.Jobs table below
                        -- If set to false it will allow anyone to use it to call EMS


Config.Jobs = {          -- ['job_name'] = MinimumGrade,
  ['police'] = 2,
  ['ambulance'] = 2,
}

Config.CheckJobOnline = true -- Set to true if you want to check for all online players with the job defined in JobToCheck and JobToCheckAmountOnline
                             -- If set to false players will always be able to call EMS even if people are online with the job

Config.JobToCheck = 'ambulance' -- The job to check for
Config.JobToCheckAmountOnline = 3 -- If there is this amount of people online with the job, you can't call a medic.


Config.PaymentType = 'bank'   -- 'cash' / 'bank'

Config.ReviveCostSuccessfulSkillCheck  = 1500      -- How much it costs to be revived if you spawn back in the hospital (if AlwaysTakeToHosptial is set to true and you pass the minigame)
Config.ReviveCostFailedSkillCheck  = 2500      -- How much it costs to be revived if you spawn back in the hospital (if you fail the minigame)  -- will default to this if you do not use skillcheck or if AlwaysTakeToHosptial is set to false


Config.CinematicMode = true -- Set to true if you want the camera to go into cinematic mode when you are being revived
                            -- Set to false if you want the camera to stay where it is when you are being revived

Config.AdvancedAnimations = true -- Set to true if you want to use the advanced animations  (sometimes onesync will break these)
                                 -- Set to false if you want to use the basic animations

Config.MiniGame = true -- Set to true if you want to use the minigame when you are being revived

Config.QBVehicleKeys = false -- Set to true if you want to use the QBVehicleKeys script to lock/unlock the ambulance
                             -- Set to false if you want to use the custom lock/unlock functions below

Config.AlwaysTakeToHosptial = true -- Set to true if you want to always take the player to the closest hospital when they are revived
                                    -- Set to false if you want to take the player to be revived on the spot and free to walk away

Config.DeleteAmbulanceTimer = 30 -- Time in seconds before the ambulance is deleted after the player has been revived

Config.Society = 'ambulance' -- Name of Society to send funds to  - set to false to disable

Config.CheckPlayerIsDead = true -- Set to true if you want to check if the player is dead before sending the ambulance
                                -- Set to false if you want to call the ambulance regardless if the player is dead or not

Config.CheckForPhone = false -- Set to true if you want to check if the player has a phone before they can call for help
                            -- Set to false if you want to allow anyone to call for help regardless if they have a phone or not
Config.PhoneItems = { 'phone', 'phone2', } -- Items to check for if CheckForPhone is set to true (supports multiple items)

Config.CheckOnDuty = false -- Set to true if you want to check if the player is on duty when doing any job checks

Config.DriveSpeedLevel = 20.0 -- NOTE: This MUST have a .0 value on the end - This is the speed the ambulance will drive at - 20.0 is a good speed but play with this setting to get the right speed for your server

Config.AnimationOffsetZ = -0.9 -- This is the offset for the animation when the medic is reviving the player - play with this setting to get the right position if you ambulancejob causes the medic to be high or low during anims - default is -0.9 -  negative number for lower, number for higher

Config.AnimationTime = 1000 -- This is an addition for the Wait time for animation syncing issues. Adjust this for your server if the animations are out of sync

Config.FreezeOnRevive = true -- Set to true if you want to freeze the player when they are being revived
                             -- Set to false if you want the player to be able to move around when they are being revived
-- NEW IN 1.7.0 -- 
Config.CallAnimDisabled = true -- Set to true if you want to disable the call animation

Config.HideOnRevive = true -- Set to true if you want to hide the player when they are being revived - this was added to 'fix' some onesync syncronised anim issues that were introudced into FiveM recently

function AddSocietyFunds(amount)
  -- this will work for qbcore-management, qbx-management and esx_society by default -- edit here for others
  Framework.SocietyAddMoney(Config.Society, 'job', amount)
end

function SkillCheck()
  return lib.skillCheck({areaSize = 100, speedMultiplier = 1.5}, {'e'})
end

function CustomUnlockVehicleEvent(ambulance)
  
end

function CustomLockVehicleEvent(ambulance)

end


--- NEW ---

-- AUTO RESOURCE DETECTION FOR REVIVE AND FUEL EVENTS --
-- DO NOT EDIT UNLESS YOU HAVE A GOOD UNDERSTANDING --

local reviveEvent = nil
local fuelEvent = nil

CreateThread(function()
  if GetResourceState('qb-ambulancejob') == 'started' then
     reviveEvent = 'hospital:client:Revive'
     return
  end
  if GetResourceState('esx_ambulancejob') == 'started' then
    reviveEvent = 'esx_ambulancejob:revive'
    return
  end
  if GetResourceState('wasabi_ambulance') == 'started' then
    reviveEvent = 'wasabi_ambulance:revive'
    return
  end
  if GetResourceState('brutal_ambulancejob') == 'started' then
    reviveEvent = 'brutal_ambulancejob:revive'
    return
  end
  if GetResourceState('qbx_medical') == 'started' then
    reviveEvent = 'qbx_medical:client:playerRevived'
    return
  end
  if GetResourceState('ak47_ambulancejob') == 'started' then
    reviveEvent = 'ak47_ambulancejob:revive'
    return
  end
  if GetResourceState('osp_ambulance') == 'started' then
    reviveEvent = 'hospital:client:Revive'
    return
  end
  print('ERROR: No Ambulance Job Detected - Please add custom ReviveEvent in config.lua')
  reviveEvent = nil
end)

CreateThread(function()
  if GetResourceState('LegacyFuel') == 'started' then
     fuelEvent = 'LegacyFuel'
     return
  end
  if GetResourceState('cdn-fuel') == 'started' then
    fuelEvent = 'cdn-fuel'
    return
  end
  if GetResourceState('BigDaddy-Fuel') == 'started' then
    fuelEvent = 'BigDaddy-Fuel'
    return
  end
  if GetResourceState('ps-fuel') == 'started' then
    fuelEvent = 'ps-fuel'
    return
  end
  if GetResourceState('okokGasStation') == 'started' then
    fuelEvent = 'okokGasStation'
    return
  end
  if GetResourceState('qs-fuelstations') == 'started' then
    fuelEvent = 'qs-fuelstations'
    return
  end
end)

function ReviveEvent(finalRevive)
  if reviveEvent == nil then
      print('ERROR: No Ambulance Job Detected - Please add custom Revive Event in config.lua')
      return
  end
  if Config.FreezeOnRevive then
    FreezeEntityPosition(cache.ped, true)
  end
  TriggerEvent(reviveEvent, cache.ped)
  if finalRevive then
    -- do additional things here
    if Config.WasabiCrutch.enabled then
      if Config.WasabiCrutch.enabled then
        if Config.WasabiCrutch.type == 'crutch' then
          exports.wasabi_crutch:SetCrutchTime(PlayerId(), Config.WasabiCrutch.time)
        elseif Config.WasabiCrutch.type == 'chair' then
          exports.wasabi_crutch:SetChairTime(PlayerId(), Config.WasabiCrutch.time)
        end
      end
    end
  end
end

function FuelEvent(ambulance)
  if fuelEvent and GetResourceState('ox_fuel') ~= 'started' then
    exports[fuelEvent]:SetFuel(ambulance, 100)
    return
  elseif GetResourceState('ox_fuel') == 'started' then
    Entity(ambulance).state.fuel = 100.0
    return
  end
  print('ERROR: No Fuel Resource Detected - Please add custom Fuel Event in config.lua')
  fuelEvent = nil
end

----------------------------------------------

Config.Lang = {

  ambulance_called = "An ambulance has been called for you!",
  ambulance_timeout = "The ambulance has timed out",
  ambulance_busy = "We're too busy right now.. Call back later!",
  ambulance_area_blacklisted = "Doesn't look like we can come to that area!",
  ambulance_area_blacklisted2 = "Sorry, we can\'t go to that area. Call back later.",
  ambulance_water = "Sorry, we hate water! - Try again later!",
  ambulance_dispatched = "An ambulance has been dispatched!",
  ambulance_help_arrived = "Help has arrived!",
  ambulance_resuscitated = "You have been successfully resuscitated!",
  ambulance_transported = "You have been resuscitated and need to be transported to the hospital!",
  ambulance_next_stop = "Next Stop - ",
  too_many_medics = "There are too many Medical Professionals on duty to call for local medical assistance",
  unauthorized_medical_call = "You are not authorized to call for medical",
  invalid_server_id = "We can\'t find any active citizens from the ID you provided! Please call back later.",
  medical_treatment_paid = 'You paid $%s for Medical Treatment',
  ambulance_no_pay = 'You can\'t afford your Medical Bills.. Get a job, you bum!',
  ambulance_left_area = 'You left the area and the ambulance has left!',
  ambulance_not_dead = 'It doesn\'t sound like the patient needs Emergency Medical Assistance?!',
  no_phone = 'You don\'t have a phone to call for help!',
  ambulance_ultimate_failsafe = 'KIFFLOM! The ambulance has failed to arrive, you will be revived by the power of Epsilon!',
  ambulance_ultimate_failsafe_healing = 'Baninishing Demons...',

  -- NEW --
  keep_items = 'You have been revived but have lost some items.',

}