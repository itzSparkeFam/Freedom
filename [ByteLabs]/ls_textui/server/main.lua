lib.versionCheck('ProjectLosSantos/ls_textui')

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    if resourceName ~= 'ls_textui' then
        print('The resource stopped because it was renamed')
        while true do

        end
    end
end)
