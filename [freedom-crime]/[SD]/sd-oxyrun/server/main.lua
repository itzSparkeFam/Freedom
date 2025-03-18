if not (GetResourceState('sd_lib') == 'started') then
    print("^1Error: sd_lib isn't installed or this resource has been started before sd_lib.")
end

local locale = SD.Locale.T
-- Variable to track status of the Cooldown
local Cooldown = false
-- Table to track active routes for each player
local activeRoutes = {}
-- Table to store Level Information (populated by the thread below)
local data = {}

-- Event to handle route occupancy and track active routes
RegisterNetEvent('sd-oxyrun:server:SetRouteOccupied', function(level, route, toggle)
    -- Check if the level and route are valid within the Config.Routes structure
    if Config.Routes[level] and Config.Routes[level][route] and Config.Routes[level][route].info then
        -- Set the route's 'occupied' status
        Config.Routes[level][route].info.occupied = toggle

        local identifier = SD.GetIdentifier(source)

        -- Track or remove the active route based on the 'toggle' value
        if toggle then activeRoutes[identifier] = { level = level, route = route } else activeRoutes[identifier] = nil end
    end
end)

-- Thread that queries the database for level information and populates the data table with the results
CreateThread(function()
    local success, err = pcall(function()
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS sd_oxyrun (
                Identifier VARCHAR(255) NOT NULL,
                XP INT NOT NULL,
                PRIMARY KEY (Identifier)
            );
        ]])
    end)
    if not success then
        print("Error creating database:", err)
    end

    local result = MySQL.query.await('SELECT * FROM sd_oxyrun', {})
    if result then
        for _, record in ipairs(result) do
            record.Changed = false
        end
        data = result
    else
        print('^1Error: No records found or failed to query `sd_oxyrun` table.')
    end
end)

-- Function to update database or insert new identifier with default XP value.
local updateDatabase = function(playerIdentifier)
    local foundInData = false
    local xpValue = 0

    -- Check if the player's identifier exists in the data table and has, at some point, influenced the XP value.
    for _, record in ipairs(data) do
        if record.Identifier == playerIdentifier and record.Changed then
            foundInData = true
            xpValue = record.XP
            break
        end
    end

    if foundInData then
        -- Check if the Identifier exists in the database.
        local results = MySQL.query.await('SELECT EXISTS(SELECT 1 FROM sd_oxyrun WHERE Identifier = @identifier) AS exist', {
            ['@identifier'] = playerIdentifier
        })

        if not results or not results[1] or results[1].exist == 0 then
            -- Insert new record with the player's identifier and XP.
            MySQL.query.await('INSERT INTO sd_oxyrun (Identifier, XP) VALUES (@identifier, @xp)', {
                ['@identifier'] = playerIdentifier,
                ['@xp'] = xpValue
            })
        else
            -- Update existing record with new XP value.
            MySQL.query.await('UPDATE sd_oxyrun SET XP = @xp WHERE Identifier = @identifier', {
                ['@identifier'] = playerIdentifier,
                ['@xp'] = xpValue
            })
        end
    end
end

-- Function to calculate level based on XP
local calculateLevel = function(xp)
    xp = tonumber(xp)

    for level, settings in ipairs(Config.Levels) do
        if settings.XPThreshold and xp < settings.XPThreshold then return level - 1 end
    end

    return #Config.Levels
end


-- Callback to retrieve a specific player's level and XP based on their identifier
SD.Callback.Register('sd-oxyrun:server:getPlayerInfo', function(source, identifier)
    for _, record in ipairs(data) do
        if record.Identifier == identifier then
            local level = calculateLevel(record.XP)
            return({level = level, xp = record.XP})
        end
    end

    return({level = nil, xp = nil})
end)

-- Function to retrieve XP for a given identifier
local getPlayerLevel = function(identifier)
    for _, record in ipairs(data) do
        if record.Identifier == identifier then
            local Level = calculateLevel(record.XP)
            return Level
        end
    end
    return nil 
end

-- CALLBACKS
-- Callback to check the cooldown status
SD.Callback.Register("sd-oxyrun:server:coolc", function(source)
    return(Cooldown)
end)

-- Callback to count the number of cops
SD.Callback.Register('sd-oxyrun:server:getCops', function(source)
    local players = GetPlayers()
    local amount = 0
    for i=1, #players do
        local player = tonumber(players[i])
        if SD.HasGroup(player, Config.PoliceJobs) then
            amount = amount + 1
        end
    end
    return(amount)
end)

-- Callback to check if the player has the required item and (optionally) consume it.
SD.Callback.Register('sd-oxyrun:server:hasItem', function(source)
    local itemCount = SD.Inventory.HasItem(source, Config.CheckForItem.Item)
    if itemCount and itemCount > 0 then
        if Config.CheckForItem.Consume.Enable then
            if math.random(1, 100) <= Config.CheckForItem.Consume.Chance then
                SD.Inventory.RemoveItem(source, Config.CheckForItem.Item, 1)
            end
        end
        return true
    else
        return false
    end
end)

