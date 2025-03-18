if Config.Framework ~= 'standalone' then
    return
end

Framework = {}

CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
            TriggerServerEvent('redutzu-ems:server:onPlayerLoaded')
			return
		end
	end
end)

function Framework.GetPlayerGender()
    local ped = PlayerPedId()
    local isFemale = not IsPedMale(ped)
    return isFemale and Locales['gender:female'] or Locales['gender:male']
end

function Framework.GetPlayerJob()
    local job = nil

    Framework.TriggerCallback('GetPlayerJob', function(job)
        job = job?.name
    end)

    return job
end

function Framework.Notify(message)
    TriggerEvent('chat:addMessage', {
        args = { '[Redutzu-EMS]', message },
        color = { 255, 255, 255 },
        multiline = true
    })
end

local function Callback(name, callback, ...)
    TriggerServerEvent('redutzu-ems:server-callback:' .. name, ...)

    return RegisterNetEvent('redutzu-ems:client-callback:' .. name, function(...)
        callback(...)
    end)
end       

function Framework.TriggerCallback(name, callback, ...)
    local event = false

    local cb = function(...)
        if event ~= false then
            RemoveEventHandler(event)
        end

        callback(...)
    end

    event = Callback(name, cb, ...)

    return event
end

function Framework.RegisterClientCallback(name, callback)
    RegisterNetEvent('redutzu-ems:server-client-callback:' .. name, function(...)
        callback(function(...)
            TriggerServerEvent('redutzu-ems:client-server-callback:' .. name, ...)            
        end, ...)
    end)
end