local activeCooldown = false

CreateThread(function()
    if Config.Cloth == Cloth.NONE then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

			-- Fallback solution, maybe the resource will use emulated qb-clothing/skinchanger.

			if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
				dbg.debugClothing('ApplyOutfit: Using qb-clothing emulation as fallback')

				local outfit = ClothingService.ConvertClothingComponents(Cloth.QB, outfitData)

				if outfit then
					TriggerEvent(Config.FrameworkEvents['qb-clothing:client:loadOutfit'], outfit)
				end
			elseif Config.Framework == Framework.ESX then
				dbg.debugClothing('ApplyOutfit: Using skinchanger emulation as fallback')

				local outfit = ClothingService.ConvertClothingComponents(Cloth.SKINCHANGER, outfitData)

				if outfit then
					TriggerEvent(Config.FrameworkEvents['skinchanger:getSkin'], function(skin)
						TriggerEvent(Config.FrameworkEvents['skinchanger:loadClothes'], skin, outfit)
					end)
				end
			end

            -- This function get outfit by player ped model
            -- These 2 functions from ClothingService.ConvertClothingComponents are converting our custom clothing structure to qb-clothing/skinchanger.
            -- You can use these to convert our outfit to the qb-clothing/skinchanger and hook with your clothing resource.

            -- ClothingService.ConvertClothingComponents(Clothing.QB, outfitData)
            -- ClothingService.ConvertClothingComponents(Clothing.SKINCHANGER, outfitData)
		end

		RestoreCivilOutfit = function()
			if activeCooldown then
				return dbg.debug('Please wait few seconds, before restoring outfit again!')
			end

			activeCooldown = true

			SetTimeout(5 * 1000, function()
				activeCooldown = false
			end)

			dbg.debugClothing('Restoring outfit as fallback!')

			if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
				TriggerServerEvent("qb-clothes:loadPlayerSkin")
				TriggerServerEvent("qb-clothing:loadPlayerSkin")
			elseif Config.Framework == Framework.ESX then
				if not Framework.object then
					return
				end

				Framework.object.TriggerServerCallback(Config.FrameworkEvents['esx_skin:getPlayerSkin'], function(skin)
					repeat
						Wait(1000)
					until skin ~= nil
			
					TriggerEvent(Config.FrameworkEvents['skinchanger:loadSkin'], skin)
				end)
			end
		end
    end
end)

