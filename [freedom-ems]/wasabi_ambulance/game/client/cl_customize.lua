-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end
ESX = nil
QBCore = nil
if wsb.framework == 'esx' then
	ESX = exports['es_extended']:getSharedObject() -- Custom esx object?
end
if wsb.framework == 'qb' then
	QBCore = exports['qb-core']:GetCoreObject()
end

IsDispatched = false
local canRespawn = false
----------------------------------------------------------------
-- Customize text ui, notifications, target and more with the --
-- "wasabi_bridge" dependency in the "customize" directory    --
-- "wasabi_bridge/customize/cl_customize.lua"                 --
----------------------------------------------------------------


RegisterNetEvent('wasabi_ambulance:resetStatus', function() -- Set your own custom hunger/thirst reset logic?
	if wsb.framework == 'esx' then
		TriggerEvent('esx_status:set', 'hunger', 1000000)
		TriggerEvent('esx_status:set', 'thirst', 1000000)
	elseif wsb.framework == 'qb' then
		TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', 100)
		TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', 100)
	end
	if Config.MythicHospital then
		TriggerEvent('mythic_hospital:client:RemoveBleed')
		TriggerEvent('mythic_hospital:client:ResetLimbs')
	end
end)

RegisterNetEvent('wasabi_ambulance:customInjuryClear', function()
	-- Set your own custom injury clear logic?
	-- Good for 3rd party injury scripts
	-- will be triggered on all revive events
end)

SetCarFuel = function(vehicle, value)
	if Config.FuelSystem == 'ox' then
		Entity(vehicle).state.fuel = value
	elseif Config.FuelSystem == 'legacy' then
		exports.LegacyFuel.SetFuel(vehicle, value)
	else
		SetVehicleFuelLevel(vehicle, value)
	end
end

SendDistressSignal = function() -- Edit distress signal to implement custom dispatch
	TriggerEvent('wasabi_bridge:notify', Strings.distress_sent_title, Strings.distress_sent_desc, 'success')
	local ped = wsb.cache.ped
	local myPos = GetEntityCoords(ped)
	myPos = vector3(myPos.x, myPos.y, myPos.z)
	if Config.phoneDistress == 'gks' then
		local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
		ESX.TriggerServerCallback('gksphone:namenumber', function(Races)
			local name = Races[2].firstname .. ' ' .. Races[2].lastname
			TriggerServerEvent('gksphone:gkcs:jbmessage', name, Races[1].phone_number, 'Emergency aid notification', '',
				GPS, '["ambulance"]', false)
		end)
	elseif Config.phoneDistress == 'qs' then
		local jobs = Config.ambulanceJobs or Config.ambulanceJob
		if jobs and type(jobs) == 'table' then
			for i = 1, #jobs do
				TriggerServerEvent('qs-smartphone:server:sendJobAlert', {
					message = 'Injured person',
					location = myPos
				}, jobs[i])
			end
			goto continue
		end
		TriggerServerEvent('qs-smartphone:server:sendJobAlert', {
			message = 'Injured person',
			location = myPos
		}, jobs)
		::continue::
		TriggerServerEvent('qs-smartphone:server:AddNotifies', {
			head = "Injured person",
			msg = 'Injured person',
			app = 'business'
		})
	elseif Config.phoneDistress == 'd-p' then
		local jobs = Config.ambulanceJobs or Config.ambulanceJob
		if jobs and type(jobs) == 'table' then
			for i = 1, #jobs do
				TriggerEvent('d-phone:client:message:senddispatch', 'Unconscious person', jobs[i])
			end
			goto continue
		end
		TriggerEvent('d-phone:client:message:senddispatch', 'Unconscious person', jobs)
		::continue::
		TriggerEvent('d-notification', 'Service Message sended', 5000, 'success')
	elseif Config.phoneDistress == 'lb' then
		local jobs = Config.ambulanceJobs or Config.ambulanceJob
		if jobs and type(jobs) == 'table' then
			for i = 1, #jobs do
				exports["lb-phone"]:SendCompanyMessage(jobs[i], 'Unconscious person')
				exports["lb-phone"]:SendCompanyCoords(jobs[i])
			end
		end
	elseif Config.phoneDistress == 'yseries' then
		local jobs = Config.ambulanceJobs or Config.ambulanceJob
		if jobs and type(jobs) == 'table' then
			for i = 1, #jobs do
				exports["yseries"]:SendCompanyMessage(jobs[i], 'A citizen is in need of medical assistance',
					{ x = myPos.x, y = myPos.y }, false)
			end
		else
			exports["yseries"]:SendCompanyMessage(jobs, 'A citizen is in need of medical assistance',
				{ x = myPos.x, y = myPos.y }, false)
		end
	elseif Config.phoneDistress == 'rcore_dispatch' then
		local data = {
			code = '911 Emmergency',
			default_priority = 'high',
			coords = myPos,
			job = 'ambulance',
			text = '911 - EMS Unit Required',
			type = 'alerts',
			blip_time = 5,
			blip = {
				sprite = 75,
				colour = 1,
				scale = 1.5,
				text = '911 - EMS',
				flashes = true,
				radius = 0,
			}
		}
		local jobs = Config.ambulanceJobs or Config.ambulanceJob
		if jobs and type(jobs) == 'table' then
			for i = 1, #jobs do
				data.job = jobs[i]
				TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
			end
			goto continue
		end
		data.job = jobs
		TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
		::continue::
	elseif Config.phoneDistress == 'redutzu_dispatch' then
		TriggerServerEvent('redutzu-ems:server:addDispatchToEMS', {
			code = '10-12',
			title = 'Unconscious person',
			duration = 5000,
			coords = myPos
		})
	elseif Config.phoneDistress == 'cd_dispatch' then
		local data = exports['cd_dispatch']:GetPlayerInfo()
		TriggerServerEvent('cd_dispatch:AddNotification', {
			job_table = Config.ambulanceJobs or { Config.ambulanceJob },
			coords = myPos,
			title = '10-15 - Injured person',
			message = 'A ' .. data.sex .. ' needs medical assistance at ' .. data.street,
			flash = 0,
			unique_id = data.unique_id,
			sound = 1,
			blip = {
				sprite = 431,
				scale = 1.2,
				colour = 3,
				flashes = false,
				text = '911 - Injured Person',
				time = 5,
				radius = 0,
			}
		})
	elseif Config.phoneDistress == 'qs_dispatch' then
		local playerData = exports['qs-dispatch']:GetPlayerInfo()
		local data = {
			job = 'ambulance',
			callLocation = playerData.coords,
			callCode = { code = 'Distress Signal', snippet = '' },
			message = "We have a distress signal concerning a " .. playerData.sex .. " at " .. playerData.street_1 .. "!",
			flashes = true,
			image = nil,
			blip = {
				sprite = 153,
				scale = 1.5,
				colour = 1,
				flashes = true,
				text = 'Distress Signal',
				time = (60 * 1000), --60 secs
			}
		}
		local jobs = Config.ambulanceJobs or Config.ambulanceJob
		if jobs and type(jobs) == 'table' then
			for i = 1, #jobs do
				data.job = jobs[i]
				TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', data)
			end
			goto continue
		end
		data.job = jobs
		TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', data)
		::continue::
	else
		TriggerServerEvent('wasabi_ambulance:onPlayerDistress') -- To add your own dispatch, comment this line out and add into here
	end
