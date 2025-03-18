local Bridge = GetCurrentResourceName()
local Name = GetResourceMetadata(Bridge, 'name', 0)
local GitHub = GetResourceMetadata(Bridge, 'github', 0)
local Version = GetResourceMetadata(Bridge, 'version', 0)
if not GitHub then return end

Citizen.CreateThreadNow(function()
    PerformHttpRequest(("%s/main/%s.json"):format(string.gsub(GitHub, "github", "raw.githubusercontent"), Name), function(status, response, headers)
        if status == 200 then
            local data = json.decode(response)
            local latestVersion = data.version

            if latestVersion ~= Version then
                print("--------------------------------------------------------------------------")
                print(("^1UPDATE AVAILABLE for %s v%s ^0"):format(Name, Version))
                print(("^2Latest Version: v%s ^0"):format(latestVersion))
                print("")
                print("^3Changelog:^0")
                for _, line in ipairs(data.changelog) do
                    print(('^3- %s ^0'):format(line))
                end
                print("")
                print("Please update to the latest version from: https://keymaster.fivem.net")
                print("--------------------------------------------------------------------------")
            else
                print(("^2%s v%s is Up to date!"):format(Name, Version))
            end
        else
            print("^1Error fetching version information.^0")
        end
    end, "GET", "", { ["Content-Type"] = "application/json" })
end)