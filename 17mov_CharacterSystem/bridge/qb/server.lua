if Config.Framework ~= "QBCore" then return end
if not Skin.Enabled then return end

RegisterServerEvent("qb-clothing:saveSkin", function(model, skin)
    local src = source
    local Player = Core?.Functions.GetPlayer(src)
    if Player and skin ~= nil then
        local p = promise.new()

        if skin.model ~= nil then
            model = skin.model
        end

        if model == nil then
            ---@diagnostic disable-next-line: undefined-global
            MySQL.query('SELECT model FROM playerskins WHERE citizenid = ? LIMIT 1', { Player.PlayerData.citizenid }, function(result)
                if result and #result > 0 then
                    model = result[1].model
                end
                p:resolve()
            end)
        else
            p:resolve()
        end

        Citizen.Await(p)

        ---@diagnostic disable-next-line: undefined-global
        MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid }, function()
            ---@diagnostic disable-next-line: undefined-global
            MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
                Player.PlayerData.citizenid,
                TranslateHashToString(model),
                json.encode(skin),
                1
            })
        end)
    end
end);

Core?.Functions.CreateCallback('qb-clothing:server:getOutfits', function(src, cb)
    local Player = Core?.Functions.GetPlayer(src)
    local outfits = {}

    ---@diagnostic disable-next-line: undefined-global
    local result = MySQL.query.await('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
    if result[1] ~= nil then
        for k, v in pairs(result) do
            if result[k].skin then
                result[k].skin = json.decode(result[k].skin)
                outfits[k] = v
            else
                if result[k].components then
                    result[k].components = json.decode(result[k].components)
                    for k,v in pairs(result[k].components) do
                        if v.component_id then
                            v.component = v.component_id
                            v.variation = v.texture
                            v.component_id = nil
                        end
                    end

                    result[k].props = json.decode(result[k].props)
                    for k,v in pairs (result[k].props) do
                        if v.prop_id then
                            v.prop = v.prop_id
                            v.variation = v.texture
                            v.prop_id = nil
                        end
                    end
                end
                result[k].skin = {
                    components = result[k].components,
                    props = result[k].props
                }

                result[k].skin = TranslateSkinToQB(result[k].skin)
                outfits[k] = v
            end
        end
    end

    cb(outfits)
end)

RegisterServerEvent("qb-clothes:saveOutfit", function(outfitName, model, skinData, rawSkin)
    local src = source
    local Player = Core?.Functions.GetPlayer(src)
    if model ~= nil and skinData ~= nil then
        ---@diagnostic disable-next-line: undefined-global
        local columnExists = false
        local success, result = pcall(function()
            ---@diagnostic disable-next-line: undefined-global
            return MySQL.query.await('SELECT skin FROM player_outfits LIMIT 1')
        end)

        if success and result then
            columnExists = true
        end

        if not columnExists then
            -- ILLENIUM APPEARANCE HAS DIFFERENT DATA FORMAT
            ---@diagnostic disable-next-line: undefined-global

            MySQL.insert.await("INSERT INTO player_outfits (citizenid, outfitname, model, components, props) VALUES (?, ?, ?, ?, ?)", {
                Player.PlayerData.citizenid,
                outfitName,
                TranslateHashToString(model),
                json.encode(rawSkin.components),
                json.encode(rawSkin.props),
            })
        else
            local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
            ---@diagnostic disable-next-line: undefined-global
            MySQL.insert('INSERT INTO player_outfits (citizenid, outfitname, model, skin, outfitId) VALUES (?, ?, ?, ?, ?)', {
                Player.PlayerData.citizenid,
                outfitName,
                TranslateHashToString(model),
                json.encode(skinData),
                outfitId
            }, function()
                ---@diagnostic disable-next-line: undefined-global
                local result = MySQL.query.await('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
                if result[1] ~= nil then
                    TriggerClientEvent('qb-clothing:client:reloadOutfits', src, result)
                else
                    TriggerClientEvent('qb-clothing:client:reloadOutfits', src, nil)
                end
            end)
        end
    end
end)

RegisterServerEvent("qb-clothing:server:removeOutfit", function(outfitName, outfitId)
    if type(outfitName) == "table" then
        outfitId = outfitName.id
        outfitName = outfitName.name
    end

    local src = source
    local Player = Core?.Functions.GetPlayer(src)
    ---@diagnostic disable-next-line: undefined-global
    MySQL.query('DELETE FROM player_outfits WHERE citizenid = ? AND outfitname = ?', {
        Player.PlayerData.citizenid,
        outfitName,
    }, function()
        ---@diagnostic disable-next-line: undefined-global
        local result = MySQL.query.await('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
        if result[1] ~= nil then
            TriggerClientEvent('qb-clothing:client:reloadOutfits', src, result)
        else
            TriggerClientEvent('qb-clothing:client:reloadOutfits', src, nil)
        end
    end)
end)

RegisterServerEvent("qb-clothes:loadPlayerSkin", function()
    local src = source
    local Player = Core?.Functions.GetPlayer(src)
    ---@diagnostic disable-next-line: undefined-global
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    local skinData = {}
    if result[1] ~= nil then
        local model = result[1].model
        if model then
            model = tonumber(model) or model
        end
        local decoded = json.decode(result[1].skin)
        if decoded.components then
            skinData = TranslateSkinToQB(TranslateSkinFromIllenium(decoded, model))
        else
            skinData = decoded
        end
        TriggerClientEvent("qb-clothes:loadSkin", src, false, result[1].model, skinData)
    else
        TriggerClientEvent("qb-clothes:loadSkin", src, true)
    end
end);

Core?.Functions.CreateCallback('qb-clothing:server:getPlayerSkin', function(src, cb)
    local Player = Core?.Functions.GetPlayer(src)
    ---@diagnostic disable-next-line: undefined-global
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    if result[1] ~= nil then
        local decoded = json.decode(result[1].skin)
        local model = result[1].model
        if model then
            model = tonumber(model) or model
        end
        local skinData
        if decoded.components then
            skinData = TranslateSkinToQB(TranslateSkinFromIllenium(decoded, model))
        end

        local skin = {
            skin = skinData or decoded,
            model = model
        }

        cb(skin)
    else
        local skin = {
            skin = GenerateRandomSkin("male"),
            model = `mp_m_freemode_01`,
        }
        cb(skin)
    end
end);

if Skin.Enabled then
    Core?.Commands.Add('skin', _L("Bridge.Command.Skin"), {}, false, function(source, args)
        local src = source

        if args[1] then
            local Player = Core?.Functions.GetPlayer(tonumber(args[1]))

            if Player then
                TriggerClientEvent('qb-clothing:client:openMenuCommand', Player.PlayerData.source)
            else
                TriggerClientEvent('QBCore:Notify', src, _L('Commands.Skin.PlayerNotOnline'), 'error')
            end
        else
            TriggerClientEvent('qb-clothing:client:openMenuCommand', src)
        end
    end, 'admin');

    Core?.Commands.Add('skinmenu', _L("Bridge.Command.Skin"), {}, false, function(source, args)
        local src = source

        if args[1] then
            local Player = Core?.Functions.GetPlayer(tonumber(args[1]))

            if Player then
                TriggerClientEvent('qb-clothing:client:openMenuCommand', Player.PlayerData.source)
            else
                TriggerClientEvent('QBCore:Notify', src, _L('Commands.Skin.PlayerNotOnline'), 'error')
            end
        else
            TriggerClientEvent('qb-clothing:client:openMenuCommand', src)
        end
    end, 'admin');
end