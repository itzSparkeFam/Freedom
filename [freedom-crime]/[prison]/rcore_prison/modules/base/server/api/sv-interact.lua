AddEventHandler('rcore_prison:shared:internal:MapLoaded', function()
    if not SH.data then
        return
    end

    if not SH.data.interaction then
        return
    end

    if Config.COMS.Enable then
        SH.data.interaction[#SH.data.interaction + 1] = Config.COMS.StartLocations
    end
end)
