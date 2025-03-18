CreateThread(function()
    if Config.Cloth == Cloth.CRM then
		ApplyOutfit = function(data)
            local plyPed = PlayerPedId()
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

            dbg.debug('ApplyOutfit: Using emulation for CRM appearance')

            local outfit = ClothingService.ConvertClothingComponents(Cloth.CRM, outfitData)

            if outfit then
                exports['crm-appearance']:crm_set_ped_clothing(plyPed, outfit.crm_clothing)
                exports['crm-appearance']:crm_set_ped_accessories(plyPed, outfit.crm_accessories)
            end
		end

		RestoreCivilOutfit = function()
            dbg.debugClothing('Restoring outfit!')
            TriggerEvent("crm-appearance:load-player-skin")
		end
    end
end)

