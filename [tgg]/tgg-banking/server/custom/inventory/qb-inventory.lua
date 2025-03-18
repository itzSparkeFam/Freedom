if (Config.Inventory ~= "qb-inventory" and Config.Inventory ~= "lj-inventory" and Config.Inventory ~= "ps-inventory") or not Config.Framework == 'qb' then
    return
end

local _Framework = exports["qb-core"]:GetCoreObject()

--- Give a card item to player's inventory.
---@param playerId number The player's ID
---@param cardId number The card's unique ID
---@param cardNumber number The card number
---@param expirationDate number Expiration date in UNIX timestamp (ms)
---@param cvv string The CVV of the card
---@param displayName string The display name of the card
---@param accountType 'personal' | 'business' | 'shared' The type of account
---@return { success: boolean, message: string }
function GiveCardItem(playerId, cardId, cardNumber, expirationDate, cvv, displayName, accountType)
    if not playerId or not tonumber(playerId) then return { success = false, message = "Invalid player ID" } end
    if not cardNumber or #cardNumber ~= 16 then return { success = false, message = "Invalid card number" } end
    if not AccountTypeToCardItem[accountType] then return { success = false, message = "Invalid account type" } end

    local cardItem = AccountTypeToCardItem[accountType]

    local expExists, canAdd = pcall(function()
        return exports['qb-inventory']:CanAddItem(playerId, cardItem, 1)
    end)

    if (expExists and canAdd) or not expExists then
        local success = exports['qb-inventory']:AddItem(playerId, cardItem, 1, false, {
            cardId = cardId,
            displayName = displayName,
            cardNumber = FormatCardNumber(cardNumber),
            expirationDate = os.date('%m/%y', expirationDate / 1000),
            cvv = cvv,
        }, '')

        if success then
            return { success = true, message = "Card added to your inventory" }
        else
            return { success = false, message = "Failed to add card to your inventory" }
        end
    else
        return { success = false, message = "You do not have enough space in your inventory" }
    end
end

for i = 1, #Config.CardItems do
    _Framework.Functions.CreateUseableItem(Config.CardItems[i], function(source, item)
        if item then
            TriggerClientEvent("banking:use-card-on-atm", source, item)
        end
    end)
end
