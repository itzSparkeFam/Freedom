local inJacuzzi, makeLocs = false, false

function makeLoc()
	if makeLocs then return end
	for k, loc in pairs(Locations) do
		if loc.enable then
			local bossroles = {}
			while not Jobs do Wait(10) end
			if not loc.job and not loc.gang then
				print("^1Error^7: ^1Skipping location^7. ^2No Job or Gang Set^7")
				return
			end
			if not Jobs[loc.job] and not Jobs[loc.gang] and not Gangs[loc.gang] then
				print("^1Error^7: ^1Skipping location^7. ^2Can't find the job/gang ^7'^6"..(loc.job or loc.gang).."^7' ^2in ^6Jobs^7")
				return
			end
			bossroles = (loc.job and Jobs[loc.job] or (loc.gang and (Jobs[loc.gang] or Gangs[loc.gang]))) and makeBossRoles(loc.job or loc.gang) or bossroles
			if loc.autoClock and (loc.autoClock.enter or loc.autoClock.exit) then
				createPoly({ points = loc.zones, name = loc.label,
					onEnter = function()
						if loc.autoClock.enter then if not onDuty and hasJob(loc.job) then toggleDuty() end end
					end,
					onExit = function()
						if loc.autoClock and loc.autoClock.exit then if onDuty and hasJob(loc.job) then toggleDuty() end end
					end,
					debug = Config.System.Debug,
				})
			end

			if loc.blip then
				makeBlip({
					coords = loc.blip.coords,
					sprite = loc.blip.blipsprite,
					col = loc.blip.blipcolor,
					scale = loc.blip.blipscale,
					disp = loc.blip.blipdisp,
					category = loc.blip.blipcat,
					name = loc.label,
					preview = (loc.blip.previewImg and loc.blip.previewImg) or (loc.logo and loc.logo) or nil,
				})
			end

			createTarget("Stash", loc.Stash, k, loc, bossroles)
			createTarget("Shop", loc.Shop, k, loc, bossroles)
			createTarget("Crafting", loc.Crafting, k, loc, bossroles)
			createTarget("PublicStash", loc.PublicStash, k, loc, bossroles)
			createTarget("Payments", loc.Payments, k, loc, bossroles)
			createTarget("Clockin", loc.Clockin, k, loc, bossroles)
			createTarget("BossMenus", loc.BossMenus, k, loc, bossroles)
			createTarget("WashHands", loc.WashHands, k, loc, bossroles)
			createTarget("Toilets", loc.Toilets, k, loc, bossroles)
			createTarget("Doors", loc.Doors, k, loc, bossroles)

			if loc.PropAdd and loc.PropAdd[1] then
				for i, target in ipairs(loc.PropAdd) do
					local prop = makeProp({ prop = target.prop, coords = target.coords }, true, false)
					if target.prop == "prop_strip_pole_01" then
						SetEntityAlpha(prop, 0) DisableCamCollisionForEntity(prop)
					end
				end
			end
			if loc.PropHide and loc.PropAdd[1] then
				for i, target in ipairs(loc.PropHide) do
					CreateModelHide(target.coords, 1.0, target.prop, true)
				end
			end

			if loc.Jacuzzi and loc.Jacuzzi[1] then
				for i, target in ipairs(loc.Jacuzzi) do
					local name = GetCurrentResourceName()..":"..k..":Jacuzzi["..i.."]"
					createCirclePoly({
						name = name,
						coords = target.coords,
						radius = 1.25,
						onEnter = function()
							inJacuzzi = true
							CreateThread(function()
								while inJacuzzi do
									Wait(5000)
									TriggerServerEvent('hud:server:RelieveStress', Config.General.JacuzzisStress)
								end
								Wait(100)
							end)
						end,
						onExit = function()
							inJacuzzi = false
						end,
						debug = Config.System.Debug,
					})
				end
			end

		end
	end
	makeLocs = true
end

function createTarget(type, targets, id, loc, bossroles)
	if not targets or not targets[1] then return end
	for i, target in ipairs(targets) do
		local name = GetCurrentResourceName()..":"..id..":"..type.."["..i.."]"
		local coords = target.coords.xyz
		local minZ = target.minZ or coords.z-0.5
		local maxZ = target.maxZ or coords.z+1
		createBoxTarget({ name, target.coords.xyz, target.w, target.d, { name = name, heading = target.coords.w, debugPoly = Config.System.Debug, minZ = minZ, maxZ = maxZ }},
			{{
				action = function()
					if type == "Stash" then
						openStash({ job = loc.job, gang = loc.gang, stash = target.stashName, coords = target.coords.xyz })
					elseif type == "Shop" then
						openShop({ job = loc.job, gang = loc.gang, shop = target.shopName, items = target.items, coords = target.coords.xyz })
					elseif type == "Crafting" then
						craftingMenu({ job = loc.job, gang = loc.gang, craftable = target.craftable, coords = target.coords.xyz, stashName = target.StashCraft })
					elseif type == "PublicStash" then
						openStash({ stash = target.stashName, coords = target.coords.xyz })
					elseif type == "Payments" then
						TriggerEvent("jim-payments:client:Charge", { job = loc.job, gang = loc.gang, coords = target.coords.xyz, img = loc.logo })
					elseif type == "Clockin" then
						toggleDuty()
					elseif type == "BossMenus" then
						TriggerEvent("qb-bossmenu:client:OpenMenu")
					elseif type == "WashHands" then
						washHands({ coords = coords })
					elseif type == "Toilets" then
						useToilet({ sitcoords = coords, urinal = target.urinal })
					elseif type == "Doors" then
						useDoor({ telecoords = target.telecoords })
					end
				end,
				icon = target.icon, label = target.label..(Config.System.Debug == true and " ["..name.."]" or ""),
				job = (type ~= "Toilets") and (type ~= "WashHands") and (type ~= "PublicStash") and loc.job or nil,
				gabg = (type ~= "Toilets") and (type ~= "WashHands") and (type ~= "PublicStash") and loc.gabg or nil,
			},
			(type == "Payments") and (Config.General.showClockInTill and { action = function() toggleDuty() end, job = loc.job, gang = loc.gang, icon = "fas fa-user-check", label = Loc[Config.Lan].target["duty"], } or nil) or nil,
			(type == "Payments") and (Config.General.showBossMenuTill and { action = function() TriggerEvent("qb-bossmenu:client:OpenMenu") end, job = (loc.job and bossroles), gang = (loc.gang and bossroles), icon = "fas fa-list", label = Loc[Config.Lan].target["boss"], } or nil) or nil,

		}, 2.0)

		if target.prop then makeProp({ prop = target.prop.model, coords = target.prop.coords }, true, false) end
	end
end