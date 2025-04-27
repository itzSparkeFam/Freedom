----------
Config = {}
---------- [Framework] ----------
-- (DONT TOUCH THIS UNLESS YOU HAVE A CUSTOM FRAMEWORK)
if GetResourceState('es_extended') == 'started' then
    Framework = "ESX" -- (ESX) or (QBCore)
elseif GetResourceState('qb-core') == 'started' then
    Framework = "QBCore" -- (ESX) or (QBCore)
end
if Framework == "QBCore" then
    Config.CoreName = "qb-core" -- your core name
    FWork = exports[Config.CoreName]:GetCoreObject()
elseif Framework == "ESX" then
    Config.CoreName = "es_extended" -- your core name
    FWork = exports[Config.CoreName]:getSharedObject()
end
------------------------------
------------------------------
Config.Debug = false -- enables debug poly for zones and prints
------------------------------
------------------------------
-- [THESE ARE NOT NOT MEANT TO BE TOUCHED UNLESS YOU KNOW WHAT YOU ARE DOING]
Config.CompatibleTargetScripts = { -- Put whatever target script you use in this table if it is not here.
    "ox_target",
    "qb-target",
    "qtarget",
}
Config.CompatibleInputScripts = { -- If you have multiple input scripts in your server, Put only the one you want to use in this table or else dont touch this.
    "ox_lib",
    "qb-input",
    "ps-ui",
}
Config.CompatibleMenuScripts = { -- If you have multiple Menu scripts in your server, Put only the one you want to use in this table or else dont touch this.
    "ox_lib",
    "qb-menu",
    "ps-ui",
}
Config.CompatibleManagmentScripts = { -- Having a compatible managment script is not required
    "qb-management",
    "prime-management",
    "esx_society"
}
Config.CompatibleInventoryScripts = { -- Having a compatible inventory script is not required
    "codem-inventory",
    "ox_inventory",
    "ps-inventory",
    "qs-inventory",
    "ps-inventory",
    "ps-inventory",
}
Config.CompatibleDispatchScripts = { -- Having a compatible dispatch script is not required
    "ps-dispatch",
    "qs-dispatch",
}
Config.CompatiblePhoneScripts = { -- Having a compatible phone script is not required
    "qb-phone",
    "qs-smartphone",
    "lb-phone",
    "roadphone",
    "jpr-phonesystem",
}
------------------------------
------------------------------
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatibleTargetScripts) do
    if GetResourceState(v) == 'started' then
        Config.Target = tostring(v)
        break
    end
end
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatibleInputScripts) do
    if GetResourceState(v) == 'started' then
        Config.InputScript = tostring(v)
        break
    end
end
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatibleMenuScripts) do
    if GetResourceState(v) == 'started' then
        Config.Menu = tostring(v)
        break
    end
end
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatibleManagmentScripts) do
    if GetResourceState(v) == 'started' then
        Config.ManagementScript = tostring(v)
        break
    end
end
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatibleInventoryScripts) do
    if GetResourceState(v) == 'started' then
        Config.InventoryType = tostring(v)
        break
    end
end
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatibleDispatchScripts) do
    if GetResourceState(v) == 'started' then
        Config.DispatchScript = tostring(v)
        break
    end
end
-- (DONT TOUCH ANY OF THIS SECTION)
for _, v in pairs(Config.CompatiblePhoneScripts) do
    if GetResourceState(v) == 'started' then
        Config.Phone = tostring(v)
        break
    end
end
------------------------------
Config.MiniGameScript = 'ps-ui' -- Recommended to use ps-ui script (if you do not want to use ps-ui search the script for Config.MiniGameScript and change it to your liking)
Config.VehilceKeysScript = "qb-vehiclekeys" -- The name of your vehicle keys script
----------
Config.VehilceKeysGivenToPlayerEvent = "vehiclekeys:client:SetOwner" -- Event used to give player keys to vehicle
Config.ClothingMenuEvent = "illenium-appearance:client:openMenu" -- (ox_appearance:wardrobe) MAME THIS NIL IF YOU DONT WANT CLOTHING ROOM TO BE AN UPGEADE event used to give players the clothing menu when they upgrade there garage to have this option
----------
----------
Config.ChopBlip = 653 -- The blip icon for when a player goes and breaks down a car for its parts. Blip id's can be found here: https://docs.fivem.net/docs/game-references/blips/
Config.ChopBlipColor = 46 -- The blip icon color for when a player goes and breaks down a car for its parts. Blip id's can be found here: https://docs.fivem.net/docs/game-references/blips/
----------
Config.DropOffBlip = 357 -- The blip icon for when a player has to take a car back to there garage after they stole it. Blip id's can be found here: https://docs.fivem.net/docs/game-references/blips/
Config.DropOffBlipColor = 2 -- The blip icon color for when a player has to take a car back to there garage after they stole it. Blip id's can be found here: https://docs.fivem.net/docs/game-references/blips/
----------
Config.BigCircleBlipColor = 49 -- Big blip color for when you need to find the car to pickup
----------
----------
Config.CarsNeededToEarnForDrop = 175 -- The amount of cars a garages has needed to earn overall to have a chance at getting Config.RareItem1 and Config.RareItem2 drops when they search a trunk
Config.RareItem2 = "nos" -- Another very rare item you cab only get when searching a trunk if your garage has earned over Config.CarsNeededToEarnForDrop cars overall
Config.RareItemChance2 = 4 -- The % of chance player gets Config.RareItem2 if there garage has earned over Config.CarsNeededToEarnForDrop amount.. (so if you change this to 50 for example the player will have a 50% chance of Config.RareItem2 every time they search a trunk)

Config.RareItem1 = "thermite_h" -- A very rare item you cab only get when searching a trunk if your garage has earned over Config.CarsNeededToEarnForDrop cars overall
Config.RareItemChance = 1 -- The % of chance player gets Config.RareItem1 if there garage has earned over Config.CarsNeededToEarnForDrop amount. (so if you change this to 50 for example the player will have a 50% chance of Config.RareItem1 every time they search a trunk)
----------
----------
Config.RandomRareItem = "advancedlockpick" -- Random Rare drop a player can get when searching a trunk with no requirements needed
Config.RandomRareItemChance = 60 -- The % of chance player gets Config.RandomRareItem when searching a trunk (no requirements needed for the player to get this item unlike how Config.RareItem1 and Config.RareItem2 work)
----------
----------
Config.SetVehiclesLocked = true -- Set this false if you want vehicles to be unlocked when players go to pick them up when stealing the,
Config.PugSlingScript = false -- Make this true if you are also using my sling script here: https://pug-scripts.tebex.io/package/5202185
Config.UseProgressBar = false -- Some esx servers may not use a progress bar. (ignore this if your qbcore)
Config.DoCutSceneWehnPurchase = true -- Toggle the cutscene that plays when a player buys a garage true or false
Config.DoCameraEffect = true -- Create a camera effect every time you enter the garage
Config.CanRemoveGarageOwner = true -- If the members of the garage can remove the owner or not
----------
----------
Config.JobRequired = false -- Make this true or false for if the player needs the Config.JobName job role to do this job.
Config.JobName = "mechanic" -- This is the job name required only if Config.JobRequired is true
----------
----------
Config.UseSharedVehicleCars = true -- (QBCore ONLY) Make this true if you want the vehicles that are randomly spawned to be picked up to be any vehicle in the shared.lua (if the shop is boat, air, or police it will reroll the car until its not one of thoese)
Config.GetCopCarChanceIfLandsOnCopCar = 50 -- % chance of getting the police car if the random roll of a vehicle lands on a cop car (Ignore this if Config.UseSharedVehicleCars is false as this never gets used if Config.UseSharedVehicleCars is false)
----------
----------
Config.DrawtextStyle = "White&NoBackground" -- This is the draw text style for breaking down the car. (Purupe&White) or (White&NoBackground) are the two style options

Config.DrawMarkerIcon = 1 -- DrawMarker icon for dropping stolen vehicle off. List of Marker icons can be found here: https://docs.fivem.net/docs/game-references/markers/
Config.DrawMarkerColor = {R = 255, G = 97, B = 255} -- DrawMarker color for dropping stolen vehicle off. Rgb selector can be found here: https://www.rapidtables.com/web/color/RGB_Color.html
----------
----------
Config.Currency = "bank" -- (money, bank, cash) what currency the player should get when breaking down parts and use to buy the garage

