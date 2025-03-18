local function getOverdueInvoices(days, jobIdentifier)
    local invoices = MySQL.query.await([[
        SELECT
            id,
            total,
            status,
            sender,
            timestamp,
            sender_id as senderId,
            recipient_id as recipientId,
            tax_percentage as taxPercentage
        FROM `tgg_billing_invoices`
        WHERE TIMESTAMPDIFF(DAY, `timestamp`, CURRENT_TIMESTAMP()) > @days AND `status` = 'unpaid' AND `sender` = @jobIdentifier
    ]], {
        ['@days'] = days,
        ['@jobIdentifier'] = jobIdentifier
    })

    return invoices
end

local function runEnforcementAgentCheck()
    debugPrint('Enforcement Agent: Checking overdue invoices...')

    for _, companyInfo in pairs(Config.Companies) do
        if companyInfo?.forcePay then
            local overdueInvoices = getOverdueInvoices(companyInfo.interest.maxDays, companyInfo.jobIdentifier)

            if #overdueInvoices > 0 then
                debugPrint('Enforcement Agent: Found ' .. #overdueInvoices .. ' overdue invoices for company: ' .. companyInfo.jobIdentifier)

                for _, invoice in ipairs(overdueInvoices) do
                    if companyInfo.jobIdentifier == invoice.sender then
                        if companyInfo.interest.enabled then
                            local rateAmount = invoice.total * (companyInfo.interest.rate / 100)

                            invoice.total = invoice.total + rateAmount
                        end

                        local success, amount = pcall(Pay, nil, invoice)
                        if not success then
                            debugPrint('Enforcement Agent: Failed to pay invoice with id: ' .. invoice.id .. ' Error: ' .. amount)
                        else
                            Logs.EnforcementAgentPaid(invoice)
                        end
                    end
                end
            else
                debugPrint('Enforcement Agent: No overdue invoices found for company: ' .. companyInfo.jobIdentifier)
            end
        end
    end

    debugPrint('Enforcement Agent: Checking overdue invoices ended.')
end

lib.cron.new(Config.EnforcementAgentTimeout, runEnforcementAgentCheck)

lib.addCommand('runEnforcementAgent', {
    help = 'Run the enforcement agent',
    restricted = 'group.admin'
}, function()
    runEnforcementAgentCheck()
end)

function EnforcementAgentRemoveRecipientMoney(playerIdentifier, invoiceAmount)
    local recipient = Framework.GetPlayerFromIdentifier(playerIdentifier)
    if not recipient then
        recipient = GetOfflinePlayer(playerIdentifier)
    end

    if recipient then
        local bankMoney = recipient.getAccount('bank')?.money
        if bankMoney >= invoiceAmount then
            recipient.removeAccountMoney('bank', invoiceAmount)
            return true
        else
            debugPrint('Enforcement Agent Pay: Recipient ' .. playerIdentifier .. ' has insufficient funds. Cannot pay invoice.')
            return false
        end
    else
        debugPrint('Enforcement Agent Pay: Recipient ' .. playerIdentifier .. ' not found. Cannot pay invoice.')
        return false
    end
end
