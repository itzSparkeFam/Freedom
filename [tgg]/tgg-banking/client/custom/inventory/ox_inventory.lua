if Config.Inventory ~= 'ox_inventory' then return end

exports.ox_inventory:displayMetadata({
    displayName = 'Display Name',
    cardNumber = 'Card Number',
    expirationDate = 'Expiration Date',
    cvv = 'CVV',
})

---@param item { slot: number }
---@return string|nil
function GetCardNumberFromItem(item)
    for _, itemName in ipairs(Config.CardItems) do
        local cards = exports.ox_inventory:Search("slots", itemName)

        for i = 1, #cards do
            local card = cards[i]
            if card?.slot == item.slot then
                return card?.metadata?.cardNumber or nil
            end
        end
    end

    return nil
end

function GetCardItems()
    local cardItems = {}

    for _, itemName in ipairs(Config.CardItems) do
        local cards = exports.ox_inventory:Search("slots", itemName)

        for i = 1, #cards do
            local card = cards[i]

            cardItems[#cardItems + 1] = card
        end
    end

    return cardItems
end