Config.PayForScrappingCarMin = 1500 -- Minimum amount a player can receive for fully scrapping a car (when they get in the car and hit E after removing all of the vehicles parts)
Config.PayForScrappingCarMax = 3000 -- Maximum amount a player can receive for fully scrapping a car (when they get in the car and hit E after removing all of the vehicles parts)
----------
----------
Config.ChancePoliceAraCalled = 50 -- % chance that the police are called (1-100)
Config.GaragePrice = 650000 -- price of garage (how much the owner of the garage pays to get one)
Config.BegginingPlayerCap = 1 -- The starting members capacity the garage starts with (DO NOT MAKE THIS LESS THEN 1)
Config.BegginingVehicleCap = 5 -- The vehicle cap that the garage starts out with (How many cars can be stored when you purchase the garage. players upgrade these over time)
Config.MembersUpgradePrice = 2500 -- Cost of upgrading members capacity (multiplied by current member capacity. example is if there is 4 players on the garage it will be 4*5500 = 22000)
Config.MaximumMembers = 10 -- How many members can be apart of one garage
Config.KickMemberPrice = 25000 -- Cost of kicking a member (to prevent members being constantly swapped out and abused)
----------
Config.VehicleCapUpgradePrice = 290 -- This is the base cost of upgrading how many vehicles can be stored in the garage it is multiplied by the garages current vehicle cap. (Config.VehicleCapUpgradePrice * CurrentGarage.vehiclecap)
Config.IncreaseVehicleAmount = 3 -- Amount of car slots you can upgrade at one time
----------
Config.CoolDown = 1 -- How long people must wait before starting chop breakdown of a car (in minutes)
----------
Config.VehicleRepairMultiplier = 5 -- whatever health is missing out of 1000 of a vehilce will cost $Config.VehicleRepairMultiplier * the number of damage of the vehicle
----------
Config.EnteringTheGarageKey = 38 -- [E] Keypress to enter the garage. Key press document for each key can be found here: https://docs.fivem.net/docs/game-references/controls/
Config.EnterTheGarageText = "[E] GARAGE" -- Text that displays for entering the garage
----------

