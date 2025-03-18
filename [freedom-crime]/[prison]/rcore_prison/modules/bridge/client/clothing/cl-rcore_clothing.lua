CreateThread(function()
    if Config.Cloth == Cloth.RCORE then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)

			if not outfitData then
				return
			end

			if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
				dbg.debugClothing('ApplyOutfit: Using qb-clothing emulation for RCore Clothing')

				local outfit = ClothingService.ConvertClothingComponents(Cloth.QB, outfitData)

				if outfit then
					TriggerEvent(Config.FrameworkEvents['qb-clothing:client:loadOutfit'], outfit)
				end
			elseif Config.Framework == Framework.ESX then
				dbg.debugClothing('ApplyOutfit: Using skinchanger emulation for RCore Clothing')

				local outfit = ClothingService.ConvertClothingComponents(Cloth.SKINCHANGER, outfitData)

				if outfit then
					TriggerEvent(Config.FrameworkEvents['skinchanger:getSkin'], function(skin)
						TriggerEvent(Config.FrameworkEvents['skinchanger:loadClothes'], skin, outfit)
					end)
				end
			end
		end

		RestoreCivilOutfit = function()
			dbg.debugClothing('Restoring outfit!')
			
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

