local TRAVERSE_MAP_POSITION = {
    ['right'] = 'right-center',
    ['left'] = 'left-center',
    ['top'] = 'top-center'
}

TextService = {}

CreateThread(function()
    TextService.Hide()
end, "cl-main code name: Bravo")

NetworkService.EventListener('heartbeat', function(eventType, data)
    if eventType ~= 'PRISONER_RELEASED' then
        return
    end

    TextService.Hide()
end)

TextService.Render = function(jailTime)
    if Config.TextUI == TextUI.NONE then
        Text.Show(jailTime, Config.Text.Position:lower()) -- RCore Prison custom TextUI
    elseif Config.TextUI == TextUI.OX then
        if not lib then
            Text.Show(jailTime)
            return dbg.debug('TextService.Render: ox_lib is not hooked with rcore_prison, loading prison default text UI.')
        end 
    
        if Config.Text.Position:lower() == 'bottom-right' then
            Config.Text.Position = 'right-center'
        end

        lib.showTextUI(jailTime, {
            position = Config.Text.Position:lower(),
        })
    elseif Config.TextUI == TextUI.QBCORE then
        if THIRD_PARTY_RESOURCE.MOV_HUD and isResourceLoaded(THIRD_PARTY_RESOURCE.MOV_HUD) then
            Text.Show(jailTime, Config.Text.Position:lower())
            return
        end

        exports['qb-core']:DrawText(jailTime, 'left')
    elseif Config.TextUI == TextUI.ESX then
        if THIRD_PARTY_RESOURCE.MOV_HUD and isResourceLoaded(THIRD_PARTY_RESOURCE.MOV_HUD) then
            Text.Show(jailTime, Config.Text.Position:lower())
            return
        end

        exports['esx_textui']:TextUI(jailTime)
    elseif Config.TextUI == TextUI.OKOK then
        Text.Show(jailTime, Config.Text.Position:lower()) 
    else
        Text.Show(jailTime, Config.Text.Position:lower())
    end
end

TextService.Hide = function()
    if Config.TextUI == TextUI.NONE then
        Text.Hide()
    elseif Config.TextUI == TextUI.OX then
        if not lib then
            Text.Hide()
            return dbg.debug('TextService.Render: ox_lib is not hooked with rcore_prison, loading prison default text UI.')
        end 
    
        lib.hideTextUI()
    elseif Config.TextUI == TextUI.QBCORE then
        if THIRD_PARTY_RESOURCE.MOV_HUD and isResourceLoaded(THIRD_PARTY_RESOURCE.MOV_HUD) then
            exports["17mov_Hud"]:HideHelpNotification()
            return
        end

        exports['qb-core']:HideText()
    elseif Config.TextUI == TextUI.ESX then
        exports['esx_textui']:HideUI()
    elseif Config.TextUI == TextUI.OKOK then
        exports['okokTextUI']:Close()
    end
end
