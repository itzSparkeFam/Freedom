resource = {}

---Resource Version
---@param name string
---@return string
resource.version = function(name)
    local version = GetResourceMetadata(name, 'version', 0)
    return version
end

---Resource Version Check
---@param resource string
---@param version string
---@return boolean
resource.isMinimalVersion = function(resource, version)
    local currentVersion = GetResourceMetadata(resource, 'version', 0)

    if not currentVersion then return false end

    local latestVersion = version:match('%d+%.%d+%.%d+')
    if not latestVersion or latestVersion == currentVersion then return true end

    local cv = { string.strsplit('.', currentVersion) }
    local lv = { string.strsplit('.', latestVersion) }

    for i = 1, #cv do
        local current, minimum = tonumber(cv[i]), tonumber(lv[i])
        if current ~= minimum then
            if current > minimum then
                return true
            else
                break
            end
        end
    end
    return false
end

---Resource Missing
---@param name string
resource.missing = function(name)
    return GetResourceState(name) == 'missing'
end