Store = setmetatable({}, {
    __index = function(self, key)
        AddEventHandler(('%s:Store:%s'):format(Bridge.Name, key), function(value)
            self[key] = value
        end)
        return rawset(self, key, exports[Bridge.Name].Store(nil, key) or false)
    end,
})

Store.PlayerId = PlayerId()
Store.ServerId = GetPlayerServerId(Store.PlayerId)

Store.Set = function(key, value)
    if value ~= Store[key] then
		TriggerEvent(('%s:Store:%s'):format(Bridge.Name, key), value, Store[key])
		Store[key] = value
		return true
	end
end

Store.On = function(key, cb)
    AddEventHandler(('%s:Store:%s'):format(Bridge.Name, key), cb)
end