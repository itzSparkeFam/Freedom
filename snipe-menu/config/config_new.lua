
--[[
    label = is the name of the sound (this will be shown on the UI)
    soundName = is the name of the sound file. (the sound file should be in the interact-sound/client/html/sounds folder without the .ogg)
]]--
Config.Sounds = {
    [1] = {label = "Air Wrench", soundName = "airwrench" },
    [2] = {label = "Door bell", soundName = "doorbell"},
}

--[[
    -- if true, you can move while in the menu after you press alt key. if false, you can't move while in the menu.
    -- admin menu can only be closed if you are focussed. 
    -- Most servers have target system attached to alt key so should not be a big issue. 
    -- if you feel like something's off, change this to false and open a ticket and we can fix it.
]]--
Config.AllowMovementWhileInMenu = true 

Config.ShowLines = true -- if true, it will show lines between you and the player. if false, it will not show lines between you and the player.
Config.NewNamesLogic = true -- if true, it will use the new names logic. if false, it will use the old names logic.
Config.LineColor = {["r"] = 255, ["g"] = 0, ["b"] =0} -- color of the line between you and the player. (r, g, b)

Config.ShowInGameNamesForNamesAndBlips = false -- if true, it will show in game names for names and blips. if false, it will show their steam/fivem name

-------------------------------Toggle Admin Feature--------------------------------

-- If true, admins will have to do /adminduty to enable the use of admin menu
-- If false, admins will be assigned admin duty automatically
Config.AdminDuty = false 
Config.AdminClothes = false -- if true, it will set the player clothing to like admin clothing (check client/open/cl_clothing.lua for more information)

---------------------------------------------------------------------------------------

Config.SnapToGroundOnNoclipStop = true -- if true, it will snap you to the ground when you stop noclip.