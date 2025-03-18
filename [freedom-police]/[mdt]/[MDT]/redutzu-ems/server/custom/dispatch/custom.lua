if Config.Dispatch.Script ~= 'custom' then
    return
end

-- If your dispatch script is client-sided, go to client/custom/dispatch/custom.lua

-- RegisterNetEvent('your_dispatch_event', function()
--     -- You can use the isJobWhitelisted(string | table) helper function to check if the alert should be added to the MDT

--     TriggerEvent('redutzu-ems:server:addDispatchToEMS', {
--         code = '10-14',
--         title = 'Carjacking',
--         street = 'Street name',
--         weapon = 'Assault Rifle (AK47)',
--         gender = 'Male',
--         vehicle = {
--             data.name = 'Infernus',
--             data.plate = 'ABC123',
--             data.doors = 'four door',
--             data.color = 'Dark Blue (Metalic)',
--             data.class = 'Sports'
--         },
--         duration = Config.Dispatch.DefaultAlertDuration, -- in miliseconds
--         coords = {
--             x = 0.0,
--             y = 0.0,
--             z = 0.0
--         }
--     })
-- end)