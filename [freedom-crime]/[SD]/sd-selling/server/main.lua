if not (GetResourceState('sd_lib') == 'started') then
    print('^1Error: sd_lib could not be found..')
end

local locale = SD.Locale.T -- Variable to abbreviate the locale function/translation
local data = {} -- Table to store Level and Stats Information
local dataLookup = {} -- Lookup table for quick access by identifier
local stolenDrugsTable = {} -- Table to store short-term stolen drugs information
local zoneSales = {} -- Table to store the sales of a zone
local pendingDeliveries = {} -- Table to store pending deliveries per player
local activeMissions = {} -- Table to store active delivery missions per player
local processingQueue = {} -- Table to store players in the processing queue
local activeEncounters = {} -- Table to store active encounters per player
local cooldownTimers = {} -- Table to store cooldown timers for each player in relation to encounters
local copCount = 0 -- Variable to store the number of cops online   
local playerRoutesData = {} -- Table to store routes data per player

CreateThread(function()
    local success, err = pcall(function()
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS sd_cornerselling (
                Identifier VARCHAR(255) NOT NULL,
                XP INT NOT NULL,
                Stats JSON NOT NULL DEFAULT '{}',
                Milestones JSON NOT NULL DEFAULT '{}',
                PRIMARY KEY (Identifier)
            );
        ]])
    end)
    if not success then
        print("Error creating database:", err)
    end

    local result = MySQL.query.await('SELECT * FROM sd_cornerselling', {})
    if result then
        for _, record in ipairs(result) do
            record.Changed = false
            if record.Stats then
                record.Stats = json.decode(record.Stats) or {}
            else
                record.Stats = {}
            end
            if record.Milestones then
                record.Milestones = json.decode(record.Milestones) or {}
            else
                record.Milestones = {}
            end
            table.insert(data, record)
            dataLookup[record.Identifier] = record
        end
    else
        print('^1Error: No records found or failed to query `sd_cornerselling` table.')
    end
end)

