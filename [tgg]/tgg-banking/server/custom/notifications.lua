function SendPhoneNotification(playerId, notificationTitle, notificationText)
    if Config.Phone == 'yseries' then
        exports.yseries:SendNotification({
            app = 'ypay',
            title = notificationTitle,
            text = notificationText,
            timeout = 3500,                                                              -- Default is 3000(optional).
            icon = 'https://r2.fivemanage.com/tQ3N61asBhnHrsT4FJakP/images/1138038.png', -- Default is the app icon, if you want custom don't send app(optional).
        }, 'source', playerId)
    end
end

function Notify(playerId, msg, type, duration)
    if not playerId then return end

    lib.notify(playerId, {
        description = msg,
        duration = duration,
        type = type,
    })
end
