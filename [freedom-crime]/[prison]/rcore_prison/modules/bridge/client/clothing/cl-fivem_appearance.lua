local activeCooldown = false
local cacheClothing = {}

NetworkService.RegisterNetEvent('StoredOutfit', function(validRequest, serverData)
    if validRequest then
        cacheClothing = serverData
    end
end)

CreateThread(function()
    if Config.Cloth == Cloth.FAPPEARANCE then
        ApplyOutfit = function(data)
            local outfitData = GetOutfitByGender(data)
            local playerPed = PlayerPedId()

            if not outfitData then
                return
            end

            local components, props = ClothingService.ConvertClothingComponents(Cloth.FAPPEARANCE, outfitData)

            dbg.debugClothing('ApplyOutfit: Using fivem-appearance, original version.')

            cacheClothing.props = exports["fivem-appearance"]:getPedProps(playerPed)
            cacheClothing.components = exports["fivem-appearance"]:getPedComponents(playerPed)
            
            TriggerServerEvent("rcore_prison:request:saveOutfitIntoCache", cacheClothing)

            if components and props then
                exports['fivem-appearance']:setPedComponents(playerPed, components)
		        exports['fivem-appearance']:setPedProps(playerPed, props)
            end
        end

        RestoreCivilOutfit = function()
			if activeCooldown then
				return dbg.debug('Please wait few seconds, before restoring outfit again!')
			end

            local playerPed = PlayerPedId()

			activeCooldown = true

			SetTimeout(5 * 1000, function()
				activeCooldown = false
			end)

			dbg.debugClothing('Restoring player outfit')

            if cacheClothing and next(cacheClothing) then
                exports['fivem-appearance']:setPedComponents(playerPed, cacheClothing.components)
		        exports['fivem-appearance']:setPedProps(playerPed, cacheClothing.props)
                cacheClothing = {}
            else
                dbg.debugClothing("Failed to restore player outfit, cannot find cached outfit.")
            end
        end
    end
end)
