--#region Getters
lib.callback.register('billing:server:invoice:all', function(source, page, filters)
    local citizenId = Framework?.GetPlayerFromId(source).identifier

    if not citizenId then return nil end

    local whereClauses = {}
    local queryParams = {
        ['@page'] = (page or 0) * 16,
        ['@perPage'] = 16
    }

    if filters.type == '__personal' then
        if filters.society == 'all' then
            -- All personal that are - send by me as __persanal, send to me as __persoanl, send to me from any society .
            table.insert(whereClauses,
                "((`sender_id` = @senderId AND `sender` = '__personal') OR (`recipient_id` = @recipientId AND `sender` = '__personal') OR (`recipient_id` = @recipientId AND `sender` != '__personal'))")
            queryParams['@senderId'] = citizenId
            queryParams['@recipientId'] = citizenId
        elseif filters.society == 'received' then
            table.insert(whereClauses, "`recipient_id` = @recipientId")
            queryParams['@recipientId'] = citizenId
        elseif filters.society == 'byMe' then
            table.insert(whereClauses, "`sender_id` = @senderId")
            queryParams['@senderId'] = citizenId

            table.insert(whereClauses, "`sender` = @sender")
            queryParams['@sender'] = '__personal'
        else
            table.insert(whereClauses, "`sender_id` = @sender")
            queryParams['@sender'] = filters.society

            table.insert(whereClauses, "`recipient_id` = @recipientId")
            queryParams['@recipientId'] = citizenId
        end
    else
        if filters.society == 'byMe' then
            table.insert(whereClauses, "`sender_id` = @sender")
            queryParams['@sender'] = citizenId
        end

        table.insert(whereClauses, "`sender` = @society")
        queryParams['@society'] = filters.type
    end

    if filters.status ~= 'all' then
        -- If the status is 'unpaid' we should filter for 'not_accepted' and 'unpaid' statuses
        if filters.status == 'unpaid' then
            table.insert(whereClauses, "(`status` = 'not_accepted' OR `status` = 'unpaid')")
        elseif filters.status == 'cancelled' then
            -- If the status is 'cancelled' we should filter for 'cancelled' and 'rejected' statuses
            table.insert(whereClauses, "(`status` = 'cancelled' OR `status` = 'rejected')")
        else
            table.insert(whereClauses, "`status` = @status")
            queryParams['@status'] = filters.status
        end
    end

    if filters.dateRange.dateFrom ~= '' and filters.dateRange.dateTo ~= '' then
        -- Using >= and < comparison instead of BETWEEN for proper date range handling
        table.insert(whereClauses, "`timestamp` >= @startDate AND `timestamp` < DATE_ADD(@endDate, INTERVAL 1 DAY)")
        queryParams['@startDate'] = filters.dateRange.dateFrom
        queryParams['@endDate'] = filters.dateRange.dateTo
    end

    local orderByClause = ""

    if filters.orderBy == 'newest' then
        orderByClause = "ORDER BY `timestamp` DESC"
    elseif filters.orderBy == 'oldest' then
        orderByClause = "ORDER BY `timestamp` ASC"
    elseif filters.orderBy == 'amountAsc' then
        orderByClause = "ORDER BY `total` ASC"
    elseif filters.orderBy == 'amountDesc' then
        orderByClause = "ORDER BY `total` DESC"
    end

    local whereClause = table.concat(whereClauses, " AND ")

    -- * Test generated queries for debugging
    -- debugPrint(queryParams)
    -- debugPrint(whereClause)
    -- debugPrint(orderByClause)

    local countResult = MySQL.single.await([[
        SELECT COUNT(*) as total
        FROM `tgg_billing_invoices`
        WHERE ]] .. whereClause .. " " .. orderByClause .. [[
    ]], queryParams)

    local totalInvoices = countResult?.total

    if totalInvoices == 0 then
        return {
            totalInvoices = 0,
            invoices = {}
        }
    end

    local query = [[
        SELECT
            id,
            uuid,
            items,
            total,
            notes,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            sender_name as senderName,
            recipient_id as recipientId,
            recipient_name as recipientName,
            tax_percentage as taxPercentage,
            sender_company_name as senderCompanyName
        FROM `tgg_billing_invoices`
        WHERE ]] .. whereClause .. " " .. orderByClause .. [[
        LIMIT @page, @perPage
    ]]

    -- Fetch filtered results with pagination
    local invoiceResult = MySQL.query.await(query, queryParams)

    for i = 1, #invoiceResult do
        invoiceResult[i].items = json.decode(invoiceResult[i].items)
    end

    return {
        totalInvoices = totalInvoices,
        invoices = invoiceResult
    }
end)

