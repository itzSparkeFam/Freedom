-- Check to see if fm-logs or fmsdk is started
local fmlogs = GetResourceState('fm-logs') == 'started'
local fmsdk = GetResourceState('fmsdk') == 'started'

-- Empty function that is triggered on drug sales
-- Can be used with XP systems, gang scripts, etc
--- @param source number Player ID
--- @param zoneId number Zone ID
--- @param item string Drug/item name
--- @param quantity number Quantity sold
--- @param value number Total money paid to player
function DrugSold(source, zoneId, item, quantity, value)
    -- Below is an example implementation of how you could use this function
    -- In this example, we'll check if the player is a gang member and if so
    -- Add reputation/notoriety to their gang upon a drug sale
    -- First, let's check if they are in a gang:
    local inGang = true
    -- If we were using something like t1ger_gangsystem we would replace
    -- "true" with the proper export, aka: exports['t1ger_gangsystem']:GetPlayerGangId(source)
    if inGang then
        -- inGang returned true or something greater than 0, so now we work within 
        -- This if-then statement. So if inGang then..
        -- Let's only add reputation/notoriety if they are selling a specific item..
        if item == 'special_drug' then
            -- Now we know this player is in a gang, and is selling this special drug
            -- So now let's add some reputation/notoriety to their gang!
            local addNotoriety = 100
            -- But, maybe we should change how much notoriety is added based
            -- On how many of this special drug they sold.. so let's do it!
            local totalToAdd = math.floor(addNotoriety * quantity)
            -- Here we just multiply the addNotoriety by the total quantity sold
            -- So if they sold x3 special_drug then they would get 300 notoriety
            -- Now we would place our export/event below to add it!
            -- exports['t1ger_gangsystem']:PlusGangNotoriety(inGang, totalToAdd)
        end
    end
    -- If a player was not in a gang then the code would do nothing!
    -- This is a simple example to demonstrate one of the many, many
    -- Options you have with a function like this, enjoy <3
end

-- Used to pay the player upon successful drug sale
--- @param source number Player ID
--- @param zoneId number Zone ID
--- @param amount number Amount of money
function PayPlayer(source, zoneId, amount)
    if not source or not zoneId or not amount then return end
    local player = GetPlayer(source)
    if not player then return end
    local zone = Config.Zones[zoneId]
    if not zone then return end
    local money, metadata = zone.settings.money, zone.settings.metadata
    if Framework == 'esx' then
        if money == 'black_money' or money == 'money' or money == 'bank' then
            player.addAccountMoney(money, amount)
        else
            AddItem(source, money, amount)
        end
    elseif Framework == 'qb' then
        if money == 'markedbills' or money == 'cashrolls' or money == 'bands' then
            if metadata then
                local hasBag = GetItemCount(source, money)
                if hasBag and hasBag > 0 then
                    local currentValue = player.Functions.GetItemByName(money).info.worth
                    local newValue = amount
                    local updatedValue = { worth = math.ceil(currentValue + newValue) }
                    player.Functions.RemoveItem(money, 1)
                    player.Functions.AddItem(money, 1, false, updatedValue)
                else
                    local data = { worth = amount }
                    player.Functions.AddItem(money, 1, false, data)
                end
            else
                player.Functions.AddItem(money, amount)
            end
        elseif money == 'cash' or money == 'bank' then
            AddMoney(source, money, amount)
        else
            AddItem(source, money, amount)
        end
    elseif Framework == 'qbx' then
        AddItem(source, money, amount)
    elseif Framework == 'ox' then
        AddItem(source, money, amount)
    else
        -- Add support for a custom framework here
    end
end

-- Returns number of players with police job(s)
--- @return number
function GetPoliceCount()
    local count, jobs = 0, {}
    for _, job in pairs(Config.Police.jobs) do
        jobs[job] = true
    end
    if Framework == 'esx' then
        for _, player in pairs(ESX.GetExtendedPlayers()) do
            if jobs[player.getJob().name] then
                count += 1
            end
        end
    elseif Framework == 'qb' then
        for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
            local player = QBCore.Functions.GetPlayer(playerId)
            if jobs[player.PlayerData.job.name] and player.PlayerData.job.onduty then
                count += 1
            end
        end
    elseif Framework == 'qbx' then
        for job, _ in pairs(jobs) do
            count = count + exports.qbx_core:GetDutyCountJob(job)
        end
    elseif Framework == 'ox' then
        -- TODO
    else
        -- Add custom framework here
    end
    return count
end

-- Returns an items metadata
--- @param source number Player ID
--- @param item string Item name
function GetMetadata(source, item)
    if not source or not item then return end
    local player = GetPlayer(source)
    if not player then return end
    if Inventory == 'ox_inventory' then
        local data = exports[Inventory]:Search(source, 'slots', item)
        if not data or #data == 0 then return end
        return data[1].metadata
    else
        local data = exports[Inventory]:GetItemByName(source, item)
        if not data then return end
        return data.info
    end
end

-- Log events if applicable
--- @param message string Message contents
--- @param type string Log type
function EventLog(message, type)
    if not message or not Config.Setup.debug then return end
    if Logs.Service == 'fivemanage' then
        if not fmsdk then return end
        exports.fmsdk:LogMessage(type or 'info', message)
    elseif Logs.Service == 'fivemerr' then
        if not fmlogs then return end
        exports['fm-logs']:createLog({
            LogType = 'Resource',
            Resource = 'lation_selling',
            Level = type or 'info',
            Message = message,
        })
    else
        print(message)
    end
end

-- Log player events if applicable
--- @param source number Player ID
--- @param title string Log title
--- @param message string Message contents
function PlayerLog(source, title, message)
    if Logs.Service == 'fivemanage' then
        if not fmsdk then return end
        if Logs.Screenshots then
            exports.fmsdk:takeServerImage(source, {
                name = title,
                description = message,
            })
        else
            exports.fmsdk:LogMessage('info', message)
        end
    elseif Logs.Service == 'fivemerr' then
        if not fmlogs then return end
        exports['fm-logs']:createLog({
            LogType = 'Player',
            Message = message,
            Resource = 'lation_selling',
            Source = source,
        }, { Screenshot = Logs.Screenshots })
    elseif Logs.Service == 'discord' then
        local embed = {
            {
                ["color"] = 16711680,
                ["title"] = "**".. title .."**",
                ["description"] = message,
                ["footer"] = {
                    ["text"] = os.date("%a %b %d, %I:%M%p"),
                    ["icon_url"] = Logs.Discord.footer
                }
            }
        }
        PerformHttpRequest(Logs.Discord.link, function()
        end, 'POST', json.encode({username = Logs.Discord.name, embeds = embed, avatar_url = Logs.Discord.image}), {['Content-Type'] = 'application/json'})
    end
end