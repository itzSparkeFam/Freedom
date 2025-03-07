--[[

Anything that needs a ped should look like this at the bottom of each shop.

targets = {
		{
			ped = `s_m_y_cop_01`,
			loc = vector3(480.45, -996.69, 29.68),
			heading = 84.76,
		}
		}
		},

- When you want to look up a ped to use for a shop follow this link: https://docs.fivem.net/docs/game-references/ped-models/

- The heading will point the ped into the direction you need the ped to be in. So in city you can do /heading in chat or in the F8 you can do heading to copy the heading.

- The Vector3 after you copy those coords you need to subtract 1.01 from the Z axis (X:, Y:, Z:) These coords belong in loc = "vector3" Reason for this is because the ped will levitate haha!

- If you want a scenario you can add it preferably under the vector e.g. (scenario = "Name of Scenario")

- If you want to joblock something follow the example below.

s_m_m_paramedic_01 - Paramedic ped    s_m_m_doctor_01 - Doctor ped

groups = {
	mechanic = 0,
	},

For example lets say you want that to be locked to a certain rank in the weed job you'll change it from mechanic to whitewidow = 3 for third rank within the said job.

]]





return {
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8

		}, inventory = {

			-- Food Items
			{ name = 'pixelsandwich', price = 75 },
			{ name = 'pixelburger', price = 75},

			-- Snack Items
			{ name = 'pixelegochaserbar', price = 50},
			{ name = 'pixelmeteoritebar', price = 50},
			{ name = 'pixelearthquakebar', price = 50},

			-- Desert Items
			{ name = 'pixelmuffin', price = 50},
			{ name = 'pixelcookie', price = 50},
			{ name = 'pixelchococookie', price = 50},
			{ name = 'pixelcakeslice', price = 50},

			-- Drink Items
			{ name = 'pixelwater', price = 25},
			{ name = 'pixelcoffee', price = 35},
			{ name = 'pixeljunkenergy', price = 35},
			{ name = 'pixelcola', price = 35},
			{ name = 'pixelorangotang', price = 35},
			{ name = 'pixelsprunk', price = 35},

			-- Stress Relief
			{ name = 'pixelcigarette', price = 50},

		}, locations = {
			vec3(25.7, -1347.3, 29.49), -- Done
			vec3(-3038.71, 585.9, 7.9), -- Done
			vec3(-3241.47, 1001.14, 12.83), -- Done
			vec3(1728.66, 6414.16, 35.03), -- Done
			vec3(1697.99, 4924.4, 42.06), -- Done
			vec3(1961.48, 3739.96, 32.34), -- Done
			vec3(547.79, 2671.79, 42.15), -- Done
			vec3(2679.25, 3280.12, 55.24), -- Done
			vec3(2557.94, 382.05, 108.62), -- Done
			vec3(373.55, 325.56, 103.56), -- Done
		
		}, targets = {
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(24.45, -1345.55, 28.49), -- Done
			heading = 271.41,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(-3040.59, 584.05, 6.90), -- Done
			heading = 13.17,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(-3244.06, 1000.12, 11.82), -- Done
			heading = 354.16,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(1728.64, 6416.76, 34.03), -- Done
			heading = 240.6,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(1697.36, 4923.46, 41.05), -- Done
			heading = 322.44,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(1959.2, 3741.57, 31.33), -- Done
			heading = 299.57,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(549.28, 2669.58, 41.15), -- Done
			heading = 97.13,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(2676.53, 3280.24, 54.23), -- Done
			heading = 334.29,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(2555.57, 380.89, 107.61), -- Done
			heading = 353.31,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(373.017, 328.147, 102.556),
			heading = 265.053,
			}
		}
	},

	Liquor = {
		name = 'Liquor Store',
		blip = {
			id = 93, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'pixelwhiskey', price = 95 },
			{ name = 'pixelbeer', price = 75 },
			{ name = 'pixelvodka', price = 100 },
			{ name = 'pixelchampagne', price = 85 },
			{ name = 'pixeltequilla', price = 95 },
			{ name = 'pixelwine', price = 95 },

		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319),
		}, targets = {
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(1134.2, -983.06, 45.41), 
			heading = 271.41,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(-1221.4, -907.91, 11.32), 
			heading = 31.8,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(-1486.68, -377.54, 39.15), 
			heading = 131.14,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(-2966.35, 391.59, 14.03), 
			heading = 75.28,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(1165.26, 2710.86, 37.15), 
			heading = 176.89,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(1391.79, 3606.1, 33.97), 
			heading = 195.48,
			},
			{
			ped = `mp_m_shopkeep_01`,
			loc = vector3(-1391.44, -606.07, 29.31), 
			heading = 113.55,
			}
		}
	},
	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 60 },
			{ name = 'radio', price = 500 },
			{ name = 'spray', price = 80000 },
			{ name = 'spray_remover', price = 150000 },
			{ name = 'racingtablet', price = 100000 },
		}, locations = {
			vec3(2748.0, 3473.0, 55.67), -- Done
			vec3(342.99, -1298.26, 32.51), -- Done
			vec3(45.693, -1748.961, 29.607), -- Done
		}, targets = {
			{
			ped = `u_m_y_chip`,
			loc = vector3(2747.94, 3473.3, 54.66), -- Done
			heading = 243.92,
			},
			{
			ped = `u_m_y_chip`,
			loc = vector3(343.03, -1298.32, 31.5),
			heading = 158.63,
			},
			{
				ped = `u_m_y_chip`,
				loc = vector3(45.693, -1748.961, 28.597), -- Done
				heading = 50.301,
			
	
			},
		},
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 10, metadata = {registered = false}, license = 'weapon' },
			{ name = 'ammo-shotgun', price = 12, metadata = {registered = false}, license = 'weapon2' },
			{ name = 'ammo-rifle', price = 14, metadata = {registered = false}, license = 'weapon3'},
			{ name = 'ammo-rifle2', price = 15, metadata = {registered = false}, license = 'weapon3'},
			{ name = 'WEAPON_KNIFE', price = 575 },
			{ name = 'WEAPON_FLASHLIGHT', price = 450 },
			{ name = 'WEAPON_GOLFCLUB', price = 650 },
			{ name = 'WEAPON_HATCHET', price = 675 },
			{ name = 'WEAPON_MACHETE', price = 675 },
			{ name = 'WEAPON_BAT', price = 545 },
			{ name = 'WEAPON_P210', price = 12500, metadata = { registered = true }, license = 'weapon' },
			{ name = 'WEAPON_P30L', price = 12500, metadata = { registered = true }, license = 'weapon' },
		    { name = 'WEAPON_R590', price = 85000, metadata = { registered = true }, license = 'weapon2' },
			{ name = 'WEAPON_M500', price = 85000, metadata = { registered = true }, license = 'weapon2' },
			{ name = 'WEAPON_RAM7', price = 110000, metadata = { registered = true }, license = 'weapon3' },
			{ name = 'WEAPON_DMK18', price = 110000, metadata = { registered = true }, license = 'weapon3' },
		}, locations = {
			vec3(-662.180, -934.961, 21.829), -- Done
			vec3(810.25, -2157.60, 29.62), -- Done
			vec3(1693.44, 3760.16, 34.71), -- Done
			vec3(-330.24, 6083.88, 31.45), -- Done
			vec3(252.63, -50.00, 69.94), -- Done
			vec3(22.56, -1109.89, 29.80), -- Done
			vec3(2567.69, 294.38, 108.73), -- Done
			vec3(-1117.58, 2698.61, 18.55), -- Done
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(-662.61, -933.51, 20.82), -- Done
			heading = 177.17,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(810.41, -2159.09, 28.61), -- Done
			heading = 358.76,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(1692.0, 3760.81, 33.70), -- Done
			heading = 227.35,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(-331.77, 6085.04, 30.44), -- Done
			heading = 22.49,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(253.93, -50.51, 68.93), -- Done
			heading = 68.39,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(22.6, -1105.32, 28.75), -- Done
			heading = 152.24,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(2568.08, 292.49, 107.72), -- Done
			heading = 2.14,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(-1119.06, 2699.8, 17.54), -- Done
			heading = 219.72,
		},
		{
			ped = `s_m_y_ammucity_01`,
			loc = vector3(842.55, -1035.43, 27.18),
			heading = 2.8,
		}
		}
		},
	
		--[[
	Blackmarket1 = {
		name = 'Blackmarket',
		inventory = {
			{ name = 'WEAPON_KEYBOARD', price = 100000},
			{ name = 'WEAPON_SWITCHBLADE', price = 25000},
			{ name = 'WEAPON_CERAMICPISTOL', price = 75000},
			{ name = 'WEAPON_PISTOLXM3', price = 125000},
			{ name = 'WEAPON_MARKSMANPISTOL', price = 400000},
			{ name = 'WEAPON_NAVYREVOLVER', price = 350000},
			{ name = 'WEAPON_REVOLVER', price = 150000},
			{ name = 'WEAPON_REVOLVER_MK2', price = 200000},
			{ name = 'WEAPON_SNSPISTOL_MK2', price = 80000},
			{ name = 'WEAPON_VINTAGEPISTOL', price = 100000},
			{ name = 'WEAPON_COMBATPISTOL', price = 250000},
			{ name = 'ammo-9', price = 25},
			{ name = 'ammo-22', price = 10},
			{ name = 'ammo-38', price = 45},
			{ name = 'ammo-44', price = 250},
			{ name = 'ammo-45', price = 75}
		}, locations = {
			vector3(-2299.53, 336.79, 184.6)
		}, targets = {
			{
			ped = `u_m_y_chip`,
			loc = vector3(-2299.53, 336.78, 183.5), -- Done
			heading = 207.62,
		}
		}
		},
	 Blackmarket2 = {
		name = 'Blackmarket',
		inventory = {
			{ name = 'WEAPON_SWITCHBLADE', price = 25000},
			{ name = 'WEAPON_KNUCKLE', price = 50000},
			{ name = 'WEAPON_ASSAULTSMG', price = 300000},
			{ name = 'WEAPON_GUSENBERG', price = 400000},
			{ name = 'WEAPON_MACHINEPISTOL', price = 280000},
			{ name = 'WEAPON_MICROSMG', price = 250000},
			{ name = 'WEAPON_MINISMG', price = 250000},
			{ name = 'WEAPON_APPISTOL', price = 180000},
			{ name = 'ammo-rifle', price = 100},
			{ name = 'ammo-9', price = 50},
			{ name = 'ammo-45', price = 75}
		}, locations = {
			vector3(-1428.92, 6760.04, 5.88)
		}, targets = {
			{
			ped = `u_m_y_chip`,
			loc = vector3(-1428.87, 6760.03, 4.87), -- Done
			heading = 160.64,
		}
		}
		},
	Blackmarket3 = {
		name = 'Blackmarket',
		inventory = {
			{ name = 'WEAPON_KNUCKLE', price = 50000},
			{ name = 'WEAPON_BATTLEAXE', price = 75000},
			{ name = 'WEAPON_ADVANCEDRIFLE', price = 600000},
			{ name = 'WEAPON_CARBINERIFLE', price = 650000},
			{ name = 'WEAPON_COMPACTRIFLE', price = 700000},
			{ name = 'WEAPON_MILITARYRIFLE', price = 800000},
			{ name = 'WEAPON_TACTICALRIFLE', price = 7500000},
			{ name = 'WEAPON_HEAVYRIFLE', price = 800000},
			{ name = 'ammo-rifle', price = 100},
			{ name = 'ammo-rifle2', price = 150}
		}, locations = {
			vector3(-281.06, -2773.83, 4.99)
		}, targets = {
			{
			ped = `u_m_y_chip`,
			loc = vector3(-280.06, -2773.45, 3.98), -- Done
			heading = 139.29,
		}
		}
	},
	Blackmarket4 = {
		name = 'Blackmarket',
		inventory = {
			{ name = 'WEAPON_BATTLEAXE', price = 75000},
			{ name = 'WEAPON_KEYBOARD', price = 100000},
			{ name = 'WEAPON_COMBATSHOTGUN', price = 450000},
			{ name = 'WEAPON_DBSHOTGUN', price = 100000},
			{ name = 'WEAPON_HEAVYSHOTGUN', price = 500000},
			{ name = 'WEAPON_PUMPSHOTGUN_MK2', price = 350000},
			{ name = 'WEAPON_SAWNOFFSHOTGUN', price = 300000},
			{ name = 'ammo-shotgun', price = 50}
		}, locations = {
			vector3(2468.51, -411.9, 93.32)
		}, targets = {
			{
			ped = `u_m_y_chip`,
			loc = vector3(-280.06, -2773.45, 3.98), -- Done
			heading = 139.29,
		}
		}
	},

	]]--

		BennysSupplies = {
			name = 'Bennys Supplies',
			groups = {
				bennys = 1,
				},
			inventory = {
				{ name = 'engine_oil', price = 1500},
				{ name = 'tyre_replacement', price = 1500},
				{ name = 'clutch_replacement', price = 1500},
				{ name = 'air_filter', price = 1500},
				{ name = 'spark_plug', price = 1500},
				{ name = 'brakepad_replacement', price = 1500},
				{ name = 'suspension_parts', price = 1500},
				{ name = 'i4_engine', price = 1500},
				{ name = 'v6_engine', price = 1500},
				{ name = 'v8_engine', price = 1500},
				{ name = 'v12_engine', price = 1500},
				{ name = 'turbocharger', price = 1500},
				{ name = 'ev_motor', price = 1500},
				{ name = 'ev_battery', price = 1500},
				{ name = 'ev_coolant', price = 1500},
				{ name = 'awd_drivetrain', price = 1500},
				{ name = 'rwd_drivetrain', price = 1500},
				{ name = 'fwd_drivetrain', price = 1500},
				{ name = 'slick_tyres', price = 1500},
				{ name = 'semi_slick_tyres', price = 1500},
				{ name = 'offroad_tyres', price = 1500},
				{ name = 'drift_tuning_kit', price = 1500},
				{ name = 'ceramic_brakes', price = 1500},
				{ name = 'lighting_controller', price = 1500},
				{ name = 'stancing_kit', price = 1500},
				{ name = 'cosmetic_part', price = 1500},
				{ name = 'respray_kit', price = 1500},
				{ name = 'vehicle_wheels', price = 1500},
				{ name = 'tyre_smoke_kit', price = 1500},
				{ name = 'extras_kit', price = 1500},
				{ name = 'nitrous_bottle', price = 1500},
				{ name = 'nitrous_install_kit', price = 1500},
				{ name = 'empty_nitrous_bottle', price = 1500},
				{ name = 'cleaning_kit', price = 1500},
				{ name = 'repair_kit', price = 500},
				{ name = 'duct_tape', price = 250},
				{ name = 'performance_part', price = 1500},
				{ name = 'mechanic_tablet', price = 1500},
				{ name = 'racingtablet', price = 10000},


			}, 
			locations = {
				vector3(-1164.615, -2022.183, 13.161),
			}, 
				targets = {
			{
				ped = `a_m_m_mlcrisis_01`,
				loc = vector3(-935.481, -2030.157, 9.526),
				heading = 129.32,
			}
			}
			},

	 		BaysideMechanic = {
				name = 'Bayside Mechanic Supplies',
				groups = {
					bayside = 1,
					},
				inventory = {
					{ name = 'engine_oil', price = 1500},
					{ name = 'tyre_replacement', price = 1500},
					{ name = 'clutch_replacement', price = 1500},
					{ name = 'air_filter', price = 1500},
					{ name = 'spark_plug', price = 1500},
					{ name = 'brakepad_replacement', price = 1500},
					{ name = 'suspension_parts', price = 1500},
					{ name = 'turbocharger', price = 1500},
					{ name = 'ev_motor', price = 1500},
					{ name = 'ev_battery', price = 1500},
					{ name = 'ev_coolant', price = 1500},
					{ name = 'awd_drivetrain', price = 1500},
					{ name = 'rwd_drivetrain', price = 1500},
					{ name = 'fwd_drivetrain', price = 1500},
					{ name = 'slick_tyres', price = 1500},
					{ name = 'semi_slick_tyres', price = 1500},
					{ name = 'offroad_tyres', price = 1500},
					{ name = 'drift_tuning_kit', price = 1500},
					{ name = 'ceramic_brakes', price = 1500},
					{ name = 'lighting_controller', price = 1500},
					{ name = 'stancing_kit', price = 1500},
					{ name = 'cosmetic_part', price = 1500},
					{ name = 'respray_kit', price = 1500},
					{ name = 'vehicle_wheels', price = 1500},
					{ name = 'tyre_smoke_kit', price = 1500},
					{ name = 'extras_kit', price = 1500},
					{ name = 'nitrous_bottle', price = 1500},
					{ name = 'nitrous_install_kit', price = 1500},
					{ name = 'empty_nitrous_bottle', price = 1500},
					{ name = 'cleaning_kit', price = 1500},
					{ name = 'repair_kit', price = 1500},
					{ name = 'duct_tape', price = 1500},
					{ name = 'performance_part', price = 1500},
					{ name = 'mechanic_tablet', price = 1500},
					{ name = 'racingtablet', price = 10000},
	
	
				}, 
				locations = {
					vector3(2685.56, 3464.925, 55.219),
				}, 
					targets = {
				{
					ped = `s_m_m_trucker_01`,
					loc = vector3(2685.56, 3464.925, 55.219),
					heading = 157.0,
				}
				}
				},

		PoliceArmory = {
			name = 'Police Armory',
			groups = shared.police,
			inventory = {
			{ name = 'WEAPON_STUNGUN', 			price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'WEAPON_NIGHTSTICK', 		price = 0, grade = 1 },
			{ name = 'WEAPON_FLASHLIGHT', 		price = 0, grade = 1 },
			{ name = 'uvlight', 				price = 0, grade = 1 },
			{ name = 'handcuffs', 				price = 0, grade = 1 },
			{ name = 'gunrack', 				price = 0, grade = 1 },
			{ name = 'boltcutter', 				price = 0, grade = 1 },
			{ name = 'armor', 					price = 0, grade = 1 },
			{ name = 'heavyarmor', 				price = 0, grade = 1 },
			{ name = 'radio', 					price = 0, grade = 1 },
			{ name = 'mic_walkie', 				price = 0, grade = 1 },
			{ name = 'police_stormram', 		price = 0, grade = 1 },
			{ name = 'binoculars',        		price = 0, grade = 1 },
			{ name = 'spray_remover',        	price = 0, grade = 1 },
			{ name = 'bodycam',        			price = 0, grade = 1 },
			{ name = 'ammo-9', 					price = 0, grade = 1 },
			{ name = 'ammo-shotgun', 			price = 0, grade = 1 }, 
			{ name = 'ammo-rifle', 				price = 0, grade = 1 }, 
			{ name = 'WEAPON_TGLOCK19', 		price = 0, metadata = { registered = true, serial = 'POL' }, grade = 1 },
			{ name = 'WEAPON_M500', 			price = 0, metadata = { registered = true, serial = 'POL' }, grade = 1 },
			{ name = 'WEAPON_BAR15', 			price = 0, metadata = { registered = true, serial = 'POL'}, grade = 1 },
			{ name = 'WEAPON_SPECIALCARBINE', 	price = 0, metadata = { registered = true, serial = 'POL' }, grade = 1 },
		}, 
			locations = { 	vec3(479.21, -996.7, 29.68),
		}, 
			targets = {
		{
			ped = `s_m_y_cop_01`,
			loc = vector3(480.45, -996.69, 29.68),
			heading = 84.76,
		}
		}
		},

		MedicalSupplies = {
			name = 'Medical Supplies',
			groups = {
				ambulance = 1,
				},
			inventory = {
			{ name = 'radio', 			price = 0, grade = 1 },
			{ name = 'mic_walkie', 		price = 0, grade = 1 },
			{ name = 'medbag', 			price = 0, grade = 1 },
			{ name = 'medikit', 		price = 0, grade = 1 },
			{ name = 'tweezers', 		price = 0, grade = 3 },
			{ name = 'suturekit', 		price = 0, grade = 3 },
			{ name = 'icepack', 		price = 0, grade = 1 },
			{ name = 'burncream', 		price = 0, grade = 1 },
			{ name = 'defib', 			price = 0, grade = 1 },
			{ name = 'sedative', 		price = 0, grade = 3 },
			{ name = 'morphine30', 		price = 0, grade = 4 },
			{ name = 'morphine15', 		price = 0, grade = 3 },
			{ name = 'perc30', 			price = 0, grade = 4 },
			{ name = 'perc10', 			price = 0, grade = 4 },
			{ name = 'perc5', 			price = 0, grade = 3 },
			{ name = 'vic10', 			price = 0, grade = 4 },
			{ name = 'vic5', 			price = 0, grade = 3 },
		}, 
			locations = { 	vector3(-462.037, -977.053, 23.519),
		}, 
			targets = {
		{
			ped = `s_m_m_doctor_01`,
			loc = vector3(-462.037, -977.053, 22.519),
			heading = 0.781,
		}
		}
		},
	
		Cluckinbell = {
			name = 'Cluckin Bell Supplies',
			groups = {
				cluckinbell = 1,
				},
			inventory = {
			{ name = 'cb_frozennuggets', 	price = 50, grade = 1 },
			{ name = 'cb_chickenraw', 		price = 50, grade = 1 },
			{ name = 'cb_frozendrumsticks', price = 50, grade = 1 },
			{ name = 'cb_potatoes', 		price = 50, grade = 1 },
			{ name = 'cb_macncheesesupplies', price = 50, grade = 1 },
			{ name = 'cb_frozenfries', 		price = 50, grade = 1 },
			{ name = 'cb_tomato', 			price = 50, grade = 1 },
			{ name = 'cb_onion', 			price = 50, grade = 1 },
			{ name = 'cb_headlettuce', 		price = 50, grade = 1 },
			{ name = 'cb_cheese', 			price = 50, grade = 1 },
			{ name = 'cb_buns', 			price = 50, grade = 1 },
			{ name = 'cb_mayo', 			price = 50, grade = 1 },
		}, 
			locations = { 	vector3(873.54, -2200.804, 30.519),
		}, 
			targets = {
		{
			ped = `s_m_y_busboy_01`,
			loc = vector3(873.54, -2200.804, 29.509),
			heading = 350.667,
		}
		}
		},

		blackmarket = {
			name = 'Strange Dealer',
			inventory = {
				{ name = 'laptop_pink', price = 5000},
				{ name = 'laptop_gold', price = 5000},	
				{ name = 'c4_bomb', price = 2500},
				{ name = 'hackingdevice', price = 2500},
				{ name = 'gpshackingdevice', price = 2500},
				{ name = 'drill', price = 2500},
				{ name = 'laptop', price = 1000},
				{ name = 'usb_stick', price = 500},
			}, 
		
			locations = {
				vector3(-1078.834, -1678.883, 4.575)
			}, 
				targets = {
			{
				ped = `s_m_y_dealer_01`,
				loc = vector3(-1078.834, -1678.883, 4.575),
				heading = 354.76,
			}
			}
		},

		VendingMachineDrinks = {
			name = 'Vending Machine',
			inventory = {
				{ name = 'pixelwater', price = 35 },
				{ name = 'pixelcola', price = 45 },
			},
			model = {
				`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
			},
		}
	}