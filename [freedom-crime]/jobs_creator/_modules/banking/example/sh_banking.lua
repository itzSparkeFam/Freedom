local moduleType = "banking" -- Module category
local moduleName = "example" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

-- This is just an EXAMPLE, so you have to edit it to make it work
Integrations[moduleType][moduleName].getSocietyMoney = function(societyName)
    local money = exports['example-banking']:getMoney(societyName)
    return money
end

-- This is just an EXAMPLE, so you have to edit it to make it work
Integrations[moduleType][moduleName].giveMoneyToSociety = function(societyName, amount)
    local success = exports['example-banking']:giveMoney(societyName, amount)
    return success -- Return true if success, false if not
end

-- This is just an EXAMPLE, so you have to edit it to make it work
Integrations[moduleType][moduleName].removeMoneyFromSociety = function(societyName, amount)
    local success = exports['example-banking']:removeMoney(societyName, amount)
    return success -- Return true if success, false if not
end