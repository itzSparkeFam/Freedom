Config = {};
Config.debug = false;
Config.InventoryImage = "ox_inventory/web/images"
Config.WhiteWidowJob = "whitewidow"
Config.BankingSystem = "custom" -- Supports: "Renewed" / "custom"
Config.BongItem = "bong"
Config.EmptyBagItem = "empty_weed_bag"
Config.WeedStrains = {
	'weed_ak47',
	'weed_amnesia',
	'weed_zkittlez',
	'weed_ogkush',
	'weed_purplehaze',
	'weed_skunk',
	'weed_whitewidow',
	'weed_gelato',
}
Config.Joints = { -- This is to make the items useable
	'weed_ak47_joint',
	'weed_amnesia_joint',
	'weed_zkittlez_joint',
	'weed_ogkush_joint',
	'weed_purplehaze_joint',
	'weed_skunk_joint',
	'weed_whitewidow_joint',
	'weed_gelato_joint',
}

Config.Business = {
	payment = {
		{
			label = "Charge Customer",
			icon = "fa-solid fa-cash-register",
			coords = vector3(188.98291015625, -241.13229370117, 54.313291168213),
			length = 0.55,
			width = 0.4,
			height = 0.5,
			heading = 70,
			debug = false
		},
		{
			label = "Charge Customer",
			icon = "fa-solid fa-cash-register",
			coords = vector3(188.10371398926, -243.5478515625, 54.313291168213),
			length = 0.55,
			width = 0.4,
			height = 0.5,
			heading = 70,
			debug = false
		}
	},
	duty = {
		{
			label = "Toggle Duty",
			icon = "fa-solid fa-toggle-on",
			coords = vector3(180.69221496582, -252.87266540527, 54.23431854248),
			length = 0.75,
			width = 0.75,
			height = 0.75,
			heading = -180,
			debug = false
		}
	},
	clothing = {
		{
			label = "Open Wardrobe",
			icon = "fa-solid fa-shirt",
			coords = vec3(184.35, -242.0, 54.55),
			length = 1.75,
			width = 0.75,
			height = 0.75,
			heading = -110,
			debug = false
		}
	},
	storage = {
		{
			label = "Open Storage",
			icon = "fa-solid fa-boxes-stacked",
			coords = vector3(184.3092803955078, -244.3968505859375, 53.81263732910156),
			name = "whitewidow1",
			length = 1,
			width = 1,
			height = 1.5,
			heading = -20,
			debug = false
		},
		{
			label = "Open Storage",
			icon = "fa-solid fa-boxes-stacked",
			coords = vector3(179.79244995117, -243.59541320801, 54.585441589355),
			name = "whitewidow2",
			length = 0.6,
			width = 2.5,
			height = 3,
			heading = -20,
			debug = false
		},
		{
			label = "White Widow",
			icon = "fa-solid fa-boxes-stacked",
			coords = vector3(188.58528137207, -242.24914550781, 54.221894836426),
			name = "whitewidow-counter",
			length = 0.6,
			width = 1.6,
			height = 0.3,
			heading = -20,
			debug = false
		}
	}
}

