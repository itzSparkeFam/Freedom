-- Here you can implement your callsign system
-- For example:

-- RegisterNetEvent('updateCallsign', function(callsign)
--     exports['redutzu-mdt']:SetOfficerCallsign(source, callsign)
-- end)

-- RegisterCommand('callsign', function(source, args)
--     if #args == 0 then
--         local callsign = exports['redutzu-mdt']:GetOfficerCallsign(source)
--         TriggerClientEvent('chat:addMessage', source, 'Your callsign is: ' .. callsign)
--     else
--         table.remove(args, 1)
--         local callsign = table.concat(args, " ")
--         exports['redutzu-mdt']:SetOfficerCallsign(source, callsign)
--     end
-- end, false)