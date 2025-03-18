-- OX INVENTORY ITEMS
-- DO NOT COPY PASTE THIS FILE JUST COPY THE ITEMS WITHIN THE TABLE BELOW!
Config.Items = {
  -- Servicing Items
  ["engine_oil"] = {
    label = "Engine Oil",
    weight = 1000,
  },
  ["tyre_replacement"] = {
    label = "Tyre Replacement",
    weight = 1000,
  },
  ["clutch_replacement"] = {
    label = "Clutch Replacement",
    weight = 1000,
  },
  ["air_filter"] = {
    label = "Air Filter",
    weight = 100,
  },
  ["spark_plug"] = {
    label = "Spark Plug",
    weight = 1000,
  },
  ["brakepad_replacement"] = {
    label = "Brakepad Replacement",
    weight = 1000,
  },
  ["suspension_parts"] = {
    label = "Suspension Parts",
    weight = 1000,
  },
  -- Engine Items
  ["i4_engine"] = {
    label = "I4 Engine",
    weight = 1000,
  },
  ["v6_engine"] = {
    label = "V6 Engine",
    weight = 1000,
  },
  ["v8_engine"] = {
    label = "V8 Engine",
    weight = 1000,
  },
  ["v12_engine"] = {
    label = "V12 Engine",
    weight = 1000,
  },
  ["turbocharger"] = {
    label = "Turbocharger",
    weight = 1000,
  },
  -- Electric Engines
  ["ev_motor"] = {
    label = "EV Motor",
    weight = 1000,
  },
  ["ev_battery"] = {
    label = "EV Battery",
    weight = 1000,
  },
  ["ev_coolant"] = {
    label = "EV Coolant",
    weight = 1000,
  },
  -- Drivetrain Items
  ["awd_drivetrain"] = {
    label = "AWD Drivetrain",
    weight = 1000,
  },
  ["rwd_drivetrain"] = {
    label = "RWD Drivetrain",
    weight = 1000,
  },
  ["fwd_drivetrain"] = {
    label = "FWD Drivetrain",
    weight = 1000,
  },
  -- Tuning Items
  ["slick_tyres"] = {
    label = "Slick Tyres",
    weight = 1000,
  },
  ["semi_slick_tyres"] = {
    label = "Semi Slick Tyres",
    weight = 1000,
  },
  ["offroad_tyres"] = {
    label = "Offroad Tyres",
    weight = 1000,
  },
  ["drift_tuning_kit"] = {
    label = "Drift Tuning Kit",
    weight = 1000,
  },
  ["ceramic_brakes"] = {
    label = "Ceramic Brakes",
    weight = 1000,
  },
  -- Cosmetic Items
  ["lighting_controller"] = {
    label = "Lighting Controller",
    weight = 100,
    client = {
      event = "jg-mechanic:client:show-lighting-controller",
    }
  },
  ["stancing_kit"] = {
    label = "Stancer Kit",
    weight = 100,
    client = {
      event = "jg-mechanic:client:show-stancer-kit",
    }
  },
  ["cosmetic_part"] = {
    label = "Cosmetic Parts",
    weight = 100,
  },
  ["respray_kit"] = {
    label = "Respray Kit",
    weight = 1000,
  },
  ["vehicle_wheels"] = {
    label = "Vehicle Wheels Set",
    weight = 1000,
  },
  ["tyre_smoke_kit"] = {
    label = "Tyre Smoke Kit",
    weight = 1000,
  },
  ["bulletproof_tyres"] = {
    label = "Bulletproof Tyres",
    weight = 1000,
  },
  ["extras_kit"] = {
    label = "Extras Kit",
    weight = 1000,
  },
  -- Nitrous & Cleaning Items
  ["nitrous_bottle"] = {
    label = "Nitrous Bottle",
    weight = 1000,
    client = {
      event = "jg-mechanic:client:use-nitrous-bottle",
    }
  },
  ["empty_nitrous_bottle"] = {
    label = "Empty Nitrous Bottle",
    weight = 1000,
  },
  ["nitrous_install_kit"] = {
    label = "Nitrous Install Kit",
    weight = 1000,
  },
  ["cleaning_kit"] = {
    label = "Cleaning Kit",
    weight = 1000,
    client = {
      event = "jg-mechanic:client:clean-vehicle",
    }
  },
  ["repair_kit"] = {
    label = "Repair Kit",
    weight = 1000,
    client = {
      event = "jg-mechanic:client:repair-vehicle",
    }
  },
  ["duct_tape"] = {
    label = "Duct Tape",
    weight = 1000,
    client = {
      event = "jg-mechanic:client:use-duct-tape",
    }
  },
  -- Performance Item
  ["performance_part"] = {
    label = "Performance Parts",
    weight = 1000,
  },
  -- Mechanic Tablet Item
  ["mechanic_tablet"] = {
    label = "Mechanic Tablet",
    weight = 1000,
    client = {
      event = "jg-mechanic:client:use-tablet",
    }
  }
}