Config.WeedPlants = {
	[1] = {
		strain = "untrimmed_ak47",
		target = {
			label = "Harvest AK47",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(172.61622619629, -240.50639343262, 49.155345916748),
			vec3(171.8690032959, -240.23442077637, 49.155345916748),
			vec3(171.13494873047, -239.96723937988, 49.155345916748),
			vec3(170.39540100098, -239.69807434082, 49.155345916748),
			vec3(169.61750793457, -239.41493225098, 49.155345916748),
		},
		debug = false,
	},
	[2] = {
		strain = "untrimmed_amnesia",
		target = {
			label = "Harvest Amnesia",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(171.94297790527, -242.36625671387, 49.155345916748),
			vec3(171.20361328125, -242.09715270996, 49.155345916748),
			vec3(170.42361450195, -241.81326293945, 49.155345916748),
			vec3(169.68716430664, -241.54521179199, 49.155345916748),
			vec3(168.9409942627, -241.27362060547, 49.155345916748),

		},
		debug = false,
	},
	[3] = {
		strain = "untrimmed_zkittlez",
		target = {
			label = "Harvest Zkittlez",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(168.32975769043, -249.75643920898, 49.155345916748),
			vec3(168.72396850586, -248.67335510254, 49.155345916748),
			vec3(169.16719055176, -247.45559692383, 49.155345916748),
			vec3(169.63507080078, -246.17012023926, 49.155345916748),
			vec3(170.07159423828, -244.97076416016, 49.155345916748),
		},
		debug = false,
	},
	[4] = {
		strain = "untrimmed_ogkush",
		target = {
			label = "Harvest OG Kush",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(165.85287475586, -248.88671875, 49.155345916748),
			vec3(166.27278137207, -247.73301696777, 49.155345916748),
			vec3(166.67930603027, -246.61608886719, 49.155345916748),
			vec3(167.16284179688, -245.28762817383, 49.155345916748),
			vec3(167.60493469238, -244.0729675293, 49.155345916748),
		},
		debug = false,
	},
	[5] = {
		strain = "untrimmed_purplehaze",
		target = {
			label = "Harvest Purple Haze",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(163.21621704102, -247.88374328613, 49.155345916748),
			vec3(163.63145446777, -246.74285888672, 49.155345916748),
			vec3(164.06228637695, -245.5591583252, 49.155345916748),
			vec3(164.51225280762, -244.32289123535, 49.155345916748),
			vec3(164.95022583008, -243.11956787109, 49.155345916748),
		},
		debug = false,
	},
	[6] = {
		strain = "untrimmed_skunk",
		target = {
			label = "Harvest Skunk",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(160.67543029785, -246.97048950195, 49.155345916748),
			vec3(161.08367919922, -245.84884643555, 49.155345916748),
			vec3(161.53114318848, -244.61943054199, 49.155345916748),
			vec3(161.96322631836, -243.43228149414, 49.155345916748),
			vec3(162.40650939941, -242.21435546875, 49.155345916748),
		},
		debug = false,
	},
	[7] = {
		strain = "untrimmed_whitewidow",
		target = {
			label = "Harvest White Widow",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(162.78297424316, -239.05726623535, 49.155345916748),
			vec3(163.45333862305, -239.30125427246, 49.155345916748),
			vec3(164.18379211426, -239.56712341309, 49.155345916748),
			vec3(164.85986328125, -239.81318664551, 49.155345916748),
			vec3(165.55444335938, -240.0659942627, 49.155345916748),
		},
		debug = false,
	},
	[8] = {
		strain = "untrimmed_gelato",
		target = {
			label = "Harvest Gelato",
			icon = "fa fa-cannabis",
			length = 0.5,
			width = 0.8,
			height = 4,
			heading = 5,
		},
		coords = {
			vec3(163.53784179688, -237.20211791992, 49.155345916748),
			vec3(164.18930053711, -237.43922424316, 49.155345916748),
			vec3(164.90089416504, -237.6982421875, 49.155345916748),
			vec3(165.52906799316, -237.92686462402, 49.155345916748),
			vec3(166.25173950195, -238.18991088867, 49.155345916748),
		},
		debug = false,
	},
}

Config.Trimming = {
	enabled = true,
	target = {
		label = "Trim Weed",
		icon = "fa fa-cannabis",
		length = 3,
		width = 0.9,
		height = 2,
	},
	strains = {
		["untrimmed_ak47"] = "weed_ak47",
		["untrimmed_amnesia"] = "weed_amnesia",
		["untrimmed_zkittlez"] = "weed_zkittlez",
		["untrimmed_ogkush"] = "weed_ogkush",
		["untrimmed_purplehaze"] = "weed_purplehaze",
		["untrimmed_skunk"] = "weed_skunk",
		["untrimmed_whitewidow"] = "weed_whitewidow",
		["untrimmed_gelato"] = "weed_gelato",
	},
	coords = {
		{ vec3(166.77757263184, -232.41284179688, 49.889225006104), heading = 160 },
		-- Add more coordinates with specific headings if needed
	},
	debug = true,
}

