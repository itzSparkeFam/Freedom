function ProgressOpen(isAtm)
    return lib.progressBar({
        duration = 750,
        label = isAtm and locale('open_atm_progress') or locale('open_bank_progress'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
    })
end

local function createPed(model, coords, bankName)
    local point = lib.points.new({
        coords = coords,
        distance = 40,
        ped = nil
    })

    function point:onEnter()
        debugPrint('onEnter: triggered')

        lib.requestModel(model)
        self.ped = CreatePed(6, model, coords.x, coords.y, coords.z - 0.9, coords.w, false, false)
        FreezeEntityPosition(self.ped, true)
        SetEntityInvincible(self.ped, true)
        SetBlockingOfNonTemporaryEvents(self.ped, true)
        SetModelAsNoLongerNeeded(model)

        CreatePedInteract(self.ped, bankName)

        debugPrint('onEnter: ped created')
    end

    function point:onExit()
        debugPrint('onExit: triggered')

        if not self.ped then return end
        DeleteEntity(self.ped)
        self.ped = nil

        debugPrint('onExit: ped deleted')
    end
end

CreateThread(function()
    lib.array.forEach(Config.BankLocations, function(location)
        local blip = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)
        SetBlipSprite(blip, 108)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(locale('bank_label'))
        EndTextCommandSetBlipName(blip)

        createPed(location.model, location.coords, location.bankName)
    end)

    CreateModelInteract(Config.Atms)
end)
