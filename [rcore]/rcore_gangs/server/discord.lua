WEBHOOK_URL = ''

function formatDrugDiscordLog(source, drugSold, drugAmountSold, drugSoldCost)
    return {
        {
            ["name"] = Locale.DISCORD_PLAYER_NAME,
            ["value"] = GetPlayerName(source),
        },
        {
            ["name"] = Locale.DISCORD_CHARACTER_NAME,
            ["value"] = Framework.GetCharacterName(source),
        },
        {
            ["name"] = Locale.DISCORD_DRUG_SOLD,
            ["value"] = drugSold,
        },
        {
            ["name"] = Locale.DISCORD_DRUG_AMOUNT,
            ["value"] = drugAmountSold,
        },
        {
            ["name"] = Locale.DISCORD_DRUG_SELL_PRICE,
            ["value"] = Locale.DISCORD_CURRENCY .. tostring(drugSoldCost),
        },
    }
end

function formatRivalryLog(gangWhoStartedRivalry, gangInRivalry, territoryName)
    return {
        {
            ["name"] = Locale.DISCORD_STARTED_RIVALRY_GANG_NAME,
            ["value"] = gangWhoStartedRivalry,
        },
        {
            ["name"] = Locale.DISCORD_IN_RIVALRY_GANG_NAME,
            ["value"] = gangInRivalry,
        },
        {
            ["name"] = Locale.DISCORD_TERRITORY_NAME,
            ["value"] = territoryName,
        },
    }
end

function formatTerritoryCaptureLog(oldOwnerName, newOwnerName, territoryName)
    return {
        {
            ["name"] = Locale.DISCORD_NEW_OWNER_NAME,
            ["value"] = newOwnerName,
        },
        {
            ["name"] = Locale.DISCORD_OLD_OWNER_NAME,
            ["value"] = oldOwnerName,
        },
        {
            ["name"] = Locale.DISCORD_TERRITORY_NAME,
            ["value"] = territoryName,
        },
    }
end

function logToDiscord(serverId, fieldData)

    if WEBHOOK_URL and WEBHOOK_URL ~= '' then
        local embed = {
            {
                ["fields"] = fieldData,
                ["color"] = 16767002,
                ["title"] = "**RCore Gangs Logs**",
                ["description"] = "",
                ["footer"] = {
                    ["text"] = os.date('%Y/%m/%d %H:%M:%S')
                },
                ["thumbnail"] = {
                    ["url"] = "",
                },
            }
        }


        if serverId then
            local discordId = GetPlayerIdentifierByType(serverId, 'discord')
            if discordId then
                discordId = discordId:gsub("discord:", "")
                table.insert(embed[1].fields, 
                    {
                        ["name"] = "",
                        ["value"] = "**"..Locale.DISCORD_USER..":** <@" ..discordId..">",
                    })
            end
        end
        PerformHttpRequest(WEBHOOK_URL, function(err, text, headers) end, 'POST', json.encode({username = "RCore Gangs", embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end