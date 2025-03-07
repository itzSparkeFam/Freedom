return {
    ['testburger'] = {
        label = 'Test Burger',
        weight = 220,
        degrade = 60,
        client = {
            image = 'burger_chicken.png',
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            export = 'ox_inventory_examples.testburger'
        },
        server = {
            export = 'ox_inventory_examples.testburger',
            test = 'what an amazingly delicious burger, amirite?'
        },
        buttons = {
            {
                label = 'Lick it',
                action = function(slot)
                    print('You licked the burger')
                end
            },
            {
                label = 'Squeeze it',
                action = function(slot)
                    print('You squeezed the burger :(')
                end
            },
            {
                label = 'What do you call a vegan burger?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('A misteak.')
                end
            },
            {
                label = 'What do frogs like to eat with their hamburgers?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('French flies.')
                end
            },
            {
                label = 'Why were the burger and fries running?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('Because they\'re fast food.')
                end
            }
        },
        consume = 0.3
    },

    ['bandage'] = {
        label = 'Bandage',
        weight = 115,
    },

    ['burger'] = {
        label = 'Burger',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        label = 'Garbage',
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },

    ['panties'] = {
        label = 'Knickers',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
    },

    ['phone'] = {
        label = 'Phone',
        weight = 190,
        stack = false,
        consume = 0,
        client = {
            add = function(total)
                if total > 0 then
                    pcall(function() return exports.npwd:setPhoneDisabled(false) end)
                end
            end,

            remove = function(total)
                if total < 1 then
                    pcall(function() return exports.npwd:setPhoneDisabled(true) end)
                end
            end
        }
    },

    ['mustard'] = {
        label = 'Mustard',
        weight = 500,
        client = {
            status = { hunger = 25000, thirst = 25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
            usetime = 2500,
            notification = 'You... drank mustard'
        }
    },

    ['water'] = {
        label = 'Water',
        weight = 500,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        }
    },

    ['armour'] = {
        label = 'Bulletproof Vest',
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    ['clothing'] = {
        label = 'Clothing',
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
    },

    ['black_money'] = {
        label = 'Dirty Money',
    },

    ['id_card'] = {
        label = 'Identification Card',
    },

    ['driver_license'] = {
        label = 'Drivers License',
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
    },

    ['radio'] = {
        label = 'Radio',
        weight = 1000,
        stack = false,
        allowArmed = true
    },

    ['advancedlockpick'] = {
        label = 'Advanced Lockpick',
        weight = 500,
    },

    ['screwdriverset'] = {
        label = 'Screwdriver Set',
        weight = 500,
    },

    ['electronickit'] = {
        label = 'Electronic Kit',
        weight = 500,
    },

    ['cleaningkit'] = {
        label = 'Cleaning Kit',
        weight = 500,
    },

    ['repairkit'] = {
        label = 'Repair Kit',
        weight = 2500,
    },

    ['advancedrepairkit'] = {
        label = 'Advanced Repair Kit',
        weight = 4000,
    },

    ['diamond_ring'] = {
        label = 'Diamond',
        weight = 1500,
    },

    ['rolex'] = {
        label = 'Golden Watch',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        weight = 1500,
    },

    ['goldchain'] = {
        label = 'Golden Chain',
        weight = 1500,
    },

    ['crack_baggy'] = {
        label = 'Crack Baggy',
        weight = 100,
    },

    ['cokebaggy'] = {
        label = 'Bag of Coke',
        weight = 100,
    },

    ['coke_brick'] = {
        label = 'Coke Brick',
        weight = 2000,
    },

    ['coke_small_brick'] = {
        label = 'Coke Package',
        weight = 1000,
    },

    ['xtcbaggy'] = {
        label = 'Bag of Ecstasy',
        weight = 100,
    },

    ['meth'] = {
        label = 'Methamphetamine',
        weight = 100,
    },

    ['oxy'] = {
        label = 'Oxycodone',
        weight = 100,
    },

    ['weed_ak47'] = {
        label = 'AK47 2g',
        weight = 200,
    },

    ['weed_ak47_seed'] = {
        label = 'AK47 Seed',
        weight = 1,
    },

    ['weed_skunk'] = {
        label = 'Skunk 2g',
        weight = 200,
    },

    ['weed_skunk_seed'] = {
        label = 'Skunk Seed',
        weight = 1,
    },

    ['weed_amnesia'] = {
        label = 'Amnesia 2g',
        weight = 200,
    },

    ['weed_amnesia_seed'] = {
        label = 'Amnesia Seed',
        weight = 1,
    },

    ['weed_og-kush'] = {
        label = 'OGKush 2g',
        weight = 200,
    },

    ['weed_og-kush_seed'] = {
        label = 'OGKush Seed',
        weight = 1,
    },

    ['weed_white-widow'] = {
        label = 'OGKush 2g',
        weight = 200,
    },

    ['weed_white-widow_seed'] = {
        label = 'White Widow Seed',
        weight = 1,
    },

    ['weed_purple-haze'] = {
        label = 'Purple Haze 2g',
        weight = 200,
    },

    ['weed_purple-haze_seed'] = {
        label = 'Purple Haze Seed',
        weight = 1,
    },

    ['weed_brick'] = {
        label = 'Weed Brick',
        weight = 2000,
    },

    ['weed_nutrition'] = {
        label = 'Plant Fertilizer',
        weight = 2000,
    },

    ['joint'] = {
        label = 'Joint',
        weight = 200,
    },

    ['rolling_paper'] = {
        label = 'Rolling Paper',
        weight = 0,
    },

    ['empty_weed_bag'] = {
        label = 'Empty Weed Bag',
        weight = 0,
    },

    ['firstaid'] = {
        label = 'First Aid',
        weight = 2500,
    },

    ['ifaks'] = {
        label = 'Individual First Aid Kit',
        weight = 2500,
    },

    ['painkillers'] = {
        label = 'Painkillers',
        weight = 400,
    },

    ['firework1'] = {
        label = '2Brothers',
        weight = 1000,
    },

    ['firework2'] = {
        label = 'Poppelers',
        weight = 1000,
    },

    ['firework3'] = {
        label = 'WipeOut',
        weight = 1000,
    },

    ['firework4'] = {
        label = 'Weeping Willow',
        weight = 1000,
    },

    ['steel'] = {
        label = 'Steel',
        weight = 100,
    },

    ['rubber'] = {
        label = 'Rubber',
        weight = 100,
    },

    ['metalscrap'] = {
        label = 'Metal Scrap',
        weight = 100,
    },

    ['iron'] = {
        label = 'Iron',
        weight = 100,
    },

    ['copper'] = {
        label = 'Copper',
        weight = 100,
    },

    ['aluminium'] = {
        label = 'Aluminium',
        weight = 100,
    },

    ['plastic'] = {
        label = 'Plastic',
        weight = 100,
    },

    ['glass'] = {
        label = 'Glass',
        weight = 100,
    },

    ['gatecrack'] = {
        label = 'Gatecrack',
        weight = 1000,
    },

    ['cryptostick'] = {
        label = 'Crypto Stick',
        weight = 100,
    },

    ['trojan_usb'] = {
        label = 'Trojan USB',
        weight = 100,
    },

    ['toaster'] = {
        label = 'Toaster',
        weight = 5000,
    },

    ['small_tv'] = {
        label = 'Small TV',
        weight = 100,
    },

    ['security_card_01'] = {
        label = 'Security Card A',
        weight = 100,
    },

    ['security_card_02'] = {
        label = 'Security Card B',
        weight = 100,
    },

    ['drill'] = {
        label = 'Drill',
        weight = 5000,
    },

    ['thermite'] = {
        label = 'Thermite',
        weight = 1000,
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },

    ['antipatharia_coral'] = {
        label = 'Antipatharia',
        weight = 1000,
    },

    ['dendrogyra_coral'] = {
        label = 'Dendrogyra',
        weight = 1000,
    },

    ['jerry_can'] = {
        label = 'Jerrycan',
        weight = 3000,
    },

    ['nitrous'] = {
        label = 'Nitrous',
        weight = 1000,
    },

    ['wine'] = {
        label = 'Wine',
        weight = 500,
    },

    ['grape'] = {
        label = 'Grape',
        weight = 10,
    },

    ['grapejuice'] = {
        label = 'Grape Juice',
        weight = 200,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 200,
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
    },

    ['beer'] = {
        label = 'beer',
        weight = 200,
    },

    ['sandwich'] = {
        label = 'beer',
        weight = 200,
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        weight = 1000,
    },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
    },

    ['stickynote'] = {
        label = 'Sticky Note',
        weight = 0,
    },

    ['empty_evidence_bag'] = {
        label = 'Empty Evidence Bag',
        weight = 200,
    },

    ['filled_evidence_bag'] = {
        label = 'Filled Evidence Bag',
        weight = 200,
    },

    ['harness'] = {
        label = 'Harness',
        weight = 200,
    },

    ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 200,
    },
    ['bandage'] = {
        label = 'Bandage',
        weight = 0,
        description = 'Can be directly used in the inventory, stops bleeding from wounds and increases health',
		stack = true,
    },
    ['ifak'] = {
        label = 'IFAK',
        weight = 200,
        description = 'Can be directly used in the inventory, contains first aid kit',
		stack = true,
		close = true,
    },
    ['painkillers'] = {
        label = 'Painkillers',
        weight = 0,
        description = 'Can be directly used in the inventory to reduce pain and stress',
		stack = true,
		close = true,
    },
    ['temporary_tourniquet'] = {
        label = 'Temporary Tourniquet',
        weight = 10,
        description = 'A temporary tourniquet that can directly be used in the inventory to stop bleeding',
		stack = true,
		close = true,
    },
	['pager'] = {
        label = 'Pager',
        weight = 10,
        description = 'Used to inform medical staff at the hospital of an incoming patient',
		stack = false,
		close = true,
    },
    ['tourniquet'] = {
        label = 'Tourniquet',
        weight = 10,
		stack = true,
    },
    ['field_dressing'] = {
        label = 'Field Dressing',
        weight = 10,
		stack = true,
    },
    ['elastic_bandage'] = {
        label = 'Elastic Bandage',
        weight = 10,
		stack = true,
    },
    ['quick_clot'] = {
        label = 'Quick Clot',
        weight = 10,
		stack = true,
    },
    ['packing_bandage'] = {
        label = 'Packing Bandage',
        weight = 10,
		stack = true,
    },
    ['sewing_kit'] = {
        label = 'Sewing Kit',
        weight = 10,
		stack = true,
    },
    ['epinephrine'] = {
        label = 'Epinephrine',
        weight = 10,
        description = 'Epinephrine, also known as adrenaline, increases the body\'s pulse as well as suppress pain.',
		stack = true,
    },
    ['morphine'] = {
        label = 'Morphine',
        weight = 10,
        description = 'Morphine decreases the body\'s pulse as well as suppress pain.',
		stack = true,
    },
    ['propofol'] = {
        label = 'Propofol',
        weight = 10,
        description = 'Propofol, is a powerful sedation medication.',
		stack = true,
    },
    ['blood250ml'] = {
        label = 'Blood Pack 250ml',
        weight = 10,
		stack = true,
    },
    ['blood500ml'] = {
        label = 'Blood Pack 500ml',
        weight = 10,
		stack = true,
    },
    ['saline250ml'] = {
        label = 'Saline 250ml',
        weight = 10,
		stack = true,
    },
    ['saline500ml'] = {
        label = 'Saline 500ml',
        weight = 10,
		stack = true,
    },
    ['revivekit'] = {
        label = 'Emergency Revive Kit',
        weight = 10,
		stack = true,
    },
    ['stretcher'] = {
        label = 'Stretcher',
        weight = 1000,
        description = 'A medical stretcher to carry wounded patients',
		stack = true,
    },
    ['wheelchair'] = {
        label = 'Wheelchair',
        weight = 1000,
		stack = true,
    },
    ['crutch'] = {
        label = 'Crutch',
        weight = 1000,
		stack = true,
    },
    ['bodybag'] = {
        label = 'Bodybag',
        weight = 1000,
        description = 'A bag to put dead bodies in',
		stack = true,
    },
    ['ecg'] = {
        label = 'ECG',
        weight = 200,
		stack = false,
		close = true,
        description = 'Electrocardiography is an electrophysiological examination method of the heart where the heart\'s electrical activity is recorded by electrodes connected to an ECG device.',
    },
   ['neckbrace'] = {
        label = 'Neck Brace',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['neckcast'] = {
        label = 'Neck Cast',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['legsplint'] = {
        label = 'Leg Splint',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['legcast'] = {
        label = 'Leg Cast',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['armsplint'] = {
        label = 'Arm Splint',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['armcast'] = {
        label = 'Arm Cast',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['propofol'] = {
        label = 'Propofol',
        weight = 1000,
        description = '',
		stack = true,
    },
    ['bill_paper'] = {
        label = 'Bill Paper',
        weight = 0,
        stack = false, -- Unique items should have stack set to false
        close = true,
        description = 'View your invoice',
        client = {
            image = "bill_paper.png"
                -- Add your custom function when the item is used
        }
    },
    ['debitcard_personal'] = {
        label = 'Personal Debit Card',
        stack = false,
        weight = 10,
        consume = 0,
        client = {
            export = "tgg-banking.UseCardOnAtm"
        }
    },
    ['debitcard_shared'] = {
        label = 'Shared Debit Card',
        stack = false,
        weight = 10,
        consume = 0,
        client = {
            export = "tgg-banking.UseCardOnAtm"
        }
    },
    ['debitcard_business'] = {
        label = 'Business Debit Card',
        stack = false,
        weight = 10,
        consume = 0,
        client = {
            export = "tgg-banking.UseCardOnAtm"
        }
    },
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
  },
  	
	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = false, combat = false },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},


	['money'] = {
		label = 'Money',
		description = "Some money?",
		client = {
			image = 'money.png',
		}

	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["noremorse_first_flag"] = {
		label = "No Remorse First Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "No Remorse First Flag",
		client = {
			image = "noremorse_first_flag.png",
		}
	},

	["moneybag"] = {
		label = "Money Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "moneybag.png",
		}
	},

	["houselaptop"] = {
		label = "House Hacking Laptop",
		weight = 1200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "houselaptop.png",
		}
	},

	["gazpacho"] = {
		label = "Guzpacho",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "gazpacho.png",
		}
	},

	["suspension3"] = {
		label = "Tier 3 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension3.png",
		}
	},

	["axleparts"] = {
		label = "Axle Parts",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "axleparts.png",
		}
	},

	["backwoods_honey"] = {
		label = "Backwoods Honey",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "backwoods_honey.png",
		}
	},

	["collarpet"] = {
		label = "Pet collar",
		weight = 500,
		stack = true,
		close = true,
		description = "Rename your pets!",
		client = {
			image = "collarpet.png",
		}
	},

	["strawberry_banana_crepes"] = {
		label = "Strawberry Banana Crepes",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "strawberry_banana_crepes.png",
		}
	},

	["trojan_usb"] = {
		label = "Trojan USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to shut down some systems",
		client = {
			image = "usb_device.png",
		}
	},

	["sapphire_ring"] = {
		label = "Sapphire Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring.png",
		}
	},

	["exhaust"] = {
		label = "Vehicle Exhaust",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "exhaust.png",
		}
	},

	["bucket"] = {
		label = "Bucket",
		weight = 100,
		stack = true,
		close = false,
		description = "A empty bucket!",
		client = {
			image = "bucket.png",
		}
	},

	["cleaningkit"] = {
		label = "Cleaning Kit",
		weight = 250,
		stack = true,
		close = true,
		description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = {
			image = "cleaningkit.png",
		}
	},

	["sapphire_earring_silver"] = {
		label = "Sapphire Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring_silver.png",
		}
	},

	["meth_amoniak"] = {
		label = "Ammonia",
		weight = 1000,
		stack = true,
		close = false,
		description = "Warning! Dangerous Chemicals!",
		client = {
			image = "meth_amoniak.png",
		}
	},

	["pineapple_crate"] = {
		label = "Pineapple Crate",
		weight = 2500,
		stack = true,
		close = false,
		description = "A crate of pineapples ready for selling!",
		client = {
			image = "pineapple_crate.png",
		}
	},

	["crowex_brown"] = {
		label = "Crowex Brown",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crowex_brown.png",
		}
	},

	["sponge_dirty"] = {
		label = "sponge dirty",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sponge_dirty.png",
		}
	},

	["trans2"] = {
		label = "Transmission Lvl. 2",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "trans2.png",
		}
	},

	["georgia_pie_joint"] = {
		label = "Georgia Pie Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "georgia_pie_joint.png",
		}
	},

	["bm_mgocake"] = {
		label = "Mango Cheesecake",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Mango Cream Cheesecake!",
		client = {
			image = "bm_mgocake.png",
		}
	},

	["w_diet_coke"] = {
		label = "Diet Coke",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_diet_coke.png",
		}
	},

	["hundred_wings"] = {
		label = "100 WINGS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "hundred_wings.png",
		}
	},

	["t_tango_orange"] = {
		label = "Tango Orange",
		weight = 500,
		stack = true,
		close = true,
		description = "Drink.",
		client = {
			image = "t_tango_orange.png",
		}
	},

	["cherrydrink"] = {
		label = "Cherry Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Cherries!",
		client = {
			image = "cherrydrink.png",
		}
	},

	["w_tango_orange"] = {
		label = "Tango Orange",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_tango_orange.png",
		}
	},

	["magicmushroom"] = {
		label = "Magic Mushroom",
		weight = 30,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "magicmushroom.png",
		}
	},

	["internals"] = {
		label = "Internal Cosmetics",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "internals.png",
		}
	},

	["eggsbenedict"] = {
		label = "Eggs Benedict",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "eggbene.png",
		}
	},

	["pizzadough"] = {
		label = "Pizza Dough",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "pizzadough.png",
		}
	},

	["blemonslush"] = {
		label = "Lemon Slush",
		weight = 100,
		stack = true,
		close = true,
		description = "Cup Fill With Lemon Slush",
		client = {
			image = "blemonslush.png",
		}
	},

	["ironoxide"] = {
		label = "Iron Powder",
		weight = 0,
		stack = true,
		close = false,
		description = "Some powder to mix with.",
		client = {
			image = "ironoxide.png",
		}
	},

	["weed_package"] = {
		label = "Weed Bag",
		weight = 500,
		stack = true,
		close = false,
		description = "Plastic bag with magic stuff!",
		client = {
			image = "weed_package.png",
		}
	},

	["grape"] = {
		label = "Grape",
		weight = 100,
		stack = true,
		close = false,
		description = "Mmmmh yummie, grapes",
		client = {
			image = "grape.png",
		}
	},

	["keepcompanioncat"] = {
		label = "Cat",
		weight = 500,
		stack = false,
		close = true,
		description = "Cat is your royal companion!",
		client = {
			image = "A_C_Cat_01.png",
		}
	},

	["bites_group_pack"] = {
		label = "THIGH BITES GROUP PACK",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "bites_group_pack.png",
		}
	},

	["uvlight"] = {
		label = "UV Light",
		weight = 25,
		stack = true,
		close = true,
		description = "To scan for fingerprints",
		client = {
			image = "uvlight.png",
		}
	},

	["casino_donut"] = {
		label = "Casino Donut",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Donut",
		client = {
			image = "casino_donut.png",
		}
	},

	["bobcatkeycard"] = {
		label = "Bobcat Security Card",
		weight = 1000,
		stack = true,
		close = true,
		description = "A keycard used at the Bobcat Security Deposit..",
		client = {
			image = "bobcatkeycard.png",
		}
	},

	["turbo"] = {
		label = "Supercharger Turbo",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "turbo.png",
		}
	},

	["rims"] = {
		label = "Custom Wheel Rims",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "rims.png",
		}
	},

	["diving_gear"] = {
		label = "Diving Gear",
		weight = 30000,
		stack = false,
		close = true,
		description = "An oxygen tank and a rebreather",
		client = {
			image = "diving_gear.png",
		}
	},

	["burger_softdrink"] = {
		label = "BurgerShot Coke",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Cola",
		client = {
			status = {
				thirst = 51,
			},
			image = "burger_softdrink.png",
		}
	},

	["bumper"] = {
		label = "Vehicle Bumper",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bumper.png",
		}
	},

	["ruby_earring"] = {
		label = "Ruby Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring.png",
		}
	},

	["comp_attachment"] = {
		label = "Compensator",
		weight = 1000,
		stack = true,
		close = true,
		description = "A compensator for a weapon",
		client = {
			image = "comp_attachment.png",
		}
	},

	["goldbar"] = {
		label = "Gold Bar",
		weight = 200,
		stack = true,
		close = true,
		description = "Looks pretty expensive to me",
		client = {
			image = "goldbar.png",
		}
	},

	["omlet"] = {
		label = "Omlet",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "omlet.png",
		}
	},

	["meat_boar"] = {
		label = "Boar Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Boar meat!",
		client = {
			image = "meat_boar.png",
		}
	},

	["oystershell"] = {
		label = "Oyster Shell",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oyster.png",
		}
	},

	["sandwiches"] = {
		label = "sandwiches",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sandwiches.png",
		}
	},

	["churros_dip"] = {
		label = "Churros Dip",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "churros_dip.png",
		}
	},

	["cheesy_gordita_crunch"] = {
		label = "Cheesy Gordita Crunch",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "cheesy_gordita_crunch.png",
		}
	},

	["gummy_skunk_cbd"] = {
		label = "CBD Skunk Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd skunk gummy bear!",
		client = {
			image = "gummy_skunk_cbd.png",
		}
	},

	["emerald_ring_silver"] = {
		label = "Emerald Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring_silver.png",
		}
	},

	["bahama_bredcrum"] = {
		label = "Breadcrumbs",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_bredcrum.png",
		}
	},

	["poppyplant"] = {
		label = "Poppy Plant",
		weight = 30,
		stack = true,
		close = false,
		description = "Very nice plant!",
		client = {
			image = "poppyplant.png",
		}
	},

	["bobatea"] = {
		label = "Boba Tea",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 47,
			},
			image = "bubbletea.png",
		}
	},

	["bolognese"] = {
		label = "Bolognese",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 30,
			},
			image = "bolognese.png",
		}
	},

	["chocolate"] = {
		label = "Chocolate",
		weight = 200,
		stack = true,
		close = false,
		description = "Chocolate Bar",
		client = {
			status = {
				hunger = 20,
			},
			image = "chocolate.png",
		}
	},

	["chickentaco"] = {
		label = "Chicken Taco",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 21,
			},
			image = "chickentaco.png",
		}
	},

	["seasoned_fries"] = {
		label = "SEASONED FRIES",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "seasoned_fries.png",
		}
	},

	["gmo_cookies_joint"] = {
		label = "GMO cookies Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gmo_cookies_joint.png",
		}
	},

	["bolt_cutter"] = {
		label = "Bolt Cutter",
		weight = 50,
		stack = true,
		close = true,
		description = "Wanna cut some metal items ?",
		client = {
			image = "bolt_cutter.png",
		}
	},

	["atomsoda"] = {
		label = "Atom Soda",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "atomsoda.png",
		}
	},

	["amarone"] = {
		label = "Amarone",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 22,
			},
			image = "amarone.png",
		}
	},

	["mushroom"] = {
		label = "Mushroom",
		weight = 100,
		stack = true,
		close = false,
		description = "Mushroom!",
		client = {
			image = "mushroom.png",
		}
	},

	["livery"] = {
		label = "Livery Roll",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "livery.png",
		}
	},

	["strawberry_nutella_waffles"] = {
		label = "Strawberry Nutella Waffles",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "strawberry_nutella_waffles.png",
		}
	},

	["digicamo_attachment"] = {
		label = "Digital Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A digital camo for a weapon",
		client = {
			image = "digicamo_attachment.png",
		}
	},

	["catcoffee"] = {
		label = "Cat Coffee",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 20,
			},
			image = "catcoffee.png",
		}
	},

	["casino_sandwitch"] = {
		label = "Casino Sandwitch",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Sandwitch",
		client = {
			image = "casino_sandwitch.png",
		}
	},

	["nekodonut"] = {
		label = "Neko Donut",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 45,
			},
			image = "catdonut.png",
		}
	},

	["hennessy_shot"] = {
		label = "Hennessy Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "hennessy_shot.png",
		}
	},

	["screwdriverset"] = {
		label = "Toolkit",
		weight = 1000,
		stack = true,
		close = false,
		description = "Very useful to screw... screws...",
		client = {
			image = "screwdriverset.png",
		}
	},

	["garlic_parmesan_wings"] = {
		label = "Garlic Parmesan Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "garlic_parmesan_wings.png",
		}
	},

	["soft_taco"] = {
		label = "Soft Taco",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "soft_taco.png",
		}
	},

	["sodium_hydroxide"] = {
		label = "Sodium Hydroxide",
		weight = 5,
		stack = true,
		close = false,
		description = "A bottle of sodium hydroxide",
		client = {
			image = "sodium_hydroxide.png",
		}
	},

	["milk"] = {
		label = "Milk",
		weight = 300,
		stack = true,
		close = true,
		description = "Carton of Milk",
		client = {
			status = {
				thirst = 53,
			},
			image = "burger_milk.png",
		}
	},

	["susp1"] = {
		label = "Suspension Lvl. 1",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "susp1.png",
		}
	},

	["bahama_peppers"] = {
		label = "Peppers",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_peppers.png",
		}
	},

	["labkey"] = {
		label = "Key",
		weight = 500,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "labkey.png",
		}
	},

	["khalifa_kush_joint"] = {
		label = "Khalifa Kush Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "khalifa_kush_joint.png",
		}
	},

	["cafe_bong"] = {
		label = "Cafe Bong",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "cafe_bong.png",
		}
	},

	["susp4"] = {
		label = "Suspension Lvl. 4",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "susp4.png",
		}
	},

	["chemicals"] = {
		label = "Chemicals",
		weight = 5,
		stack = true,
		close = false,
		description = "A bottle of mixed chemicals",
		client = {
			image = "chemicals.png",
		}
	},

	["pancake"] = {
		label = "PawCake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 42,
			},
			image = "pawcakes.png",
		}
	},

	["bahama_champagne"] = {
		label = "Champagne",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_champagne.png",
		}
	},

	["chop_trunk"] = {
		label = "Car Trunk",
		weight = 2000,
		stack = true,
		close = true,
		description = "A trunk from a vehicle",
		client = {
			image = "chop_trunk.png",
		}
	},

	["lofexidine"] = {
		label = "Lofexidine",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "lofexidine.png",
		}
	},

	["xenonsdefault"] = {
		label = "White Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsdefault.png",
		}
	},

	["apple_gelato"] = {
		label = "Apple Gelato",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "apple_gelato.png",
		}
	},

	["bm_tequilashot"] = {
		label = "Tequila Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Tequila Shot!",
		client = {
			image = "bm_tequilashot.png",
		}
	},

	["money_shot_burger"] = {
		label = "money shot burger",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "money_shot_burger.png",
		}
	},

	["sanfrancisco"] = {
		label = "San Francisco",
		weight = 30,
		stack = true,
		close = true,
		description = "Alcoholic Drink",
		client = {
			image = "sanfrancisco.png",
		}
	},

	["snow_man"] = {
		label = "Snow Man",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "snow_man.png",
		}
	},

	["hellhounds_first_flag"] = {
		label = "hellhounds First Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "hellhounds First Flag",
		client = {
			image = "hellhounds_first_flag.png",
		}
	},

	["gary_payton"] = {
		label = "Gary Payton",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gary_payton.png",
		}
	},

	["arm4"] = {
		label = "Armor Lvl. 4",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "arm4.png",
		}
	},

	["sapphire_necklace"] = {
		label = "Sapphire Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace.png",
		}
	},

	["goldearring"] = {
		label = "Golden Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_earring.png",
		}
	},

	["meat_chickenhawk"] = {
		label = "Chickenhawk Meat",
		weight = 400,
		stack = true,
		close = true,
		description = "Chickenhawk meat!",
		client = {
			image = "meat_chickenhawk.png",
		}
	},

	["codeine"] = {
		label = "Codeine",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "codeine.png",
		}
	},

	["ironore"] = {
		label = "Iron Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Iron, a base ore.",
		client = {
			image = "ironore.png",
		}
	},

	["bm_rissole"] = {
		label = "Chicken Rissole",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Chicken Ball Rissole!",
		client = {
			image = "bm_rissole.png",
		}
	},

	["murderbag"] = {
		label = "Murder Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "Grab a Murder Bag of Burgers",
		client = {
			image = "burgerbag.png",
		}
	},

	["broken_handcuffs"] = {
		label = "Broken Handcuffs",
		weight = 100,
		stack = true,
		close = true,
		description = "It's broken, maybe you can repair it?",
		client = {
			image = "broken_handcuffs.png",
		}
	},

	["upeel_shrimp"] = {
		label = "U_Peel Shrimp",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "upeel_shrimp.png",
		}
	},

	["keepcompanionmtlion"] = {
		label = "MtLion",
		weight = 500,
		stack = false,
		close = true,
		description = "MtLion is your royal companion!",
		client = {
			image = "A_C_MtLion.png",
		}
	},

	["shamrock_cookie"] = {
		label = "Shamrock Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shamrock_cookie.png",
		}
	},

	["empty_cup"] = {
		label = "empty cup",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "empty_cup.png",
		}
	},

	["khalifa_kush"] = {
		label = "Khalifa Kush",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "khalifa_kush.png",
		}
	},

	["poppy_tears"] = {
		label = "Poppy Tears",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "poppy_tears.png",
		}
	},

	["tahoe_og"] = {
		label = "Tahoe OG",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "tahoe_og.png",
		}
	},

	["destroyed_cup"] = {
		label = "destroyed cup",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "destroyed_cup.png",
		}
	},

	["meat_coyote"] = {
		label = "Coyote Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Coyote meat!",
		client = {
			image = "meat_coyote.png",
		}
	},

	["ps_coca_cola"] = {
		label = "Coca Cola",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ps_coca_cola.png",
		}
	},

	["paintingg"] = {
		label = "Vintage Painting",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "",
		}
	},

	["bahama_whiskey"] = {
		label = "Whiskey",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_whiskey.png",
		}
	},

	["butter_cookie"] = {
		label = "Butter Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "butter_cookie.png",
		}
	},

	["garlic_parm_wings"] = {
		label = "Garlic Parm Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "garlic_parm_wings.png",
		}
	},

	["bahama_ojuice"] = {
		label = "Orange Juice",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_ojuice.png",
		}
	},

	["cactusfruit"] = {
		label = "Cactus Fruit",
		weight = 100,
		stack = true,
		close = false,
		description = "Cactus Fruit!",
		client = {
			image = "cactusfruit.png",
		}
	},

	["lemon_crate"] = {
		label = "Lemon Crate",
		weight = 3500,
		stack = true,
		close = false,
		description = "A crate of lemons ready for selling!",
		client = {
			image = "lemon_crate.png",
		}
	},

	["art3"] = {
		label = "Fancy Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art3.png",
		}
	},

	["rag_dirty"] = {
		label = "rag dirty",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "rag_dirty.png",
		}
	},

	["emerald_necklace_silver"] = {
		label = "Emerald Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace_silver.png",
		}
	},

	["lsd3"] = {
		label = "LSD",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "lsd3.png",
		}
	},

	["fried_egg"] = {
		label = "fried_egg",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fried_egg.png",
		}
	},

	["meth_sacid"] = {
		label = "Sodium Benzoate Canister",
		weight = 1000,
		stack = true,
		close = false,
		description = "Warning! Dangerous Chemicals!",
		client = {
			image = "meth_sacid.png",
		}
	},

	["diamond_earring"] = {
		label = "Diamond Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring.png",
		}
	},

	["vape"] = {
		label = "Vape",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "vape.png",
		}
	},

	["art1"] = {
		label = "Kitty Sleeping Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art1.png",
		}
	},

	["chickenfillet"] = {
		label = "Chicken Fillets",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "chickenbreasts.png",
		}
	},

	["xenonsrose2"] = {
		label = "Hot Pink Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsrose2.png",
		}
	},

	["armor"] = {
		label = "Armor",
		weight = 2000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500,
		}
	},

	["xenonsjaune"] = {
		label = "Yellow Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsjaune.png",
		}
	},

	["double_cup"] = {
		label = "Double Cup",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "double_cup.png",
		}
	},

	["casino_sprite"] = {
		label = "Casino Sprite",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Sprite",
		client = {
			image = "casino_sprite.png",
		}
	},

	["boba"] = {
		label = "Boba",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 43,
			},
			image = "boba.png",
		}
	},

	["watch_material"] = {
		label = "Watch Material",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "watch_material.png",
		}
	},

	["leopardcamo_attachment"] = {
		label = "Leopard Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A leopard camo for a weapon",
		client = {
			image = "leopardcamo_attachment.png",
		}
	},

	["fried_calamari"] = {
		label = "Fried Calamari",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fried_calamari.png",
		}
	},

	["copper"] = {
		label = "Copper",
		weight = 0,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "copper.png",
		}
	},

	["steel"] = {
		label = "Steel",
		weight = 0,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "steel.png",
		}
	},

	["brakes1"] = {
		label = "Tier 1 Brakes",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "brakes1.png",
		}
	},

	["capricciosa"] = {
		label = "Capriccosa",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "capricciosa.png",
		}
	},

	["legbrace"] = {
		label = "Legbrace",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "legbrace.png",
		}
	},

	["cheesewrap"] = {
		label = "BS Cheese Wrap",
		weight = 150,
		stack = true,
		close = true,
		description = "BurgerShot Cheese Wrap",
		client = {
			status = {
				hunger = 46,
			},
			image = "burger_chickenwrap.png",
		}
	},

	["ecstasy2"] = {
		label = "Ectasy",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "ecstasy2.png",
		}
	},

	["firework3"] = {
		label = "WipeOut",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework3.png",
		}
	},

	["juice_mix"] = {
		label = "Juice Mix",
		weight = 500,
		stack = true,
		close = true,
		description = "Fresh Fruit Juice",
		client = {
			image = "juice_mix.png",
		}
	},

	["quesadilla"] = {
		label = "Quesadilla",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "quesadilla.png",
		}
	},

	["whiskey_bottle"] = {
		label = "Whiskey Bottle",
		weight = 500,
		stack = true,
		close = true,
		description = "A fine bottle of whiskey",
		client = {
			image = "whiskey_bottle.png",
		}
	},

	-- STradio Items
	["radio"] = {
		label = "Radio",
		weight = 1000,
		stack = false,
		close = true,
		consume = 0,
		server = {
			export = 'stRadio.use_radio',
			image = 'radio.png',
		},
	},
	
	["radio_server"] = {
		label = "Radio Server",
		weight = 1000,
		stack = false,
		close = true,
		consume = 0,
		server = {
			export = 'stRadio.use_radioserver',
		},
	},
	
	["hack_chip"] = {
		label = "Hack chip",
		weight = 1000,
		stack = false,
		close = true,
		consume = 0,
		server = {
			export = 'stRadio.use_hackchip',
		},
	},
	
	["radio_jammer"] = {
		label = "Radio Jammer",
		weight = 1000,
		stack = false,
		close = true,
		consume = 0,
		server = {
			export = 'stRadio.use_radiojammer',
		},
	},
	
	["radio_powerbank"] = {
		label = "Portable battery",
		weight = 1000,
		stack = false,
		close = true,
		consume = 0,
		server = {
			export = 'stRadio.use_portbat',
		},
	},
	
	["radio_red"] = {
		label = "Color frame red",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_blue"] = {
		label = "Color frame blue",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_purple"] = {
		label = "Color frame purple",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_pink"] = {
		label = "Color frame pink",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_lightblue"] = {
		label = "Color frame lightblue",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_orange"] = {
		label = "Color frame orange",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_yellow"] = {
		label = "Color frame yellow",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_green"] = {
		label = "Color frame green",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_white"] = {
		label = "Color frame white",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["radio_grey"] = {
		label = "Color frame grey",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["bat_low"] = {
		label = "Cheap battery",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["bat_medium"] = {
		label = "Common battery",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["bat_high"] = {
		label = "Premium battery",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["chip_5g"] = {
		label = "5G Chip",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["chip_ghost"] = {
		label = "Ghost Chip",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	["chip_antihack"] = {
		label = "Antihack Chip",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["mic_walkie"] = {
		label = "Talkie Shoulder Microphone",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["radio_monitor"] = {
		label = "Hospital monitor",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["radio_server_bat"] = {
		label = "Car battery",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["radio_cables"] = {
		label = "Radio Jammer",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["radio_tool"] = {
		label = "Radio tools",
		weight = 1000,
		stack = false,
		close = true,
		consume = 0,
		server = {
			export = 'stRadio.use_repairRadio',
		},
	},
	
	["radio_broken"] = {
		label = "Broken radio",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},
	
	["chip_waterproof"] = {
		label = "Waterproof radio",
		weight = 1000,
		stack = false,
		close = false,
		consume = 0,
	},


	-- Licenses and Badges
    ['weapon'] = {
		label = 'Firearm License',
		description = 'Firearms License',
		weight = 50,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'weapon.png',
		}
	},

	['weapon2'] = {
		label = 'Firearm License C2',
		description = 'Class 2 Firearms License',
		weight = 50,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'weapon.png',
		}
	},

	['weapon3'] = {
		label = 'Firearm License C3',
		description = 'Class 3 Firearms License',
		weight = 50,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'weapon.png',
		}
	},

	['business'] = {
		label = 'Drivers License',
		description = 'Drivers License',
		weight = 50,
		stack = false,
		close = true,
        description = 'A license to show you lawfully own and operate your business.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'business.png',
		}
	},

	['paramedic'] = {
		label = 'Paramedic License',
		description = 'Paramedic License',
		weight = 50,
		stack = false,
		close = true,
        description = 'A license to show you lawfully own and operate your business.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'paramedic.png',
		}
	},

	['hunting'] = {
		label = 'Hunting License',
		description = 'A license showing that you are lawfully allowed to hunt.',
		weight = 50,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'hunting.png',
		}
	},
 
	['driver'] = {
		label = 'Drivers License',
		description = 'Drivers License',
		weight = 50,
		stack = false,
		close = true,
        description = 'A drivers license to lawfully operate a motor vehicle and prove your identity.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'driver.png',
		}
	},
 
	['boating'] = {
		label = 'Boating License',
		weight = 50,
		stack = false,
		close = true,
		description = 'A boating license to lawfully operate a watercraft.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'boating.png',
		}
	},
 
	['pilot'] = {
		label = 'Pilot License',
		weight = 50,
		stack = false,
		close = true,
		description = 'A pilots license to lawfully operate an aircraft.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'pilot.png',
		}
	},

    ['boatingpermit'] = {
		label = 'Student Boating Permit',
		weight = 50,
		stack = false,
		close = true,
		description = 'A certificate showing you are allowed to operate a watercraft with a licensed person.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'boatingpermit.png',
		}
	},

    ['pilotpermit'] = {
		label = 'Student Pilot Permit',
		weight = 50,
		stack = false,
		close = true,
		description = 'A student pilot certificate showing you are allowed to operate an aircraft with a licensed person.',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'pilotpermit.png',
		}
	},

    ['identification'] = {
		label = 'Identification',
		weight = 50,
		stack = false,
		close = true,
		description = 'Kartu Ijin Mengemudi',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showCard',
			image = 'identification.png',
		}
	},

	-- BADGES

	['lspd_badge'] = {
		label = 'LSPD Badge',
		weight = 50,
		stack = false,
		close = true,
		description = 'LSPD Badge',
		consume = 0,
		client = {
			export = 'bcs_licensemanager.showBadge',
			image = 'lspd_badge.png',
		}
	},
	

	-- MISC
	["mozzarella_sticks"] = {
		label = "Mozzarella Sticks",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "mozzarella_sticks.png",
		}
	},

	["bahama_beef"] = {
		label = "Beef",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_beef.png",
		}
	},

	["salami"] = {
		label = "Salami",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "salami.png",
		}
	},

	["mansionlaptop"] = {
		label = "Mansion Hacking Laptop",
		weight = 1100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mansionlaptop.png",
		}
	},

	["gelato"] = {
		label = "Choc and Vanilla Gelato",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "gelato.png",
		}
	},

	["skin_cow"] = {
		label = "Cow Hide",
		weight = 1250,
		stack = true,
		close = true,
		description = "Cow hide.",
		client = {
			image = "skin_cow.png",
		}
	},

	["tropical_chicken_salad"] = {
		label = "Tropical Chicken Salad",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "tropical_chicken_salad.png",
		}
	},

	["bcaramelsyrup"] = {
		label = "Caramel Syrup",
		weight = 100,
		stack = true,
		close = true,
		description = "Caramel Syrup",
		client = {
			image = "bcaramelsyrup.png",
		}
	},

	["bacon_burger"] = {
		label = "Bacon Burger",
		weight = 334,
		stack = true,
		close = true,
		description = "A burger with the perfect combination of a juicy patty and the smoky goodness of bacon.",
		client = {
			image = "bacon_burger.png",
		}
	},

	["artificial_bait"] = {
		label = "Artificial bait",
		weight = 30,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "artificial_bait.png",
		}
	},

	["tuna"] = {
		label = "Tuna",
		weight = 10000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tuna.png",
		}
	},

	["margherita"] = {
		label = "Margherita",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "margherita.png",
		}
	},

	["ambeer"] = {
		label = "AM Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 40,
			},
			image = "ambeer.png",
		}
	},

	["oilp3"] = {
		label = "Tier 3 Oil Pump",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "oilp3.png",
		}
	},

	["goldak_earrings"] = {
		label = "GoldAK Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "goldak_earrings.png",
		}
	},

	["pink_sandy"] = {
		label = "Pink Sandy",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pink_sandy.png",
		}
	},

	["goldingot"] = {
		label = "Gold Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldingot.png",
		}
	},

	["burger_moneyshot"] = {
		label = "Money Shot",
		weight = 200,
		stack = true,
		close = true,
		description = "Money Shot",
		client = {
			status = {
				hunger = 48,
			},
			image = "burger_moneyshot.png",
		}
	},

	["prosciuttio"] = {
		label = "Prosciuttio E Funghi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "proscuttio.png",
		}
	},

	["usb_blue"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A blue USB flash drive",
		client = {
			image = "usb_blue.png",
		}
	},

	["slanted_muzzle_brake"] = {
		label = "Slanted Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "slanted_muzzle_brake.png",
		}
	},

	["applecocktail"] = {
		label = "Apple Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Rumor has it that Issac Newton made this.",
		client = {
			image = "applecocktail.png",
		}
	},

	["gary_payton_joint"] = {
		label = "Gary Payton Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gary_payton_joint.png",
		}
	},

	["diavola"] = {
		label = "Diavola",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "diavola.png",
		}
	},

	["skin_boar"] = {
		label = "Boar Hide",
		weight = 1250,
		stack = true,
		close = true,
		description = "Boar hide.",
		client = {
			image = "skin_boar.png",
		}
	},

	["ifaks"] = {
		label = "ifaks",
		weight = 200,
		stack = true,
		close = true,
		description = "ifaks for healing and a complete stress remover.",
		client = {
			image = "ifaks.png",
		}
	},

	["bm_bluelagoon"] = {
		label = "Blue Lagoon",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Blue Lagoon Cocktail!",
		client = {
			image = "bm_bluelagoon.png",
		}
	},

	["limeysdonut2"] = {
		label = "Chocolate Donut",
		weight = 200,
		stack = true,
		close = true,
		description = "Chocolate Donut!",
		client = {
			image = "limeysdonut2.png",
		}
	},

	["casino_coffee"] = {
		label = "Casino Coffee",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Coffee",
		client = {
			image = "casino_coffee.png",
		}
	},

	["lemondrink"] = {
		label = "Lemon Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Rip_off Lemonade",
		client = {
			image = "lemondrink.png",
		}
	},

	["morphine30"] = {
		label = "Morphine 30mg",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "morphine30.png",
		}
	},

	["radiocell"] = {
		label = "AAA Cells",
		weight = 500,
		stack = true,
		close = true,
		description = "Batteries to powerup radio device",
		client = {
			image = "radiocell.png",
		}
	},

	["latte"] = {
		label = "Latte",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "latte.png",
		}
	},

	["drug_grinder"] = {
		label = "Tobacco Grinder",
		weight = 100,
		stack = true,
		close = true,
		description = "A tobacco grinder or something more..",
		client = {
			image = "drug_grinder.png",
		}
	},

	["perseuscamo_attachment"] = {
		label = "Perseus Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A perseus camo for a weapon",
		client = {
			image = "perseuscamo_attachment.png",
		}
	},

	["crunchy_taco_supreme"] = {
		label = "Crunchy Taco Supreme",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "crunchy_taco_supreme.png",
		}
	},

	["mint"] = {
		label = "Matcha",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "matcha.png",
		}
	},

	["diamond_ring"] = {
		label = "Diamond Ring",
		weight = 1500,
		stack = true,
		close = true,
		description = "A diamond ring seems like the jackpot to me!",
		client = {
			image = "diamond_ring.png",
		}
	},

	["woodcamo_attachment"] = {
		label = "Woodland Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A woodland camo for a weapon",
		client = {
			image = "woodcamo_attachment.png",
		}
	},

	["bm_seabreezeshot"] = {
		label = "SeaBreeze Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Sea Breeze Shot!",
		client = {
			image = "bm_seabreezeshot.png",
		}
	},

	["heroin_brick"] = {
		label = "Heroinbrick",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "heroin_brick.png",
		}
	},

	["french_fries"] = {
		label = "French Fries",
		weight = 285,
		stack = true,
		close = true,
		description = "🍟✨ Crispy on the outside, fluffy on the inside. These french fries are a classic and irresistible side. 🌟🍴",
		client = {
			image = "french_fries.png",
		}
	},

	["pumpkin_cookie"] = {
		label = "Pumpkin Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pumpkin_cookie.png",
		}
	},

	["w_medium_fanta_strawberry"] = {
		label = "Medium Fanta Strawberry",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_medium_fanta_strawberry.png",
		}
	},

	["vodka_mash"] = {
		label = "Vodka Mash",
		weight = 5000,
		stack = true,
		close = false,
		description = "A bucket of vodka mash!",
		client = {
			image = "vodka_mash.png",
		}
	},

	["art6"] = {
		label = "Merp Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art6.png",
		}
	},

	["soft_taco_supreme"] = {
		label = "Soft Taco Supreme",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "soft_taco_supreme.png",
		}
	},

	["icecream"] = {
		label = "Ice Cream",
		weight = 500,
		stack = true,
		close = false,
		description = "Ice Cream.",
		client = {
			image = "burger_icecream.png",
		}
	},

	["noremorse_flag"] = {
		label = "No Remorse Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "No Remorse Flag",
		client = {
			image = "noremorse_flag.png",
		}
	},

	["sheriff_bulletproof"] = {
		label = "Sheriff Bulletproof",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sheriff_bulletproof.png",
		}
	},

	["rawhoney"] = {
		label = "Raw Honey",
		weight = 100,
		stack = true,
		close = true,
		description = "A jar of rawhoney, good for making sweets!",
		client = {
			image = "rawhoney.png",
		}
	},

	["c4_bomb"] = {
		label = "C4 Brick",
		weight = 1000,
		stack = false,
		close = true,
		description = "Very Dangerous! High Yield Explosive.",
		client = {
			image = "c4_bomb.png",
		}
	},

	["bpepper"] = {
		label = "DR.Pepper",
		weight = 100,
		stack = true,
		close = true,
		description = "Cup Fill With DR.Pepper",
		client = {
			image = "bpepper.png",
		}
	},

	["bakingsoda"] = {
		label = "Baking Soda",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "bakingsoda.png",
		}
	},

	["meth_glass"] = {
		label = "Tray with meth",
		weight = 1000,
		stack = true,
		close = false,
		description = "Needs to be smashed with hammer",
		client = {
			image = "meth_glass.png",
		}
	},

	["cheetah_piss"] = {
		label = "Cheetah Piss",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cheetah_piss.png",
		}
	},

	["skin_rabbit"] = {
		label = "Rabbit Hide",
		weight = 550,
		stack = true,
		close = true,
		description = "Rabbit hide.",
		client = {
			image = "skin_rabbit.png",
		}
	},

	["paradisecocktail"] = {
		label = "Paradise Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Living in paradise!",
		client = {
			image = "paradisecocktail.png",
		}
	},

	["watermelondrink"] = {
		label = "Watermelon Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Watermelon Drink.",
		client = {
			image = "watermelondrink.png",
		}
	},

	["burger_meatfree"] = {
		label = "Meat Free Burger",
		weight = 200,
		stack = true,
		close = true,
		description = "Meat Free",
		client = {
			status = {
				hunger = 48,
			},
			image = "burger_meatfree.png",
		}
	},

	["acamprosate"] = {
		label = "Acamprosate",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "acamprosate.png",
		}
	},

	["logger"] = {
		label = "Logger Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 49,
			},
			image = "logger.png",
		}
	},

	["yeast"] = {
		label = "Yeast",
		weight = 100,
		stack = true,
		close = false,
		description = "A packet of yeast!",
		client = {
			image = "yeast.png",
		}
	},

	["keepcompanionhen"] = {
		label = "Hen",
		weight = 500,
		stack = false,
		close = true,
		description = "Hen is your royal companion!",
		client = {
			image = "A_C_Hen.png",
		}
	},

	["ecstasy4"] = {
		label = "Ectasy",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "ecstasy4.png",
		}
	},

	["borangeslush"] = {
		label = "Orange Slush",
		weight = 100,
		stack = true,
		close = true,
		description = "Cup Fill With Orange Slush",
		client = {
			image = "borangeslush.png",
		}
	},

	["blueberry_cruffin_joint"] = {
		label = "Blueberry Cruffin Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blueberry_cruffin_joint.png",
		}
	},

	["cheap_lighter"] = {
		label = "Cheap Lighter",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "cheap_lighter.png",
		}
	},

	["witches_brew"] = {
		label = "Witches Brew",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Beverage",
		client = {
			image = "witches_brew.png",
		}
	},

	["bahama_cranjuice"] = {
		label = "Cranberry Juice",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_cranjuice.png",
		}
	},

	["white_runtz"] = {
		label = "White Runtz",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "white_runtz.png",
		}
	},

	["grilledchicken"] = {
		label = "Chicken Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "chickensandwich.png",
		}
	},

	["goldstone_earrings"] = {
		label = "Goldstone Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "goldstone_earrings.png",
		}
	},

	["cam_hacking"] = {
		label = "Camera Hack",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cam_hacking.png",
		}
	},

	["oreoz_joint"] = {
		label = "Oreoz Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "oreoz_joint.png",
		}
	},

	["meth_pooch"] = {
		label = "Meth Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "meth_pooch.png",
		}
	},

	["fine_china_joint"] = {
		label = "Fine China Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fine_china_joint.png",
		}
	},

	["fine_china"] = {
		label = "Fine China",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fine_china.png",
		}
	},

	["goldchain"] = {
		label = "Golden Chain",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden chain seems like the jackpot to me!",
		client = {
			image = "goldchain.png",
		}
	},

	["limedrink"] = {
		label = "Lime Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "Limes...",
		client = {
			image = "limedrink.png",
		}
	},

	["cylind1"] = {
		label = "Tier 1 Cylinder Head",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cylind1.png",
		}
	},

	["gummy_ak47_cbd"] = {
		label = "CBD AK47 Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd ak47 gummy bear!",
		client = {
			image = "gummy_ak47_cbd.png",
		}
	},

	["crisps"] = {
		label = "Crisps",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 24,
			},
			image = "chips.png",
		}
	},

	["fueltank1"] = {
		label = "Tier 1 Fuel Tank",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "fueltank1.png",
		}
	},

	["keepcompanionmtlion2"] = {
		label = "Panter",
		weight = 500,
		stack = false,
		close = true,
		description = "Panter is your royal companion!",
		client = {
			image = "A_C_MtLion.png",
		}
	},

	["rolling_paper"] = {
		label = "Rolling Paper",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "rolling_paper.png",
		}
	},

	["perc"] = {
		label = "Perc",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "perc.png",
		}
	},

	["cylind3"] = {
		label = "Tier 3 Cylinder Head",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cylind3.png",
		}
	},

	["laptop_gold"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Trinity",
		client = {
			image = "laptop_gold.png",
		}
	},

	["drink_glass"] = {
		label = "Glass",
		weight = 1000,
		stack = true,
		close = true,
		description = "Glass made for normal drinks",
		client = {
			image = "drink_glass.png",
		}
	},

	["shrimp_and_grits"] = {
		label = "Shrimp & Grits",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shrimp_and_grits.png",
		}
	},

	["ice_cream_cake_pack"] = {
		label = "Ice Cream Cake Pack",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ice_cream_cake_pack.png",
		}
	},

	["marinarabox"] = {
		label = "Boxed Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["drifttires"] = {
		label = "Drift Tires",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "drifttires.png",
		}
	},

	["handcuffs"] = {
		label = "Handcuffs",
		weight = 100,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "handcuffs.png",
		}
	},

	["bm_corona"] = {
		label = "Corona Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Draft Corona!",
		client = {
			image = "bm_corona.png",
		}
	},

	["heroin_syringe"] = {
		label = "Syringe",
		weight = 320,
		stack = true,
		close = false,
		description = "Enjoy your new crystal clear stuff!",
		client = {
			image = "heroin_syringe.png",
		}
	},

	["beer"] = {
		label = "Beer",
		weight = 500,
		stack = true,
		close = true,
		description = "Nothing like a good cold beer!",
		client = {
			image = "beer.png",
		}
	},

	["xenonsmenthe"] = {
		label = "Mint Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsmenthe.png",
		}
	},

	["gin_bottle"] = {
		label = "Gin Bottle",
		weight = 500,
		stack = true,
		close = true,
		description = "A fine bottle of gin",
		client = {
			image = "gin_bottle.png",
		}
	},

	["suppressor_attachment"] = {
		label = "Suppressor",
		weight = 1000,
		stack = true,
		close = true,
		description = "A suppressor for a weapon",
		client = {
			image = "suppressor_attachment.png",
		}
	},

	["brakes2"] = {
		label = "Tier 2 Brakes",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "brakes2.png",
		}
	},

	["burger_heartstopper"] = {
		label = "HeartStopper",
		weight = 200,
		stack = true,
		close = true,
		description = "Heartstopper",
		client = {
			status = {
				hunger = 57,
			},
			image = "burger_heartstopper.png",
		}
	},

	["miso"] = {
		label = "Miso Soup",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 44,
			},
			image = "miso.png",
		}
	},

	["junkdrink"] = {
		label = "Junk",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 27,
			},
			image = "junkdrink.png",
		}
	},

	["magic_mushroom"] = {
		label = "Magic Mushroom",
		weight = 20,
		stack = true,
		close = false,
		description = "A handful of magic mushrooms!",
		client = {
			image = "magic_mushroom.png",
		}
	},

	["lsd"] = {
		label = "lsd",
		weight = 3,
		stack = true,
		close = false,
		description = "ready for a trip?",
		client = {
			image = "lsd.png",
		}
	},

	["beef"] = {
		label = "Beef",
		weight = 286,
		stack = true,
		close = true,
		description = "🥩✨ Premium quality beef, rich in flavor and perfect for grilling or cooking. 🌟🍖",
		client = {
			image = "beef.png",
		}
	},

	["chickenhornburger"] = {
		label = "Chicken HornBurger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "chickenburger.png",
		}
	},

	["contract"] = {
		label = "Contract",
		weight = 1,
		stack = false,
		close = true,
		description = "A contract",
		client = {
			image = "contract.png",
		}
	},

	["coke_box"] = {
		label = "Box with Coke",
		weight = 2000,
		stack = true,
		close = false,
		description = "Be careful not to spill it on the ground",
		client = {
			image = "coke_box.png",
		}
	},

	["bicedcaffelatte"] = {
		label = "Iced Caffe Latte",
		weight = 100,
		stack = true,
		close = true,
		description = "Iced Caffe Latte",
		client = {
			image = "bicedcaffelatte.png",
		}
	},

	["salad"] = {
		label = "Salad",
		weight = 357,
		stack = true,
		close = true,
		description = "🥗✨ A vibrant mix of fresh greens, vegetables, and dressing. A healthy and delicious choice. 🌟🍽️",
		client = {
			image = "salad.png",
		}
	},

	["bigfruit"] = {
		label = "The Big Fruit",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "bigfruit.png",
		}
	},

	["potato_seed"] = {
		label = "Potato Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of seed potatoes!",
		client = {
			image = "potato_seed.png",
		}
	},

	["rectdia_earrings"] = {
		label = "RectDia Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "rectdia_earrings.png",
		}
	},

	["cylind2"] = {
		label = "Tier 2 Cylinder Head",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cylind2.png",
		}
	},

	["chain_ls"] = {
		label = "Chain LS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_ls.png",
		}
	},

	["baconroll"] = {
		label = "Bacon Roll",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "baconroll.png",
		}
	},

	["flashlight_attachment"] = {
		label = "Flashlight",
		weight = 1000,
		stack = true,
		close = true,
		description = "A flashlight for a weapon",
		client = {
			image = "flashlight_attachment.png",
		}
	},

	["casino_beer"] = {
		label = "Casino Beer",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Beer",
		client = {
			image = "casino_beer.png",
		}
	},

	["xenonsbleuelect"] = {
		label = "Electric Blue Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsbleuelect.png",
		}
	},

	["vodka_tonic"] = {
		label = "Vodka Tonic",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "vodka_tonic.png",
		}
	},

	["acid_paper"] = {
		label = "Acid Paper",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "acid_paper.png",
		}
	},

	["w_medium_fanta_orange"] = {
		label = "Ice Cola",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_medium_fanta_orange.png",
		}
	},

	["white_stone"] = {
		label = "White Stone",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "white_stone.png",
		}
	},

	["bstrawberry"] = {
		label = "Strawberry",
		weight = 100,
		stack = true,
		close = true,
		description = "Strawberry",
		client = {
			image = "bstrawberry.png",
		}
	},

	["thirty_crispy_tenders"] = {
		label = "30 CRISPY TENDERS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "thirty_crispy_tenders.png",
		}
	},

	["glazed_salmon"] = {
		label = "Glazed Salmon",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "glazed_salmon.png",
		}
	},

	["hunksohen"] = {
		label = "Hunk o' Hen",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "chickenthighs.png",
		}
	},

	["apple"] = {
		label = "Apple",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "apple.png",
		}
	},

	["mdmonitor"] = {
		label = "Monitor",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mansionlaptop.png",
		}
	},

	["goldhex_earrings"] = {
		label = "GoldHex Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "goldhex_earrings.png",
		}
	},

	["rice"] = {
		label = "Bowl of Rice",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 43,
			},
			image = "rice.png",
		}
	},

	["casino_chips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = false,
		description = "Casino Chips",
		client = {
			image = "casino_chips.png",
		}
	},

	["meatball"] = {
		label = "Homemade Meatballs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "meatball.png",
		}
	},

	["atom_delivery_package"] = {
		label = "Atom Delivery Package",
		weight = 100,
		stack = true,
		close = true,
		description = "📦✨ A package containing a variety of good munch. 🌟🍽️",
		client = {
			image = "atom_delivery_package.png",
		}
	},

	["pearls_coffee"] = {
		label = "Pearls Coffee",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pearls_coffee.png",
		}
	},

	["bespressomacchiato"] = {
		label = "Espresso Macchiato",
		weight = 100,
		stack = true,
		close = true,
		description = "Espresso Macchiato",
		client = {
			image = "bespressomacchiato.png",
		}
	},

	["antilag"] = {
		label = "AntiLag",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "antiLag.png",
		}
	},

	["luxuryfinish_attachment"] = {
		label = "Luxury Finish",
		weight = 1000,
		stack = true,
		close = true,
		description = "A luxury finish for a weapon",
		client = {
			image = "luxuryfinish_attachment.png",
		}
	},

	["plate"] = {
		label = "Plate",
		weight = 50,
		stack = false,
		close = true,
		description = "A plate.",
		client = {
			image = "plate.png",
		}
	},

	["flakka_joint"] = {
		label = "Flakka Joint",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "flakka_joint.png",
		}
	},

	["bice"] = {
		label = "Ice",
		weight = 100,
		stack = true,
		close = true,
		description = "Ice",
		client = {
			image = "bice.png",
		}
	},

	["water_bottle"] = {
		label = "Bottle of Water",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "water_bottle.png",
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `ba_prop_club_water_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
		}
	},

	["drum_attachment"] = {
		label = "Drum",
		weight = 1000,
		stack = true,
		close = true,
		description = "A drum for a weapon",
		client = {
			image = "drum_attachment.png",
		}
	},

	["bcaramelfrappucino"] = {
		label = "Caramel Frappucino",
		weight = 100,
		stack = true,
		close = true,
		description = "Caramel Frappucino",
		client = {
			image = "bcaramelfrappucino.png",
		}
	},

	["skin_rat"] = {
		label = "Rat Hide",
		weight = 150,
		stack = true,
		close = true,
		description = "Rat hide.",
		client = {
			image = "skin_rat.png",
		}
	},

	["meat_cow"] = {
		label = "Beef Meat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Cow meat!",
		client = {
			image = "meat_cow.png",
		}
	},

	["bahama_mug"] = {
		label = "Empty Mug",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_mug.png",
		}
	},

	["chop_door"] = {
		label = "Car Door",
		weight = 2000,
		stack = true,
		close = true,
		description = "A door from a vehicle",
		client = {
			image = "chop_door.png",
		}
	},

	["skin_shark"] = {
		label = "Shark Skin",
		weight = 1750,
		stack = true,
		close = true,
		description = "Shark skin. Highly illegal!",
		client = {
			image = "skin_shark.png",
		}
	},

	["cookie_craze"] = {
		label = "Cookie Craze",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cookie_craze.png",
		}
	},

	["baking_soda"] = {
		label = "Baking Soda",
		weight = 30,
		stack = true,
		close = false,
		description = "Baking Bad!",
		client = {
			image = "baking_soda.png",
		}
	},

	["largescope_attachment"] = {
		label = "Large Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A large scope for a weapon",
		client = {
			image = "largescope_attachment.png",
		}
	},

	["dirty_cup"] = {
		label = "dirty cup",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "dirty_cup.png",
		}
	},

	["cakepop"] = {
		label = "Cat Cake_Pop",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 41,
			},
			image = "cakepop.png",
		}
	},

	["casino_luckypotion"] = {
		label = "Casino Lucky Potion",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Lucky Potion",
		client = {
			image = "casino_luckypotion.png",
		}
	},

	["meth_raw"] = {
		label = "Meth Raw",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "meth_raw.png",
		}
	},

	["cables1"] = {
		label = "Tier 1 Battery Cables",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cables1.png",
		}
	},

	["marinara"] = {
		label = "Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 24,
			},
			image = "marinara.png",
		}
	},

	["watertank"] = {
		label = "Water Tank",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "watertank.png",
		}
	},

	["xanax_box"] = {
		label = "Xanax Box",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "xanax_box.png",
		}
	},

	["t_seven_up"] = {
		label = "Seven Up",
		weight = 500,
		stack = true,
		close = true,
		description = "Drink.",
		client = {
			image = "t_seven_up.png",
		}
	},

	["poppy"] = {
		label = "poppy",
		weight = 2,
		stack = true,
		close = false,
		description = "A poppy plant",
		client = {
			image = "poppy.png",
		}
	},

	["maize_seed"] = {
		label = "Maize Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of maize seeds!",
		client = {
			image = "maize_seed.png",
		}
	},

	["bm_whiskeyshot"] = {
		label = "Whiskey Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Whiskey Shot!",
		client = {
			image = "bm_whiskeyshot.png",
		}
	},

	["arm5"] = {
		label = "Armor Lvl. 5",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "arm5.png",
		}
	},

	["chicken_and_waffles"] = {
		label = "Chicken & Waffles",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chicken_and_waffles.png",
		}
	},

	["sausages"] = {
		label = "Sausages",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "sausage.png",
		}
	},

	["bprooftires"] = {
		label = "Bulletproof Tires",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bprooftires.png",
		}
	},

	["get_figgy"] = {
		label = "Get Figgy",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "get_figgy.png",
		}
	},

	["sludgie_ice_green"] = {
		label = "sludgie ice green",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sludgie_ice_green.png",
		}
	},

	["morphine10"] = {
		label = "Morphine 10mg",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "morphine10.png",
		}
	},

	["sprite"] = {
		label = "Sprite",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "sprite.png",
		}
	},

	["fishtaco"] = {
		label = "Fish Taco",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "fishtaco.png",
		}
	},

	["blueberry_crate"] = {
		label = "Blueberry Crate",
		weight = 2500,
		stack = true,
		close = false,
		description = "A crate of blueberries ready for selling!",
		client = {
			image = "blueberry_crate.png",
		}
	},

	["flakka"] = {
		label = "Flakka",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "flakka.png",
		}
	},

	["cactus_seed"] = {
		label = "Cactus Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of cactus seeds!",
		client = {
			image = "cactus_seed.png",
		}
	},

	["manual"] = {
		label = "Manual Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "Manual Transmission change for vehicles",
		client = {
			image = "manual.png",
		}
	},

	["biscotti_joint"] = {
		label = "Biscotti Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "biscotti_joint.png",
		}
	},

	["metalscrap"] = {
		label = "Metal Scrap",
		weight = 0,
		stack = true,
		close = false,
		description = "You can probably make something nice out of this",
		client = {
			image = "metalscrap.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Empty Evidence Bag",
		weight = 0,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more",
		client = {
			image = "evidence.png",
		}
	},

	["oxy"] = {
		label = "Prescription Oxy",
		weight = 0,
		stack = true,
		close = true,
		description = "The Label Has Been Ripped Off",
		client = {
			image = "oxy.png",
		}
	},

	["paracetamol"] = {
		label = "Paracetamol",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "paracetamol.png",
		}
	},

	["bahama_glass"] = {
		label = "Empty Glass",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_glass.png",
		}
	},

	["casinochips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "casinochips.png",
		}
	},

	["group_pack"] = {
		label = "WINGS & THIGH BITES GROUP PACK",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "group_pack.png",
		}
	},

	["baconeggtoast"] = {
		label = "Bacon & Egg on Toast",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "baconegg.png",
		}
	},

	["emerald_earring"] = {
		label = "Emerald Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring.png",
		}
	},

	["advscope_attachment"] = {
		label = "Advanced Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "An advanced scope for a weapon",
		client = {
			image = "advscope_attachment.png",
		}
	},

	["xanaxplate"] = {
		label = "Xanax Plate",
		weight = 30,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "xanaxplate.png",
		}
	},

	["boltcutter"] = {
		label = "Bolt Cutter",
		weight = 100,
		stack = true,
		close = true,
		description = "Bolt cutter used to cut small pieces of metal.",
		client = {
			image = "boltcutter.png",
		}
	},

	["dab"] = {
		label = "DAB",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "dab.png",
		}
	},

	["asic_miner_fan"] = {
		label = "Asic mining fan",
		weight = 100,
		stack = true,
		close = true,
		description = "Device to dissipate heat and maintain optimal temperature.",
		client = {
			image = "Fans.png",
		}
	},

	["meth_shot"] = {
		label = "Meth Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "meth_shot.png",
		}
	},

	["thermite_h"] = {
		label = "Thermite",
		weight = 1000,
		stack = false,
		close = true,
		description = "A high_yield thermite charge..",
		client = {
			image = "thermite_h.png",
		}
	},

	["Panther"] = {
		label = "Vintage Phanter",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "",
		}
	},

	["bcoffeeglass"] = {
		label = "Coffee Glass",
		weight = 100,
		stack = true,
		close = true,
		description = "Empty Coffee Glass",
		client = {
			image = "bcoffeeglass.png",
		}
	},

	["bstrawberryvanillaoatlatte"] = {
		label = "Strawberry Vanilla Oat Latte",
		weight = 100,
		stack = true,
		close = true,
		description = "Strawberry Vanilla Oat Latte",
		client = {
			image = "bstrawberryvanillaoatlatte.png",
		}
	},

	["meat_chicken"] = {
		label = "Chicken Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Chicken meat!",
		client = {
			image = "meat_chicken.png",
		}
	},

	["riceball"] = {
		label = "Neko Onigiri",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 42,
			},
			image = "catrice.png",
		}
	},

	["iphone"] = {
		label = "iPhone",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "iphone.png",
		}
	},

	["lime_slushy"] = {
		label = "Lime Slushy",
		weight = 100,
		stack = true,
		close = true,
		description = "🥤✨ A refreshing lime slushy to quench your thirst. 🌟🍽️",
		client = {
			image = "lime_slushy.png",
		}
	},

	["engine2"] = {
		label = "Tier 2 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine2.png",
		}
	},

	["earrings_sgold"] = {
		label = "Earrings SGold",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "earrings_sgold.png",
		}
	},

	["wood_plank"] = {
		label = "Wood Plank",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "woodplank.png",
		}
	},

	["keepcompanionretriever"] = {
		label = "Retriever",
		weight = 500,
		stack = false,
		close = true,
		description = "Retriever is your royal companion!",
		client = {
			image = "A_C_Retriever.png",
		}
	},

	["laptop_pink"] = {
		label = "Pink Laptop",
		weight = 5000,
		stack = false,
		close = true,
		description = "A security Laptop",
		client = {
			image = "laptop_pink.png",
		}
	},

	["empty_cup_for_slushie"] = {
		label = "empty cup for slushie",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "empty_cup_for_slushie.png",
		}
	},

	["vodka_ferm"] = {
		label = "Fermented Vodka",
		weight = 5000,
		stack = true,
		close = false,
		description = "A bucket of fermented vodka!",
		client = {
			image = "vodka_ferm.png",
		}
	},

	["emptysack"] = {
		label = "Sack",
		weight = 100,
		stack = true,
		close = false,
		description = "A empty sack for storing crops!",
		client = {
			image = "emptysack.png",
		}
	},

	["apple_gelato_joint"] = {
		label = "Apple Gelato Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "apple_gelato_joint.png",
		}
	},

	["volcano_burrito"] = {
		label = "Volcano Burrito",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "volcano_burrito.png",
		}
	},

	["tomato_crate"] = {
		label = "Tomato Crate",
		weight = 2500,
		stack = true,
		close = false,
		description = "A crate of tomatoes ready for selling!",
		client = {
			image = "tomato_crate.png",
		}
	},

	["boombox"] = {
		label = "Boom Box",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "boombox.png",
		}
	},

	["dom_perignon"] = {
		label = "Dom Perignon",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "dom_perignon.png",
		}
	},

	["burger_bread"] = {
		label = "burger bread",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "burger_bread.png",
		}
	},

	["policeid"] = {
		label = "POLICE ID",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "policeid.png",
		}
	},

	["salt"] = {
		label = "salt",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "salt.png",
		}
	},

	["gunrack"] = {
		label = "Gunrack",
		weight = 100,
		stack = true,
		close = true,
		description = "Very useful if you are a Law Enforcement Officer and want to rack your weapons in your vehicle.",
		client = {
			image = "gunrack.png",
		}
	},

	["w_ice_cola"] = {
		label = "Ice Cola",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_ice_cola.png",
		}
	},

	["iron"] = {
		label = "Iron",
		weight = 0,
		stack = true,
		close = false,
		description = "Handy piece of metal that you can probably use for something",
		client = {
			image = "iron.png",
		}
	},

	["nvscope_attachment"] = {
		label = "Night Vision Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A night vision scope for a weapon",
		client = {
			image = "nvscope_attachment.png",
		}
	},

	["bapple"] = {
		label = "Apple",
		weight = 100,
		stack = true,
		close = true,
		description = "Red Apple",
		client = {
			image = "bapple.png",
		}
	},

	["noscan"] = {
		label = "Empty NOS Bottle",
		weight = 0,
		stack = true,
		close = true,
		description = "An Empty bottle of NOS",
		client = {
			image = "noscan.png",
		}
	},

	["bee_worker"] = {
		label = "Worker Bee",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bee_worker.png",
		}
	},

	["customplate"] = {
		label = "Customized Plates",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "plate.png",
		}
	},

	["glass"] = {
		label = "Glass",
		weight = 0,
		stack = true,
		close = false,
		description = "It is very fragile, watch out",
		client = {
			image = "glass.png",
		}
	},

	["necklace_family"] = {
		label = "Necklace Family",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "necklace_family.png",
		}
	},

	["default_gateway_override"] = {
		label = "Gateway Override",
		weight = 200,
		stack = false,
		close = true,
		description = "A default gateway override on a usb",
		client = {
			image = "default_gateway_override.png",
		}
	},

	["tequila_shot"] = {
		label = "Tequila Shot",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Shot",
		client = {
			image = "tequila_shot.png",
		}
	},

	["moonshine"] = {
		label = "Moonshine",
		weight = 500,
		stack = true,
		close = false,
		description = "A bottle of moonshine!",
		client = {
			image = "moonshine.png",
		}
	},

	["ecstasy3"] = {
		label = "Ectasy",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "ecstasy3.png",
		}
	},

	["bahama_cachaca"] = {
		label = "Cachaça",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_cachaca.png",
		}
	},

	["limeysdonut"] = {
		label = "Strawberry Donut",
		weight = 200,
		stack = true,
		close = true,
		description = "Strawberry Donut!",
		client = {
			image = "limeysdonut2.png",
		}
	},

	["bee_house"] = {
		label = "Bee House",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bee_house.png",
		}
	},

	["tires"] = {
		label = "Drift Smoke Tires",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "tires.png",
		}
	},

	["keepcompanionhusky"] = {
		label = "Husky",
		weight = 500,
		stack = false,
		close = true,
		description = "Husky is your royal companion!",
		client = {
			image = "A_C_Husky.png",
		}
	},

	["bahama_butter"] = {
		label = "Butter",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_butter.png",
		}
	},

	["casino_burger"] = {
		label = "Casino Burger",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Burger",
		client = {
			image = "casino_burger.png",
		}
	},

	["cryptostick"] = {
		label = "Crypto Stick",
		weight = 200,
		stack = false,
		close = true,
		description = "Why would someone ever buy money that doesn't exist.. How many would it contain..?",
		client = {
			image = "cryptostick.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "Pump 4 Caffeine",
		client = {
			image = "coffee.png",
		}
	},

	["cheesecake"] = {
		label = "Cheese Cake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "cheesecake.png",
		}
	},

	["meat_rabbit"] = {
		label = "Rabbit Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Rabbit meat!",
		client = {
			image = "meat_rabbit.png",
		}
	},

	["drives1"] = {
		label = "Tier 1 Drive Shaft",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "drives1.png",
		}
	},

	["ecola"] = {
		label = "ecola",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ecola.png",
		}
	},

	["butter"] = {
		label = "Butter",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "farming_butter.png",
		}
	},

	["cutter"] = {
		label = "Cutting Machine",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "",
		}
	},

	["basic_rod"] = {
		label = "Fishing rod",
		weight = 250,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "basic_rod.png",
		}
	},

	["usb_red"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A red USB flash drive",
		client = {
			image = "usb_red.png",
		}
	},

	["laptop"] = {
		label = "Laptop",
		weight = 4000,
		stack = true,
		close = true,
		description = "Expensive laptop",
		client = {
			image = "laptop.png",
		}
	},

	["raw_patty"] = {
		label = "raw patty",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "raw_patty.png",
		}
	},

	["advanceddecrypter"] = {
		label = "Advanced Decrypter",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "advanceddecrypter.png",
		}
	},

	["advancedrepairkit"] = {
		label = "Advanced Repairkit",
		weight = 4000,
		stack = false,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "advancedkit.png",
		}
	},

	["dusche"] = {
		label = "Dusche Gold",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 50,
			},
			image = "dusche.png",
		}
	},

	["recyclablematerial"] = {
		label = "Recycle Box",
		weight = 100,
		stack = true,
		close = false,
		description = "A box of Recyclable Materials",
		client = {
			image = "recyclablematerial.png",
		}
	},

	["suspension4"] = {
		label = "Tier 4 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension4.png",
		}
	},

	["prosciuttiobox"] = {
		label = "Boxed Prosciuttio E Funghi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["xpill"] = {
		label = "X_Pill",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "xpill.png",
		}
	},

	["gummy_og_kush_cbd"] = {
		label = "CBD OG_Kush Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd og kush gummy bear!",
		client = {
			image = "gummy_og_kush_cbd.png",
		}
	},

	["nitrous"] = {
		label = "Nitrous",
		weight = 1000,
		stack = true,
		close = true,
		description = "Speed up, gas pedal! :D",
		client = {
			image = "nitrous.png",
		}
	},

	["xanax"] = {
		label = "Xanax",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "xanax.png",
		}
	},

	["beandonut"] = {
		label = "Donut",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "popdonut.png",
		}
	},

	["burger_fries"] = {
		label = "Shot Fries",
		weight = 200,
		stack = true,
		close = true,
		description = "Shot Fries",
		client = {
			status = {
				hunger = 40,
			},
			image = "burger_fries.png",
		}
	},

	["threequarter_raglan_sleeve"] = {
		label = "Three Quarter Raglan Sleeve",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "threequarter_raglan_sleeve.png",
		}
	},

	["eldiablos_first_flag"] = {
		label = "eldiablos First Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "El Diablos First Flag",
		client = {
			image = "eldiablos_first_flag.png",
		}
	},

	["gin_shot"] = {
		label = "Gin Shot",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Shot",
		client = {
			image = "gin_shot.png",
		}
	},

	["highnoon"] = {
		label = "Highnoon",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "highnoon.png",
		}
	},

	["cheese_burger"] = {
		label = "Cheese Burger",
		weight = 267,
		stack = true,
		close = true,
		description = "🍔🧀✨ A classic burger elevated with the creamy goodness of cheese. A true indulgence! 🌟🍴",
		client = {
			image = "cheese_burger.png",
		}
	},

	["mushroom_sack"] = {
		label = "Mushroom Sack",
		weight = 5000,
		stack = true,
		close = false,
		description = "A sack of mushrooms ready for selling!",
		client = {
			image = "mushroom_sack.png",
		}
	},

	["skin_deer"] = {
		label = "Deer Hide",
		weight = 950,
		stack = true,
		close = true,
		description = "Deer hide.",
		client = {
			image = "skin_deer.png",
		}
	},

	["Necklace"] = {
		label = "Diamond Necklace",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "",
		}
	},

	["blue_tomyz_joint"] = {
		label = "Blue Tomyz Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blue_tomyz_joint.png",
		}
	},

	["mozz"] = {
		label = "Mozzeralla",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mozz.png",
		}
	},

	["drill"] = {
		label = "Drill",
		weight = 20000,
		stack = true,
		close = false,
		description = "The real deal...",
		client = {
			image = "drill.png",
		}
	},

	["graphite_rod"] = {
		label = "Graphite rod",
		weight = 350,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "graphite_rod.png",
		}
	},

	["piranha"] = {
		label = "Piranha",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "piranha.png",
		}
	},

	["uncut_sapphire"] = {
		label = "Uncut Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Sapphire",
		client = {
			image = "uncut_sapphire.png",
		}
	},

	["blacklightning"] = {
		label = "Black Lightning",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blacklightning.png",
		}
	},

	["shark"] = {
		label = "Shark",
		weight = 7500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shark.png",
		}
	},

	["beefy_nacho"] = {
		label = "Beefy Nacho",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "beefy_nacho.png",
		}
	},

	["oilp2"] = {
		label = "Tier 2 Oil Pump",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "oilp2.png",
		}
	},

	["xenonsrose"] = {
		label = "Pink Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsrose.png",
		}
	},

	["diaplatinum_earrings"] = {
		label = "Diaplatinum Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "diaplatinum_earrings.png",
		}
	},

	["banana_backwoods"] = {
		label = "Banana Backwoods",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "banana_backwoods.png",
		}
	},

	["bootlegvodka"] = {
		label = "Bootleg Vodka",
		weight = 500,
		stack = true,
		close = false,
		description = "A bottle of bootleg vodka!",
		client = {
			image = "bootlegvodka.png",
		}
	},

	["syringe"] = {
		label = "Syringe",
		weight = 300,
		stack = true,
		close = false,
		description = "Enjoy your new crystal clear stuff!",
		client = {
			image = "syringe.png",
		}
	},

	["car_armor"] = {
		label = "Vehicle Armor",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "car_armour.png",
		}
	},

	["electronickit"] = {
		label = "Electronic Kit",
		weight = 100,
		stack = true,
		close = true,
		description = "If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?",
		client = {
			image = "electronickit.png",
		}
	},

	["wingstop_dips"] = {
		label = "DIPS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "wingstop_dips.png",
		}
	},

	["medscope_attachment"] = {
		label = "Medium Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A medium scope for a weapon",
		client = {
			image = "medscope_attachment.png",
		}
	},

	["taco_regular"] = {
		label = "Taco Regular",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "taco_regular.png",
		}
	},

	["rolls"] = {
		label = "Roll Of Small Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A roll of small notes..",
		client = {
			image = "rolls.png",
		}
	},

	["milk_pail"] = {
		label = "Milk Pail",
		weight = 1000,
		stack = true,
		close = false,
		description = "Fresh milk, straight from the cow!",
		client = {
			image = "milk_pail.png",
		}
	},

	["bahama_shotglass"] = {
		label = "Empty Shot Glass",
		weight = 100,
		stack = true,
		close = false,
		description = "An Ingredient",
		client = {
			image = "bahama_shotglass.png",
		}
	},

	["bm_nachos"] = {
		label = "Guac Nachos",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Beef and Guacamole Nachos!",
		client = {
			image = "bm_nachos.png",
		}
	},

	["fries_burgershot"] = {
		label = "fries burgershot",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fries_burgershot.png",
		}
	},

	["marshmallow_og_joint"] = {
		label = "Marshmallow OG Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "marshmallow_og_joint.png",
		}
	},

	["onion"] = {
		label = "Onion",
		weight = 500,
		stack = true,
		close = false,
		description = "An onion",
		client = {
			image = "burger_onion.png",
		}
	},

	["cables2"] = {
		label = "Tier 2 Battery Cables",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cables2.png",
		}
	},

	["precision_muzzle_brake"] = {
		label = "Precision Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "precision_muzzle_brake.png",
		}
	},

	["barley_seed"] = {
		label = "Barley Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of barley seeds!",
		client = {
			image = "barley_seed.png",
		}
	},

	["diamond_ring_silver"] = {
		label = "Diamond Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_ring_silver.png",
		}
	},

	["housewhite"] = {
		label = "House White Wine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 30,
			},
			image = "housewhite.png",
		}
	},

	["usb_grey"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A grey USB flash drive",
		client = {
			image = "usb_grey.png",
		}
	},

	["sandwich"] = {
		label = "Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice bread for your stomach",
		client = {
			image = "sandwich.png",
		}
	},

	["screwdriver"] = {
		label = "Screwdriver",
		weight = 50,
		stack = true,
		close = true,
		description = "Very useful for changing vehicle plates.",
		client = {
			image = "screwdriver.png",
		}
	},

	["blue_stone"] = {
		label = "Blue Stone",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blue_stone.png",
		}
	},

	

	["necklace_dogtag"] = {
		label = "Necklace Dogtag",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "necklace_dogtag.png",
		}
	},

	["white_runtz_joint"] = {
		label = "White Runtz Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "white_runtz_joint.png",
		}
	},

	["rentalpaper"] = {
		label = "Rental Paper",
		weight = 0,
		stack = false,
		close = false,
		description = "Vehicle rental paper",
		client = {
			image = "rentalpaper.png",
		}
	},

	["crab_legs_meal"] = {
		label = "Crab Legs Meal",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crab_legs_meal.png",
		}
	},

	["hotdogmeat"] = {
		label = "Hotdog Meat",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hotdogmeat.png",
		}
	},

	["chilidog"] = {
		label = "Footlong Chili Dog",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "chillidog.png",
		}
	},

	["burger_salad"] = {
		label = "burger salad",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "burger_salad.png",
		}
	},

	["large_drill"] = {
		label = "Large Drill",
		weight = 20000,
		stack = true,
		close = false,
		description = "A Large Drill, good at cracking Secure Locks.",
		client = {
			image = "large_drill.png",
		}
	},

	["silverchain"] = {
		label = "Silver Chain",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silverchain.png",
		}
	},

	["engine1"] = {
		label = "Tier 1 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine1.png",
		}
	},

	["raw_cone_king"] = {
		label = "Raw Cone King",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "raw_cone_king.png",
		}
	},

	["mininglaser"] = {
		label = "Mining Laser",
		weight = 900,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mininglaser.png",
		}
	},

	["plastic"] = {
		label = "Plastic",
		weight = 0,
		stack = true,
		close = false,
		description = "RECYCLE! _ Greta Thunberg 2019",
		client = {
			image = "plastic.png",
		}
	},

	["baby_lobster_pasta"] = {
		label = "Baby Lobster Pasta",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "baby_lobster_pasta.png",
		}
	},

	["moonshine_distill"] = {
		label = "Distilled Moonshine",
		weight = 5000,
		stack = true,
		close = false,
		description = "A bucket of distilled moonshine!",
		client = {
			image = "moonshine_distill.png",
		}
	},

	["hex_gold"] = {
		label = "Hex Gold",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "hex_gold.png",
		}
	},

	["checkbook"] = {
		label = "Check Book",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "checkbook.png",
		}
	},

	["diavolabox"] = {
		label = "Boxed Diavola",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["shrimp_and_crab_dip"] = {
		label = "Shrimp & Crab Dip",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shrimp_and_crab_dip.png",
		}
	},

	["bmilk"] = {
		label = "Milk",
		weight = 100,
		stack = true,
		close = true,
		description = "Milk",
		client = {
			image = "bmilk.png",
		}
	},

	["fueltank2"] = {
		label = "Tier 2 Fuel Tank",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "fueltank2.png",
		}
	},

	["fitbit"] = {
		label = "Fitbit",
		weight = 500,
		stack = false,
		close = true,
		description = "I like fitbit",
		client = {
			image = "fitbit.png",
		}
	},

	["meal_for_two"] = {
		label = "15PC MEAL FOR 2",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "meal_for_two.png",
		}
	},

	["slicedpotato"] = {
		label = "Sliced Potatoes",
		weight = 500,
		stack = true,
		close = false,
		description = "Sliced Potato",
		client = {
			image = "burger_slicedpotato.png",
		}
	},

	["blueberry_jam_cookie"] = {
		label = "Blueberry Jam Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blueberry_jam_cookie.png",
		}
	},

	["crispy_chicken_staco"] = {
		label = "Crispy Chicken Soft Taco",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "crispy_chicken_staco.png",
		}
	},

	["firstaidforpet"] = {
		label = "First aid for pet",
		weight = 500,
		stack = true,
		close = true,
		description = "Revive your pet!",
		client = {
			image = "firstaidforpet.png",
		}
	},

	["can"] = {
		label = "Empty Can",
		weight = 10,
		stack = true,
		close = false,
		description = "An empty can, good for recycling",
		client = {
			image = "can.png",
		}
	},

	["bahama_icecube"] = {
		label = "Ice Cubes",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_icecube.png",
		}
	},

	["bcoffeebeans"] = {
		label = "Coffee Beans",
		weight = 100,
		stack = true,
		close = true,
		description = "Coffee Beans",
		client = {
			image = "bcoffeebeans.png",
		}
	},

	["orangedrink"] = {
		label = "Orange Drink",
		weight = 1000,
		stack = true,
		close = true,
		description = "A fancy orange juice...",
		client = {
			image = "orangedrink.png",
		}
	},

	["opium_pooch"] = {
		label = "Opium Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "opium_pooch.png",
		}
	},

	["bm_whiskeysour"] = {
		label = "Whiskey Sour",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Whiskey Sour!",
		client = {
			image = "bm_whiskeysour.png",
		}
	},

	["wwmenu"] = {
		label = "White Widow Menu",
		weight = 10,
		stack = true,
		close = true,
		description = "A menu for the white widoe medical dispensary!",
		client = {
			image = "wwmenu.png",
		}
	},

	["advanceddrill"] = {
		label = "Advanced Drill",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "advanceddrill.png",
		}
	},

	["chillimince"] = {
		label = "Chillimince",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chillimince.png",
		}
	},

	["frenchtoast"] = {
		label = "French Toast",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "frenchtoast.png",
		}
	},

	["fried_mushrooms"] = {
		label = "Fried Mushrooms",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fried_mushrooms.png",
		}
	},

	["whitecherry_gelato"] = {
		label = "Whitecherry Gelato",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "whitecherry_gelato.png",
		}
	},

	["keepcompanionrat"] = {
		label = "Rat",
		weight = 500,
		stack = false,
		close = true,
		description = "Your royal companion!",
		client = {
			image = "A_C_Rat.png",
		}
	},

	["tofu"] = {
		label = "Tofu",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 45,
			},
			image = "tofu.png",
		}
	},

	["buffalo_chicken_strips"] = {
		label = "Buffalo Chicken Strips",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "buffalo_chicken_strips.png",
		}
	},

	["weed_wrap"] = {
		label = "Blunt Wraps",
		weight = 75,
		stack = true,
		close = false,
		description = "Get Weed Bag and roll blunt!",
		client = {
			image = "weed_wrap.png",
		}
	},

	["xpills"] = {
		label = "xpills",
		weight = 5,
		stack = true,
		close = false,
		description = "A bottle of XPills",
		client = {
			image = "xpills.png",
		}
	},

	["tilapia_fish_meal"] = {
		label = "Steak & Lobster Meal",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "tilapia_fish_meal.png",
		}
	},

	["blueberry_cruffin"] = {
		label = "Blueberry Cruffin",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blueberry_cruffin.png",
		}
	},

	["bahama_rawwing"] = {
		label = "Raw Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_rawwing.png",
		}
	},

	["pineapple"] = {
		label = "Pineapple",
		weight = 100,
		stack = true,
		close = false,
		description = "Lemon!",
		client = {
			image = "pineapple.png",
		}
	},

	["small_bands"] = {
		label = "Small Bands",
		weight = 500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "small_bands.png",
		}
	},

	["spice_leaf"] = {
		label = "Spice Leaf",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "spice_leaf.png",
		}
	},

	["gummybearmould"] = {
		label = "Gummy Bear Mould",
		weight = 100,
		stack = true,
		close = true,
		description = "A BPA free mould, shaped like a bear!",
		client = {
			image = "gummybearmould.png",
		}
	},

	["molly_pooch"] = {
		label = "Molly Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "molly_pooch.png",
		}
	},

	["cuffkeys"] = {
		label = "Cuff Keys",
		weight = 75,
		stack = true,
		close = true,
		description = "Set them free !",
		client = {
			image = "cuffkeys.png",
		}
	},

	["bm_wings"] = {
		label = "Jerk Chicken Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Jerk Chicken Wings!",
		client = {
			image = "bm_wings.png",
		}
	},

	["diamond_necklace"] = {
		label = "Diamond Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace.png",
		}
	},

	["xenonsorange"] = {
		label = "Orange Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsorange.png",
		}
	},

	["coke_access"] = {
		label = "Access card",
		weight = 50,
		stack = true,
		close = false,
		description = "Access Card for Coke Lab",
		client = {
			image = "coke_access.png",
		}
	},

	["icenugget"] = {
		label = "Ice Nugget",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 24,
			},
			image = "icenugget.png",
		}
	},

	["cheese_fries"] = {
		label = "CHEESE FRIES",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cheese_fries.png",
		}
	},

	["orangotang"] = {
		label = "Bacon",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 27,
			},
			image = "orangotang.png",
		}
	},

	["pinacolada"] = {
		label = "Pinã Colada",
		weight = 30,
		stack = true,
		close = true,
		description = "Alcoholic Drink",
		client = {
			image = "pinacolada.png",
		}
	},

	["sprunklight"] = {
		label = "Sprunk Light",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "sprunklight.png",
		}
	},

	["miningdrill"] = {
		label = "Mining Drill",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "miningdrill.png",
		}
	},

	["onion_slice"] = {
		label = "onion slice",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "onion_slice.png",
		}
	},

	["coke_figureempty"] = {
		label = "Action Figure",
		weight = 150,
		stack = true,
		close = false,
		description = "Action Figure of the cartoon superhero Impotent Rage",
		client = {
			image = "coke_figureempty.png",
		}
	},

	["bahama_avocado"] = {
		label = "Avocado",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_avocado.png",
		}
	},

	["xenonsbleu"] = {
		label = "Blue Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsbleu.png",
		}
	},

	["toolbox"] = {
		label = "Toolbox",
		weight = 0,
		stack = false,
		close = true,
		description = "Needed for Performance part removal",
		client = {
			image = "toolbox.png",
		}
	},

	["sticker"] = {
		label = "sticker",
		weight = 1,
		stack = true,
		close = false,
		description = "Smile :)",
		client = {
			image = "sticker.png",
		}
	},

	["lighter"] = {
		label = "Lighter",
		weight = 100,
		stack = true,
		close = true,
		description = "A lighter, everybody has to have one of these on hand!",
		client = {
			image = "lighter.png",
		}
	},

	["ziptie"] = {
		label = "ZipTie",
		weight = 50,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "ziptie.png",
		}
	},

	["chickensalad"] = {
		label = "Chicken Salad",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "chickensalad.png",
		}
	},

	["cajun_fried_corn"] = {
		label = "CAJUN FRIED CORN",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cajun_fried_corn.png",
		}
	},

	["potatos"] = {
		label = "potatos",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "potatos.png",
		}
	},

	["blacktar"] = {
		label = "Black Tar Heroin",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blacktar.png",
		}
	},

	["trowel"] = {
		label = "Trowel",
		weight = 1000,
		stack = true,
		close = false,
		description = "Small handheld garden shovel",
		client = {
			image = "trowel.png",
		}
	},

	["carbattery"] = {
		label = "Car Battery",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "carbattery.png",
		}
	},

	["newsbmic"] = {
		label = "Boom Microphone",
		weight = 100,
		stack = false,
		close = true,
		description = "A Useable BoomMic",
		client = {
			image = "newsbmic.png",
		}
	},

	["meth_bag"] = {
		label = "Meth Bag",
		weight = 1000,
		stack = true,
		close = false,
		description = "Plastic bag with magic stuff!",
		client = {
			image = "meth_bag.png",
		}
	},

	["cheese_package"] = {
		label = "Cheese Package",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "cheese_package.png",
		}
	},

	["collins_ave"] = {
		label = "Collins AVE",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "collins_ave.png",
		}
	},

	["pickaxe"] = {
		label = "Pickaxe",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "pickaxe.png",
		}
	},

	["radioscanner"] = {
		label = "Radio Scanner",
		weight = 1000,
		stack = true,
		close = true,
		description = "With this you can get some police alerts. Not 100% effective however",
		client = {
			image = "radioscanner.png",
		}
	},

	["art5"] = {
		label = "Obi Jesus Painting",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art5.png",
		}
	},

	["mdtablet"] = {
		label = "Tablet",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mdtablet.png",
		}
	},

	["fried_scallops"] = {
		label = "Fried Scallops",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fried_scallops.png",
		}
	},

	["squared_muzzle_brake"] = {
		label = "Squared Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "squared_muzzle_brake.png",
		}
	},

	["cheetah_piss_joint"] = {
		label = "Cheetah Piss Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cheetah_piss_joint.png",
		}
	},

	["silver_ring"] = {
		label = "Silver Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_ring.png",
		}
	},

	["farm_fertilizer"] = {
		label = "Fertilizer",
		weight = 1500,
		stack = true,
		close = false,
		description = "A bag of organic fertilizer!",
		client = {
			image = "farm_fertilizer.png",
		}
	},

	["raw_meth"] = {
		label = "raw meth",
		weight = 3,
		stack = true,
		close = false,
		description = "Raw Meth",
		client = {
			image = "meth.png",
		}
	},

	["paintcan"] = {
		label = "Vehicle Spray Can",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "spraycan.png",
		}
	},

	["marshmallow_og"] = {
		label = "Marshmallow OG",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "marshmallow_og.png",
		}
	},

	["fat_end_muzzle_brake"] = {
		label = "Fat End Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "fat_end_muzzle_brake.png",
		}
	},

	["platbox_earrings"] = {
		label = "Platbox Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "platbox_earrings.png",
		}
	},

	["shells_clam_chowder"] = {
		label = "Shells Clam Chowder",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shells_clam_chowder.png",
		}
	},

	["classic_donut"] = {
		label = "classic donut",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "classic_donut.png",
		}
	},

	["bcocacola"] = {
		label = "CocaCola",
		weight = 100,
		stack = true,
		close = true,
		description = "Cup Fill With Cocacola",
		client = {
			image = "bcocacola.png",
		}
	},

	["bahama_coffee"] = {
		label = "Coffee",
		weight = 100,
		stack = true,
		close = false,
		description = "An Ingredient",
		client = {
			image = "bahama_coffee.png",
		}
	},

	["bong"] = {
		label = "Bong",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "bong.png",
		}
	},

	["bacon_in_package"] = {
		label = "Bacon in package",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "bacon_in_package.png",
		}
	},

	["emerald"] = {
		label = "Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A Emerald that shimmers",
		client = {
			image = "emerald.png",
		}
	},

	["oysters_half_shell"] = {
		label = "Oysters On the Half Shell",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "oysters_half_shell.png",
		}
	},

	["mushroom_seed"] = {
		label = "Mushroom Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of mushroom seeds!",
		client = {
			image = "mushroom_seed.png",
		}
	},

	["zushi_joint"] = {
		label = "Zushi Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "zushi_joint.png",
		}
	},

	["pasta"] = {
		label = "Bag of Pasta",
		weight = 200,
		stack = true,
		close = false,
		description = "A bag of Pasta",
		client = {
			image = "pasta.png",
		}
	},

	["art7"] = {
		label = "Family Portait",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art7.png",
		}
	},

	["meth_tray"] = {
		label = "meth tray",
		weight = 3,
		stack = true,
		close = false,
		description = "Tray of meth",
		client = {
			image = "meth_tray.png",
		}
	},

	["medicalbag"] = {
		label = "Medical Bag",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "medicalbag.png",
		}
	},

	["bahama_tequila"] = {
		label = "Tequila",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_tequila.png",
		}
	},

	["bm_millerlite"] = {
		label = "Millerlite Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Draft Miller Lite!",
		client = {
			image = "bm_millerlite.png",
		}
	},

	["roseymary_gin_fizz"] = {
		label = "Roseymary Gin Fizz",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "roseymary_gin_fizz.png",
		}
	},

	["basicdecrypter"] = {
		label = "Basic Decrypter",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "basicdecrypter.png",
		}
	},

	["transmission1"] = {
		label = "Tier 1 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission1.png",
		}
	},

	["chain_medal"] = {
		label = "Chain Medal",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_medal.png",
		}
	},

	["trackeritem"] = {
		label = "Tracker Disabler",
		weight = 2000,
		stack = true,
		close = true,
		description = "A tracking disabler",
		client = {
			image = "trackeritem.png",
		}
	},

	["the_bleeder_burger"] = {
		label = "the bleeder burger",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "the_bleeder_burger.png",
		}
	},

	["blueberry_slushy"] = {
		label = "Blueberry Slushy",
		weight = 100,
		stack = true,
		close = true,
		description = "🥤✨ A refreshing blueberry slushy to quench your thirst. 🌟🍽️",
		client = {
			image = "blueberry_slushy.png",
		}
	},

	["goldpan"] = {
		label = "Gold Panning Tray",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldpan.png",
		}
	},

	
	["lithium"] = {
		label = "lithium",
		weight = 10,
		stack = true,
		close = false,
		description = "A Substance used in the creation of batteries",
		client = {
			image = "lithium.png",
		}
	},


	["cash_bag"] = {
		label = "Gruppe 6 Cash Bag",
		weight = 1000,
		stack = true,
		close = false,
		description = "Bag full of un_inked cash",
		client = {
			image = "cash_bag.png",
		}
	},

	["bm_kebab"] = {
		label = "BBQ Beef Kebab",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama BBQ Beef Kebab!",
		client = {
			image = "bm_kebab.png",
		}
	},

	["driverlicense"] = {
		label = "DRIVER LICENSE",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "driverlicense.png",
		}
	},

	["empty_weed_bag"] = {
		label = "Resealable Bag",
		weight = 1,
		stack = true,
		close = true,
		description = "A small empty bag",
		client = {
			image = "empty_weed_bag.png",
		}
	},

	["no_99"] = {
		label = "NO 99",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "no_99.png",
		}
	},

	["skullcamo_attachment"] = {
		label = "Skull Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A skull camo for a weapon",
		client = {
			image = "skullcamo_attachment.png",
		}
	},

	["psilocybin_seed"] = {
		label = "Psilocybin Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of psilocybin seeds!",
		client = {
			image = "psilocybin_seed.png",
		}
	},

	["coke_figure"] = {
		label = "Action Figure",
		weight = 150,
		stack = true,
		close = false,
		description = "Action Figure of the cartoon superhero Impotent Rage",
		client = {
			image = "coke_figure.png",
		}
	},

	["ps_dr_pepper"] = {
		label = "Dr Pepper",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ps_dr_pepper.png",
		}
	},

	["moon_rock_joint"] = {
		label = "Moon Rock Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "moon_rock_joint.png",
		}
	},

	["bhotchocolatepowder"] = {
		label = "Hot Chocolate Powder",
		weight = 100,
		stack = true,
		close = true,
		description = "Hot Chocolate Powder",
		client = {
			image = "bhotchocolatepowder.png",
		}
	},

	["lsd2"] = {
		label = "LSD",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "lsd2.png",
		}
	},

	["coca_leaf"] = {
		label = "Coca Leaf",
		weight = 2,
		stack = true,
		close = false,
		description = "A coca leaf",
		client = {
			image = "coca_leaf.png",
		}
	},

	["nekocookie"] = {
		label = "Neko Cookie",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 45,
			},
			image = "catcookie.png",
		}
	},

	["arm2"] = {
		label = "Armor Lvl. 2",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "arm2.png",
		}
	},

	["bahama_seasoning"] = {
		label = "Seasonings",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_seasoning.png",
		}
	},

	["bahama_vodka"] = {
		label = "Vodka",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_vodka.png",
		}
	},

	["bchocolatemuffin"] = {
		label = "Chocolate Muffin",
		weight = 100,
		stack = true,
		close = true,
		description = "Chocolate Muffin",
		client = {
			image = "bchocolatemuffin.png",
		}
	},

	["bhighcoffeeglasscup"] = {
		label = "High Coffee Glass",
		weight = 100,
		stack = true,
		close = true,
		description = "Empty High Coffee Glass",
		client = {
			image = "bhighcoffeeglasscup.png",
		}
	},

	["cheesy_black_bean"] = {
		label = "Cheesy Black Bean",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "cheesy_black_bean.png",
		}
	},

	["biscotti"] = {
		label = "Biscotti",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "biscotti.png",
		}
	},

	["codine"] = {
		label = "Codine",
		weight = 2,
		stack = true,
		close = false,
		description = "A strong painkiller",
		client = {
			image = "codine.png",
		}
	},

	["shovel"] = {
		label = "Flag Removal Shovel",
		weight = 500,
		stack = true,
		close = true,
		description = "Used to destroy/remove flags",
		client = {
			image = "lost_flag.png",
		}
	},

	["buns"] = {
		label = "Buns",
		weight = 241,
		stack = true,
		close = true,
		description = "🍔✨ Soft and fluffy, these buns are the perfect vessel for a mouthwatering burger. 🌟🍴",
		client = {
			image = "buns.png",
		}
	},

	["chop_wheel"] = {
		label = "Car Wheel",
		weight = 1000,
		stack = true,
		close = true,
		description = "A wheel from a vehicle",
		client = {
			image = "chop_wheel.png",
		}
	},

	["sapphire"] = {
		label = "Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A Sapphire that shimmers",
		client = {
			image = "sapphire.png",
		}
	},

	["skin_dolphin"] = {
		label = "Dolphin Skin",
		weight = 850,
		stack = true,
		close = true,
		description = "Dolphin skin. Highly illegal!",
		client = {
			image = "skin_dolphin.png",
		}
	},

	["frozennugget"] = {
		label = "Frozen Nuggets",
		weight = 500,
		stack = true,
		close = false,
		description = "Bag of Frozen Nuggets",
		client = {
			image = "burger_frozennugget.png",
		}
	},

	["bacon_egg_cheese"] = {
		label = "Bacon Egg Cheese",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "bacon_egg_cheese.png",
		}
	},

	["cocaine"] = {
		label = "cocaine",
		weight = 5,
		stack = true,
		close = false,
		description = "A bag of cocaine",
		client = {
			image = "cocaine.png",
		}
	},

	["pendulus_platinum"] = {
		label = "Pendulus Platinum",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pendulus_platinum.png",
		}
	},

	["kurkakola"] = {
		label = "Cola",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "cola.png",
		}
	},

	["firework4"] = {
		label = "Weeping Willow",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework4.png",
		}
	},

	["breakfast_meal"] = {
		label = "Breakfast Meal",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "breakfast_meal.png",
		}
	},

	["advancedlockpick"] = {
		label = "Advanced Lockpick",
		weight = 100,
		stack = true,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers",
		client = {
			image = "advancedlockpick.png",
		}
	},

	["hex4you_earrings"] = {
		label = "Hex4You Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "hex4you_earrings.png",
		}
	},

	["lime_crate"] = {
		label = "Lime Crate",
		weight = 3500,
		stack = true,
		close = false,
		description = "A crate of limes ready for selling!",
		client = {
			image = "lime_crate.png",
		}
	},

	["broom"] = {
		label = "broom",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "broom.png",
		}
	},

	["chickenbreast"] = {
		label = "Chicken Breast",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			status = {
				hunger = 13,
			},
			image = "chickenbreast.png",
		}
	},

	["mimosa"] = {
		label = "Mimosa",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "mimosa.png",
		}
	},

	["tablet"] = {
		label = "Tablet",
		weight = 2000,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["syriange"] = {
		label = "Syriange",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "syriange.png",
		}
	},

	["strawberry_jam_cookie"] = {
		label = "Strawberry Jam Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "strawberry_jam_cookie.png",
		}
	},

	["xenonsrouge"] = {
		label = "Red Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsrouge.png",
		}
	},

	["plastic_bag"] = {
		label = "plastic bag",
		weight = 1,
		stack = true,
		close = false,
		description = "Am empty plastic bag",
		client = {
			image = "plastic_bag.png",
		}
	},

	["adderall"] = {
		label = "Adderall",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "adderall.png",
		}
	},

	["spikestrip"] = {
		label = "Spikestrip",
		weight = 25,
		stack = true,
		close = true,
		description = "A spikestrip",
		client = {
			image = "spikestrip.png",
		}
	},

	["lsd1"] = {
		label = "LSD",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "lsd1.png",
		}
	},

	["fueltank3"] = {
		label = "Tier 3 Fuel Tank",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "fueltank3.png",
		}
	},

	["bm_budlite"] = {
		label = "Budlite Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Draft Bud Lite!",
		client = {
			image = "bm_budlite.png",
		}
	},

	["red_wine_sangria"] = {
		label = "Redwine Sangria",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "red_wine_sangria.png",
		}
	},

	["repairkit"] = {
		label = "Repairkit",
		weight = 2500,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "repairkit.png",
		}
	},

	["strawberry_crate"] = {
		label = "Strawberry Crate",
		weight = 2500,
		stack = true,
		close = false,
		description = "A crate of strawberries ready for selling!",
		client = {
			image = "strawberry_crate.png",
		}
	},

	["basicdrill"] = {
		label = "Basic Drill",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "basicdrill.png",
		}
	},

	["keepcompanionpug"] = {
		label = "Pug",
		weight = 500,
		stack = false,
		close = true,
		description = "Pug is your royal companion!",
		client = {
			image = "A_C_Pug.png",
		}
	},

	["tequila_bottle"] = {
		label = "Tequila Bottle",
		weight = 500,
		stack = true,
		close = true,
		description = "A fine bottle of tequila",
		client = {
			image = "tequila_bottle.png",
		}
	},

	["blueberry_seed"] = {
		label = "Blueberry Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of blueberry seeds!",
		client = {
			image = "blueberry_seed.png",
		}
	},

	["cake_mix_joint"] = {
		label = "Cake Mix Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cake_mix_joint.png",
		}
	},

	["louisiana_voodoo_fries"] = {
		label = "LOUISIANA VOODOO FRIES",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "louisiana_voodoo_fries.png",
		}
	},

	["vegetariana"] = {
		label = "Vegetariana",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "vegetariana.png",
		}
	},

	["heavy_duty_muzzle_brake"] = {
		label = "HD Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "heavy_duty_muzzle_brake.png",
		}
	},

	["xray"] = {
		label = "X_Ray Scanner",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "xray.png",
		}
	},

	["bregularcup"] = {
		label = "Regular Cup",
		weight = 100,
		stack = true,
		close = true,
		description = "Regular Cup",
		client = {
			image = "bregularcup.png",
		}
	},

	["tenkgoldchain"] = {
		label = "10k Gold Chain",
		weight = 2000,
		stack = true,
		close = true,
		description = "10 carat golden chain",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["barley_sack"] = {
		label = "Barley Sack",
		weight = 5000,
		stack = true,
		close = false,
		description = "A sack of barley ready for selling!",
		client = {
			image = "barley_sack.png",
		}
	},

	["lspr_flag"] = {
		label = "LSPR Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "LSPR Flag",
		client = {
			image = "lspr_flag.png",
		}
	},

	["maitai"] = {
		label = "Mai Tai",
		weight = 30,
		stack = true,
		close = true,
		description = "Alcoholic Drink",
		client = {
			image = "maitai.png",
		}
	},

	["skin_coyote"] = {
		label = "Coyote Hide",
		weight = 750,
		stack = true,
		close = true,
		description = "Coyote hide.",
		client = {
			image = "skin_coyote.png",
		}
	},

	["bahama_gin"] = {
		label = "Gin",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_gin.png",
		}
	},

	["bottle"] = {
		label = "Vintage Bottle",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "",
		}
	},

	["empty_lean_bottle"] = {
		label = "Empty Lean Bottle",
		weight = 1,
		stack = true,
		close = false,
		description = "Its empty",
		client = {
			image = "empty_lean_bottle.png",
		}
	},

	["tirerepairkit"] = {
		label = "Tire Repair Kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "A kit to repair your tires",
		client = {
			image = "tirerepairkit.png",
		}
	},

	["mdlaptop"] = {
		label = "Slow Laptop",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "laptop.png",
		}
	},

	["meat_mtlion"] = {
		label = "Mt Lion Meat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Mt Lion meat!",
		client = {
			image = "meat_mtlion.png",
		}
	},

	["dendrogyra_coral"] = {
		label = "Dendrogyra",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as pillar coral",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["bcoldbrewlatte"] = {
		label = "Cold Brew Latte",
		weight = 100,
		stack = true,
		close = true,
		description = "Cold Brew Latte",
		client = {
			image = "bcoldbrewlatte.png",
		}
	},

	['spray_remover'] = {
		label = 'Spray Remover',
		weight = 250,
		close = true,
		consume = 0,
		client = { 
			image = "spray_remover.png",
		},
		server = {
			export = 'rcore_spray.spray_remover',
		},
	},

	["petgroomingkit"] = {
		label = "Pet Grooming Kit",
		weight = 1000,
		stack = false,
		close = true,
		description = "Pet Grooming Kit",
		client = {
			image = "petgroomingkit.png",
		}
	},

	["dblhornburger"] = {
		label = "DBL HornBurger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "dblhornburger.png",
		}
	},

	["newsmic"] = {
		label = "News Microphone",
		weight = 100,
		stack = false,
		close = true,
		description = "A microphone for the news",
		client = {
			image = "newsmic.png",
		}
	},

	["keepcompanionshepherd"] = {
		label = "Shepherd",
		weight = 500,
		stack = false,
		close = true,
		description = "Shepherd is your royal companion!",
		client = {
			image = "A_C_shepherd.png",
		}
	},

	["diamond_necklace_silver"] = {
		label = "Diamond Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace_silver.png",
		}
	},

	["sapphire_ring_silver"] = {
		label = "Sapphire Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring_silver.png",
		}
	},

	["bahama_mango"] = {
		label = "Mango",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_mango.png",
		}
	},

	["eldiablos_flag"] = {
		label = "eldiablos Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "El Diablos Flag",
		client = {
			image = "eldiablos_flag.png",
		}
	},

	["medfruits"] = {
		label = "Fresh Fruit Medly",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "medfruits.png",
		}
	},

	["oilp1"] = {
		label = "Tier 1 Oil Pump",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "oilp1.png",
		}
	},

	["uncut_emerald"] = {
		label = "Uncut Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Emerald",
		client = {
			image = "uncut_emerald.png",
		}
	},

	["scissors"] = {
		label = "Scissors",
		weight = 40,
		stack = true,
		close = false,
		description = "To help you with collecting",
		client = {
			image = "scissors.png",
		}
	},

	["idcard"] = {
		label = "CITIZEN ID",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "idcard.png",
		}
	},

	["moonshine_ferm"] = {
		label = "Fermented Moonshine",
		weight = 5000,
		stack = true,
		close = false,
		description = "A bucket of fermented moonshine!",
		client = {
			image = "moonshine_ferm.png",
		}
	},

	["headlights"] = {
		label = "Xenon Headlights",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "headlights.png",
		}
	},

	["transmission4"] = {
		label = "Tier 4 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission4.png",
		}
	},

	["coke_raw"] = {
		label = "Raw Coke",
		weight = 50,
		stack = true,
		close = true,
		description = "Coke with some dirty particles",
		client = {
			image = "coke_raw.png",
		}
	},

	["lspr_first_flag"] = {
		label = "LSPR First Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "LSPR First Flag",
		client = {
			image = "lspr_first_flag.png",
		}
	},

	["laptop_red"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Plague",
		client = {
			image = "laptop_red.png",
		}
	},

	["sliced_burger_bread"] = {
		label = "sliced burger bread",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sliced_burger_bread.png",
		}
	},

	["bhoney"] = {
		label = "Honey",
		weight = 100,
		stack = true,
		close = true,
		description = "Honey",
		client = {
			image = "bhoney.png",
		}
	},

	["bm_coorslite"] = {
		label = "Coorslite Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Draft Coors Lite!",
		client = {
			image = "bm_coorslite.png",
		}
	},

	["thigh_bites_combo"] = {
		label = "LARGE THIGH BITES COMBO",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "thigh_bites_combo.png",
		}
	},

	["rollingpapers"] = {
		label = "Rolling Papers",
		weight = 50,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rollingpapers.png",
		}
	},

	["spray"] = {
		label = "Spray",
		weight = 500,
		stack = true,
		close = true,
		description = "Spray paint can",
		client = { 
			image = "spray.png",
		},	
		server = {
			export = 'rcore_spray.spray',
		},
	},

	["alabama_slammer"] = {
		label = "Alabama Slammer",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Beverage",
		client = {
			image = "alabama_slammer.png",
		}
	},

	["drug_scales"] = {
		label = "Scale",
		weight = 1500,
		stack = true,
		close = false,
		description = "A set of premium scales for weighing out decimals..",
		client = {
			image = "drug_scales.png",
		}
	},

	["strawberry_seed"] = {
		label = "Strawberry Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of strawberry seeds!",
		client = {
			image = "strawberry_seed.png",
		}
	},

	["heart_stopper_burger"] = {
		label = "heart stopper burger",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heart_stopper_burger.png",
		}
	},

	["keepcompanionwesty"] = {
		label = "Westy",
		weight = 500,
		stack = false,
		close = true,
		description = "Westy is your royal companion!",
		client = {
			image = "A_C_Westy.png",
		}
	},

	["grabba_leaf"] = {
		label = "Grabba Leaf",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "grabba_leaf.png",
		}
	},

	["tender_pack"] = {
		label = "24PC CRISPY TENDER PACK",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "tender_pack.png",
		}
	},

	["emerald_earring_silver"] = {
		label = "Emerald Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring_silver.png",
		}
	},

	["t_tango_apple"] = {
		label = "Tango Apple",
		weight = 500,
		stack = true,
		close = true,
		description = "Drink.",
		client = {
			image = "t_tango_apple.png",
		}
	},

	["oreoz"] = {
		label = "Oreoz",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "oreoz.png",
		}
	},

	["lsd4"] = {
		label = "LSD",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "lsd4.png",
		}
	},

	["ruby_ring"] = {
		label = "Ruby Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring.png",
		}
	},

	["shot_glass"] = {
		label = "Shot Glass",
		weight = 500,
		stack = true,
		close = true,
		description = "An Empty Shot Glass",
		client = {
			image = "shot_glass.png",
		}
	},

	["maize_sack"] = {
		label = "Maize Sack",
		weight = 5000,
		stack = true,
		close = false,
		description = "A sack of maize ready for selling!",
		client = {
			image = "maize_sack.png",
		}
	},

	["armbrace"] = {
		label = "Armbrace",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "armbrace.png",
		}
	},

	["mechanic_tools"] = {
		label = "Mechanic tools",
		weight = 0,
		stack = false,
		close = true,
		description = "Needed for vehicle repairs",
		client = {
			image = "mechanic_tools.png",
		}
	},

	["jerry_can"] = {
		label = "Jerrycan 20L",
		weight = 20000,
		stack = true,
		close = true,
		description = "A can full of Fuel",
		client = {
			image = "jerry_can.png",
		}
	},

	["bm_oldfashion"] = {
		label = "Old Fashioned",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Old Fashioned!",
		client = {
			image = "bm_oldfashion.png",
		}
	},

	["icecake"] = {
		label = "Ice Cream Cake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "icecake.png",
		}
	},

	["limeyschocolate2"] = {
		label = "Cadbury Dairy Milk Chocolate",
		weight = 100,
		stack = true,
		close = true,
		description = "Cadbury Chocolate!",
		client = {
			image = "limeyschocolate2.png",
		}
	},

	["caffeagra"] = {
		label = "Caffeagra",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 21,
			},
			image = "caffeagra.png",
		}
	},

	["burger_coffee"] = {
		label = "BurgerShot Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Coffee",
		client = {
			status = {
				thirst = 35,
			},
			image = "burger_coffee.png",
		}
	},

	["hackingtab"] = {
		label = "Hacking Tablet",
		weight = 800.0,
		stack = true,
		close = true,
		client = {
			image = "hackingtab.png",
		}
	},

	["raw_fries"] = {
		label = "raw fries",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "raw_fries.png",
		}
	},

	["hellhounds_flag"] = {
		label = "hellhounds Flag",
		weight = 500,
		stack = true,
		close = true,
		description = "hellhounds Flag",
		client = {
			image = "hellhounds_flag.png",
		}
	},

	["vodka_distill"] = {
		label = "Distilled Vodka",
		weight = 5000,
		stack = true,
		close = false,
		description = "A bucket of distilled vodka!",
		client = {
			image = "vodka_distill.png",
		}
	},

	["tosti"] = {
		label = "Grilled Cheese Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice to eat",
		client = {
			image = "tosti.png",
		}
	},

	["fries_grande"] = {
		label = "Fries Grande",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "fries_grande.png",
		}
	},

	["neckbrace"] = {
		label = "Neckbrace",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "neckbrace.png",
		}
	},

	["backwoods_russian_cream"] = {
		label = "Backwoods Russian Cream",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "backwoods_russian_cream.png",
		}
	},

	["cocomilk"] = {
		label = "Coco Milk",
		weight = 10,
		stack = true,
		close = true,
		description = "Ingredients",
		client = {
			image = "cocomilk.png",
		}
	},

	["la_confidential_joint"] = {
		label = "LA Confidential Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "la_confidential_joint.png",
		}
	},

	["ruby_earring_silver"] = {
		label = "Ruby Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring_silver.png",
		}
	},

	["crack_pipe"] = {
		label = "Crack Pipe",
		weight = 550,
		stack = true,
		close = false,
		description = "Enjoy your Crack!",
		client = {
			image = "crack_pipe.png",
		}
	},

	["bhotchoc"] = {
		label = "Hot Choc",
		weight = 100,
		stack = true,
		close = true,
		description = "Hot Choc",
		client = {
			image = "bhotchoc.png",
		}
	},

	["cherrycocktail"] = {
		label = "Cherry Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Cherries.. But with whiskey",
		client = {
			image = "cherrycocktail.png",
		}
	},

	["keepcompanionrabbit"] = {
		label = "Rabbit",
		weight = 500,
		stack = false,
		close = true,
		description = "Rabbit is your royal companion!",
		client = {
			image = "A_C_Rabbit_01.png",
		}
	},

	["ice"] = {
		label = "ice",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ice.png",
		}
	},

	["lettuce_seed"] = {
		label = "Lettuce Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of lettuce seeds!",
		client = {
			image = "lettuce_seed.png",
		}
	},

	["party_pack"] = {
		label = "50PC PARTY PACK",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "party_pack.png",
		}
	},

	["ecstasy1"] = {
		label = "Ectasy",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "ecstasy1.png",
		}
	},

	["uncut_ruby"] = {
		label = "Uncut Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Ruby",
		client = {
			image = "uncut_ruby.png",
		}
	},

	["keepcompanionrottweiler"] = {
		label = "Rottweiler",
		weight = 500,
		stack = false,
		close = true,
		description = "Rottweiler is your royal companion!",
		client = {
			image = "A_Rottweiler.png",
		}
	},

	["police_bulletproof"] = {
		label = "Police Bulletproof",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "police_bulletproof.png",
		}
	},

	["usb_gold"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A gold USB flash drive",
		client = {
			image = "usb_gold.png",
		}
	},

	["paris_fog"] = {
		label = "Paris Fog",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "paris_fog.png",
		}
	},

	["beer_pint"] = {
		label = "Pint of Beer",
		weight = 500,
		stack = true,
		close = true,
		description = "A pint of beer",
		client = {
			image = "beer_pint.png",
		}
	},

	["oxycodone"] = {
		label = "Oxycodone",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "oxycodone.png",
		}
	},

	["chain_richman"] = {
		label = "Chain Richman",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_richman.png",
		}
	},

	["crack"] = {
		label = "Crack",
		weight = 30,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "crack.png",
		}
	},

	["chocolate_donut"] = {
		label = "chocolate donut",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "chocolate_donut.png",
		}
	},

	["weed_access"] = {
		label = "Access Card",
		weight = 50,
		stack = true,
		close = false,
		description = "Access Card for Weed Lab",
		client = {
			image = "weed_access.png",
		}
	},

	["black_jeans"] = {
		label = "Black Jeans",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "black_jeans.png",
		}
	},

	["atomic_wings"] = {
		label = "Atomic Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "atomic_wings.png",
		}
	},

	["opium"] = {
		label = "Opium",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "opium.png",
		}
	},

	["w_dr_pepper"] = {
		label = "Dr Pepper",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_dr_pepper.png",
		}
	},

	["cup"] = {
		label = "cup",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "cup.png",
		}
	},

	["bahama_lime"] = {
		label = "Lime",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_lime.png",
		}
	},

	["borange"] = {
		label = "Orange",
		weight = 100,
		stack = true,
		close = true,
		description = "Orange",
		client = {
			image = "borange.png",
		}
	},

	["breadslice"] = {
		label = "Slice of Bread",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 13,
			},
			image = "breadslice.png",
		}
	},

	["tactical_muzzle_brake"] = {
		label = "Tactical Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brakee for a weapon",
		client = {
			image = "tactical_muzzle_brake.png",
		}
	},

	["burger_bleeder"] = {
		label = "The Bleeder",
		weight = 200,
		stack = true,
		close = true,
		description = "The Bleeder",
		client = {
			status = {
				hunger = 42,
			},
			image = "burger_bleeder.png",
		}
	},

	["egg_burger"] = {
		label = "Egg Burger",
		weight = 380,
		stack = true,
		close = true,
		description = "🍔🍳✨ A delicious combination of a juicy burger patty and a perfectly cooked egg. A breakfast delight! 🌟🍽️",
		client = {
			image = "egg_burger.png",
		}
	},

	["meat_cormorant"] = {
		label = "Cormorant Meat",
		weight = 400,
		stack = true,
		close = true,
		description = "Cormorant meat!",
		client = {
			image = "meat_cormorant.png",
		}
	},

	["meth_pipe"] = {
		label = "Meth Pipe",
		weight = 880,
		stack = true,
		close = false,
		description = "Enjoy your new crystal clear stuff!",
		client = {
			image = "meth_pipe.png",
		}
	},

	["fingle_burger"] = {
		label = "fingle burger",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fingle_burger.png",
		}
	},

	["fentanyl_pill"] = {
		label = "Fentanyl Pill",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fentanyl_pill.png",
		}
	},

	["bsprite"] = {
		label = "Sprite",
		weight = 100,
		stack = true,
		close = true,
		description = "Cup Fill With Sprite",
		client = {
			image = "bsprite.png",
		}
	},

	["hood"] = {
		label = "Vehicle Hood",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "hood.png",
		}
	},

	["bahama_curacao"] = {
		label = "Blue Curacao",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_curacao.png",
		}
	},

	["apple_crate"] = {
		label = "Apple Crate",
		weight = 3500,
		stack = true,
		close = false,
		description = "A crate of apples ready for selling!",
		client = {
			image = "apple_crate.png",
		}
	},

	["meth_sharp"] = {
		label = "Tray with smashed meth",
		weight = 1000,
		stack = true,
		close = false,
		description = "Can be packed",
		client = {
			image = "meth_sharp.png",
		}
	},

	["bm_caipirinhashot"] = {
		label = "Caipirinha Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Caipirinha Shot!",
		client = {
			image = "bm_caipirinhashot.png",
		}
	},

	["anchovy"] = {
		label = "Anchovy",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "anchovy.png",
		}
	},

	["skull_earrings"] = {
		label = "Skull Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "skull_earrings.png",
		}
	},

	["emerald_necklace"] = {
		label = "Emerald Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace.png",
		}
	},

	["keepcompanioncoyote"] = {
		label = "Coyote",
		weight = 500,
		stack = false,
		close = true,
		description = "Coyote is your royal companion!",
		client = {
			image = "A_C_Coyote.png",
		}
	},

	["hornburger"] = {
		label = "HornBurger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "hornburger.png",
		}
	},

	["bberrymuffin"] = {
		label = "Berry Muffin",
		weight = 100,
		stack = true,
		close = true,
		description = "Berry Muffin",
		client = {
			image = "bberrymuffin.png",
		}
	},

	["xenonsblacklight"] = {
		label = "Blacklight Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsblacklight.png",
		}
	},

	["petnametag"] = {
		label = "Name tag",
		weight = 500,
		stack = true,
		close = true,
		description = "Rename your pet",
		client = {
			image = "petnametag.png",
		}
	},

	["mocha"] = {
		label = "Mocha Meow",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 44,
			},
			image = "mochameow.png",
		}
	},

	["sauce"] = {
		label = "Tomato Sauce",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sauce.png",
		}
	},

	["pizzabase"] = {
		label = "Pizza Base",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "base2.png",
		}
	},

	["trans1"] = {
		label = "Transmission Lvl. 1",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "trans1.png",
		}
	},

	["bahama_eggs"] = {
		label = "Fresh Eggs",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_eggs.png",
		}
	},

	["paxton_pearl_cigars"] = {
		label = "Paxton Pearl Cigars",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "paxton_pearl_cigars.png",
		}
	},

	["wine"] = {
		label = "Wine",
		weight = 300,
		stack = true,
		close = false,
		description = "Some good wine to drink on a fine evening",
		client = {
			image = "wine.png",
		}
	},

	["ecocoffee"] = {
		label = "The Eco_ffee",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 28,
			},
			image = "ecoffee.png",
		}
	},

	["ketamine"] = {
		label = "Ketamine",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ketamine.png",
		}
	},

	["silverore"] = {
		label = "Silver Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Silver Ore",
		client = {
			image = "silverore.png",
		}
	},

	["sliced_burger_tomatos"] = {
		label = "sliced burger tomatos",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sliced_burger_tomatos.png",
		}
	},

	["art4"] = {
		label = "Presidential Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art4.png",
		}
	},

	["farmguide"] = {
		label = "Farming Handbook",
		weight = 100,
		stack = true,
		close = false,
		description = "Learn all about farming with this handbook!",
		client = {
			image = "farmguide.png",
		}
	},

	["cheese_sauce"] = {
		label = "CHEESE SAUCE",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cheese_sauce.png",
		}
	},

	["gummy_purple_haze_cbd"] = {
		label = "CBD Purple_Haze Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd purple haze gummy bear!",
		client = {
			image = "gummy_purple_haze_cbd.png",
		}
	},

	["kronos_gold"] = {
		label = "Kronos Gold",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "kronos_gold.png",
		}
	},

	["chopped_pickle"] = {
		label = "chopped pickle",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "chopped_pickle.png",
		}
	},

	["expensive_champagne"] = {
		label = "Champagne",
		weight = 200,
		stack = true,
		close = true,
		description = "A sparkling wine from France",
		client = {
			image = "expensive_champagne.png",
		}
	},

	["barbera"] = {
		label = "Barbera D'Asti",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 20,
			},
			image = "barbera.png",
		}
	},

	["biscuits_gravy"] = {
		label = "Biscuits Gravy",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "biscuits_gravy.png",
		}
	},

	["georgia_pie"] = {
		label = "Georgia Pie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "georgia_pie.png",
		}
	},

	["red_stone"] = {
		label = "Red Stone",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "red_stone.png",
		}
	},

	["chop_hood"] = {
		label = "Car Hood",
		weight = 2000,
		stack = true,
		close = true,
		description = "A hood from a vehicle",
		client = {
			image = "chop_hood.png",
		}
	},

	["sangria_lemonade"] = {
		label = "Sangria Lemonade",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "sangria_lemonade.png",
		}
	},

	["cocktails_glass"] = {
		label = "Cocktail Glass",
		weight = 500,
		stack = true,
		close = true,
		description = "An Empty Cocktail Glass",
		client = {
			image = "cocktails_glass.png",
		}
	},

	["ps_sprite"] = {
		label = "Sprite",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ps_sprite.png",
		}
	},

	["korean_q_wings"] = {
		label = "Korean Q Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "korean_q_wings.png",
		}
	},

	["skin_whale"] = {
		label = "Whale Skin",
		weight = 7500,
		stack = true,
		close = true,
		description = "Whale skin. Highly illegal",
		client = {
			image = "skin_whale.png",
		}
	},

	["diving_fill"] = {
		label = "Diving Tube",
		weight = 3000,
		stack = false,
		close = true,
		client = {
			image = "diving_tube.png",
		}
	},

	["laptop_blue"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Ramsay",
		client = {
			image = "laptop_blue.png",
		}
	},

	["flusher"] = {
		label = "The Flusher",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "flusher.png",
		}
	},

	["bbobatea"] = {
		label = "Blue Boba Tea",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 49,
			},
			image = "bubbleteablue.png",
		}
	},

	["firework1"] = {
		label = "2Brothers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework1.png",
		}
	},

	["hornbreakfast"] = {
		label = "Horny's Breakfast",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 23,
			},
			image = "bangers.png",
		}
	},

	["original_hot_wings"] = {
		label = "Original Hot Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "original_hot_wings.png",
		}
	},

	["pineapple_seed"] = {
		label = "Pineapple Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of pineapple seeds!",
		client = {
			image = "pineapple_seed.png",
		}
	},

	["worms"] = {
		label = "Worms",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "worms.png",
		}
	},

	["patriotcamo_attachment"] = {
		label = "Patriot Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A patriot camo for a weapon",
		client = {
			image = "patriotcamo_attachment.png",
		}
	},

	["bmenu"] = {
		label = "Bean Machine Menu",
		weight = 100,
		stack = true,
		close = true,
		description = "Menu",
		client = {
			image = "bmenu.png",
		}
	},

	["stretcher"] = {
		label = "Stretcher",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "stretcher.png",
		}
	},

	["bee_hive"] = {
		label = "Bee Hive",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bee_hive.png",
		}
	},

	["ruby_necklace"] = {
		label = "Ruby Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace.png",
		}
	},

	["ruby_ring_silver"] = {
		label = "Ruby Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring_silver.png",
		}
	},

	["pirckly_pear_joint"] = {
		label = "Pirckly Pear Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pirckly_pear_joint.png",
		}
	},

	["heavyarmor"] = {
		label = "Heavy Armor",
		weight = 2000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500,
		}
	},

	["peyote_button"] = {
		label = "Peyote Button",
		weight = 20,
		stack = true,
		close = false,
		description = "A handful of peyote buttons!",
		client = {
			image = "peyote_button.png",
		}
	},

	["pickle"] = {
		label = "Pickle",
		weight = 200,
		stack = true,
		close = true,
		description = "A jar of Pickles",
		client = {
			status = {
				hunger = 44,
			},
			image = "pickle.png",
		}
	},

	["rawsausage"] = {
		label = "Raw Sausages",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rawsausage.png",
		}
	},

	["egg"] = {
		label = "egg",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "egg.png",
		}
	},

	["wing_combo"] = {
		label = "LARGE 10 PC WING COMBO",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "wing_combo.png",
		}
	},

	["gbobatea"] = {
		label = "Green Boba Tea",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 45,
			},
			image = "bubbleteagreen.png",
		}
	},

	["bmochi"] = {
		label = "Blue Mochi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 42,
			},
			image = "mochiblue.png",
		}
	},

	["grouper"] = {
		label = "Grouper",
		weight = 3500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grouper.png",
		}
	},

	["bbanana"] = {
		label = "Banana",
		weight = 100,
		stack = true,
		close = true,
		description = "Banana",
		client = {
			image = "bbanana.png",
		}
	},

	["gelatti"] = {
		label = "Gelatti",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gelatti.png",
		}
	},

	["beer_glass"] = {
		label = "Beer Glass",
		weight = 500,
		stack = true,
		close = true,
		description = "An Empty Beer Glass",
		client = {
			image = "beer_glass.png",
		}
	},

	["xanaxpill"] = {
		label = "Xanax Pill",
		weight = 2,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "xanaxpill.png",
		}
	},

	["printerdocument"] = {
		label = "Document",
		weight = 500,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "printerdocument.png",
		}
	},

	["burgerpatty"] = {
		label = "Burger Patty",
		weight = 500,
		stack = true,
		close = false,
		description = "Raw Patty",
		client = {
			image = "burgerpatty.png",
		}
	},

	["burgerbun"] = {
		label = "Burger Bun",
		weight = 100,
		stack = true,
		close = false,
		description = "Some big burger brother",
		client = {
			image = "burgerbun.png",
		}
	},

	["inkedbills"] = {
		label = "Inked Money Bag",
		weight = 2000,
		stack = true,
		close = false,
		description = "A bag full of inked bills",
		client = {
			image = "inked_cash_bag.png",
		}
	},

	["dblchickenhornburger"] = {
		label = "DBL Chicken HornBurger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "dblchickenburger.png",
		}
	},

	["fentanyl_pills"] = {
		label = "Fentanyl Pills",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fentanyl_pills.png",
		}
	},

	["bananacocktail"] = {
		label = "Banana Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "The Minions made this.",
		client = {
			image = "bananacocktail.png",
		}
	},

	["meat_whale"] = {
		label = "Whale Meat",
		weight = 6000,
		stack = true,
		close = true,
		description = "Whale meat!",
		client = {
			image = "meat_whale.png",
		}
	},

	["opium_joint"] = {
		label = "Opium Joint",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "opium_joint.png",
		}
	},

	["boilermaker"] = {
		label = "Boilermaker",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Shot",
		client = {
			image = "boilermaker.png",
		}
	},

	["win3"] = {
		label = "Limo Window Tint",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "win3.png",
		}
	},

	["casino_psqs"] = {
		label = "Casino Ps & Qs",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Ps & Qs",
		client = {
			image = "casino_psqs.png",
		}
	},

	["icecone"] = {
		label = "Ice Cone",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "cone.png",
		}
	},

	["red_snapper"] = {
		label = "Red Snapper",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "red_snapper.png",
		}
	},

	["spoiler"] = {
		label = "Vehicle Spoiler",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "spoiler.png",
		}
	},

	["bathsalts"] = {
		label = "Bath Salts",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "bathsalts.png",
		}
	},

	["bee_honey"] = {
		label = "Honey",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bee_honey.png",
		}
	},

	["rimjob"] = {
		label = "Rim Job",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Donut",
		client = {
			status = {
				hunger = 48,
			},
			image = "burger_rimjob.png",
		}
	},

	["ergot"] = {
		label = "Ergot",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "ergot.png",
		}
	},

	["xanaxpack"] = {
		label = "Xanax Pack",
		weight = 130,
		stack = true,
		close = true,
		description = "Explore a new universe!",
		client = {
			image = "xanaxpack.png",
		}
	},

	["key_lime_cookie"] = {
		label = "Key Lime Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "key_lime_cookie.png",
		}
	},

	["casino_earrings"] = {
		label = "Casino Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "casino_earrings.png",
		}
	},

	["sake"] = {
		label = "Sake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 40,
			},
			image = "sake.png",
		}
	},

	["chain_triangle"] = {
		label = "Chain Triangle",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_triangle.png",
		}
	},

	["gold_bar"] = {
		label = "Gold Bar",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gold_bar.png",
		}
	},

	["rotisserie_wings"] = {
		label = "Rotisserie Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "rotisserie_wings.png",
		}
	},

	["la_confidential"] = {
		label = "LA Confidential",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "la_confidential.png",
		}
	},

	["cactusfruit_crate"] = {
		label = "Cactus Fruit Crate",
		weight = 3500,
		stack = true,
		close = false,
		description = "A crate of cactus fruits ready for selling!",
		client = {
			image = "cactusfruit_crate.png",
		}
	},

	["steroids"] = {
		label = "steroids",
		weight = 3,
		stack = true,
		close = false,
		description = "A vial of steroids",
		client = {
			image = "steroids.png",
		}
	},

	["enchiladas"] = {
		label = "Breakfast Enchiladas",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "enchi.png",
		}
	},

	["revivekit"] = {
		label = "Revival Kit",
		weight = 3000,
		stack = false,
		close = false,
		description = "When your pal needs that pick me up",
		client = {
			image = "revivekit.png",
		}
	},

	["w_tango_apple"] = {
		label = "Tango Apple",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_tango_apple.png",
		}
	},

	["patron_margarita"] = {
		label = "Patron Margarita",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "patron_margarita.png",
		}
	},

	["pmochi"] = {
		label = "Pink Mochi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 50,
			},
			image = "mochipink.png",
		}
	},

	["crunchytaco"] = {
		label = "Crunchy Taco",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "crunchytaco.png",
		}
	},

	["alla"] = {
		label = "Alla Vodka",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 21,
			},
			image = "alla.png",
		}
	},

	["asic_miner_hashing_board"] = {
		label = "asic miner hashing board",
		weight = 100,
		stack = true,
		close = true,
		description = "Specialized board used in ASIC mining devices to perform hashing calculations necessary for cryptocurrency mining.",
		client = {
			image = "HashingBoard.png",
		}
	},

	["dolceto"] = {
		label = "Dolcetto D'Alba",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 29,
			},
			image = "dolceto.png",
		}
	},

	["skirts"] = {
		label = "Vehicle Skirts",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "skirts.png",
		}
	},

	["rhinohorn"] = {
		label = "Rhino Horn",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rhinohorn.png",
		}
	},

	["noscolour"] = {
		label = "NOS Colour Injector",
		weight = 0,
		stack = true,
		close = true,
		description = "Make that purge spray",
		client = {
			image = "noscolour.png",
		}
	},

	["watermelonslice"] = {
		label = "Watermelon Slice",
		weight = 200,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "watermelonslice.png",
		}
	},

	["caipirinha"] = {
		label = "Caipirinha",
		weight = 30,
		stack = true,
		close = true,
		description = "Alcoholic Drink",
		client = {
			image = "caipirinha.png",
		}
	},

	["bm_mimosa"] = {
		label = "Mimosa",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Mimosa Cocktail!",
		client = {
			image = "bm_mimosa.png",
		}
	},

	["cheese_quesadilla"] = {
		label = "Cheese Quesadilla",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "cheese_quesadilla.png",
		}
	},

	["drillbit"] = {
		label = "Drill Bit",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drillbit.png",
		}
	},

	["casino_coke"] = {
		label = "Casino Kofola",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Kofola",
		client = {
			image = "casino_coke.png",
		}
	},

	["binoculars"] = {
		label = "Binoculars",
		weight = 600,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "binoculars.png",
		}
	},

	["bespresso"] = {
		label = "Espresso",
		weight = 100,
		stack = true,
		close = true,
		description = "Espresso",
		client = {
			image = "bespresso.png",
		}
	},

	["orange_crate"] = {
		label = "Orange Crate",
		weight = 3500,
		stack = true,
		close = false,
		description = "A crate of oranges ready for selling!",
		client = {
			image = "orange_crate.png",
		}
	},

	["ruby"] = {
		label = "Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A Ruby that shimmers",
		client = {
			image = "ruby.png",
		}
	},

	["fried_fries"] = {
		label = "fried fries",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fried_fries.png",
		}
	},

	["bodybandage"] = {
		label = "Body Bandage",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "bodybandage.png",
		}
	},

	["molly_tablet"] = {
		label = "Molly Tablet",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "molly_tablet.png",
		}
	},

	["security_card_02"] = {
		label = "Security Card B",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_02.png",
		}
	},

	["tunerlaptop"] = {
		label = "Tunerchip",
		weight = 2000,
		stack = false,
		close = true,
		description = "With this tunerchip you can get your car on steroids... If you know what you're doing",
		client = {
			image = "tunerchip.png",
		}
	},

	["diamond_earring_silver"] = {
		label = "Diamond Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring_silver.png",
		}
	},

	["brushcamo_attachment"] = {
		label = "Brushstroke Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A brushstroke camo for a weapon",
		client = {
			image = "brushcamo_attachment.png",
		}
	},

	["firstaid"] = {
		label = "First Aid",
		weight = 1000,
		stack = true,
		close = true,
		description = "You can use this First Aid kit to get people back on their feet",
		client = {
			image = "firstaid.png",
		}
	},

	["aluminum"] = {
		label = "Aluminium",
		weight = 0,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "aluminum.png",
		}
	},

	["vegetarianabox"] = {
		label = "Boxed Vegetariana",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["covgari_gold"] = {
		label = "Covgari Gold",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "covgari_gold.png",
		}
	},

	["angeldust"] = {
		label = "Angel Dust",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "angeldust.png",
		}
	},

	["cake"] = {
		label = "Strawberry Cake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 45,
			},
			image = "cake.png",
		}
	},

	["empty_pill_bottle"] = {
		label = "Empty Pill Bottle",
		weight = 2,
		stack = true,
		close = false,
		description = "An empty pill bottle",
		client = {
			image = "empty_pill_bottle.png",
		}
	},

	["keepcompanionpoodle"] = {
		label = "Poodle",
		weight = 500,
		stack = false,
		close = true,
		description = "Poodle is your royal companion!",
		client = {
			image = "A_C_Poodle.png",
		}
	},

	["side_of_flavor"] = {
		label = "SIDE OF FLAVOR",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "side_of_flavor.png",
		}
	},

	["gold_ring"] = {
		label = "Gold Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_ring.png",
		}
	},

	["sessantacamo_attachment"] = {
		label = "Sessanta Nove Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A sessanta nove camo for a weapon",
		client = {
			image = "sessantacamo_attachment.png",
		}
	},

	["nos"] = {
		label = "NOS Bottle",
		weight = 0,
		stack = false,
		close = true,
		description = "A full bottle of NOS",
		client = {
			image = "nos.png",
		}
	},

	["mdspeakers"] = {
		label = "Speakers",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "speaker.png",
		}
	},

	["chocolate_chunk_brownie"] = {
		label = "TRIPLE CHOCOLATE CHUNK BROWNIE",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chocolate_chunk_brownie.png",
		}
	},

	["pomegranate_mimosa"] = {
		label = "Pomegranate Mimosa",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pomegranate_mimosa.png",
		}
	},

	["gatecrack"] = {
		label = "Gatecrack",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences",
		client = {
			image = "usb_device.png",
		}
	},

	["markedbills"] = {
		label = "Marked Money",
		weight = 1000,
		stack = true,
		close = true,
		description = "Money?",
		client = {
			image = "markedbills.png",
		}
	},

	["crispy_tender_combo"] = {
		label = "LARGE 5 PC CRISPY TENDER COMBO",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crispy_tender_combo.png",
		}
	},

	["package"] = {
		label = "Suspicious Package",
		weight = 10000,
		stack = false,
		close = false,
		description = "A mysterious package.. Scary!",
		client = {
			image = "package.png",
		}
	},

	["sponge"] = {
		label = "sponge",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sponge.png",
		}
	},

	["buffalo_ranch_fries"] = {
		label = "BUFFALO RANCH FRIES",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "buffalo_ranch_fries.png",
		}
	},

	["lean_bottle"] = {
		label = "Lean Bottle",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "lean_bottle.png",
		}
	},

	["sparkplugs"] = {
		label = "Spark Plugs",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sparkplugs.png",
		}
	},

	["bleachwipes"] = {
		label = "Bleach Wipes",
		weight = 25,
		stack = true,
		close = true,
		description = "To clean and sanatize",
		client = {
			image = "bleachwipes.png",
		}
	},

	["t_diet_pepsi"] = {
		label = "Diet Pepsi",
		weight = 500,
		stack = true,
		close = true,
		description = "Drink.",
		client = {
			image = "t_diet_pepsi.png",
		}
	},

	["w_diet_pepsi"] = {
		label = "Det Pepsi",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_diet_pepsi.png",
		}
	},

	["acid"] = {
		label = "acid",
		weight = 5,
		stack = true,
		close = false,
		description = "A bottle of acid",
		client = {
			image = "acid.png",
		}
	},

	["zushi"] = {
		label = "Zushi",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "zushi.png",
		}
	},

	["spicy_chicken_burrito"] = {
		label = "Spicy Chicken Burrito",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "spicy_chicken_burrito.png",
		}
	},

	["skin_pig"] = {
		label = "Pig Skin",
		weight = 850,
		stack = true,
		close = true,
		description = "Pig skin.",
		client = {
			image = "skin_pig.png",
		}
	},

	["cola"] = {
		label = "Cola",
		weight = 100,
		stack = true,
		close = true,
		description = "🥤✨ A refreshing cola to quench your thirst. 🌟🍽️",
		client = {
			image = "cola.png",
		}
	},

	["engine3"] = {
		label = "Tier 3 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine3.png",
		}
	},

	["housered"] = {
		label = "House Red Wine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 20,
			},
			image = "housered.png",
		}
	},

	["meat_rat"] = {
		label = "Rat Meat",
		weight = 200,
		stack = true,
		close = true,
		description = "Rat meat!",
		client = {
			image = "meat_rat.png",
		}
	},

	["catfish"] = {
		label = "Catfish",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "catfish.png",
		}
	},

	["suspension2"] = {
		label = "Tier 2 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension2.png",
		}
	},

	["externals"] = {
		label = "Exterior Cosmetics",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "mirror.png",
		}
	},

	["hexdia_earrings"] = {
		label = "HexDia Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "hexdia_earrings.png",
		}
	},

	["engine5"] = {
		label = "Tier 5 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine5.png",
		}
	},

	["silverearring"] = {
		label = "Silver Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_earring.png",
		}
	},

	["susp3"] = {
		label = "Suspension Lvl. 3",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "susp3.png",
		}
	},

	["lean"] = {
		label = "Lean",
		weight = 5,
		stack = true,
		close = false,
		description = "Slurp",
		client = {
			image = "lean.png",
		}
	},

	["nekolatte"] = {
		label = "Neko Latte",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 30,
			},
			image = "latte.png",
		}
	},

	["bee_wax"] = {
		label = "Wax",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bee_wax.png",
		}
	},

	["pescatore"] = {
		label = "Pescatore",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "pescatore.png",
		}
	},

	["bm_jelloshot"] = {
		label = "Jello Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Jello Shot!",
		client = {
			image = "bm_jelloshot.png",
		}
	},

	["mddesktop"] = {
		label = "Desktop",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mddesktop.png",
		}
	},

	["pogo"] = {
		label = "Pogo",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pogo.png",
		}
	},

	["peyote_seed"] = {
		label = "Peyote Seed",
		weight = 1,
		stack = true,
		close = false,
		description = "A handful of peyote seeds!",
		client = {
			image = "peyote_seed.png",
		}
	},

	["gourmet_double_burger"] = {
		label = "Gourmet Double Burger",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gourmet_double_burger.png",
		}
	},

	["arm3"] = {
		label = "Armor Lvl. 3",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "arm3.png",
		}
	},

	["rawbacon"] = {
		label = "Raw Bacon",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rawbacon.png",
		}
	},

	["gmochi"] = {
		label = "Green Mochi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 49,
			},
			image = "mochigreen.png",
		}
	},

	["bm_pinacolada"] = {
		label = "Pina Colada",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Pina Colada!",
		client = {
			image = "bm_pinacolada.png",
		}
	},

	["maize"] = {
		label = "Maize",
		weight = 100,
		stack = true,
		close = false,
		description = "Maize!",
		client = {
			image = "maize.png",
		}
	},

	["wheelchair"] = {
		label = "Wheelchair",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "wheelchair.png",
		}
	},

	["w_medium_sprite"] = {
		label = "Medium Sprite",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "w_medium_sprite.png",
		}
	},

	["gummy_white_widow_cbd"] = {
		label = "CBD White_Widow Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd white widow gummy bear!",
		client = {
			image = "gummy_white_widow_cbd.png",
		}
	},

	["glue"] = {
		label = "Glue",
		weight = 30,
		stack = true,
		close = false,
		description = "Good for repairing things!",
		client = {
			image = "glue.png",
		}
	},

	["meat_pig"] = {
		label = "Pork Meat",
		weight = 750,
		stack = true,
		close = true,
		description = "Pig meat!",
		client = {
			image = "meat_pig.png",
		}
	},

	["shotrings"] = {
		label = "Ring Shots",
		weight = 200,
		stack = true,
		close = true,
		description = "Burgershot Onion Rings",
		client = {
			status = {
				hunger = 43,
			},
			image = "burger_shotrings.png",
		}
	},

	["handcuff_key"] = {
		label = "Handcuff Key",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "handcuff_key.png",
		}
	},

	["geocamo_attachment"] = {
		label = "Geometric Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A geometric camo for a weapon",
		client = {
			image = "geocamo_attachment.png",
		}
	},

	["meat_dolphin"] = {
		label = "Dolphin Meat",
		weight = 850,
		stack = true,
		close = true,
		description = "Dolphin meat!",
		client = {
			image = "meat_dolphin.png",
		}
	},

	["pinger"] = {
		label = "Pinger",
		weight = 1000,
		stack = true,
		close = true,
		description = "With a pinger and your phone you can send out your location",
		client = {
			image = "pinger.png",
		}
	},

	["medicinebox"] = {
		label = "Medicine Box",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "medicinebox.png",
		}
	},

	["boomcamo_attachment"] = {
		label = "Boom Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A boom camo for a weapon",
		client = {
			image = "boomcamo_attachment.png",
		}
	},

	["ducttape"] = {
		label = "Duct Tape",
		weight = 0,
		stack = false,
		close = true,
		description = "Good for quick fixes",
		client = {
			image = "bodyrepair.png",
		}
	},

	["hammer"] = {
		label = "Hammer",
		weight = 500,
		stack = true,
		close = false,
		description = "Good for smashing things!",
		client = {
			image = "hammer.png",
		}
	},

	["gummy_amnesia_cbd"] = {
		label = "CBD Amnesia Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd og kush gummy bear!",
		client = {
			image = "gummy_amnesia_cbd.png",
		}
	},

	["goldore"] = {
		label = "Gold Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Gold Ore",
		client = {
			image = "goldore.png",
		}
	},

	["potato_sack"] = {
		label = "Potato Sack",
		weight = 5000,
		stack = true,
		close = false,
		description = "A sack of potatoes ready for selling!",
		client = {
			image = "potato_sack.png",
		}
	},

	["cake_mix"] = {
		label = "Cake Mix",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cake_mix.png",
		}
	},

	["coke_figurebroken"] = {
		label = "Pieces of Action Figure",
		weight = 100,
		stack = true,
		close = false,
		description = "You can throw this away or try to repair with glue",
		client = {
			image = "coke_figurebroken.png",
		}
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1000,
		stack = true,
		close = true,
		description = "A diamond seems like the jackpot to me!",
		client = {
			image = "diamond.png",
		}
	},

	["tree_lumber"] = {
		label = "Lumber",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lumber.png",
		}
	},

	["newscam"] = {
		label = "News Camera",
		weight = 100,
		stack = false,
		close = true,
		description = "A camera for the news",
		client = {
			image = "newscam.png",
		}
	},

	["twerks_candy"] = {
		label = "Twerks",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "twerks_candy.png",
		}
	},

	["rosso"] = {
		label = "Rosso Del Montalcino",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 23,
			},
			image = "rosso.png",
		}
	},

	["meth_syringe"] = {
		label = "Syringe",
		weight = 320,
		stack = true,
		close = false,
		description = "Enjoy your new crystal clear stuff!",
		client = {
			image = "meth_syringe.png",
		}
	},

	["jefe_joint"] = {
		label = "Jefe Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "jefe_joint.png",
		}
	},

	["smallscope_attachment"] = {
		label = "Small Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A small scope for a weapon",
		client = {
			image = "smallscope_attachment.png",
		}
	},

	["miner_pcb"] = {
		label = "Circuit Board for Miner",
		weight = 100,
		stack = true,
		close = true,
		description = "This board is fundamental in cryptocurrency mining devices and is responsible for coordinating the calculations necessary for mining.",
		client = {
			image = "PCB.png",
		}
	},

	["meat_stingray"] = {
		label = "Stingray Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Stingray meat!",
		client = {
			image = "meat_stingray.png",
		}
	},

	["chalupa_supreme"] = {
		label = "Chalupa Supreme",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "chalupa_supreme.png",
		}
	},

	["tahoe_og_joint"] = {
		label = "Tahoe OG Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "tahoe_og_joint.png",
		}
	},

	["suspension1"] = {
		label = "Tier 1 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension1.png",
		}
	},

	["drug_shears"] = {
		label = "Trimming Shears",
		weight = 200,
		stack = true,
		close = true,
		description = "A set of high quality trimming shears.",
		client = {
			image = "drug_shears.png",
		}
	},

	["stone"] = {
		label = "Stone",
		weight = 2000,
		stack = true,
		close = false,
		description = "Stone woo",
		client = {
			image = "stone.png",
		}
	},

	["marathon_joint"] = {
		label = "Marathon Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "marathon_joint.png",
		}
	},

	["egg_crate"] = {
		label = "Egg Crate",
		weight = 2500,
		stack = true,
		close = false,
		description = "A crate of eggs ready for selling!",
		client = {
			image = "egg_crate.png",
		}
	},

	["heroin_shot"] = {
		label = "Heroin Shot",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "heroin_shot.png",
		}
	},

	["grip_attachment"] = {
		label = "Grip",
		weight = 1000,
		stack = true,
		close = true,
		description = "A grip for a weapon",
		client = {
			image = "grip_attachment.png",
		}
	},

	["pisswasser"] = {
		label = "Pißwasser",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 44,
			},
			image = "pisswaser1.png",
		}
	},

	["bahama_rum"] = {
		label = "Rum",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_rum.png",
		}
	},

	["gunkaccino"] = {
		label = "The Gunkaccino",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "gunkaccino.png",
		}
	},

	["flush_cutter"] = {
		label = "Flush Cutter",
		weight = 50,
		stack = true,
		close = true,
		description = "Comes in handy when you want to cut zipties..",
		client = {
			image = "flush_cutter.png",
		}
	},

	["skin_stingray"] = {
		label = "Stingray Skin",
		weight = 850,
		stack = true,
		close = true,
		description = "Stingray skin. Highly illegal!",
		client = {
			image = "skin_stingray.png",
		}
	},

	["susp2"] = {
		label = "Suspension Lvl. 2",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "susp2.png",
		}
	},

	["inked_cash_bag"] = {
		label = "Gruppe 6 Inked Cash Bag",
		weight = 1000,
		stack = true,
		close = false,
		description = "Bag full of useless inked cash.",
		client = {
			image = "inked_cash_bag.png",
		}
	},

	["karaoke_earrings"] = {
		label = "Karaoke Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "karaoke_earrings.png",
		}
	},

	["bahama_chips"] = {
		label = "Tortilla Chips",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_chips.png",
		}
	},

	["art2"] = {
		label = "Wide Eye Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art2.png",
		}
	},

	["firework2"] = {
		label = "Poppelers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework2.png",
		}
	},

	["watering_can_full"] = {
		label = "Full Watering Can",
		weight = 500,
		stack = true,
		close = false,
		description = "A watering can full of water!",
		client = {
			image = "watering_can_full.png",
		}
	},

	["emptymilkbottle"] = {
		label = "Empty Milk Bottle",
		weight = 100,
		stack = true,
		close = false,
		description = "A empty milk bottle!",
		client = {
			image = "emptymilkbottle.png",
		}
	},

	["bento"] = {
		label = "Bento Box",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 49,
			},
			image = "bento.png",
		}
	},

	["weedlicense"] = {
		label = "WEED LICENSE",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "weedlicense.png",
		}
	},

	["mojito"] = {
		label = "Mojito",
		weight = 30,
		stack = true,
		close = true,
		description = "Alcoholic Drink",
		client = {
			image = "mojito.png",
		}
	},

	["xenonsvert"] = {
		label = "Green Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsvert.png",
		}
	},

	["bahama_jello"] = {
		label = "Jello Mix",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_jello.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Evidence Bag",
		weight = 200,
		stack = false,
		close = true,
		description = "A filled evidence bag to see who committed the crime >:(",
		client = {
			image = "evidence.png",
		}
	},

	["diagold_earrings"] = {
		label = "Diagold Earrings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "diagold_earrings.png",
		}
	},

	["shroom_pooch"] = {
		label = "Shroom Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shroom_pooch.png",
		}
	},

	["uncut_diamond"] = {
		label = "Uncut Diamond",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Diamond",
		client = {
			image = "uncut_diamond.png",
		}
	},

	["classic_wings_combo"] = {
		label = "CLASSIC WINGS COMBO",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "classic_wings_combo.png",
		}
	},

	["bahama_ccheese"] = {
		label = "Cream Cheese",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_ccheese.png",
		}
	},

	["bratte"] = {
		label = "The Bratte",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 24,
			},
			image = "bratte.png",
		}
	},

	["bjavachipfrappuccino"] = {
		label = "Java Chip Frappuccino",
		weight = 100,
		stack = true,
		close = true,
		description = "Java Chip Frappuccino",
		client = {
			image = "bjavachipfrappuccino.png",
		}
	},

	["margarita"] = {
		label = "Margarita",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Beverage",
		client = {
			image = "margarita.png",
		}
	},

	["ecstasy5"] = {
		label = "Ectasy",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "ecstasy5.png",
		}
	},

	["vodka_shot"] = {
		label = "Vodka Shot",
		weight = 500,
		stack = true,
		close = true,
		description = "A Strong Shot",
		client = {
			image = "vodka_shot.png",
		}
	},

	["bm_cosmopolitan"] = {
		label = "Cosmopolitan",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Cosmopolitan!",
		client = {
			image = "bm_cosmopolitan.png",
		}
	},

	["okokphone"] = {
		label = "Phone",
		weight = 50,
		stack = false,
		close = true,
		description = "A smartphone",
		client = {
			image = "phone.png",
		}
	},

	["laptop_green"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "laptop_green.png",
		}
	},

	["shroom_cut"] = {
		label = "Shroom Cut",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shroom_cut.png",
		}
	},

	["cooked_chicken_breasts"] = {
		label = "cooked chicken breasts",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "cooked_chicken_breasts.png",
		}
	},

	["bstrawberrycreamfrappuccino"] = {
		label = "Strawberry Cream Frappuccino",
		weight = 100,
		stack = true,
		close = true,
		description = "Strawberry Cream Frappuccino",
		client = {
			image = "bstrawberrycreamfrappuccino.png",
		}
	},

	["jefe"] = {
		label = "Jefe",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "jefe.png",
		}
	},

	["ice_cream_cake_pack_joint"] = {
		label = "Ice Cream Cake Pack Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ice_cream_cake_pack_joint.png",
		}
	},

	["laundrycard"] = {
		label = "Laundry Card",
		weight = 100,
		stack = true,
		close = true,
		description = "A Laundry Card",
		client = {
			image = "laundrycard.png",
		}
	},

	["saline"] = {
		label = "Saline",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "saline.png",
		}
	},

	["sparetire"] = {
		label = "Spare Tire",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sparetire.png",
		}
	},

	["kronos_black"] = {
		label = "Kronos Black",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "kronos_black.png",
		}
	},

	["heroin"] = {
		label = "heroin",
		weight = 5,
		stack = true,
		close = false,
		description = "A bag of heroin",
		client = {
			image = "heroin.png",
		}
	},

	["zebracamo_attachment"] = {
		label = "Zebra Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A zebra camo for a weapon",
		client = {
			image = "zebracamo_attachment.png",
		}
	},

	["win2"] = {
		label = "Dark Smoke Window Tint",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "win2.png",
		}
	},

	["cucumber"] = {
		label = "cucumber",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "cucumber.png",
		}
	},

	["yachtcodes"] = {
		label = "Yacht Access Codes",
		weight = 200,
		stack = false,
		close = true,
		description = "The first half of codes for the Yacht",
		client = {
			image = "yachtcodes.png",
		}
	},

	["boneless_wings"] = {
		label = "BONELESS WINGS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "boneless_wings.png",
		}
	},

	["meat_deer"] = {
		label = "Venison",
		weight = 850,
		stack = true,
		close = true,
		description = "Deer meat!",
		client = {
			image = "meat_deer.png",
		}
	},

	["leo_gps"] = {
		label = "LEO GPS",
		weight = 2000,
		stack = false,
		close = true,
		description = "Show your gps location to others",
		client = {
			image = "leo_gps.png",
		}
	},

	["tripleburger"] = {
		label = "The Triple Burger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "tripleburger.png",
		}
	},

	["coke_pure"] = {
		label = "Pure Coke",
		weight = 70,
		stack = true,
		close = true,
		description = "Coke without any dirty particles",
		client = {
			image = "coke_pure.png",
		}
	},

	["sludgie_ice_blue"] = {
		label = "sludgie ice blue",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sludgie_ice_blue.png",
		}
	},

	["boostingtab"] = {
		label = "Boosting Tablet",
		weight = 800.0,
		stack = true,
		close = true,
		client = {
			image = "boostingtab.png",
		}
	},

	["blue_tomyz"] = {
		label = "Blue Tomyz",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "blue_tomyz.png",
		}
	},

	["chicken_caesar_salad"] = {
		label = "Chicken Caesar Salad",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chicken_caesar_salad.png",
		}
	},

	["peyote"] = {
		label = "Peyote",
		weight = 30,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "peyote.png",
		}
	},

	["plastic_wrap"] = {
		label = "Plastic Wrap",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "plastic_wrap.png",
		}
	},

	["mechboard"] = {
		label = "Mechanic Sheet",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "mechboard.png",
		}
	},

	["bahama_pineapple"] = {
		label = "Pineapple",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_pineapple.png",
		}
	},

	["bcloudcafe"] = {
		label = "Cloud Cafe",
		weight = 100,
		stack = true,
		close = true,
		description = "Cloud Cafe",
		client = {
			image = "bcloudcafe.png",
		}
	},

	["drives3"] = {
		label = "Tier 3 Drive Shaft",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "drives3.png",
		}
	},

	["watermelon"] = {
		label = "Watermelon",
		weight = 1000,
		stack = true,
		close = true,
		description = "a sliceable watermelon!",
		client = {
			image = "watermelon.png",
		}
	},

	["antipatharia_coral"] = {
		label = "Antipatharia",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as black corals or thorn corals",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["bhoneyhazelnutoatlatte"] = {
		label = "Honey Hazelnut Oat Latte",
		weight = 100,
		stack = true,
		close = true,
		description = "Honey Hazelnut Oat Latte",
		client = {
			image = "bhoneyhazelnutoatlatte.png",
		}
	},

	["horn"] = {
		label = "Custom Vehicle Horn",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "horn.png",
		}
	},

	["lettuce_crate"] = {
		label = "Lettuce Crate",
		weight = 3500,
		stack = true,
		close = false,
		description = "A crate of lettuce ready for selling!",
		client = {
			image = "lettuce_crate.png",
		}
	},

	["gelatti_joint"] = {
		label = "Gelatti Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "gelatti_joint.png",
		}
	},

	["barrel_attachment"] = {
		label = "Barrel",
		weight = 1000,
		stack = true,
		close = true,
		description = "A barrel for a weapon",
		client = {
			image = "barrel_attachment.png",
		}
	},

	["bahama_rawchik"] = {
		label = "Raw Chicken",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_rawchik.png",
		}
	},

	["sour_diesel_joint"] = {
		label = "Sour Diesel Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "sour_diesel_joint.png",
		}
	},

	["emptycrate"] = {
		label = "Crate",
		weight = 100,
		stack = true,
		close = false,
		description = "A empty crate for storing things!",
		client = {
			image = "emptycrate.png",
		}
	},

	["antminers9"] = {
		label = "AntminerS9",
		weight = 100,
		stack = true,
		close = true,
		description = "Cryptocurrency mining device designed and manufactured by the Bitmain company.",
		client = {
			image = "antminers9.png",
		}
	},

	["drang_o_tang"] = {
		label = "drang o tang",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drang_o_tang.png",
		}
	},

	["purrito"] = {
		label = "Purrito",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 40,
			},
			image = "purrito.png",
		}
	},

	["backwoods_grape"] = {
		label = "Backwoods Grape",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "backwoods_grape.png",
		}
	},

	["froties"] = {
		label = "Froties",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "froties.png",
		}
	},

	["shroom"] = {
		label = "Shroom",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "shroom.png",
		}
	},

	["spice_pooch"] = {
		label = "Spice Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "spice_pooch.png",
		}
	},

	["rubber"] = {
		label = "Rubber",
		weight = 0,
		stack = true,
		close = false,
		description = "Rubber, I believe you can make your own rubber ducky with it :D",
		client = {
			image = "rubber.png",
		}
	},

	["gummy_gelato_cbd"] = {
		label = "CBD Gelato Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd gelato gummy bear!",
		client = {
			image = "gummy_gelato_cbd.png",
		}
	},

	["pizzmushrooms"] = {
		label = "Mushrooms",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mushrooms.png",
		}
	},

	["tiramisu"] = {
		label = "Tiramisu",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "tiramisu.png",
		}
	},

	["sapphire_earring"] = {
		label = "Sapphire Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring.png",
		}
	},

	["shrimp_alfredo"] = {
		label = "Shrimp Alfredo",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shrimp_alfredo.png",
		}
	},

	["skin_mtlion"] = {
		label = "Mt Lion Hide",
		weight = 1050,
		stack = true,
		close = true,
		description = "Mt. Lion hide. Highly illegal!",
		client = {
			image = "skin_mtlion.png",
		}
	},

	["flat_muzzle_brake"] = {
		label = "Flat Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "flat_muzzle_brake.png",
		}
	},

	["underglow"] = {
		label = "Underglow LEDS",
		weight = 0,
		stack = false,
		close = true,
		description = "Underglow addition for vehicles",
		client = {
			image = "underglow.png",
		}
	},

	["id_card"] = {
		label = "ID Card",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
		client = {
			image = "id_card.png",
		}
	},

	["police_stormram"] = {
		label = "Stormram",
		weight = 10000,
		stack = true,
		close = true,
		description = "A nice tool to break into doors",
		client = {
			image = "police_stormram.png",
		}
	},

	["moon_rock"] = {
		label = "Moon Rock",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "moon_rock.png",
		}
	},

	["bank_card"] = {
		label = "Bank Card",
		weight = 0,
		stack = false,
		close = true,
		description = "Used to access ATM",
		client = {
			image = "bank_card.png",
		}
	},

	["copperore"] = {
		label = "Copper Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Copper, a base ore.",
		client = {
			image = "copperore.png",
		}
	},

	["crowex_black"] = {
		label = "Crowex Black",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crowex_black.png",
		}
	},

	["bluelagoon"] = {
		label = "Blue Lagoon",
		weight = 30,
		stack = true,
		close = true,
		description = "Alcoholic Drink",
		client = {
			image = "bluelagoon.png",
		}
	},

	["asain_zest_wings"] = {
		label = "Asain Zest Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "asain_zest_wings.png",
		}
	},

	["coke_rail"] = {
		label = "Coke Rail",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "coke_rail.png",
		}
	},

	["crispy_tenders"] = {
		label = "8 PC MEAL FOR 2 CRISPY TENDERS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crispy_tenders.png",
		}
	},

	["rollcage"] = {
		label = "Roll Cage",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "rollcage.png",
		}
	},

	["marathon"] = {
		label = "Marathon",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "marathon.png",
		}
	},

	["lemon"] = {
		label = "Lemon",
		weight = 1000,
		stack = true,
		close = true,
		description = "an ingredient!",
		client = {
			image = "lemon.png",
		}
	},

	["sour_diesel"] = {
		label = "Sour Diesel",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "sour_diesel.png",
		}
	},

	["samsungphone"] = {
		label = "Samsung S10",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "samsungphone.png",
		}
	},

	["crab_cakes"] = {
		label = "Crab Cakes",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crab_cakes.png",
		}
	},

	["ether_joint"] = {
		label = "Ether Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ether_joint.png",
		}
	},

	["thermite"] = {
		label = "Thermite",
		weight = 1000,
		stack = true,
		close = true,
		description = "Sometimes you'd wish for everything to burn",
		client = {
			image = "thermite.png",
		}
	},

	["xenonsgold"] = {
		label = "Gold Xenons",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsgold.png",
		}
	},

	["salmon"] = {
		label = "Salmon",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "salmon.png",
		}
	},

	["collins_ave_joint"] = {
		label = "Collins AVE Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "collins_ave_joint.png",
		}
	},

	["silveringot"] = {
		label = "Silver Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silveringot.png",
		}
	},

	["transmission2"] = {
		label = "Tier 2 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission2.png",
		}
	},

	["security_card_oil"] = {
		label = "Pink USB Dongle",
		weight = 500,
		stack = false,
		close = true,
		description = "This has got to be some important information...",
		client = {
			image = "security_card_oil.png",
		}
	},

	["meth"] = {
		label = "meth",
		weight = 5,
		stack = true,
		close = false,
		description = "A bag of meth",
		client = {
			image = "methpouch.png",
		}
	},

	["chain_m"] = {
		label = "Chain M",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_m.png",
		}
	},

	["bespressocoffeecup"] = {
		label = "Espresso Coffee Cup",
		weight = 100,
		stack = true,
		close = true,
		description = "Espresso Coffee Cup",
		client = {
			image = "bespressocoffeecup.png",
		}
	},

	["platinum_bar"] = {
		label = "Platinum Bar",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "platinum_bar.png",
		}
	},

	["lsd5"] = {
		label = "LSD",
		weight = 10,
		stack = true,
		close = false,
		description = "Explore a new universe!",
		client = {
			image = "lsd5.png",
		}
	},

	["kiwicocktail"] = {
		label = "Kiwi Cocktail",
		weight = 1000,
		stack = true,
		close = true,
		description = "Kiwi.",
		client = {
			image = "kiwicocktail.png",
		}
	},

	["obobatea"] = {
		label = "Orange Boba Tea",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 47,
			},
			image = "bubbleteaorange.png",
		}
	},

	["trans3"] = {
		label = "Transmission Lvl. 3",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "trans3.png",
		}
	},

	["split_end_muzzle_brake"] = {
		label = "Split End Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "split_end_muzzle_brake.png",
		}
	},

	["meat_free_burger"] = {
		label = "meat free burger",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "meat_free_burger.png",
		}
	},

	["thermalscope_attachment"] = {
		label = "Thermal Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A thermal scope for a weapon",
		client = {
			image = "thermalscope_attachment.png",
		}
	},

	["sapphire_necklace_silver"] = {
		label = "Sapphire Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace_silver.png",
		}
	},

	["pisswasser2"] = {
		label = "Pißwasser Stout",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 45,
			},
			image = "pisswaser2.png",
		}
	},

	["lawyerpass"] = {
		label = "Lawyer Pass",
		weight = 0,
		stack = false,
		close = false,
		description = "Pass exclusive to lawyers to show they can represent a suspect",
		client = {
			image = "lawyerpass.png",
		}
	},

	["chain_is"] = {
		label = "Chain IS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_is.png",
		}
	},

	["creamyshake"] = {
		label = "Extra Creamy Jumbo Shake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 24,
			},
			image = "atomshake.png",
		}
	},

	["roof"] = {
		label = "Vehicle Roof",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "roof.png",
		}
	},

	["raine"] = {
		label = "Raine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 24,
			},
			image = "raine.png",
		}
	},

	["pirckly_pear"] = {
		label = "Pirckly Pear",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pirckly_pear.png",
		}
	},

	["cooked_patty"] = {
		label = "cooked patty",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "cooked_patty.png",
		}
	},

	["pbobatea"] = {
		label = "Pink Boba Tea",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 48,
			},
			image = "bubbleteapink.png",
		}
	},

	["cream"] = {
		label = "Cream",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cream.png",
		}
	},

	["burgermeat"] = {
		label = "Burger Meat",
		weight = 500,
		stack = true,
		close = false,
		description = "Cooked Burger Meat",
		client = {
			image = "burgermeat.png",
		}
	},

	["sheriffid"] = {
		label = "SHERIFF ID",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "sheriffid.png",
		}
	},

	["cereal_milk_joint"] = {
		label = "Cereal Milk Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cereal_milk_joint.png",
		}
	},

	["emsid"] = {
		label = "PARAMEDIC",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "emsid.png",
		}
	},

	["milk_crate"] = {
		label = "Milk Crate",
		weight = 5500,
		stack = true,
		close = false,
		description = "A crate of milk bottles ready for selling!",
		client = {
			image = "milk_crate.png",
		}
	},

	["underglow_controller"] = {
		label = "Neon Controller",
		weight = 0,
		stack = true,
		close = true,
		description = "RGB LED Vehicle Remote",
		client = {
			image = "underglow_controller.png",
		}
	},

	["sweat_tea_sangria"] = {
		label = "Sweat Tea Sangria",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "sweat_tea_sangria.png",
		}
	},

	["ecolalight"] = {
		label = "eCola Light",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 24,
			},
			image = "ecolalight.png",
		}
	},

	["bm_daiquiri"] = {
		label = "Daiquiri",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Daiquiri!",
		client = {
			image = "bm_daiquiri.png",
		}
	},

	["meat_shark"] = {
		label = "Shark Meat",
		weight = 1200,
		stack = true,
		close = true,
		description = "Shark meat!",
		client = {
			image = "meat_shark.png",
		}
	},

	["burger_torpedo"] = {
		label = "Torpedo",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Torpedo",
		client = {
			status = {
				hunger = 47,
			},
			image = "burger_torpedo.png",
		}
	},

	["steak_and_lobster_meal"] = {
		label = "Steak & Lobster Meal",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "steak_and_lobster_meal.png",
		}
	},

	["chickenwrap"] = {
		label = "BS Goat Cheese Wrap",
		weight = 150,
		stack = true,
		close = true,
		description = "BurgerShot Goat Cheese Wrap",
		client = {
			status = {
				hunger = 41,
			},
			image = "burger_goatwrap.png",
		}
	},

	["trout"] = {
		label = "Trout",
		weight = 750,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "trout.png",
		}
	},

	["pearl"] = {
		label = "Pearl",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pearl.png",
		}
	},

	["capricciosabox"] = {
		label = "Boxed Capriccosa",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["sandwich_bread"] = {
		label = "sandwich bread",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sandwich_bread.png",
		}
	},

	["harness"] = {
		label = "Race Harness",
		weight = 1000,
		stack = false,
		close = true,
		description = "Racing Harness so no matter what you stay in the car",
		client = {
			image = "harness.png",
		}
	},

	["molly"] = {
		label = "Molly",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "molly.png",
		}
	},

	["rawhotdog"] = {
		label = "Raw Hotdog",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rawhotdog.png",
		}
	},

	["cokebrick"] = {
		label = "Cokebrick",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "cokebrick.png",
		}
	},

	["lobster_bisque"] = {
		label = "Lobster Bisque",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "lobster_bisque.png",
		}
	},

	["bdonut"] = {
		label = "Donut",
		weight = 100,
		stack = true,
		close = true,
		description = "Tasty Donut",
		client = {
			image = "bdonut.png",
		}
	},

	["boneless_meal_deal"] = {
		label = "Boneless Meal Deal",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "boneless_meal_deal.png",
		}
	},

	["frenchtoastbacon"] = {
		label = "French Toast Bacon",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "frenchbacon.png",
		}
	},

	["snow_man_joint"] = {
		label = "Snow Man Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "snow_man_joint.png",
		}
	},

	["ecola_light"] = {
		label = "ecola light",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ecola_light.png",
		}
	},

	["jolly_candy"] = {
		label = "Jolly Candy",
		weight = 1,
		stack = true,
		close = false,
		description = "A sweet treat",
		client = {
			image = "jolly_candy.png",
		}
	},

	["certificate"] = {
		label = "Certificate",
		weight = 0,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "certificate.png",
		}
	},

	["picklehornburger"] = {
		label = "HornBurger Pickle",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "pickleburger.png",
		}
	},

	["bcream"] = {
		label = "Whipped Cream",
		weight = 100,
		stack = true,
		close = true,
		description = "Whipped Cream",
		client = {
			image = "bcream.png",
		}
	},

	["newoil"] = {
		label = "Car Oil",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "caroil.png",
		}
	},

	["fireid"] = {
		label = "FIREFIGHTER",
		weight = 100,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "fireid.png",
		}
	},

	["drives2"] = {
		label = "Tier 2 Drive Shaft",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "drives2.png",
		}
	},

	["cables3"] = {
		label = "Tier 3 Battery Cables",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "cables3.png",
		}
	},

	["vodka_bottle"] = {
		label = "Vodka Bottle",
		weight = 500,
		stack = true,
		close = true,
		description = "A fine bottle of Vodka",
		client = {
			image = "vodka_bottle.png",
		}
	},

	["coke_leaf"] = {
		label = "Coca leaves",
		weight = 15,
		stack = true,
		close = false,
		description = "Leaf from amazing plant",
		client = {
			image = "coca_leaf.png",
		}
	},

	["margheritabox"] = {
		label = "Boxed Margherita",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["bellend_muzzle_brake"] = {
		label = "Bellend Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "bellend_muzzle_brake.png",
		}
	},

	["hashbrowns"] = {
		label = "Hash Browns",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "hashbrown.png",
		}
	},

	["raw_chicken_breasts"] = {
		label = "raw chicken breasts",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "raw_chicken_breasts.png",
		}
	},

	["transmission3"] = {
		label = "Tier 3 Transmission",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "transmission3.png",
		}
	},

	["tacomeet"] = {
		label = "Taco Meet",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "tacomeet.png",
		}
	},

	["burger_mshake"] = {
		label = "Milkshake",
		weight = 500,
		stack = true,
		close = true,
		description = "BurgerShot Milkshake",
		client = {
			status = {
				thirst = 51,
			},
			image = "burger_milkshake.png",
		}
	},

	["milking_pail"] = {
		label = "Milking Pail",
		weight = 250,
		stack = true,
		close = false,
		description = "A milking pail for collecting milk!",
		client = {
			image = "milking_pail.png",
		}
	},

	["holoscope_attachment"] = {
		label = "Holo Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A holo scope for a weapon",
		client = {
			image = "holoscope_attachment.png",
		}
	},

	["tree_bark"] = {
		label = "Tree Bark",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "treebark.png",
		}
	},

	["chain_dogtag"] = {
		label = "Chain Dogtag",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "chain_dogtag.png",
		}
	},

	["lemon_pepper_wings"] = {
		label = "Lemon Pepper Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "lemon_pepper_wings.png",
		}
	},

	["bmuffin"] = {
		label = "Muffin",
		weight = 100,
		stack = true,
		close = true,
		description = "Muffin",
		client = {
			image = "bmuffin.png",
		}
	},

	["moonshine_mash"] = {
		label = "Moonshine Mash",
		weight = 5000,
		stack = true,
		close = false,
		description = "A bucket of moonshine mash!",
		client = {
			image = "moonshine_mash.png",
		}
	},

	["bahama_shrimp"] = {
		label = "Raw Shrimp",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_shrimp.png",
		}
	},

	["suspension5"] = {
		label = "Tier 5 Suspension",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "suspension5.png",
		}
	},

	["bbq_wings"] = {
		label = "BBQ Wings",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "bbq_wings.png",
		}
	},

	["bahama_strawberry"] = {
		label = "Strawberry",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_strawberry.png",
		}
	},

	["froties_joint"] = {
		label = "Froties Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "froties_joint.png",
		}
	},

	["bm_martini"] = {
		label = "Martini",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Martini!",
		client = {
			image = "bm_martini.png",
		}
	},

	["hot_chicken_wrap"] = {
		label = "Hot Chicken Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "hot_chicken_wrap.png",
		}
	},

	["security_card_01"] = {
		label = "Security Card A",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_01.png",
		}
	},

	["perc_pooch"] = {
		label = "Perc Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "perc_pooch.png",
		}
	},

	["pink_sandy_joint"] = {
		label = "Pink Sandy Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "pink_sandy_joint.png",
		}
	},

	["lucas3"] = {
		label = "Lucas 3",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "lucas3.png",
		}
	},

	["squid"] = {
		label = "Calamari",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "squid.png",
		}
	},

	["large_thigh_bites"] = {
		label = "LARGE THIGH BITES",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "large_thigh_bites.png",
		}
	},

	["green_stone"] = {
		label = "Green Stone",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "green_stone.png",
		}
	},

	["token"] = {
		label = "Mysterious Token",
		weight = 500,
		stack = false,
		close = true,
		description = "A Mysterious Token",
		client = {
			image = "token.png",
		}
	},

	["fresh_baked_rolls"] = {
		label = "FRESH BAKED ROLLS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "fresh_baked_rolls.png",
		}
	},

	["usb_green"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A green USB flash drive",
		client = {
			image = "usb_green.png",
		}
	},

	["speedball"] = {
		label = "The SpeedBall",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 29,
			},
			image = "speedball.png",
		}
	},

	["marshmallow_crisp"] = {
		label = "Marshmallow Crisp",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "marshmallow_crisp.png",
		}
	},

	["engine4"] = {
		label = "Tier 4 Engine",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "engine4.png",
		}
	},

	["chicken_burrito"] = {
		label = "Chicken Burrito",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "chicken_burrito.png",
		}
	},

	["nori"] = {
		label = "Nori",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "nori.png",
		}
	},

	["casinocodes"] = {
		label = "Casino Access Codes",
		weight = 200,
		stack = false,
		close = true,
		description = "The first half of codes for the Casino",
		client = {
			image = "casinocodes.png",
		}
	},

	["petfood"] = {
		label = "pet food",
		weight = 500,
		stack = true,
		close = true,
		description = "food for your companion!",
		client = {
			image = "petfood.png",
		}
	},

	["carlockpick"] = {
		label = "Carlockpick",
		weight = 50,
		stack = false,
		close = true,
		description = "A Lockpick.",
		client = {
			image = "carlockpick.png",
		}
	},

	["bee_queen"] = {
		label = "Bee Queen",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bee_queen.png",
		}
	},

	["mahi_mahi"] = {
		label = "Mahi Mahi",
		weight = 3500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mahi_mahi.png",
		}
	},

	["atomfries"] = {
		label = "Atom Fries",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 23,
			},
			image = "atomfries.png",
		}
	},

	["barley"] = {
		label = "Barley",
		weight = 100,
		stack = true,
		close = false,
		description = "Barley!",
		client = {
			image = "barley.png",
		}
	},

	["creampie"] = {
		label = "Creampie",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Apple Pie",
		client = {
			status = {
				hunger = 40,
			},
			image = "burger_creampie.png",
		}
	},

	["meth_access"] = {
		label = "Access Card",
		weight = 50,
		stack = true,
		close = false,
		description = "Access Card for Meth Lab",
		client = {
			image = "meth_access.png",
		}
	},

	["bands"] = {
		label = "Band Of Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A band of small notes..",
		client = {
			image = "bands.png",
		}
	},

	["aluminumoxide"] = {
		label = "Aluminium Powder",
		weight = 0,
		stack = true,
		close = false,
		description = "Some powder to mix with",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["limeyschocolate"] = {
		label = "Nestle Extrafino Chocolate",
		weight = 100,
		stack = true,
		close = true,
		description = "Mmmmmm Chocolate!",
		client = {
			image = "limeyschocolate.png",
		}
	},

	["pisswasser3"] = {
		label = "Pißwasser Pale Ale",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 50,
			},
			image = "pisswaser3.png",
		}
	},

	["limeysgum"] = {
		label = "Trident Gum",
		weight = 100,
		stack = true,
		close = true,
		description = "Chewy! Minty! Fresh!",
		client = {
			image = "limeysgum.png",
		}
	},

	["pooch_bag"] = {
		label = "Pooch Bag",
		weight = 500,
		stack = true,
		close = false,
		description = "Your description here",
		client = {
			image = "pooch_bag.png",
		}
	},

	["snikkel_candy"] = {
		label = "Snikkel",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "snikkel_candy.png",
		}
	},

	["oilbarrel"] = {
		label = "Oil Barrel",
		weight = 20000,
		stack = false,
		close = true,
		description = "Full of oil, probably has some value",
		client = {
			image = "oilbarrel.png",
		}
	},

	["watering_can"] = {
		label = "Watering Can",
		weight = 100,
		stack = true,
		close = false,
		description = "A empty watering can!",
		client = {
			image = "watering_can.png",
		}
	},

	["secured_safe"] = {
		label = "Safe",
		weight = 200,
		stack = false,
		close = true,
		description = "Meant to protect valuables",
		client = {
			image = "secured_safe.png",
		}
	},

	["bahama_sugarcube"] = {
		label = "Sugar Cubes",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_sugarcube.png",
		}
	},

	["runtz_og"] = {
		label = "Runtz OG",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "runtz_og.png",
		}
	},

	["arm1"] = {
		label = "Armor Lvl. 1",
		weight = 1000.0,
		stack = true,
		close = true,
		client = {
			image = "arm1.png",
		}
	},

	["shrimp_pasta"] = {
		label = "Shrimp Pasta",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "shrimp_pasta.png",
		}
	},

	["gummy_zkittlez_cbd"] = {
		label = "CBD Zkittlez Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd zkittlez gummy bear!",
		client = {
			image = "gummy_zkittlez_cbd.png",
		}
	},

	["shotnuggets"] = {
		label = "Shot Nuggets",
		weight = 200,
		stack = true,
		close = true,
		description = "Burgershot Nuggets",
		client = {
			status = {
				hunger = 44,
			},
			image = "burger_shotnuggets.png",
		}
	},

	["salmon_caesar_salad"] = {
		label = "Salmon Caesar Salad",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "salmon_caesar_salad.png",
		}
	},

	["bahama_bbq"] = {
		label = "BBQ Sauce",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_bbq.png",
		}
	},

	["crack_pooch"] = {
		label = "Crack Pooch",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "crack_pooch.png",
		}
	},

	["clip_attachment"] = {
		label = "Clip",
		weight = 1000,
		stack = true,
		close = true,
		description = "A clip for a weapon",
		client = {
			image = "clip_attachment.png",
		}
	},

	["pizza"] = {
		label = "Kitty Pizza",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 41,
			},
			image = "catpizza.png",
		}
	},

	["beancoffee"] = {
		label = "Coffe Beans",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 23,
			},
			image = "beancoffee.png",
		}
	},

	["bahama_cheddar"] = {
		label = "Cheddar",
		weight = 100,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bahama_cheddar.png",
		}
	},

	["stickynote"] = {
		label = "Sticky note",
		weight = 0,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "stickynote.png",
		}
	},

	["noodles"] = {
		label = "Instant Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "noodles.png",
		}
	},

	["miner_s9shell"] = {
		label = "Management device",
		weight = 100,
		stack = true,
		close = true,
		description = "This device is used to keep control of mining devices.",
		client = {
			image = "s9shell.png",
		}
	},

	["titanium_rod"] = {
		label = "Titanium rod",
		weight = 450,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "titanium_rod.png",
		}
	},

	["bm_kahlua"] = {
		label = "Kahlua",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Kahlua Cocktail!",
		client = {
			image = "bm_kahlua.png",
		}
	},

	["petwaterbottleportable"] = {
		label = "Portable water bottle",
		weight = 1000,
		stack = false,
		close = true,
		description = "Flask to store water for your pets",
		client = {
			image = "petwaterbottleportable.png",
		}
	},

	["brakes3"] = {
		label = "Tier 3 Brakes",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "brakes3.png",
		}
	},

	["skull_bracelet"] = {
		label = "Skull Bracelet",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "skull_bracelet.png",
		}
	},

	["rolex"] = {
		label = "Golden Watch",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden watch seems like the jackpot to me!",
		client = {
			image = "rolex.png",
		}
	},

	["xenonsmauve"] = {
		label = "Purple Xenone",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "xenonsmauve.png",
		}
	},

	["baconcheesemelt"] = {
		label = "Bacon_Triple Cheese Melt",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "baconcheesemelt.png",
		}
	},

	["veggie_sticks"] = {
		label = "VEGGIE STICKS",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "veggie_sticks.png",
		}
	},

	["caradvancedlockpick"] = {
		label = "Car Advanced Lockpick",
		weight = 500,
		stack = true,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers",
		client = {
			image = "advancedlockpick.png",
		}
	},

	["omochi"] = {
		label = "Orange Mochi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 44,
			},
			image = "mochiorange.png",
		}
	},

	["chickenhorn"] = {
		label = "Chicken Hornstars",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 23,
			},
			image = "chickhornstars.png",
		}
	},

	["cheese"] = {
		label = "Cheese",
		weight = 179,
		stack = true,
		close = true,
		description = "🧀✨ A delightful blend of flavors, this cheese adds a creamy and savory touch to any dish. 🌟🧀",
		client = {
			image = "cheese.png",
		}
	},

	

	["ether"] = {
		label = "Ether",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "ether.png",
		}
	},

	["seat"] = {
		label = "Seat Cosmetics",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "seat.png",
		}
	},

	["spice_joint"] = {
		label = "Spice Joint",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "spice_joint.png",
		}
	},

	["rag"] = {
		label = "rag",
		weight = 150,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "rag.png",
		}
	},

	["side_caesar_salad"] = {
		label = "Side Caesar Salad",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "side_caesar_salad.png",
		}
	},

	["emerald_ring"] = {
		label = "Emerald Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring.png",
		}
	},

	["meat"] = {
		label = "Meat",
		weight = 200,
		stack = true,
		close = false,
		description = "A slab of Meat",
		client = {
			image = "meat.png",
		}
	},

	["triple_meal_deal"] = {
		label = "Chicken Biscuit",
		weight = 100,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "triple_meal_deal.png",
		}
	},

	["cocktailglass"] = {
		label = "Cocktail Glass",
		weight = 1000,
		stack = true,
		close = true,
		description = "Glass made for cocktails!",
		client = {
			image = "cocktailglass.png",
		}
	},

	["growler"] = {
		label = "Growler",
		weight = 100,
		stack = true,
		close = false,
		description = "A empty growler!",
		client = {
			image = "growler.png",
		}
	},

	["casino_ego_chaser"] = {
		label = "Casino Ego Chaser",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Ego Chaser",
		client = {
			image = "casino_ego_chaser.png",
		}
	},

	["baconhornburger"] = {
		label = "HornBurger Bacon",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 30,
			},
			image = "baconburger.png",
		}
	},

	["ruby_necklace_silver"] = {
		label = "Ruby Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace_silver.png",
		}
	},

	["cereal_milk"] = {
		label = "Cereal Milk",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "cereal_milk.png",
		}
	},

	["calamari"] = {
		label = "Calamari Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "calamari.png",
		}
	},

	["crunchwrap_supreme"] = {
		label = "Crunchwrap Supreme",
		weight = 500,
		stack = true,
		close = true,
		description = "Food.",
		client = {
			image = "crunchwrap_supreme.png",
		}
	},

	["noodlebowl"] = {
		label = "Bowl of Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 49,
			},
			image = "noodlebowl.png",
		}
	},

	["bm_caridea"] = {
		label = "Shrimp Caridean",
		weight = 100,
		stack = true,
		close = true,
		description = "Bahama Mama Shrimp Squid Caridean!",
		client = {
			image = "bm_caridea.png",
		}
	},

	["runtz_og_joint"] = {
		label = "Runtz OG Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "Your description here",
		client = {
			image = "runtz_og_joint.png",
		}
	},

	["gelatine"] = {
		label = "Gelatine",
		weight = 100,
		stack = true,
		close = true,
		description = "A packet of gelatine, good for making sweets!",
		client = {
			image = "gelatine.png",
		}
	},

	["win1"] = {
		label = "Light Smoke Window Tint",
		weight = 100.0,
		stack = true,
		close = true,
		client = {
			image = "win1.png",
		}
	},

	["meth_emptysacid"] = {
		label = "Empty Canister",
		weight = 100,
		stack = true,
		close = false,
		description = "Material: Plastic, Good for Sodium Benzoate",
		client = {
			image = "meth_emptysacid.png",
		}
	},

	['debitcard_personal'] = {
        label = 'Personal Debit Card',
        weight = 0,
        category = 'money',
        client = {
            image = 'debitcard_personal.png',
            export = "tgg-banking.UseCardOnAtm",

        },
    },

    ['debitcard_shared'] = {
        label = 'Shared Debit Card',
        weight = 0,
        client = {
            image = 'debitcard_shared.png',
            export = "tgg-banking.UseCardOnAtm",
        },
    },

    ['debitcard_business'] = {
        label = 'Business Debit Card',
        weight = 0,
        client = {
            image = 'debitcard_business.png',
            export = "tgg-banking.UseCardOnAtm",
        },
    },

	['mdt'] = {
		label = 'POLICE MDT',
		weight = 500,
		stack = false,
		close = true,
		allowArmed = false,
		consume = 0,
		client = { event = 'redutzu-mdt:client:openMDT', image = 'redutzu_mdt.png' },
		description = 'Take roleplay to another level with the most advanced MDT on FiveM'
	},

	['ems'] = {
		label = 'SAMS MDT',
		weight = 500,
		stack = false,
		close = true,
		allowArmed = false,
		consume = 0,
		client = { event = 'redutzu-ems:client:openEMS', image = 'redutzu_ems.png' },
		description = 'Take roleplay to another level with the most advanced MDT on FiveM'
	},
	
	['bodycam'] = {
			label = 'Bodycam',
			weight = 300,
			stack = false,
			close = true,
			allowArmed = true,
			consume = 0,
			client = { event = 'redutzu-mdt:client:toggle-bodycam-state', image = 'bodycam.png' },
			description = 'Let other players see your body with the most advanced bodycam on FiveM'
	},

	-- Wasabi Ambulance Job Items
	['medikit'] = {
			label = 'Medikit',
			weight = 165,
			stack = true,
			close = true,
			client = {
				image = 'medikit.png',
			}
		},
		['medbag'] = {
			label = 'Medical Bag',
			weight = 165,
			stack = false,
			close = true,
			client = {
				image = 'medbag.png',
			}
		},
	
		['tweezers'] = {
			label = 'Tweezers',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'tweezers.png',
			}
		},
	
		['suturekit'] = {
			label = 'Suture Kit',
			weight = 15,
			stack = true,
			close = true,
			client = {
				image = 'suturekit.png',
			}
		},
	
		['icepack'] = {
			label = 'Ice Pack',
			weight = 29,
			stack = true,
			close = true,
			client = {
				image = 'icepack.png',
			}
		},
	
		['burncream'] = {
			label = 'Burn Cream',
			weight = 19,
			stack = true,
			close = true,
			client = {
				image = 'burncream.png',
			}
		},
	
		['defib'] = {
			label = 'Defibrillator',
			weight = 225,
			stack = false,
			close = true,
			client = {
				image = 'defib.png',
			}
			
		},
	
		['sedative'] = {
			label = 'Sedative',
			weight = 15,
			stack = true,
			close = true,
			client = {
				image = 'sedative.png',
			}
		},

		['morphine30'] = {
			label = 'Morphine 30MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'morphine30.png',
			}
		},

		['morphine15'] = {
			label = 'Morphine 15MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'morphine15.png',
			}
		},

		['perc30'] = {
			label = 'Percocet 30MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'perc30.png',
			}
		},

		['perc10'] = {
			label = 'Percocet 10MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'perc10.png',
			}
		},

		['perc5'] = {
			label = 'Percocet 5MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'perc5.png',
			}
		},

		['vic10'] = {
			label = 'Vicodin 10MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'vic10.png',
			}
		},

		['vic5'] = {
			label = 'Vicodin 5MG',
			weight = 2,
			stack = true,
			close = true,
			client = {
				image = 'vic5.png',
			}
		},
	
		['recoveredbullet'] = {
			label = 'Recovered Bullet',
			weight = 1,
			stack = true,
			close = false,
			client = {
				image = 'recoveredbullet.png',
			}
		},

		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		----| YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!!YSERIES PHONE ONLY!!! |----
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		["yflip_mint"]  = {
			label = "YFlip (Mint)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A minty colored flip smartphone.",
			client = {
				image = "yflip_mint.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yflip_gold"]  = {
			label = "YFlip (Gold)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A yellowish gold colored flip smartphone.",
			client = {
				image = "yflip_gold.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yflip_graphite"]  = {
			label = "YFlip (Graphite)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A graphite colored flip smartphone.",
			client = {
				image = "yflip_graphite.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yflip_lavender"]  = {
			label = "YFlip (Lavender)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A lavender colored flip smartphone.",
			client = {
				image = "yflip_lavender.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yphone_natural"] = {
			label = "YPhone (Natural)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A natural titanium colored smartphone.",
			client = {
				image = "yphone_natural.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yphone_black"] = {
			label = "YPhone (Black)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A black titanium colored smartphone.",
			client = {
				image = "yphone_black.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yphone_white"] = {
			label = "YPhone (White)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A white titanium colored smartphone.",
			client = {
				image = "yphone_white.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["yphone_blue"] = {
			label = "YPhone (Blue)",
			weight = 100,
			stack = false,
			consume = 0,
			description = "A blue titanium colored smartphone.",
			client = {
				image = "yphone_blue.png",
				export = "yseries.UsePhoneItem",
				remove = function()
				TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
				TriggerEvent("yseries:phone-item-added")
			end
			}
		},

		["y24_black"] = {
			label = "Y24 (Black)",
			weight = 100,
			stack = false,
			consume = 0,
			client = {
				image = 'y24_black.png',
				export = "yseries.UsePhoneItem",
				remove = function()
					TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
					TriggerEvent("yseries:phone-item-added")
				end
			}
		},

		["y24_silver"] = {
			label = "Y24 (Silver)",
			weight = 100,
			stack = false,
			consume = 0,
			client = {
				image = 'y24_silver.png',
				export = "yseries.UsePhoneItem",
				remove = function()
					TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
					TriggerEvent("yseries:phone-item-added")
				end
			}
		},

		["y24_violet"] = {
			label = "Y24 (Violet)",
			weight = 100,
			stack = false,
			consume = 0,
			client = {
				image = 'y24_violet.png',
				export = "yseries.UsePhoneItem",
				remove = function()
					TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
					TriggerEvent("yseries:phone-item-added")
				end
			}
		},
		
		["y24_yellow"] = {
			label = "Y24 (Yellow)",
			weight = 100,
			stack = false,
			consume = 0,
			client = {
				image = 'y24_yellow.png',
				export = "yseries.UsePhoneItem",
				remove = function()
					TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
					TriggerEvent("yseries:phone-item-added")
				end
			}
		},
		["yfold_black"] = {
			label = "YFold Black",
			weight = 100,
			stack = false,
			consume = 0,
			client = {
				image =  "yfold_black.png",
				export = "yseries.UsePhoneItem",
				remove = function()
					TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
					TriggerEvent("yseries:phone-item-added")
				end
			}
		},
		["yphone_fold_black"] = {
			label = "YPhone Fold Black",
			weight = 100,
			stack = false,
			consume = 0,
			client = {
				image = "yphone_fold_black.png",
				export = "yseries.UsePhoneItem",
				remove = function()
					TriggerEvent("yseries:phone-item-removed")
				end,
				add = function()
					TriggerEvent("yseries:phone-item-added")
				end
			}
		},
		['ys_sim_card'] = {
			label = 'Sim Card',
			stack = false,
			weight = 10,
			consume = 0,
		},

		-- RCORE PRISON
		['sludgie'] = {
			name = 'sludgie',
			label = 'Sludgie',
			weight = 350,
			client = {
				status = { thirst = 200000 },
				anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
				prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
				usetime = 2500,
				notification = 'You quenched your thirst with a Coffee'
			}
		},
		['ecola_light'] = {
			name = 'ecola_light',
			label = 'Ecola light',
			weight = 350,
			client = {
				status = { thirst = 200000 },
				anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
				prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
				usetime = 2500,
				notification = 'You quenched your thirst with a Coffee'
			}
		},
		['ecola'] = {
			name = 'ecola',
			label = 'Ecola',
			weight = 350,
			client = {
				status = { thirst = 200000 },
				anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
				prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
				usetime = 2500,
				notification = 'You quenched your thirst with a Coffee'
			}
		},
		['coffee'] = {
			name = 'coffee',
			label = 'Coffee',
			weight = 350,
			client = {
				status = { thirst = 200000 },
				anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
				prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
				usetime = 2500,
				notification = 'You quenched your thirst with a Coffee'
			}
		},
		['fries'] = {
			name = 'fries',
			label = 'Fries',
			weight = 350,
			client = {
				status = { hunger = 200000 },
				anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
				prop = { model = 'prop_food_cb_chips', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
				usetime = 2500,
				notification = 'You eat Fries'
			}
		},
		['pizza_ham'] = {
			name = 'pizza_ham',
			label = 'Pizza Ham',
			weight = 350,
			client = {
				status = { hunger = 200000 },
				anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
				prop = { model = 'prop_food_cb_chips', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
				usetime = 2500,
				notification = 'You eat Fries'
			}
		},
		['chips'] = {
			name = 'chips',
			label = 'Chips',
			weight = 350,
			client = {
				status = { hunger = 200000 },
				anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
				prop = { model = 'prop_food_cb_chips', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
				usetime = 2500,
				notification = 'You eat Chips'
			}
		},
		['donut'] = {
			name = 'donut',
			label = 'Donut',
			weight = 350,
			client = {
				status = { hunger = 200000 },
				anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
				prop = { model = 'prop_amb_donut', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
				usetime = 2500,
				notification = 'You eat Donut'
			}
		},

		-- WASABI BANK ROBBERIES
		['wire_cutter'] = {
			name = 'wire_cutter',
			label = 'cutter',
			weight = 100,
			stack = true,
			consume = 0,
			close = true,
			client = {
				image = 'wire_cutter.png',
			}
		},
		['cigarrete'] = {
			name = 'cigarrete',
			label = 'Cigarrete',
			weight = 100,
			stack = true,
			consume = 0,
			close = true,
			client = {
				image = 'cigarrete.png',
			}
		},
		['usb_stick'] = {
			label = 'USB Stick',
			weight = 5,
			stack = true,
			close = true,
			description = 'USB Stick',
			client = {
				image = 'usb_stick.png',
			}
		},
		['thermite_bomb'] = {
			label = 'Thermite Bomb',
			weight = 5,
			stack = true,
			close = true,
			description = 'Thermite Bomb',
			client = {
				image = 'thermite_bomb.png',
			}
		},
		['c4_bomb'] = {
			label = 'C4 Bomb',
			weight = 5,
			stack = true,
			close = true,
			description = 'C4 Bomb',
			client = {
				image = 'c4_bomb.png',
			}
		},
		['drill'] = {
			label = 'Drill',
			weight = 5,
			stack = true,
			close = true,
			description = 'Drill',
			client = {
				image = 'drill.png',
			}
		},
		['laptop'] = { 
			label = 'Laptop', 
			weight = 5, 
			stack = true, 
			close = true, 
			description = 'Laptop', 
			client = {
				image = 'laptop.png',
			}
		},
		['diamond'] = { 
			label = 'Diamond', 
			weight = 5, 
			stack = true, 
			close = true, 
			description = 'Diamond', 
			client = {
				image = 'diamond.png',
			}
		},
		['gold_bar'] = { 
			label = 'Gold Bar', 
			weight = 5, 
			stack = true, 
			close = true, 
			description = 'Gold Bar', 
			client = {
				image = 'usb_stick.png',
			}
		},

		-- JG MECHANIC ITEMS
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
		 --[[ -- Engine Items
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
		  ]]--
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
		  },

		  -- White Widow Items
		  ['trimmers'] = {
			label = 'Trimming Shears',
			weight = 200,
			stack = true,
			close = true,
			description = 'High quality trimming shears.',
			client = {
				image = 'ww_shears.png',
			}
		},
		['grinder'] = {
			label = 'Grinder',
			weight = 100,
			stack = true,
			close = true,
			description = 'A Grinder',
			client = {
				image = 'ww_grinder.png',
			}
		},
		['rollingpapers'] = {
			label = 'Rolling Papers',
			weight = 50,
			stack = true,
			close = true,
			description = 'Roll em up',
			client = {
				image = 'ww_rollingpapers.png',
			}
		},
		['lighter'] = {
			label = 'Lighter',
			weight = 100,
			stack = true,
			close = true,
			description = 'Please don’t light anything on fire',
			client = {
				image = 'ww_lighter.png',
			}
		},
		['emptybaggy'] = {
			label = 'Resealable Bag',
			weight = 1,
			stack = true,
			close = true,
			description = 'A small empty bag',
			client = {
				image = 'ww_baggie.png',
			}
		},
		['gummymould'] = {
			label = 'Gummy Mould',
			weight = 100,
			stack = true,
			close = true,
			description = 'A mould for candy making',
			client = {
				image = 'ww_gummymould.png',
			}
		},
		['gelatine'] = {
			label = 'Gelatine',
			weight = 100,
			stack = true,
			close = true,
			description = 'You could make some jello out of this',
			client = {
				image = 'ww_gelatine.png',
			}
		},
		['cereal'] = {
			label = 'Cereal',
			weight = 100,
			stack = true,
			close = true,
			description = 'Yum! Cereal',
			client = {
				image = 'ww_cereal.png',
			}
		},
		['cannabutter'] = {
			label = 'Cannabutter',
			weight = 100,
			stack = true,
			close = true,
			description = 'This butter sure do smell funny',
			client = {
				image = 'ww_cannabutter.png',
			}
		},
		['butter'] = {
			label = 'Butter',
			weight = 100,
			stack = true,
			close = true,
			description = 'Butter full of carbs',
			client = {
				image = 'ww_butter.png',
			}
		},
		['sugar'] = {
			label = 'Sugar',
			weight = 100,
			stack = true,
			close = true,
			description = 'Sweeter than you',
			client = {
				image = 'ww_sugar.png',
			}
		},
		['flour'] = {
			label = 'Flour',
			weight = 100,
			stack = true,
			close = true,
			description = 'Butter full of carbs',
			client = {
				image = 'ww_flour.png',
			}
		},
		['egg'] = {
			label = 'Egg',
			weight = 100,
			stack = true,
			close = true,
			description = 'Sweeter than you',
			client = {
				image = 'ww_egg.png',
			}
		},
		['milk'] = {
			label = 'Milk',
			weight = 100,
			stack = true,
			close = true,
			description = 'Sweeter than you',
			client = {
				image = 'ww_milk.png',
			}
		},
		['peanutbutter'] = {
			label = 'Peanut Butter',
			weight = 100,
			stack = true,
			close = true,
			description = 'Creamy Goodness',
			client = {
				image = 'ww_peanutbutter.png',
			}
		},
		['chocolatechips'] = {
			label = 'Chocolate Chips',
			weight = 100,
			stack = true,
			close = true,
			description = 'Creamy Goodness',
			client = {
				image = 'ww_chocolatechips.png',
			}
		},

		-- White Widow Crops
		['afghankush_crop'] = {
			label = 'Afghan Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Afghan Kush Crop',
			client = {
				image = 'ww_afghankush_crop.png',
			}
		},
		['bluedream_crop'] = {
			label = 'Blue Dream Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Blue Dream Crop',
			client = {
				image = 'ww_bluedream_crop.png',
			}
		},
		['granddaddypurple_crop'] = {
			label = 'Grand Daddy Purple Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Grand Daddy Purple Crop',
			client = {
				image = 'ww_granddaddypurple_crop.png',
			}
		},
		['greencrack_crop'] = {
			label = 'Green Crack Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Green Crack Crop',
			client = {
				image = 'ww_greencrack_crop.png',
			}
		},
		['jackherrer_crop'] = {
			label = 'Jack Herer Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Jack Herer Crop',
			client = {
				image = 'ww_jackherrer_crop.png',
			}
		},
		['sourdiesel_crop'] = {
			label = 'Sour Diesel Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Sour Diesel Crop',
			client = {
				image = 'ww_sourdiesel_crop.png',
			}
		},
		['weddingcake_crop'] = {
			label = 'Wedding Cake Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'Wedding Cake Crop',
			client = {
				image = 'ww_weddingcake_crop.png',
			}
		},
		['whitewidow_crop'] = {
			label = 'White Widow Crop',
			weight = 1200,
			stack = true,
			close = false,
			description = 'White Widow Crop',
			client = {
				image = 'ww_whitewidow_crop.png',
			}
		},
		-- White Widow Bud
		['afghankush_bud'] = {
			label = 'Afghan Kush Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Afghan Kush Bud',
			client = {
				image = 'ww_afghankush_bud.png',
			}
		},
		['bluedream_bud'] = {
			label = 'Blue Dream Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Blue Dream Bud',
			client = {
				image = 'ww_bluedream_bud.png',
			}
		},
		['granddaddypurple_bud'] = {
			label = 'Grand Daddy Purple Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Grand Daddy Purple Bud',
			client = {
				image = 'ww_granddaddypurple_bud.png',
			}
		},
		['greencrack_bud'] = {
			label = 'Green Crack Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Green Crack Bud',
			client = {
				image = 'ww_greencrack_bud.png',
			}
		},
		['jackherrer_bud'] = {
			label = 'Jack Herer Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Jack Herer Bud',
			client = {
				image = 'ww_jackherrer_bud.png',
			}
		},
		['sourdiesel_bud'] = {
			label = 'Sour Diesel Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Sour Diesel Bud',
			client = {
				image = 'ww_sourdiesel_bud.png',
			}
		},
		['weddingcake_bud'] = {
			label = 'Wedding Cake Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'Wedding Cake Bud',
			client = {
				image = 'ww_weddingcake_bud.png',
			}
		},
		['whitewidow_bud'] = {
			label = 'White Widow Bud',
			weight = 2,
			stack = true,
			close = false,
			description = 'White Widow Bud',
			client = {
				image = 'ww_whitewidow_bud.png',
			}
		},

		
	
    ["bluedream_joint"] = {
        label = "Blue Dream Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Grand Daddy Purple Joint",
        client = {
            image = "ww_bluedream_joint.png",
        }
    },

    ["jackherrer_joint"] = {
        label = "Jack Herrer Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Jack Herrer Joint",
        client = {
            image = "ww_jackherrer_joint.png",
        }
    },

    ["gummy_blueberry"] = {
        label = "Blue Dream Gummy",
        weight = 4,
        stack = true,
        close = true,
        description = "A hazy Blue Dream Gummy",
        client = {
            image = "ww_blueberrygummies.png",
        }
    },

    ["granddaddypurple_joint"] = {
        label = "Grand Daddy Purple Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Grand Daddy Purple Joint",
        client = {
            image = "ww_granddaddypurple_joint.png",
        }
    },

    ["edible_cchip"] = {
        label = "Buddy Crocker Chip",
        weight = 4,
        stack = true,
        close = true,
        description = "Buddy Crockers Homemade Goods",
        client = {
            image = "ww_chocochip.png",
        }
    },

    ["edible_peanutcookie"] = {
        label = "Buddy Peanutbutter Cookie",
        weight = 4,
        stack = true,
        close = true,
        description = "Buddy Crockers Homemade Goods",
        client = {
            image = "ww_peanutbuttercookie.png",
        }
    },

    ["edible_snickerdoodle"] = {
        label = "Buddy Crocker Doodle",
        weight = 4,
        stack = true,
        close = true,
        description = "Buddy Crockers Homemade Goods",
        client = {
            image = "ww_snickerdoodle.png",
        }
    },

    ["gummy_grape"] = {
        label = "Grand Daddy Purp Gummy",
        weight = 4,
        stack = true,
        close = true,
        description = "Grand Daddy of Gummies",
        client = {
            image = "ww_grapegummies.png",
        }
    },

    ["greencrack_joint"] = {
        label = "Green Crack Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Green Crack Joint",
        client = {
            image = "ww_greencrack_joint.png",
        }
    },

    ["afghankush_joint"] = {
        label = "Afghan Kush Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Afghan Kush Joint",
        client = {
            image = "ww_afghankush_joint.png",
        }
    },

    ["gummy_belt"] = {
        label = "Herrer Belts",
        weight = 4,
        stack = true,
        close = true,
        description = "Sour Belts with a Twist",
        client = {
            image = "ww_rainbowbelts.png",
        }
    },

    ["weddingcake_joint"] = {
        label = "Wedding Cake Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Wedding Cake Joint",
        client = {
            image = "ww_weddingcake_joint.png",
        }
    },

    ["edible_ricecrispy"] = {
        label = "Buddy Crocker Crispy",
        weight = 4,
        stack = true,
        close = true,
        description = "Buddy Crockers Homemade Goods",
        client = {
            image = "ww_crispytreat.png",
        }
    },

    ["sourdiesel_joint"] = {
        label = "Sour Diesel Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "Sour Diesel Joint",
        client = {
            image = "ww_sourdiesel_joint.png",
        }
    },

    ["gummy_applering"] = {
        label = "Green Crack Gummy",
        weight = 4,
        stack = true,
        close = true,
        description = "There is no Crack in this Gummy stop asking",
        client = {
            image = "ww_greenapplegummies.png",
        }
    },

    ["gummy_rasberry"] = {
        label = "Rasberry Kush Gummy",
        weight = 4,
        stack = true,
        close = true,
        description = "A Rashberry Kush Gummy - Not Safe for Kids!",
        client = {
            image = "ww_rasberrygummies.png",
        }
    },

    ["whitewidow_joint"] = {
        label = "White Widow Joint",
        weight = 2,
        stack = true,
        close = false,
        description = "White Widow Joint",
        client = {
            image = "ww_whitewidow_joint.png",
        }
    },



	-- CluckinBell Items Seymore's business
	--// Ingredients for Cluckin Bell
	['cb_mayo'] = {
		label = 'Mayonnaise',
		weight = 200,
		description = 'Mayonnaise for Cluckin Bell!',
		client = {
			image = 'Mayonnaise.png',
		}
	},

	['cb_cheese'] = {
		label = 'American Cheese',
		weight = 200,
		description = 'American Cheese for Cluckin Bell!',
		client = {
			image = 'cb_cheese.png',
		}
	},

	['cb_buns'] = {
		label = 'Buns',
		weight = 200,
		description = 'Buns for Cluckin Bell!',
		client = {
			image = 'cb_buns.png',
		}
	},

	['cb_grilledbuns'] = {
		label = 'Grilled Buns',
		weight = 200,
		description = 'Grilled buns for Cluckin Bell!',
		client = {
			image = 'cb_buns.png',
		}
	},

	['cb_nuggets'] = {
		label = 'Nuggets',
		weight = 200,
		description = 'Nuggets fresh out of the fryer!',
		client = {
			image = 'cb_nugget.png',
		}
	},

	['cb_frozennuggets'] = {
		label = 'Frozen Nuggets',
		weight = 200,
		description = 'Frozen nuggets for Cluckin Bell.',
		client = {
			image = 'cb_nugget.png',
		}
	},

	['cb_drumstick'] = {
		label = 'Drumsticks',
		weight = 200,
		description = 'Drumsticks fresh out of the fryer!',
		client = {
			image = 'cb_drumstick.png',
		}
	},

	['cb_frozendrumsticks'] = {
		label = 'Frozen Drumsticks',
		weight = 200,
		description = 'Frozen drumsticks for Cluckin Bell.',
		client = {
			image = 'cb_drumstick.png',
		}
	},

	['cb_chickenraw'] = {
		label = 'Raw Chicken Filet',
		weight = 200,
		description = 'Raw chicken filet for Cluckin Bell!',
		client = {
			image = 'cb_chickenraw.png',
		}
	},

	['cb_chickenfilet'] = {
		label = 'Cooked Chicken Filet',
		weight = 200,
		description = 'Cooked chicken filet for Cluckin Bell!',
		client = {
			image = 'cb_chickenfilet.png',
		}
	},

	['cb_onionrings'] = {
		label = 'Onion Rings',
		weight = 200,
		description = 'Fresh onion rings stright out of the fryer.',
		client = {
			image = 'cb_onionring.png',
		}
	},

	['cb_onion'] = {
		label = 'Onion',
		weight = 200,
		description = 'Drumsticks fresh out of the fryer!',
		client = {
			image = 'cb_onion.png',
		}
	},

	['cb_onionslices'] = {
		label = 'Sliced Onions',
		weight = 200,
		description = 'Sliced onions for Cluckin Bell',
		client = {
			image = 'cb_onionslice.png',
		}
	},

	['cb_tomato'] = {
		label = 'Tomato',
		weight = 200,
		description = 'Sliced onions for Cluckin Bell.',
		client = {
			image = 'cb_tomato.png',
		}
	},

	['cb_tomatoslices'] = {
		label = 'Sliced Tomatos',
		weight = 200,
		description = 'Sliced tomatos for Cluckin Bell.',
		client = {
			image = 'cb_tomatoslices.png',
		}
	},

	['cb_headlettuce'] = {
		label = 'Head of Lettuce',
		weight = 200,
		description = 'A head of lettuce for Cluckin Bell.',
		client = {
			image = 'cb_headlettuce.png',
		}
	},

	['cb_shreddedlettuce'] = {
		label = 'Shredded Lettuce',
		weight = 200,
		description = 'Shredded lettuce for Cluckin Bell.',
		client = {
			image = 'cb_lettuce.png',
		}
	},

	['cb_frozenfries'] = {
		label = 'Frozen French Fries',
		weight = 200,
		description = 'Frozen fries for Cluckin Bell.',
		client = {
			image = 'cb_fry.png',
		}
	},

	['cb_fries'] = {
		label = 'French Fries',
		weight = 200,
		description = 'Fresh fries straight out of the fryer.',
		client = {
			image = 'cb_fry.png',
		}
	},
	
	--// Food Items for Cluckin Bell
	-- Chicken Sandwiches
	
	['cb_chickensandwich'] = {
		label = 'Chicken Sandwich',
		weight = 200,
		description = 'A delicious chicken sandwich from Cluckin Bell',
		client = {
			image = 'cb_chickensandwich.png',
		}
	},

	['cb_chickensandwich_double'] = {
		label = 'Double Chicken Sandwich',
		weight = 200,
		description = 'A delicious double chicken sandwich from Cluckin Bell',
		client = {
			image = 'cb_chickensandwich_double.png',
		}
	},

	-- Fried Chicken

	['cb_friedchicken5pc'] = {
		label = 'Fried Chicken 5pc',
		weight = 200,
		description = 'A delicious 5 piece fried chicken entree from Cluckin Bell!',
		client = {
			image = 'cb_friedchicken_5pc.png',
		}
	},

	['cb_friedchicken10pc'] = {
		label = 'Fried Chicken 10pc',
		weight = 200,
		description = 'A delicious 10 piece fried chicken entree from Cluckin Bell. Extra filling!',
		client = {
			image = 'cb_friedchicken_10pc.png',
		}
	},

	-- Chicken Nuggets

	['cb_nuggets_sm'] = {
		label = 'Small Chicken Nuggets',
		weight = 200,
		description = 'Small chicken nuggets from Cluckin Bell.',
		client = {
			image = 'cb_nuggets_sm.png',
		}
	},

	['cb_nuggets_md'] = {
		label = 'Medium Chicken Nuggets',
		weight = 200,
		description = 'Medium chicken nuggets from Cluckin Bell.',
		client = {
			image = 'cb_nuggets_md.png',
		}
	},

	['cb_nuggets_lg'] = {
		label = 'Large Chicken Nuggets',
		weight = 200,
		description = 'Large chicken nuggets from Cluckin Bell.',
		client = {
			image = 'cb_nuggets_lg.png',
		}
	},

	--// Side Items for Cluckin Bell
	
	-- Mac N' Cheese
	['cb_macncheese'] = {
		label = 'Mac N Cheese',
		weight = 200,
		description = 'Mac N Cheese from Cluckin Bell.',
		client = {
			image = 'cb_macncheese.png',
		}
	},

	['cb_macncheesesupplies'] = {
		label = 'Mac Supplies',
		weight = 200,
		description = 'Supplies to make mac n cheese.',
		client = {
			image = 'macncheese.png',
		}
	},

	-- Mashed Potatoes
	['cb_mashedpotatoes'] = {
		label = 'Mashed Potatoes',
		weight = 200,
		description = 'Mashed potatoes from Cluckin Bell.',
		client = {
			image = 'cb_mashedpotatoes.png',
		}
	},

	['cb_potatoes'] = {
		label = 'Potatoes',
		weight = 200,
		description = 'A handfull of potatoes for Cluckin Bell.',
		client = {
			image = 'potatos.png',
		}
	},



	-- French Fries

	['cb_fries_sm'] = {
		label = 'Small French Fries',
		weight = 200,
		description = 'Small fries from Cluckin Bell.',
		client = {
			image = 'cb_fries_sm.png',
		}
	},

	['cb_fries_md'] = {
		label = 'Medium French Fries',
		weight = 200,
		description = 'Medium fries from Cluckin Bell.',
		client = {
			image = 'cb_fries_md.png',
		}
	},

	['cb_fries_lg'] = {
		label = 'Large French Fries',
		weight = 200,
		description = 'Large fries from Cluckin Bell.',
		client = {
			image = 'cb_fries_lg.png',
		}
	},

	-- Onion Rings

	['cb_onionrings_sm'] = {
		label = 'Small Onion Rings',
		weight = 200,
		description = 'Delicious onion rings from Cluckin Bell.',
		client = {
			image = 'cb_onionrings_sm.png',
		}
	},

	['cb_onionrings_md'] = {
		label = 'Medium Onion Rings',
		weight = 200,
		description = 'Delicious, yet filling medium order of onion rings from Cluckin Bell!',
		client = {
			image = 'cb_onionrings_md.png',
		}
	},

	['cb_onionrings_lg'] = {
		label = 'Large Onion Rings',
		weight = 200,
		description = 'Delicious, yet filling large order of onion rings from Cluckin Bell!',
		client = {
			image = 'cb_onionrings_lg.png',
		}
	},

	--// Dessert Items for Cluckin Bell
	-- Ice Cream

	['cb_icecream_van'] = {
		label = 'Vanilla Icecream',
		weight = 200,
		description = 'Delicious vanilla ice cream from Cluckin Bell.',
		client = {
			image = 'cb_icecream_van.png',
		}
	},

	['cb_icecream_straw'] = {
		label = 'Strawberry Icecream',
		weight = 200,
		description = 'Delicious strawberry ice cream from Cluckin Bell.',
		client = {
			image = 'cb_icecream_straw.png',
		}
	},

	['cb_icecream_choc'] = {
		label = 'Chocolate Icecream',
		weight = 200,
		description = 'Delicious chocolate ice cream from Cluckin Bell.',
		client = {
			image = 'cb_icecream_choc.png',
		}
	},

	['cb_icecream_mint'] = {
		label = 'Mint Icecream',
		weight = 200,
		description = 'Delicious mint ice cream from Cluckin Bell.',
		client = {
			image = 'cb_icecream_mint.png',
		}
	},

	--// Drink Items for Cluckin Bell
	---- Coffee
	---- Empty
	['cb_coffee_sm_empty'] = {
		label = 'Empty Small Coffee Cup',
		weight = 200,
		description = 'Delicious mint ice cream from Cluckin Bell.',
		client = {
			image = 'cb_coffee_sm_empty.png',
		}
	},

	['cb_coffee_lg_empty'] = {
		label = 'Empty Large Coffee Cup',
		weight = 200,
		description = 'Delicious mint ice cream from Cluckin Bell.',
		client = {
			image = 'cb_coffee_sm_empty.png',
		}
	},

	---- Full

	['cb_coffee_sm_full'] = {
		label = 'Small Coffee',
		weight = 200,
		description = 'A full small cup of coffee from Cluckin Bell.',
		client = {
			image = 'cb_coffee_sm_full.png',
		}
	},

	['cb_coffee_lg_full'] = {
		label = 'Empty Large Coffee Cup',
		weight = 200,
		description = 'A full large cup of coffee from Cluckin Bell.',
		client = {
			image = 'cb_coffee_sm_empty.png',
		}
	},

	-- Soda
	['cb_drinkcup_empty'] = {
		label = 'Empty Soda Cup',
		weight = 200,
		description = 'A full large cup of coffee from Cluckin Bell.',
		client = {
			image = 'cb_drinkcup_empty.png',
		}
	},

	['cb_drinkcup_full'] = {
		label = 'Cup of Soda',
		weight = 200,
		description = 'A full cup of soda from Cluckin Bell.',
		client = {
			image = 'cb_drinkcup_full.png',
		}
	},

	-- New Consumables System Items!!!! Woot woot!!!
	--// Food Items
	['pixelsandwich'] = {
        label = 'Sandwich',
        weight = 200,
        description = 'Yummy food!',
        client = { 
			image = 'pixelsandwich.png', 
		}
    },

    ['pixelbowlachilli'] = {
        label = 'Chilli Bowl',
        weight = 200,
        description = 'Yummy food!',
        client = { 
			image = 'pixelbowlachilli.png', 
		}
    },

    ['pixelbowlapozole'] = {
        label = 'Pozole',
        weight = 200,
        description = 'Yummy food!',
        client = { 
			image = 'pixelbowlapozole.png', 
		}
    },

    ['pixelburger'] = {
        label = 'Burger',
        weight = 200,
        description = 'Yummy food!',
        client = { 
			image = 'pixelburger.png', 
		}
    },

    ['pixeltaco'] = {
        label = 'Taco',
        weight = 200,
        description = 'Yummy food!',
        client = { 
			image = 'pixeltaco.png', 
		}
    },

	--// Snack Items
	['pixelegochaserbar'] = {
        label = 'Egochaser',
        weight = 200,
        stack = true,
        close = true,
        description = 'Yummy snack!',
        client = {
            image = 'pixelegochaserbar.png',
        }
    },

    ['pixelmeteoritebar'] = {
        label = 'Meteorite',
        weight = 200,
        stack = true,
        close = true,
        description = 'Yummy snack!',
        client = {
            image = 'pixelmeteoritebar.png',
        }
    },

    ['pixelearthquakebar'] = {
        label = 'Earthquake',
        weight = 200,
        stack = true,
        close = true,
        description = 'Yummy snack!',
        client = {
            image = 'pixelearthquakebar.png',
        }
    },

	--// Desert Items
	['pixelmuffin'] = {
        label = "Muffin",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelmuffin.png",
        }
    },

    ['pixelcakeslice'] = {
        label = "Cake Slice",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelcakeslice.png",
        }
    },

    ['pixelcookie'] = {
        label = "Cookie",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelcookie.png",
        }
    },

    ['pixelchococookie'] = {
        label = "Chocolate Cookie",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelchococookie.png",
        }
    },

    ['pixelchocodonut'] = {
        label = "Chocolate Donut",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelchocodonut.png",
        }
    },

    ['pixelstrawdonut'] = {
        label = "Strawberry Donut",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelstrawdonut.png",
        }
    },

    ['pixelchocoicecone'] = {
        label = "Chocolate Ice Cream",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelchocoicecone.png",
        }
    },

    ['pixelstrawicecone'] = {
        label = "Strawberry Ice Cream",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelstrawicecone.png",
        }
    },

    ['pixelvanillaicecone'] = {
        label = "Vanilla Ice Cream",
        weight = 200,
        stack = true,
        close = true,
        description = "Yummy dessert!",
        client = {
            image = "pixelvanillaicecone.png",
        }
    },

	--// Drink Items
	['pixelcola'] = {
        label = "Cola",
        weight = 200,
        stack = true,
        close = true,
        description = "Tasty drink!",
        client = {
            image = "pixelcola.png",
        }
    },

    ['pixelsprunk'] = {
        label = "Sprunk",
        weight = 200,
        stack = true,
        close = true,
        description = "Tasty drink!",
        client = {
            image = "pixelsprunk.png",
        }
    },

    ['pixelorangotang'] = {
        label = "OrangOTang",
        weight = 200,
        stack = true,
        close = true,
        description = "Tasty drink!",
        client = {
            image = "pixelorangotang.png",
        }
    },

    ['pixeljunkenergy'] = {
        label = "Junk Energy",
        weight = 200,
        stack = true,
        close = true,
        description = "Tasty drink!",
        client = {
            image = "pixeljunkenergy.png",
        }
    },

    ['pixelcoffee'] = {
        label = "Coffee",
        weight = 200,
        stack = true,
        close = true,
        description = "Tasty drink!",
        client = {
            image = "pixelcoffee.png",
        }
    },

    ['pixelwater'] = {
        label = "Water Bottle",
        weight = 200,
        stack = true,
        close = true,
        description = "Tasty drink!",
        client = {
            image = "pixelwater.png",
        }
    },

	--// Alcohol Items
	['pixelwhiskey'] = {
        label = "Whiskey",
        weight = 200,
        stack = true,
        close = true,
        description = "Let's get drunk!",
        client = {
            image = "pixelwhiskey.png",
        }
    },
    ['pixelbeer'] = {
        label = "Beer",
        weight = 200,
        stack = true,
        close = true,
        description = "Let's get drunk!",
        client = {
            image = "pixelbeer.png",
        }
    },
    ['pixelvodka'] = {
        label = "Vodka",
        weight = 200,
        stack = true,
        close = true,
        description = "Let's get drunk!",
        client = {
            image = "pixelvodka.png",
        }
    },
    ['pixelchampagne'] = {
        label = "Champagne",
        weight = 200,
        stack = true,
        close = true,
        description = "Let's get drunk!",
        client = {
            image = "pixelchampagne.png",
        }
    },
    ['pixeltequilla'] = {
        label = "Tequila",
        weight = 200,
        stack = true,
        close = true,
        description = "Let's get drunk!",
        client = {
            image = "pixeltequilla.png",
        }
    },
    ['pixelwine'] = {
        label = "Wine",
        weight = 200,
        stack = true,
        close = true,
        description = "Let's get drunk!",
        client = {
            image = "pixelwine.png",
        }
    },

	--// Drug Items
	['pixelcigs'] = {
        label = "Redwood Cigarettes",
        weight = 250,
        stack = false, -- Unique item, so it doesn't stack
        close = true,
        description = "Pack of Cigarettes, Made in USA",
        client = {
            image = "pixelcigs.png",
        }
    },

    ['pixelcigarette'] = {
        label = "Cigarette",
        weight = 250,
        stack = true,
        close = true,
        description = "Smokeable Tobacco",
        client = {
            image = "pixelcigarette.png",
        }
    },

    ['pixeljoint'] = {
        label = "Joint",
        weight = 0,
        stack = true,
        close = true,
        description = "To chill out",
        client = {
            image = "pixeljoint.png",
        }
    },

    ['pixelcocaine'] = {
        label = "Cocaine",
        weight = 0,
        stack = true,
        close = true,
        description = "To chill out",
        client = {
            image = "pixelcocaine.png",
        }
    },

    ['pixelmeth'] = {
        label = "Meth",
        weight = 0,
        stack = true,
        close = true,
        description = "To chill out",
        client = {
            image = "pixelmeth.png",
        }
    },

    ['pixelshrooms'] = {
        label = "Shrooms",
        weight = 0,
        stack = true,
        close = true,
        description = "To chill out",
        client = {
            image = "pixelshrooms.png",
        }
    },

    ['pixelecstasy'] = {
        label = "Ecstasy",
        weight = 0,
        stack = true,
        close = true,
        description = "To chill out",
        client = {
            image = "pixelecstasy.png",
        }
    },
	
    ['pixeloxy'] = {
        label = "Oxy",
        weight = 0,
        stack = true,
        close = true,
        description = "To chill out",
        client = {
            image = "pixeloxy.png",
        }
    },

	-- Rahe Boosting Tablet
	['boostingtablet'] = {
		label = 'Boosting tablet',
		weight = 0,
		description = "Seems like something's installed on this.",
		client = {
		export = 'rahe-boosting.boostingtablet',
		image = "boostingtablet.png",
		}
	},

	['hackingdevice'] = {
		label = 'Hacking device',
		weight = 0,
		description = 'Will allow you to bypass vehicle security systems.',
		client = {
		export = 'rahe-boosting.hackingdevice',
		image = "hackingdevice.png",
		}
	},

	['gpshackingdevice'] = {
		label = 'GPS hacking device',
		weight = 0,
		description = 'If you wish to disable vehicle GPS systems.',
		client = {
		export = 'rahe-boosting.gpshackingdevice',
		image = "gpshackingdevice.png",
		}
	},
	

	-- Rahe Racing Tablet
	['racingtablet'] = {
		label = 'Racing tablet',
		weight = 500,
		description = 'Seems like something to do with cars.',
		stack = false,
		client = {
			export = 'rahe-racing.racingtablet',
			image = 'racingtablet.png',
		}
	},

	-- Mrnewb Vehicle Keys System
	['vehiclekeys'] = {
        label = 'Vehicle Keys',
        weight = 220,
        stack = false,
        close = true,
        description = "Keys To A Car",
		client = {
			image = "vehiclekeys.png",
		}
    },

    ['aftermarket_locks'] = {
        label = 'Aftermarket Locks',
        weight = 220,
        stack = false,
        close = true,
        description = "Aftermarket Lock System",
		client = {
			image = "fobicon.png",
		}
    },

    ['keyring'] = {
        label = 'Keyring',
        weight = 220,
        stack = false,
        close = true,
        description = "A keyring for your vehicle keys!",
		client = {
			image = "keyring.png",
		}
    },

	-- Jaksam Drugs Creator
	["ammonium_nitrate"] = {
		label = "Ammonium Nitrate",
		weight = 500,
		stack = true,
		close = false,
		description = "A chemical compound.",
		client = {
			image = "ammonium_nitrate.png",
		}
	},

	["carbon"] = {
		label = "Carbon",
		weight = 500,
		stack = true,
		close = false,
		description = "Pure carbon material.",
		client = {
			image = "carbon.png",
		}
	},

	["codeine"] = {
		label = "Codeine",
		weight = 500,
		stack = true,
		close = false,
		description = "A prescription opioid medication.",
		client = {
			image = "codeine.png",
		}
	},

	["drink_sprite"] = {
		label = "Sprite",
		weight = 500,
		stack = true,
		close = false,
		description = "A refreshing soft drink.",
		client = {
			image = "drink_sprite.png",
		}
	},

	["drug_ecstasy"] = {
		label = "Ecstasy",
		weight = 500,
		stack = true,
		close = false,
		description = "A psychoactive drug.",
		client = {
			image = "drug_ecstasy.png",
		}
	},

	["drug_lean"] = {
		label = "Lean",
		weight = 500,
		stack = true,
		close = false,
		description = "A recreational drug drink.",
		client = {
			image = "drug_lean.png",
		}
	},

	["drug_lsd"] = {
		label = "LSD",
		weight = 500,
		stack = true,
		close = false,
		description = "A hallucinogenic drug.",
		client = {
			image = "drug_lsd.png",
		}
	},

	["drug_meth"] = {
		label = "Meth",
		weight = 500,
		stack = true,
		close = false,
		description = "A highly addictive stimulant.",
		client = {
			image = "drug_meth.png",
		}
	},

	["hydrogen"] = {
		label = "Hydrogen",
		weight = 500,
		stack = true,
		close = false,
		description = "A chemical element.",
		client = {
			image = "hydrogen.png",
		}
	},

	["ice"] = {
		label = "Ice",
		weight = 500,
		stack = true,
		close = false,
		description = "Frozen water.",
		client = {
			image = "ice.png",
		}
	},

	["jolly_ranchers"] = {
		label = "Jolly Ranchers",
		weight = 500,
		stack = true,
		close = false,
		description = "A popular hard candy.",
		client = {
			image = "jolly_ranchers.png",
		}
	},

	["liquid_sulfur"] = {
		label = "Liquid Sulfur",
		weight = 500,
		stack = true,
		close = false,
		description = "A chemical substance.",
		client = {
			image = "liquid_sulfur.png",
		}
	},

	["muriatic_acid"] = {
		label = "Muriatic Acid",
		weight = 500,
		stack = true,
		close = false,
		description = "A highly corrosive acid.",
		client = {
			image = "muriatic_acid.png",
		}
	},

	["nitrogen"] = {
		label = "Nitrogen",
		weight = 500,
		stack = true,
		close = false,
		description = "A common gas in the atmosphere.",
		client = {
			image = "nitrogen.png",
		}
	},

	["oxygen"] = {
		label = "Oxygen",
		weight = 500,
		stack = true,
		close = false,
		description = "Essential for breathing.",
		client = {
			image = "oxygen.png",
		}
	},

	["pseudoefedrine"] = {
		label = "Pseudoefedrine",
		weight = 500,
		stack = true,
		close = false,
		description = "A common ingredient in decongestants.",
		client = {
			image = "pseudoefedrine.png",
		}
	},

	["red_sulfur"] = {
		label = "Red Sulfur",
		weight = 500,
		stack = true,
		close = false,
		description = "A variant of sulfur used in chemical processes.",
		client = {
			image = "red_sulfur.png",
		}
	},

	["sodium_hydroxide"] = {
		label = "Sodium Hydroxide",
		weight = 500,
		stack = true,
		close = false,
		description = "A strong alkali used in many industries.",
		client = {
			image = "sodium_hydroxide.png",
		}
	},

	["water"] = {
		label = "Water",
		weight = 500,
		stack = true,
		close = false,
		description = "Essential for life.",
		client = {
			image = "water.png",
		}
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 500,
		stack = true,
		close = false,
		description = "A widely known plant with various uses.",
		client = {
			image = "cannabis.png",
		}
	},

	["green_gelato_cannabis"] = {
		label = "Green Gelato Cannabis",
		weight = 500,
		stack = true,
		close = false,
		description = "A specific strain of cannabis.",
		client = {
			image = "green_gelato_cannabis.png",
		}
	},

	["opium"] = {
		label = "Opium",
		weight = 500,
		stack = true,
		close = false,
		description = "A substance derived from poppies.",
		client = {
			image = "opium.png",
		}
	},

	["cocaine"] = {
		label = "Cocaine",
		weight = 500,
		stack = true,
		close = false,
		description = "A powerful stimulant drug.",
		client = {
			image = "cocaine.png",
		}
	},

	["coke_pooch"] = {
		label = "Cocaine Baggie",
		weight = 100,
		stack = true,
		close = true,
		description = "A baggie of cocaine",
		client = {
			image = "coke_pooch.png",
		}
	},

	['weed_ak47'] = {
		label = 'AK47',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_ak47.png',
		}
	},
	
	['weed_amnesia'] = {
		label = 'Amnesia',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_amnesia.png',
		}
	},
	
	['weed_zkittlez'] = {
		label = 'Zkittlez',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_zkittlez.png',
		}
	},
	
	['weed_ogkush'] = {
		label = 'OGKush',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_ogkush.png',
		}
	},
	
	['weed_purplehaze'] = {
		label = 'Purple Haze',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_purplehaze.png',
		}
	},
	
	['weed_skunk'] = {
		label = 'Skunk',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_skunk.png',
		}
	},
	
	['weed_whitewidow'] = {
		label = 'White Widow',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'weed_whitewidow.png',
		}
	},
	
	['weed_gelato'] = {
		label = 'Gelato',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'weed_gelato.png',
		}
	},
	
	['untrimmed_ak47'] = {
		label = 'AK47',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'untrimmed_ak47.png',
		}
	},
	
	['untrimmed_amnesia'] = {
		label = 'Amnesia',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'untrimmed_amnesia.png',
		}
	},
	
	['untrimmed_zkittlez'] = {
		label = 'Zkittlez',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'untrimmed_zkittlez.png',
		}
	},
	
	['untrimmed_ogkush'] = {
		label = 'OGKush',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'untrimmed_ogkush.png',
		}
	},
	
	['untrimmed_purplehaze'] = {
		label = 'Purple Haze',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'untrimmed_purplehaze.png',
		}
	},
	
	['untrimmed_skunk'] = {
		label = 'Skunk',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'untrimmed_skunk.png',
		}
	},
	
	['untrimmed_whitewidow'] = {
		label = 'White Widow',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'untrimmed_whitewidow.png',
		}
	},
	
	['untrimmed_gelato'] = {
		label = 'Gelato',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'untrimmed_gelato.png',
		}
	},
	
	['weed_ak47_baggy'] = {
		label = 'AK47',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_ak47_baggy.png',
		}
	},
	
	['weed_amnesia_baggy'] = {
		label = 'Amnesia',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_amnesia_baggy.png',
		}
	},
	
	['weed_zkittlez_baggy'] = {
		label = 'Zkittlez',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_zkittlez_baggy.png',
		}
	},
	
	['weed_ogkush_baggy'] = {
		label = 'OGKush',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_ogkush_baggy.png',
		}
	},
	
	['weed_purplehaze_baggy'] = {
		label = 'Purple Haze',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_purplehaze_baggy.png',
		}
	},
	
	['weed_skunk_baggy'] = {
		label = 'Skunk',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_skunk_baggy.png',
		}
	},
	
	['weed_whitewidow_baggy'] = {
		label = 'White Widow',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'weed_whitewidow_baggy.png',
		}
	},
	
	['weed_gelato_baggy'] = {
		label = 'Gelato',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'weed_gelato_baggy.png',
		}
	},
	
	['weed_ak47_joint'] = {
		label = 'AK47',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_ak47_joint.png',
		}
	},
	
	['weed_amnesia_joint'] = {
		label = 'Amnesia',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_amnesia_joint.png',
		}
	},
	
	['weed_zkittlez_joint'] = {
		label = 'Zkittlez',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_zkittlez_joint.png',
		}
	},
	
	['weed_ogkush_joint'] = {
		label = 'OGKush',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_ogkush_joint.png',
		}
	},
	
	['weed_purplehaze_joint'] = {
		label = 'Purple Haze',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_purplehaze_joint.png',
		}
	},
	
	['weed_skunk_joint'] = {
		label = 'Skunk',
		weight = 100,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'weed_skunk_joint.png',
		}
	},
	
	['weed_whitewidow_joint'] = {
		label = 'White Widow',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'weed_whitewidow_joint.png',
		}
	},
	
	['weed_gelato_joint'] = {
		label = 'Gelato',
		weight = 100,
		stack = true,
		close = false,
		description = '',
		client = {
			image = 'weed_gelato_joint.png',
		}
	},
	
	["bong"] = {
		label = "Bong",
		weight = 1000,
		stack = false,
		close = true,
		description = "A glass pipe for smoking tobacco",
		client = {
			image = "bong.png",
		}
	},
	['weed_bud'] = {
		label = 'Weed Bud',
		description = "Needs to be clean at the table",
		weight = 40,
		stack = true
	},

	['weed_blunt'] = {
		label = 'Blunt',
		description = "Enjoy your weed!",
		weight = 90,
		stack = true,
		close = true
	},

	['weed_wrap'] = {
		label = 'Blunt wraps',
		description = "Get Weed Bag and roll blunt!",
		weight = 75,
		stack = true,
		close = true
	},

	['weed_papers'] = {
		label = 'Weed papers',
		description = "Get Weed Bag and roll joint!",
		weight = 15,
		stack = true,
		close = true
	},

	['weed_joint'] = {
		label = 'Joint',
		description = "Enjoy your weed!",
		weight = 50,
		stack = true,
		close = true
	},

	['weed_budclean'] = {
		label = 'Weed Bud',
		description = "You can pack this at the table",
		weight = 35,
		stack = true
	},

	-- Lation Car Chopping
	['auto_parts'] = {
		label = 'Auto Parts',
		weight = 5,
		client = {
			image = "auto_parts.png",
		}
	},

	['chop_lockpick'] = {
		label = 'Lockpick',
		weight = 150,
		client = {
			image = "chop_lockpick.png",
		}
	},

	['chop_torch'] = {
		label = 'Torch',
		weight = 275,
		client = {
			image = "chop_torch.png",
		}
	},

	['chop_lugwrench'] = {
		label = 'Lug Wrench',
		weight = 225,
		client = {
			image = "chop_lugwrench.png",
		}
	},

	['speaker'] = {
		label = 'Speaker',
		weight = 0,
		description = 'Speaker.',
		consume = 0,
		client = {
			image = 'speaker.png',
		},
		server = {
			export = 'rahe-speakers.speaker',
			
		}
	},

    	-- Renewed Business Creator
    	-- // Business Items // --
     
    ['business_tempitem'] = {
        label = "how did you get this?",
        weight = 0,
        stack = true,
        close = true,
        consume = 0,
        server = {
            export = 'Renewed-Businesses.useItem',
        }
    },
     
    -- Kitchen Tools --
     
    ['kitchenknife'] = {
    	label = 'Kitchen Knife',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['cleaver'] = {
    	label = 'Meat Cleaver',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['blender'] = {
    	label = 'Blender',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['whisk'] = {
    	label = 'Whisks',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['slicer'] = {
    	label = 'Slicer',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['potatopusher'] = {
    	label = 'Potato Pusher',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['peeler'] = {
    	label = 'Peeler',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['scooper'] = {
    	label = 'Scooper',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    ['grater'] = {
    	label = 'Grater',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,  
    },
     
    -- Fruit --
     
    ['strawberry'] = {
    	label = 'Strawberries',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutstrawberry'] = {
    	label = 'Cut Strawberries',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['strawberryjuice'] = {
    	label = 'Strawberry Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['apples'] = {
    	label = 'Apples',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutapples'] = {
    	label = 'Cut Apples',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['applejuice'] = {
    	label = 'Apple Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['pickle'] = {
    	label = 'Pickles',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutpickle'] = {
    	label = 'Cut Pickles',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['pineapple'] = {
    	label = 'Pineapples',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutpineapple'] = {
    	label = 'Cut Pineapple',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['pineapplejuice'] = {
    	label = 'Pineapple Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['orange'] = {
    	label = 'Oranges',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutorange'] = {
    	label = 'Cut Oranges',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['orangejuice'] = {
    	label = 'Orange Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['blueberry'] = {
    	label = 'Blueberries',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutblueberry'] = {
    	label = 'Cut Blueberries',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['blueberryjuice'] = {
    	label = 'Blueberry Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['boba'] = {
    	label = 'Boba',
    	weight = 50,   
    	foodType = 'food',
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['lime'] = {
    	label = 'Limes',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10,  
    },
     
    ['cutlime'] = {
    	label = 'Cut Limes',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['limejuice'] = {
    	label = 'Lime Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['banana'] = {
    	label = 'Bananas',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	}, 
    },
     
    ['cutbananas'] = {
    	label = 'Cut Bananas',
    	weight = 50,   
    	foodType = {'food', 'drink'},
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['grapes'] = {
    	label = 'Grapes',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	}, 
    },
     
    ['grapejuice'] = {
    	label = 'Grape Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['lemons'] = {
    	label = 'Lemons',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['lemonjuice'] = {
    	label = 'Lemon Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['cutlemon'] = {
    	label = 'Cut Lemon',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
     
    ['kiwi'] = {
    	label = 'Kiwi',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['cutkiwi'] = {
    	label = 'Cut Kiwi',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['cherry'] = {
    	label = 'Cherries',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['cherryjuice'] = {
    	label = 'Cherry Juice',
    	weight = 50,   
    	foodType = 'drink',
    	nutrition = {
    		healthy = 3,
    		thirst = 3,
    	},
    },
     
    ['lettuce'] = {
    	label = 'Lettuce Head',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['choplettuce'] = {
    	label = 'Chopped Lettuce',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['tomato'] = {
    	label = 'Tomatos',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['choptomato'] = {
    	label = 'Chopped Tomato',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['slicedtomato'] = {
    	label = 'Tomato Slices',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['potatoes'] = {
    	label = 'Potatoes',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['potatoslice'] = {
    	label = 'Sliced Potatoes',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		salt = 2,
    		hunger = 3,
    	},
    },
     
    ['potatoskins'] = {
    	label = 'Potato Skins',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		salt = 2,
    		hunger = 3,
    	},
    },
     
    ['choppotato'] = {
    	label = 'Chopped Potatoes',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		salt = 2,
    		hunger = 3,
    	},
    },
     
    ['squash'] = {
    	label = 'Squash',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chopsquash'] = {
    	label = 'Chopped Squash',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['spinach'] = {
    	label = 'Spinach',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chopspinach'] = {
    	label = 'Chopped Spinach',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['celery'] = {
    	label = 'Celery',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chopcelery'] = {
    	label = 'Chopped Celery',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['redpeppers'] = {
    	label = 'Red Peppers',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['slicedredpepper'] = {
    	label = 'Sliced Red Pepper',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['chopredpepper'] = {
    	label = 'Chopped Red Pepper',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['greenpeppers'] = {
    	label = 'Green Peppers',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['slicedgreenpepper'] = {
    	label = 'Sliced Green Pepper',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['chopgreenpepper'] = {
    	label = 'Chopped Green Pepper',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['hotpepper'] = {
    	label = 'Jalapeno Peppers',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chophotpepper'] = {
    	label = 'Chopped Jalapeno Pepper',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['carrots'] = {
    	label = 'Carrots',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chopcarrots'] = {
    	label = 'Chopped Carrots',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['cucumbers'] = {
    	label = 'Cucumbers',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chopcucumbers'] = {
    	label = 'Chopped Cucumbers',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['peas'] = {
    	label = 'Peas',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['greenbeans'] = {
    	label = 'Grean Beans',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['corn'] = {
    	label = 'Corn',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['cobcorn'] = {
    	label = 'Corn on the Cob',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    ['broccoli'] = {
    	label = 'Broccoli',
    	weight = 50,  
    	shopType = 'farmers',
    	price = 10, 
    },
     
    ['chopbroccoli'] = {
    	label = 'Chopped Broccoli',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		healthy = 3,
    		hunger = 3,
    	},
    },
     
    -- // Dairy // --
     
    ['milk'] = {
    	label = 'Milk',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = {'food', 'drink'},
    	nutrition = {
    		dairy = 3,
    		thirst = 3,
    	},
    },
     
    ['eggs'] = {
    	label = 'Eggs',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		protein = 2,
    		hunger = 3,
    	},
    },
     
    ['butter'] = {
    	label = 'Butter',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['condensedmilk'] = {
    	label = 'Condensed Milk',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['yogurt'] = {
    	label = 'Yogurt',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = {'food', 'drink'},
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    		thirst = 2,
    	},
    },
     
    ['mozzarella'] = {
    	label = 'Mozzarella Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    },
     
    ['cubemozzarella'] = {
    	label = 'Cubbed Mozzarella Cheese',
    	weight = 50,    
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['stringmozzarella'] = {
    	label = 'String Mozzarella Cheese',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['provolone'] = {
    	label = 'Provolone Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    },
     
    ['cubeprovolone'] = {
    	label = 'Cubbed Provolone Cheese',
    	weight = 50,    
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['stringprovolone'] = {
    	label = 'String Provolone Cheese',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['cheddar'] = {
    	label = 'Cheddar Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    },
     
    ['cubecheddar'] = {
    	label = 'Cubbed Cheddar Cheese',
    	weight = 50,    
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['stringcheddar'] = {
    	label = 'String Cheddar Cheese',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['bluecheese'] = {
    	label = 'Blue Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['parmesan'] = {
    	label = 'Parmesan Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    },
     
    ['parmesanflakes'] = {
    	label = 'Parmesan Flakes',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['ricotta'] = {
    	label = 'Ricotta Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['creamcheese'] = {
    	label = 'Cream Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['gouda'] = {
    	label = 'Cream Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['cottagecheese'] = {
    	label = 'Cottage Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['swiss'] = {
    	label = 'Swiss Cheese',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    ['icecream'] = {
    	label = 'Ice Cream',
    	weight = 50,   
    	shopType = 'dairy',
    	price = 10, 
    	foodType = {'food', 'drink'},
    	nutrition = {
    		dairy = 3,
    		hunger = 3,
    	},
    },
     
    -- // Meat // --
     
     
    ['bologna'] = {
    	label = 'Bologna',
    	weight = 50,   
    	shopType = 'butcher',
    	price = 10, 
    	foodType = 'food',
    },
     
     
    ['slicedbologna'] = {
    	label = 'Sliced Bologna',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 5,
    	},
    },
     
    ['wholeham'] = {
    	label = 'Whole Ham',
    	weight = 50,   
    	shopType = 'butcher',
    	price = 10, 
    	foodType = 'food',
    },
     
    ['bacon'] = {
    	label = 'Bacon Strips',
    	weight = 50,   
    	foodType = 'food',
    	shopType = 'butcher',
    	price = 10,
    	nutrition = {
    		protein = 3,
    		hunger = 5,
    	},
    },
     
    ['baconbits'] = {
    	label = 'Bacon Bits',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 5,
    	},
    },
     
    ['meatslab'] = {
    	label = 'Slab of Meat',
    	weight = 50,   
    	shopType = 'butcher',
    	price = 10, 
    	foodType = 'food',
    },
     
    ['nystrip'] = {
    	label = 'Raw NY Stip',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 4,
    		hunger = 8,
    	},
    },
     
    ['filet'] = {
    	label = 'Raw Beef Tenderloin',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 7,
    	},
    },
     
    ['ribs'] = {
    	label = 'Ribs',
    	weight = 50,   
    	shopType = 'butcher',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		protein = 4,
    		hunger = 8,
    	},
    },
     
    ['hotdog'] = {
    	label = 'Hotdogs',
    	weight = 50,   
    	shopType = 'butcher',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 4,
    	},
    },
     
    ['roastbeef'] = {
    	label = 'Roast Beef',
    	weight = 50,   
    	shopType = 'butcher',
    	price = 10, 
    	foodType = 'food',
    	nutrition = {
    		protein = 4,
    		hunger = 6,
    	},
    },
     
    ['slicedham'] = {
    	label = 'Sliced Ham',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 6,
    	},
    },
     
    ['dicedham'] = {
    	label = 'Diced Ham',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 4,
    	},
    },
     
    ['frozennuggets'] = {
    	label = 'Frozen Nuggets',
    	weight = 50,  
    	shopType = 'butcher',
    	price = 10,  
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 6,
    	},
    },
     
    ['frozenchickenpatty'] = {
    	label = 'Frozen Chicken Patty',
    	weight = 50,  
    	shopType = 'butcher',
    	price = 10,  
    	foodType = 'food',
    	nutrition = {
    		protein = 4,
    		hunger = 5,
    	},
    },
     
    ['frozenbeefpatty'] = {
    	label = 'Beef Patty',
    	weight = 50,  
    	shopType = 'butcher',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		protein = 4,
    		hunger = 6,
    	},
    },
     
    ['pepperoni'] = {
    	label = 'Pepperoni',
    	weight = 50,  
    	shopType = 'butcher',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 4,
    	},
    },
     
    ['packagedchicken'] = {
    	label = 'Packaged Chicken',
    	weight = 50,  
    	shopType = 'butcher',
    	price = 10,   
    	foodType = 'food',
    },
     
    ['venison'] = {
    	label = 'Hunting Meat',
    	weight = 50,  
    	foodType = 'food',
    	nutrition = {
    		protein = 6,
    		hunger = 13,
    	},
    },
     
    ['chickenstrips'] = {
    	label = 'Chicken Strips',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 4,
    	},
    },
     
    ['chickenwings'] = {
    	label = 'Chicken Wings',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 4,
    		hunger = 5,
    	},
    },
     
    ['catfishfilet'] = {
    	label = 'Catfish Filet',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 7,
    	},
    },
     
    ['redfishfilet'] = {
    	label = 'Redfish Filet',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 7,
    	},
    },
     
    ['salomfilet'] = {
    	label = 'Salmon Filet',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 6,
    	},
    },
     
    ['tunafilet'] = {
    	label = 'Tuna Filet',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 8,
    	},
    },
     
    ['stripedbassfilet'] = {
    	label = 'Stripped Bass Filet',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 5,
    	},
    },
     
    ['rawsquid'] = {
    	label = 'Raw Squid',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		protein = 3,
    		hunger = 4,
    	},
    },
     
    -- // Bread/Carbs  // -- 
     
    ['breadloaf'] = {
    	label = 'Bread Loaf',
    	weight = 50,   
    	foodType = 'food',
    	shopType = 'bakery',
    	price = 10, 
    },
     
    ['flour'] = {
    	label = 'Flour',
    	weight = 50,   
    	foodType = 'food',
    	shopType = 'bakery',
    	price = 10, 
    },
     
    ['hotdogbun'] = {
    	label = 'Hot Dog Buns',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 3,
    	},
    },
     
    ['burgerbuns'] = {
    	label = 'Burger Buns',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 4,
    	},
    },
     
    ['flatbread'] = {
    	label = 'Flat Bread',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 3,
    	},
    },
     
    ['bagel'] = {
    	label = 'Bagel',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 3,
    	},
    },
     
    ['pizzadough'] = {
    	label = 'Yeast',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 2,
    		hunger = 6,
    	}, 
    },
     
    ['sandwichbread'] = {
    	label = 'Sandwich Bread',
    	weight = 50,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 3,
    		hunger = 2,
    	}, 
    },
     
    ['fettuccine'] = {
    	label = 'Fettuccine Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 5,
    		hunger = 4,
    	},
    },
     
    ['spaghetti'] = {
    	label = 'Spaghetti Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 5,
    		hunger = 4,
    	},
    },
     
    ['tortellini'] = {
    	label = 'Tortellini Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 5,
    		hunger = 4,
    	},
    },
     
    ['linguine'] = {
    	label = 'Linguine Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 5,
    		hunger = 4,
    	},
    },
     
    ['lasagna'] = {
    	label = 'Lasagna Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 5,
    		hunger = 4,
    	},
    },
     
    ['macaroni'] = {
    	label = 'Macaroni Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 5,
    	},
    },
     
    ['rigatoni'] = {
    	label = 'Macaroni Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 5,
    	},
    },
     
    ['ramen'] = {
    	label = 'Ramen Noodles',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 3,
    	},
    },
     
    ['rice'] = {
    	label = 'Rice',
    	weight = 50,  
    	shopType = 'bakery',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		carbs = 4,
    		hunger = 4,
    	},
    },
     
    -- // General Market // --
     
    ['coffeebean'] = {
    	label = 'Coffee Beans',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 4,
    		thirst = 5,
    		seasoning = 2,
    	},
    },
     
    ['ketchup'] = {
    	label = 'Ketchup',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		hunger = 2,
    		seasoning = 2,
    	},
    },
     
    ['mustard'] = {
    	label = 'Mustard',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		hunger = 2,
    		seasoning = 2,
    	},
    },
     
    ['bbqsauce'] = {
    	label = 'BBQ Sauce',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		hunger = 2,
    		seasoning = 4,
    	},
    },
     
    ['mint'] = {
    	label = 'Mint',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		hunger = 2,
    		seasoning = 3,
    	},
    },
     
    ['sauce'] = {
    	label = 'Generic Sauce',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		hunger = 3,
    		seasoning = 2,
    	},
    },
     
    ['chips'] = {
    	label = 'Potato Chips',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		hunger = 3,
    	},
    },
     
    ['chocolatecandies'] = {
    	label = 'Chocolate Candy',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 3,
    		seasoning = 1,
    		hunger = 1,
    	},
    },
     
    ['chocolatesyrup'] = {
    	label = 'Chocolate Syrup',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 3,
    		seasoning = 1,
    		hunger = 1,
    	},
    },
     
    ['sprinkles'] = {
    	label = 'Assorted Sprinkles',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 2,
    		seasoning = 1,
    		hunger = 1,
    	},
    },
     
    ['candy'] = {
    	label = 'Assorted Candies',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 2,
    		seasoning = 1,
    		hunger = 1,
    	},
    },
     
    ['sugar'] = {
    	label = 'Sugar',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 2,
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
    ['brownsugar'] = {
    	label = 'Brown Sugar',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		sugar = 2,
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
     
    ['salt'] = {
    	label = 'Salt',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
    ['pepper'] = {
    	label = 'Pepper',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
    ['basil'] = {
    	label = 'Basil',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
    ['chilipowder'] = {
    	label = 'Chili Powder',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 3,
    		hunger = 1,
    	},
    },
     
    ['cinnamon'] = {
    	label = 'Cinnamon',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 3,
    		hunger = 1,
    	},
    },
     
    ['garlicpowder'] = {
    	label = 'Garlic Powder',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 3,
    		hunger = 1,
    	},
    },
     
    ['lemonpeper'] = {
    	label = 'Lemon Pepper',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 4,
    		hunger = 1,
    	},
    },
     
    ['nutmeg'] = {
    	label = 'Nutmeg',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
    ['onionpowder'] = {
    	label = 'Onion Powder',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 1,
    		hunger = 1,
    	},
    },
     
    ['oregano'] = {
    	label = 'Oregano',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 3,
    		hunger = 1,
    	},
    },
     
    ['paprika'] = {
    	label = 'Paprika',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
    ['pepperflakes'] = {
    	label = 'Red Pepper Flakes',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 3,
    		hunger = 1,
    	},
    },
     
    ['thyme'] = {
    	label = 'Thyme',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 1,
    		hunger = 1,
    	},
    },
     
    ['curry'] = {
    	label = 'Curry',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'food',
    	nutrition = {
    		seasoning = 2,
    		hunger = 1,
    	},
    },
     
     
     
    -- // Alchol // -- 
     
    ['gin'] = {
    	label = 'Gin',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    	},
    },
     
    ['vodka'] = {
    	label = 'Vodka',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    	},
    },
     
    ['whiskey'] = {
    	label = 'Whiskey',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    	},
    },
     
    ['cognac'] = {
    	label = 'Cognac',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    	},
    },
     
    ['rum'] = {
    	label = 'Rum',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    	},
    },
     
    ['olives'] = {
    	label = 'Olives',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = {'food', 'drink'},
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    		hunger = 2
    	},
    },
     
    ['tonic'] = {
    	label = 'Tonic',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		alcohol = 5,
    		thirst = 3,
    	},
    },
     
    ['carbonatedwater'] = {
    	label = 'Cabonated Water',
    	weight = 50,  
    	shopType = 'general',
    	price = 10,   
    	foodType = 'drink',
    	nutrition = {
    		thirst = 7,
    	},
    },
	
	-- Quasar Billing System
	['bill_paper'] = {
		label = 'Billing Paper',
		weight = 1,
		description = 'View your invoice',
		client = {
			image = 'bill_paper.png',
		}
	},

	-- Haute Strip Club
		-- DRINK INGREDIENTS
		ice = {
			label = "Ice",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "ice.png", 
			}
		},
		pineapplejuice = {
			label = "Pineapple Juice",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "pineapplejuice.png", 
			}
		},
		lemon = {
			label = "Lemon",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "lemon.png", 
			}
		},
		lime = {
			label = "Lime",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "lime.png", 
			}
		},
		sugar = {
			label = "Sugar",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "sugar.png", 
			}
		},
		mint = {
			label = "Mint",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "mint.png", 
			}
		},
		cocomilk = {
			label = "Coco Milk",
			weight = 10,
			stack = true,
			close = true,
			description = "Ingredients",
			client = { 
				image = "cocomilk.png",
			}
		},
	
		-- DRINKS
		bluelagoon = {
			label = "Blue Lagoon",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "bluelagoon.png",
			}
		},
		caipirinha = {
			label = "Caipirinha",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "caipirinha.png",
			}
		},
		pinacolada = {
			label = "Piña Colada",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "pinacolada.png", 
			}
		},
		maitai = {
			label = "Mai Tai",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "maitai.png",
			 }
		},
		mojito = {
			label = "Mojito",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "mojito.png",
			}
		},
		sanfrancisco = {
			label = "San Francisco",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "sanfrancisco.png", 
			}
		},
		gin = {
			label = "Gin",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "gin.png",
			}
		},
		rum = {
			label = "Rum",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "rum.png",
			}
		},
		whiskey = {
			label = "Whiskey",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "whiskey.png" ,
			}
		},
		vodka = {
			label = "Vodka",
			weight = 30,
			stack = true,
			close = true,
			description = "Alcoholic Drink",
			client = { 
				image = "vodka.png", 
			}
		},
		['baitcast_rod'] = {
			label = 'Baitcast Rod',
			weight = 20,
			stack = false,
			close = true,
			description = 'Baitcast Fishing Rod',
		},
		['spincast_rod'] = {
			label = 'Spincast Rod',
			weight = 20,
			stack = false,
			close = true,
			description = 'Spincast Fishing Rod',
		},
		['spinning_rod'] = {
			label = 'Spinning Rod',
			weight = 20,
			stack = false,
			close = true,
			description = 'Spinning Fishing Rod',
		},
		['worms'] = {
			label = 'Worms',
			weight = 1,
			stack = true,
			close = true,
			description = 'Fishing Bait',
		},
		['carp'] = {
			label = 'Carp',
			weight = 15,
			stack = true,
			close = true,
			description = 'Carp',
		},
		['pike'] = {
			label = 'Pike',
			weight = 15,
			stack = true,
			close = true,
			description = 'Pike',
		},
		['piranha'] = {
			label = 'Piranha',
			weight = 15,
			stack = true,
			close = true,
			description = 'Piranha',
		},
		['salmon'] = {
			label = 'Salmon',
			weight = 15,
			stack = true,
			close = true,
			description = 'Salmon',
		},
		['shark'] = {
			label = 'Shark',
			weight = 15,
			stack = true,
			close = true,
			description = 'Shark',
		},
		['net_sm'] = {
			label = 'Small Fishing Net',
			weight = 15,
			stack = true,
			close = true,
			description = 'Small Fishing Net',
		},
		['net_md'] = {
			label = 'Medium Fishing Net',
			weight = 40,
			stack = true,
			close = true,
			description = 'Medium Fishing Net',
		},
		['net_xl'] = {
			label = 'XL Fishing Net',
			weight = 100,
			stack = true,
			close = true,
			description = 'XL Fishing Net',
		},
		
		
		
	}