lib.callback.register('billing:invoice:get-by-uuid', function(_, uuid)
    local invoice = MySQL.single.await([[
        SELECT
            id,
            uuid,
            items,
            total,
            notes,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            sender_name as senderName,
            recipient_id as recipientId,
            recipient_name as recipientName,
            tax_percentage as taxPercentage,
            sender_company_name as senderCompanyName
        FROM `tgg_billing_invoices`
        WHERE `uuid` = @uuid
    ]], {
        ['@uuid'] = uuid
    })

    if invoice == nil then return nil end

    invoice.items = json.decode(invoice.items)

    return invoice
end)

lib.callback.register('billing:server:invoice:search-by-uuid', function(_, uuidQuery, playerIdentifier)
    local additionalFilter = ""
    if Config.GlobalSearchAllowed == false then
        additionalFilter = string.format(" AND (sender_id = '%s' OR recipient_id = '%s')", playerIdentifier,
            playerIdentifier)
    end

    local invoice = MySQL.single.await([[
        SELECT
            id,
            uuid,
            items,
            total,
            notes,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            sender_name as senderName,
            recipient_id as recipientId,
            recipient_name as recipientName,
            tax_percentage as taxPercentage,
            sender_company_name as senderCompanyName
        FROM `tgg_billing_invoices`
        WHERE `uuid` LIKE CONCAT(@uuid, '%%')]] .. additionalFilter .. [[
        ORDER BY LENGTH(uuid), uuid
        LIMIT 1
    ]], {
        ['@uuid'] = uuidQuery
    })

    if invoice == nil then return nil end

    invoice.items = json.decode(invoice.items)

    return invoice
end)
--#endregion

--#region Create, Cancel, Pay, Accept, Reject

---@param invoiceData table
---@return table|nil
function CreateInvoice(_, invoiceData)
    invoiceData.uuid = GenerateSequentalUUID()

    local senderCompanyConfig = GetCompanyConfig(invoiceData.sender)

    if senderCompanyConfig?.acceptFirst or (Config.PersonalAcceptFirst and invoiceData.sender == '__personal') then
        invoiceData.status = 'not_accepted'
    else
        invoiceData.status = 'unpaid'
    end

    local invoiceId = MySQL.insert.await([[
        INSERT INTO `tgg_billing_invoices` (
            `uuid`,
            `items`,
            `total`,
            `notes`,
            `sender`,
            `status`,
            `sender_id`,
            `sender_name`,
            `recipient_id`,
            `recipient_name`,
            `tax_percentage`,
            `sender_company_name`
        )
        VALUES (
            @uuid,
            @items,
            @total,
            @notes,
            @sender,
            @status,
            @sender_id,
            @sender_name,
            @recipient_id,
            @recipient_name,
            @tax_percentage,
            @sender_company_name
        )
    ]], {
        ['@uuid'] = invoiceData.uuid,
        ['@total'] = invoiceData.total,
        ['@notes'] = invoiceData.notes,
        ['@status'] = invoiceData.status,
        ['@sender'] = invoiceData.sender,
        ['@sender_id'] = invoiceData.senderId,
        ['@sender_name'] = invoiceData.senderName,
        ['@recipient_id'] = invoiceData.recipientId,
        ['@items'] = json.encode(invoiceData.items),
        ['@recipient_name'] = invoiceData.recipientName,
        ['@tax_percentage'] = invoiceData.taxPercentage,
        ['@sender_company_name'] = invoiceData.senderCompanyName,
    })

    if not invoiceId then return nil end

    local invoice = GetInvoiceById(invoiceId)

    if senderCompanyConfig?.acceptFirst or (Config.PersonalAcceptFirst and invoiceData.sender == '__personal') then
        local recipientSource = Framework.GetPlayerFromIdentifier(invoiceData.recipientId)?.source

        if recipientSource then
            TriggerClientEvent('billing:client:ask-invoice-acceptance',
                recipientSource, invoice)
        end
    end

    TriggerEvent('billing:server:on-invoice-created', invoice)

    return invoice
