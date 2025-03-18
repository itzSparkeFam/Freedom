Config = {}

Config.account = {								-- Account configs
	['trucker'] = 'bank',						-- Change here the account that should be used with trucker expenses
}

Config.job = false		-- Required jobs name to open the menu (set as {} to disable the permission)

Config.disable_loans = false					-- Set this to true if you want to disable the loans
Config.disable_drivers = false					-- Set this to true if you want to disable the NPC drivers

-- Here are the places where the person can open the trucker menu
-- You can add as many locations as you like, just use the location already created as an example
Config.trucker_locations = {
	["trucker_1"] = {															-- ID
		['menu_location'] = {1208.7689208984,-3114.9829101562,5.5403342247009},	-- Coordinate to open the menu (vector3)
		['garage_location'] = {													-- Garage coordinates, where the trucks will spawn (vector4)
			{1250.55,-3162.4,5.88,270.00},
			{1250.76,-3168.05,5.86,270.00},
			{1245.91,-3135.67,5.62,270.00},
			{1246.07,-3142.42,5.63,270.00},
			{1245.93,-3149.04,5.62,270.00},
			{1245.69,-3155.94,5.6,270.00},
		},
		['trailer_location'] = {												-- Trailer coordinates, where the trailers will spawn (vector4)
			{1274.21,-3186.43,5.91,90.00},
			{1274.21,-3186.43,5.91,90.00},
			{1272.53,-3097.32,5.91,90.00},
			{1273.55,-3088.39,5.91,90.00},
			{1273.47,-3123.78,5.91,90.00},
			{1272.68,-3159.19,5.91,90.00},
			{1275.37,-3174.52,5.91,90.00},
			{1275.04,-3168.83,5.91,90.00},
		},
		['blips'] = {							-- Create the blips on map
			['id'] = 478,						-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Trucking Job",		    -- Blip Name
			['color'] = 4,						-- Blip Color
			['scale'] = 0.5,					-- Blip Scale
		}
	}
}

