function BeginLockPickMiniGame(vehicle, advanced)
    R14EvidenceEvents(vehicle, "lockpicking")
    if Config.Prefrences.LockPickMiniGame == "ox" then
        local result = lib.skillCheck({'easy', 'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'})
        return result
    elseif Config.Prefrences.LockPickMiniGame == "bagus" then
        local result = exports['lockpick']:startLockpick()
        return result
    elseif Config.Prefrences.LockPickMiniGame == "ps-ui" then
        local returnvalue = false
        exports['ps-ui']:Circle(function(success)
            if success then
                returnvalue = true
            else
                returnvalue = false
            end
        end, 3, 20000)
        return returnvalue
    elseif Config.Prefrences.LockPickMiniGame == "bl-progress" then
        local success = exports.bl_ui:Progress(3, 50)
        return success
    elseif Config.Prefrences.LockPickMiniGame == "bl-keyspam" then
        local success = exports.bl_ui:KeySpam(3, 50)
        return success
    elseif Config.Prefrences.LockPickMiniGame == "bl-circle" then
        local success = exports.bl_ui:CircleProgress(3, 50)
        return success
    elseif Config.Prefrences.LockPickMiniGame == "bl-printlock" then
        local success = exports.bl_ui:PrintLock(3, {
            grid = 4,
            duration = 5000,
            target = 4
        })
        return success
    elseif Config.Prefrences.LockPickMiniGame == "t3_lockpick" then
        local returnvalue = false
        local success = exports["t3_lockpick"]:startLockpick(1.0, 2, 5)
        if success then
            returnvalue = true
        else
            returnvalue = false
        end
        return returnvalue
    elseif Config.Prefrences.LockPickMiniGame == "bit-unlock" then
        -- untested, I dont own this to test
        local returnvalue = nil
        TriggerEvent("bit-unlock:start", "lockpick", "easy", function(success)
            if success then
                returnvalue = true
            else
                returnvalue = false
            end
        end)
        while returnvalue == nil do
            Wait(0)
        end
        return returnvalue
    else
        return true
    end
end

function BeginHotWireMiniGame(vehicle)
    if HijackImmune(vehicle) then return NotifyPlayer(locale("LockPick.VehicleIsHijackImmune"), "error") end
    R14EvidenceEvents(vehicle, "hotwiring")
    if Config.Prefrences.HotWireMiniGame == "ox" then
        local result = lib.skillCheck({'easy', 'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'})
        return result
    elseif Config.Prefrences.HotWireMiniGame == "bagus" then
        local result = exports['lockpick']:startLockpick()
        return result
    elseif Config.Prefrences.HotWireMiniGame == "ps-ui" then
        local returnvalue = false
        exports['ps-ui']:Circle(function(success)
            if success then
                returnvalue = true
            else
                returnvalue = false
            end
        end, 3, 20000)
        return returnvalue
    elseif Config.Prefrences.HotWireMiniGame == "bl-progress" then
        local success = exports.bl_ui:Progress(3, 50)
        return success
    elseif Config.Prefrences.HotWireMiniGame == "bl-keyspam" then
        local success = exports.bl_ui:KeySpam(3, 50)
        return success
    elseif Config.Prefrences.HotWireMiniGame == "bl-circle" then
        local success = exports.bl_ui:CircleProgress(3, 50)
        return success
    elseif Config.Prefrences.HotWireMiniGame == "bl-printlock" then
        local success = exports.bl_ui:PrintLock(3, {
            grid = 4,
            duration = 5000,
            target = 4
        })
        return success
    elseif Config.Prefrences.HotWireMiniGame == "t3_lockpick" then
        local returnvalue = false
        local success = exports["t3_lockpick"]:startLockpick(1.0, 2, 5)
        if success then
            returnvalue = true
        else
            returnvalue = false
        end
        return returnvalue
    elseif Config.Prefrences.HotWireMiniGame == "bit-unlock" then
        -- untested, I dont own this to test
        local returnvalue = nil
        TriggerEvent("bit-unlock:start", "lockpick", "easy", function(success)
            if success then
                returnvalue = true
            else
                returnvalue = false
            end
        end)
        while returnvalue == nil do
            Wait(0)
        end
        return returnvalue
    else
        return true
    end
end

--[[

-- These are some example minigames, you can swap with the above

-------------------BaguscodeStudio-----------------
--https://github.com/baguscodestudio/lockpick
---
---
----------------------PS-UI MINIGAMES----------------------
---https://github.com/Project-Sloth/ps-ui
---
---
----------------------Byte-Labs--------------------------------
---https://github.com/Byte-Labs-Studio/bl_ui
---
---
----------------------T3Development--------------------------
--https://github.com/T3development/t3_lockpick

--]]