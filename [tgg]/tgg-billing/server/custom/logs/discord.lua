if Config.Logs ~= 'discord' then return end

local discordWebhook = "https://discord.com/api/webhooks/1197575566388383916/3IzNxKmtDlySm2Gvi_6q7xVXJC7oTzoLfL9_QjOKOy6RguxCaYX32QU5r_PMphOgkZBJ"

local discord = {
    send = function(title, description, color)
        if not discordWebhook then return end

        local embed = {
            {
                ["title"] = title,
                ["description"] = description,
                ["color"] = color,
                ["footer"] = {
                    ["text"] = os.date('%d/%m/%Y [%X]'),
                }
            }
        }
        PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({ embeds = embed }),
            { ['Content-Type'] = 'application/json' })
    end
}

Logs = {
    InvoiceCreated = function(invoiceData)
        if not discordWebhook then return end

        local itemsDescription = ""
        for _, item in ipairs(invoiceData.items) do
            itemsDescription = itemsDescription ..
                item.label .. " - Price: $" .. item.price .. ", Quantity: " .. item.quantity .. "\n"
        end

        local description = ('**Created by:** %s\n**Society:** %s\n\n**Receiver:** %s\n**Value:** %s$\n**Items:**\n%s\n**Status:** %s')
            :format(
                invoiceData.senderName,
                invoiceData.sender == '__personal' and 'Personal' or invoiceData.sender,
                invoiceData.recipientName,
                tostring(invoiceData.total),
                itemsDescription,
                invoiceData.status
            )

        if invoiceData.taxPercentage ~= 0 then
            description = description .. '\n**Tax:** ' .. tostring(invoiceData.taxPercentage) .. '%'
        end

        if invoiceData.notes ~= '' then
            description = description .. '\n**Note:** ' .. invoiceData.notes
        end

        discord.send(
            ('Invoice #%s has been created'):format(invoiceData.id),
            description,
            1752220
        )
    end,

    PayInvoice = function(invoiceData)
        if not discordWebhook then return end

        local itemsDescription = ""
        for _, item in ipairs(invoiceData.items) do
            itemsDescription = itemsDescription ..
                item.label .. " - Price: $" .. item.price .. ", Quantity: " .. item.quantity .. "\n"
        end

        local description = ('**Created by:** %s\n**Society:** %s\n\n**Receiver:** %s\n**Value:** %s$\n**Items:**\n%s')
            :format(
                invoiceData.senderName,
                invoiceData.sender == '__personal' and 'Personal' or invoiceData.sender,
                invoiceData.recipientName,
                tostring(invoiceData.total),
                itemsDescription
            )

        if invoiceData.taxPercentage ~= 0 then
            description = description .. '\n**Tax:** ' .. tostring(invoiceData.taxPercentage) .. '%'
        end

        if invoiceData.notes ~= '' then
            description = description .. '\n**Note:** ' .. invoiceData.notes
        end

        discord.send(
            ('Invoice #%s has been paid'):format(invoiceData.id),
            description,
            65280
        )
    end,

    CancelInvoice = function(invoiceData)
        if not discordWebhook then return end

        local itemsDescription = ""
        for _, item in ipairs(invoiceData.items) do
            itemsDescription = itemsDescription ..
                item.label .. " - Price: $" .. item.price .. ", Quantity: " .. item.quantity .. "\n"
        end

        local description = ('**Created by:** %s\n**Society:** %s\n\n**Receiver:** %s\n**Value:** %s$\n**Items:**\n%s\n**Status:** %s')
            :format(
                invoiceData.senderName,
                invoiceData.sender == '__personal' and 'Personal' or invoiceData.sender,
                invoiceData.recipientName,
                tostring(invoiceData.total),
                itemsDescription,
                invoiceData.status
            )

        if invoiceData.taxPercentage ~= 0 then
            description = description .. '\n**Tax:** ' .. tostring(invoiceData.taxPercentage) .. '%'
        end

        if invoiceData.notes ~= '' then
            description = description .. '\n**Note:** ' .. invoiceData.notes
        end

        discord.send(
            ('Invoice #%s has been cancelled'):format(invoiceData.id),
            description,
            16711680
        )
    end,

    InvoiceAccepted = function(invoiceData)
        if not discordWebhook then return end

        local itemsDescription = ""
        for _, item in ipairs(invoiceData.items) do
            itemsDescription = itemsDescription ..
                item.label .. " - Price: $" .. item.price .. ", Quantity: " .. item.quantity .. "\n"
        end

        local description = ('**Created by:** %s\n**Society:** %s\n\n**Receiver:** %s\n**Value:** %s$\n**Items:**\n%s\n**Status:** %s')
            :format(
                invoiceData.senderName,
                invoiceData.sender == '__personal' and 'Personal' or invoiceData.sender,
                invoiceData.recipientName,
                tostring(invoiceData.total),
                itemsDescription,
                invoiceData.status
            )

        if invoiceData.taxPercentage ~= 0 then
            description = description .. '\n**Tax:** ' .. tostring(invoiceData.taxPercentage) .. '%'
        end

        if invoiceData.notes ~= '' then
            description = description .. '\n**Note:** ' .. invoiceData.notes
        end

        discord.send(
            ('Invoice #%s has been accepted'):format(invoiceData.id),
            description,
            65280
        )
    end,

    InvoiceRejected = function(invoiceData)
        if not discordWebhook then return end

        local itemsDescription = ""
        for _, item in ipairs(invoiceData.items) do
            itemsDescription = itemsDescription ..
                item.label .. " - Price: $" .. item.price .. ", Quantity: " .. item.quantity .. "\n"
        end

        local description = ('**Created by:** %s\n**Society:** %s\n\n**Receiver:** %s\n**Value:** %s$\n**Items:**\n%s\n**Status:** %s')
            :format(
                invoiceData.senderName,
                invoiceData.sender == '__personal' and 'Personal' or invoiceData.sender,
                invoiceData.recipientName,
                tostring(invoiceData.total),
                itemsDescription,
                invoiceData.status
            )

        if invoiceData.taxPercentage ~= 0 then
            description = description .. '\n**Tax:** ' .. tostring(invoiceData.taxPercentage) .. '%'
        end

        if invoiceData.notes ~= '' then
            description = description .. '\n**Note:** ' .. invoiceData.notes
        end

        discord.send(
            ('Invoice #%s has been rejected'):format(invoiceData.id),
            description,
            16711680
        )
    end,

    EnforcementAgentPaid = function(invoiceData)
        if not discordWebhook then return end

        discord.send(
            ('Invoice #%s has been paid by the enforcement agent'):format(invoiceData.id),
            '', -- Empty description since the title contains all necessary information
            65280
        )
    end,

    EnforcementAgentFailed = function(invoiceData)
        if not discordWebhook then return end

        discord.send(
            ('Invoice #%s has failed to be paid by the enforcement agent. Reason: Insufficient funds'):format(invoiceData.id),
            '', -- Empty description since the title contains all necessary information
            16711680
        )
    end
}
