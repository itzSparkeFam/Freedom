Notify = {}

Notify.Standalone = function(message)
    local icon = "CHAR_DEFAULT"
    local type = 1
    local text = message
    local title = _U('NOTIFY.TITLE') or ""
    local subTitle = ""

    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetTextFont(1)
    SetNotificationMessage(icon, icon, true, type, title, subTitle)
    DrawNotification(false, true)
end

CreateThread(function()
    if lib and Config.Notifies == Notifies.OX and isResourceLoaded(Notifies.OX) then
        Framework.sendNotification = function(message, type)
            lib.notify({
                title = _U('NOTIFY.TITLE'),
                description = message,
                type = type
            })
        end
    end

    if Config.Notifies == Notifies.NATIVE then
        Framework.sendNotification = function(message)
			Notify.Standalone(message)
        end
    end

    if Config.Notifies == Notifies.NONE or Config.Notifies == Notifies.AUTO_DETECT then
        if Config.Framework == Framework.ESX then
            return 
        end

        if Config.Framework == Framework.QBCore then
            return
        end

        Framework.sendNotification = function(message)
			Notify.Standalone(message)
        end
    end

    if Config.Notifies == Notifies.BRUTAL then
        Framework.sendNotification = function(message, type)
			exports[Notifies.BRUTAL]:SendAlert(_U('NOTIFY.TITLE'), message, 5500, type)
        end
    end

    if Config.Notifies == Notifies.PNOTIFY then
        Framework.sendNotification = function(message, type)
            exports[Notifies.PNOTIFY]:SendNotification({
                text = ('%s %s'):format(_U('NOTIFY.TITLE'), message),
                type = type,
                timeout = math.random(5000, 6000),
                layout = "centerLeft",
                queue = "left"
            })
        end
    end
end, "cl-main code name: Omega")
