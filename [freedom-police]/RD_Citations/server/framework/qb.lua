if Config.Framework ~= "qb" then return end

local QB = exports["qb-core"]:GetCoreObject()

function AddMoney(society, money)
    --exports["qb-management"]:AddMoney(society, money) --Old QB
    exports["qb-banking"]:AddMoney(society, money) --Newest QB
end

function AddItem(source, item, amount, slot, info)
    exports["ox_inventory"]:AddItem(source, item, amount, slot, info)
end

function RemoveItem(source, item, amount, slot)
    exports["ox_inventory"]:RemoveItem(source, item, amount, slot)
end

function SetItemMetadata(src, item, metadata)
    local items = GetPlayerItems(src)
    items[item.slot].info = metadata
    QB.Functions.GetPlayer(src).Functions.SetPlayerData("items", items)
end

function GetitemMetadata(item)
   -- return item.info --qb-inventory
    return item.metadata --ox_inventory
end

function MakeCitationUseable()
    QB.Functions.CreateUseableItem("citation", function(source, item)
        UseCitation(source, item)
    end)
end

function MakeCitationRollUseable()
    QB.Functions.CreateUseableItem("citation_roll", function(source, item)
        src = source
        UseCitationRoll(source, item)
    end)
end

function CreateControlPanelCommand()
    if Config.PoliceMenuCommand ~= "" then
        QB.Commands.Add(Config.PoliceMenuCommand, "Open Citation Control Panel", {}, false, function(source)
            ExecuteControlPanelCommand(source)
        end)
    end
end

function GetPlayerCitizenid(src)
    return QB.Functions.GetPlayer(src).PlayerData.citizenid
end

function GetPlayerJobName(src)
    return QB.Functions.GetPlayer(src).PlayerData.job.name
end

function GetPlayerItems(source)
    return QB.Functions.GetPlayer(source).PlayerData.items
end

function GetPlayerMoney(src, moneyType)
    return QB.Functions.GetPlayer(src).PlayerData.money[moneyType]
end

function GetFullPlayerName(citizenid)
    local player = QB.Functions.GetPlayerByCitizenId(citizenid)
    if not player then player = QB.Functions.GetOfflinePlayerByCitizenId(citizenid) end
    if not player then return "", "" end
    local charinfo = player.PlayerData.charinfo
    return charinfo.firstname, charinfo.lastname
end

function PlayerNameSearch(search, searchType)
    local sql = [[
    SELECT JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.firstname')) AS firstname,
           JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.lastname')) AS lastname,
           p.citizenid
    FROM players p
    WHERE LOWER(
      CONCAT(
        JSON_UNQUOTE(JSON_EXTRACT(p.charinfo, '$.]]..searchType..[[name'))
      )
    ) LIKE ?
    ]]
    return MySQL.query.await(sql, { string.lower('%'..search..'%') })
end

function RandomInt(len)
    return QB.Shared.RandomInt(len)
end

function RandomStr(len)
    return QB.Shared.RandomStr(len)
end