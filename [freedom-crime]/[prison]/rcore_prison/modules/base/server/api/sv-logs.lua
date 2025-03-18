Logs = {}

NetworkService.EventListener('heartbeat', function(eventType, data)
    if not next(data) then
        return
    end

    local prisoner = data.prisoner

    if not prisoner then
        return
    end

    local playerId = prisoner.source

    if eventType == 'PRISONER_NEW' then
        NewPrisoner(prisoner)
    elseif eventType == 'PRISONER_RELEASED' and not prisoner.escaped then
        PrisonerReleased(prisoner)
        Inventory.HandleOpenState(playerId, false)

        if RegisterNetworkFlow[tostring(playerId)] then
            RegisterNetworkFlow[tostring(playerId)] = nil
        end
    end
end)

Logs.Sent = function(title, description, fields)
    Discord.SendMessage(title, description, fields)
end

Logs.PrisonBreak = function(playerId)
    Discord.SendMessage(_U('LOGS_DISCORD.PRISON_BREAK_TITLE_LABEL'), _U('LOGS_DISCORD.PRISON_BREAK_DESC_LABEL'), {
        { name = _U('LOGS_DISCORD.OOC_NAME'), value = GetPlayerName(playerId) },
    })
end

function PrisonerReleased(prisoner)
    Discord.SendMessage(_U('LOGS_DISCORD.PRISONER_RELEASED_TITLE_LABEL'), _U('LOGS_DISCORD.PRISONER_RELEASED_DESC_LABEL'), {
        { name = _U('LOGS_DISCORD.OOC_NAME'), value = GetPlayerName(prisoner.source) },
        { name = _U('LOGS_DISCORD.IC_NAME'), value = prisoner.prisonerName },
        { name = _U('LOGS_DISCORD.CHARACTER_ID'), value = prisoner.owner },
        { name = _U('LOGS_DISCORD.REMAINING_JAIL_TIME'), value = Time.DynamicSecondsToClock(prisoner.jail_time) },
    })
end

function NewPrisoner(prisoner)
    Discord.SendMessage(_U('LOGS_DISCORD.NEW_PRISONER_TITLE_LABEL'), _U('LOGS_DISCORD.NEW_PRISONER_DESC_LABEL'), {
        { name = _U('LOGS_DISCORD.OOC_NAME'), value = GetPlayerName(prisoner.source) },
        { name = _U('LOGS_DISCORD.IC_NAME'), value = prisoner.prisonerName },
        { name = _U('LOGS_DISCORD.CHARACTER_ID'), value = prisoner.owner },
        { name = _U('LOGS_DISCORD.JAIL_TIME'), value = Time.DynamicSecondsToClock(prisoner.jail_time) },
        { name = _U('LOGS_DISCORD.JAIL_REASON'), value = prisoner.jail_reason },
    })
end

function Logs.FreePackageCanteen(playerId)
    Discord.SendMessage(_U('LOGS_DISCORD.CANTEEN_TITLE_LABEL'), _U('LOGS_DISCORD.CANTEEN_DESC_LABEL'), {
        { name = _U('LOGS_DISCORD.OOC_NAME'), value = GetPlayerName(playerId) },
        { name = _U('LOGS_DISCORD.IC_NAME'), value = Framework.getCharacterName(playerId) },
        { name = _U('LOGS_DISCORD.CHARACTER_ID'), value = Framework.getIdentifier(playerId)},
    })
end

function Logs.BuyItemCanteen(playerId, item, itemAmount, itemPrice)
    Discord.SendMessage(_U('LOGS_DISCORD.CANTEEN_TITLE_LABEL'), _U('LOGS_DISCORD.CANTEEN_BOUGH_ITEM_LABEL'), {
        { name = _U('LOGS_DISCORD.OOC_NAME'), value = GetPlayerName(playerId) },
        { name = _U('LOGS_DISCORD.IC_NAME'), value = Framework.getCharacterName(playerId) },
        { name = _U('LOGS_DISCORD.CHARACTER_ID'), value = Framework.getIdentifier(playerId)},
        { name = _U('LOGS_DISCORD.ITEM'), value = item.name },
        { name = _U('LOGS_DISCORD.AMOUNT'), value = itemAmount },
        { name = _U('LOGS_DISCORD.TOTAL_COST'), value = itemPrice },
    })
end