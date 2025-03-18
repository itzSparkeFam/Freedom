if Config.Framework ~= "qbx" then return end

function AddItem(source, item, amount, slot, info)
    exports["ox_inventory"]:AddItem(source, item, amount, info, slot)
end

function RemoveItem(source, item, amount, slot)
    exports["ox_inventory"]:RemoveItem(source, item, amount, nil, slot)
end

function SetItemMetadata(src, item, metadata)
    exports["ox_inventory"]:SetMetadata(src, item.slot, metadata)
end

function GetitemMetadata(item)
    --return item.info --qb-inventory
    return item.metadata --ox_inventory
end

function MakeCitationUseable()
    exports["qbx_core"]:CreateUseableItem("citation", function(source, item)
        UseCitation(source, item)
    end)
end

function MakeCitationRollUseable()
    exports["qbx_core"]:CreateUseableItem("citation_roll", function(source, item)
        src = source
        UseCitationRoll(source, item)
    end)
end

function CreateControlPanelCommand()
    if Config.PoliceMenuCommand ~= "" then

        lib.addCommand(Config.PoliceMenuCommand, {
            help = "Open Citation Control Panel",
            params = {},
            restricted = ''
        }, function(source, args)
            ExecuteControlPanelCommand(source)
        end)
    end
end

function GetPlayerCitizenid(src)
    return exports["qbx_core"]:GetPlayer(src).PlayerData.citizenid
end

function GetPlayerJobName(src)
    return exports["qbx_core"]:GetPlayer(src).PlayerData.job.name
end

function GetPlayerItems(source)
    return exports["qbx_core"]:GetPlayer(source).PlayerData.items
end

function GetPlayerMoney(src, moneyType)
    return exports["qbx_core"]:GetPlayer(src).PlayerData.money[moneyType]
end

function GetFullPlayerName(citizenid)
    local player = exports["qbx_core"]:GetPlayerByCitizenId(citizenid)
    if not player then player = exports["qbx_core"]:GetOfflinePlayerByCitizenId(citizenid) end
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

local StringCharset = {}
local NumberCharset = {}

for i = 48, 57 do NumberCharset[#NumberCharset + 1] = string.char(i) end
for i = 65, 90 do StringCharset[#StringCharset + 1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset + 1] = string.char(i) end

function RandomStr(length)
    if length <= 0 then return '' end
    return RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

function RandomInt(length)
    if length <= 0 then return '' end
    return RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end