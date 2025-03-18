RegisterServerEvent("LicenseManager:server:AddLicense", function(license, mugshot, creator, fake, playerId)
	local job = Config.Licenses[fake and license.license or license].manager
	local source = playerId or source
	local xPlayer = GetPlayerFromId(source)
	if xPlayer then
		if fake then
			CreateLicense(xPlayer, license.license, job, mugshot, license)
		else
			CheckLicense(source, license, function(have)
				if not have then
					CreateLicense(xPlayer, license, job, mugshot)
					TriggerEvent("LicenseManager:server:addHistory", GetName(xPlayer), xPlayer.identifier,
						os.date("%d/%m/%Y"),
						license,
						creator or "System", "Create")
				elseif Config.inventory and not Config.Licenses[license].nonItem then
					if not InventoryHasItem(xPlayer, license) then
						RetrieveLicense(xPlayer, license)
					end
				else
					TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"], Locale
						["already_have_license"], "error", 3000)
				end
			end)
		end
	end
end)

RegisterServerEvent("LicenseManager:server:CreateFakeLicense", function(manager, data, playerId)
	local xPlayer = GetPlayerFromId(playerId or source)
	if xPlayer then
		TriggerClientEvent("LicenseManager:client:AddLicense", xPlayer.source, data, manager, true)
	end
end)

RegisterServerEvent("LicenseManager:server:CreateLicense", function(manager, target, license, price, creator, playerId)
	local xTarget = GetPlayerFromId(target)
	local source = playerId or source
	local xPlayer = GetPlayerFromId(source)

	if xTarget then
		if Config.Licenses[license].requires then
			for _, v in pairs(Config.Licenses[license].requires) do
				if not HasLicense(target, v) then
					TriggerClientEvent('LicenseManager:notify', source, Locale['license_manager'],
						string.format(Locale['license_required'], GetName(xTarget), Config.Licenses[v].label,
							Config.Licenses[license].label))
					return
				end
			end
		end
		CheckLicense(target, license, function(have)
			if not have then
				if Config.Manager[manager].disableBuy then
					TriggerClientEvent("LicenseManager:notify", xPlayer.source, Locale["license_manager"],
						Locale["only_renew_lost"], "error", 3000)
					return
				end
				if GetMoney(xTarget) >= price then
					RemoveMoney(xTarget, "money", price)
				elseif GetAccount(xTarget, 'bank') >= price then
					RemoveMoney(xTarget, 'bank', price)
				else
					TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"],
						Locale["player_not_enough_money"], "error", 3000)
					return
				end
				if Config.society then
					if type(Config.Licenses[license].job) ~= "table" then
						AddToSociety(Config.Licenses[license].job, price)
					else
						AddToSociety(Config.Licenses[license].job[1], price)
					end
				end
				TriggerClientEvent("LicenseManager:client:AddLicense", target, license, creator or GetName(xPlayer))
				TriggerClientEvent("LicenseManager:notify", target, Locale["license_manager"],
					string.format(Locale["license_received"], Config.Licenses[license].label), "success", 3000)
				TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"],
					string.format(Locale["license_created"], Config.Licenses[license].label, GetName(xTarget)),
					"success", 3000)
			elseif
				Config.inventory
				and not Config.Licenses[license].nonItem and not InventoryHasItem(xTarget, license)
			then
				RetrieveLicense(xTarget, license)
				TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"],
					string.format(Locale["player_license_retrieved"], Config.Licenses[license].label, GetName(xTarget)),
					"success", 3000)
			else
				TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"],
					string.format(Locale["player_have_license"], Config.Licenses[license].label, GetName(xTarget)),
					"error", 3000)
			end
		end)
	end
end)

RegisterServerEvent("LicenseManager:server:RenewLicense", function(owner, license, mugshot, creator)
	local xPlayer = GetPlayerFromIdentifier(owner)
	if xPlayer and creator then
		local data = GenerateLicenseData(license, xPlayer, mugshot)

		InventorySetItem(xPlayer, license, data)

		if type(creator) == "number" then
			TriggerClientEvent("LicenseManager:notify", creator, Locale["license_manager"], Locale["license_renewed"],
				"success", 3000)
		end
		TriggerClientEvent("LicenseManager:notify", xPlayer.source, Locale["license_manager"],
			Locale["citizen_license_renewed"], "success", 3000)
		TriggerEvent("LicenseManager:server:addHistory", GetName(xPlayer), xPlayer.identifier, os.date("%d/%m/%Y"),
			license,
			type(creator) == "string" and creator or GetName(GetPlayerFromId(creator)),
			"Renew")

		MySQL.Async.execute("UPDATE licenses SET name = @name, data = @data WHERE owner = @owner AND license = @license",
			{
				['@name'] = GetName(xPlayer),
				["@data"] = json.encode(data),
				["@owner"] = xPlayer.identifier,
				["@license"] = license,
			})
	end
end)

RegisterServerEvent("LicenseManager:server:BeginRenew", function(license, owner, playerId)
	local source = playerId or source
	local xPlayer = GetPlayerFromId(source)
	if owner then
		local xTarget = GetPlayerFromIdentifier(owner)
		if xTarget then
			TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"], Locale["renewing_license"],
				"info",
				3000)
			TriggerClientEvent("LicenseManager:client:GetMugshotRenew", xTarget.source, owner, license, source)
		else
			TriggerClientEvent("LicenseManager:notify", source, Locale["license_manager"],
				Locale["player_offline"], "error", 3000)
		end
	else
		MySQL.Async.fetchAll(
			"SELECT owner, license FROM licenses WHERE license=@license AND owner=@owner",
			{ ["@license"] = license, ["@owner"] = xPlayer.identifier },
			function(result)
				if result[1] then
					TriggerClientEvent("LicenseManager:client:GetMugshotRenew", source, result[1].owner,
						result[1].license,
						"Shop")
				end
			end
		)
	end
end)

RegisterServerEvent("LicenseManager:server:RevokeLicense", function(owner, license, data, playerId)
	local source = playerId or source
	RevokeLicense(owner, license, source, data)
end)

lib.callback.register('LicenseManager:server:GetDBLicenses', function(source, target)
	local Player = GetPlayerFromId(target)
	if Player then
		MySQL.Async.fetchAll('SELECT license, data FROM ' .. Config.Database.license .. ' WHERE owner = @identifier',
			{ ['identifier'] = Player.identifier }, function(result)
				local licenses = {}
				for k, v in pairs(result) do
					table.insert(licenses, {
						type = v.license,
						label = Config.Licenses[v.license].label,
						data = json.decode(v.data)
					})
				end
				return licenses
			end
		)
	end
	return {}
end)

RegisterServerEvent("esx_license:removeLicense", function(target, license, src)
	local source = src or source
	RevokeLicense(target, license, source)
end)

-- esx_license backwards compability

AddEventHandler("esx_license:getLicense", function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler("esx_license:getLicenses", function(target, cb)
	GetLicenses(target, cb)
end)

AddEventHandler("esx_license:checkLicense", function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler("esx_license:getLicensesList", function(cb)
	GetLicensesList(cb)
end)

CreateThread(function()
	RegisterServerCallback("esx_license:getLicense", function(source, cb, type)
		GetLicense(type, cb)
	end)

	RegisterServerCallback("esx_license:getLicenses", function(source, cb, target)
		GetLicenses(target, cb)
	end)

	RegisterServerCallback("esx_license:checkLicense", function(source, cb, target, type)
		CheckLicense(target, type, cb)
	end)

	RegisterServerCallback("esx_license:getLicensesList", function(source, cb)
		GetLicensesList(cb)
	end)
end)