-- Event to set the Boss location when resource starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		math.randomseed(os.time())
        GlobalState.CornersellingPed = Config.Ped.Location[math.random(#Config.Ped.Location)]
    end
end)

--- Function to store pending delivery for a player.
--- Stores the pending delivery data in the 'pendingDeliveries' table.
--- @param drug table The drug data.
--- @param deliveryType string The type of delivery ('Small', 'Medium', 'Large').
local StorePendingDelivery = function(drug, deliveryType)
    local src = source
    local playerId = SD.GetIdentifier(src)
    pendingDeliveries[playerId] = {
        drug = drug,
        deliveryType = deliveryType
    }
    TriggerClientEvent('sd_bridge:notification', src, locale('notifications.delivery_ready_start'), 'success')
end

RegisterNetEvent('sd-selling:server:storePendingDelivery', StorePendingDelivery)

--- Function to cancel the pending delivery for a player.
local CancelPendingDelivery = function()
    local src = source
    local playerId = SD.GetIdentifier(src)

    if pendingDeliveries[playerId] then
        playerRoutesData[playerId] = nil
        pendingDeliveries[playerId] = nil
    end
end

RegisterNetEvent('sd-selling:server:cancelPendingDelivery', CancelPendingDelivery)

--- Function to cancel the active delivery mission for a player.
local CancelDeliveryMission = function()
    local src = source
    local playerId = SD.GetIdentifier(src)

    if activeMissions[playerId] then
        activeMissions[playerId] = nil
        TriggerClientEvent('sd-selling:client:deliveryMissionCancelled', src)
    end
end

RegisterNetEvent('sd-selling:server:cancelDeliveryMission', CancelDeliveryMission)

--- Function to calculate the payout per stop based on the drug's price and number of stops.
--- Returns the payout per stop and quantity per stop.
--- @param stops number The number of stops in the route.
--- @param drugPrice number The price per unit of the drug.
--- @param totalQuantity number The total quantity being delivered.
--- @param boost number The boost percentage to apply to the payout (e.g., 0.10 for 10%).
local CalculatePayoutPerStop = function(stops, drugPrice, totalQuantity, boost)
    local quantityPerStop = math.floor(totalQuantity / stops)
    local basePayout = quantityPerStop * drugPrice

    -- Apply boost to the base payout
    local payoutPerStop = basePayout * (1 + boost)

    return math.floor(payoutPerStop), quantityPerStop
end

--- Function to calculate routes data, including payouts and quantities.
--- Returns a table of routes with calculated payouts and quantities.
--- @param pendingDelivery table The pending delivery data.
local CalculateRoutesData = function(pendingDelivery)
    local deliveryType = pendingDelivery.deliveryType
    local drug = pendingDelivery.drug
    local deliveryConfig = Config.Delivery[deliveryType]
    local drugConfig = Config.Delivery.Drugs[drug.name]
    local drugPrice = drugConfig.Price

    local totalQuantity = deliveryConfig.Quantity

    local possibleRoutes = deliveryConfig.Routes
    local routeCount = deliveryConfig.RouteCount

    local selectedRoutes = {}
    local indices = {}
    while #selectedRoutes < routeCount and #indices < #possibleRoutes do
        local index = math.random(1, #possibleRoutes)
        if not indices[index] then
            indices[index] = true
            local routeInfo = possibleRoutes[index]
            local stops = routeInfo.Stops
            local boost = routeInfo.Boost

            local payoutPerStop, quantityPerStop = CalculatePayoutPerStop(stops, drugPrice, totalQuantity, boost)
            selectedRoutes[#selectedRoutes + 1] = {
                routeId = #selectedRoutes + 1,
                stops = stops,
                boost = boost,
                payoutPerStop = payoutPerStop,
                quantityPerStop = quantityPerStop,
                totalPayout = payoutPerStop * stops
            }
        end
    end

    return selectedRoutes
end

--- Function to check if a player is in the processing queue.
--- @param playerId string The player's identifier.
--- @return boolean True if the player is in queue, false otherwise.
local IsPlayerInQueue = function(playerId)
    return processingQueue[playerId] ~= nil
end

--- Callback to retrieve available routes for a player's pending delivery
--- @return a table of routes with calculated payouts and quantities.
SD.Callback.Register('sd-selling:server:getAvailableRoutes', function()
    local src = source
    local playerId = SD.GetIdentifier(src)
    local pendingDelivery = pendingDeliveries[playerId]
    
    if not pendingDelivery then
        return(nil)
    end
    
    if not playerRoutesData[playerId] then
        local routesData = CalculateRoutesData(pendingDelivery)
        playerRoutesData[playerId] = routesData
    end

    return(playerRoutesData[playerId])
end)

--- Callback to retrieve if the player has a pending delivery
--- @return boolean 
SD.Callback.Register('sd-selling:server:hasPendingDelivery', function()
    local src = source
    local playerId = SD.GetIdentifier(src)
    return(pendingDeliveries[playerId] ~= nil)
end)

-- Callback to return delivery status if the player has a pending delivery
SD.Callback.Register('sd-selling:server:getDeliveryStatus', function(source)
    local src = source
    local playerId = SD.GetIdentifier(src)

    local hasPending = pendingDeliveries[playerId] ~= nil
    local isInQueue = IsPlayerInQueue(playerId)
    local isOnRoute = activeMissions[playerId] ~= nil

    return({
        hasPending = hasPending,
        isInQueue = isInQueue,
        isOnRoute = isOnRoute
    })
end)

--- Function to start the delivery process for a player.
--- Adds the player to the processing queue and sets a timeout to process the delivery.
--- @param drug table The drug being delivered.
--- @param deliveryType string The type of delivery ('Small', 'Medium', 'Large').
local StartDeliveryProcess = function(drug, deliveryType)
    local src = source
    local playerId = SD.GetIdentifier(src)

    processingQueue[playerId] = true

    local deliveryConfig = Config.Delivery[deliveryType]
    local processingTimeConfig = deliveryConfig.ProcessingTime

    if processingTimeConfig.Enable then
        local processingTime = (processingTimeConfig.Period.Hour * 3600 + processingTimeConfig.Period.Min * 60) * 1000
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.delivery_processing'), 'success')

        SetTimeout(processingTime, function()
            processingQueue[playerId] = nil

            pendingDeliveries[playerId] = {
                drug = drug,
                deliveryType = deliveryType
            }
            TriggerClientEvent('sd_bridge:notification', src, locale('notifications.delivery_ready_start'), 'success')
        end)
    else
        processingQueue[playerId] = nil

        pendingDeliveries[playerId] = {
            drug = drug,
            deliveryType = deliveryType
        }
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.delivery_ready_start'), 'success')
    end
end

RegisterNetEvent('sd-selling:server:startDeliveryProcess', StartDeliveryProcess)

--- Function to calculate the distance between two positions.
--- @param pos1 table Position with x, y, z coordinates.
--- @param pos2 table Position with x, y, z coordinates.
--- @return number The distance between pos1 and pos2.
local function CalculateDistance(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    return math.sqrt(dx * dx + dy * dy)
end

-- Helper function to check if a player is on cooldown
--- @param playerId string identifier of the player
local IsPlayerOnCooldown = function(playerId)
    return cooldownTimers[playerId] ~= nil
end

--- Helper function to start a cooldown for a player
--- @param playerId string identifier of the player
local StartCooldown = function(playerId)
    local cooldownConfig = Config.Encounters.Cooldown
    local cooldownTime = (cooldownConfig.Period.Hour * 3600 + cooldownConfig.Period.Min * 60) * 1000

    cooldownTimers[playerId] = true

    SetTimeout(cooldownTime, function()
        cooldownTimers[playerId] = nil
    end)
end

--- Function to generate delivery locations based on the delivery type and number of stops.
--- Ensures that each location is at least minDistance apart from the others.
--- @param deliveryType string The type of delivery ('Small', 'Medium', 'Large').
--- @param stops number The number of stops.
local GenerateDeliveryLocations = function(deliveryType, stops)
    local locations = {}
    local deliveryConfig = Config.Delivery[deliveryType]
    local possibleLocations = deliveryConfig.Locations
    local minDistance = 100.0

    if #possibleLocations < stops then
        print(('Not enough locations for %s delivery. Needed: %d, Available: %d'):format(deliveryType, stops, #possibleLocations))
        stops = #possibleLocations
    end

    local shuffledIndices = {}
    for i = 1, #possibleLocations do
        shuffledIndices[i] = i
    end
    for i = #shuffledIndices, 2, -1 do
        local j = math.random(1, i)
        shuffledIndices[i], shuffledIndices[j] = shuffledIndices[j], shuffledIndices[i]
    end

    -- First, try to add locations that are at least minDistance apart
    for _, index in ipairs(shuffledIndices) do
        local location = possibleLocations[index]
        local isFarEnough = true

        for _, selectedLocation in ipairs(locations) do
            local distance = CalculateDistance(location, selectedLocation)
            if distance < minDistance then
                isFarEnough = false
                break
            end
        end

        if isFarEnough then
            locations[#locations + 1] = location
            if #locations >= stops then
                break
            end
        end
    end

    if #locations < stops then
        print(('Could only find %d locations at least %.1f meters apart for %s delivery. Filling with random locations.'):format(#locations, minDistance, deliveryType))
        for _, index in ipairs(shuffledIndices) do
            if #locations >= stops then break end
            local location = possibleLocations[index]
            if not locations[location] then
                locations[#locations + 1] = location
            end
        end
    end

    return locations
end

--- Function to start the delivery mission for a player.
--- Initiates the mission and sends mission data to the client.
--- @param routeId number The selected route ID.
local StartDeliveryMission = function(routeId)
    local src = source
    local playerId = SD.GetIdentifier(src)
    local pendingDelivery = pendingDeliveries[playerId]

    if not pendingDelivery then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.no_pending_delivery'), 'error')
        return
    end

    local routesData = playerRoutesData[playerId]
    if not routesData then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.no_routes_available'), 'error')
        return
    end

    local selectedRoute

    for _, route in ipairs(routesData) do
        if route.routeId == routeId then
            selectedRoute = route
            break
        end
    end

    if not selectedRoute then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.invalid_route'), 'error')
        return
    end

    playerRoutesData[playerId] = nil

    pendingDeliveries[playerId] = nil

    local deliveryLocations = GenerateDeliveryLocations(pendingDelivery.deliveryType, selectedRoute.stops)

    activeMissions[playerId] = {
        drug = pendingDelivery.drug,
        deliveryType = pendingDelivery.deliveryType,
        stops = selectedRoute.stops,
        locations = deliveryLocations,
        currentStop = 1,
        quantityPerStop = selectedRoute.quantityPerStop,
        payoutPerStop = selectedRoute.payoutPerStop
    }

    TriggerClientEvent('sd-selling:client:startDeliveryMission', src, activeMissions[playerId])
end

RegisterNetEvent('sd-selling:server:startDeliveryMission', StartDeliveryMission)

-- Function to handle payout logic
---@param source number The player source
---@param cashValue number The amount of cash to payout
---@param levelData table The level data, optional if levels are disabled
local HandlePayout = function(source, cashValue, levelData)
    local moneyType = (Config.EnableLevels and levelData and levelData.MoneyType) or Config.Payout
    local framework = SD.Framework

    if moneyType.Type == 'dirty' then
        if moneyType.DirtyType == 'standard' then
            if framework == 'qb' then
                local info = {worth = cashValue}
                SD.Inventory.AddItem(source, 'markedbills', 1, info)
            elseif framework == 'esx' then
                player.addAccountMoney(Config.DirtyMoney, cashValue)
            end
        elseif moneyType.DirtyType == '1-1' then
            SD.Inventory.AddItem(source, Config.DirtyMoney, cashValue)
        end
    else
        SD.Money.AddMoney(source, 'cash', cashValue)
    end
end

--- Function to add a new player to the data table.
--- Adds the player with default XP if they don't already exist.
--- @param identifier string The player's identifier.
local AddPlayerToData = function(identifier)
    if not dataLookup[identifier] then
        local newRecord = {
            Identifier = identifier,
            XP = 0,
            Stats = {},
            Changed = false
        }
        table.insert(data, newRecord)
        dataLookup[identifier] = newRecord
    end
end

--- Function to handle delivery completion at a stop.
--- Processes the delivery, updates mission data, and notifies the client.
local CompleteDeliveryStop = function()
    local src = source
    local playerId = SD.GetIdentifier(src)
    local mission = activeMissions[playerId]

    if not mission then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.no_active_mission'), 'error')
        return
    end

    local quantity = mission.quantityPerStop
    local drugName = mission.drug.name

    local hasItem = SD.Inventory.HasItem(src, drugName)
    if hasItem < quantity then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.not_enough_drugs'), 'error')
        return
    end

    SD.Inventory.RemoveItem(src, drugName, quantity)

    local payout = mission.payoutPerStop
    HandlePayout(src, payout)

    local deliveryType = mission.deliveryType
    if deliveryType and Config.Delivery[deliveryType] then
        AddPlayerToData(playerId)
        TriggerEvent('sd-selling:server:addXP', playerId, 'delivery', deliveryType)
    else
        print(('Error: Invalid deliveryType "%s" for player %s'):format(tostring(deliveryType), playerId))
    end

    mission.currentStop = mission.currentStop + 1
    if mission.currentStop > mission.stops then
        activeMissions[playerId] = nil
        playerRoutesData[playerId] = nil
        TriggerClientEvent('sd-selling:client:deliveryMissionComplete', src)
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.delivery_complete'), 'success')
    else
        activeMissions[playerId] = mission
        playerRoutesData[playerId] = nil
        TriggerClientEvent('sd-selling:client:proceedToNextStop', src, mission)
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.delivery_stop_complete', {payout = payout}), 'success')
    end
end

RegisterNetEvent('sd-selling:server:completeDeliveryStop', CompleteDeliveryStop)

--- Function to update the player's data in the database.
--- Inserts or updates the player's XP, Stats, and Milestones based on changes.
--- @param playerIdentifier string The player's identifier.
local UpdateDatabase = function(playerIdentifier)
    local record = dataLookup[playerIdentifier]
    if not record or not record.Changed then
        return
    end

    local xpValue = record.XP
    local statsValue = json.encode(record.Stats or {})
    local milestonesValue = json.encode(record.Milestones or {})

    local existsQuery = 'SELECT EXISTS(SELECT 1 FROM sd_cornerselling WHERE Identifier = ?) AS exist'
    local existsResult = MySQL.query.await(existsQuery, {playerIdentifier})

    if existsResult and existsResult[1] and existsResult[1].exist == 1 then
        local updateQuery = 'UPDATE sd_cornerselling SET XP = ?, Stats = ?, Milestones = ? WHERE Identifier = ?'
        local affectedRows = MySQL.update.await(updateQuery, {xpValue, statsValue, milestonesValue, playerIdentifier})
    else
        local insertQuery = 'INSERT INTO sd_cornerselling (Identifier, XP, Stats, Milestones) VALUES (?, ?, ?, ?)'
        local affectedRows = MySQL.update.await(insertQuery, {playerIdentifier, xpValue, statsValue, milestonesValue})
    end

    record.Changed = false
end


--- Event handler for player disconnect.
--- Updates the database when a player disconnects.
AddEventHandler('playerDropped', function(reason)
    local playerIdentifier = SD.GetIdentifier(source)
    UpdateDatabase(playerIdentifier)
end)

--- Function to save all player data to the database.
--- Iterates over the entire 'data' table and updates/inserts every record
--- into the 'sd_cornerselling' table, regardless of their change status.
local SaveAllData = function()
    if not data then
        return
    end

    for index, record in ipairs(data) do
        local playerIdentifier = record.Identifier
        local xpValue = record.XP
        local statsValue = json.encode(record.Stats or {})
        local milestonesValue = json.encode(record.Milestones or {})

        local existsQuery = 'SELECT EXISTS(SELECT 1 FROM sd_cornerselling WHERE Identifier = ?) AS exist'
        local existsResult = MySQL.query.await(existsQuery, {playerIdentifier})

        if existsResult and existsResult[1] and existsResult[1].exist == 1 then
            local updateQuery = 'UPDATE sd_cornerselling SET XP = ?, Stats = ?, Milestones = ? WHERE Identifier = ?'
            local affectedRows = MySQL.update.await(updateQuery, {xpValue, statsValue, milestonesValue, playerIdentifier})
        else
            local insertQuery = 'INSERT INTO sd_cornerselling (Identifier, XP, Stats, Milestones) VALUES (?, ?, ?, ?)'
            local affectedRows = MySQL.update.await(insertQuery, {playerIdentifier, xpValue, statsValue, milestonesValue})
        end

        record.Changed = false
    end
end

-- Event handler for saving all data when the server shuts down
AddEventHandler('txAdmin:events:serverShuttingDown', function()
    SaveAllData()
end)

-- Event handler for saving all data when the resource stops
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        SaveAllData()
    end
end)

--- Function to calculate the player'sF level based on XP.
--- Returns the level corresponding to the player's XP.
--- @param xp number The player's XP.
local CalculateLevel = function(xp)
    xp = tonumber(xp)

    for level, settings in ipairs(Config.Levels) do
        if settings.XPThreshold and xp < settings.XPThreshold then
            return level
        end
    end

    return #Config.Levels
end

--- Function to retrieve the player's level.
--- Returns the player's level based on their identifier.
--- @param identifier string The player's identifier.
local GetPlayerLevel = function(identifier)
    if identifier and dataLookup[identifier] then
        if Config.EnableLevels then
            local level = CalculateLevel(dataLookup[identifier].XP)
            return level
        else
            return 1
        end
    else
        return 1
    end
end

--- Event to add XP to a player.
--- Increases the player's XP and marks their data as changed.
--- @param identifier string The player's identifier.
--- @param type string The type of XP ('delivery', 'sale', or 'encounter'). Optional: defaults to 'sale' if not provided.
--- @param deliveryType string The type of delivery ('Small', 'Medium', 'Large'). Required if type is 'delivery'.
RegisterNetEvent('sd-selling:server:addXP', function(identifier, type, deliveryType)
    if Config.EnableLevels then
        local xpToAdd = 0

        if type == 'delivery' and deliveryType then
            xpToAdd = Config.Delivery[deliveryType].XPPerStop
        elseif type == 'encounter' then
            xpToAdd = Config.Encounters.XPPerEncounter
        else
            local playerLevel = GetPlayerLevel(identifier)
            xpToAdd = Config.Levels[playerLevel].XPPerSale
        end

        local record = dataLookup[identifier]
        if record then
            record.XP = (tonumber(record.XP) or 0) + xpToAdd
            record.Changed = true
        else
            print('Error: Player identifier not found in dataLookup:', identifier)
        end
    end
end)

--- Callback to retrieve player's items for a zone.
--- Returns a list of drugs the player has in the specified zone.
--- @param source number The player's source.
--- @param zoneId any The zone ID.
SD.Callback.Register('sd-selling:server:getItems', function(source, zoneId)
    local playerItems = {}
    local zone = Config.Zones[zoneId]

    if not zone then
        return nil
    end

    for drugName, drugData in pairs(zone.Drugs) do
        local itemAmount = SD.Inventory.HasItem(source, drugName)
        if itemAmount and itemAmount > 0 then
            playerItems[#playerItems + 1] = {name = drugName, amount = itemAmount}
        end
    end

    return playerItems
end)


-- Thread to retrieve the number of cops online at set intervals
CreateThread(function()
    while true do
        Wait(Config.RetrieveCopsTime * 60000)
        local players = GetPlayers()
        local amount = 0
        for i = 1, #players do
            local player = tonumber(players[i])
            if SD.HasGroup(player, Config.PoliceJobs) then
                amount = amount + 1
            end
        end
        copCount = amount
        TriggerClientEvent('sd-selling:client:setCopCount', -1, copCount)
    end
end)

-- Callback to return the number of cops to the client
SD.Callback.Register('sd-selling:server:getCopCount', function(source)
    return copCount
end)

--- Callback to retrieve a player's level and XP.
--- Returns the player's level and XP based on their identifier.
--- @param source number The player's source.
SD.Callback.Register('sd-selling:server:getPlayerLevel', function(source)
    local identifier = SD.GetIdentifier(source)
    
    if identifier and dataLookup[identifier] then
        local level, xp = GetPlayerLevel(identifier)
        local playerData = dataLookup[identifier]
        local playerXP = playerData.XP or 0
        return level, playerXP
    else
        return 1, 1
    end
end)

--- Callback to check if a player has an item and quantity.
--- Returns true if the player has the required amount, false otherwise.
--- @param source number The player's source.
--- @param item string The item name.
--- @param amount number The required amount.
SD.Callback.Register('sd-selling:server:hasItem', function(source, item, amount)
    if SD.Inventory.HasItem(source, item) >= amount then
        return true
    else
        return false
    end
end)

--- Callback to check zone cooldown.
--- Returns true if the zone is not on cooldown, false otherwise.
--- @param source number The player's source.
--- @param zoneID any The zone ID.
SD.Callback.Register('sd-selling:server:checkZoneCooldown', function(source, zoneID)
    if not Config.EnableZones then return true end 

    local currentTime = os.time()
    local zoneCooldown = Config.Zones[zoneID].Cooldown

    if zoneSales[zoneID] and (currentTime - zoneSales[zoneID].timestamp) >= (zoneCooldown.Period.Hour * 3600 + zoneCooldown.Period.Min * 60) then
        zoneSales[zoneID].count = 0
        zoneSales[zoneID].timestamp = currentTime
    end

    if zoneSales[zoneID] and zoneSales[zoneID].count >= zoneCooldown.Max then
        return false
    end

    return true
end)

--- Event to handle storing stolen drugs.
--- Removes the item from the player's inventory and stores the data.
--- @param drugName string The drug name.
--- @param quantity number The quantity of the drug.
RegisterNetEvent('sd-selling:server:storeStolenDrugs', function(drugName, quantity)
    local player = source
    SD.Inventory.RemoveItem(player, drugName, quantity)
    stolenDrugsTable[player] = {drugName = drugName, quantity = quantity}
end)

--- Event to handle returning stolen drugs.
--- Adds the stolen drugs back to the player's inventory.
RegisterNetEvent('sd-selling:server:returnStolenDrugs', function()
    local player = source
    
    if stolenDrugsTable[player] then
        local stolenData = stolenDrugsTable[player]
        SD.Inventory.AddItem(player, stolenData.drugName, stolenData.quantity)
        stolenDrugsTable[player] = nil
    end
end)

--- Event to destroy stolen drugs.
--- Removes the player's entry from the stolenDrugsTable.
RegisterNetEvent('sd-selling:server:destroyStolenDrugs', function()
    local player = source
    stolenDrugsTable[player] = nil
end)

--- Function to increment the number of sales for a specific zone.
--- Updates the sales count and timestamp for the zone.
--- @param zoneID any The zone ID.
local IncrementZone = function(zoneID)
    local currentTime = os.time()
    local zoneCooldown = Config.Zones[zoneID].Cooldown

    if not zoneSales[zoneID] then
        zoneSales[zoneID] = { count = 0, timestamp = currentTime }
    end

    if (currentTime - zoneSales[zoneID].timestamp) >= (zoneCooldown.Period.Hour * 3600 + zoneCooldown.Period.Min * 60) then
        zoneSales[zoneID].count = 0
        zoneSales[zoneID].timestamp = currentTime
    end

    zoneSales[zoneID].count = zoneSales[zoneID].count + 1
end

--- Function to generate encounter details.
--- @param source number The player's source.
--- @param drugName string The name of the drug.
--- @param currentZone table The current zone data.
local GenerateEncounterDetails = function(source, drugName, currentZone)
    local identifier = SD.GetIdentifier(source)
    local playerLevel = GetPlayerLevel(identifier)
    local levelData = Config.Levels[playerLevel]
    local encounterConfig = levelData.Encounter

    local locations = Config.Encounters.Locations
    local location = locations[math.random(1, #locations)]

    local drugData = currentZone.Drugs[drugName]
    if not drugData then
        print(('Error: Drug "%s" not found in current zone.'):format(drugName))
        return nil
    end

    local quantity = math.random(encounterConfig.Quantity.Min, encounterConfig.Quantity.Max)

    local pricePerUnit = 0
    if drugData.Price.Randomize then
        pricePerUnit = math.random(drugData.Price.Min, drugData.Price.Max)
    else
        pricePerUnit = drugData.Price.Base
    end

    if Config.EnableLevels then
        pricePerUnit = pricePerUnit * levelData.Multiplier
    end

    pricePerUnit = math.floor(pricePerUnit + 0.5)

    local totalPrice = pricePerUnit * quantity
    totalPrice = math.floor(totalPrice + 0.5)

    local encounterDetails = {
        location = location,
        drugName = drugName,
        drugLabel = drugData.Label or drugName,
        quantity = quantity,
        totalPrice = totalPrice,
        pricePerUnit = pricePerUnit
    }

    activeEncounters[identifier] = encounterDetails

    return encounterDetails
end

-- Event if the player accepts the encounter
RegisterNetEvent('sd-selling:server:acceptEncounter', function()
    local src = source
    local identifier = SD.GetIdentifier(src)
    local encounterDetails = activeEncounters[identifier]

    if encounterDetails then
        TriggerClientEvent('sd-selling:client:setEncounterBlip', src, encounterDetails.location)
        TriggerClientEvent('sd_bridge:notification', src, locale('encounter.meeting_set'), 'success')
    else
        print(('Error: No encounter details found for player %s'):format(identifier))
        TriggerClientEvent('sd_bridge:notification', src, locale('encounter.no_active_encounter'), 'error')
    end
end)

-- Event if the player declines the encounter
RegisterNetEvent('sd-selling:server:declineEncounter', function()
    local src = source
    local identifier = SD.GetIdentifier(src)
    activeEncounters[identifier] = nil
end)

--- Event if the player completes the encounter
RegisterNetEvent('sd-selling:server:completeEncounter', function(ped, encounterBlip)
    local src = source
    local identifier = SD.GetIdentifier(src)
    local encounterDetails = activeEncounters[identifier]

    if encounterDetails then
        local hasItem = SD.Inventory.HasItem(src, encounterDetails.drugName)
        if hasItem >= encounterDetails.quantity then
            SD.Inventory.RemoveItem(src, encounterDetails.drugName, encounterDetails.quantity)

            HandlePayout(src, encounterDetails.totalPrice)

            activeEncounters[identifier] = nil
            TriggerEvent('sd-selling:server:addXP', identifier, 'encounter')
            TriggerClientEvent('sd_bridge:notification', src, locale('encounter.meeting_success'), 'success')
            TriggerClientEvent('sd-selling:client:resetEncounterPed', src, ped, encounterBlip)
        else
            TriggerClientEvent('sd_bridge:notification', src, locale('encounter.no_drugs', {drug = encounterDetails.drugLabel, quantity = encounterDetails.quantity}), 'error')
        end
    else
        TriggerClientEvent('sd_bridge:notification', src, locale('encounter.no_active_encounter'), 'error')
    end
end)

--- Function to update the player's stats.
--- Adds or updates the stats for a specific drug.
--- @param identifier string The player's identifier.
--- @param drugName string The name of the drug.
--- @param quantity number The quantity of the drug.
local UpdateStats = function(identifier, drugName, quantity)
    local record = dataLookup[identifier]
    if record then
        if not record.Stats then
            record.Stats = {}
        end
        if record.Stats[drugName] then
            record.Stats[drugName] = record.Stats[drugName] + quantity
        else
            record.Stats[drugName] = quantity
        end
        record.Changed = true
    else
        print('Error: Player identifier not found in dataLookup:', identifier)
    end
end

-- Callback to retrieve the player's stats and make them available on the client
--- @param source number The player's source
SD.Callback.Register('sd-selling:server:getPlayerStats', function(source)
    local identifier = SD.GetIdentifier(source)
    
    if identifier and dataLookup[identifier] then
        return dataLookup[identifier].Stats or {}
    else
        return {}
    end
end)

--- Event to redeem a milestone for a player.
--- Grants the appropriate reward and marks the milestone as redeemed.
--- @param milestoneName string The name of the milestone category (e.g., "oxy").
--- @param progression number The progression level of the milestone (e.g., 1, 2).
local RedeemMilestone = function(milestoneName, progression)
    local src = source
    local identifier = SD.GetIdentifier(src)
    local playerData = dataLookup[identifier]
    
    if not playerData then
        print("RedeemMilestone Error: Player data not found for identifier " .. identifier)
        return
    end

    local milestones = playerData.Milestones or {}

    if milestones[milestoneName] and milestones[milestoneName][progression] then
        TriggerClientEvent('sd_bridge:notification', src, locale('milestones.redeemed'), 'error')
        print("RedeemMilestone Info: Player " .. identifier .. " attempted to redeem an already redeemed milestone: " .. milestoneName .. " progression " .. progression)
        return
    end

    local milestoneConfig = Config.Milestones[milestoneName] and Config.Milestones[milestoneName][progression]
    
    if not milestoneConfig then
        TriggerClientEvent('sd_bridge:notification', src, locale('milestones.not_completed'), 'error')
        print("RedeemMilestone Error: Milestone config not found for " .. milestoneName .. " progression " .. progression)
        return
    end

    local requiredAmount = milestoneConfig.RequiredAmount
    local playerProgress = 0

    if milestoneName == "general" then
        for _, quantity in pairs(playerData.Stats) do
            playerProgress = playerProgress + quantity
        end
    else
        playerProgress = playerData.Stats[milestoneName] or 0
    end

    if playerProgress < requiredAmount then
        TriggerClientEvent('sd_bridge:notification', src, locale('milestones.not_completed'), 'error')
        print("RedeemMilestone Error: Player " .. identifier .. " does not meet the required amount for milestone: " .. milestoneName .. " progression " .. progression)
        return
    end

    local reward = milestoneConfig.Reward
    local rewardDesc = ""

    if reward.Type == "item" then
        SD.Inventory.AddItem(src, reward.Name, reward.Amount)
        rewardDesc = locale('milestones.reward_item', { amount = reward.Amount, label = reward.Label })
    elseif reward.Type == "xp" then
        if playerData then
            playerData.XP = (playerData.XP or 0) + reward.Amount
            playerData.Changed = true
            rewardDesc = locale('milestones.reward_xp', { amount = reward.Amount })
        end
    elseif reward.Type == 'money' then 
        SD.Money.AddMoney(src, 'cash', reward.Amount)
        rewardDesc = locale('milestones.reward_money', { amount = reward.Amount })
    else
        TriggerClientEvent('sd_bridge:notification', src, "An error occurred while redeeming your milestone.", 'error')
        return
    end

    milestones[milestoneName] = milestones[milestoneName] or {}
    milestones[milestoneName][progression] = true
    playerData.Milestones = milestones
    playerData.Changed = true

    TriggerClientEvent('sd_bridge:notification', src, locale('milestones.redeemed', { milestone = milestoneName .. " - " .. locale('milestones.progression_term') .. " " .. progression, reward = rewardDesc }), 'success')
end

RegisterNetEvent('sd-selling:server:redeemMilestone', RedeemMilestone)


--- Callback to retrieve player stats and milestones.
SD.Callback.Register('sd-selling:server:getPlayerMilestones', function(source)
    local identifier = SD.GetIdentifier(source)
    local playerData = dataLookup[identifier]
    if not playerData then return {stats = {}, milestones = {}} end

    return {
        stats = playerData.Stats or {},
        milestones = playerData.Milestones or {}
    }
end)

--- Function to handle money laundering.
--- Cleans dirty money or handles 1-1 item washing.
--- @param source number The player's source.
local MoneyLaundering = function(source)
    local player = SD.GetPlayer(source)
    local level = GetPlayerLevel(SD.GetIdentifier(source))
    local levelConfig = Config.Levels[level]

    if Config.MoneyWashing.WashItem.Enable then
        local chance = math.random(0, 100)
        local itemAmount = SD.Inventory.HasItem(source, Config.MoneyWashing.WashItem.ItemName)

        if itemAmount >= Config.MoneyWashing.WashItem.MinAmount and chance <= Config.MoneyWashing.WashItem.Chance then
            local washAmount = itemAmount >= Config.MoneyWashing.WashItem.MaxAmount and math.random(Config.MoneyWashing.WashItem.MinAmount, Config.MoneyWashing.WashItem.MaxAmount) or math.random(Config.MoneyWashing.WashItem.MinAmount, itemAmount)

            local moneyToAdd = washAmount
            if Config.EnableLevels and levelConfig.Tax.Enable then 
                moneyToAdd = moneyToAdd - (moneyToAdd * (levelConfig.Tax.Percentage / 100)) 
                moneyToAdd = math.floor(moneyToAdd + 0.5) 
            end

            SD.Money.AddMoney(source, 'cash', moneyToAdd)
            SD.Inventory.RemoveItem(source, Config.MoneyWashing.WashItem.ItemName, washAmount)
        end
    else
        local chance = math.random(0, 100)
        local BillsCount = SD.Inventory.HasItem(source, 'markedbills')
        local BandsCount = SD.Inventory.HasItem(source, 'bands')
        local RollsCount = SD.Inventory.HasItem(source, 'rolls')

        local rewards = {
            {name = 'markedbills', chance = levelConfig.Washing.Bills.chance, payoutMin = levelConfig.Washing.Bills.min, payoutMax = levelConfig.Washing.Bills.max, amount = BillsCount},
            {name = 'bands', chance = levelConfig.Washing.Bands.chance, payoutMin = levelConfig.Washing.Bands.min, payoutMax = levelConfig.Washing.Bands.max, amount = BandsCount},
            {name = 'rolls', chance = levelConfig.Washing.Rolls.chance, payoutMin = levelConfig.Washing.Rolls.min, payoutMax = levelConfig.Washing.Rolls.max, amount = RollsCount}
        }

        for _, reward in ipairs(rewards) do
            if chance < reward.chance and SD.Inventory.HasItem(source, reward.name) > 0 then
                local amount = 1

                local moneyToAdd = 0
                if reward.name == 'markedbills' then
                    local worth = player.Functions.GetItemByName(source, 'markedbills').info.worth
                    if worth then 
                        moneyToAdd = amount * worth 
                    else 
                        moneyToAdd = amount * math.random(reward.payoutMin, reward.payoutMax) 
                    end
                elseif reward.name == 'bands' then
                    moneyToAdd = amount * math.random(reward.payoutMin, reward.payoutMax)
                elseif reward.name == 'rolls' then
                    moneyToAdd = amount * math.random(reward.payoutMin, reward.payoutMax)
                end

                if Config.EnableLevels and levelConfig.Tax.Enable then 
                    moneyToAdd = moneyToAdd - (moneyToAdd * (levelConfig.Tax.Percentage / 100))
                    moneyToAdd = math.floor(moneyToAdd + 0.5)
                end

                SD.Money.AddMoney(source, 'cash', moneyToAdd)
                SD.Inventory.RemoveItem(source, reward.name, amount)
            end
        end
    end
end

--- Function to handle the drug sale process.
--- Removes the items and adds money to the player, handles XP and police notifications.
--- @param drugName string The name of the drug.
--- @param data table Additional data for the sale.
--- @param entity string the name of the entity
local HandleDrugSale = function(drugName, data, entity)
    local src = source
    local player = SD.GetPlayer(src)
    local zoneID = data.zoneID
    local currentZone = Config.Zones[zoneID]
    local identifier = SD.GetIdentifier(src)
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)

    if player and currentZone then
        local drugData = currentZone.Drugs[drugName]

        local distance = #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(currentZone.Coords.x, currentZone.Coords.y, currentZone.Coords.z))

        if Config.EnableZones and distance > currentZone.Size then
            print("Player is not within the zone.")
            return
        end

        if drugData then
            local level = GetPlayerLevel(identifier)
            local levelData = Config.Levels[level]

            local price = data.price
            local quantity = data.quantity

            if (drugData.Price.Randomize and price / (Config.EnableLevels and levelData.Multiplier or 1) >= drugData.Price.Min and price / (Config.EnableLevels and levelData.Multiplier or 1) <= drugData.Price.Max) or (not drugData.Price.Randomize and price / (Config.EnableLevels and levelData.Multiplier or 1) == drugData.Price.Base) then
                if (drugData.Quantity.Randomize and quantity >= drugData.Quantity.Min and quantity <= drugData.Quantity.Max) or (not drugData.Quantity.Randomize and quantity == drugData.Quantity.Base) then
                    local playerItemAmount = SD.Inventory.HasItem(src, drugName)
                    if playerItemAmount >= quantity then
                        AddPlayerToData(identifier)
                        SD.Inventory.RemoveItem(src, drugName, quantity)

                        local cashValue = price * quantity

                        HandlePayout(src, cashValue, levelData)

                        if Config.EnableLaundering then MoneyLaundering(src) end

                        if Config.EnableLevels then
                            TriggerEvent('sd-selling:server:addXP', identifier)
                        end

                        if Config.Stats.Enable then
                            UpdateStats(identifier, drugName, quantity)
                        end

                        if levelData.Encounter.Enable and (math.random(1, 100) <= levelData.Encounter.Chance) then
                            
                            if IsPlayerOnCooldown(identifier) then
                                print(('Player %s is on cooldown for encounters. Skipping encounter.'):format(identifier))
                                TriggerClientEvent('sd-selling:client:cleanUp', src, entity)
                                return
                            end
                        
                            local encounterDetails = GenerateEncounterDetails(src, drugName, currentZone)
                            if encounterDetails then
                                local clientEncounterInfo = {
                                    drugLabel = encounterDetails.drugLabel,
                                    quantity = encounterDetails.quantity,
                                    totalPrice = encounterDetails.totalPrice
                                }
                                
                                TriggerClientEvent('sd-selling:client:createEncounter', src, entity, clientEncounterInfo)
                                if Config.Encounters.Cooldown.Enable then StartCooldown(identifier) end
                            else
                                print('Encounter details could not be generated.')
                            end
                        else
                            TriggerClientEvent('sd-selling:client:cleanUp', src, entity)
                        end

                        if Config.EnableLevels and levelData.PoliceNotify.Enable and math.random(100) <= levelData.PoliceNotify.Chance then
                            TriggerClientEvent('sd-selling:client:policeAlert', src)
                        end

                        IncrementZone(zoneID)
                    end
                end
            end
        end
    end
end

--- Event to handle the drug sale.
--- Calls HandleDrugSale with the given drug name and data.
RegisterNetEvent('sd-selling:server:handleDrugSale', HandleDrugSale)

SD.CheckVersion('sd-versions/sd-selling')
