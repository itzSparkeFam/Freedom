RegisterCommand("phonedebug", function()
    Config.Debug = not Config.Debug

    SendReactMessage("toggleDebug", Config.Debug)
    print("DEBUG:", Config.Debug)
end, false)

local function RegisterDebugCommand(command, fn)
    if not Config.Debug then
        return
    end

    RegisterCommand(command, fn, false)
end

RegisterDebugCommand("getphonecache", function()
    SendReactMessage("printCache")
end)

RegisterDebugCommand("getphonestacks", function()
    SendReactMessage("printStacks")
end)
