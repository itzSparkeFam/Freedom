local function handleNuiMessage(table)
    SendNUIMessage(table)
end

local function showTextUI(textUis)
    if type(textUis) ~= 'table' then
        print('Expected table, got', type(textUis))
        return
    end
    for k, v in pairs(textUis) do
        if v.id ~= nil and (v.key ~= nil or v.icon ~= nil) and v.message ~= nil then
            handleNuiMessage({
                type = 'showTextUI',
                id = v.id,
                key = v.key,
                icon = v.icon,
                message = v.message
            })
        end
    end
end

local function hideTextUI(table)
    if type(table) == 'table' then
        for _, index in pairs(table) do
            print(index)
            handleNuiMessage({
                type = 'hideTextUI',
                id = index
            })
        end
    else
        handleNuiMessage({
            type = 'hideTextUI',
            id = table
        })
    end
end

local function fetchTextUIs()
    local ids = nil
    local timeout = 5000
    local startTime = GetGameTimer()

    handleNuiMessage({ type = 'getTextUIs' })

    RegisterNuiCallback('returnTextUIs', function(uiId, cb)
        if type(uiId) == 'table' then
            if next(uiId) == nil then
                ids = false
            else
                ids = uiId
            end
            cb(true)
        else
            print('Expected table, got', type(uiId))
            cb(false)
        end
    end)
    while ids == nil do
        Wait(0)
        if GetGameTimer() - startTime > timeout then
            print('Fetch timeout')
            return false
        end
    end
    return ids
end

exports('showTextUI', showTextUI)
exports('hideTextUI', hideTextUI)
exports('getTextUIs', fetchTextUIs)
