EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
    
    ["esx_skin:save"] = "esx_skin:save",

    ["esx_billing:sendBill"] = "esx_billing:sendBill",

    ["jsfour-idcard:open"] = "jsfour-idcard:open",

    ["esx_license:removeLicense"] = "esx_license:removeLicense",
    ["esx_license:addLicense"] = "esx_license:addLicense",

    ["esx_skin:getPlayerSkin"] = "esx_skin:getPlayerSkin",

    -- Just used if you choose illenium instead of framework "outfit manager"
    ["illenium-appearance:client:openOutfitMenu"] = "illenium-appearance:client:openOutfitMenu",
    ["illenium-apearance:client:outfitsCommand"] = "illenium-apearance:client:outfitsCommand",
}

-- If true, the markers will be hidden when the player is not on duty, if false, they will be visible but it can't be used
COMPLETELY_HIDE_MARKERS_WHEN_OFF_DUTY = false

--[[
    Default progressbar color (must be a hex code). Examples:
    "#0fffef" - Light blue
    "#ff0f0f" - Red
    "#0f0fff" - Blue
]]
DEFAULT_PROGRESSBAR_COLOR = "#0fffef"

-- If you use an ambulance script that edits death behavior, making native IsPedDeadOrDying return false when the player is dead
function IsPedDeadOrDyingCustom(ped)
    if not IsPedAPlayer(ped) then return IsPedDeadOrDying(ped) end -- Most likely you don't need to touch this

    -- EDIT THIS FUNCTION TO RETURN TRUE WHEN THE PLAYER IS DEAD AND FALSE WHEN THE PLAYER IS ALIVE
    local isPlayerDead = IsPedDeadOrDying(ped)
    return isPlayerDead
end