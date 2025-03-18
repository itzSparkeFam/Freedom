CreateThread(function()
    if Config.Framework == Framework.NDCore then
        function Framework.getIdentifier(client)
            local player = Framework.getPlayer(client)
    
            if not player then
                return nil
            end
    
            local identifiers = player.identifiers
    
            if not identifiers then
                return nil
            end
    
            return identifiers['discord'] or identifiers['license'] or identifiers['license2'] 
        end
    

        function Framework.canStartPrisonBreak()
            local retval = false
            local officers = Framework.getOfficers()

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

        function Framework.getJob(client)
            local retval =  {
                name = 'unemployed',
                label = 'Unemployed',
                gradeName = 'None',
                grade = 1
            }

            if Ace.Can(client, Permissions.CAN_USE_JOB_COMMANDS) then
                retval =  {
                    name = 'police',
                    label = 'Police',
                    gradeName = 'Officer',
                    grade = 1
                }
            end
    
            return retval
        end
    
            
        function Framework.getPlayer(client)
            return NDCore.getPlayer(client) or {}
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
    
            local firstname = player.firstname
            local lastname = player.lastname
    
            local shortName = firstname or lastname
    
            return shortName
        end
    
    
        function Framework.getCharacterName(client)
            local player = Framework.getPlayer(client)
    
            if not player then
                return 'Unknown'
            end
    
            if player.firstname == nil or player.lastname == nil then
                return 'Unknown'
            end
    
            local name = ('%s %s'):format(player.firstname or 'Unknown', player.lastname or 'Unknown')
    
            return name or GetPlayerName(client)
        end
    
        function Framework.sendNotification(client, message, type)
            TriggerClientEvent('chat:addMessage', client, {
                multiline = true,
                args = { message }
            })
        end
    
        function Framework.isAdmin(client)
            local retval = false

            if Ace.Can(client, Permissions.HAS_SERVER_GROUP) then
                retval = true
            end
    
            return retval
        end
    
        function Framework.getMoney(client)
            local player = Framework.getPlayer(client)
    
            if not player then
                return 0
            end
    
            return player.cash or 0
        end
    
    
        function Framework.addMoney(client, amount)
            local player = Framework.getPlayer(client)
    
            if not player then
                return 0
            end
    
            return player.addMoney("cash", amount, 'prison - addMoney')
        end
    
        function Framework.removeMoney(client, amount)
            local player = Framework.getPlayer(client)
    
            if not player then
                return 0
            end
    
            return player.deductMoney("cash", amount, 'prison - deductMoney')
        end
        
        function LoadOfficers()
            local players = GetPlayers()
            local retval = {}

            for _, playerId in pairs(players) do
                playerId = tonumber(playerId)
                
                local job = Framework.getJob(playerId)

                if job and job.name and Config.Jobs[job.name] then
                    dbg.debug("GetOfficers: Adding player with ID: %s that has job named: %s", playerId, job.name)
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
            dbg.debug('This feature is not defined for NDCore, will not work!')
        end

        RegisterNetEvent('rcore_prison:bridge:standalonePlayerActivated', function()
            local client = source
            TriggerEvent('rcore_prison:server:playerLoaded', client)
        end)
    
        AddEventHandler("ND:characterUnloaded", function(source, character)
            local playerId = source
        
            if playerId then
                TriggerEvent('rcore_prison:server:playerUnloaded', playerId)
            end
        end)

        AddEventHandler('playerDropped', function()
            local playerId = source
        
            if playerId then
                TriggerEvent('rcore_prison:server:playerUnloaded', playerId)
            end
        end)
    end
end, "sv-ndcore code name: Phoenix")
