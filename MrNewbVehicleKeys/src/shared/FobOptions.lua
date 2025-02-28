FobConfig = {
	EnabledButtons = {'REMOTE_START',},	-- set this to the defualt buttons you want to use --[['EXPLODE_VEHICLE','ROOF_TOGGLE', 'SELFPARK_VEHICLE', 'SUMMON_VEHICLE'-]]
    ExtraButtons = {						-- set this to the extra buttons you want to use
		{
			number 		= 1,
			action_id 	= 'REMOTE_START',
			text      	= 'Remote Start',
			description = 'This will start/stop the engine of the vehicle',
			icon      	= 'fas fa-car',
			price    	= 25000,
			canPurchase = false,
			action    	= function(vehicle)
				local engineStatus = GetIsVehicleEngineRunning(vehicle)
				SetVehicleEngineOn(vehicle, not engineStatus, true, true)
			end,
		},
		{
			number 		= 2,
			action_id 	= 'ROOF_TOGGLE',
			text      	= 'Toggle Roof',
			description = 'This will open/close the roof of the vehicle',
			icon      	= 'fas fa-car',
			price    	= 25000,
			canPurchase = false,
			action   	 = function(vehicle)
                local roofState = GetConvertibleRoofState(vehicle)
                if roofState == 2 then return RaiseConvertibleRoof(vehicle, false) end
                LowerConvertibleRoof(vehicle, false)
			end,
		},
		{
			number 		= 3,
			action_id 	= 'SELFPARK_VEHICLE',
			text      	= 'Park Vehicle',
			description = 'This will park your vehicle in the nearest parking spot',
			icon      	= 'fas fa-car',
			price    	= 25000,
			canPurchase = false,
			action    	= function(vehicle)
				DoVehicleSelfPark(vehicle)
			end,
		},
		{
			number 		= 4,
			action_id 	= 'SUMMON_VEHICLE',
			text      	= 'Summon Vehicle',
			description = 'This will summon your vehicle to your location',
			icon      	= 'fas fa-car',
			price    	= 25000,
			canPurchase = false,
			action    	= function(vehicle)
				SummonVehicle(vehicle)
			end,
		},
		{
			number 		= 5,
			action_id 	= 'AUTO_PILOT',
			text      	= 'Auto Pilot',
			description = 'This Will Drive Your Vehicle To The Set Waypoint',
			icon      	= 'fas fa-car',
			price    	= 25000,
			canPurchase = true,
			action    	= function()
				EnableAutoPilot()
			end,
		},
		{
			number 		= 6,
			action_id 	= 'DANCE_MODE',
			text      	= 'Dance Mode',
			description = 'This Will Make Your Vehicle Dance',
			icon      	= 'fas fa-car',
			price    	= 25000,
			canPurchase = true,
			action    	= function(vehicle)
				DanceMode(vehicle)
			end,
		},
		{
			number 		= 7,
			action_id 	= 'PROXIMITY_TOGGLE',
			text      	= 'Proximity Locks',
			description = 'This Will Allow You To Toggle Proximity Locks',
			icon      	= 'fas fa-car',
			price    	= 1000,
			canPurchase = true,
			action    	= function(vehicle)
				ExecuteCommand('proximitylocks')
			end,
		},
	},
}