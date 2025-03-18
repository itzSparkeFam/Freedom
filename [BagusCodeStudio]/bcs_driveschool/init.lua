Shared = {
    config = require("config.shared"),
}
lib = lib

if Shared.config.locale then
    require(("locales.%s"):format(Shared.config.locale))
end

if GetResourceState("es_extended") == "started" then
    Shared.framework = "esx"
elseif GetResourceState("qbx_core") == "started" then
    Shared.framework = "qbx"
elseif GetResourceState("qb-core") == "started" then
    Shared.framework = "qb"
else
    Shared.framework = "custom"
end

if IsDuplicityVersion() then
    Server = {
        config = require("config.server"),
        schools = lib.loadJson("data.schools") or {},
        tracks = lib.loadJson("data.tracks") or {},
        questionare = lib.loadJson("data.questionare") or {}
    }
else
    Client = {
        config = require("config.client"),
        schools = lib.loadJson("data.schools") or {},
        tracks = lib.loadJson("data.tracks") or {},
        questionare = lib.loadJson("data.questionare") or {},
        utils = require("modules.utils.client"),
    }
    cache = cache
    require("modules.freecam.main")
end

DebugPrint = function(...)
    if Shared.config.debug then
        print(('%s ^0%s\n'):format('[DRIVESCHOOL]', table.concat({ ... }, ' ')))
    end
end

DebugWarn = function(...)
    if Shared.config.debug then
        warn(('%s ^0%s\n'):format('[DRIVESCHOOL]', table.concat({ ... }, ' ')))
    end
end
