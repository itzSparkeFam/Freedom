local activeCooldown = false

CreateThread(function()
    if Config.Cloth == Cloth.IAPPEARANCE then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

			local plyPed = PlayerPedId()
			local pedModel = GetEntityModel(plyPed)
			local pedModelReadable = GetEntityArchetypeName(plyPed)
	
			local allowedModels = {
				[`mp_m_freemode_01`] = true,
				[`mp_f_freemode_01`] = true,
			}
	
			if not allowedModels[pedModel] then
				return dbg.info('Player model not allowed for Illenium-appearance to apply outfit player model detected: (%s) supported: (mp_m_freemode_01, mp_f_freemode_01)', pedModelReadable)
			end


			if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
				dbg.debugClothing('ApplyOutfit: Using qb-clothing emulation for Illenium')

				local outfit = ClothingService.ConvertClothingComponents(Cloth.QB, outfitData)

				if outfit then
					TriggerEvent(Config.FrameworkEvents['qb-clothing:client:loadOutfit'], outfit)
				end
			elseif Config.Framework == Framework.ESX then
				dbg.debugClothing('ApplyOutfit: Using skinchanger emulation for Illenium')

				local outfit = ClothingService.ConvertClothingComponents(Cloth.SKINCHANGER, outfitData)

				if outfit then
					TriggerEvent(Config.FrameworkEvents['skinchanger:getSkin'], function(skin)
						TriggerEvent(Config.FrameworkEvents['skinchanger:loadClothes'], skin, outfit)
					end)
				end
			end
		end

		RestoreCivilOutfit = function()
			if not Framework.object then
				return
			end

			if activeCooldown then
				return dbg.debug('Please wait few seconds, before restoring outfit again!')
			end

			activeCooldown = true

			SetTimeout(5 * 1000, function()
				activeCooldown = false
			end)

			dbg.debugClothing('Restoring outfit!')

            if Config.Framework == Framework.ESX then
                Framework.object.TriggerServerCallback(Config.FrameworkEvents['esx_skin:getPlayerSkin'], function(apperance, skin)
                    repeat
                        Wait(1000)
                    until apperance ~= nil

                    TriggerEvent(Config.FrameworkEvents['skinchanger:loadSkin'], apperance)
                end)
            elseif Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
				TriggerServerEvent("qb-clothes:loadPlayerSkin")
				TriggerServerEvent("qb-clothing:loadPlayerSkin")
				ExecuteCommand('reloadskin')
            end
		end
    end
end)

