if Config.Framework ~= "ESX" then return end
if not Skin.Enabled then return end

Config.BackpackWeight = {
    [40] = 16,
    [41] = 20,
    [44] = 25,
    [45] = 23,
}

-- esx_skin
RegisterServerEvent("esx_skin:save")
AddEventHandler("esx_skin:save", function(skin)
    local src = source
    local xPlayer = Core?.GetPlayerFromId(src)

    if not Core?.GetConfig()?.OxInventory then
        local defaultMaxWeight = Core?.GetConfig().MaxWeight
        local backpackModifier = Config.BackpackWeight[skin.bags_1]

        if backpackModifier then
            xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
        else
            xPlayer.setMaxWeight(defaultMaxWeight)
        end
    end

    ---@diagnostic disable-next-line: undefined-global
    MySQL.update("UPDATE users SET skin = @skin WHERE identifier = @identifier", {
        ["@skin"] = json.encode(skin),
        ["@identifier"] = xPlayer.identifier,
    })

    if IlleniumActive then
        local skin = TranslateSkinToIllenium(TranslateSkinFromESX(skin, skin.model))
        ---@diagnostic disable-next-line: undefined-global
        MySQL.update("UPDATE playerskins SET skin = @skin, model = @model WHERE citizenid = @citizenid", {
            ["@skin"] = json.encode(skin),
            ["@model"] = TranslateHashToString(skin.model),
            ["@citizenid"] = xPlayer.identifier,
        })
        IlleniumSkins[xPlayer.identifier] = {
            skin = skin,
            model = TranslateHashToString(skin.model)
        }
    end
end)

RegisterServerEvent("esx_skin:setWeight")
AddEventHandler("esx_skin:setWeight", function(skin)
    local src = source
    local xPlayer = Core?.GetPlayerFromId(src)

    if not Core?.GetConfig().OxInventory then
        local defaultMaxWeight = Core?.GetConfig().MaxWeight
        local backpackModifier = Config.BackpackWeight[skin.bags_1]

        if backpackModifier then
            xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
        else
            xPlayer.setMaxWeight(defaultMaxWeight)
        end
    end
end);

Core?.RegisterServerCallback("esx_skin:getPlayerSkin", function(source, cb)
    local xPlayer = Core?.GetPlayerFromId(source)

    if IlleniumActive then
        local skinData = TranslateSkinToESX(TranslateSkinFromIllenium(IlleniumSkins[xPlayer.identifier]?.skin, IlleniumSkins[xPlayer.identifier]?.model))
        cb(skinData)
    else
        ---@diagnostic disable-next-line: undefined-global
        MySQL.query("SELECT skin FROM users WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
        }, function(users)
            local skin = nil
            local user = users[1]
            local jobSkin = {
                skin_male = xPlayer.job.skin_male,
                skin_female = xPlayer.job.skin_female,
            }

            if user.skin then
                skin = json.decode(user.skin)
                if skin.components then
                    skin = TranslateSkinToESX(TranslateSkinFromIllenium(skin, skin.model or xPlayer.variables.sex == "m" and `mp_m_freemode_01` or xPlayer.variables.sex == 0 and `mp_m_freemode_01` or `mp_f_freemode_01`))
                end
                skin.sex = xPlayer.variables.sex == "m" and 0 or xPlayer.variables.sex == 0 and 0 or 1
            end

            cb(skin, jobSkin)
        end)
    end

end);

if Skin.Enabled then
    Core?.RegisterCommand({'skin', 'skinmenu'}, 'admin', function(xPlayer, args, showError)
        if not args.targetId then args.targetId = xPlayer.source end
        if args.targetId then
            local targetPlayer = Core?.GetPlayerFromId(tonumber(args.targetId))
            if targetPlayer then
                targetPlayer.triggerEvent("esx_skin:openSaveableMenu")
                xPlayer.showNotification(_L("Commands.Skin.SkinMenuOpened"))
            else
                xPlayer.showNotification(_L("Commands.Skin.PlayerNotOnline"))
            end
        else
            xPlayer.triggerEvent("esx_skin:openSaveableMenu")
        end
    end, false, {help = _L('Bridge.Command.Skin'), arguments = {{name = 'targetId', help = _L('Bridge.Command.SkinId'), type = 'any'}}})
end

Functions.RegisterServerCallback("17mov_CharacterSystem:CheckForIlleniumSkin", function(source)
    local xPlayer = Core?.GetPlayerFromId(source)
    if xPlayer.identifier and IlleniumSkins[xPlayer.identifier] then
        return IlleniumSkins[xPlayer.identifier].skin
    else
        return nil
    end
end)

Functions.RegisterServerCallback("17mov_CharacterSystem:FetchOutifts", function(source)
    local outfits = {}
    local xPlayer = Core?.GetPlayerFromId(source)
    if Config.Framework == "ESX" then
        if IlleniumActive then
            ---@diagnostic disable-next-line: undefined-global
            local result = MySQL.query.await('SELECT * FROM player_outfits WHERE citizenid = ?', { xPlayer.identifier })
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
                            result[k].skin = {
                                components = result[k].components,
                                props = result[k].props
                            }

                            result[k].components = nil
                            result[k].props = nil
                        end

                        result[k].outfit_name = result[k].outfitname
                        result[k].outfitname = nil
                        table.insert(outfits, v)
                    end
                end
            end
        end

        local xPlayer = Core?.GetPlayerFromId(source)
        local result = MySQL.query.await('SELECT * FROM 17mov_character_outfits WHERE identifier = ?', { xPlayer.identifier })
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local decoded = json.decode(result[k].outfit)
                result[k].skin = TranslateSkinFromESX(decoded)
                result[k].outfit = nil
                table.insert(outfits, v)
            end
        end
    end

    return outfits
end)

RegisterNetEvent("17mov_CharacterSystem:Deleteoufit", function(name)
    if Config.Framework == "ESX" then
        local xPlayer = Core?.GetPlayerFromId(source);
        if IlleniumActive then
            ---@diagnostic disable-next-line: undefined-global
            MySQL?.query.await('DELETE FROM player_outfits WHERE citizenid = ? AND outfitname = ?', { xPlayer.identifier, name});
        end

        ---@diagnostic disable-next-line: undefined-global
        MySQL?.query.await('DELETE FROM 17mov_character_outfits WHERE identifier = ? AND outfit_name = ?', { xPlayer.identifier, name});
    end
end)

RegisterNetEvent("17mov_CharacterSystem:SaveOutfit", function(skin, name)
    if Config.Framework == "ESX" then
        local xPlayer = Core?.GetPlayerFromId(source);
        local outfits = MySQL?.single.await('SELECT COUNT(*) as count FROM 17mov_character_outfits WHERE identifier = ? AND outfit_name = ?', { xPlayer.identifier, name });

        if outfits and outfits.count > 0 then
            xPlayer.showNotification(_L("Bridge.Wardrobe.AlreadyExists"))
        end

        MySQL?.query.await('INSERT INTO 17mov_character_outfits (identifier, outfit, outfit_name) VALUES (?, ?, ?)', { xPlayer.identifier, json.encode(skin), name})
    end
end)