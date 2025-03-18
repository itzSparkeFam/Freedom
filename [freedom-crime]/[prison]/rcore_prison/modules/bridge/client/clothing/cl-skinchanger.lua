local activeCooldown = false

CreateThread(function()
    if Config.Cloth == Cloth.SKINCHANGER then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

			local outfit = ClothingService.ConvertClothingComponents(Cloth.SKINCHANGER, outfitData)

			dbg.debugClothing('ApplyOutfit: Using skinchanger.')

			if outfit then
				TriggerEvent(Config.FrameworkEvents['skinchanger:getSkin'], function(skin)
					TriggerEvent(Config.FrameworkEvents['skinchanger:loadClothes'], skin, outfit)
				end)
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

			Framework.object.TriggerServerCallback(Config.FrameworkEvents['esx_skin:getPlayerSkin'], function(skin)
				repeat
					Wait(1000)
				until skin ~= nil

				TriggerEvent(Config.FrameworkEvents['skinchanger:loadSkin'], skin)
			end)
		end
    end
end)

