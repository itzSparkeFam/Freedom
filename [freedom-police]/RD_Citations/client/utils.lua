RegisterNetEvent("animations:client:PlayEmote", function(args)
    if args[1] == "c" then
        ExecuteCommand("e c")
    else
        ExecuteCommand("e clipboard")
    end
end)