end

AddEventHandler('wasabi_ambulance:changeClothes', function(data)
	local gender = wsb.getGender()
	if not gender or gender == 0 or gender == 'm' then gender = 'male' end
	if gender == 'f' or gender == 1 then gender = 'female' end
	if data == 'civ_wear' then
		RemoveClothingProps()
		RequestCivilianOutfit()
		return
	end
	if type(data) ~= 'table' then return end
	SaveCivilianOutfit()
	RemoveClothingProps()
	if data[gender] and data[gender].clothing and next(data[gender].clothing) then
		for _, clothing in pairs(data[gender].clothing) do
			SetPedComponentVariation(wsb.cache.ped, clothing.component, clothing.drawable, clothing.texture, 0)
		end
	end
	if data[gender] and data[gender].props and next(data[gender].props) then
		for _, prop in pairs(data[gender].props) do
			SetPedPropIndex(wsb.cache.ped, prop.component, prop.drawable, prop.texture, true)
		end
	end
end)

-- Death screen related editables
function StartDeathTimer()
	canRespawn = false
	if not Config.DisableDeathAnimation then
		SetGameplayCamRelativeHeading(-360)
	end
	local earlySpawnTimer = math.floor(Config.RespawnTimer / 1000)
	local bleedoutTimer = math.floor(Config.BleedoutTimer / 1000)

	SendNUIMessage({
		action = 'displayDeathScreen',
		counter = earlySpawnTimer,
		dispatched = false,
		canRespawn = canRespawn,
		type = Config.DeathScreenType,
		color = Config.UIColor,
		translationStrings = UIStrings,
		emsOnline = EMSAvailable or 0,
		showCount = Config.ShowEMSCountOnDeath or false
	})

	CreateThread(function()
		while earlySpawnTimer > 0 and isDead do
			Wait(1000)
			if not wsb.playerLoaded then
				HideDeathNui()
				break
			end
			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
				if not IsCheckedIn and isDead then
					SendNUIMessage({
						action = 'updateDeathScreen',
						counter = earlySpawnTimer,
						dispatched = IsDispatched and true or false,
						canRespawn = canRespawn,
						emsOnline = EMSAvailable or 0,
						color = Config.UIColor,
						type = Config.DeathScreenType,
						showCount = Config.ShowEMSCountOnDeath or false
					})
				else
					HideDeathNui()
					break
				end
			end
		end
		while bleedoutTimer > 0 and isDead do
			if isDead == 'laststand' then SetEntityHealth(wsb.cache.ped, 0) end
			Wait(1000)
			if not wsb.playerLoaded then
				HideDeathNui()
				break
			end
			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
				if not IsCheckedIn and isDead then
					SendNUIMessage({
						action = 'updateDeathScreen',
						counter = bleedoutTimer,
						dispatched = IsDispatched or false,
						canRespawn = canRespawn,
						emsOnline = EMSAvailable or 0,
						color = Config.UIColor,
						type = Config.DeathScreenType,
						showCount = Config.ShowEMSCountOnDeath or false
					})
				else
					HideDeathNui()
					break
				end
			end
		end
	end)


	CreateThread(function()
		local timeHeld = 0
		while earlySpawnTimer > 0 and isDead do
			Wait(0)
			if not IsDispatched then
				if IsControlJustReleased(0, 47) then --Old 47
					IsDispatched = true
					SendDistressSignal()
				end
			else
				Wait(1000)
			end
		end
		while bleedoutTimer > 0 and isDead do
			Wait(0)
			if not IsDispatched then
				if IsControlJustReleased(0, 47) then --Old 47
					IsDispatched = true
					SendDistressSignal()
				end
			end
			if not canRespawn then
				SendNUIMessage({
					action = 'updateDeathScreen',
					counter = bleedoutTimer,
					dispatched = IsDispatched or false,
					canRespawn = true,
					emsOnline = EMSAvailable or 0,
					color = Config.UIColor,
					type = Config.DeathScreenType,
					showCount = Config.ShowEMSCountOnDeath or false
				})
				canRespawn = true
			end
			if not IsCheckedIn then
				if IsControlPressed(0, 38) and timeHeld > 60 then
					StartRPDeath()
					break
				end
				if IsControlPressed(0, 38) then
					timeHeld = timeHeld + 1
				else
					timeHeld = 0
				end
			else
				Wait(1000)
			end
		end
		if bleedoutTimer < 1 and isDead then
			StartRPDeath()
		end
	end)