-- Here is the definition of the contracts that are generated for the players to deliver
Config.jobs = {
	['cancel_job'] = 167,						-- Key to cancel the active job (167 = F6) [Hold key 2 seconds]
	['cooldown'] = 5, 							-- Cooldown time (in minutes) to generate new contracts
	['generated_amount'] = 5,					-- Number of contracts created per interval ('cooldown'). Each interval will create a quick job contract and a freight job contract, so a value of 5 will generate 5 quick job and 5 freight job contracts
	['max_active_contracts'] = 30,				-- Maximum of contracts that can be active per page, this means that when generating a contact that exceeds this number, the oldest contract will be deleted
	['price_per_km_min'] = 1200,				-- Minimum price per kilometer of the contract
	['price_per_km_max'] = 1800,				-- Maximum price per kilometer of the contract
	['freight_job_mutiplier'] = 1.3,			-- Multiplier applied when generating FREIGHT loads (this means that freight jobs will have a 20% higher rewards)
	['probability_urgent_cargo'] = 10,			-- The urgent load is generated randomly, here you can configure the probability (%)
	['available_trucks'] = {					-- List of rented trucks that are generated in contracts
		"hauler","packer", "blacktop", "brickades", "vetirs"
	},
	['must_bring_truck_back'] = true,			-- true: Payment will only be made when bringing the truck back to the garage (except with own truck) | false: Payment will be made upon delivery of the cargo
	['available_loads'] = {
		--[[
			List of cargo types generated in contracts.
			'trailer': refers to the trailer spawn name.
			'name': is the displayed name for players to select from.
			'def': defines the cargo attributes, including ADR certification type, fragility, and value.
			'def' consists of 3 values:
			'def' = {
				0,  -- [First value]: ADR certificate type. 0 = None, 1 = Explosives, 2 = Flammable gases, 3 = Flammable liquids, 4 = Flammable solids, 5 = Toxic substances, 6 = Corrosive substances
				0,  -- [Second value]: Fragile cargo. 0 = Not fragile, 1 = Fragile
				0   -- [Third value]: Valuable cargo. 0 = Not valuable, 1 = Valuable
			}
		]]
		{ trailer = "armytanker", name = "Army fuel tank", def = {3,0,0}},
		{ trailer = "armytanker", name = "Army water supply", def = {0,0,0}},
		{ trailer = "armytanker", name = "Army Corrosive Materials Tank", def = {6,0,1}},
		{ trailer = "armytanker", name = "Army flammable gas tank", def = {2,0,0}},
		{ trailer = "armytanker", name = "Army toxic gas tank", def = {5,0,0}},
		{ trailer = "armytanker", name = "Army secret materials", def = {0,0,1}},

		{ trailer = "docktrailer", name = "Furniture transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Refrigerator transport", def = {0,1,0}},
		{ trailer = "docktrailer", name = "Brick transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Transport of imported products", def = {0,0,1}},
		{ trailer = "docktrailer", name = "Transport of plastics", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Clothing transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Chair transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Appliance transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Transport of cleaning supplies", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Refined timber transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Stone transport", def = {0,0,0}},
		{ trailer = "docktrailer", name = "Transport of jewels", def = {0,1,1}},
		{ trailer = "docktrailer", name = "Glass transport", def = {0,1,0}},
		{ trailer = "docktrailer", name = "Ammo transport", def = {1,0,0}},

		{ trailer = "tr2", name = "Car trailer empty", def = {0,0,0}},

		{ trailer = "trailers4", name = "Naval articles trailer", def = {0,0,0}},
		{ trailer = "trailers4", name = "Boat trailer", def = {0,1,1}},

		{ trailer = "tr4", name = "Stork", def = {0,1,1}},

		{ trailer = "tvtrailer", name = "Transport of materials for shows", def = {0,0,1}},
		{ trailer = "tvtrailer", name = "Transport of event materials", def = {0,1,1}},

		{ trailer = "tanker", name = "Fuel tank with additives", def = {3,0,0}},
		{ trailer = "tanker2", name = "Common fuel tank", def = {3,0,0}},
		{ trailer = "tanker2", name = "Kerosene tank", def = {3,0,0}},
		{ trailer = "tanker2", name = "Oil tank", def = {3,0,0}},

		{ trailer = "docktrailer", name = "Transport of exotic materials", def = {0,1,1}},
		{ trailer = "docktrailer", name = "Transport of rare materials", def = {0,1,1}},
		{ trailer = "docktrailer", name = "Transport of armaments", def = {0,0,1}},

		{ trailer = "trailerlogs", name = "Log transportation", def = {0,0,0}},

		{ trailer = "trailers", name = "Transport of construction materials", def = {0,0,0}},
		{ trailer = "trailers", name = "Rubber transport", def = {0,0,0}},
		{ trailer = "trailers", name = "Appliance transportation", def = {0,1,0}},
		{ trailer = "trailers", name = "Transport of vaccines", def = {0,1,0}},
		{ trailer = "trailers", name = "Transport of explosives", def = {1,1,0}},
		{ trailer = "trailers", name = "Sawdust transport", def = {0,0,0}},

		{ trailer = "trailers2", name = "Grape transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Pork transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Transport of beef", def = {0,0,0}},
		{ trailer = "trailers2", name = "Carrot transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Potato transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Milk transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Transport of canned goods", def = {0,0,0}},
		{ trailer = "trailers2", name = "Frozen meat transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Bean transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Vinegar transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Lemonade transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Bottled water transport", def = {0,0,0}},
		{ trailer = "trailers2", name = "Cheese transport", def = {0,0,0}},

		{ trailer = "trailers3", name = "Tile transport", def = {0,0,0}},
		{ trailer = "trailers3", name = "Rail transport", def = {0,0,0}},
		{ trailer = "trailers3", name = "Transport of used packaging", def = {0,0,0}},
		{ trailer = "trailers3", name = "Floor plate transport", def = {0,0,0}},
		{ trailer = "trailers3", name = "Ceramic transport", def = {0,1,0}},
		{ trailer = "trailers3", name = "Scrap transport", def = {0,0,0}},

		{ trailer = "trailers4", name = "Transport of fireworks", def = {1,1,0}},
		{ trailer = "trailers4", name = "Transport of explosives", def = {1,1,0}},
		{ trailer = "trailers4", name = "Dynamite transport", def = {1,1,0}},
		{ trailer = "trailers4", name = "White phosphorus transport", def = {4,1,0}},
	}
}

