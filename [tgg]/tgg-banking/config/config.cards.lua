Config = Config or {}

-- Whether you want to use the Cards feature.
-- NOTE: You need to have one of the supported inventory resources installed.
Config.UseCards = true

Config.Inventory = 'auto'

-- The limit for the ATM withdraw feature (per transaction).
Config.WithdrawAtmLimit = 5000

-- The limit for the ATM deposit feature (per transaction).
Config.DepositAtmLimit = 5000

-- The allowed attempts before the card gets frozen (when entering the wrong pin).
Config.FreezeCardAfterFailedAttempts = 5

Config.CardItems = {
    'debitcard_personal',
    'debitcard_business',
    'debitcard_shared'
}

-- Limit the number of cards that can be created by a player per account.
-- The limit is per account. 1 account can have 5(default value) cards.
Config.LimitCardCreation = 5

-- ========================= --
--- Inventory Normalization ---
-- ========================= --
if Config.Inventory == 'auto' then
    debugPrint('Auto-detecting inventory option...')

    local inventories = {
        'ox_inventory',
        'qb-inventory',
        'lj-inventory',
        'ps-inventory',
    }

    for i = 1, #inventories do
        if GetResourceState(inventories[i]):find('start') then
            Config.Inventory = inventories[i]
            break
        end
    end

    if Config.Inventory == 'auto' then
        Config.Inventory = 'standalone'
    end

    debugPrint('Auto-detected inventory option: ' .. Config.Inventory)
end
-- ========================= --
--- Inventory Normalization ---
-- ========================= --