end

lib.callback.register('billing:server:invoice:create', CreateInvoice)

---@param invoiceId number
---@return boolean
function CancelInvoice(_, invoiceId)
    if not invoiceId then return false end

    local cancelled = MySQL.update.await([[
        UPDATE `tgg_billing_invoices`
        SET `status` = 'cancelled'
        WHERE `id` = @id
    ]], {
        ['@id'] = invoiceId
    })

    local invoiceData = GetInvoiceById(invoiceId)

    if cancelled > 0 then
        TriggerEvent('billing:server:on-invoice-cancelled', invoiceData)
    end

    return cancelled
end

lib.callback.register('billing:server:invoice:cancel', CancelInvoice)

---@param source number
---@param invoiceId number
---@return boolean, number?
function PayInvoice(source, invoiceId)
    local _playerSource = source
    local citizenId = Framework?.GetPlayerFromId(_playerSource)?.identifier
    if not citizenId then return false end

    local invoice = GetInvoiceById(invoiceId)
    if not invoice then
        debugPrint('Payment Failed: Invoice not found.')
        return false
    end

    if invoice.recipientId ~= citizenId and not Config.GlobalSearchAllowed then
        debugPrint('Payment Failed: Player is not the recipient of the invoice.')
        return false
    end

    local success, amountPaid = Pay(source, invoice)

    if success then
        if citizenId ~= invoice.recipientId then
            local recipientSource = Framework.GetPlayerFromIdentifier(invoice.recipientId)?.source
            if recipientSource then
                TriggerClientEvent('billing:client:on-external-invoice-paid', recipientSource, invoice)
            end
        end


        TriggerEvent('billing:server:on-invoice-paid', invoice)
    end

    return success, amountPaid
end

lib.callback.register('billing:server:invoice:pay', PayInvoice)

---- Paying Function ----
---@param source number | nil
---@param invoice table
---@return boolean, number?
function Pay(source, invoice)
    if not invoice then return false end

    local tax = invoice.total * (invoice.taxPercentage / 100)
    local sender = Framework.GetPlayerFromIdentifier(invoice.senderId)
    local senderJob = nil
    local senderGrade = nil
    local isSenderOffline = false
    local enforcementAgent = false

    if not source then enforcementAgent = true end -- We are going to use the enforcment agent!

    if not sender then
        sender = GetOfflinePlayer(invoice.senderId)
        isSenderOffline = true
    end

    if invoice.sender ~= '__personal' then
        senderJob = sender?.job.name
        senderGrade = sender?.job.grade
    end

    local totalPayment = invoice.total + tax
    if not enforcementAgent then
        local targetPlayer = Framework.GetPlayerFromId(source)

        if targetPlayer then
            local targetPlayerMoney = targetPlayer.getAccount('bank')?.money
            if targetPlayerMoney >= totalPayment then
                -- Remove money(bank) from recipient.
                RemoveRecipientMoney(source, totalPayment)
            else
                return false, 0
            end
        end
    else
        local success = EnforcementAgentRemoveRecipientMoney(invoice.recipientId, totalPayment)
        if not success then return false, 0 end
    end

    local workerAmount = 0
    local companyAmount = 0

    local isPersonal = invoice.sender == '__personal'
    if isPersonal and not isSenderOffline then
        AddWorkerMoney(invoice.senderId, invoice.total)
    elseif isPersonal and isSenderOffline then
        AddOfflineWorkerMoney(invoice.senderId, invoice.total)
    else
        local data = {
            jobFound = false,
            receiveTax = false
        }

        for _, company in pairs(Config.Companies) do
            if company.jobIdentifier == senderJob then
                data = { jobFound = true, receiveTax = company.companyReceiveTax and not Config.Government.CollectTax }
                break
            end
        end

        if not data.jobFound then senderJob = 'other' end

        debugPrint("Sender Job is: " .. senderJob)

        if Config.Companies[senderJob].comission ~= {} then
            local comissionPercentage = 0

            for _, comission in pairs(Config.Companies[senderJob].comission) do
                if comission.grade == senderGrade then
                    comissionPercentage = comission.percentage / 100
                    debugPrint("Comission Percentage is: " .. comissionPercentage)
                    break
                end
            end

            if comissionPercentage > 0 then
                workerAmount = invoice.total * comissionPercentage
                companyAmount = invoice.total - workerAmount
            else
                companyAmount = invoice.total
            end

            debugPrint("Worker will receive: " .. workerAmount)
            debugPrint("Company will receive: " .. companyAmount)
        elseif Config.Companies[senderJob].comission == {} then
            companyAmount = invoice.total
        end

        if companyAmount > 0 then
            local taxdata = {
                receiveTax = data.receiveTax,
                taxAmount = tax
            }

            AddCompanyMoney(senderJob, companyAmount, taxdata)
        end

        if workerAmount > 0 then
            if not isSenderOffline then
                AddWorkerMoney(invoice.senderId, workerAmount)
            else
                AddOfflineWorkerMoney(invoice.senderId, workerAmount)
            end
        end
    end

    if Config.Government.CollectTax and Config.Government.Account then
        AddCompanyMoney(Config.Government.Account, 0, { receiveTax = true, taxAmount = tax })
    end

    local updated = MySQL.update.await([[
        UPDATE `tgg_billing_invoices`
        SET `status` = 'paid'
        WHERE `id` = @id
    ]], {
        ['@id'] = invoice.id
    }) > 0

    if updated and AddBankingTransaction then
        if workerAmount > 0 then
            AddBankingTransaction(invoice.senderId, workerAmount, invoice)
        end

        if companyAmount > 0 and senderJob ~= 'other' then
            AddBankingTransaction(senderJob, companyAmount, invoice)
        end

        -- AddBankingTransaction(isPersonal and invoice.senderId or senderJob, totalPayment, invoice)
    end

    return updated, totalPayment
