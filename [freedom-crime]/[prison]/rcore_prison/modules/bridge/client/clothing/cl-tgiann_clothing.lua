CreateThread(function()
    if Config.Cloth == Cloth.TGIANN then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

            dbg.debug('ApplyOutfit: Using emulation for TGIANN appearance')

            local outfit = ClothingService.ConvertClothingComponents(Cloth.TGIANN, outfitData)

            if outfit then
                TriggerEvent("tgiann-clothing:changeScriptClothe", outfit)
            end
		end

		RestoreCivilOutfit = function()
            dbg.debugClothing('Restoring outfit!')
            TriggerEvent("tgiann-clothing:changeScriptClothe", false)
		end
    end
end)