-- Here is the definition of the drivers that are generated for the players to hire
Config.drivers = {
	['cooldown'] = 20,							-- Cooldown time (in minutes) to generate a new driver

	['hiring_costs'] = {						-- Cost of hiring the driver (this amount will only be paid at the time of hiring)
		['min'] = 500,							-- This is the minimum base cost of hiring the employee
		['max'] = 1000,							-- This is the maximum base cost of hiring the employee (this amount will increase according to the employee's skills)
		['percentage_skills'] = 25,				-- This is the % cost that each skill will add to the cost of hiring the driver. That is, for each skill level the driver has, this percentage will increase. (In this case, each skill will increase the cost by 25%)
	},

	['available_drivers'] = {
		-- List of drivers that are randomly generated to be hired
		{img = "img/avatar/avatar8.png", names = {"Victoria Sullivan", "Madeline Hughes", "Adeline Brooks", "Georgia Cruz", "Isla Sanders", "Clara Lopez", "Naomi Bryant", "Ellie Hayes", "Autumn Rivera", "Ariana Butler", "Kennedy Campbell", "Ruby Jenkins", "Willow Gomez", "Maya Hughes", "Alice Morgan", "Isabelle Clark", "Nora Ward", "Eva Patterson", "Sophia Ross", "Hazel Perez", "Julia Foster", "Elizabeth Hayes", "Emma Scott", "Lila Parker", "Sarah Murphy", "Rachel Carter", "Gabriella Mitchell", "Faith Stewart", "Mackenzie Watson", "Lydia Young", "Cora Alexander", "Molly Barnes", "Angelina Peterson", "Bella Jenkins", "Margaret Bell", "Reese Henderson", "Phoebe Foster", "Elise Gray", "Wren Butler", "Eloise Coleman", "Piper Ward", "Megan Howard", "Delilah Murphy", "Addison Clark", "Jane Adams", "Melanie Stewart", "Elsie Davis", "Clara Wilson", "Hannah King", "Lucy Sanders"}},
		{img = "img/avatar/avatar7.png", names = {"James Robinson", "Liam Scott", "Noah Brown", "Mason Adams", "William Moore", "Elijah Murphy", "Lucas Walker", "Logan White", "Alexander Stewart", "Jackson Lewis", "Ethan Martin", "Aiden Davis", "Sebastian Wilson", "Daniel Thompson", "Matthew Anderson", "David Johnson", "Joseph Harris", "Andrew Lee", "Benjamin Taylor", "Samuel Young", "Nathan King", "Henry Wright", "Gabriel Evans", "Christopher Clark", "Dylan Baker", "Jonathan Carter", "Adam Mitchell", "Aaron Hall", "Nicholas Edwards", "Ryan Collins", "Christian Turner", "Zachary Rodriguez", "Joshua Allen", "Charles Sanchez", "Isaac Morris", "Owen Parker", "Thomas Reed", "Evan Jenkins", "Cameron Cox", "Brandon Bryant", "Caleb Rogers", "Jack Brooks", "Connor Howard", "Robert Cook", "Lucas Diaz", "Ian Rivera", "Anthony Gray", "Hunter Price", "Dominic Foster", "Jason Phillips", "Justin Long", "Cole Powell", "Tyler Bell", "Austin Peterson", "Mark Hughes", "Sean Ramirez", "Nathaniel Russell", "Jeremy Butler", "Oscar Perry", "Miles Campbell"}},
		{img = "img/avatar/avatar6.png", names = {"Jake Simmons", "Elliott Watson", "Victor Grant", "Micah Sanders", "Vincent Foster", "Dean Cooper", "Jonah James", "Felix Bennett", "Seth Rivera", "Julian Warren", "George Howard", "Gavin Powell", "Paul Young", "Carter Ross", "Troy Murphy", "Arthur Bailey", "Bennett Reed", "Grayson Rogers", "Declan Torres", "Eli Mitchell", "Wesley Adams", "Lincoln Brown", "Colton Morris", "Spencer Davis", "Tobias Perry", "Max Turner", "Ezra Ramirez", "Adrian Collins", "Asher Campbell", "Xavier Cook", "Nolan Phillips", "Louis Clark", "Leo Sanchez", "Eric Coleman", "Ryder Foster", "Wyatt Butler", "Steven Long", "Tucker Evans", "Bryce Perry", "Silas Parker", "Blake Roberts", "Graham Rodriguez", "Dominic Barnes", "Hudson Hall", "Patrick King", "Victor Russell", "Clark Williams", "Shawn Jenkins", "Tate Edwards", "Marshall Fisher", "Quentin Bell", "Reid Sanders", "Roy Jenkins", "Finn Torres", "Kieran Wright", "Jude Harrison", "Oliver Young", "Bruce Bryant", "Beau Baker"}},
		{img = "img/avatar/avatar5.png", names = {"Carl Richardson", "Jeffrey Garcia", "Simon Stewart", "Ethan Morris", "Kenneth Morgan", "Wayne Myers", "Lawrence Scott", "Keith Howard", "Marcus Barnes", "Nelson Hughes", "Phillip Diaz", "Walter Jenkins", "Edwin Harrison", "Frederick Collins", "Travis Spencer", "Bruce McCarthy", "Hector Morris", "Martin Allen", "Russell Fox", "Curtis Gray", "Peter Bennett", "Stanley Adams", "Terry Torres", "Raymond Evans", "Frankie Henderson", "Ralph Bryant", "Harvey Cook", "Dean Harris", "Rick Davis", "Victor Campbell", "Clifford Young", "Malcolm Perry", "Randy Hill", "Glen Foster", "Dennis Lewis", "Gordon Patterson", "Joel Mitchell", "Warren Phillips", "Leon Bailey", "Norman Sanders", "Jerome Butler", "Leonard Perry", "Eugene James", "Floyd Fisher", "Rodney Turner", "Brent Campbell", "Kurt Robinson", "Archie Williams", "Tyson Brooks", "Wesley Cox", "Frank Green", "Cliff Rogers", "Lloyd Moore", "Alex Jordan", "Todd White", "Rick Bennett", "Stewart Thomas", "Charlie Bell", "Guy Ramirez", "Neil Foster"}},
		{img = "img/avatar/avatar4.png", names = {"Ronan West", "Cody Foster", "Toby Reed", "Malik Henderson", "Arthur Bishop", "Gideon Morris", "Casey Russell", "Jamie Crawford", "Brady Foster", "Zane Collins", "Francis Ward", "Brock James", "Clayton Carter", "Reed Spencer", "Cyrus King", "Javier Diaz", "Jaxon Rogers", "Elliot Murphy", "Damon Jenkins", "Walter Fisher", "Albert Scott", "Wayne Turner", "Byron Adams", "Milton Brooks", "Brett Perry", "Alexis Bryant", "Clifford Rivera", "Rex Hughes", "Evan Mitchell", "Harley Coleman", "Rodney Bell", "Dallas Johnson", "Grant Campbell", "Marshall Edwards", "Lane Moore", "Blake Lewis", "Levi Garcia", "Alec Young", "Reese Clark", "Trey Evans", "Shane Scott", "Leroy Foster", "Roman Sanchez", "Raymond Diaz", "Robbie Hill", "Doug Watson", "Brent Collins", "Russell Baker", "Arnold Stewart", "Gerald Barnes", "Randall Howard", "Curtis Campbell", "Darren King", "Leonard West", "Jonas Perry", "Eli Edwards", "Parker Powell", "Griffin Brown", "Marco Davis", "Sebastian Turner"}},
		{img = "img/avatar/avatar3.png", names = {"Abigail Harper", "Sophia Dawson", "Olivia Mitchell", "Emily Bennett", "Isabella Reed", "Grace Fletcher", "Ava Collins", "Amelia Parker", "Mia Jenkins", "Charlotte Turner", "Hannah James", "Ella Carter", "Lily Morgan", "Zoe Henderson", "Evelyn Ross", "Harper Foster", "Victoria Edwards", "Madison Murphy", "Scarlett Long", "Luna Cox", "Ruby Coleman", "Aria Gray", "Savannah Thompson", "Stella Cooper", "Chloe Bell", "Lucy Foster", "Paisley Bailey", "Aurora Bryant", "Elena Howard", "Audrey King", "Sadie Martin", "Josephine Young", "Natalie Walker", "Penelope Scott", "Violet Davis", "Brooklyn Perez", "Layla Brooks", "Avery Fisher", "Ella Anderson", "Emma Sanders"}},
		{img = "img/avatar/avatar2.png", names = {"Maxwell Torres", "Connor Davis", "Finn Morgan", "Oliver Perry", "Nathaniel Harris", "Keegan Brooks", "Brett Murphy", "Graham Cook", "Jasper Lewis", "Colin Russell", "Xander Edwards", "Archer Foster", "Bennett Gray", "Miles Turner", "Harrison Stewart", "Nico Thomas", "Bryson Scott", "Kellen Ward", "Axel Collins", "Reid King", "Derek Jenkins", "Clayton Phillips", "Aidan Robinson", "Lane Fisher", "Jude Campbell", "Gavin Hill", "Sawyer Mitchell", "Beckett Evans", "Milo Hughes", "Zachary Moore", "Elliot Bennett", "Brock Spencer", "Corbin Adams", "Tucker Carter", "Jared Perry", "Ashton Young", "Roman Foster", "Damien Howard", "Grant Powell", "Desmond Coleman", "Rylan Rogers", "Sterling Harris", "Zion Rivera", "Lennox Bell", "Orion Turner", "Beau Martin", "Eli Reed", "Ronin Thompson", "Theo Butler", "Emerson Cooper", "Gunner Richardson", "Sullivan Bailey", "Callum Collins", "Finley Johnson", "Pierce Sanders", "Declan Price", "Mackenzie Bryant", "Quincy Barnes", "Winston Parker", "Calvin King"}},
		{img = "img/avatar/avatar1.png", names = {"Malcolm Reed", "Vincent Patterson", "Tyler Perry", "Shawn Moore", "Bryce Edwards", "Dylan Morris", "Carter Scott", "Wyatt Campbell", "Adam Turner", "Nathan Brooks", "Cody Jenkins", "Joel Garcia", "Felix Torres", "Seth Mitchell", "Mark Howard", "Landon Ward", "Miles Rivera", "Chase Phillips", "Spencer Foster", "Simon Anderson", "Franklin Stewart", "Gregory Perry", "Hector Adams", "Jonathon Bailey", "Wayne Robinson", "Kyle Bell", "Jack Thompson", "Randy Brooks", "Rodney Russell", "Bryan Hughes", "Carlos Evans", "Justin Johnson", "Ethan Barnes", "Raymond King", "Levi Sanders", "Griffin Bryant", "Dean Fisher", "Hunter Davis", "Louis James", "Tommy Clark", "Zachariah Jenkins", "Gavin Collins", "Peter Cox", "Nolan Price", "Wesley Young", "Christopher Scott", "Trevor Perry", "Eric Powell", "Ross Green", "Alvin Hill", "Dominic Parker", "Craig Foster", "Lawrence Cooper", "Ruben Harris", "Miguel Jenkins", "Nelson Mitchell", "Will Sanchez", "Arnold Moore", "Victor Butler", "Sebastian Perry"}}
	},
	['max_active_drivers'] = 20,				-- Maximum number of drivers that can be active, this means that when generating a driver that exceeds this number, the oldest driver will be deleted
	['max_drivers_per_player'] = {				-- Maximum number of drivers the player can hire per level
		[0] = 3,								-- Between level 0 to 10 player will be able to hire 3 drivers
		[10] = 4,								-- Between level 10 to 20 player will be able to hire 4 drivers
		[20] = 5,								-- etc
		[30] = 6
	}
}

-- Here is the definition of the contracts that are generated for drivers to carry out
Config.driver_jobs = {
	['cooldown'] = 30,							-- Cooldown time (in minutes) for drivers to make contracts and generate money for the company

	['profit'] = {								-- These are the drivers' earnings for each contract, a random value is generated for each contract
		['min'] = 200,							-- Minimum base profit, this will be the minimum money this driver can generate
		['max'] = 350,							-- Maximum base profit, this will be the maximum amount of money this driver can generate (this amount will increase according to the driver's skills)
		['percentage_skills'] = 15,				-- This is the % value that each skill will add to the driver's final profit. That is, the more skills he has, the greater the profit.
	},
	['fuel_consumption'] = {					-- Fuel consumption for each delivery
		['min'] = 2,							-- Minimum % amount consumed
		['max'] = 8								-- Maximum % amount consumed
	},

	['generate_money_offline'] = false 			-- true: drivers will generate money all the time / false: drivers will generate money only if the owner is online
}

Config.sell_price_multiplier = 0.7				-- Value you receive when selling the used truck
Config.dealership = {							-- Truck dealership vehicles
	-- Here you can configure the vehicles of the dealership
	['hauler'] = { 								-- Vehicle spawn name
		['name'] = 'JoBuilt Hauler',			-- Truck name
		['price'] = 70000,						-- Value
		['engine'] = "12.0L Turbocharged V8",	-- Engine configuration
		['transmission'] = "8-Speed",			-- Transmission configuration
		['hp'] = '500',							-- Horsepower
		['img'] = 'img/trucks/hauler.png',		-- Vehicle image
		['driver_bonus'] = 4, 					-- This percentage represents the additional earnings a driver receives when using this specific truck
		['required_level'] = 12					-- Required player level to be able to purchase this truck
	},
	-- The other vehicles follow the same pattern as the vehicle above
	['phantom'] = {
		['name'] = 'JoBuilt Phantom',
		['price'] = 130000,
		['engine'] = "15.0L Turbocharged V12",
		['transmission'] = "10-Speed",
		['hp'] = '600',
		['img'] = 'img/trucks/phantom.png',
		['driver_bonus'] = 8,
		['required_level'] = 25
	},
	['phantom3'] = {
		['name'] = 'JoBuilt Phantom Custom',
		['price'] = 180000,
		['engine'] = "16.5L Twin-Turbo V16",
		['transmission'] = "12-Speed Plus",
		['hp'] = '650',
		['img'] = 'img/trucks/phantom3.png',
		['driver_bonus'] = 10,
		['required_level'] = 30
	},
	['packer'] = {
		['name'] = 'MTL Packer',
		['price'] = 110000,
		['engine'] = "13.0L Supercharged V8",
		['transmission'] = "8-Speed",
		['hp'] = '570',
		['img'] = 'img/trucks/packer.png',
		['driver_bonus'] = 6,
		['required_level'] = 20
	},
	['aerocab'] = {
		['name'] = 'Vapid Tanker',
		['price'] = 90000,
		['engine'] = "12.5L Turbocharged V8",
		['transmission'] = "8-Speed",
		['hp'] = '565',
		['img'] = 'img/trucks/aerocab.png',
		['driver_bonus'] = 6,
		['required_level'] = 10
	},
	['blacktop'] = {
		['name'] = 'Brute Blacktop',
		['price'] = 45000,
		['engine'] = "11.0L Brute I6",
		['transmission'] = "6-Speed",
		['hp'] = '420',
		['img'] = 'img/trucks/blacktop.png',
		['driver_bonus'] = 2,
		['required_level'] = 3
	},
	['brickades'] = {
		['name'] = 'MTL Brickade',
		['price'] = 60000,
		['engine'] = "12.5L Turbocharged V8",
		['transmission'] = "8-Speed",
		['hp'] = '480',
		['img'] = 'img/trucks/brickades.png',
		['driver_bonus'] = 4,
		['required_level'] = 6
	},
	['linerunner'] = {
		['name'] = 'HVY Linerunner',
		['price'] = 105000,
		['engine'] = "14.0L Supercharged V10",
		['transmission'] = "10-Speed",
		['hp'] = '580',
		['img'] = 'img/trucks/linerunner.png',
		['driver_bonus'] = 6,
		['required_level'] = 15
	},
	['vetirs'] = {
		['name'] = 'Vetir Semi',
		['price'] = 25000,
		['engine'] = "10.0L Vetir I6",
		['transmission'] = "5-Speed",
		['hp'] = '380',
		['img'] = 'img/trucks/vetirs.png',
		['driver_bonus'] = 1,
		['required_level'] = 0
	}
}

Config.repair_price = { -- Cost to repair 1% damage for each part (For example: if a part is 40% damaged, the cost to repair will be multiplied by 40)
	['engine'] = 75,
	['body'] = 40,
	['transmission'] = 50,
	['wheels'] = 25,
	['fuel'] = 5
}

--[[
	Maximum loan amount available per level (loan size increases with higher levels)
	Example:
	[0] = 40000,
	[10] = 100000,
	[20] = 250000
	This indicates that from level 0 to level 10, players can take out a maximum loan of 40 000. From level 10 to 20, the maximum loan amount increases to 100 000...
]]
Config.max_loan_per_level = {
	[0] = 50000,
	[10] = 100000,
	[20] = 250000,
	[30] = 600000
}

-- Loan amounts and interest charges
Config.loans = {
	-- Set the interval between loan payments in hours (24 hours by default)
	['payment_interval_hours'] = 24,

	-- Define the available loan plans, you can create as many as you want
	['plans'] = {
		{
			['loan_amount'] = 20000,		-- Total loan amount (20,000)
			['interest_rate'] = 20,			-- Interest rate in percentage
			['repayment_days'] = 15			-- Number of days to complete the loan payment
		},
		{
			['loan_amount'] = 50000,
			['interest_rate'] = 17.5,
			['repayment_days'] = 20
		},
		{
			['loan_amount'] = 100000,
			['interest_rate'] = 15,
			['repayment_days'] = 25
		},
		{
			['loan_amount'] = 400000,
			['interest_rate'] = 12.5,
			['repayment_days'] = 30
		}
	}
}

--[[
	Skill level and max travel distance at each level
	Example:
	[0] = 6,
	[1] = 6.5,
	This indicates that at level 0, players can take contracts with a maximum distance of 6 km. At level 1, they can take contracts with a maximum distance of 6.5 km.
	Level 6 represents the maximum skill level attainable.
]]
Config.distance_skill = {
	[0] = 6,
	[1] = 6.5,
	[2] = 7,
	[3] = 7.5,
	[4] = 8,
	[5] = 8.5,
	[6] = 99 -- Maximum
}

--[[
	Experience required to reach each level
	Example:
	[1] = 100,
	[2] = 200,
	This indicates that to reach level 1, you need 100 EXP; to reach level 2, you need 200 EXP.
	Upon leveling up, the player receives 1 skill point.
	Level 30 represents the maximum achievable level.
]]
Config.required_xp_to_levelup = {
	[1] = 1000,
	[2] = 2000,
	[3] = 3000,
	[4] = 4000,
	[5] = 5000,
	[6] = 6000,
	[7] = 7000,
	[8] = 8000,
	[9] = 9000,
	[10] = 10000,
	[11] = 11000,
	[12] = 12000,
	[13] = 13000,
	[14] = 14000,
	[15] = 16000,
	[16] = 18000,
	[17] = 20000,
	[18] = 22000,
	[19] = 24000,
	[20] = 26000,
	[21] = 28000,
	[22] = 30000,
	[23] = 35000,
	[24] = 40000,
	[25] = 45000,
	[26] = 50000,
	[27] = 55000,
	[28] = 60000,
	[29] = 65000,
	[30] = 100000 -- Maximum
}

--[[
	EXP gain in %
	XP is calculated based on the distance of the delivery. For instance, if they drive 2km in one delivery and Config.exp_gain = 3.0, they will earn 60 XP
	This XP can be increased based on the bonuses configured below
]]
Config.exp_gain = 3.0

-- EXP bonuses and money each skill gives
Config.bonus = {
	-- This bonus will be applied according to the level and requirements of the load. Then, when transporting a fragile cargo, he will receive the fragile cargo bonus (these values ​​are in%)
	['distance'] = {
		['money_bonus_percentage'] = {
			[1] = 2,
			[2] = 4,
			[3] = 6,
			[4] = 8,
			[5] = 10,
			[6] = 12
		},
		['exp_bonus_percentage'] = {
			[1] = 150,
			[2] = 150,
			[3] = 150,
			[4] = 150,
			[5] = 150,
			[6] = 150
		}
	},
	['valuable'] = {
		['money_bonus_percentage'] = {
			[1] = 2,
			[2] = 4,
			[3] = 6,
			[4] = 8,
			[5] = 10,
			[6] = 12
		},
		['exp_bonus_percentage'] = {
			[1] = 10,
			[2] = 10,
			[3] = 10,
			[4] = 10,
			[5] = 10,
			[6] = 10
		}
	},
	['fragile'] = {
		['money_bonus_percentage'] = {
			[1] = 2,
			[2] = 4,
			[3] = 6,
			[4] = 8,
			[5] = 10,
			[6] = 12
		},
		['exp_bonus_percentage'] = {
			[1] = 10,
			[2] = 10,
			[3] = 10,
			[4] = 10,
			[5] = 10,
			[6] = 10
		}
	},
	['fast'] = {
		['money_bonus_percentage'] = {
			[1] = 2,
			[2] = 4,
			[3] = 6,
			[4] = 8,
			[5] = 10,
			[6] = 12
		},
		['exp_bonus_percentage'] = {
			[1] = 10,
			[2] = 10,
			[3] = 10,
			[4] = 10,
			[5] = 10,
			[6] = 10
		}
	}
}

Config.party = {
	['price_to_create'] = 5000,		-- Price to create a party
	['price_per_member'] = 100, 	-- Cost of each additional member
	['max_members'] = 10,			-- Maximum number of members of each group
	['party_money_bonus'] = 5,		-- Bonus money (in %) that each party member receives upon completing a delivery
	['party_exp_bonus'] = 5,		-- Bonus xp (in %) that each party member receives when completing a delivery
	['only_leader_can_start'] = false-- true: Only the group leader can start a delivery | false: Any member can start a delivery
}

-- Cargo delivery locations (vector4)
Config.delivery_locations = {
	{-758.14,5540.96,33.49,110.53},
	{-3046.19,143.27,11.6,11.14},
	{-1153.01,2672.99,18.1,312.25},
	{622.67,110.27,92.59,340.75},
	{-574.62,-1147.27,22.18,177.7},
	{376.31,2638.97,44.5,286.38},
	{1738.32,3283.89,41.13,16.24},
	{1419.98,3618.63,34.91,195.33},
	{1452.67,6552.02,14.89,138.69},
	{3472.4,3681.97,33.79,76.44},
	{2485.73,4116.13,38.07,66.71},
	{65.02,6345.89,31.22,206.64},
	{-303.28,6118.17,31.5,135.24},
	{-63.41,-2015.25,18.02,299.48},
	{-46.35,-2112.38,16.71,290.84},
	{-746.6,-1496.67,5.01,28.08},
	{369.54,272.07,103.11,247.94},
	{907.61,-44.12,78.77,323.08},
	{-1517.31,-428.29,35.45,55.77},
	{235.04,-1520.18,29.15,316.76},
	{34.8,-1730.13,29.31,226.06},
	{350.4,-2466.9,6.4,169.38},
	{1213.97,-1229.01,35.35,270.74},
	{1395.7,-2061.38,52.0,135.81},
	{729.09,-2023.63,29.31,268.75},
	{840.72,-1952.59,28.85,81.46},
	{551.76,-1840.26,25.34,40.72},
	{723.78,-1372.08,26.29,106.65},
	{-339.92,-1284.25,31.32,89.06},
	{1137.23,-1285.05,34.6,189.65},
	{466.93,-1231.55,29.95,267.14},
	{442.28,-584.28,28.5,252.12},
	{1560.52,888.69,77.46,19.02},
	{2561.78,426.67,108.46,301.57},
	{569.21,2730.83,42.07,91.35},
	{2665.4,1700.63,24.49,269.33},
	{1120.1,2652.5,38.0,181.77},
	{2004.23,3071.87,47.06,237.58},
	{2038.78,3175.7,45.09,140.47},
	{1635.54,3562.84,35.23,296.61},
	{2744.55,3412.43,56.57,247.48},
	{1972.17,3839.16,32.0,304.36},
	{1980.59,3754.65,32.18,211.64},
	{1716.0,4706.41,42.69,91.44},
	{1691.36,4918.42,42.08,57.29},
	{1970.3,5177.39,47.83,318.89},
	{1908.78,4932.06,48.97,340.08},
	{140.79,-1077.85,29.2,262.4},
	{-323.98,-1522.86,27.55,258.59},
	{-1060.53,-221.7,37.84,299.01},
	{2471.47,4463.07,35.3,277.56},
	{2699.47,3444.81,55.8,153.49},
	{2651.19,3252.42,54.93,232.7},
	{2730.39,2778.2,36.01,134.51},
	{-2966.68,363.37,14.77,359.8},
	{2788.89,2816.49,41.72,296.22},
	{-604.45,-1212.24,14.95,227.43},
	{2534.83,2589.08,37.95,2.48},
	{-143.31,205.88,92.12,86.41},
	{2381.84,2594.34,46.66,192.86},
	{860.47,-896.87,25.53,181.8},
	{973.34,-1038.19,40.84,272.3},
	{-409.04,1200.44,325.65,164.59},
	{-1664.81,3076.59,31.23,229.86},
	{-71.8,-1089.98,26.56,339.06},
	{1246.34,1860.78,79.47,315.78},
	{-1777.63,3082.36,32.81,236.17},
	{-1775.87,3088.13,32.81,239.97},
	{-1827.5,2934.11,32.82,59.53},
	{-2123.69,3270.14,32.82,145.14},
	{-2444.59,2981.63,32.82,283.55},
	{-2448.59,2962.8,32.82,333.19},
	{-2277.86,3176.57,32.81,236.61},
	{-2969.0,366.46,14.77,292.99},
	{-1637.61,-814.53,10.17,139.15},
	{-1494.72,-891.67,10.11,73.06},
	{-902.27,-1528.42,5.03,106.23},
	{-1173.93,-1749.87,3.97,211.53},
	{-1087.8,-2047.55,13.23,314.93},
	{-1108.63,-2026.09,13.24,308.01},
	{-1828.58,-2823.35,13.95,155.0},
	{-1025.97,-2223.62,8.99,224.96},
	{850.42,2197.69,51.93,243.19},
	{42.61,2803.45,57.88,145.49},
	{-1193.54,-2155.4,13.2,138.82},
	{-1184.37,-2185.67,13.2,336.13},
	{2041.76,3172.26,44.98,155.2},
	{-477.44,-2166.87,9.59,121.48},
	{-3189.8,1078.75,20.85,154.85},
	{-433.69,-2277.29,7.61,268.97},
	{-395.18,-2182.97,10.29,94.54},
	{-3029.7,591.68,7.79,199.33},
	{-1007.29,-3021.72,13.95,65.31},
	{-61.32,-1832.75,26.8,227.87},
	{822.72,-2134.28,29.29,349.36},
	{942.22,-2487.76,28.34,89.41},
	{279.31,-2078.18,16.83,28.94},
	{783.08,-2523.98,20.51,5.67},
	{720.61,-2128.76,29.22,87.12},
	{787.05,-1612.38,31.17,48.33},
	{913.52,-1556.87,30.74,272.14},
	{777.64,-2529.46,20.13,96.09},
	{843.82,-2474.47,25.3,87.54},
	{711.79,-1395.19,26.35,103.31},
	{723.38,-1286.3,26.3,90.13},
	{983.0,-1230.77,25.38,121.4},
	{818.01,-2422.85,23.6,174.28},
	{885.53,-1166.38,24.99,94.77},
	{700.85,-1106.93,22.47,163.11},
	{882.26,-2384.1,28.0,179.16},
	{1003.55,-1860.27,30.89,268.33},
	{-1138.73,-759.77,18.87,234.36},
	{938.71,-1154.36,25.38,178.46},
	{973.0,-1156.18,25.43,267.36},
	{689.41,-963.48,23.49,178.61},
	{140.72,-375.29,43.26,336.19},
	{-497.09,-62.13,39.96,353.27},
	{-606.34,187.43,70.01,270.65},
	{117.12,-356.15,42.59,252.09},
	{53.91,-1571.07,29.47,137.1},
	{1528.1,1719.32,109.97,34.6},
	{1411.29,1060.33,114.34,269.14},
	{1145.76,-287.73,68.96,284.29},
	{-441.96,-1704.7,18.89,250.12},
	{874.28,-949.16,26.29,358.46},
	{829.28,-874.08,25.26,270.18},
	{725.37,-874.53,24.67,265.96},
	{693.66,-1090.43,22.45,174.62},
	{1210.33,-1076.89,39.96,304.44},
	{945.1,-1163.54,25.68,270.98},
	{911.7,-1258.04,25.58,33.69},
	{847.06,-1397.72,26.14,151.79},
	{852.32,-1393.03,26.14,151.28},
	{130.47,-1066.12,29.2,160.09},
	{-52.79,-1078.65,26.93,67.2},
	{-131.74,-1097.38,21.69,335.25},
	{-621.47,-1106.05,22.18,1.07},
	{-668.65,-1182.07,10.62,208.79},
	{-111.84,-956.71,27.27,339.83},
	{-1359.83,-1144.35,4.26,6.03},
	{-1190.55,-2057.76,14.33,4.39},
	{-1169.18,-1768.78,3.87,306.82},
	{-1343.38,-744.02,22.28,309.26},
	{-1532.84,-578.16,33.63,304.2},
	{-1461.4,-362.39,43.89,219.06},
	{-1457.25,-384.15,38.51,114.12},
	{-1544.42,-411.45,41.99,226.04},
	{-1432.72,-250.32,46.37,130.83},
	{-1040.24,-499.88,36.07,118.78},
	{346.43,-1107.19,29.41,177.11},
	{523.99,-2112.7,5.99,182.08},
	{977.19,-2539.34,28.31,353.75,357.42},
	{1101.01,-2405.39,30.76,259.61},
	{1591.9,-1714.0,88.16,120.75},
	{1693.41,-1497.45,113.05,66.92},
	{1029.44,-2501.31,28.43,149.34},
	{2492.55,-320.89,93.0,82.83},
	{2846.31,1463.1,24.56,74.93},
	{3631.05,3768.61,28.52,320.0},
	{3572.5,3665.53,33.9,75.93},
	{2919.03,4337.85,50.31,203.77},
	{2521.47,4203.47,39.95,327.93},
	{2926.2,4627.28,48.55,143.26},
	{3808.59,4463.22,4.37,87.61},
	{2802.35,4838.31,44.99,118.49},
	{2133.06,4789.57,40.98,26.62},
	{1900.83,4913.82,48.87,154.21},
	{381.06,3591.37,33.3,82.49},
	{642.8,3502.47,34.09,95.04},
	{277.33,2884.71,43.61,296.91},
	{-60.3,1961.45,190.19,294.86},
	{225.63,1244.33,225.46,194.24},
	{-513.24,5257.73,80.62,159.3},
	{-519.96,5243.84,79.95,72.76},
	{-602.87,5326.63,70.46,168.65},
	{-797.95,5400.61,34.24,86.78},
	{-776.0,5579.11,33.49,167.58},
	{-704.2,5772.55,17.34,68.44},
	{-299.24,6300.27,31.5,134.2},
	{402.52,6619.61,28.26,357.71},
	{-247.72,6205.46,31.49,45.5},
	{-326.49,6104.64,31.49,46.83},
	{-64.73,6553.21,31.5,41.71},
	{2204.73,5574.04,53.74,351.31},
	{1638.98,4840.41,42.03,185.92},
	{1961.26,4640.93,40.71,293.6},
	{1776.61,4584.67,37.65,181.45},
	{137.29,281.73,109.98,335.6},
	{607.49,165.2,98.24,341.06},
	{212.28,2789.95,45.66,276.37},
	{708.58,-295.1,59.19,277.93},
	{581.28,2799.43,42.1,1.52},
	{1296.73,1424.35,100.45,178.89},
	{955.85,-22.89,78.77,147.51}
}

Config.create_table = true				-- Keep this true please