Config.Bagging = {
	requiredItem = "empty_weed_bag",
	target = {
		label = "Bag Weed",
		icon = "fa fa-cannabis",
		length = 1,
		width = 3.5,
		height = 1.5,
		-- Remove heading from here
	},
	strains = {
		["weed_ak47"] = "weed_ak47_baggy",
		["weed_amnesia"] = "weed_amnesia_baggy",
		["weed_zkittlez"] = "weed_zkittlez_baggy",
		["weed_ogkush"] = "weed_ogkush_baggy",
		["weed_purplehaze"] = "weed_purplehaze_baggy",
		["weed_skunk"] = "weed_skunk_baggy",
		["weed_whitewidow"] = "weed_whitewidow_baggy",
		["weed_gelato"] = "weed_gelato_baggy",
	},
	coords = {
		{ vector3(185.29440307617, -242.12998962402, 53.57447052002), heading = -20 },
		-- Add more coordinates with specific headings if needed
	},
	debug = false,
}

Config.Edibles = {
	requiredItem = "edible_mold",
	target = {
		label = "Bag Weed",
		icon = "fa fa-cannabis",
		length = 1,
		width = 3.5,
		height = 1.5,
		-- Remove heading from here
	},
	strains = {
		["weed_ak47"] = "weed_ak47_baggy",
		["weed_amnesia"] = "weed_amnesia_baggy",
		["weed_zkittlez"] = "weed_zkittlez_baggy",
		["weed_ogkush"] = "weed_ogkush_baggy",
		["weed_purplehaze"] = "weed_purplehaze_baggy",
		["weed_skunk"] = "weed_skunk_baggy",
		["weed_whitewidow"] = "weed_whitewidow_baggy",
		["weed_gelato"] = "weed_gelato_baggy",
	},
	coords = {
		{ vector3(185.29440307617, -242.12998962402, 53.57447052002), heading = -20 },
		-- Add more coordinates with specific headings if needed
	},
	debug = false,
}

Config.Rolling = {
	requiredItem = "rolling_paper",
	target = {
		label = "Roll Joints",
		icon = "fa fa-cannabis",
		length = 0.5,
		width = 1,
		height = 0.5,
		-- Remove heading from here
	},
	strains = {
		["weed_ak47"] = "weed_ak47_joint",
		["weed_amnesia"] = "weed_amnesia_joint",
		["weed_zkittlez"] = "weed_zkittlez_joint",
		["weed_ogkush"] = "weed_ogkush_joint",
		["weed_purplehaze"] = "weed_purplehaze_joint",
		["weed_skunk"] = "weed_skunk_joint",
		["weed_whitewidow"] = "weed_whitewidow_joint",
		["weed_gelato"] = "weed_gelato_joint",
	},
	coords = {
		{ vec3(188.50192260742, -239.72418212891, 54.319705200195), heading = 70 },
		-- Add more coordinates with specific headings if needed
	},
	debug = false,
}

Config.Crafting = {
	enabled = true,
	target = {
		label = "Weed Crafting",
		icon = "fa fa-cannabis",
		length = 3,
		width = 0.9,
		height = 2,
		-- Remove heading from here
	},
	coords = {
		{ vec3(165.4013671875, -235.78907775879, 49.942863464355), heading = 160 },
		-- Add more coordinates with specific headings if needed
	},
	debug = false,
}

Config.WeedCrafting = {
	["bong"] = {
		{
			free = false,
			items = {
				{
					item = "glass",
					amount = 15,
					remove = true
				},
			},
			result = {
				item = "bong",
				amount = 1
			},
			duration = 5000,
			dict = "anim@amb@business@meth@meth_monitoring_no_work@",
			clip = "so_board_with_cleaning_lazycook"
		}
	},
}