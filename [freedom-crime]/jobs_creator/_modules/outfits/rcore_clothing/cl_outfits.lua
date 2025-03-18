local moduleType = "outfits" -- Module category
local moduleName = "rcore_clothingV2" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

--[[
    You can edit below here
]]

-- This function has to open saved player outfits menu from your own script
Integrations[moduleType][moduleName].openWardrobe = function()
    TriggerEvent('rcore_clothing:openChangingRoom')
end

--[[
    return true will call openJobOutfits, so getPlayerClothes and setPlayerClothes will be ignored
    return false will override current getPlayerClothes and setPlayerClothes functions, using Jobs Creator menu
]]
Integrations[moduleType][moduleName].openExternalMenu = function()
    return false
end

-- This function has to open saved job outfits menu from your own script, completely replacing Jobs Creator job outfit feature    
Integrations[moduleType][moduleName].openJobOutfits = function()
    TriggerEvent('rcore_clothing:openChangingRoom')
end

-- This function has return current player's outfit. The required format is shown below
Integrations[moduleType][moduleName].getPlayerClothes = function()
    local promise = promise.new()

	TriggerEvent('skinchanger:getSkin', function(skin)
        promise:resolve(skin)
    end)

    return Citizen.Await(promise)
end

-- This function has set current player's outfit. The required format is shown below
Integrations[moduleType][moduleName].setPlayerClothes = function(outfit, saveAfterRestart)
	TriggerEvent('skinchanger:loadSkin', outfit)
end

-- EXAMPLE FORMAT FOR OUTFIT
--[[
    ------------------------------
	| Key           | Value      |
	|---------------|------------|
	| tshirt_1      | NUMBER     |
	| tshirt_2      | NUMBER     |
	| torso_1       | NUMBER     |
	| torso_2       | NUMBER     |
	| decals_1      | NUMBER     |
	| decals_2      | NUMBER     |
	| arms          | NUMBER     |
	| arms_2        | NUMBER     |
	| pants_1       | NUMBER     |
	| pants_2       | NUMBER     |
	| shoes_1       | NUMBER     |
	| shoes_2       | NUMBER     |
	| mask_1        | NUMBER     |
	| mask_2        | NUMBER     |
	| bproof_1      | NUMBER     |
	| bproof_2      | NUMBER     |
	| chain_1       | NUMBER     |
	| chain_2       | NUMBER     |
	| helmet_1      | NUMBER     |
	| helmet_2      | NUMBER     |
	| glasses_1     | NUMBER     |
	| glasses_2     | NUMBER     |
	| bags_1        | NUMBER     |
	| bags_2        | NUMBER     |
	------------------------------
]]