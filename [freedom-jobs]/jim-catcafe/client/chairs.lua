local seat, Chairs = 0, {}

CreateThread(function()
	for k in pairs(Locations) do
		if Locations[k].enable then
			for v in pairs(Locations[k]) do
				if v == "Chairs" then
					for i = 1, #Locations[k].Chairs do
						local loc = Locations[k].Chairs[i]
						local name = GetCurrentResourceName()..":"..k..":Chair["..i.."]"
						Chairs[name] =
							createBoxTarget({name, vec3(loc.coords.x, loc.coords.y, loc.coords.z-1), 0.6, 0.6, { name=name, heading = loc.coords.w, debugPoly=Config.System.Debug, minZ = loc.coords.z-1.2, maxZ = loc.coords.z+0.1, } },
								{ { action = function()
										TriggerEvent(GetCurrentResourceName()..":Chair", { loc = loc.coords, stand = loc.stand })
									end,
									icon = "fas fa-chair",
									label = Loc[Config.Lan].target["sit"],
								}, },
							2.2)
					end
				end
			end
		end
	end
end)

RegisterNetEvent(GetCurrentResourceName()..':Chair', function(data)
	local canSit = true
	local sitting = false
	local ped = PlayerPedId()

    local players = {}
    local activePlayers = GetActivePlayers()
    for i = 1, #activePlayers do
        local ped = GetPlayerPed(activePlayers[i])
        if DoesEntityExist(ped) then players[#players+1] = activePlayers[i] end
    end

    for i = 1, #players do
		local targetdistance = #(GetEntityCoords(GetPlayerPed(players[i])) - data.loc.xyz)
		if targetdistance <= 0.4 then
			triggerNotify(nil, Loc[Config.Lan].error["someone_sitting_here"])
			canSit = false
		end
    end

	if canSit then
		if not IsPedHeadingTowardsPosition(ped, data.loc.xyz, 20.0) then TaskTurnPedToFaceCoord(ped, data.loc.xyz, 1500) Wait(1500)	end
		if #(data.loc.xyz - GetEntityCoords(PlayerPedId())) > 1.5 then TaskGoStraightToCoord(ped, data.loc.xyz, 0.5, 1000, 0.0, 0) Wait(1100) end
		TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", data.loc.x, data.loc.y, data.loc.z-0.5, data.loc[4], 0, 1, true)
		seat = data.stand
		sitting = true
	end
	drawText(nil, {(Config.System.drawText == "gta" and "~INPUT_CELLPHONE_CANCEL~" or "[Backspace]").." Stand up"}, "g")
	while sitting do
		if sitting then
			if IsControlJustReleased(0, 202) and IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER") then
				sitting = false
				hideText()
				ClearPedTasks(ped)
				if seat then SetEntityCoords(ped, seat) end
				seat = nil
			end
		end
		Wait(5) if not IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER") then
			sitting = false
		end
	end
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	for k in pairs(Chairs) do removeZoneTarget(Chairs[k]) end
end)