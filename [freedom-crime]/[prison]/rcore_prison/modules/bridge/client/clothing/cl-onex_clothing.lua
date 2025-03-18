CreateThread(function()
	if Config.Cloth == Cloth.ONEX then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

			local outfit = ClothingService.ConvertClothingComponents(Cloth.QB, outfitData)

			if outfit and outfit.outfitData then
				TriggerEvent('onex-creation:client:loadCustomOutfit', outfit.outfitData, false)
			end
		end

		RestoreCivilOutfit = function()
			dbg.debugClothing('Restoring outfit!')
			TriggerEvent('onex-creation:syncClothes', false)
		end
	end
end)
