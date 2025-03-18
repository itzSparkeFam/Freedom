-- Generated with https://configurator.jgscripts.com at 2/2/2025, 8:48:08 AM

Config = {}
Config.Locale = 'en'
Config.NumberAndDateFormat = 'en-US'
Config.Currency = 'USD'
Config.Framework = 'QBCore'
Config.FuelSystem = 'cdn-fuel'
Config.VehicleKeys = 'qb-vehiclekeys'
Config.Notifications = 'ox_lib'
Config.DrawText = 'ox_lib'
Config.OpenGarageKeyBind = 38
Config.OpenGaragePrompt = '[E] Open Garage'
Config.OpenImpoundKeyBind = 38
Config.OpenImpoundPrompt = '[E] Open Impound'
Config.InsertVehicleKeyBind = 38
Config.InsertVehiclePrompt = '[E] Store Vehicle'
Config.ExitInteriorKeyBind = 38
Config.ExitInteriorPrompt = '[E] Exit Garage'
Config.UseTarget = false
Config.TargetPed = 's_m_y_valet_01'
Config.Target = 'ox_target'
Config.UseRadialMenu = false
Config.RadialMenu = 'ox_lib'
Config.ShowVehicleImages = true
Config.DoNotSpawnInsideVehicle = false
Config.SaveVehicleDamage = true
Config.AdvancedVehicleDamage = true
Config.SaveVehiclePropsOnInsert = true
Config.SpawnVehiclesWithServerSetter = false
Config.TransferHidePlayerNames = false
Config.GarageVehicleTransferCost = 100
Config.EnableTransfers = {
  betweenGarages = true,
  betweenPlayers = false,
}
Config.AllowInfiniteVehicleSpawns = false
Config.JobGaragesAllowInfiniteVehicleSpawns = false
Config.GangGaragesAllowInfiniteVehicleSpawns = false
Config.GarageVehicleReturnCost = 100
Config.GarageVehicleReturnCostSocietyFund = false
Config.GarageShowBlips = true
Config.GarageUniqueBlips = false
Config.GarageUniqueLocations = true
Config.GarageEnableInteriors = true
Config.GarageLocations = {
  ['Legion Square'] = {
    coords = vector3(215.09, -805.17, 30.81),
    spawn = vector4(212.42, -798.77, 30.88, 336.61),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['RideOut Customs'] = {
    coords = vector3(567.673, -137.93, 54.532),
    spawn = vector4(559.454, -138.032, 54.532, 89.729),
    distance = 15,
    type = 'car',
    hideBlip = true,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = false,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Islington South'] = {
    coords = vector3(273.0, -343.85, 44.91),
    spawn = vector4(270.75, -340.51, 44.92, 342.03),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Grove Street'] = {
    coords = vector3(14.66, -1728.52, 29.3),
    spawn = vector4(23.93, -1722.9, 29.3, 310.58),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Mirror Park'] = {
    coords = vector3(1032.84, -765.1, 58.18),
    spawn = vector4(1023.2, -764.27, 57.96, 319.66),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Beach = {
    coords = vector3(-1248.69, -1425.71, 4.32),
    spawn = vector4(-1244.27, -1422.08, 4.32, 37.12),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Great Ocean Highway'] = {
    coords = vector3(-2961.58, 375.93, 15.02),
    spawn = vector4(-2964.96, 372.07, 14.78, 86.07),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Sandy South'] = {
    coords = vector3(217.33, 2605.65, 46.04),
    spawn = vector4(216.94, 2608.44, 46.33, 14.07),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Sandy North'] = {
    coords = vector3(1878.44, 3760.1, 32.94),
    spawn = vector4(1880.14, 3757.73, 32.93, 215.54),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['North Vinewood Blvd'] = {
    coords = vector3(365.21, 295.65, 103.46),
    spawn = vector4(364.84, 289.73, 103.42, 164.23),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Grapeseed = {
    coords = vector3(1713.06, 4745.32, 41.96),
    spawn = vector4(1710.64, 4746.94, 41.95, 90.11),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Paleto Bay'] = {
    coords = vector3(107.32, 6611.77, 31.98),
    spawn = vector4(110.84, 6607.82, 31.86, 265.28),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Boats = {
    coords = vector3(-795.15, -1510.79, 1.6),
    spawn = vector4(-798.66, -1507.73, -0.47, 102.23),
    distance = 20,
    type = 'sea',
    hideBlip = false,
    blip = {
      id = 410,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  TruckingDocks = {
    coords = vector3(1125.353, -3139.493, 5.901),
    spawn = vector4(1114.932, -3139.684, 5.901, 359.087),
    distance = 15,
    type = 'car',
    hideBlip = false,
    blip = {
        id = 357,
        color = 0,
        scale = 0.6,
    },
    hideMarkers = true,
    markers = {
        id = 21,
        size = {
            x = 0.3,
            y = 0.3,
            z = 0.3,
        },
        color = {
            r = 255,
            g = 255,
            b = 255,
            a = 120,
        },
        bobUpAndDown = 0,
        faceCamera = 0,
        rotate = 1,
        drawOnEnts = 0,
    },
  },
  Hospital = {
    coords = vector3(-485.894, -1054.742, 22.589),
    spawn = vector4(-481.242, -1068.823, 22.589, 2.772),
    distance = 25,
    type = 'car',
    hideBlip = false,
    blip = {
        id = 357,
        color = 0,
        scale = 0.6,
    },
    hideMarkers = true,
    markers = {
        id = 21,
        size = {
            x = 0.3,
            y = 0.3,
            z = 0.3,
        },
        color = {
            r = 255,
            g = 255,
            b = 255,
            a = 120,
        },
        bobUpAndDown = 0,
        faceCamera = 0,
        rotate = 1,
        drawOnEnts = 0,
    },
  },  
} -- Added missing closing brace for TruckingDocks

Hangar = {
    coords = vector3(-1243.49, -3391.88, 13.94),
    spawn = vector4(-1258.4, -3394.56, 13.94, 328.23),
    distance = 20,
    type = 'air',
    hideBlip = false,
    blip = {
        id = 423,
        color = 0,
        scale = 0.6,
    },
    hideMarkers = true,
    markers = {
        id = 21,
        size = {
            x = 0.3,
            y = 0.3,
            z = 0.3,
        },
        color = {
            r = 255,
            g = 255,
            b = 255,
            a = 120,
        },
        bobUpAndDown = 0,
        faceCamera = 0,
        rotate = 1,
        drawOnEnts = 0,
    }
}

Config.PrivGarageCreateCommand = 'privategarages'
Config.PrivGarageCreateJobRestriction = {
  'realestate',
}
Config.PrivGarageEnableInteriors = true
Config.PrivGarageHideBlips = false
Config.PrivGarageBlip = {
  id = 357,
  color = 0,
  scale = 0.7,
}
Config.JobGarageShowBlips = true
Config.JobGarageUniqueBlips = false
Config.JobGarageSetVehicleCommand = 'setjobvehicle'
Config.JobGarageRemoveVehicleCommand = 'removejobvehicle'
Config.JobGarageUniqueLocations = true
Config.JobGarageEnableInteriors = true
Config.JobGarageLocations = {
  Police = {
    coords = vector3(-583.265, -432.876, 31.16),
    spawn = {
      vector4(-588.464, -418.983, 31.16, 269.792),
      vector4(-589.289, -408.493, 31.16, 269.364),
    },
    distance = 15,
    type = 'car',
    job = {
      'police',
    },
    hideBlip = true,
    vehiclesType = 'spawner',
    vehicles = {
      {
        model = 'pvccjv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Vapid Caracara',
      },
      {
        model = 'pvajv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Vapid Aleutian',
      },
      {
        model = 'pbbjv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Bravado Buffalo STX',
      },
      {
        model = 'pdglxjv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Declasse Granger 3600XL',
      },
      {
        model = 'pvcjv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Vapid Stanier LE Cruiser',
      },
      {
        model = 'pvsjv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Vapid Scout',
      },
      {
        model = 'pvdtrt',
        plate = false,
        minJobGrade = 5,
        nickname = 'Vapid Dominator (Heat Unit)',
      },
      {
        model = 'pvtjv',
        plate = false,
        minJobGrade = 5,
        nickname = 'Vapid Torrance',
      },
      {
      model = 'sphijv',
      plate = false,
      minJobGrade = 8,
      nickname = 'HVY Insurgent',
      }
    },
    blip = {
      id = 357,
      color = 0,
      scale = 0.8,
    },
    hideMarkers = false,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    showLiveriesExtrasMenu = true,
  },
  Ambulance = {
    coords = vector3(329.177, -575.073, 28.797),
    spawn = {
      vector4(319.754, -574.437, 28.797, 249.715),
      vector4(320.211, -565.625, 28.797, 249.082),
    },
    distance = 15,
    type = 'car',
    job = {
      'ambulance',
    },
    hideBlip = true,
    vehiclesType = 'spawner',
    vehicles = {
      {
        model = 'sandbulance',
        plate = false,
        minJobGrade = 1,
        nickname = 'Vapid Sandstorm (Ambulance)',
      },
      {
      model = 'evajv',
        plate = false,
        minJobGrade = 1,
        nickname = 'Vapid Aleutian (SUV)',
      },
    },
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = false,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    showLiveriesExtrasMenu = true,
  },
  cluckinbell = {
    coords = vector3(-135.606, -251.879, 43.774),
    spawn = {
      vector4(-135.606, -251.879, 43.774, 249.588),
    },
    distance = 5,
    type = 'car',
    job = {
      'cluckinbell',
    },
    hideBlip = false,
    vehiclesType = 'personal',
    vehicles = {},
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = false,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    showLiveriesExtrasMenu = true,
  },
}
Config.GangGarageShowBlips = true
Config.GangGarageUniqueBlips = false
Config.GangGarageSetVehicleCommand = 'setgangvehicle'
Config.GangGarageRemoveVehicleCommand = 'removegangvehicle'
Config.GangGarageUniqueLocations = true
Config.GangGarageEnableInteriors = true
Config.GangGarageLocations = {
  ['Grey Syndicate'] = {
    coords = vector3(-683.168, -886.818, 24.499),
    spawn = {
      vector4(-683.168, -886.818, 24.499, 359.72),
    },
    distance = 15,
    type = 'car',
    gang = {
      'greysyndicate',
    },
    hideBlip = false,
    vehiclesType = 'personal',
    vehicles = {},
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = false,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  Gambinos = {
    coords = vector3(500.767, -1519.129, 28.914),
    spawn = {
      vector4(500.767, -1519.129, 28.914, 48.833),
    },
    distance = 15,
    type = 'car',
    gang = {
      'gambino',
    },
    hideBlip = false,
    vehiclesType = 'personal',
    vehicles = {},
    blip = {
      id = 357,
      color = 0,
      scale = 0.6,
    },
    hideMarkers = false,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
    showLiveriesExtrasMenu = true,
  },
}
Config.ImpoundCommand = 'iv'
Config.ImpoundFeesSocietyFund = 'police'
Config.ImpoundShowBlips = true
Config.ImpoundUniqueBlips = false
Config.ImpoundTimeOptions = {
  0,
  1,
  4,
  12,
  24,
  72,
  168,
}
Config.ImpoundLocations = {
  ['Impound A'] = {
    coords = vector3(410.8, -1626.26, 29.29),
    spawn = vector4(408.44, -1630.88, 29.29, 136.88),
    distance = 15,
    type = 'car',
    job = {
      'police',
    },
    blip = {
      id = 68,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
  ['Impound B'] = {
    coords = vector3(1649.71, 3789.61, 34.79),
    spawn = vector4(1643.66, 3798.36, 34.49, 216.16),
    distance = 15,
    type = 'car',
    job = {
      'police',
    },
    blip = {
      id = 68,
      color = 0,
      scale = 0.6,
    },
    hideBlip = false,
    hideMarkers = true,
    markers = {
      id = 21,
      size = {
        x = 0.3,
        y = 0.3,
        z = 0.3,
      },
      color = {
        r = 255,
        g = 255,
        b = 255,
        a = 120,
      },
      bobUpAndDown = 0,
      faceCamera = 0,
      rotate = 1,
      drawOnEnts = 0,
    },
  },
}
Config.GarageInteriorEntrance = vector4(227.96, -1003.06, -99.0, 358.0)
Config.GarageInteriorVehiclePositions = {
  vec4(233.000000, -984.000000, -99.410004, 118.000000),
  vec4(233.000000, -988.500000, -99.410004, 118.000000),
  vec4(233.000000, -993.000000, -99.410004, 118.000000),
  vec4(233.000000, -997.500000, -99.410004, 118.000000),
  vec4(233.000000, -1002.000000, -99.410004, 118.000000),
  vec4(223.600006, -979.000000, -99.410004, 235.199997),
  vec4(223.600006, -983.599976, -99.410004, 235.199997),
  vec4(223.600006, -988.200012, -99.410004, 235.199997),
  vec4(223.600006, -992.799988, -99.410004, 235.199997),
  vec4(223.600006, -997.400024, -99.410004, 235.199997),
  vec4(223.600006, -1002.000000, -99.410004, 235.199997),
}
Config.ChangeVehiclePlate = 'vplate'
Config.DeleteVehicleFromDB = 'dvdb'
Config.ReturnVehicleToGarage = 'vreturn'
Config.VehicleLabels = {
  spawnName = 'Pretty Vehicle Label',
}
Config.PlayerTransferBlacklist = {
  'spawnName',
}
Config.ReturnToPreviousRoutingBucket = false
Config.__v3Config = true
Config.Config = {}