-- Callback to retrieve the available routes for a specific level
SD.Callback.Register('sd-oxyrun:server:getAvailableRoutes', function(source, level)
    local availableRoutes = {}
    if Config.Routes[level] then
        for i, route in ipairs(Config.Routes[level]) do
            if not route.info.occupied then
                table.insert(availableRoutes, i)
            end
        end
    end
    return(availableRoutes)
end)

-- Callback to retrieve a player's level using the calculateLevel function
SD.Callback.Register('sd-oxyrun:server:getPlayerLevel', function(source)
    local identifier = SD.GetIdentifier(source)
    for _, record in ipairs(data) do
        if record.Identifier == identifier then
            local level = calculateLevel(record.XP)
            return(level)
        end
    end
    return(nil) -- Return nil if the player is not found
end)

-- Event to add XP
RegisterNetEvent('sd-oxyrun:server:addXP', function(identifier)
    local playerLevel = getPlayerLevel(identifier)
    
    for _, record in ipairs(data) do
        if record.Identifier == identifier then
            record.XP = (tonumber(record.XP) or 0) + Config.Levels[playerLevel].XPPerDelivery
            if not record.Changed then record.Changed = true end
            break
        end
    end
end)

-- Function to add a new player if not in data table
local addPlayerToData = function(identifier)
    local playerExists = false

    for _, record in ipairs(data) do if record.Identifier == identifier then playerExists = true break end end

    if not playerExists then
        local newPlayer = {Identifier = identifier, XP = 0}
        table.insert(data, newPlayer)
    end
end

