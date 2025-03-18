-----------------------------------------------------------------------------------------------------------
-------------------------------------------- VEHICLE TUNING -----------------------------------------------
-----------------------------------------------------------------------------------------------------------
--
-- Here you can create, edit and remove various tuning parts. The changes they make to the handling is all
-- in here, so feel free to modify as you wish. PLEASE bear in mind that if 2 different tuning options
-- modify the same handling values, and are set to overwrite, they could overwrite each other unpredictably
-- Either set the values to NOT overwrite, or make sure that different tuning parts modify unique parts of
-- the handling to prevent undesired results. 
--
-- Here is a guide on what different options mean to help you customise your tuning parts.
--
-----------------------------------------------------------------------------------------------------------
--  name                      The name of the modification that will be shown in the tablet.
-----------------------------------------------------------------------------------------------------------
--  info                      Optional, but you can provide additional info that will show in the UI when
--                            clicking the info icon when they are selecting an upgrade. It could be used 
--                            to warn mechanics of vehicles an upgrade shouldn't be applied on, or results
--                            from your testing of handling values.
-----------------------------------------------------------------------------------------------------------
--  itemName                  For mechanics set up to use an item for upgrades, this is the name of the
--                            required item.
-----------------------------------------------------------------------------------------------------------
--  price                     For mechanics set up to purchase upgrades, this will be the cost to the
--                            mechanic to apply the upgrade.
-----------------------------------------------------------------------------------------------------------
--  audioNameHash             Any in-game vehicle name, or addon sound pack name (ENGINE SWAPS ONLY!)
-----------------------------------------------------------------------------------------------------------
--  handling                  Add/remove handling attributes & values.
--                            More help & info on handling values: https://gtamods.com/wiki/Handling.meta
-----------------------------------------------------------------------------------------------------------
--  handlingApplyOrder        The order in which this tuning option should be applied. This is useful when
--                            tuning options have overlapping handling values! Provide a priority number,
--                            and the lowest numbers will be applied first.
-----------------------------------------------------------------------------------------------------------
--  handlingOverwritesValues  Whether the handling values provided should overwrite the vehicle's existing
--                            values, or whether they should modify the vehicle's existing values. This
--                            also works for negative values too.
--                           
--                            For example: a vehicle's current fDriveInertia value is at 1.0
--                               true  = a value of 0.5 sets fDriveInertia to 0.5
--                               false = a value of 0.5 will mean [1.0 + 0.5] and set fDriveInertia to 1.5
-----------------------------------------------------------------------------------------------------------
-- restricted (optional)      Can either be false (unrestricted) "electric" or "combustion"
-----------------------------------------------------------------------------------------------------------
-- blacklist                  List of archetype names (spawn codes) that cannot use this modification
-----------------------------------------------------------------------------------------------------------

