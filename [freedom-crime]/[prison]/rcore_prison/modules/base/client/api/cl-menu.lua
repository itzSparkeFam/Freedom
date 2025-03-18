local PositionTraverse = {
    ['top-right'] = 'right',
    ['top-left'] = 'left',
}

function RenderESXMenu(esxListArray, currentName, currentLabel)
    Framework.object.UI.Menu.Open('default', GetCurrentResourceName(), currentName:lower(), {
        title    = c(currentLabel),
        align    = Config.Menu.Position,
        elements = esxListArray.options,
    }, function(data, menu)
        if data.current and data.current.serverEvent then
            TriggerServerEvent(data.current.serverEvent, data.current.args) 
        elseif data.current and data.current.event and data.current.args then
            TriggerEvent(data.current.event, data.current.args)
        end

        menu.close()
        currentName = nil
    end, function(data, menu) -- ON BACKSPACE CANCEL -> CLOSE
        menu.close()
        currentName = nil
    end)
end

function RenderESXContext(esxListArray, currentName, currentLabel)
    exports["esx_context"]:Open(PositionTraverse[Config.Menu.Position] or "right", esxListArray.options, function(menu, current)
        if current and current.serverEvent then
            TriggerServerEvent(current.serverEvent, current.args)
        elseif current and current.event and current.args then
            TriggerEvent(current.event, current.args)
        end

        exports["esx_context"]:Close()

        currentName = nil
    end)
end
