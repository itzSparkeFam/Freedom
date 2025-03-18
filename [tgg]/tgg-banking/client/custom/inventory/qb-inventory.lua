if (Config.Inventory ~= "qb-inventory" and Config.Inventory ~= "lj-inventory" and Config.Inventory ~= "ps-inventory") or not Config.Framework == 'qb' then
    return
end

local _Framework = exports["qb-core"]:GetCoreObject()

---@param item { info: { cardNumber: string } }
---@return string|nil
function GetCardNumberFromItem(item)
    return item?.info?.cardNumber or nil
end

function GetCardItems()
    local items = {}

    for _, itemName in ipairs(Config.CardItems) do
        local inventory = _Framework.Functions.GetPlayerData().items
        for _, item in pairs(inventory) do
            if item?.name == itemName then
                items[#items + 1] = item
            end
        end
    end

    return items
end

RegisterNetEvent('banking:use-card-on-atm', function(cardItem)
    UseCardOnAtm(cardItem)
end)
