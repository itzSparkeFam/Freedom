RegisterNetEvent('MrNewbVehicleKeys:Server:SendLog', function(data)
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	Bridge.Utility.SendLog(src, "Player:  | ID#" .. src .. " | "..identifier.." | ".. data)
end)

function RemoveAccountBalance(src, account, price)
	return Bridge.Framework.RemoveAccountBalance(src, account, price)
end

function GetAccountBalance(src, account)
	return Bridge.Framework.GetAccountBalance(src, account)
end

function NotifyPlayer(src, message, _type)
    if not _type then _type = "success" end
	return Bridge.Notify.SendNotify(src, message, _type, 6000)
end

function GetPlayerIdentifier(src)
	return Bridge.Framework.GetPlayerIdentifier(src)
end