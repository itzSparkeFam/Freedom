local restoreOutfit = false

CreateThread(function()
    if Config.Cloth == Cloth.QB then
        RegisterNetEvent("qb-clothes:loadSkin", function(state, model, skin)
            if not restoreOutfit then
                return
            end

            if type(state) == "boolean" and state or restoreOutfit then
                dbg.debugClothing("Outfit restored success!")
            else
                dbg.critical("Failed to restore player skin via qb-clothing, not saved outfit in database!")
            end
        end)
            
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

            dbg.debugClothing('ApplyOutfit: Using qb-clothing.')

            local outfit = ClothingService.ConvertClothingComponents(Cloth.QB, outfitData)

            if outfit then
                TriggerEvent(Config.FrameworkEvents['qb-clothing:client:loadOutfit'], outfit)
            end
		end

		RestoreCivilOutfit = function()
            if restoreOutfit then
                return
            end

            restoreOutfit = true

            SetTimeout(5 * 1000, function()
				restoreOutfit = false
			end)

            dbg.debugClothing('Restoring outfit!')

            TriggerServerEvent("qb-clothes:loadPlayerSkin")
            TriggerServerEvent("qb-clothing:loadPlayerSkin")
		end
    end
end)

