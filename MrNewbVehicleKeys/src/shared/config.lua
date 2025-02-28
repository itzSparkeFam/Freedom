--		MrNewbVehicleKeysV2 BETA -- If you have recived this and dont own the actual script please let us know in the discord.
--		___  ___       _   _                  _      _____              _         _
--		|  \/  |      | \ | |                | |    /  ___|            (_)       | |
--		| .  . | _ __ |  \| |  ___ __      __| |__  \ `--.   ___  _ __  _  _ __  | |_  ___
--		| |\/| || '__|| . ` | / _ \\ \ /\ / /| '_ \  `--. \ / __|| '__|| || '_ \ | __|/ __|
--		| |  | || |   | |\  ||  __/ \ V  V / | |_) |/\__/ /| (__ | |   | || |_) || |_ \__ \
--		\_|  |_/|_|   \_| \_/ \___|  \_/\_/  |_.__/ \____/  \___||_|   |_|| .__/  \__||___/
--									          							  | |
--									          							  |_|
--
--		  Need support? Join our Discord server for help: https://discord.gg/mrnewbscripts
--
--		  If you need help with configuration or have any questions, please do not hesitate to ask.
--
--		  Docs Are Always Available At -- https://mrnewbs-scrips.gitbook.io/guide

Config = {}

Config.Utility = {
	Debug = false,														-- set this to turn on debug commands and prints (do not leave on in a live enviroment)
	EngineToggle = true,												-- set this to true to use my engine toggle, if you have a hud that already has this set it as false.
}

Config.KeybingSettings = {
	-- Remember These can be re-bound by the player in the keybinds menu
	LockKeyBind = "l",													-- set this to the defualt keybind you want to use for the lock/unlock feature. (players can rebind this)
	HotWireBind = "e",													-- set this to the defualt keybind you want to use for the hotwire feature.
	EngineKeyBind = "g",												-- set this to the defualt keybind you want to use for the engine toggle feature. (players can rebind this)
	Keyring = "f5",														-- set this to the defualt keybind you want to use for the keyring feature (only for non item setting). (players can rebind this)
}

Config.HotWireSettings = {
	Cooldown = true,
	HotWireCooldownTime = 3000,											-- set this to the cooldown time for hotwiring a vehicle in milliseconds (1000 = 1 second)
	MaxAttempts = 3,													-- set this to the maximum number of hotwire attempts
	GrantVehicleKeysOnHotWire = true,									-- set this to false to disable the key being given on successful hotwire
}

Config.VehicleSettings = {
	HotwireDisabled = false,											-- set this to true to disable the hotwire features, this will make it so a player can just get in and drive the car without the keys. And leaves keys exclusively to lock/unlock.
	EngineRemainsOnWhenExiting = true,									-- set this to true to enable the keep vehicle running on exit if not shut off/keep off till toggled on.
	GiveKeysIfEngineRunning = true,									-- set this to true to grant the keys on entering the vehicles that are running (like real life), anyone who enters driver seat while its running will get a key
	IsFronk = {
		-- this is the door index, its for if a car has a trunk in the front etc
		[`adder`] = 4,
		[`reaper`] = 4,
		[`torero`] = 5,
		[`t20`] = 4,
	},
	JobBypassKeys = {
		--[[
		["JobName"] = { -- this is the job name, anthing in this table will be bypassed with this job
			"vehiclename"	-- this is the spawn name of the vehicle.
		},
		--]]
		["police"] = {
			[`police`] = true,
			[`police2`] = true,
			[`polmav`] = true,
		},
		["ambulance"] = {
			[`ambulance`] = true,
			[`polmav`] = true,
		},

	},
	No_Key_Required_Vehicles = {
		[`bmx`] = true,
		[`cruiser`] = true,
		[`scorcher`] = true,
		[`tribike2`] = true,
		[`tribike3`] = true,
		[`fixter`] = true,
		[`tribike`] = true,
		[`inductor`] = true,
		[`inductor2`] = true,
		--put other vehicles you wish to remove key requirements from here
		--this must be the model name itself
	},
	ElectricVehicles = {
		[`dilettante2`] = true,
		[`voltic`] = true,
		[`voltic2`] = true,
		[`dilettante`] = true,
		[`pipistrello`] = true,
		[`omnisegt`] = true,
		[`surge`] = true,
		[`khamelion`] = true,
		[`raiden`] = true,
		[`mower`] = true,
		[`coureur`] = true,
		[`buffalo5`] = true,
		[`cyclone`] = true,
		[`neon`] = true,
		[`tezeract`] = true,
		[`imorgon`] = true,
		[`iwagen`] = true,
		[`virtue`] = true,
		[`vivanite`] = true,
		[`envisage`] = true,

	},
	ConvertableVehicles = {
		[`ninef2`] = true,
		[`cogcabrio`] = true,
		[`felon2`] = true,
		[`carbonizzare`] = true,
		[`rt3000`] = true,
		[`issi2`] = true,
		[`tornado2`] = true,
		[`rapidgt2`] = true,
		[`sentinel2`] = true,
		[`zion2`] = true,
		[`comet7`] = true,
		[`surano`] = true,
		[`windsor2`] = true,
		[`tornado5`] = true,
		[`Vigero3`] = true,
		[`dominator9`] = true,
	},
	HijackImmune = {
		-- Police Vehicles
		[`police`] = true,

		-- EMS Vehicles
		[`sandbulance`] = true,
	}
}