Config.Tuning = {
  --
  -- ENGINE SWAPS
  -- You can customise, or add new engine swap options here.
  --
  engineSwaps = {
    [1] = {
      name = "I4 Turbo 2.5L",
      icon = "engine.svg",
      info = "A twin-turbo charged 2.5L engine. Can reach speeds of up to 100mph!",
      itemName = "i4_engine",
      price = 30000,
      audioNameHash = "sultan2",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.25,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 130.0,
        fClutchChangeRateScaleUpShift = 4.0,
        fClutchChangeRateScaleDownShift = 3.0
      },
      restricted = "combustion",
    },
    [2] = {
      name = "V6 3.3L",
      icon = "engine.svg",
      audioNameHash = "comet4",
      info = "Tuned V6 engine - capable of speeds up to 120mph.",
      itemName = "v6_engine",
      price = 45000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.35,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 145.0,
        fClutchChangeRateScaleUpShift = 5.0,
        fClutchChangeRateScaleDownShift = 4.0
      },
      restricted = "combustion",
    },
    [3] = {
      name = "V8 6.5L",
      icon = "engine.svg",
      info = "Naturally aspirated 6.5L V8. Has awesome backfires and a crackling sound as you let off the gas. Sure to impress.",
      itemName = "v8_engine",
      price = 65000,
      audioNameHash = "jugular",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.45,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 160.0,
        fClutchChangeRateScaleUpShift = 7.0,
        fClutchChangeRateScaleDownShift = 6.0
      },
      restricted = "combustion",
    },
    [4] = {
      name = "V12 6.0L",
      icon = "engine.svg",
      info = "A huge 6L V12 monster. Can reach speeds of over 130mph, be realistic and only put this in vehicles that could realistically fit a V12.",
      itemName = "v12_engine",
      price = 80000,
      audioNameHash = "schafter3",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.5,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 180.0,
        fClutchChangeRateScaleUpShift = 6.0,
        fClutchChangeRateScaleDownShift = 5.0
      },
      restricted = "combustion",
      blacklist = {"panto"} -- Example of the blacklist feature - feel free to remove this (it couldn't fit a v12 though man, come on)
    }
  },

  --
  -- TYRES
  -- You can customise, or add new tyre options here.
  --
  tyres = {
    [1] = {
      name = "Slicks",
      icon = "wheels/offroad.svg",
      info = false,
      itemName = "slick_tyres",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 2,
      handling = {
        fTractionCurveMin = 2.8,
        fTractionCurveMax = 3.0
      },
    },
    [2] = {
      name = "Semi-slicks",
      icon = "wheels/offroad.svg",
      info = false,
      itemName = "semi_slick_tyres",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 2,
      handling = {
        fTractionCurveMin = 2.4,
        fTractionCurveMax = 2.6
      },
    },
    [3] = {
      name = "Offroad",
      icon = "wheels/offroad.svg",
      info = false,
      itemName = "offroad_tyres",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 2,
      handling = {
        fTractionLossMult = 0.0
      },
    }
  },

  --
  -- BRAKES
  -- You can customise, or add new tyre options here.
  --
  brakes = {
    [1] = {
      name = "Ceramic",
      icon = "brakes.svg",
      info = "Powerful brakes with an immense stopping power",
      itemName = "ceramic_brakes",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 3,
      handling = {
        fBrakeForce = 1.5
      },
    }
  },

  --
  -- DRIVETRAINS
  -- You can customise, or add new drivetain options here.
  --
  drivetrains = {
    [1] = {
      name = "AWD",
      icon = "drivetrain.svg",
      info = false,
      itemName = "awd_drivetrain",
      price = 50000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 4,
      handling = {
        fDriveBiasFront = 0.5
      },
    },
    [2] = {
      name = "RWD",
      icon = "drivetrain.svg",
      info = false,
      itemName = "rwd_drivetrain",
      price = 50000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 4,
      handling = {
        fDriveBiasFront = 0.0
      },
    },
    [3] = {
      name = "FWD",
      icon = "drivetrain.svg",
      info = false,
      itemName = "fwd_drivetrain",
      price = 50000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 4,
      handling = {
        fDriveBiasFront = 1.0
      },
    }
  },

  --
  -- TURBOCHARGING
  -- Note: This category is unique as it just enables/disables mod 18 (the standard GTA turbocharging option)
  -- You can't add additional turbocharging options, you can only adjust/remove the existing one.
  -- You can't add any handling changes. Make new items/other categories for that.
  --
  turbocharging = {
    [1] = {
      name = "Turbocharging",
      icon = "turbo.svg",
      info = false,
      itemName = "turbocharger",
      price = 35000,
      restricted = "combustion",
    }
  },

  --
  -- DRIFT TUNING
  -- You can't add additional drift tuning options, you can only adjust/remove the existing one.
  --
  driftTuning = {
    [1] = {
      name = "Drift Tuning",
      icon = "wheels/tuner.svg",
      info = false,
      itemName = "drift_tuning_kit",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 5,
      handling = {
        fInitialDragCoeff = 12.22,
        fInitialDriveForce = 3.0,
        fInitialDriveMaxFlatVel = 155.0,
        fSteeringLock = 58.0,
        fTractionCurveMax = 0.6,
        fTractionCurveMin = 1.3,
        fTractionCurveLateral = 21.0,
        fLowSpeedTractionLossMult = 0.5,
        fTractionBiasFront = 0.49
      },
    }
  },

  --
  -- EXAMPLE CUSTOM NEW CATEGORY
  -- 
  -- ["Transmissions"] = {
  --   [1] = {
  --     name = "8 speed transmission",
  --     icon = "transmission.svg",
  --     info = "Testing making a new category",
  --     itemName = "transmission",
  --     price = 1000,
  --     handlingOverwritesValues = true,
  --     handling = {
  --       nInitialDriveGears = 8
  --     },
  --     restricted = false,
  --   }
  -- }
  --
  -- -- IMPORTANT NOTE --
  -- inside of the config.lua, inside of a mechanic location's "tuning" section, you will need to add an
  -- additional line in order for it to show & be enabled in the tablet 
  --
  -- ["Transmissions"] = { enabled = true, requiresItem = false },
}