end

---@param invoiceId number
function AcceptInvoice(_, invoiceId)
    debugPrint('Accepting invoice: ' .. invoiceId)
    if not invoiceId then return false end

    local accepted = MySQL.update.await([[
        UPDATE `tgg_billing_invoices`
        SET `status` = 'unpaid'
        WHERE `id` = @id
    ]], {
        ['@id'] = invoiceId
    })

    if accepted > 0 then
        local invoice = GetInvoiceById(invoiceId)
        TriggerEvent('billing:server:on-invoice-accepted', invoice)
    end

    return accepted
end

lib.callback.register('billing:server:invoice:accept', AcceptInvoice)

---@param invoiceId number
function RejectInvoice(_, invoiceId)
    if not invoiceId then return false end

    local rejected = MySQL.update.await([[
        UPDATE `tgg_billing_invoices`
        SET `status` = 'rejected'
        WHERE `id` = @id
    ]], {
        ['@id'] = invoiceId
    })


    if rejected > 0 then
        local invoice = GetInvoiceById(invoiceId)
        TriggerEvent('billing:server:on-invoice-rejected', invoice)
    end

    return rejected
end

lib.callback.register('billing:server:invoice:reject', RejectInvoice)

---@param id number
---@return table|nil
function GetInvoiceById(id)
    local invoice = MySQL.single.await([[
        SELECT
            id,
            uuid,
            items,
            total,
            notes,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            sender_name as senderName,
            recipient_id as recipientId,
            recipient_name as recipientName,
            tax_percentage as taxPercentage,
            sender_company_name as senderCompanyName
        FROM `tgg_billing_invoices`
        WHERE `id` = @id
    ]], {
        ['@id'] = id
    })

    if invoice == nil then return nil end

    invoice.items = json.decode(invoice.items)

    return invoice
end

lib.callback.register('billing:server:invoice:get', function(_, id)
    return GetInvoiceById(id)
end)

