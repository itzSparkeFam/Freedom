-- █████╗ ██████╗ ███████╗██╗  ██╗    ███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗ ███████╗
--██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝    ██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║██╔═══██╗██╔════╝
--███████║██████╔╝█████╗   ╚███╔╝     ███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║███████╗
--██╔══██║██╔═══╝ ██╔══╝   ██╔██╗     ╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║╚════██║
--██║  ██║██║     ███████╗██╔╝ ██╗    ███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝███████║
--╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝    ╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝ ╚══════╝

----------------------------------------------------------------------------------------------------

local Apex = exports['apex_lib']:GetApexObject()
---------------------------------------


-- Inventory functions --
function RegisterStash(id, label, slots, weight, owner)
    Apex.Functions.RegisterStash(id, label, slots, weight, owner)
end

-- Add & Remove Items functions --
function AddItem(source, item, amount)
    Apex.Functions.AddItem(source, item, amount)
end

function RemoveItem(source, item, amount)
    Apex.Functions.RemoveItem(source, item, amount)
end

function HasItem(source, item, amount)
    return Apex.Functions.HasItem(source, item, amount)
end
---------------------------------------


-- Notification functions --
function Notifications(source, message, time, type)
    Apex.Functions.Notify(source, message, time, type)
    -- If we do not support your current Notification system. Comment out the line above by adding (--) in front of it
    -- and then add your own trigger below.
    -- Examples:
    -- exports['NotificationScript']:Alert("", message, time, type)
    -- TriggerClientEvent('NotificationScript:sendnotification', src, message, time, type)
end
---------------------------------------


-- AddMoneyToSociety functions --
---------------------------------------
function AddMoneyToSociety(source, societyName, societyPaid)
    if Config.Debug == true then
        Debug('Society system, id: ' .. source .. ', society name: ' .. societyName .. ', Paid: ' .. societyPaid)
    end
    exports['qb-management']:AddMoney(societyName, societyPaid)
    -- exports['qb-banking']:AddMoney(societyName, societyPaid)
end