local activeCooldown = false

CreateThread(function()
    if Config.Cloth == Cloth.CODEM then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

			local outfit = ClothingService.ConvertClothingComponents(Cloth.SKINCHANGER, outfitData)

			if outfit then
				TriggerEvent(Config.FrameworkEvents['skinchanger:getSkin'], function(skin)
					TriggerEvent(Config.FrameworkEvents['skinchanger:loadClothes'], skin, outfit)
				end)
			end
		end

		RestoreCivilOutfit = function()
			if activeCooldown then
				return dbg.debug('Please wait few seconds, before restoring outfit again!')
			end

			activeCooldown = true

			SetTimeout(5 * 1000, function()
				activeCooldown = false
			end)

            TriggerEvent("codem-appearance:reloadSkin")
		end
    end
end)