end

function OnPlayerDeath(stagetwo)
	if not isDead or isDead ~= 'dead' then
		isDead = 'dead'
		TriggerServerEvent('wasabi_ambulance:setDeathStatus', 'dead', true)
		DrugIntake = {}
		if not stagetwo then
			StartDeathTimer()
		end
		startDeathAnimation(false)
	else
		startDeathAnimation(true)
	end
	if Config.CompleteDeath.enabled and wsb.framework == 'esx' then
		TriggerServerEvent('wasabi_ambulance:deathCount')
	end
end

-- Job menu edits?
function OpenJobMenu()
	if not wsb.hasGroup(Config.ambulanceJobs or Config.ambulanceJob) then return end
	if isPlayerDead() then return end
	if not wsb.isOnDuty() then return end
	Options = {
		{
			title = Strings.dispatch,
			description = Strings.dispatch_desc,
			icon = 'truck-medical',
			arrow = true,
			event = 'wasabi_ambulance:dispatchMenu',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.diagnose_patient,
			description = Strings.diagnose_patient_desc,
			icon = 'stethoscope',
			arrow = false,
			event = 'wasabi_ambulance:diagnosePlayer',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.revive_patient,
			description = Strings.revive_patient_desc,
			icon = 'kit-medical',
			arrow = false,
			event = 'wasabi_ambulance:reviveTarget',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.heal_patient,
			description = Strings.heal_patient_desc,
			icon = 'bandage',
			arrow = false,
			event = 'wasabi_ambulance:healTarget',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.place_patient,
			description = Strings.place_patient_desc,
			icon = 'car',
			arrow = false,
			event = 'wasabi_ambulance:placeInVehicle',
			disabled = isPlayerDead() == true
		}
	}
	if Config.EnviPrescriptions.enabled then
		local _job, grade = wsb.hasGroup(Config.ambulanceJobs or Config.ambulanceJob)
		if grade and grade >= Config.EnviPrescriptions.minRank then
			Options[#Options + 1] = {
				title = Strings.prescription_menu,
				description = Strings.prescription_menu_desc,
				icon = 'pills',
				arrow = true,
				event = 'envi-prescriptions:openPrescriptionsMenu',
				disabled = isPlayerDead() == true
			}
		end
	end
	Options[#Options + 1] = {
		title = Strings.sedate_patient,
		description = Strings.sedate_patient_desc,
		icon = 'syringe',
		arrow = false,
		event = 'wasabi_ambulance:useSedative',
		disabled = isPlayerDead() == true
	}
	Options[#Options + 1] = {
		title = Strings.toggle_stretcher,
		description = Strings.toggle_stretcher_desc,
		icon = 'bed',
		arrow = false,
		event = 'wasabi_ambulance:toggleStretcher',
		disabled = isPlayerDead() == true
	}

	if Config?.wasabi_crutch?.crutchInJobMenu then
		Options[#Options + 1] = {
			title = Strings.menu_crutch,
			description = Strings.menu_crutch_desc,
			icon = 'crutch',
			arrow = false,
			event = 'wasabi_ambulance:crutchMenu',
			disabled = isPlayerDead() == true
		}

		Options[#Options + 1] = {
			title = Strings.menu_remove_crutch,
			description = Strings.menu_remove_crutch_desc,
			icon = 'crutch',
			arrow = false,
			event = 'wasabi_ambulance:crutchRemoveMenu',
			disabled = isPlayerDead() == true
		}
	end
	if Config?.wasabi_crutch?.chairInJobMenu then
		Options[#Options + 1] = {
			title = Strings.menu_chair,
			description = Strings.menu_chair_desc,
			icon = 'wheelchair',
			arrow = false,
			event = 'wasabi_ambulance:chairMenu',
			disabled = isPlayerDead() == true
		}

		Options[#Options + 1] = {
			title = Strings.menu_remove_chair,
			description = Strings.menu_remove_chair_desc,
			icon = 'wheelchair',
			arrow = false,
			event = 'wasabi_ambulance:chairRemoveMenu',
			disabled = isPlayerDead() == true
		}
	end

	if Config.billingSystem then
		Options[#Options + 1] = {
			title = Strings.bill_patient,
			description = Strings.bill_patient_desc,
			icon = 'file-invoice',
			arrow = false,
			event = 'wasabi_ambulance:billPatient',
			disabled = isPlayerDead() == true
		}
	end

	if Config.MobileMenu.enabled then
		wsb.showMenu({
			id = 'ems_job_menu',
			color = Config.UIColor,
			title = Strings.JobMenuTitle,
			position = Config.MobileMenu.position,
			options = Options
		})
		return
	end

	wsb.showContextMenu({
		id = 'ems_job_menu',
		color = Config.UIColor,
		title = Strings.JobMenuTitle,
		options = Options
	})