lib.callback.register('billing:invoice:server:get-total-payment-amount', function(_, recipientId)
    local invoiceResult = MySQL.query.await([[
        SELECT
            total,
            sender
        FROM `tgg_billing_invoices`
        WHERE `recipient_id` = @recipientId AND `status` = 'unpaid'
    ]], {
        ['@recipientId'] = recipientId
    })

    local totalPayment = 0

    if not invoiceResult then return totalPayment end

    for i = 1, #invoiceResult do
        local companyConfig = GetCompanyConfig(invoiceResult[i].sender)

        local taxPercentage = companyConfig.taxPercentage / 100

        local tax = invoiceResult[i].total * taxPercentage

        totalPayment += invoiceResult[i].total + tax
    end

    return totalPayment
end)

lib.callback.register('billing:invoice:server:pay-all', function(_, playerIdentifier, totalPayment)
    local playerMoney = Framework.GetPlayerFromIdentifier(playerIdentifier)?.getAccount('bank')?.money

    if not playerMoney then return false end

    if tonumber(playerMoney) < tonumber(totalPayment) then return false end

    local invoices = MySQL.query.await([[
        SELECT
            id,
            uuid,
            items,
            total,
            notes,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            sender_name as senderName,
            recipient_id as recipientId,
            recipient_name as recipientName,
            tax_percentage as taxPercentage,
            sender_company_name as senderCompanyName
        FROM `tgg_billing_invoices`
        WHERE `recipient_id` = @recipientId AND `status` = 'unpaid'
    ]], {
        ['@recipientId'] = playerIdentifier
    })

    if not invoices then return false end

    local playerSource = Framework.GetPlayerFromIdentifier(playerIdentifier)?.source
    if not playerSource then return false end

    for i = 1, #invoices do
        local errors, success = pcall(Pay, playerSource, invoices[i])

        if errors then
            debugPrint('Error paying invoice: ' .. invoices[i].id .. ' Error: ' .. errors)
        end

        if success then TriggerEvent('billing:server:on-invoice-paid', invoices[i]) end
    end

    return true
end)
--#endregion

--#region Statistics
local intervals = {
    today = "INTERVAL 1 DAY",
    last_week = "INTERVAL 1 WEEK",
    month = "INTERVAL 1 MONTH",
    year = "INTERVAL 1 YEAR"
}

lib.callback.register('billing:invoice:server:count', function(_, period, status, sender, senderId)
    -- status: all, paid, unpaid, cancelled, rejected, not_accepted
    -- sender: society, '__personal'

    local interval = intervals[period]
    if not interval then
        -- Handle error: Invalid period specified
        debugPrint("Invalid period specified: " .. tostring(period))
        return 0 -- Early return to prevent SQL execution with invalid data
    end

    local whereClauses = {}

    -- Add sender constraints
    if sender == '__personal' and senderId then
        table.insert(whereClauses, string.format("`sender` = '__personal' AND `sender_id` = '%s'", senderId))
    else
        table.insert(whereClauses, string.format("`sender` = '%s'", sender))
    end

    -- Add status constraints
    if status ~= 'all' then
        if status == 'unpaid' then
            table.insert(whereClauses, "(`status` = 'not_accepted' OR `status` = 'unpaid')")
        elseif status == 'cancelled' then
            table.insert(whereClauses, "(`status` = 'cancelled' OR `status` = 'rejected')")
        else
            table.insert(whereClauses, string.format("`status` = '%s'", status))
        end
    end

    -- Add time period constraint
    table.insert(whereClauses, string.format("`timestamp` >= DATE_SUB(NOW(), %s)", interval))

    local statusCondition = table.concat(whereClauses, " AND ")

    local query = string.format([[
        SELECT COUNT(*) as total
        FROM `tgg_billing_invoices`
        WHERE %s
    ]], statusCondition)

    local countResult = MySQL.query.await(query, {})

    return countResult[1]?.total or 0
end)

lib.callback.register('billing:invoice:server:income', function(_, period, sender, senderId)
    local interval = intervals[period]

    if not interval then
        -- Handle error: Invalid period specified
        debugPrint("Invalid period specified: " .. tostring(period))
    end

    local senderConstraint = ""
    if sender == '__personal' and senderId then
        senderConstraint = string.format("AND `sender` = '__personal' AND `sender_id` = '%s'", senderId)
    elseif sender then
        senderConstraint = string.format("AND `sender` = '%s'", sender)
    end

    local query = string.format([[
        SELECT SUM(`total` * (1 + `tax_percentage` / 100)) AS total
        FROM `tgg_billing_invoices`
        WHERE `status` = 'paid' AND `timestamp` >= DATE_SUB(NOW(), %s) %s
    ]], interval, senderConstraint)

    local income = MySQL.query.await(query)

    return income[1]?.total or 0
end)

