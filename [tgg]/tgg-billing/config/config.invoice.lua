Config = Config or {}

-- Allow players to go into negative bank balance.
-- If false, the player will not be able to pay invoices if they don't have enough money.
-- However if the company has `forcePay` enabled it will go in negative bank balance in order to collect the society money.
Config.AllowOverdraft = true
-- The limit of the negative bank balance the player can go if `AllowOverdraft` is enabled.
Config.OverdraftLimit = 1000

-- Allow players to search for invoices by `uuid` globally.
-- This will allow players to view/pay invoices of another players if they know the `uuid`.
Config.GlobalSearchAllowed = true

-- Whether to accept the first invoice automatically for personal invoices or ask for receiver's acceptance.
Config.PersonalAcceptFirst = true
-- Tax percentage that will be applied to the invoices created as a personal invoice.
Config.PersonalTaxPercentage = 10

-- The count of recent payments to show in the `Recent Payments(Statistics)` section.
Config.RecentPayments = 25

Config.SocietyFilters = { -- https://i.imgur.com/hYUcxQr.png
    {
        value = 'all',
        label = 'All',
    },
    { -- Filter for `Invoices` created by me as an individual personality.
        value = 'byMe',
        label = 'Created by me',
    },
    { -- Filter for `Invoices` received to me as an individual personality.
        value = 'received',
        label = 'Received',
    },
    {
        value = 'police',
        label = 'Law Enforcement',
    },
    {
        value = 'ambulance',
        label = 'Medical Services',
    },
    {
        value = 'mechanic',
        label = 'LS Customs',
    },
    {
        value = 'cardealer',
        label = 'Car Dealership',
    },
    {
        value = 'realestateagent',
        label = 'Real Estate',
    },
}
