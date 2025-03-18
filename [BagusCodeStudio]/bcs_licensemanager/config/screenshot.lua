function GetScreenshot()
    local Promise = promise.new()
    local server, field
    local options = {
        encoding = 'png',
        quality = 0.5,
    }
    if Config.Screenshot == 'fivemanage' or Config.Screenshot == 'fivemerr' or Config.Screenshot == 'GKSMEDIA' then
        options.headers = {
            Authorization = GetConvar('SCREENSHOT_TOKEN', ''),
            ['Content-Type'] = 'application/json'
        }
        if Config.Screenshot == 'fivemanage' then
            options.headers['Content-Type'] = nil
            server = 'https://api.fivemanage.com/api/image'
            field = 'image'
        elseif Config.Screenshot == 'fivemerr' then
            server = 'https://api.fivemerr.com/v1/media/images'
        elseif Config.Screenshot == 'GKSMEDIA' then
            server = 'https://servicemedia.gkshop.org/mediau'
            options.headers['GKSHOP-Secret'] = GetConvar('SCREENSHOT_TOKEN', '')
        end
    elseif Config.Screenshot == 'discord' then
        server = GetConvar('SCREENSHOT_WEBHOOK', '')
        field = 'files'
    elseif Config.Screenshot == 'standalone' then
        server = GetConvar('IMAGE_SERVER', '')
        field = 'file'
    end
    exports['screenshot-basic']:requestScreenshotUpload(server, field, options, function(data)
        if Config.Screenshot == 'fivemanage' or Config.Screenshot == 'fivemerr' or Config.Screenshot == 'GKSMEDIA' then
            local image = json.decode(data)
            if image and image.url then
                Promise:resolve(image.url)
            else
                Promise:resolve(print("HOST UPLOAD ERROR", server))
            end
        elseif Config.Screenshot == 'discord' then
            local image = json.decode(data)
            if image and image.attachments[1].proxy_url then
                Promise:resolve(image.attachments[1].proxy_url)
            else
                Promise:resolve(print("HOST UPLOAD ERROR", server))
            end
        elseif Config.Screenshot == 'standalone' then
            local image = json.decode(data)
            if image and image.filename then
                local link = ('%s/%s'):format(server, image.filename)
                Promise:resolve(link)
            else
                Promise:resolve(print("HOST UPLOAD ERROR", server))
            end
        end
    end)
    return Citizen.Await(Promise)
end