lib.callback.register('billing:invoice:server:expected-income', function(_, period, sender, senderId)
    local interval = intervals[period]
    if not interval then
        -- Handle error: Invalid period specified
        debugPrint("Invalid period specified: " .. tostring(period))
    end

    local senderConstraint = ""
    if sender == '__personal' and senderId then
        senderConstraint = string.format("AND `sender` = '__personal' AND `sender_id` = '%s'", senderId)
    elseif sender then
        senderConstraint = string.format("AND `sender` = '%s'", sender)
    end

    local query = string.format([[
        SELECT SUM(`total` * (1 + `tax_percentage` / 100)) AS total
        FROM `tgg_billing_invoices`
        WHERE `status` = 'unpaid' AND `timestamp` >= DATE_SUB(NOW(), %s) %s
    ]], interval, senderConstraint)

    local income = MySQL.query.await(query)

    return income[1]?.total or 0
end)

lib.callback.register('billing:invoice:server:last-15-daily-income', function(_, sender, senderId)
    -- Generate dates for the last 15 days in the desired format
    local today = os.time()
    local dates = {}
    for i = 0, 14 do
        local date = os.date('*t', today - (i * 86400)) -- Generate date table
        local formattedDate = string.format('%s %02d, %02d', os.date('%b', today - (i * 86400)), date.day,
            date.year % 100)
        dates[formattedDate] = 0 -- Initialize all dates with 0 total
    end

    local senderConstraint = ""
    if sender == '__personal' and senderId then
        senderConstraint = string.format("AND `sender` = '__personal' AND `sender_id` = '%s'", senderId)
    else
        senderConstraint = string.format("AND `sender` = '%s'", sender)
    end

    local query = string.format([[
        SELECT
            DATE_FORMAT(`last_modified`, '%%b %%d, %%y') as date,
            SUM(`total` * (1 + `tax_percentage` / 100)) AS total
        FROM `tgg_billing_invoices`
        WHERE `status` = 'paid' AND `last_modified` >= DATE_SUB(NOW(), INTERVAL 15 DAY) %s
        GROUP BY DATE(`last_modified`)
        ORDER BY DATE(`last_modified`) DESC
    ]], senderConstraint)

    local sales = MySQL.query.await(query)
    -- Update the map with actual sales data
    for _, sale in ipairs(sales) do
        dates[sale.date] = sale.total
    end

    -- Convert map to array
    local completeSales = {}
    for date, total in pairs(dates) do
        -- Format total to two decimal places
        local formattedTotal = string.format("%.2f", total)
        table.insert(completeSales, { date = date, total = tonumber(formattedTotal) })
    end

    -- Sort by date
    table.sort(completeSales, function(a, b) return a.date > b.date end)

    return completeSales
end)

lib.callback.register('billing:invoice:server:recent-payments', function(_, sender, senderId)
    local senderConstraint = ""
    if sender == '__personal' and senderId then
        senderConstraint = string.format("AND `sender` = '__personal' AND `sender_id` = '%s'", senderId)
    else
        senderConstraint = string.format("AND `sender` = '%s'", sender)
    end

    local query = string.format([[
        SELECT
            id,
            uuid,
            items,
            total,
            notes,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            sender_name as senderName,
            recipient_id as recipientId,
            last_modified as lastModified,
            recipient_name as recipientName,
            tax_percentage as taxPercentage,
            sender_company_name as senderCompanyName
        FROM `tgg_billing_invoices`
        WHERE `status` = 'paid' %s
        ORDER BY `last_modified` DESC
        LIMIT %d
    ]], senderConstraint, Config.RecentPayments or 25)

    local recentPayments = MySQL.query.await(query)

    for i = 1, #recentPayments do
        recentPayments[i].items = json.decode(recentPayments[i].items)
    end

    return recentPayments
end)

--#endregion
