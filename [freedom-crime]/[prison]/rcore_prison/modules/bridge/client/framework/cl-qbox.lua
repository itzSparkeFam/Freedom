CreateThread(function()
    if Config.Framework == Framework.QBOX then
        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            TriggerServerEvent('rcore_prison:bridge:playerLoaded')
        end)

        local QBox = nil
    
        local success = pcall(function()
            QBox = exports['qb-core']:GetCoreObject()
        end)

        Framework.object = QBox

        function HandleInventoryOpenState(state)
            local ply = LocalPlayer
        
            if not ply then
                return
            end
        
            ply.state:set('inv_busy', state)
        end

        function Framework.showHelpNotification(text)
            DisplayHelpTextThisFrame(text, false)
            BeginTextCommandDisplayHelp(text)
            EndTextCommandDisplayHelp(0, false, false, -1)
        end
    
        function Framework.sendNotification(message, type)
            TriggerEvent('QBCore:Notify', message, type, 5000)
        end
        

        function Framework.isInJob()
            if Framework.job and Config.Jobs[Framework.job.name] then
                return true
            end

            return false
        end

        RegisterNetEvent('rcore_prison:client:playerLoaded')
        AddEventHandler('rcore_prison:client:playerLoaded', function(jobData)
            dbg.debug('Framework - job: Updating player job data [customEvent]')
            Framework.setJob({
                name = jobData.name,
                gradeName = jobData.grade,
                grade = jobData.grade,
                isOnDuty = jobData.onDuty,
                isBoss = jobData.isBoss
            })
        end)

        RegisterNetEvent(Config.FrameworkEvents['QBCore:Client:OnJobUpdate'])
        AddEventHandler(Config.FrameworkEvents['QBCore:Client:OnJobUpdate'], function(updatedJobData)
            dbg.debug('Framework - job: Updating player job data!')
            Framework.setJob({
                name = updatedJobData.name,
                gradeName = updatedJobData.grade.name,
                grade = updatedJobData.grade.level,
                isOnDuty = updatedJobData.onduty,
                isBoss = updatedJobData.isboss
            })
        end)

        SetTimeout(1000, function()
            if not Framework.object then
                return
            end

            local success, result = pcall(function()
                return Framework.object.Functions.GetPlayerData() and Framework.object.Functions.GetPlayerData().job
            end)

            if result and success then
                dbg.debug('Framework - job: Setting player job data on init!')
                Framework.setJob({
                    name = result.name,
                    gradeName = result.grade.name,
                    grade = result.grade.level,
                    isOnDuty = result.onduty,
                    isBoss = result.isboss
                })
            end
        end)

        function Framework.setJob(job)
            Framework.job = job
        end
    end    
end, "cl-qbox code name: Phoenix")