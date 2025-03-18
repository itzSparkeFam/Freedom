local activeCooldown = false

CreateThread(function()
	if Config.Cloth == Cloth.BL_APPEARANCE then
		ApplyOutfit = function(data)
			local outfitData = GetOutfitByGender(data)
			local playerPed = PlayerPedId()

			if not outfitData then
				return
			end

			local appearance = ClothingService.ConvertClothingComponents(Cloth.BL_APPEARANCE, outfitData)

			dbg.debugClothing('ApplyOutfit: Using bl_appearance.')

			if appearance then
				exports.bl_appearance:SetPedClothes(playerPed, {
					drawables = appearance.drawables,
					props = appearance.props
				})
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

			local outfit = exports.bl_appearance:GetPlayerPedAppearance()

			dbg.debugClothing('Restoring player outfit')

			if outfit and next(outfit) then
				exports.bl_appearance:SetPlayerPedAppearance(outfit)
			end
		end
	end
end)
