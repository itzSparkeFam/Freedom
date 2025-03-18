Config = {

	BlipSprite = 237,
	BlipColor = 26,
	BlipText = 'Workbench',
	
	
	CraftingStopWithDistance = false, -- Crafting will stop when not near workbench
	
	ExperiancePerCraft = 10, -- The amount of experiance added per craft (100 Experiance is 1 level)
	
	HideWhenCantCraft = false, -- Instead of lowering the opacity it hides the item that is not craftable due to low level or wrong job
	
	Categories = {
	
	['misc'] = {
		Label = 'MISC',
		Image = 'fishingrod',
		Jobs = {}
	},
	['weapons'] = {
		Label = 'WEAPONS',
		Image = 'WEAPON_APPISTOL',
		Jobs = {}
	},
	['medical'] = {
		Label = 'MEDICAL',
		Image = 'bandage',
		Jobs = {}
	}
	
	
	},
	
	PermanentItems = { -- Items that dont get removed when crafting
		['wrench'] = true
	},
	
	Recipes = { -- Enter Item name and then the speed value! The higher the value the more torque
	
	['bandage'] = {
		Level = 0, -- From what level this item will be craftable
		Category = 'medical', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 5, -- The amount that will be crafted
		SuccessRate = 100, -- 100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 10, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['rubber'] = 1 -- item name and count, adding items that dont exist in database will crash the script
		}
	}, 
	
	['weapon_redarp'] = {
		Level = 8, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = true, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 300, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['steel'] = 2000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 2000,
			['iron'] = 2000
		}
	}, 
	['Weapon_bcar'] = {
		Level = 15, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = true, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 300, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['steel'] = 2000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 2000,
			['iron'] = 2000
		}
	}, 
	['weapon_woarp'] = {
		Level = 13, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = true, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 600, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['steel'] = 2000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 2000,
			['iron'] = 2000
		}
	}, 
	['weapon_blueglocks'] = {
		Level = 11, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = true, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 240, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 1000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 1000,
		}
	}, 
	['weapon_fn57'] = {
		Level = 10, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = true, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 240, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 1000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 1000,
		}
	},
	['at_clip_100_pistol'] = {
		Level = 10, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 240, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 1000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 1000,
		}
	},
	['at_clip_drum_rifle'] = {
		Level = 10, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 240, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 1000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 1000,
		}
	},
	['at_clip_extended_shotgun'] = {
		Level = 10, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 240, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 1000, -- item name and count, adding items that dont exist in database will crash the script
			['metalscrap'] = 1000,
		}
	}, 
	
	['boostingtablet'] = {
		Level = 7, -- From what level this item will be craftable
		Category = 'misc', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 5, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 30, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['metalscrap'] = 1500 -- item name and count, adding items that dont exist in database will crash the script
			
		}
	},
	['thermite_h'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'misc', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 90, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 100 -- item name and count, adding items that dont exist in database will crash the script
			
		}
	},
	['handcuffs'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'misc', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 90, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 90, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['steel'] = 250 -- item name and count, adding items that dont exist in database will crash the script
			
		}
	}

},

Workbenches = { -- Every workbench location, leave {} for jobs if you want everybody to access

		{coords = vector3(101.921, 6622.455, 31.787), jobs = {}, gangs = {}, blip = false, recipes = {'bandage', 'handcuffs'}, radius = 3.0 },
		{coords = vector3(-2186.555, 203.489, 194.602), jobs = {}, gangs = {}, blip = false, recipes = {}, radius = 1.0 },
		{coords = vector3(850.067, -2501.946, 40.686), jobs = {}, gangs = {}, blip = false, recipes = {}, radius = 1.0 },
		{coords = vector3(496.079, -1487.396, 29.297), jobs = {}, gangs = {}, blip = false, recipes = {}, radius = 1.0 }

},
 

Text = {

    ['not_enough_ingredients'] = 'You dont have enough ingredients',
    ['you_cant_hold_item'] = 'You cant hold the item',
    ['item_crafted'] = 'Item crafted!',
    ['wrong_job'] = 'You cant open this workbench',
    ['workbench_hologram'] = '[~b~E~w~] Workbench',
    ['wrong_usage'] = 'Wrong usage of command',
    ['inv_limit_exceed'] = 'Inventory limit exceeded! Clean up before you lose more',
    ['crafting_failed'] = 'You failed to craft the item!'

}

}



function SendTextMessage(msg)

        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)

        --EXAMPLE USED IN VIDEO
        --exports['mythic_notify']:SendAlert('inform', msg)

end