-- Do not touch any of this unless
-- YOU REALLY KNOW WHAT YOU ARE DOING
Config.FrameworkFunctions = {
    -- Client-side trigger callback
    TriggerCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.TriggerCallback(...)
        else
            FWork.TriggerServerCallback(...)
        end
    end,

    -- Server-side register callback
    CreateCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.CreateCallback(...)
        else
            FWork.RegisterServerCallback(...)
        end
    end,

    -- Server-side Get All Players
    GetPlayers = function()
        if Framework == 'QBCore' then
            return FWork.Functions.GetPlayers()
        else
            return FWork.GetPlayers()
        end
    end,

    -- Client Notification Function
    Notify = function(msg, type, length)
        if Framework == 'QBCore' then
            return FWork.Functions.Notify(msg, type, length)
        else
            return FWork.ShowNotification(msg, type, length)
        end
    end,
    
    GetIdentifiers = function(source, idtype)
        return GetIdentifiers(source, idtype)
    end,

    GetItemByName = function(source, item, amount) 
        if Framework == 'QBCore' then 
            local player = FWork.Functions.GetPlayer(source)
            return player.Functions.GetItemByName(item, amount)
        else
            local player = FWork.GetPlayerFromId(source)
            return player.getInventoryItem(item, amount)
        end
    end,
    
    -- Server-side get player data
    GetPlayer = function(source,cid,client)
        if Framework == 'QBCore' then
            local self = {}
            local player = nil
            if cid then
                player = FWork.Functions.GetPlayerByCitizenId(source)
            elseif client then
                player = FWork.Functions.GetPlayerData()
            else
                player = FWork.Functions.GetPlayer(source)
            end

            if (player ~= nil) then
                self.source = source
                if client then
                    self.PlayerData = { charinfo = { firstname = player.charinfo.firstname, lastname = player.charinfo.lastname}, citizenid = player.citizenid, money = player.money, metadata = player.metadata }
                else
                    self.PlayerData = { charinfo = { firstname = player.PlayerData.charinfo.firstname, lastname = player.PlayerData.charinfo.lastname}, citizenid = player.PlayerData.citizenid, 
                    money = player.PlayerData.money, metadata = player.PlayerData.metadata, items = player.PlayerData.items, source =  player.PlayerData.source, job = {name = player.PlayerData.job.name, onduty = player.PlayerData.job.onduty}}
                end
                self.AddMoney = function(currency, amount) 
                    player.Functions.AddMoney(currency, amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.Functions.RemoveMoney(currency, amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.Functions.RemoveItem(item, amount, false)
                end

                self.AddItem = function(item, amount, info) 
                    player.Functions.AddItem(item, amount, false, info)
                end

                return self
            end
        else
            local self = {}
            local player = nil
            if cid then
                player = PugFindPlayersByItentifier(source)
                if player ~= nil then
                    self.PlayerData = {source = PugFindPlayersByItentifier(source, true), charinfo = { firstname = player.get('firstName'), lastname = player.get('lastName')}, citizenid = FWork.GetIdentifier(source) }
                    return self
                else
                    return nil
                end
            elseif client then
                player = FWork.GetPlayerData()
            else
                player = FWork.GetPlayerFromId(source)
            end

            if (player ~= nil) then
                self.source = source
                if client then
                    self.PlayerData = { money = {cash = PugGetPlayerMoneyCount()}}
                else
                    self.PlayerData = { charinfo = { firstname = player.get('firstName'), lastname = player.get('lastName')}, citizenid = FWork.GetIdentifier(source), 
                    money = {cash = player.getAccount('money').money, bank = player.getAccount('bank').money}, source = PugFindPlayersByItentifier(source), job = { name = player.job.name }}
                end
                self.AddMoney = function(currency, amount) 
                    player.addMoney(amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.removeMoney(amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.removeInventoryItem(item, amount)
                end

                self.AddItem = function(item, amount, info) 
                    player.addInventoryItem(item, amount, false, info)
                end

                return self
            end
        end

        return nil
    end,
}

-- How much chopping each car part pays (Config.Currency)
Config.VehiclePartsPay = {
    ["chop_wheel"] = {
        Min = 750, -- Minimum pay
        Max = 1200 -- Maximum pay
    },
    ["chop_door"] = {
        Min = 750, -- Minimum pay
        Max = 1200 -- Maximum pay
    },
    ["chop_hood"] = {
        Min = 750, -- Minimum pay
        Max = 1200 -- Maximum pay
    },
    ["chop_trunk"] = {
        Min = 750, -- Minimum pay
        Max = 1200 -- Maximum pay
    },
}

--
if Config.UseSharedVehicleCars and Framework == "QBCore" then
    Framework = "QBCore"
    local num = 0
    for _, _ in pairs(FWork.Shared.Vehicles) do
        num = num + 1
    end
    Config.VehicleList = num -- DONT TOUCH THIS
else
    Config.VehicleList = { -- Change these cars to your liking
        ["adder"] = {
            tracker = false
        },
        ["blista"] = {
            tracker = false
        },
        ["dilettante"] = {
            tracker = false
        },
        ["emperor"] = {
            tracker = false
        },
        ["faggio"] = {
            tracker = false
        },
        ["intruder"] = {
            tracker = false
        },
        ["manana"] = {
            tracker = false
        },
        ["peyote"] = {
            tracker = false
        },
        ["prairie"] = {
            tracker = false
        },
        ["premier"] = {
            tracker = false
        },
        ["sabre"] = {
            tracker = false
        },
        ["sultan"] = {
            tracker = false
        },
        ["surge"] = {
            tracker = false
        },
        ["tornado"] = {
            tracker = false
        },
        ["vigero"] = {
            tracker = false
        },
        ["washington"] = {
            tracker = false
        },
        ["banshee"] = {
            tracker = false
        },
        ["bullet"] = {
            tracker = false
        },
        ["carbonizzare"] = {
            tracker = false
        },
        ["comet2"] = {
            tracker = false
        },
        ["comet3"] = {
            tracker = false
        },
        ["coquette"] = {
            tracker = false
        },
        ["elegy"] = {
            tracker = false
        },
        ["feltzer2"] = {
            tracker = false
        },
        ["furoregt"] = {
            tracker = false
        },
        ["infernus"] = {
            tracker = false
        },
        ["jester"] = {
            tracker = false
        },
        ["kuruma"] = {
            tracker = false
        },
        ["massacro"] = {
            tracker = false
        },
        ["ninef"] = {
            tracker = false
        },
        ["ninef2"] = {
            tracker = false
        },
        ["osiris"] = {
            tracker = false
        },
        ["penetrator"] = {
            tracker = false
        },
        ["rapidgt"] = {
            tracker = false
        },
        ["rapidgt2"] = {
            tracker = false
        },
        ["schafter2"] = {
            tracker = false
        },
        ["sultan2"] = {
            tracker = false
        },
        ["sultan"] = {
            tracker = false
        },
        ["t20"] = {
            tracker = false
        },
        ["tempesta"] = {
            tracker = false
        },
        ["turismo2"] = {
            tracker = false
        },
        ["tyrus"] = {
            tracker = false
        },
        ["vacca"] = {
            tracker = false
        },
        ["verlierer2"] = {
            tracker = false
        },
        -- DLC Cars
        ["autarch"] = {
            tracker = false
        },
        ["banshee2"] = {
            tracker = false
        },
        ["cheetah2"] = {
            tracker = false
        },
        ["cyclone"] = {
            tracker = false
        },
        ["deveste"] = {
            tracker = false
        },
        ["emerus"] = {
            tracker = false
        },
        ["entity2"] = {
            tracker = false
        },
        ["entityxf"] = {
            tracker = false
        },
        ["fagaloa"] = {
            tracker = false
        },
        ["flashgt"] = {
            tracker = false
        },
        ["gauntlet5"] = {
            tracker = true
        },
        ["gp1"] = {
            tracker = false
        },
        ["infernus2"] = {
            tracker = false
        },
        ["italigtb"] = {
            tracker = false
        },
        ["italigtb2"] = {
            tracker = false
        },
        ["nero"] = {
            tracker = false
        },
        ["nero2"] = {
            tracker = false
        },
        ["paragon"] = {
            tracker = false
        },
        ["paragon2"] = {
            tracker = false
        },
        ["pariah"] = {
            tracker = false
        },
        ["penumbra2"] = {
            tracker = false
        },
    }
end
--

-- All Text used in the script (you can change any of the text you want)
Config.LangT = {
    -- Menu
    ["EmailHeader"] = "AD HAWK AUTOS",
    ["EmailSubject"] = "Located",
    ["EmailText"] = "The vehicle you need to collect is",
    ["WarehouseGarage"] = "Warehouse Garage",
    ["CiminalEnterPrizeGarage"] = "A criminal Enterprize garage",
    ["EnterGarage"] = "Enter Garage",
    ["EnterPassword"] = "Enter Password",
    ["LeaveGarage"] = "Leave Garage",
    ["PurchaceGarage"] = "Purchace Garage $",
    ["CurrentlyCooldown"] = "Currently on cooldown",
    ["DropOff"] = "Drop off ",
    ["Repair"] = "Repair ",
    ["ForMoney"] = " for $",
    ["CraftingBench"] = "Crafting Bench",
    ["GaragePrinter"] = "Garage Printer",
    ["RequiresMoneyNStuff"] = "Requires ? & $",
    ["Purchase"] = "Purchase ",
    ["CarsObtained"] = " Cars obtained",
    ["YouOwnThisGame"] = " You own this game",
    ["Play"] = "Play ",
    ["Back"] = "< back",
    ["Close"] = "[x] close",
    ["Vehicle:"] = "Vehicle: ",
    ["ManageAllVehicles"] = "Manage all vehicles",
    ["CarsActivelyStored"] = " cars actively stored",
    ["PickupACar"] = "Pickup A Car ",
    ["BodyHealth"] = "Body Health: ",
    ["RepairCost"] = "Repair Cost: ",
    ["Plate:"] = " Plate: ",
    ["WarehouseGarageHub"] = "Warehouse Garage Hub",
    ["VehiclesMenu"] = "Vehicles Menu",
    ["ManageWarehouse"] = "Manage Warehouse",
    ["ManageWeahouseFeatures:"] = "Manage All Weahouse Features",
    ["ChangePassword"] = "Change Password",
    ["ManageMembers"] = "Manage Members",
    ["UpgradeGarage"] = "Upgrade Garage",
    ["UpgradeVehicleSlots"] = "Upgrade Vehicle Slots ",
    ["MaxedOut"] = "(MAXED OUT)",
    ["KickMember"] = "Kick Member ($",
    ["UpgradeMemberSlots"] = "Upgrade Member Slots",
    ["AddAMember"] = "Add A Member",
    ["CurrentCapacity"] = "Current capacity ",
    ["+1For"] = "+1 for $",
    ["AreYouSureYouWantToRemove"] = "Are You Sure You Want ToRemove ",
    ["Yes"] = "Yes",
    ["No"] = "No",
    ["Upgrade"] = "Upgrade ",
    ["CarsInTheGarage"] = " Cars In The Garage",
    ["BreakDownParts"] = "🔧 Break Down Parts 🔧",
    ["BreakDownDoors"] = "Break Down Doors",
    ["BreakDownWheels"] = "Break Down Wheels",
    ["BreakDownHoods"] = "Break Down Hoods",
    ["BreakDownTrunks"] = "Break Down Trunks",
    ["PlayerId"] = "(PLAYERS ID)",
    ["PASSWORD"] = "(PASSWORD)",

    -- Target
    ["ViewLaptop"] = "View Laptop",

    -- Progress bar
    ["BreakDownHood"] = "Scrapping hood down...",
    ["BreakDownDoor"] = "Scrapping door down...",
    ["BreakDownTrunk"] = "Scrapping trunk down...",
    ["BreakDownWheel"] = "Scrapping wheel down...",

    -- Notifications
    ["Wait"] = "Couldnt find anything for you yet..",
    ["Wardrobe"] = "Checking out wardrobe...",
    ["Finished"] = "Finished!",
    ["3"] = "3...",
    ["2"] = "2..",
    ["1"] = "1.",
    ["AlreadyChoppingCarPart"]    = "You already chopping a car part.",
    ["EmailNotification"]    = "I will send an email with more Information.",
    ["StoringVehicle"] = "Storing vehicle...",
    ["WrongVehicle"] = "This Is not the Vehicle your looking for",
    ["LoseHeat"] = "Get rid of the heat first.",
    ["FinishFirst"] = "You need to finish this one first.",
    ["TrackerRemoved"] = "Success! You removed the tracker!",
    ["FoundVehicle"] = "This is is! You found the car!",
    ["Canceled"] = "Canceled..",
    ["StartedChop"] = "Finish this job first!",
    ["ShouldntBeHere"] = "You are not suppose to be in here...",
    ["NoID"] = "No ID entered",
    ["LeftVehicle"] = "You left the vehicle. It has been destroyed!",
    ["WheelBar"] = "Removing The Wheel...",
    ["HoodBar1"] = "Removing Screws",
    ["HoodBar2"] = "Removing Hood From vehicle",
	["DoorBar1"] = "Removing Screws",
	["DoorBar2"] = "Removing Door From vehicle",
    ["TrunkBar1"] = "Removing Screws",
    ["TrunkBar2"] = "Removing Trunk From vehicle",
	["Destroying"]  = "Destroying the vehicle for good!",
    ["SearchingTrunk"] = "Searching around the trunk",
    ["MaxMembers"] = "Your max members count is ",
    ["NoPassword"] = "No password entered",
    ["DropOff"] = "Sending drop off location to your GPS...",
    ["DoDropOff"] = "Drop Off ",
    ["SuccessFullUpgrade"] = "Successfully upgraded ",
    ["RemoveAll"]  = "~b~[E]~w~ Remove ",
    ["YouAreMissing"]  = "you are missing ",
    ["NotAurthorized"]  = "You dont have authorization here...",
    ["NowOwnCriminalEnterprize"]  = "You are now the owner of a Criminal Enterprize",
    ["ChangedPassword"]  = "succesfully changed password to ",
    ["MaxCapacity"]  = "You are at max capacity",
    ["AlreadyOwnGame"]  = "you already have this game...",
    ["AlreadyInAGarage"]  = "This person already has a garage",
    ["AlreadyAMember"]  = "This person is already a member",
    ["NotInCity"]  = "This person is not in city",
    ["MissingReputation"]  = "You are missing reputation",
    ["MissingItem"]  = "You are missing an item",
    ["AlreadyOwnUpgrade"]  = "you already have this upgrade...",
    ["WrongPassword"]  = "Wrong password",
    ["GarageMaxCapacity"]  = "This garage is at max capacity",
    ["VehicleTakenOut"]  = "This vehicle has just been taken out",
    ["SuccessfulRepair"]  = "Successfully Repaired",
    ["CarsObtained"]  = " Cars obtained",
    ["AmountOfCarsMissing"]  = " cars in your garage for this upgrade",
    ["YouNeedJobName"]  = "You do not have the required job to access this. You must be a "..Config.JobName,
    ["Success"]  = "Success!",
    ["Fail"]  = "Failed!",
    ["NeedKeysFirst"]  = "You Need Keys First!",
    -- Draw Text
    ["chop"] = "~b~[E]~w~ - Start Chopping",
	["remove"] = "~b~[E]~w~ - Remove the ",
	["destroy"] = "[E] Scrap Vehicle",
	["Trunk"] = "Trunk",				
	["Hood"] = "Hood",				
	["FrontDriverDoor"] = "door",	
	["BackDriverDoor"] = "door",		
	["PassengerFrontDoor"] = "door",	
	["PassengerBackDoor"] = "door",	
	["FrontDriverWheel"] = "wheel",	
	["BackDriverWheel"] = "wheel",	
	["PassengerFrontWheel"] = "wheel",	
	["PassengerBackWheel"] = "wheel",
    ["CantRemoveOwner"] = "You cannot remove the garage owner",		
}

-- Locations where you drop the vehicle off too. (it will choose one of these random coords)
Config.DeliveryCoords = {  -- Vehicle Delivery Cords where you will take the car to chop
    vector4(226.12, 107.29, 92.78, 355.6),
    vector4(1000.75, -1559.69, 30.06, 177.69),
    vector4(2052.06, 3191.46, 44.49, 334.38),
    vector4(1206.39, 2640.27, 37.12, 142.75),
    vector4(-1490.75, -203.42, 49.7, 220.14),
    vector4(1563.29, -2168.8, 76.82, 171.31),
    vector4(-468.43, -1675.82, 18.36, 357.4),
    vector4(-646.16, -1727.5, 23.79, 182.03),
}

-- Printer options
Config.PrinterOptions = {
    [0] = {
        Item = 'security_card_01', -- What you get from the printer
        Reqired = { -- Items required to print that item
            ["iron"] = 25, -- Item needed and amount needed ( you can add as many items as you like)
            ["metalscrap"] = 15, -- Item needed and amount needed ( you can add as many items as you like)
            ["rubber"] = 18, -- Item needed and amount needed ( you can add as many items as you like)
        },
        price = 500, -- cost of printing
    },
    [1] = {
        Item = 'bobcatkeycard', -- What you get from the printer
        Reqired = { -- Items required to print that item
            ["iron"] = 25, -- Item needed and amount needed ( you can add as many items as you like)
            ["metalscrap"] = 15, -- Item needed and amount needed ( you can add as many items as you like)
            ["rubber"] = 18, -- Item needed and amount needed ( you can add as many items as you like)
        },
        price = 250, -- cost of printing
    },
    -- You add add as many items as you want like this example here:

    -- [1] = {
    --     Item = 'security_card_02',
    --     Reqired = {
    --         ["plastic"] = 25, -- Item needed and amount needed ( you can add as many items as you like)
    --         ["rubber"] = 18, -- Item needed and amount needed ( you can add as many items as you like)
    --     },
    --     price = 1500,
    -- },
}

-- You can configure this to whatever games you want you would just need to make your own event. (These events can be edited at the bottom of client/open.lua)
Config.ArcadeGames = { -- Arcade games you can play
    [0] = {
        Game = 'Maze',
        GameEvent = 'Pug:client:MazeGame',
        price = 2500,
        CarsCount = 1,
    },
    [1] = {
        Game = 'Var',
        GameEvent = 'Pug:client:VarGame',
        price = 3500,
        CarsCount = 2,
    },
    [2] = {
        Game = 'Circle',
        GameEvent = 'Pug:client:CircleGame',
        price = 4500,
        CarsCount = 3,
    },
    [3] = {
        Game = 'Memory',
        GameEvent = 'Pug:client:ThermiteGame',
        price = 5500,
        CarsCount = 4,
    },
    [4] = {
        Game = 'Scrambler',
        GameEvent = 'Pug:client:ScramblerGame',
        price = 6500,
        CarsCount = 5,
    },
}

-- Garage upgrade options 
Config.UpgradesMenu = {
    [0] = {
        label = 'Clothing Change', -- preivew lable 
        itemupgrade = 'clothingchange', -- upgrade identifier name (very important)
        CamPos = vector3(959.53, -3005.18, -39.55), -- Camera position for previewing this upgrade
        CamRot = vector3(0.0, 0.0, 90.000000), -- Camera rotation for previewing this upgrade. Basically what direction the camera looks at.
        price = 2500, -- Hpw much the garage upgrade options 
        CarsCount = 1, -- how many cars in total obtained
        Carsowned = 1,-- how many cars in the garage right now
        AddUpgradeEvent = "Pug:client:AddClothesTarget", -- You need to make a new event like this if you want to make more upgrades. The event examples are all in open.lua
    },
    [1] = {
        label = 'Storage Locker',
        itemupgrade = 'storagelocker',
        CamPos = vector3(969.94, -2999.66, -39.20),
        CamRot = vector3(0.0, 0.0, 90.000000),
        price = 5000,
        CarsCount = 1,-- how many cars in total obtained
        Carsowned = 1,-- how many cars in the garage right now
        AddUpgradeEvent = "Pug:client:AddStorageTarget",
    },
    [2] = {
        label = 'Crafting Bench',
        itemupgrade = 'craftingbench',
        CamPos = vector3(967.51, -2992.84, -39.0),
        CamRot = vector3(-15.0, 0.0, 90.000000),
        price = 30000,
        CarsCount = 1,-- how many cars in total obtained
        Carsowned = 1,-- how many cars in the garage right now
        AddUpgradeEvent = "Pug:client:AddCraftingBenchTarget",
    },
    [3] = {
        label = 'Welding Bench',
        itemupgrade = 'weldingbench',
        CamPos = vector3(995.72, -2989.5, -39.20),
        CamRot = vector3(0.0, 0.0, 0.000000),
        price = 12000,
        CarsCount = 1,-- how many cars in total obtained
        Carsowned = 1,-- how many cars in the garage right now
        AddUpgradeEvent = "Pug:client:AddWeldingBench",
    },
    [4] = {
        label = 'Arcade Mechine',
        itemupgrade = 'arcademechine',
        CamPos = vector3(960.02, -3001.11, -39.64),
        CamRot = vector3(0.0, 0.0, 0.000000),
        price = 15000,
        CarsCount = 1,-- how many cars in total obtained
        Carsowned = 1,-- how many cars in the garage right now
        AddUpgradeEvent = "Pug:client:AddArcadeMechine",
    },
    [5] = {
        label = 'Printer Machine',
        itemupgrade = 'printermachine',
        CamPos = vector3(965.29, -3003.42, -39.25),
        CamRot = vector3(-15.0, 0.0, -90.000000),
        price = 15000,
        CarsCount = 1,-- how many cars in total obtained
        Carsowned = 1,-- how many cars in the garage right now
        AddUpgradeEvent = "Pug:client:AddPrinterMachine",
    },
    -- This was made durring testing but since everyone is in the same instance this scuffs out but still works if only one garage at a time is using it.
    -- [4] = {
    --     label = 'Black Jack Table',
    --     itemupgrade = 'blackjacktable',
    --     CamPos = vector3(969.22, -3022.43, -39.25),
    --     CamRot = vector3(-15.0, 0.0, 90.000000),
    --     price = 1,
    --     CarsCount = 0,
    --     AddUpgradeEvent = "Pug:client:AddBlackJack",
    -- },
    -- [5] = {
    --     label = 'Pool Table',
    --     itemupgrade = 'pooltable',
    --     CamPos = vector3(962.06, -3027.41, -39.25),
    --     CamRot = vector3(-15.0, 0.0, 15.000000),
    --     price = 1,
    --     CarsCount = 0,
    --     AddUpgradeEvent = "Pug:client:AddPoolTable",
    -- },
    -- [6] = {
    --     label = 'Roulette Table',
    --     itemupgrade = 'roulettetable',
    --     CamPos = vector3(968.39, -3025.19, -39.25),
    --     CamRot = vector3(-15.0, 0.0, 90.000000),
    --     price = 1,
    --     CarsCount = 0,
    --     AddUpgradeEvent = "Pug:client:AddRouleteTable",
    -- },
}

-- Items you get when chopping a wheel.
-- when breaking down each of these parts it picks 1 to however many options you have here to 
-- choose to give to the player and then it chooses to give between amountmin and amountmax to the player
Config.VehicleParts = {
    ["chop_wheel"] = { -- When you break down a wheel
        [1] = { -- you either get this
            ["item"] = "aluminum", -- item recieved
            ["amountmin"] = 250, -- minimum aluminum
            ["amountmax"] = 500, -- maximum aluminum
        },
        [2] = { -- or this
            ["item"] = "plastic", -- item recieved
            ["amountmin"] = 250, -- minimum plastic
            ["amountmax"] = 500, -- maximum plastic
        },
        [3] = { -- or this
            ["item"] = "rubber", -- item recieved
            ["amountmin"] = 250, -- minimum rubber
            ["amountmax"] = 500, -- maximum rubber
        },
    },
    ["chop_door"] = { -- When you break down a door
        [1] = {
            ["item"] = "steel",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [2] = {
            ["item"] = "plastic",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [3] = {
            ["item"] = "metalscrap",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [4] = {
            ["item"] = "iron",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [5] = {
            ["item"] = "aluminum",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
    },
    ["chop_hood"] = {
        [1] = {
            ["item"] = "steel",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [2] = {
            ["item"] = "plastic",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [3] = {
            ["item"] = "metalscrap",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [4] = {
            ["item"] = "iron",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [5] = {
            ["item"] = "aluminum",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
    },
    ["chop_trunk"] = {
        [1] = {
            ["item"] = "lockpick",
            ["amountmin"] = 1,
            ["amountmax"] = 2,
        },
        [2] = {
            ["item"] = "steel",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [3] = {
            ["item"] = "plastic",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [4] = {
            ["item"] = "metalscrap",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [5] = {
            ["item"] = "iron",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [6] = {
            ["item"] = "aluminum",
            ["amountmin"] = 250,
            ["amountmax"] = 500,
        },
        [7] = {
            ["item"] = "bandsofnotes",
            ["amountmin"] = 5,
            ["amountmax"] = 10,
        },
    },
}


-- Crafting bench menu values
Config.CraftingItems = {
    ["harness"] = { -- Item to craft
        materials = {
            ["steel"] = 42, -- Item needed and amount needed ( you can add as many items as you like)
            ["plastic"] = 37, -- Item needed and amount needed ( you can add as many items as you like)
            ["rubber"] = 36, -- Item needed and amount needed ( you can add as many items as you like)
        }
    },

    -- You add add as many items as you want like these examples here:

    -- ["hotwirekit"] = { -- Item to craft
    --     materials = {
    --         ["iron"] = 25, -- Item needed and amount needed ( you can add as many items as you like)
    --         ["metalscrap"] = 15, -- Item needed and amount needed ( you can add as many items as you like)
    --         ["rubber"] = 18, -- Item needed and amount needed ( you can add as many items as you like)
    --     }
    -- },
    -- ["fake_plate"] = {
    --     materials = {
    --         ["plastic"] = 12,
    --         ["metalscrap"] = 145,
    --         ["rubber"] = 5,
    --         ["aluminum"] = 55,
    --     }
    -- },
    -- ["racing_usb"] = {
    --     materials = {
    --         ["copper"] = 5,
    --         ["plastic"] = 12,
    --         ["rubber"] = 7,
    --         ["aluminum"] = 5,
    --     },
    --     price = 2500,
    -- },
    -- ["nos"] = {
    --     materials = {
    --         ["copper"] = 45,
    --         ["plastic"] = 52,
    --         ["rubber"] = 47,
    --         ["aluminum"] = 35,
    --         ["steel"] = 72,
    --     },
    --     price = 25000,
    -- },
    -- ["racing_usbmaster"] = {
    --     materials = {
    --         ["copper"] = 35,
    --         ["plastic"] = 52,
    --         ["rubber"] = 47,
    --         ["aluminum"] = 35,
    --     },
    --     price = 15000,
    -- },
    -- ["ausb2"] = {
    --     materials = {
    --         ["copper"] = 5,
    --         ["plastic"] = 12,
    --         ["rubber"] = 7,
    --         ["aluminum"] = 5,
    --     },
    --     price = 3000,
    -- },
    -- ["boostinglaptop"] = {
    --     materials = {
    --         ["copper"] = 20,
    --         ["plastic"] = 15,
    --         ["rubber"] = 5,
    --         ["aluminum"] = 25,
    --     },
    --     price = 15000,
    -- },
}

-- Different zone locations where you can enter a garage from. (this is too keep players not all piled up at one garage)
Config.GarageZones = {
    ["1"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the garage area
                vector2(-798.59539794922, 352.69418334961),
                vector2(-806.98504638672, 352.6926574707),
                vector2(-807.11938476563, 357.11404418945),
                vector2(-798.92596435547, 356.9367980957)
            },
            ['minZ'] = 85.867988586426,  -- min height of the garage area
            ['maxZ'] = 88.875709533691,  -- max height of the garage area
            ['location'] = vector4(-778.35, 355.98, 87.86, 4.8), -- Side Garage where you drop off cars and take cars from

            ['cameracoords'] = vector3(-803.02, 353.54, 87.87), -- get as close to the garage for this vector
            ['setplayercoords'] = vector4(-803.32, 357.18, 87.87, 181.15), -- Face towards garage for this vector. if Config.DoCameraEffect is false then this does not matter.
        },
    },
    ["2"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the garage area
                vector2(-1370.8363037109, -333.72216796875),
                vector2(-1374.4760742188, -335.35507202148),
                vector2(-1376.5892333984, -331.63946533203),
                vector2(-1373.0814208984, -329.97491455078)
            },
            ['minZ'] = 34.926025390625,  -- min height of the garage area
            ['maxZ'] = 39.248031616211,  -- max height of the garage area
            ['location'] = vector4(-1390.6, -338.46, 39.71, 114.0), -- Side Garage where you drop off cars and take cars from

            ['cameracoords'] = vector3(-1372.45, -334.72, 38.93), -- get as close to the garage for this vector
            ['setplayercoords'] = vector4(-1374.62, -331.23, 39.18, 204.63), -- Face towards garage for this vector. if Config.DoCameraEffect is false then this does not matter.
        },
    },
    ["3"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the garage area
                vector2(-238.58103942871, -231.5458984375),
                vector2(-238.58097839355, -236.46220397949),
                vector2(-242.35015869141, -236.58027648926),
                vector2(-242.56657409668, -231.57754516602)
            },
            ['minZ'] = 33.519077301025,  -- min height of the garage area
            ['maxZ'] = 39.519077301025,  -- max height of the garage area
            ['location'] = vector4(-241.95, -224.25, 36.52, 92.76),-- Side Garage where you drop off cars and take cars from

            ['cameracoords'] = vector3(-238.56, -234.46, 36.52),-- get as close to the garage for this vector
            ['setplayercoords'] = vector4(-242.45, -234.16, 36.52, 267.52), -- Face towards garage for this vector. if Config.DoCameraEffect is false then this does not matter.
        },
    },
    ["4"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the garage area
                vector2(150.04570007324, -117.53902435303),
                vector2(155.82246398926, -119.75988006592),
                vector2(154.29931640625, -123.71705627441),
                vector2(148.31596374512, -122.58327484131)
            },
            ['minZ'] = 52.825523376465,  -- min height of the garage area
            ['maxZ'] = 57.826675415039,  -- max height of the garage area
            ['location'] = vector4(125.66, -116.54, 54.84, 163.32),-- Side Garage where you drop off cars and take cars from

            ['cameracoords'] = vector3(152.98, -118.61, 54.83),-- get as close to the garage for this vector
            ['setplayercoords'] = vector4(151.89, -122.49, 54.83, 341.11), -- Face towards garage for this vector. if Config.DoCameraEffect is false then this does not matter.
        },
    },
    ["5"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the garage area
                vector2(-1597.1104736328, -454.46450805664),
                vector2(-1593.0639648438, -457.93371582031),
                vector2(-1595.8387451172, -461.17141723633),
                vector2(-1600.0280761719, -458.39398193359)
            },
            ['minZ'] = 34.179935455322,  -- min height of the garage area
            ['maxZ'] = 38.425037384033,  -- max height of the garage area
            ['location'] = vector4(-1608.3, -450.81, 38.15, 141.31),-- Side Garage where you drop off cars and take cars from

            ['cameracoords'] = vector3(-1595.06, -456.17, 37.23),-- get as close to the garage for this vector
            ['setplayercoords'] = vector4(-1598.93, -461.02, 37.31, 319.25), -- Face towards garage for this vector. if Config.DoCameraEffect is false then this does not matter.
        },
    },
}

-- This is a zone inside the garage to hit E to leave (only accessible when in a vehicle)
Config.InsideZone = {
    ["0"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the garage area
                vector2(967.89105224609, -2987.2678222656),
                vector2(974.31927490234, -2987.1884765625),
                vector2(974.20343017578, -2991.3366699219),
                vector2(967.81475830078, -2991.8461914063)
            },
            ['minZ'] = -41.647006988525,  -- min height of the garage area
            ['maxZ'] = -37.646945953369  -- max height of the garage area
        },
    },
}


-- Spawns of the vehicles inside of the garage (wouldnt touch this unless you fully understand it)
Config.CarSpawnLocations = {
    vector4(978.15, -2993.91, -40.34, 179.37),
    vector4(985.26, -2995.46, -40.34, 202.44),
    vector4(991.62, -2992.49, -40.34, 162.17),
    vector4(998.51, -2992.61, -40.34, 131.37),
    vector4(999.3, -2997.89, -40.34, 87.53),
    vector4(991.42, -3000.82, -40.34, 89.36),
    vector4(1002.19, -3005.82, -40.34, 90.19),
    vector4(1005.01, -3010.37, -40.34, 94.07),
    vector4(1002.72, -3014.76, -40.34, 100.78),
    vector4(1009.48, -3026.34, -40.34, 356.32),
    vector4(1009.12, -3027.06, -37.59, 180.72),
    vector4(1004.09, -3026.95, -40.35, 359.49),
    vector4(1004.04, -3027.48, -37.58, 359.63),
    vector4(998.38, -3026.32, -40.34, 177.4),
    vector4(998.47, -3027.27, -37.58, 0.08),
    vector4(993.46, -3026.14, -40.35, 352.96),
    vector4(993.11, -3027.33, -37.59, 1.59),
    vector4(989.75, -3015.43, -40.34, 276.16),
    vector4(984.92, -3009.17, -40.34, 269.43),
    vector4(978.31, -3009.84, -40.34, 0.21),
    vector4(977.63, -3017.28, -40.34, 32.75),
    vector4(955.07, -3018.41, -40.34, 270.85),
    vector4(955.15, -3018.56, -37.59, 270.29),
    vector4(955.35, -3023.58, -40.35, 89.65),
    vector4(955.21, -3023.78, -37.59, 270.37),
    vector4(955.64, -3028.7, -40.34, 269.44),
    vector4(954.84, -3028.79, -37.58, 270.4),
    vector4(956.51, -3032.81, -40.35, 310.98),
    vector4(959.51, -3035.61, -40.34, 357.69),
    vector4(959.27, -3035.58, -37.58, 180.24),
    vector4(963.41, -3034.92, -40.34, 354.9),
    vector4(963.56, -3035.91, -37.59, 1.1),
    vector4(967.8, -3034.85, -40.34, 354.7),
    vector4(967.92, -3036.06, -37.58, 0.01),
    vector4(971.67, -3034.58, -40.35, 358.03),
    vector4(971.83, -3035.69, -37.58, 359.13),
    vector4(975.2, -3031.32, -40.34, 252.8),
    vector4(976.08, -3036.1, -40.35, 359.29),
    vector4(976.23, -3035.72, -37.59, 358.3),
    vector4(961.66, -3029.75, -40.35, 318.36),
}

-- 380+ Random vehicle spawns
Config.VehicleCoords = { -- Locations of where the vehicle can spawn **Chosen from random every time you start a new job**
    -- South Side
    vector4(166.65, -1928.96, 21.01, 232.07),
    vector4(308.24, -2025.55, 20.4, 320.9),
    vector4(412.46, -2066.09, 20.77, 139.58),
    vector4(550.0, -1929.69, 24.81, 300.71),
    vector4(433.68, -1839.67, 28.05, 227.06),
    vector4(380.24, -1818.31, 29.14, 49.64),
    vector4(275.58, -1935.4, 24.49, 231.29),
    vector4(88.29, -1969.12, 20.05, 320.62),
    vector4(113.03, -1917.69, 20.24, 151.85),
    vector4(41.6, -1921.2, 20.96, 321.46),
    vector4(-60.17, -1842.99, 25.88, 320.67),
    vector4(-89.76, -2009.23, 17.32, 172.86),
    vector4(-57.28, -2107.14, 16.0, 20.54),
    vector4(-151.04, -2209.59, 7.11, 178.62),
    vector4(91.13, -2221.7, 5.34, 0.38),
    vector4(321.45, -2091.01, 16.98, 118.65),
    vector4(495.6, -1968.78, 24.21, 124.94),
    vector4(555.56, -1796.83, 28.5, 351.61),
    vector4(530.67, -1755.14, 28.29, 150.3),
    vector4(458.6, -1696.55, 28.58, 320.15),
    vector4(401.34, -1648.04, 28.59, 320.67),
    vector4(225.18, -1707.86, 28.59, 215.08),
    vector4(194.54, -1698.73, 28.71, 329.05),
    vector4(201.43, -1854.27, 26.5, 138.65),
    vector4(80.33, -2528.78, 5.3, 210.59),
    vector4(116.15, -2579.93, 5.31, 180.21),
    vector4(-199.78, -1714.26, 31.97, 137.05),
    vector4(-20.64, -1677.58, 28.79, 98.98),
    vector4(-27.77, -1495.7, 29.66, 134.59),
    vector4(-257.33, -1546.37, 31.0, 230.46),
    vector4(-34.39, -1427.29, 30.76, 88.66),
    vector4(66.13, -1431.5, 28.61, 139.69),
    vector4(162.21, -1508.51, 28.44, 316.26),
    vector4(234.88, -1510.12, 28.45, 43.62),
    vector4(671.39, -1435.07, 9.03, 14.72),
    vector4(328.51, -1471.78, 29.06, 49.81),
    vector4(32.11, -1580.74, 28.53, 229.56),
    vector4(-218.71, -1635.44, 32.91, 90.84),
    vector4(-352.45, -1493.82, 29.6, 271.19),
    vector4(-182.47, -1260.49, 30.6, 269.26),
    -- End of south side
    -- Beach Side
    vector4(-1067.77, -1413.89, 4.68, 255.72),
    vector4(-966.8, -1478.01, 4.32, 109.37),
    vector4(-1012.36, -1642.48, 3.66, 231.44),
    vector4(-1042.17, -1594.91, 4.05, 303.21),
    vector4(-1094.13, -1502.74, 4.07, 124.49),
    vector4(-1195.2, -1496.07, 3.68, 125.0),
    vector4(-1171.2, -1739.75, 3.36, 215.9),
    vector4(-1133.1, -1449.0, 4.32, 39.47),
    vector4(-1178.93, -1396.47, 3.98, 303.93),
    vector4(-1204.92, -1331.65, 4.14, 199.75),
    vector4(-1295.13, -1313.84, 3.97, 358.65),
    vector4(-1156.99, -1226.11, 6.03, 201.01),
    vector4(-1074.23, -1245.2, 4.71, 119.0),
    vector4(-1039.3, -1232.92, 5.15, 211.44),
    vector4(-1126.21, -1213.57, 1.74, 29.23),
    vector4(-1161.95, -1164.47, 4.93, 104.39),
    vector4(-1261.53, -1236.04, 4.53, 107.99),
    vector4(-1144.31, -1064.79, 1.45, 210.1),
    vector4(-1091.15, -1055.19, 1.45, 30.07),
    vector4(-866.87, -1123.48, 6.37, 120.77),
    vector4(-822.05, -1197.36, 6.13, 140.39),
    vector4(-915.22, -1161.19, 4.11, 209.26),
    vector4(-827.75, -1064.26, 10.9, 298.69),
    vector4(-763.16, -1022.92, 12.45, 297.49),
    vector4(-829.64, -760.67, 21.33, 91.19),
    vector4(-786.7, -809.53, 19.94, 1.66),
    vector4(-1008.26, -785.34, 15.67, 242.29),
    vector4(-1328.71, -926.01, 10.5, 110.26),
    vector4(-1418.67, -958.65, 6.54, 239.23),
    vector4(-1632.85, -944.58, 7.56, 141.06),
    vector4(-1708.9, -899.41, 7.12, 319.74),
    vector4(-1661.65, -843.84, 8.72, 318.47),
    vector4(-1740.54, -722.0, 9.76, 50.83),
    vector4(-1855.78, -623.49, 10.48, 51.15),
    vector4(-2010.51, -484.35, 10.7, 321.24),
    vector4(-2160.17, -393.0, 12.65, 79.7),
    -- Upper beach side
    vector4(-2175.91, -421.5, 12.53, 186.26),
    vector4(-2095.32, -295.06, 12.35, 82.5),
    vector4(-2064.88, -302.74, 12.45, 175.09),
    vector4(-1810.34, -344.47, 48.43, 50.55),
    vector4(-1802.27, -404.99, 44.05, 143.61),
    vector4(-1686.42, -452.34, 39.9, 231.08),
    vector4(-1577.18, -372.05, 44.68, 265.79),
    vector4(-1566.89, -423.71, 37.18, 49.8),
    vector4(-1475.76, -509.11, 32.11, 214.15),
    vector4(-1520.16, -549.39, 32.48, 215.27),
    vector4(-1515.99, -711.72, 26.84, 0.03),
    vector4(-1408.89, -636.95, 27.97, 33.52),
    vector4(-1442.42, -684.34, 25.61, 213.57),
    vector4(-1268.52, -645.96, 26.2, 127.89),
    vector4(-1228.1, -698.33, 22.38, 306.68),
    vector4(-1136.75, -746.61, 19.04, 285.26),
    vector4(-1022.32, -510.42, 35.94, 294.67),
    vector4(-1085.08, -476.62, 35.92, 28.27),
    vector4(-1087.04, -547.99, 34.39, 25.28),
    vector4(-1113.26, -576.57, 31.13, 298.48),
    vector4(-1247.05, -527.33, 29.48, 219.65),
    vector4(-1274.52, -608.44, 25.79, 220.22),
    vector4(-726.68, -412.13, 34.34, 266.12),
    vector4(-733.66, -282.28, 36.25, 82.65),
    vector4(-579.62, -246.47, 35.16, 28.48),
    vector4(-668.18, -172.1, 36.98, 119.36),
    vector4(-470.38, -57.08, 43.82, 266.37),
    vector4(-551.38, -143.75, 37.5, 57.76),
    -- Lower vinewood
    vector4(-833.07, -36.01, 38.0, 303.3),
    vector4(-890.93, -2.79, 42.74, 209.74),
    vector4(-917.68, 9.95, 47.02, 315.82),
    vector4(-918.78, 105.41, 54.62, 26.37),
    vector4(-790.64, 40.12, 47.72, 249.31),
    vector4(-961.15, 110.24, 55.65, 312.02),
    vector4(-989.15, 144.61, 59.93, 260.81),
    vector4(-951.72, 187.26, 65.89, 79.83),
    vector4(-910.13, 189.5, 68.75, 176.43),
    vector4(-1047.81, 219.36, 63.07, 182.81),
    vector4(-827.7, 175.98, 70.19, 155.37),
    vector4(-835.58, 113.63, 54.55, 171.84),
    vector4(-1130.55, 303.5, 65.53, 172.51),
    vector4(-1061.66, 304.63, 65.28, 350.33),
    vector4(-1014.04, 359.18, 70.0, 159.52),
    vector4(-1376.98, -24.2, 52.61, 175.33),
    vector4(-1390.98, 59.1, 52.9, 306.78),
    vector4(-1433.41, -250.26, 45.67, 133.71),
    vector4(-1575.21, -84.74, 53.44, 273.97),
    vector4(-1580.15, -60.1, 55.79, 271.2),
    vector4(-1524.82, 31.6, 55.87, 260.33),
    vector4(-1557.29, 21.91, 57.97, 167.57),
    vector4(-1613.38, 20.4, 61.48, 334.57),
    vector4(-1685.52, 48.5, 63.35, 162.75),
    vector4(-1660.5, 75.76, 62.69, 349.33),
    -- vector4(-1556.44, 113.48, 56.08, 233.03),--inside playboy mansion (player owned mlo)
    vector4(-1887.36, 122.84, 81.0, 308.55),
    vector4(-1934.5, 183.94, 83.87, 310.06),
    -- North rockfard
    vector4(-1954.9, 213.03, 85.39, 206.06),
    vector4(-1880.71, 189.12, 83.18, 125.59),
    vector4(-1908.28, 248.4, 85.55, 31.0),
    vector4(-1974.76, 260.3, 86.52, 287.14),
    vector4(-1924.4, 283.92, 88.37, 9.51),
    vector4(-2001.25, 368.13, 93.78, 180.29),
    vector4(-1937.92, 359.58, 92.86, 158.99),
    vector4(-1915.64, 405.56, 95.6, 96.85),
    vector4(-1954.17, 449.23, 100.37, 187.99),
    vector4(-2003.71, 455.03, 101.87, 277.97),
    vector4(-2007.5, 483.47, 105.77, 256.03),
    vector4(-1987.46, 604.28, 117.29, 74.98),
    vector4(-1942.44, 582.89, 118.18, 249.98),
    vector4(-1889.39, 625.5, 129.3, 314.54),
    vector4(-1816.2, 786.87, 137.13, 39.4),
    vector4(-2580.16, 1929.75, 166.66, 248.05),
    vector4(-2776.3, 1428.95, 100.23, 140.82),
    vector4(-1797.48, 398.27, 112.09, 100.84),
    vector4(-1857.96, 328.77, 87.95, 7.89),
    vector4(-1793.81, 349.22, 87.86, 245.42),
    vector4(-1751.13, 365.2, 88.99, 116.89),
    vector4(-1667.6, 392.13, 88.44, 198.07),
    -- Vinewood
    vector4(-1547.38, 428.17, 108.65, 272.12),
    vector4(-1507.59, 428.0, 110.39, 41.65),
    vector4(-1483.11, 528.94, 117.53, 214.93),
    vector4(-1471.57, 513.56, 117.12, 194.88),
    vector4(-1416.4, 536.88, 121.07, 288.31),
    vector4(-1346.74, 609.64, 133.15, 101.17),
    vector4(-1283.34, 647.55, 138.85, 196.78),
    vector4(-1248.83, 663.74, 141.94, 255.31),
    vector4(-1120.48, 787.54, 162.17, 36.74),
    vector4(-1117.02, 769.46, 162.53, 24.78),
    vector4(-1051.97, 769.26, 166.85, 96.68),
    vector4(-1057.9, 736.92, 164.75, 121.85),
    vector4(-1022.74, 694.13, 160.6, 179.06),
    vector4(-810.98, 705.26, 146.4, 203.07),
    vector4(-763.66, 667.63, 143.3, 117.53),
    vector4(-753.14, 628.9, 141.83, 196.35),
    vector4(-671.62, 645.57, 148.5, 265.16),
    vector4(-668.09, 669.96, 149.73, 249.34),
    vector4(-710.13, 655.95, 154.48, 164.42),
    vector4(-670.57, 753.86, 173.4, 184.55),
    vector4(-581.06, 738.96, 182.88, 232.77),
    vector4(-592.01, 752.99, 183.02, 75.4),
    vector4(-596.31, 805.5, 190.14, 333.01),
    vector4(-661.71, 808.74, 198.84, 182.84),
    vector4(-905.2, 783.66, 185.26, 189.95),
    vector4(-918.28, 803.39, 183.59, 8.7),
    vector4(-955.98, 800.61, 177.2, 8.73),
    vector4(-994.08, 811.05, 171.87, 6.59),
    vector4(-970.01, 766.74, 174.47, 225.71),
    vector4(-1021.84, 811.83, 171.37, 18.99),
    vector4(-148.55, 917.96, 234.96, 227.87),
    vector4(-107.18, 836.8, 234.98, 2.29),
    vector4(-69.22, 897.4, 234.82, 292.72),
    vector4(199.44, 1228.55, 224.76, 103.86),
    vector4(174.32, 484.89, 141.75, 176.23),
    vector4(-77.01, 496.99, 143.72, 353.47),
    vector4(-245.2, 494.46, 125.0, 203.45),
    vector4(-360.77, 513.75, 118.88, 315.12),
    vector4(-410.58, 555.0, 123.06, 333.38),
    vector4(-205.51, 301.4, 96.25, 179.28),
    vector4(-250.51, 292.79, 91.12, 268.1),
    vector4(-209.12, 280.63, 91.62, 162.06),
    vector4(-209.34, 315.08, 96.25, 358.15),
    vector4(-39.71, 211.7, 105.86, 344.79),
    vector4(-35.64, 196.94, 101.28, 161.58),
    -- East cost upper city
    vector4(88.28, 183.96, 103.93, 339.01),
    vector4(57.83, 19.1, 68.68, 338.99),
    vector4(165.17, 29.36, 72.36, 247.43),
    vector4(281.74, 79.51, 99.19, 339.86),
    vector4(254.68, -13.87, 72.96, 249.59),
    vector4(479.59, -43.89, 88.16, 58.82),
    vector4(235.02, -33.19, 69.02, 339.07),
    vector4(109.02, -133.94, 54.05, 247.72),
    vector4(99.63, -206.07, 53.79, 249.67),
    vector4(283.15, -323.8, 44.22, 69.64),
    vector4(385.0, -331.9, 46.16, 246.94),
    vector4(496.55, -90.09, 65.72, 251.54),
    vector4(463.39, 227.07, 102.49, 249.85),
    vector4(428.37, 255.95, 102.51, 69.94),
    vector4(604.83, 121.86, 92.2, 69.09),
    vector4(870.02, -36.24, 78.07, 238.78),
    vector4(944.66, -256.75, 66.75, 325.71),
    vector4(941.25, -248.49, 67.89, 326.21),
    vector4(1257.57, -336.97, 68.38, 353.36),
    vector4(1269.55, -373.27, 68.32, 232.8),
    vector4(1360.49, -601.39, 73.64, 356.86),
    vector4(1360.49, -601.39, 73.64, 356.86),
    vector4(915.22, -625.93, 57.35, 300.71),
    vector4(852.62, -565.14, 57.0, 279.53),
    vector4(943.51, -471.1, 60.56, 212.45),
    vector4(1018.14, -773.63, 57.2, 130.94),
    vector4(852.58, -906.07, 24.59, 90.21),
    vector4(900.19, -1067.61, 32.13, 179.18),
    vector4(907.47, -1733.38, 29.89, 356.03),
    vector4(974.63, -1823.92, 30.44, 353.43),
    vector4(1005.41, -1868.81, 30.19, 354.83),
    vector4(1394.71, -1532.94, 56.81, 222.72),
    vector4(-463.3, 641.89, 143.49, 42.66),
    vector4(-223.54, 594.15, 189.7, 341.21),
    vector4(215.8, 758.12, 203.96, 47.59),
    vector4(-129.09, 1003.08, 235.03, 197.71),
    vector4(-2289.38, 412.66, 173.77, 325.34),
    vector4(-2338.34, 290.52, 168.77, 295.29),
    -- Great ocean highway
    vector4(-3052.28, 146.73, 10.86, 266.12),
    vector4(-2997.18, 92.61, 10.91, 316.42),
    vector4(-3082.99, 223.32, 13.31, 325.15),
    vector4(-3098.78, 243.34, 11.68, 293.08),
    vector4(-3102.41, 281.06, 8.49, 269.91),
    vector4(-3096.62, 306.5, 7.61, 255.39),
    vector4(-3091.66, 317.04, 6.89, 257.42),
    vector4(-3087.44, 340.6, 6.68, 254.87),
    vector4(-3080.1, 366.81, 6.41, 256.44),
    vector4(-3072.37, 395.35, 6.27, 252.52),
    vector4(-3055.9, 440.05, 5.66, 245.11),
    vector4(-3038.91, 474.18, 6.03, 252.6),
    vector4(-3031.1, 496.89, 6.11, 256.27),
    vector4(-3030.01, 556.15, 6.81, 276.59),
    vector4(-3052.61, 603.06, 6.58, 292.68),
    vector4(-2943.86, 477.18, 14.55, 357.73),
    vector4(-2956.85, 417.68, 14.57, 77.81),
    vector4(-2968.46, 358.6, 14.07, 33.17),
    vector4(736.8, 1296.14, 359.6, 238.6),
    vector4(306.98, 707.74, 173.78, 350.87),
    vector4(1447.43, -2598.28, 47.61, 164.66),
    vector4(1226.8, -2442.45, 43.78, 304.01),
    vector4(1767.09, -1656.41, 111.97, 61.02),
    vector4(1736.21, -1537.27, 112.0, 65.42),
    vector4(1568.49, -1679.52, 87.46, 17.36),
    vector4(1700.94, -1498.59, 112.28, 245.94),
    vector4(2549.66, -371.39, 92.29, 350.69),
    vector4(2512.97, -293.23, 92.29, 162.37),
    vector4(2540.77, -390.05, 92.3, 10.65),
    vector4(2588.46, 447.05, 107.76, 269.68),
    vector4(2728.6, 1369.07, 23.83, 358.97),
    vector4(2793.28, 1408.42, 23.74, 86.29),
    vector4(2673.72, 1708.28, 23.79, 90.07),
    vector4(2491.91, 1583.11, 32.02, 0.51),
    --harmony/sandyshores
    vector4(311.35, 2832.39, 42.6, 341.04),
    vector4(1186.34, 2727.81, 37.17, 268.44),
    vector4(774.26, 2560.04, 74.86, 224.03),
    vector4(169.53, 2282.45, 92.14, 265.27),
    vector4(-116.0, 2804.83, 52.18, 249.85),
    vector4(526.89, 3113.5, 39.71, 54.46),
    vector4(580.7, 2913.41, 39.19, 155.88),
    vector4(565.95, 2808.37, 41.29, 273.21),
    vector4(580.08, 2656.26, 41.05, 269.9),
    vector4(726.2, 2777.31, 65.86, 3.59),
    vector4(1006.94, 3023.9, 40.53, 23.53),
    vector4(1089.65, 3128.03, 38.14, 296.04),
    vector4(1753.97, 3321.08, 40.39, 219.54),
    vector4(1754.42, 3040.78, 61.42, 278.69),
    vector4(1595.62, 2898.71, 56.19, 158.63),
    vector4(1986.81, 3039.88, 46.22, 57.08),
    vector4(1434.2, 2790.71, 51.53, 347.37),
    vector4(2063.31, 3439.13, 43.1, 94.07),
    vector4(2396.57, 3359.98, 45.88, 223.1),
    vector4(1856.72, 3776.1, 32.18, 301.45),
    vector4(1714.99, 3848.56, 34.04, 38.26),
    vector4(1532.44, 3914.43, 30.8, 251.68),
    vector4(1704.35, 3702.0, 33.48, 293.36),
    vector4(1430.85, 3643.39, 33.76, 110.71),
    vector4(1448.28, 3761.84, 30.89, 291.22),
    vector4(1358.46, 3617.96, 34.05, 109.95),
    vector4(1520.98, 3594.84, 34.39, 299.76),
    vector4(1574.51, 3588.44, 34.52, 297.24),
    vector4(1622.63, 3588.74, 34.3, 207.65),
    vector4(2035.83, 3900.07, 31.01, 241.11),
    vector4(1946.6, 3960.38, 31.94, 50.56),
    vector4(2409.01, 3036.3, 47.31, 0.0),
    vector4(2351.98, 3037.1, 47.31, 2.85),
    --behind mega mall on highway
    vector4(2675.12, 3522.85, 51.82, 337.68),
    vector4(2500.16, 3147.4, 48.17, 192.0),
    vector4(2459.99, 3421.68, 49.35, 203.31),
    vector4(2800.86, 3501.34, 54.01, 65.45),
    -- Middle of the city
    vector4(-326.88, -1110.13, 22.26, 161.48),
    vector4(-322.89, -945.74, 30.38, 71.28),
    vector4(-287.51, -1009.68, 29.68, 68.91),
    vector4(-134.81, -1100.53, 20.99, 323.19),
    vector4(-145.56, -1015.09, 26.57, 339.4),
    vector4(-5.9, -1051.76, 37.45, 249.88),
    vector4(325.92, -1160.04, 28.59, 269.33),
    vector4(359.03, -1159.78, 28.59, 87.21),
    vector4(424.8, -1160.77, 28.6, 270.13),
    vector4(492.02, -634.76, 24.2, 260.38),
    vector4(498.79, -584.63, 24.06, 261.68),
    vector4(433.45, -605.6, 27.8, 266.42),
    vector4(384.02, -766.19, 28.6, 181.56),
    vector4(217.88, -768.31, 30.14, 70.25),
    vector4(255.26, -745.92, 30.12, 340.34),
    vector4(357.43, -1115.55, 28.71, 0.17),
    vector4(-466.61, -800.47, 29.84, 89.82),
    --grapeseed
    vector4(2725.48, 4433.83, 43.43, 167.63),
    vector4(2548.03, 4287.77, 40.76, 149.58),
    vector4(2577.84, 4636.52, 32.74, 135.53),
    vector4(2566.22, 4665.65, 33.24, 216.1),
    vector4(2434.68, 4653.64, 32.12, 314.83),
    vector4(2306.99, 4783.39, 36.63, 164.3),
    vector4(2110.73, 4769.93, 40.37, 99.51),
    vector4(2137.47, 4835.48, 40.48, 287.46),
    vector4(2202.02, 4822.29, 38.75, 224.27),
    vector4(2009.82, 4984.85, 40.42, 46.03),
    vector4(1820.45, 4714.4, 37.07, 92.64),
    vector4(1641.39, 4772.85, 41.24, 3.26),
    vector4(1636.81, 4851.13, 41.18, 2.54),
    vector4(1668.46, 4972.26, 41.44, 131.47),
    vector4(1904.4, 4922.28, 47.99, 336.56),
    vector4(2013.08, 4982.2, 40.4, 47.72),
    vector4(1973.36, 5180.58, 47.02, 109.66),
    vector4(2416.8, 5013.13, 45.71, 134.5),
    vector4(2262.87, 5153.02, 56.24, 219.29),
    vector4(2309.92, 5189.86, 55.39, 43.13), --under a bridge may have to remove but test for now
    vector4(2577.57, 5077.18, 43.81, 195.5),
    vector4(2682.23, 5126.42, 37.3, 194.99),
    vector4(2686.72, 4856.22, 32.61, 133.55),
    vector4(2892.69, 4380.23, 49.51, 268.06),
}