end

-- Medbag menu edits?
function InteractBag()
	if isPlayerDead() then return end
	if wsb.hasGroup(Config.ambulanceJobs or Config.ambulanceJob) or (Config.policeCanTreat.enabled and wsb.hasGroup(Config.policeCanTreat.jobs)) then
		local Options = {
			{
				title = Strings.medbag_tweezers,
				description = Strings.medbag_tweezers_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.TreatmentItems.shot }
			},
			{
				title = Strings.medbag_suture,
				description = Strings.medbag_suture_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.TreatmentItems.stabbed }
			},
			{
				title = Strings.medbag_icepack,
				description = Strings.medbag_icepack_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.TreatmentItems.beat }
			},
			{
				title = Strings.medbag_burncream,
				description = Strings.medbag_burncream_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.TreatmentItems.burned }
			},
			{
				title = Strings.medbag_defib,
				description = Strings.medbag_defib_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.EMSItems.revive.item }
			},
			{
				title = Strings.medbag_medikit,
				description = Strings.medbag_medikit_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.EMSItems.heal.item }
			},
			{
				title = Strings.medbag_sedative,
				description = Strings.medbag_sedative_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.EMSItems.sedate.item }
			}

		}
		if Config?.wasabi_crutch?.crutchInMedbag?.enabled then
			Options[#Options + 1] = {
				title = Strings.medbag_crutch,
				description = Strings.medbag_crutch_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.wasabi_crutch.crutchInMedbag.item }
			}
		end
		if Config?.wasabi_crutch?.chairInMedbag?.enabled then
			Options[#Options + 1] = {
				title = Strings.medbag_chair,
				description = Strings.medbag_chair_desc,
				arrow = false,
				event = 'wasabi_ambulance:gItem',
				args = { item = Config.wasabi_crutch.chairInMedbag.item }
			}
		end

		local menu = Config.MobileMenu.enabled and 'showMenu' or 'showContextMenu'

		wsb[menu]({
			id = 'medbag',
			title = Strings.medbag,
			color = Config.UIColor,
			position = Config.MobileMenu.position,
			options = Options
		})
	else
		TriggerEvent('wasabi_bridge:notify', Strings.not_medic, Strings.not_medic_desc, 'error')
	end
end
