CreateThread(function()
    if Config.Framework == Framework.QBOX then
        local QBox = nil
    
        local success = pcall(function()
            QBox = exports['qb-core']:GetCoreObject()
        end)

        Framework.object = QBox

        
        NetworkService.EventListener('heartbeat', function(eventType, data)
            if not next(data) then
                return
            end
        
            local prisoner = data.prisoner
        
            if not prisoner then
                return
            end

            local playerId = prisoner.source
            local jailTime = prisoner.jail_time
        
            if eventType == HEARTBEAT_EVENTS.PRISONER_NEW then
                local applyState, applyRetval = pcall(function()
                    return Framework.applyJailMetaData(playerId, jailTime)
                end)
            elseif eventType == HEARTBEAT_EVENTS.PRISONER_RELEASED then
                local applyState, applyRetval = pcall(function()
                    return Framework.removeJailMetaData(playerId)
                end)
            end
        end)

        function Framework.getPlayer(client)
            if not client then
                return nil
            end

            return exports.qbx_core:GetPlayer(client)
        end

        function Framework.canStartPrisonBreak()
            local retval = false
            local officers = exports.qbx_core:GetDutyCountType('leo')

            if type(officers) == "table" then
                if Config.Escape.PoliceCheck then
                    if officers and next(officers) then
                        local size = #officers

                        if not size or size == 0 then
                            size = table.size(officers)
                        end

                        if size and size >= Config.Escape.RequiredPolice then
                            retval = true
                            dbg.debug('Can start prison break: %s', officers)
                        else
                            dbg.debug('Cannot start prison break not enough officers: %s', officers)
                        end
                    end
                else
                    retval = true
                end
            elseif type(officers) == "number" then
                if Config.Escape.PoliceCheck then
                    if officers >= Config.Escape.RequiredPolice then
                        retval = true
                        dbg.debug('Can start prison break: %s', officers)
                    else
                        dbg.debug('Cannot start prison break not enough officers: %s', officers)
                    end
                else
                    retval = true
                end
            end

            return retval
        end

        function Framework.getPlayerCuffState(client)
            local player = Framework.getPlayer(client)

            if not player then
                return false
            end

            local retval = false
            
            if player.PlayerData.metadata['ishandcuffed'] then
                retval = player.PlayerData.metadata['ishandcuffed']
            end

            return retval
        end

        function Framework.getMoney(client)
            local player = Framework.getPlayer(client)

            if not player then
                return 0
            end

            return player.Functions.GetMoney("cash")
        end


        function Framework.addMoney(client, amount)
            local player = Framework.getPlayer(client)

            if not player then
                return 0
            end

            return player.Functions.AddMoney("cash", amount)
        end

        function Framework.removeMoney(client, amount)
            local player = Framework.getPlayer(client)

            if not player then
                return 0
            end

            player.Functions.RemoveMoney("cash", amount)
        end

        function Framework.canPerformJobCommand(client, commandName)
            local job = Framework.getJob(client)
            
            if job == nil then return false, false end
    
            local jobName = job.name
            local jobGrade = job.grade
            local gradeName = job.gradeName:lower()
            
            if jobName == nil then return false end
            
            if Config.RestrictCommands and Config.RestrictCommands.Enable and commandName and next(Config.RestrictCommands.ListGrades[commandName]) then
                if Config.RestrictCommands.UseGradeNumbers and jobGrade ~= nil then
                    if jobGrade >= Config.RestrictCommands.GradeNumber then
                        return true, true
                    else
                        return false, _U('PERMISSION.NOT_ENOUGH_RANK')
                    end
                else
                    local hasPermission = Config.RestrictCommands.ListGrades[commandName][gradeName]

                    if not hasPermission then
                        return false, _U('PERMISSION.NOT_ENOUGH_RANK')
                    else
                        return true, true
                    end
                end
            end

            if Config.AllowAdminGroupsUseJailCommands and Framework.isAdmin(client) then
                return true, true
            end
    
            if Config.Jobs[jobName] then
                return true, true
            end
            
            return false, false
        end
    
        function Framework.getCharacterShortName(client)
            local player = Framework.getPlayer(client)
            if player == nil then return nil end
    
            local firstname = player.PlayerData.charinfo.firstname
            local lastname = player.PlayerData.charinfo.lastname
    
            local shortName = firstname or lastname
    
            return shortName
        end
    
        function Framework.getIdentifier(client)
            local player = Framework.getPlayer(client)
            if player == nil then return nil end


            return tostring(player.PlayerData.citizenid)
        end
    
        function Framework.getJob(client)
            local player = Framework.getPlayer(client)
            if player == nil then return nil end
    
            return {
                name = player.PlayerData.job.name,
                gradeName = player.PlayerData.job.grade.name,
                grade = player.PlayerData.job.grade.level,
                onDuty = player.PlayerData.job.onduty,
                isBoss = player.PlayerData.job.isboss
            }
        end
    
        function Framework.getCharacterName(client)
            local player = Framework.getPlayer(client)
            if player == nil then return nil end
    
            local firstname = player.PlayerData.charinfo.firstname
            local lastname = player.PlayerData.charinfo.lastname
    
            return string.format('%s %s', firstname, lastname)
        end
    
        function Framework.sendNotification(client, message, type)
            TriggerClientEvent('QBCore:Notify', tonumber(client), message, type, 5000)
        end
    
        function Framework.isAdmin(client)
            for _, adminGroup in ipairs(Config.FrameworkAdminGroups[Config.Framework]) do
                if QBox.Functions.HasPermission(client, adminGroup) then
                    return true
                end
            end
    
            return false
        end

        function Framework.removeJailMetaData(client)
    
        end

        function Framework.applyJailMetaData(client, jailTime)
          
        end

        function LoadOfficers()
            local players = GetPlayers()
            local retval = {}

            for playerId, v in pairs(players) do
                local job = Framework.getJob(playerId)

                if not job then
                    return
                end

                local jobName = job.name

                if Config.Jobs[jobName] then
                    dbg.debug("GetOfficers: Adding player with ID: %s that has job named: %s", playerId, jobName)
                    retval[#retval + 1] = playerId
                end
            end
            
            return retval
        end

        function Framework.getOfficers()
            local officers = LoadOfficers()

            if isResourcePresentProvideless(THIRD_PARTY_RESOURCE.WASABI_POLICE) then
                return exports.wasabi_police:getPoliceOnline(), officers
            end

            return officers
        end

        function Framework.setJob(client, jobName)
            local player = Framework.getPlayer(client)

            if not player then
                return nil
            end

            if not jobName then
                jobName = 'unemployed'
            end

            player.Functions.SetJob(jobName)

            dbg.debug("Framework.setJob: Setting citizen %s (%s) to job named: %s", GetPlayerName(client), client, jobName)
        end

        --- @return boolean
        function Framework.clearInventory(client)
            local player = Framework.getPlayer(client)

            if player == nil then 
                return nil 
            end

            local p = promise.new()
            local clearMain, clearMainErr = pcall(function()
                return player.Functions.ClearInventory(Inventory.KeepSessionItems)
            end)
            
            local state = false

            if clearMain then
                state = true
                p:resolve(state)
            else
                local backClear, backClearErr = pcall(player.Functions.SetPlayerData, "items", {})

                if backClear then
                    state = true
                    p:resolve(state)
                else
                    p:resolve(state)
                end
            end

            dbg.debugInventory("Framework.clearInventory: For citizen %s (%s) with state: %s", GetPlayerName(client), client, state)

            Citizen.Await(p)

            return state
        end
            
        RegisterNetEvent('rcore_prison:bridge:playerLoaded', function()
            local client = source

            if not client then
                return
            end

            local playerJob = Framework.getJob(client)

            if playerJob then
                SetTimeout(1000, function()
                    TriggerClientEvent('rcore_prison:client:playerLoaded', client, playerJob)
                end)
            end

            if PrisonService.CheckForAnySentence(client) then
                local mePed = GetPlayerPed(client)
                local meCoords = GetEntityCoords(mePed)

                local prisonYard = vec3(SH.data.prisonYard.x, SH.data.prisonYard.y, SH.data.prisonYard.z)

                local dist = #(prisonYard - meCoords)

                if dist >= 100 then
                    if SH.data.prisonYard then
                        local coords = vec3(SH.data.prisonYard.x, SH.data.prisonYard.y, SH.data.prisonYard.z)

                        if coords then
                            StartClient(client, 'teleportUser', coords)
                        end
                    end

                    dbg.debug("Prisoner: Teleporting citizen %s (%s) to prison yard, spawned outside of Prison!",
                        GetPlayerName(client), client)
                end
            end

            TriggerEvent('rcore_prison:server:playerLoaded', client)
        end)
    

        AddEventHandler('QBCore:Server:OnPlayerUnload', function(playerId)
            TriggerEvent('rcore_prison:server:playerUnloaded', playerId)
        end)

        AddEventHandler('playerDropped', function()
            local playerId = source
        
            if playerId then
                TriggerEvent('rcore_prison:server:playerUnloaded', playerId)
            end
        end)

        SetTimeout(2000, function()
            Inventory.CheckItemExistList(PRISON_ITEMS)
        end)
    end    
end, "sv-qbox code name: Phoenix")