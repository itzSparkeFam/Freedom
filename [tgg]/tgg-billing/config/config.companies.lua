Config = Config or {}

Config.Government = {}

Config.Government.CollectTax = false     -- Whether to send the tax to the government account. NOTE: This will override the companyReceiveTax(below) setting.
Config.Government.Account = 'government' -- The account name to use for the government. Must be a valid account name and the account must exist.

-- Default *grades for create, cancel:
--  *{} - Can't create/cancel invoices;
--  *{-1} - Can create/cancel invoices, no matter the grade;
--  *{1, 2, 3} - Can create/cancel invoices if it has the grade 1, 2 or 3;
--  *{'__personal'} - Can create/cancel invoices as an individual personality. Need to set that explicitly to allow the player to create/cancel invoices as an individual.
Config.Companies = {
    ["other"] = { -- [DO NOT REMOVE] - All jobs that are not configured below will fall into this case.
        name = 'other',
        jobIdentifier = 'other',
        create = { '__personal' },
        cancel = {},
        acceptFirst = true,
        comission = {},
        taxPercentage = 10,
        forcePay = true,
        interest = {
            enabled = true,
            rate = 10,
            maxDays = 30,
        },
        allowCustomItems = false,
        defaultInvoiceItems = {},
    },
    ["police"] = {
        name = 'Law Enforcement',      -- How your company name will be displayed in the UI.
        jobIdentifier = 'police',      -- The job indentifier that MUST MATCH the job name in your framework.
        create = { -1, '__personal' }, -- The grades that can create invoices for this company. -1 = all grades. *'__personal' = create as individual personality.
        cancel = { 3, 4 },             -- The grades that can cancel invoices for this company. -1 = all grades.
        acceptFirst = true,            -- Whether to ask the recipient to accept the invoice. If *false, the invoice will be accepted automatically.
        taxPercentage = 10,            -- The tax percentage the player will have to pay when the invoice is paid. Leave it to *0* to disable taxes.
        companyReceiveTax = true,      -- if true, the tax % will go to the society, otherwise the money will be voided.
        -- ^^^ COMISSION:  MAX SUM VALUE is *100*(simple math) ^^^
        -- The comission the player and society will get when the invoice is paid.
        -- The comission will be paid based on the grade of the player configured below.
        -- The socienty will receive the amount that is left after the player gets his comission.
        -- Ex: If the player is a boss(4) and the comission is 40, the player will receive 40% of the invoice and the society will receive 60%.
        comission = { -- Leave it empty(`comission = {}`) to disable comission(all goes to the society).
            {
                grade = 4,
                percentage = 50
            }
        },
        -- If the invoice is not paid within the `maxDays`, the billing will automatically collect the money and pay the invoice.
        -- A cron job will be scheduled on given interval that will check for overdue invoices.
        -- Modify the timeout in `config.misc.lua` - `Config.EnforcementAgentTimeout`.
        forcePay = true,
        interest = {             -- If the invoice is paid after the due date(maxDays), the player will have to pay interest(rate).
            enabled = true,      -- Whether to enable interest for this company.
            rate = 10,           -- The interest rate(%) for this company.
            maxDays = 30,        -- The maximum days the invoice can be overdue.
        },
        allowCustomItems = true, -- Whether to allow the player to add custom items to the invoice as job related. Personal invoices can have always custom items.
        defaultInvoiceItems = {  -- The default invoice items that will be displayed when creating an invoice.
            { key = 'speeding', label = 'Speeding', price = 100, quantity = 1, priceChange = false, quantityChange = false },
            { key = 'parking',  label = 'Parking',  price = 25,  quantity = 1, priceChange = false, quantityChange = false },
            { key = 'cop-bait', label = 'Cop Bait', price = 150, quantity = 1, priceChange = true,  quantityChange = true },
        }
    },
    ["mechanic"] = {
        name = 'LS Customs',
        jobIdentifier = 'mechanic',
        create = { -1, '__personal' },
        cancel = { 3, 4 },
        acceptFirst = true,
        taxPercentage = 10,
        companyReceiveTax = true,
        comission = {},
        forcePay = true,
        interest = {
            enabled = true,
            rate = 10,
            maxDays = 30,
        },
        allowCustomItems = true,
        defaultInvoiceItems = {
            { key = 'oil-change',        label = 'Oil Change',        price = 100, quantity = 1, priceChange = false, quantityChange = false },
            { key = 'tire-repair',       label = 'Tire Repair',       price = 25,  quantity = 1, priceChange = false, quantityChange = true },
            { key = 'engine-diagnostic', label = 'Engine Diagnostic', price = 150, quantity = 1, priceChange = true,  quantityChange = false },
        }
    },
}