Config.VehicleLockingChance = {
	EnableLocalVehicleLocking = true,									-- set this to to true to enable the chance of the local vehicles being locked, parked/driving otherwise only locked vehicles will be set by spawning locked or set by a player with keys
	UnlockedChance = 0,													-- set this to the percentage chance that local vehicles will be unlocked. Set to 0 to lock all cars (both parked and driving)
}

Config.ItemBasedSettings = {
	using_key_items = false,												-- set this to true if you want to use the keys as an item
	DisableKeyFobUI = false,											-- set this to true if you want to use the keys as an item WITHOUT UI
	vehicleKeysItem = "vehiclekeys",									-- set this to the name of the item that would be used for the keys
	keyRingItem = "keyring",											-- set this to the name of the item that would be used for the keyring
	LockChangeSystemEnabled = true,										-- set this to true to enable the lock change system
	locksystemItem = "aftermarket_locks",								-- set this to the name of the item that would be used for the lock change
	FallBackTimerCheck = 3000,											-- set this to the time in milliseconds that the script will check for keys if they are not found on the player, 3000 = 3 seconds and seems fair. lower the number if you want it to check more often.
}

Config.LockSmithSettings = {
	SpareKeyPrice = 500,												-- set to to the price of a spare key
	KeyRingPrice = 50,													-- set to the price of a key ring
	Locations = {
		["Dirks Locksmithing"] = {
			coords = vector4(170.3532, -1799.5085, 28.34, 327.1338),
			pedmodel = 'u_m_y_pogo_01',
			distance = 100,
			blipSprite = 186,
			blipColor = 1,
			blipDisplay = 4,
			blipScale = 1.2,
		},
	},
}

Config.AnimationSettings = {
	animDict = "veh@break_in@0h@p_m_one@",								-- set to the animation dictionary for progressbar
	anim = "low_force_entry_ds",										-- set to the animation name for progressbar
	keyProp = "prop_cuff_keys_01",										-- set to the prop name for the keys
}

Config.Prefrences = {
	HelpTextPostion 	= "right-center",								-- set this to the position of the notify messages
	LockpickAlertChance = 50,											-- set this to the percentage chance that a dispatch alert will be sent when a vehicle is lockpicked -- set to 0 to never alert
	HotwireAlertChance 	= 50,											-- set this to the percentage chance that a dispatch alert will be sent when a vehicle is Hotwired -- set to 0 to never alert
	LockpickBreakChance = 50,											-- set this to the percentage chance that the lockpick will break when lockpicking fails, set to 100 to never break
	HijackingAlertChance = 50,											-- set this to the percentage chance that a dispatch alert will be sent when a vehicle is hijacked -- set to 0 to never alert
	TargetVehicleFunctionsEnabled = true,								-- set this to true to enable the target points for the lock smith
	DisableVehicleAutoStart = true,									-- set this to true to disable the auto start of the vehicle when entering
	LockPickMiniGame = "t3_lockpick",											-- set this to the minigame you want to use for lockpicking "ox", "bagus", "ps-ui", "bl-progress", "bl-keyspam", "bl-circle", "bl-printlock", "t3_lockpick", "false" (false for none and always success)
	HotWireMiniGame = "bl-circle",												-- set this to the minigame you want to use for hotwiring "ox", "bagus", "ps-ui", "bl-progress", "bl-keyspam", "bl-circle", "bl-printlock", "t3_lockpick", "false"   (false for none and always success)
	ProximityLocking = {												-- set this to true to enable the proximity locking system
		enabled = true,
		lockdistance = 12,												-- set this to the distance for the proximity locking system when the vehicle is unlocked
		unlockdistance = 2,												-- set this to the distance for the proximity locking system when the vehicle is locked
	},
	DispatchAlertJobs = {"police"},										-- set this to the jobs that will receive dispatch alerts
}

Config.CustomCarsMissingLabels = {
	-- This is for messed up cars that display "NULL" in the garage menus/When hitting z in a car. 
	-- This will also prevent keyfobs from saying "NULL" as the name of the vehicle
	-- If you already have something fixing these ignore this
	-- This is just a additional option to help you.
	--{model = "spawnname", label = "desired in game name"},
	{model = "aerocab", label = "Aerocab"},
	{model = "blacktop", label = "Blacktop"},
	{model = "brickades", label = "Brickades"},
	{model = "linerunner", label = "linerunner"},
	{model = "vetirs", label = "Vetirs"},
}