-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {
	Lan = "en",
	System = {
		Debug = false,

		Menu = "ox",			-- "qb", "ox", "gta"
		Notify = "ox",			-- "qb", "ox", "esx, "okok", "gta"
		drawText = "ox",		-- "qb", "ox", "gta"
		ProgressBar = "ox", 	-- "qb", "ox", "gta"

	},
	Crafting = {
		craftCam = false,
		MultiCraft = false,
		MultiCraftAmounts = { [1], [5], [50] },
		showItemBox = true,
	},
	General = {
		JimShops = false,
		showClockInTill = true,
		showBossMenuTill = true,
	},

	--Simple Toy Reward Support
	Rewards = {
		RewardItem = { "", "", }, --Set this to the name of an item eg "bento"
		RewardPool = { -- Set this to the list of items to be given out as random prizes when the item is used - can be more or less items in the list
			{ item = "", rarity = 90},
			{ item = "", rarity = 10},
		},
	},
	Cats = {
		PatHeal = 2, 			--how much you are healed by patting a cat, 2 hp seems resonable, enough not to be over powered and enough to draw people in.
								--set to 0 if you don't want to use this
		RelieveStress = 5,		-- How much stress relief per pat
	},

}

Shops = {
	Items = {
		label = "Ingredients Storage",
		slots = 14,
		items = {
			{ name = "sugar", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "flour", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "nori", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "tofu", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "onion", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
			{ name = "boba", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
			{ name = "mint", price = 0, amount = 50, info = {}, type = "item", slot = 7, },
			{ name = "orange", price = 0, amount = 50, info = {}, type = "item", slot = 8, },
			{ name = "strawberry", price = 0, amount = 50, info = {}, type = "item", slot = 9, },
			{ name = "blueberry", price = 0, amount = 50, info = {}, type = "item", slot = 10, },
			{ name = "milk", price = 0, amount = 50, info = {}, type = "item", slot = 11, },
			{ name = "rice", price = 0, amount = 50, info = {}, type = "item", slot = 12, },
			{ name = "sake", price = 0, amount = 50, info = {}, type = "item", slot = 13, },
			{ name = "noodles", price = 0, amount = 50, info = {}, type = "item", slot = 14, },
		},
	},
}

Crafting = {
	ChoppingBoard = {
		Header = Loc[Config.Lan].menu["header_chop"],
		Anims = { animDict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_b_idle" },
		progressBar = { label = Loc[Config.Lan].progressbar["progress_make"], time = 5000, },
		Recipes = {
			{ bmochi = { ['sugar'] = 1, ['flour'] = 1, ['blueberry'] = 1, },
				["amount"] = 1,
			},
			{ gmochi = { ['sugar'] = 1, ['flour'] = 1, ['mint'] = 1, },
				["amount"] = 1,
			},
			{ omochi = { ['sugar'] = 1, ['flour'] = 1, ['orange'] = 1, },
				["amount"] = 1,
			},
			{ pmochi = { ['sugar'] = 1, ['flour'] = 1, ['strawberry'] = 1, },
				["amount"] = 1,
			},
			{ riceball = { ['rice'] = 1, ['nori'] = 1, },
				["amount"] = 1,
			},
			{ bento = { ['rice'] = 1, ['nori'] = 1, ['tofu'] = 1, },
				["amount"] = 1,
			},
			{ purrito = { ['rice'] = 1, ['flour'] = 1, ['onion'] = 1, },
				["amount"] = 1,
			},
		}
	},
	Oven = {
		Header = Loc[Config.Lan].menu["header_oven"],
		Anims = { animDict = "amb@prop_human_bbq@male@base", anim = "base" },
		progressBar = { label = Loc[Config.Lan].progressbar["progress_make"], time = 5000, },
		Recipes = {
			{ nekocookie = { ['flour'] = 1, ['milk'] = 1, },
				["amount"] = 1,
			},
			{ nekodonut = { ['flour'] = 1, ['milk'] = 1, },
				["amount"] = 1,
			},
			{ cake = { ['flour'] = 1, ['milk'] = 1, ['strawberry'] = 1, },
				["amount"] = 1,
			},
			{ cakepop = { ['flour'] = 1, ['milk'] = 1, ['sugar'] = 1, },
				["amount"] = 1,
			},
			{ pancake = { ['flour'] = 1, ['milk'] = 1, ['strawberry'] = 1, },
				["amount"] = 1,
			},
			{ pizza = { ['flour'] = 1, ['milk'] = 1,},
				["amount"] = 1,
			},
		},
	},
	Coffee = {
		Header = Loc[Config.Lan].menu["header_coffee"],
		Anims = { animDict = "mp_ped_interaction", anim = "handshake_guy_a" },
		progressBar = { label = Loc[Config.Lan].progressbar["progress_pour"], time = 5000, },
		Recipes = {
			{ catcoffee = { },
				["amount"] = 1,
			},
			{ nekolatte = { },
				["amount"] = 1,
			},
			{ bobatea = { ['boba'] = 1, ['milk'] = 1,},
				["amount"] = 1,
			},
			{ bbobatea = {
				['boba'] = 1, ['milk'] = 1, ['sugar'] = 1,},
				["amount"] = 1,
			},
			{ gbobatea = {
				['boba'] = 1, ['milk'] = 1, ['strawberry'] = 1, },
				["amount"] = 1,
			},
			{ obobatea = {
				['boba'] = 1, ['milk'] = 1, ['orange'] = 1,},
				["amount"] = 1,
			},
			{ pbobatea = {
				['boba'] = 1, ['milk'] = 1, ['strawberry'] = 1,},
				["amount"] = 1,
			},
			{ mocha = {
				['milk'] = 1, ['sugar'] = 1,},
				["amount"] = 1,
			},
		},
	},
	Hob = {
		Header = Loc[Config.Lan].menu["header_hob"],
		Anims = { animDict = "amb@prop_human_bbq@male@base", anim = "base" },
		progressBar = { label = Loc[Config.Lan].progressbar["progress_make"], time = 5000, },
		Recipes = {
			{ miso = { ['nori'] = 1, ['tofu'] = 1, ['onion'] = 1, },
				["amount"] = 1,
			},
			{ ramen = { ['noodles'] = 1, ['onion'] = 1, },
				["amount"] = 1,
			},
			{ noodlebowl = { ['noodles'] = 1, },
				["amount"] = 1,
			},
		}
	},
}