-- Event to set the OxyBoss location when resource starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		math.randomseed(os.time())
        GlobalState.OxyBossLocation = Config.Ped.Location[math.random(#Config.Ped.Location)]
    end
end)

-- Event handler for player disconnect
AddEventHandler('playerDropped', function(reason)
    local playerIdentifier = SD.GetIdentifier(source)
    updateDatabase(playerIdentifier)

    local activeRoute = activeRoutes[playerIdentifier]
    if activeRoute then
        local level = activeRoute.level local route = activeRoute.route

        if Config.Routes[level] and Config.Routes[level][route] and Config.Routes[level][route].info then Config.Routes[level][route].info.occupied = false end
        -- Remove the player from the active routes table
        activeRoutes[playerIdentifier] = nil
    end
end)

-- Event to start the run
RegisterNetEvent('sd-oxyrun:server:startr', function()
	local src = source
    local identifier = SD.GetIdentifier(src)
	local hasMoney = SD.Money.GetPlayerAccountFunds(src, 'money', Config.RunCost)

	if hasMoney >= Config.RunCost then
        addPlayerToData(identifier)
		TriggerClientEvent("sd-oxyrun:client:sendToOxy", src)
	else
		TriggerClientEvent('sd_bridge:notification', src, locale('error.you_dont_have_enough_money'), 'error')
	end
end)

-- Event to take money from the player and if enabled, trigger the Cooldown
RegisterNetEvent('sd-oxyrun:server:TakeMoney', function()
	SD.Money.RemoveMoney(source, 'cash', Config.RunCost)

    if Config.Cooldown.EnableGlobalCooldown then
        TriggerEvent('sd-oxyrun:server:coolout')
    end
end)

RegisterNetEvent('sd-oxyrun:server:removeItem', function()
    if SD.Inventory.HasItem(source, Config.Items.Package) > 0 then
        SD.Inventory.RemoveItem(source, Config.Items.Package, 1)
    end
end)

-- Event to implement cooldown
RegisterNetEvent('sd-oxyrun:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown.GlobalCooldown * 60000

    print(locale('prints.global_cooldown_started'))

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            print(locale('prints.global_cooldown_finished'))
            Cooldown = false
        end
    end
end)

-- Event to send the car
RegisterNetEvent("sd-oxyrun:server:sendCar", function(Routes)
	TriggerClientEvent("sd-oxyrun:createOxyVehicle", source, Routes)
end)

-- Event to process package delivery and rewards
RegisterNetEvent("sd-oxyrun:server:deliver", function(doingOxy, holdingBox)
    local Player = SD.GetPlayer(source)
    local identifier = SD.GetIdentifier(source)
    local playerLevel = getPlayerLevel(identifier)
    local levelConfig = Config.Levels[playerLevel] or Config.Levels[1]

    if doingOxy and holdingBox and SD.Inventory.HasItem(source, Config.Items.Package) > 0 then
        if Config.Levels.GiveItem then
            local rareitemchance = math.random(1, 100)
            local itemCount = math.random(levelConfig.ItemReward.Min, levelConfig.ItemReward.Max)

            -- Give the standard item reward
            SD.Inventory.AddItem(source, levelConfig.ItemReward.Item, itemCount)

            -- Process rare item rewards
            if levelConfig.RareItem.Enable and rareitemchance <= levelConfig.RareItem.Chance then
                local itemIndex = math.random(1, #levelConfig.RareItem.Reward.Items)
                local itemCount2 = math.random(levelConfig.RareItem.Reward.Min, levelConfig.RareItem.Reward.Max)
                SD.Inventory.AddItem(source, levelConfig.RareItem.Reward.Items[itemIndex], itemCount2)
            end
        end

        local washingSettings = levelConfig.Washing or {}

        -- Handle 1-1 item washing if enabled and player has enough
        if Config.MoneyWashing.WashItem.Enable then
            local chance = math.random(0, 100)
            local itemAmount = SD.Inventory.HasItem(source, Config.MoneyWashing.WashItem.ItemName)
            if itemAmount >= Config.MoneyWashing.WashItem.MinAmount and chance <= Config.MoneyWashing.WashItem.Chance then
                
                local washAmount
                if itemAmount >= Config.MoneyWashing.WashItem.MaxAmount then
                    washAmount = math.random(Config.MoneyWashing.WashItem.MinAmount, Config.MoneyWashing.WashItem.MaxAmount)
                else
                    washAmount = math.random(Config.MoneyWashing.WashItem.MinAmount, itemAmount)
                end

                local moneyToAdd = washAmount
                if levelConfig.Tax.Enable then 
                    moneyToAdd = moneyToAdd - (moneyToAdd * (levelConfig.Tax.Percentage / 100)) 
                    moneyToAdd = math.floor(moneyToAdd + 0.5) 
                end

                SD.Money.AddMoney(source, 'cash', moneyToAdd)
                SD.Inventory.RemoveItem(source, Config.MoneyWashing.WashItem.ItemName, washAmount)
            end
        elseif washingSettings.Enable then
        -- Handle dirty money cleaning
            local chance = math.random(0, 100)
            
            local BillsCount = SD.Inventory.HasItem(source, 'markedbills')
            local BandsCount = SD.Inventory.HasItem(source, 'bands')
            local RollsCount = SD.Inventory.HasItem(source, 'rolls')

                -- Washing logic for Bags, Bands, and Rolls
                local rewards = {
                    {name = 'markedbills', chance = washingSettings.Bills.chance, payoutMin = washingSettings.Bills.min, payoutMax = washingSettings.Bills.max, amount = BillsCount},
                    {name = 'bands', chance = washingSettings.Bands.chance, payoutMin = washingSettings.Bands.min, payoutMax = washingSettings.Bands.max, amount = BandsCount},
                    {name = 'rolls', chance = washingSettings.Rolls.chance, payoutMin = washingSettings.Rolls.min, payoutMax = washingSettings.Rolls.max, amount = RollsCount}
                }

                for _, reward in ipairs(rewards) do
                    if chance < reward.chance and SD.Inventory.HasItem(source, reward.name) > 0 then
                        local amount = Config.Amount.Type == 'random' and math.random(reward.amount) or 1
                        if amount > Config.Amount.max then amount = Config.Amount.max end

                        local moneyToAdd = 0
                        if reward.name == 'markedbills' then
                            if SD.Framework == 'qb' then
                                local worth = Player.Functions.GetItemByName('markedbills').info.worth
                                if worth then 
                                    moneyToAdd = amount * worth 
                                else 
                                    moneyToAdd = amount * math.random(reward.payoutMin, reward.payoutMax) 
                                end
                            elseif SD.Framework == 'esx' then
                                local black_money_player = Player.getAccount('black_money').money
                                if black_money_player > 0 then
                                    if black_money_player > 3000 then 
                                        black_money_player = 3000
                                    end
                                    Player.removeAccountMoney('black_money', black_money_player)
                                    moneyToAdd = black_money_player
                                end
                            end
                        elseif reward.name == 'bands' then
                            moneyToAdd = amount * math.random(reward.payoutMin, reward.payoutMax)
                        elseif reward.name == 'rolls' then
                            moneyToAdd = amount * math.random(reward.payoutMin, reward.payoutMax)
                        end

                        if levelConfig.Tax.Enable then moneyToAdd = moneyToAdd - (moneyToAdd * (levelConfig.Tax.Percentage / 100)) moneyToAdd = math.floor(moneyToAdd + 0.5) end

                        SD.Money.AddMoney(source, 'cash', moneyToAdd)
                        SD.Inventory.RemoveItem(source, reward.name, amount)
                    end
            end
        end
        TriggerEvent('sd-oxyrun:server:addXP', identifier)
        SD.Inventory.RemoveItem(source, Config.Items.Package, 1)
    end
end)

RegisterNetEvent('sd-oxyrun:server:addItem', function(SupplierPosition, isOnRun)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local distanceThreshold = 5.0 -- Distance threshold in meters

    if isOnRun then
        if SupplierPosition then
            local supplierDistance = #(playerCoords - vector3(SupplierPosition.x, SupplierPosition.y, SupplierPosition.z))

            if supplierDistance <= distanceThreshold then
                SD.Inventory.AddItem(source, Config.Items.Package, 1)
            end
        end
    end
end)

SD.CheckVersion('sd-versions/sd-oxyrun') -- Check version of specified resource