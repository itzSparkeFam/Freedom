if Config.Inventory ~= 'ox_inventory' then return end

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

    if exports.ox_inventory:CanCarryItem(playerId, cardItem, 1) then
        local success, _ = exports.ox_inventory:AddItem(playerId, cardItem, 1, {
            cardId = cardId,
            displayName = displayName,
            cardNumber = FormatCardNumber(cardNumber),
            expirationDate = os.date('%m/%y', expirationDate / 1000),
            cvv = cvv,
        })

        if success then
            return { success = true, message = "Card added to your inventory" }
        else
            return { success = false, message = "Failed to add card to your inventory" }
        end
    else
        return { success = false, message = "You do not have enough space in your inventory" }
    end
end
