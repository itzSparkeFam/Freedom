--[[
    Welcome to the qs-housing configuration guide!

    Before you dive into setting up your new asset, make sure to read this guide carefully.
    We'll explain each key part of the configuration, step by step, so that you can
    customize everything to fit your server perfectly.

    Important configuration sections will be clearly marked, like this one you're reading now.
    These sections will guide you through each setting available in this file.

    Flexibility is a big part of this setup. Most settings can be adapted to work with
    your specific framework (ESX, QBCore, etc.), so feel free to tweak them as needed.
    You’ll find all the customizable files under client/custom/* or server/custom/*.

    Before you get started, check out our detailed documentation for full guidance:
    https://docs.quasar-store.com/information/welcome

    This resource offers full customization, making it easy to adjust features to your server’s needs.
    Take your time to explore and enjoy building your housing system!


	IMPORTANT
	In the new version, the database of furniture has been changed and the problem of furniture disappearing has been solved.
	However, players' old furniture has disappeared. To bring back the destroyed furniture,
	use the `/revert_decorations` command and restart the script. This will restore the furniture to the database.
	This command can be use only on cmd
	
	DO NOT FORGET TO BACKUP YOUR SERVER BEFORE RUNNING THIS COMMAND! IT IS A ONE-TIME COMMAND
]]

---@generic T
---@param data {[string]: string}
---@return string | false
local function dependencyCheck(data)
	for k, v in pairs(data) do
		if GetResourceState(k):find('started') ~= nil then
			return v
		end
	end
	return false
end

Config = {}
Locales = {}

--[[
    Choose your preferred language!

    In this section, you can select the main language for your asset. We have a wide
    selection of default languages available, located in the locales/* folder.

    If your language is not listed, don't worry! You can easily create a new one
    by adding a new file in the locales folder and customizing it to your needs.

    Default languages available:
        'ar'     -- Arabic
        'bg'     -- Bulgarian
        'ca'     -- Catalan
        'cs'     -- Czech
        'da'     -- Danish
        'de'     -- German
        'el'     -- Greek
        'en'     -- English
        'es'     -- Spanish
        'fa'     -- Persian
        'fr'     -- French
        'hi'     -- Hindi
        'hu'     -- Hungarian
        'it'     -- Italian
        'ja'     -- Japanese
        'ko'     -- Korean
        'nl'     -- Dutch
        'no'     -- Norwegian
        'pl'     -- Polish
        'pt'     -- Portuguese
        'ro'     -- Romanian
        'ru'     -- Russian
        'sl'     -- Slovenian
        'sv'     -- Swedish
        'th'     -- Thai
        'tr'     -- Turkish
        'zh-CN'  -- Chinese (Simplified)
        'zh-TW'  -- Chinese (Traditional)

    After selecting your preferred language, be sure to save your changes and test
    the asset to ensure everything works as expected!
]]

Config.Language = 'en'

--[[
    Framework Detection System:

    This script automatically detects if you're using 'es_extended' (ESX), 'qb-core' (QBCore),
    or 'qbx_core' frameworks. It configures itself based on the detected framework.

    If you've renamed your framework or are using a custom version, do NOT remove the value
    from `Config.Framework`. Instead, follow these steps:

    1. **Create a new framework file**:
        - Add your custom framework logic by creating new files in the following directories:
          - `client/custom/framework/`
          - `server/custom/framework/`

    2. **Modify the detection logic**:
        - You can then adapt the framework detection and customization logic within those files
          to match your specific framework setup.

    Remember: This detection is automatic and should not be edited unless you are certain of the
    changes you're making. Incorrect modifications could cause issues with the functionality.
]]

local frameworks = {
	['es_extended'] = 'esx',
	['qb-core'] = 'qb',
	['qbx_core'] = 'qb'
}

Config.Framework = dependencyCheck(frameworks) or 'standalone'
Config.FiveGuard = false -- Your fiveguard script name if exists, if not false.

--[[
    Inventory System Integration:

    This feature allows you to add a personalized stash for each property in the housing asset.
    The system is designed to automatically detect which inventory system your server uses.

    Supported inventory systems include popular frameworks such as ESX, QBCore, and others.

    If your inventory system is not on the supported list, don't worry! You can manually configure
    your inventory by editing the files located in:
        `client/custom/inventory/*.lua`

    If you need further assistance or run into issues, feel free to contact the seller of the asset
    for guidance and support.
]]

local inventories = {
	['qs-inventory'] = 'qs-inventory',
	['qs-advancedinventory'] = 'qs-advancedinventory',
	['qb-inventory'] = 'qb-inventory',
	['ps-inventory'] = 'ps-inventory',
	['ox_inventory'] = 'ox_inventory',
	['core_inventory'] = 'core_inventory',
	['codem-inventory'] = 'codem-inventory',
	['inventory'] = 'inventory',
	['origen_inventory'] = 'origen_inventory'
}

Config.Inventory = dependencyCheck(inventories) or 'default'

--[[
    Dispatch System Integration:

    This feature allows you to customize how calls and alerts are managed for each supported
    dispatch resource within this asset. The system is designed to automatically detect which
    dispatch system is currently in use on your server.

    Supported dispatch systems include popular frameworks. The detection is done automatically
    based on the resource state.

    If your dispatch system is not listed or automatically detected, you can manually configure it
    by editing the files located in:
        `client/custom/dispatch/*.lua`

    For any questions or concerns, please contact the seller of the asset for further assistance.
]]

local dispatch = {
	['qs-dispatch'] = 'qs-dispatch'
}

Config.Dispatch = dependencyCheck(dispatch) or 'default'

--[[
    Phone System Integration:

    This feature allows us to manage phone-related functions for the asset's sale board,
    ensuring smooth communication and interaction with players. The system is designed
    to automatically detect which phone system is currently in use.

    Popular phone systems are automatically detected based on your server configuration.

    If your phone system is not listed or detected, you can manually configure it by editing
    the necessary files located in:
        `server/custom/phone/*.lua`

    For any questions or support, feel free to contact the seller of this asset for further assistance.
]]

local phones = {
	['qs-smartphone-pro'] = 'qs-smartphone-pro',
	['qs-smartphone'] = 'qs-smartphone',
	['lb-phone'] = 'lb-phone',
	['gksphone'] = 'gksphone',
	['okokPhone'] = 'okokPhone'
}

Config.Phone = dependencyCheck(phones) or 'default'

--[[
    Wardrobe System Integration:

    This function is responsible for the automated configuration of the wardrobe system,
    detecting which wardrobe system is currently in use on your server and setting it
    automatically for this asset.

    If your wardrobe system is not detected or listed here, you can manually configure it
    by editing the relevant files located in:
        `client/custom/wardrobe/*.lua`

    If you have any questions or need assistance, please contact the seller of your asset for support.
]]

local wardrobes = {
	['qb-clothing'] = 'qb-clothing',
	['codem-appearance'] = 'codem-appearance',
	['ak47_clothing'] = 'ak47_clothing',
	['fivem-appearance'] = 'fivem-appearance',
	['illenium-appearance'] = 'illenium-appearance',
	['raid_clothes'] = 'raid_clothes',
	['rcore_clothes'] = 'rcore_clothes',
	['sleek-clothestore'] = 'sleek-clothestore'
}

Config.Wardrobe = dependencyCheck(wardrobes) or 'default'

--[[
    Garage System Configuration:

    This function handles the automatic configuration of the garage system on the server.
    If your server does not use a compatible garage system, or if you haven't created
    a compatible custom garage system in the server files, the option to use garages
    will automatically be disabled.

    To enable garages, you can create or configure a compatible system by editing the files located in:
        `server/custom/garage/*.lua`

    If you have any questions or need help configuring your garage system, contact the seller
    of your asset for further assistance.
]]

local garages = {
	['qb-garages'] = 'qb-garages',
	['qs-advancedgarages'] = 'qs-advancedgarages',
	['jg-advancedgarages'] = 'jg-advancedgarages',
	['cd_garage'] = 'cd_garage',
	['okokGarage'] = 'okokGarage',
	['loaf_garage'] = 'loaf_garage',
	['rcore_garage'] = 'rcore_garage',
	['zerio-garage'] = 'zerio-garage',
	['codem-garage'] = 'codem-garage',
	['ak47_garage'] = 'ak47_garage',
	['vms_garagesv2'] = 'vms_garagesv2',
	['cs-garages'] = 'cs-garages'
}

Config.Garage = dependencyCheck(garages) or 'standalone'

--[[
    General Configuration Overview:

    This section outlines the basic and advanced settings for the asset. It allows you to customize
    key elements such as the use of a targeting system (qb-target or ox_target), property upgrades
    (like security systems), and house creation jobs. It also provides options to manage the
    currency format, house ownership limits, and the in-game menus for interacting with houses.

    You can adjust these settings to fit your server's needs, whether it's tweaking commissions,
    limiting the number of houses a player can own, or enabling/disabling the sales board.
]]

Config.NeedToBeInsidePoints = {
	['customHouse'] = false,
	['shell'] = false -- Force shell to be inside of the poly points
}

Config.UseTarget = false -- Set true/false (only qb-target or ox_target)
Config.TargetLength = 5.0
Config.TargetWidth = 5.0

Config.Upgrades = {
	{
		name = 'alarm',
		title = 'Security Alarm',
		price = 10000,
		icon = 'alarmImage'
	},
	{
		name = 'camera',
		title = 'Security Cameras',
		price = 35000,
		icon = 'cameraImage'
	},
	{
		name = 'sensor',
		title = 'Motion Sensor',
		price = 45000,
		icon = 'motionImage'
	},
	{
		name = 'vault',
		title = 'Vault Lock',
		price = 50000,
		icon = 'vaultImage'
	}
}


Config.Society = 'esx_society' -- 'none', 'esx_society', 'ap-government', 'esx_society' or 'qb-management'
Config.SocietyCommision = 0.3  -- Percentage of the commission for the company (%30 of house price)

-- Taxes configuration
Config.BankFee = function(price) return price / 100 * 10 end
Config.BrokerFee = function(price) return price / 100 * 5 end
Config.Taxes = function(price) return price / 100 * 5 end

Config.UseMathCeilOnFees = true

Config.CreatorJobs = { -- Choose the jobs suitable for creating houses
	'realestate',
	'police',
	'realestatejob'
}

Config.TestRemTime = 1                -- Visiting time inside the house (1 = 1 minute)
Config.MinZOffset = 30                -- Minimum shell spawn offset
Config.CreatorAlpha = 200             -- Ignore this if you don't want to edit the Alpha
Config.SignTextScale = 0.6            -- Sale poster text size
Config.TimeInterior = 23              -- This is the time it will be when entering the shells (to avoid alternating shadows)
Config.HideOwnedHouses = true         -- Hide owned houses from the map
Config.GroupBlips = false             -- Hide address on the blips (Short blips)
Config.MaxOwnedHouses = 15            -- Limit of houses per player (5 default)
Config.SellObjectCommision = 0.3      -- Commission that will be charged when selling a piece of furniture
Config.EnableBoard = true             -- Enable or disable the sales board
Config.BoardObject = 'qs_salesign_01' -- House for sale sign prop (edit it for another one if you want)
Config.BoardSpawnDistance = 35.0
Config.UseDrawTextOnBoard = true      -- Use DrawText3D on the sales board
Config.MaxApartmentCount = 50         -- Maximum number of apartments per house (Remember that every apartment is a house, so make sure you keep this at a low value so that it doesn't adversely affect the performance of your server.)
Config.DefaultLightIntensity = 20.0
Config.MaxVaultCodes = 3              -- Select the number of vaults that each home can have


-- Your currency symbol (https://www.telerik.com/blogs/javascript-intl-object)
Config.Intl = {
	locales = 'en-US',      -- 'en-US', 'pt-BR', 'es-ES', 'fr-FR', 'de-DE', 'ru-RU', 'zh-CN'
	options = {
		style = 'currency', -- 'decimal', 'currency', 'percent', 'unit'
		currency = 'USD',   -- 'USD', 'EUR', 'BRL', 'RUB', 'CNY'
		minimumFractionDigits = 0 -- 0, 1, 2, 3, 4, 5
	}
}

Config.Blip = {
	forSale = {
		enabled = true,
	},
	owned = {
		enabled = true,
		color = 3
	},
	ownedOther = {
		enabled = true,
		color = 3
	},
	officialOwned = { -- When put the rent the house you are official owner of the house
		enabled = true,
		color = 2
	},
	rentable = {
		enabled = true,
		color = 5
	},
	purchasable = {
		enabled = true,
		color = 4
	}
}

Config.DisableAllHouseBlips = false           -- Disable all blips on the map

Config.OpenHouseMenu = 'F3'                   -- Key to open the internal menu of the home
Config.OpenJobMenu = 'F7'                     -- Key to open the house creation menu

Config.DisableBuyableDecorationFromF3 = false -- Disable the purchase of decorations from the F3 menu (stonks for ikea)

--[[
    Illegal System Configuration:

    This section handles the configuration for the illegal system in the asset.
    Make sure to carefully control this to avoid breaking the in-game economy
    or disrupting player systems.

    It is recommended to use mini-game scripts as part of the illegal system's operation.
    You can find more details and the necessary dependencies for these scripts in the
    documentation under the 'dependencies' section.
]]

Config.RequiredCop = 0 -- Number of police required (only for lockpicking)
Config.PoliceJobs = {  -- Jobs that will be considered police
	'realestate',
	'police',
	'realestatejob'
}

Config.EnableRobbery = true            -- Enable or disable the usable item to initiate robberies
Config.EnableRaid = true               -- Enable or disable the usable item to initiate raids
Config.RobberyItem = 'lockpick'        -- Item to start the robbery of houses
Config.StomRamItem = 'police_stormram' -- Item to begin the search of a house

--[[
    Rental and Mortgage System Configuration:

    This section is dedicated to configuring the rental system for homes,
    including how the rental process works and the duration of rental agreements.
    It also handles the configuration of credit times for players purchasing homes through
    mortgages, allowing you to set repayment schedules and terms.

    Customize these settings to ensure the rental and mortgage system fits the economy
    and gameplay style of your server.
]]

Config.CreditEnable = true                     -- Enable or disable the mortgage option in the house contract.
Config.CreditEq = 0.3                          -- Collection percentage for bank loans (default 0.3)
Config.CreditTime = 5                          -- Time interval to collect bank credit (5 = 5 minutes)
Config.HireRenterCommand = 'hireRenter'        -- Command for the administrator to expel a tenant from the property (force eviction)

Config.RentTime = 5                            -- Time interval to collect rent (5 = 5 minutes)
Config.EnableRentable = true                   -- Enable or disable the rental system
Config.CreatedRentableHousesManageable = false -- If you set this to false, realestate cannot cancel the lease or expel players.

--[[
    Decoration and Stash Configuration:

    This section allows you to configure the decoration and stash settings for each house.
    You can specify whether only the owner of the house can decorate it, or if anyone
    with keys has permission to do so. Additionally, this section manages the basic stash
    system for each home, allowing for personal storage.

    Adjust these settings based on the level of access you want to give to other players
    who have access to the house.
]]

Config.SpawnDistance = 100.0             -- Distance in meters for spawning related objects/entities
Config.MaximumDistanceForDecorate = 350.0
Config.DecorateOnlyAccessForOwner = true -- Can anyone with a key decorate or only the owner?
Config.HideRadarInDecorate = true        -- Disable radar in decorations?
Config.ModernDecorateMode = true         -- Use the old keyboard and mouse decoration system (if you use true, you will use the modern method)

Config.DefaultStashData = {
	maxweight = 1000000,
	slots = 30,
}

Config.Music = 'building' -- You can set false if you don't want music
Config.MusicVolume = 0.01 -- Choose a volume for the songs

Config.HandleHud = {
	enable = function()
		Debug('Enable hud triggered')
		-- Enable your hud
	end,
	disable = function()
		Debug('Disable hud triggered')
		-- Disable your hud
	end
}

--[[
    Shell and 3D Model Configuration:

    This section is dedicated to configuring the shells (interior models) and 3D props
    used for house creation. You can define the props you want to use or specify the
    shell models in this configuration. There is no limit to the number of shells or models
    you can add to this list.

    If you're looking for additional shells, we recommend visiting our trusted partner at
    https://www.k4mb1maps.com, known for providing some of the best FiveM shells.

    Feel free to expand this list as needed to fit your server's requirements.
]]

Config.Shells = {
	[1] = {
		model = 'standardmotel_shell',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- }
	},
	[2] = {
		model = 'modernhotel_shell',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[3] = {
		model = 'furnitured_midapart',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[4] = {
		model = 'shell_garagem',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[5] = {
		model = 'shell_office1',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[6] = {
		model = 'shell_store1',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[7] = {
		model = 'shell_warehouse1',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[8] = {
		model = 'container_shell',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[9] = {
		model = 'shell_michael',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[10] = {
		model = 'shell_frankaunt',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[11] = {
		model = 'shell_ranch',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[12] = {
		model = 'shell_trailer',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[13] = {
		model = 'shell_lester',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[14] = {
		model = 'shell_v16mid',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[15] = {
		model = 'shell_trevor',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
	[16] = {
		model = 'shell_v16low',
		stash = {
			maxweight = 1000000,
			slots = 5,
		},
		-- imgs = {
		-- 	{
		-- 		url = 'Add imagen here (optional, is only for future dlcs)',
		-- 		label = 'Name room',
		-- 	},
		-- },
	},
}

exports('getShells', function()
	return Config.Shells
end)

Config.HouseObjects = {
	[1] = { -- House 1
		model = 'lf_house_04_',
	},
	[2] = { -- House 2
		model = 'lf_house_05_',
	},
	[3] = { -- House 3
		model = 'lf_house_07_',
	},
	[4] = { -- House 4
		model = 'lf_house_08_',
	},
	[5] = { -- House 5
		model = 'lf_house_09_',
	},
	[6] = { -- House 6
		model = 'lf_house_10_',
	},
	[7] = { -- House 7
		model = 'lf_house_11_',
	},
	[8] = { -- House 8
		model = 'lf_house_13_',
	},
	[9] = { -- House 9
		model = 'lf_house_15_',
	},
	[10] = { -- House 10
		model = 'lf_house_16_',
	},
	[11] = { -- House 11
		model = 'lf_house_17_',
	},
	[12] = { -- House 12
		model = 'lf_house_18_',
	},
	[13] = { -- House 13
		model = 'lf_house_19_',
	},
	[14] = { -- House 14
		model = 'lf_house_20_',
	},
}

Config.Islands = {
	[1] = { -- Island 1
		model = 'qs_pineisland_01',
	},
	[2] = { -- Island 2
		model = 'qs_pineisland_02',
	},
	[3] = { -- Island 3
		model = 'qs_pineisland_03',
	},
	[4] = { -- Island 4
		model = 'qs_treeisland_01',
	},
	[5] = { -- Island 5
		model = 'qs_treeisland_02',
	},
	[6] = { -- Island 6
		model = 'qs_treeisland_03',
	},
	[7] = { -- Island 7
		model = 'qs_tropiisland_01',
	},
	[8] = { -- Island 8
		model = 'qs_tropiisland_02',
	},
	[9] = { -- Island 9
		model = 'qs_tropiisland_03',
	},
}

Config.IplData = {
	{
		-- Apartment
		export = function()
			return exports['bob74_ipl']:GetExecApartment1Object()
		end,
		defaultTheme = 'seductive',
		themes = {
			{ label = 'Modern',     value = 'modern',     price = 500, image = './assets/img/management/themes/apartment/modern.png' },
			{ label = 'Moody',      value = 'moody',      price = 500, image = './assets/img/management/themes/apartment/moody.png' },
			{ label = 'Vibrant',    value = 'vibrant',    price = 500, image = './assets/img/management/themes/apartment/vibrant.png' },
			{ label = 'Monochrome', value = 'monochrome', price = 500, image = './assets/img/management/themes/apartment/monochrome.png' },
			{ label = 'Seductive',  value = 'seductive',  price = 500, image = './assets/img/management/themes/apartment/seductive.png' },
			{ label = 'Regal',      value = 'regal',      price = 500, image = './assets/img/management/themes/apartment/regal.png' },
			{ label = 'Aqua',       value = 'aqua',       price = 500, image = './assets/img/management/themes/apartment/aqua.png' },
			-- { label = 'Sharp',      value = 'sharp',      price = 500, image = './assets/img/management/themes/apartment/sharp.png' }
		},
		exitCoords = vec3(-787.44, 315.81, 217.64),
		iplCoords = vec3(-787.78050000, 334.92320000, 215.83840000),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Office
		export = function()
			return exports['bob74_ipl']:GetFinanceOffice1Object()
		end,
		defaultTheme = 'warm',
		themes = {
			{ label = 'Warm',         value = 'warm',         price = 500, image = './assets/img/management/themes/office/warm.png' },
			{ label = 'Classical',    value = 'classical',    price = 500, image = './assets/img/management/themes/office/classical.png' },
			{ label = 'Vintage',      value = 'vintage',      price = 500, image = './assets/img/management/themes/office/vintage.png' },
			{ label = 'Contrast',     value = 'contrast',     price = 500, image = './assets/img/management/themes/office/contrast.png' },
			{ label = 'Rich',         value = 'rich',         price = 500, image = './assets/img/management/themes/office/rich.png' },
			{ label = 'Cool',         value = 'cool',         price = 500, image = './assets/img/management/themes/office/cool.png' },
			{ label = 'Ice',          value = 'ice',          price = 500, image = './assets/img/management/themes/office/ice.png' },
			{ label = 'Conservative', value = 'conservative', price = 500, image = './assets/img/management/themes/office/conservative.png' },
			{ label = 'Polished',     value = 'polished',     price = 500, image = './assets/img/management/themes/office/polished.png' }
		},
		exitCoords = vec3(-141.1987, -620.913, 168.8205),
		iplCoords = vec3(-141.1987, -620.913, 168.8205),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Night Club
		exitCoords = vec3(-1569.402222, -3017.604492, -74.413940),
		iplCoords = vec3(-1604.664, -3012.583, -78.000),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Clubhouse 1
		exitCoords = vec3(1121.037354, -3152.782471, -37.074707),
		iplCoords = vec3(1107.04, -3157.399, -37.51859),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Clubhouse 2
		exitCoords = vec3(997.028564, -3158.136230, -38.911377),
		iplCoords = vec3(998.4809, -3164.711, -38.90733),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Cocaine Lab
		exitCoords = vec3(1088.703247, -3187.463623, -38.995605),
		iplCoords = vec3(1093.6, -3196.6, -38.99841),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Meth Lab
		exitCoords = vec3(996.896729, -3200.914307, -36.400757),
		iplCoords = vec3(1009.5, -3196.6, -38.99682),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Weed Lab
		exitCoords = vec3(1066.298950, -3183.586914, -39.164062),
		iplCoords = vec3(1056.975830, -3194.571533, -39.164062),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Counterfeit Cash Factory
		exitCoords = vec3(1138.101074, -3199.107666, -39.669556),
		iplCoords = vec3(1121.897, -3195.338, -40.4025),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Document Forgery
		exitCoords = vec3(1173.7, -3196.73, -39.01),
		iplCoords = vec3(1165, -3196.6, -39.01306),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Penthouse Casino
		exitCoords = vec3(980.83, 56.51, 116.16),
		iplCoords = vec3(976.636, 70.295, 115.164),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- NightClub Warehouse
		exitCoords = vec3(-1520.88, -2978.54, -80.45),
		iplCoords = vec3(-1505.783, -3012.587, -80.000),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- 2 Car
		exitCoords = vec3(179.15, -1000.15, -99.0),
		iplCoords = vec3(173.2903, -1003.6, -99.65707),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- 6 Car
		exitCoords = vec3(212.4, -998.97, -99.0),
		iplCoords = vec3(197.8153, -1002.293, -99.65749),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- 10 Car
		exitCoords = vec3(240.67, -1004.69, -99.0),
		iplCoords = vec3(229.9559, -981.7928, -99.66071),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Casino NightClub
		exitCoords = vec3(1545.57, 254.22, -46.01),
		iplCoords = vec3(1550.0, 250.0, -48.0),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Warehouse Small
		exitCoords = vec3(1087.43, -3099.48, -39.0),
		iplCoords = vec3(1094.988, -3101.776, -39.00363),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Warehouse Medium
		exitCoords = vec3(1048.12, -3097.28, -39.0),
		iplCoords = vec3(1056.486, -3105.724, -39.00439),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Warehouse Large
		exitCoords = vec3(992.38, -3098.08, -39.0),
		iplCoords = vec3(1006.967, -3102.079, -39.0035),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Vehicle Warehouse
		exitCoords = vec3(956.12, -2987.24, -39.65),
		iplCoords = vec3(994.5925, -3002.594, -39.64699),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Old Bunker Interior
		exitCoords = vec3(899.5518, -3246.038, -98.04907),
		iplCoords = vec3(899.5518, -3246.038, -98.04907),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Arcadius Garage 1
		exitCoords = vec3(-198.666, -580.515, 136.00),
		iplCoords = vec3(-191.0133, -579.1428, 135.0000),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- Arcadius Mod Shop
		exitCoords = vec3(-139.388, -587.917, 167.00),
		iplCoords = vec3(-146.6166, -596.6301, 166.0000),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- 2133 Mad Wayne Thunder
		exitCoords = vec3(-1289.89, 449.83, 97.9),
		iplCoords = vec3(-1288, 440.748, 97.69459),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- 2868 Hillcrest Avenue
		exitCoords = vec3(-753.04, 618.82, 144.14),
		iplCoords = vec3(-763.107, 615.906, 144.1401),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- EclipseTowers, Apt 3	
		exitCoords = vec3(-785.12, 323.75, 212.0),
		iplCoords = vec3(-773.407, 341.766, 211.397),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	},
	{
		-- 	Dell Perro Heights, Apt 7
		exitCoords = vec3(-1453.86, -517.64, 56.93),
		iplCoords = vec3(-1477.14, -538.7499, 55.5264),
		stash = {
			maxweight = 1000000,
			slots = 10,
		},
	}
}

--[[
	This script sets up a construction system for a FiveM server. It allows you to create interactive construction zones with NPCs working on them.

	1. **Config.Construction**: Enables or disables the construction system.

	2. **Config.Constructions**: A table of defined construction projects. Each entry includes:
		- **duration**: Time in milliseconds for the construction to complete (e.g., 60 seconds here).
		- **model**: Temporary construction model that replaces the final model during the building phase.
		- **peds**: A list of NPCs with their models, positions, headings, and animations to simulate workers.
]]

Config.Construction = false -- Enable constructión timer/animations?

---@type table<string, Construction>
Config.Constructions = {
	['lf_house_04_'] = {
		duration = 10 * 60, -- 1 minute
		model = 'prop_pighouse2', -- Construction model. When construction is done it will be change with original model
		peds = {            -- Your ped offsets you can add whatever you want
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_05_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_07_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_08_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_09_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_10_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_11_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_13_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_15_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_16_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_17_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_18_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_19_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
	['lf_house_20_'] = {
		duration = 10 * 60,
		model = 'prop_pighouse2',
		peds = {
			{
				model = 's_m_m_dockwork_01',
				offsets = vec3(0.0, 0.3, 0.0),
				heading = 65.54,
				anim = 'base',
				dict = 'anim@amb@office@boardroom@boss@male@',
			},
			{
				model = 's_m_m_gardener_01',
				offsets = vec3(1.0, 2.0, 0.0),
				heading = 179.27,
				anim = 'idle_a',
				dict = 'amb@world_human_picnic@female@idle_a',
			}
		}
	},
}

--[[
    Shell/IPL/MLO General Controls Configuration:

    This section allows you to configure the general controls and language settings
    when modifying or creating shells, IPL (Interior Proxy Library), or MLO (Map Loaded Object) models.

    You can adjust these controls to your preference, ensuring smooth operation when
    handling interiors and models in your server.

    Make sure to configure these settings carefully, as they will determine how you
    interact with and customize interiors within the game.
]]

ActionControls = {
	forward = {
		label = 'Forward +/-',
		codes = { 33, 32 }
	},
	right = {
		label = 'Right +/-',
		codes = { 35, 34 }
	},
	up = {
		label = 'Up +/-',
		codes = { 52, 51 }
	},
	add_point = {
		label = 'Add Point',
		codes = { 24 }
	},
	set_any = {
		label = 'Set',
		codes = { 24 }
	},
	undo_point = {
		label = 'Undo Last',
		codes = { 25 }
	},
	set_position = {
		label = 'Set Position',
		codes = { 24 }
	},
	add_garage = {
		label = 'Add Garage',
		codes = { 24 }
	},
	rotate_z = {
		label = 'RotateZ +/-',
		codes = { 20, 73 }
	},
	rotate_z_scroll = {
		label = 'RotateZ +/-',
		codes = { 17, 16 }
	},
	increase_z = {
		label = 'Z Boundary +/-',
		codes = { 180, 181 }
	},
	decrease_z = {
		label = 'Z Boundary +/-',
		codes = { 21, 180, 181 }
	},
	done = {
		label = 'Done',
		codes = { 191 }
	},
	change_player = {
		label = 'Player +/-',
		codes = { 82, 81 }
	},
	change_shell = {
		label = 'Change Shell +/-',
		codes = { 189, 190 }
	},
	select_player = {
		label = 'Select Player',
		codes = { 191 }
	},
	cancel = {
		label = 'Cancel',
		codes = { 194 }
	},
	change_outfit = {
		label = 'Outfit +/-',
		codes = { 82, 81 }
	},
	delete_outfit = {
		label = 'Delete Outfit',
		codes = { 178 }
	},
	select_vehicle = {
		label = 'Vehicle +/-',
		codes = { 82, 81 }
	},
	spawn_vehicle = {
		label = 'Spawn Vehicle',
		codes = { 191 }
	},
	leftApt = {
		label = 'Previous Apartment',
		codes = { 174 }
	},
	rightApt = {
		label = 'Next Apartment',
		codes = { 175 }
	},
	testPos = {
		label = 'Test Pos',
		codes = { 47 }
	},
}

Config.DoorDistance = 1.5                  -- Distance to interact with doors
Config.DoorDuplicateDistance = 3.0         -- If door is closest by this distance it will be one door

Config.DynamicDoors = true                 -- Enable dynamic doors? needs `setr game_enableDynamicDoorCreation "true"`
Config.CreditToggleActiveInDefault = false -- Enable credit toggle active in default

CameraOptions = {
	lookSpeedX = 500.0,
	lookSpeedY = 500.0,
	moveSpeed = 10.0,
	climbSpeed = 10.0,
	rotateSpeed = 50.0,
}

--[[
    Custom House Creation Configuration:

    This section allows you to manually create custom houses directly through the configuration
    files without using the in-game creation system. This option is more complex and is recommended
    only for experienced developers who are familiar with server-side modifications.

    If you are not an experienced developer, we strongly advise using the in-game F7 menu
    and the appropriate job role for creating and managing houses.

    Manual configuration should only be done if you understand the process well to avoid issues.
]]

CreatingHouse = {}

Config.Houses = {
	-- 	['Test House'] = {
	-- 		owned = 0,
	-- 		price = 0,
	-- 		locked = true,
	-- 		address = 'Nikola p1',
	-- 		tier = 1,
	-- 		coords = {
	-- 			enter = {
	-- 				['z'] = 71.46570587158203,
	-- 				['h'] = 311.8609924316406,
	-- 				['x'] = 1303.005859375,
	-- 				['y'] = -527.4683837890625
	-- 			},
	-- 			PolyZone = {
	-- 				thickness = 25.0,
	-- 				usePolyZone = true,
	-- 				points = { {
	-- 					['x'] = 1303.5743408203125,
	-- 					['y'] = -500.41802978515625,
	-- 					['z'] = 71.0
	-- 				}, {
	-- 					['x'] = 1293.0418701171875,
	-- 					['y'] = -537.6560668945312,
	-- 					['z'] = 71.0
	-- 				}, {
	-- 					['x'] = 1311.5504150390625,
	-- 					['y'] = -544.9464721679688,
	-- 					['z'] = 71.0
	-- 				}, {
	-- 					['x'] = 1327.7315673828125,
	-- 					['y'] = -498.835205078125,
	-- 					['z'] = 71.0
	-- 				} }
	-- 			},
	-- 			cam = {
	-- 				['h'] = 311.8609924316406,
	-- 				['y'] = -527.4683837890625,
	-- 				['z'] = 71.46570587158203,
	-- 				yaw = -10.0,
	-- 				['x'] = 1303.005859375
	-- 			},
	-- 			exit = {
	-- 				['z'] = 27.56341361999511,
	-- 				['h'] = 246.86099243164062,
	-- 				['x'] = 1264.6019287109375,
	-- 				['y'] = -545.8494262695312
	-- 			},
	-- 			interiorCoords = {
	-- 				['x'] = 1266.744384765625,
	-- 				['y'] = -544.3600463867188,
	-- 				['z'] = 26.55422592163086,
	-- 				['w'] = 311.8609924316406
	-- 			},
	-- 			shellCoords = {
	-- 				['z'] = 26.55422592163086,
	-- 				['h'] = 311.8609924316406,
	-- 				['x'] = 1266.744384765625,
	-- 				['y'] = -544.3600463867188
	-- 			}
	-- 		},
	-- 		garage = {
	-- 			max = 4, -- Maximum spawn point [max slot]
	-- 			access = {},
	-- 			slots = {
	-- 				[1] = { -- Spawn Points
	-- 					x = -125.64788055419922,
	-- 					y = -1297.646728515625,
	-- 					z = 29.44520378112793,
	-- 					h = 93.55599975585938,
	-- 				},
	-- 			},
	-- 			coords = {
	-- 				-- Garage location
	-- 				x = -228.8,
	-- 				y = -990.41,
	-- 				z = 29.34,
	-- 				h = 267.02,
	-- 			}
	-- 		},
	-- 	}
}

--[[
    Free Mode Keys Configuration:

    This configuration defines the key bindings for Free Mode, allowing users
    to move, rotate, and manipulate objects within the environment. These keys
    are mapped to specific functions to provide intuitive controls for object
    placement and adjustments.

    Each key binding corresponds to a particular action, such as increasing
    speed, moving objects in specific directions, or rotating them for fine-tuning.
    These bindings are essential for achieving precise placement and control
    over objects in the environment.

    Customizable Key Bindings:
    - ChangeKey: Switches between different movement modes.
    - Speed Adjustment: Controls the movement speed of objects.
    - Directional Movement: Moves objects along the X, Y, and Z axes.
    - Rotation: Rotates objects around their axes.
    - Tilt: Tilts objects for angled adjustments.
    - Stick to Ground: Aligns objects to the ground level.

    Developers or server administrators can customize these keys to match their
    preferences or to integrate seamlessly with other controls in their resource.
]]

Keys = { ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57, ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177, ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18, ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182, ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81, ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70, ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178, ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173, ['NENTER'] = 201, ['N4'] = 108, ['N5'] = 60, ['N6'] = 107, ['N+'] = 96, ['N-'] = 97, ['N7'] = 117, ['N8'] = 61, ['N9'] = 118 }

Config.FreeModeKeys = {
	ChangeKey = Keys['LEFTCTRL'],

	MoreSpeed = Keys['.'],
	LessSpeed = Keys[','],

	MoveToTop = Keys['TOP'],         -- Key to move the object upwards (Top Arrow)
	MoveToDown = Keys['DOWN'],       -- Key to move the object downwards (Down Arrow)

	MoveToForward = Keys['TOP'],     -- Key to move the object forward (Top Arrow)
	MoveToBack = Keys['DOWN'],       -- Key to move the object backward (Down Arrow)
	MoveToRight = Keys['RIGHT'],     -- Key to move the object to the right (Right Arrow)
	MoveToLeft = Keys['LEFT'],       -- Key to move the object to the left (Left Arrow)

	RotateToTop = Keys['6'],         -- Key to rotate the object to the top (Number 6)
	RotateToDown = Keys['7'],        -- Key to rotate the object downwards (Number 7)
	RotateToLeft = Keys['8'],        -- Key to rotate the object to the left (Number 8)
	RotateToRight = Keys['9'],       -- Key to rotate the object to the right (Number 9)

	TiltToTop = Keys['Z'],           -- Key to tilt the object to the top
	TiltToDown = Keys['X'],          -- Key to tilt the object downwards
	TiltToLeft = Keys['C'],          -- Key to tilt the object to the left
	TiltToRight = Keys['V'],         -- Key to tilt the object to the right

	StickToTheGround = Keys['LEFTALT'], -- Key to stick the object to the ground (Left Alt)
}

--[[
    Debug Mode:

    This mode is designed to provide constant feedback and print information
    from the system, which can be helpful for developers to understand how
    the resource operates.

    We do not recommend enabling debug mode unless you are a developer,
    as it will flood your console with information, but it can be valuable
    for troubleshooting and understanding the inner workings of the system.
]]

Config.Debug = true      -- Enable or disable debug mode for general information and troubleshooting.
Config.ZoneDebug = false -- Enable or disable debug mode for zone-related actions and details.
