-- QBCore INVENTORY ITEMS
-- DO NOT COPY PASTE THIS FILE JUST COPY THE ITEMS WITHIN THE TABLE BELOW!
Config.Items = {
  -- Servicing Items
  engine_oil  = { name = 'engine_oil', label = 'Engine Oil', weight = 1000, type = 'item', image = 'engine_oil.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  tyre_replacement  = { name = 'tyre_replacement', label = 'Tyre Replacement', weight = 1000, type = 'item', image = 'tyre_replacement.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },  
  clutch_replacement = { name = 'clutch_replacement', label = 'Clutch Replacement', weight = 1000, type = 'item', image = 'clutch_replacement.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  air_filter = { name = 'air_filter', label = 'Air Filter', weight = 1000, type = 'item', image = 'air_filter.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  spark_plug = { name = 'spark_plug', label = 'Spark Plug', weight = 1000, type = 'item', image = 'spark_plug.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  suspension_parts = { name = 'suspension_parts', label = 'Suspension Parts', weight = 1000, type = 'item', image = 'suspension_parts.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  brakepad_replacement = { name = 'brakepad_replacement', label = 'Brakepad Replacement', weight = 1000, type = 'item', image = 'brakepad_replacement.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  -- Engine Items
  i4_engine = { name = 'i4_engine', label = 'I4 Engine', weight = 1000, type = 'item', image = 'i4_engine.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  v6_engine = { name = 'v6_engine', label = 'V6 Engine', weight = 1000, type = 'item', image = 'v6_engine.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  v8_engine  = { name = 'v8_engine', label = 'V8 Engine', weight = 1000, type = 'item', image = 'v8_engine.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  v12_engine  = { name = 'v12_engine', label = 'V12 Engine', weight = 1000, type = 'item', image = 'v12_engine.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  turbocharger  = { name = 'turbocharger', label = 'Turbo', weight = 1000, type = 'item', image = 'turbocharger.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  -- Electric Engines
  ev_motor = { name = 'ev_motor', label = 'EV Motor', weight = 1000, type = 'item', image = 'ev_motor.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  ev_battery = { name = 'ev_battery', label = 'EV Battery', weight = 1000, type = 'item', image = 'ev_battery.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  ev_coolant  = { name = 'ev_coolant', label = 'EV Coolant', weight = 1000, type = 'item', image = 'v8_engine.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  -- Drivetrain Items
  awd_drivetrain = { name = 'awd_drivetrain', label = 'AWD Drivetrain', weight = 1000, type = 'item', image = 'awd_drivetrain.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  rwd_drivetrain = { name = 'rwd_drivetrain', label = 'RWD Drivetrain', weight = 1000, type = 'item', image = 'rwd_drivetrain.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  fwd_drivetrain  = { name = 'fwd_drivetrain', label = 'FWD Drivetrain', weight = 1000, type = 'item', image = 'fwd_drivetrain.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  -- Tuning Items
  slick_tyres  = { name = 'slick_tyres', label = 'Slick Tyres', weight = 1000, type = 'item', image = 'slick_tyres.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  semi_slick_tyres = { name = 'semi_slick_tyres', label = 'Semi Slick Tyres', weight = 1000, type = 'item', image = 'semi_slick_tyres.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  offroad_tyres = { name = 'offroad_tyres', label = 'Offroad Tyres', weight = 1000, type = 'item', image = 'offroad_tyres.png', unique = true, useable = false, shouldClose = false, combinable = nil, description = nil },
  ceramic_brakes  = { name = 'ceramic_brakes', label = 'Ceramic Brakes', weight = 1000, type = 'item', image = 'ceramic_brakes.png', unique = true, useable = false, shouldClose = false, combinable = nil, description = nil },
  drift_tuning_kit = { name = 'drift_tuning_kit', label = 'Drift Tuning Kit', weight = 1000, type = 'item', image = 'drift_tuning_kit.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },   
  -- Cosmetic Items
  lighting_controller = { name = 'lighting_controller', label = 'Lighting Controller', weight = 100, type = 'item', image = 'lighting_controller.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = nil },
  stancing_kit = { name = 'stancing_kit', label = 'Stance Kit', weight = 100, type = 'item', image = 'stancing_kit.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = nil },
  cosmetic_part = { name = 'cosmetic_part', label = 'Body Kit', weight = 1000, type = 'item', image = 'cosmetic_part.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  respray_kit = { name = 'respray_kit', label = 'Respray Kit', weight = 1000, type = 'item', image = 'respray_kit.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  vehicle_wheels = { name = 'vehicle_wheels', label = 'Vehicle Wheels Set', weight = 1000, type = 'item', image = 'vehicle_wheels.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  tyre_smoke_kit = { name = 'tyre_smoke_kit', label = 'Tyre Smoke Kit', weight = 1000, type = 'item', image = 'tyre_smoke_kit.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  bulletproof_tyres = { name = 'bulletproof_tyres', label = 'Bulletproof Tyres', weight = 1000, type = 'item', image = 'bulletproof_tyres.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  extras_kit = { name = 'extras_kit', label = 'Extras Kit', weight = 100, type = 'item', image = 'extras_kit.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  -- Nitrous 
  nitrous_bottle = { name = 'nitrous_bottle', label = 'Nitrous Bottle', weight = 1000, type = 'item', image = 'nitrous_bottle.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = nil },
  empty_nitrous_bottle = { name = 'empty_nitrous_bottle', label = 'Empty Nitrous Bottle', weight = 1000, type = 'item', image = 'empty_nitrous_bottle.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  nitrous_install_kit  = { name = 'nitrous_install_kit', label = 'Nitrous Install Kit', weight = 1000, type = 'item', image = 'nitrous_install_kit.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },
  -- Repair & Cleaning Items
  cleaning_kit  = { name = 'cleaning_kit', label = 'Cleaning Kit', weight = 1000, type = 'item', image = 'cleaning_kit.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = nil },
  repair_kit = { name = 'repair_kit', label = 'Vehicle Repair Kit', weight = 1000, type = 'item', image = 'repair_kit.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = nil },
  duct_tape = { name = 'duct_tape', label = 'Duct Tape', weight = 100, type = 'item', image = 'duct_tape.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = nil },
  -- Performance
  performance_part = { name = 'performance_part', label = 'Performance Part', weight = 1000, type = 'item', image = 'performance_part.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
  -- Mechanic Tablet
  mechanic_tablet = { name = 'mechanic_tablet', label = 'Mechanic Tablet', weight = 1000, type = 'item', image = 'mechanic_tablet.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = nil },
}