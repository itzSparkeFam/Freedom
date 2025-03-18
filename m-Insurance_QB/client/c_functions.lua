local QBCore = exports[Config.Core]:GetCoreObject()

function IsBlacklistedVehicle(model)
    for _, vehicle in ipairs(Config.BlacklistVehicles) do
        if GetHashKey(vehicle) == GetHashKey(model) then
            return true
        end
    end
    return false
end

-- Open insurance menu if you use without job
function OpenInsuranceMenu()
    QBCore.Functions.TriggerCallback('m-Insurance:Server:GetPlayerVehicles', function(vehicles)
        if vehicles then
            local OpenInsuranceMenu = {
                id = 'OpenInsuranceMenu',
                title = "Car Registration / Insurance",
                options = {}
            }
    
            for _, option in ipairs(vehicles) do
                local registrationStatus = option.hasRegistration and "Registered" or "Not Registered"
                local insuranceStatus = option.hasInsurance and "Insured" or "Not Insured"

                OpenInsuranceMenu.options[#OpenInsuranceMenu.options + 1] = {
                    title = "Plate: ".. option.plate .. " | Model: " .. option.model,
                    description = "Registration: " .. registrationStatus .. " | Insurance: " .. insuranceStatus,
                    icon = 'fa-solid fa-car',
                    onSelect = function()
                        local SubMenu = {
                            id = 'SubMenu',
                            title = "Choose an Option for: " .. option.plate,
                            options = {
                                {
                                    title = "Register Vehicle",
                                    description = option.hasRegistration and "This vehicle is already registered" or "Register your vehicle to make it legal",
                                    icon = 'fa-solid fa-clipboard',
                                    disabled = option.hasRegistration,
                                    onSelect = function()
                                        local options = {}
                                        for _, days in ipairs(Config.carInsurance.insuranceTypes[1].days) do
                                            options[#options + 1] = { label = "Registration for " .. days .. " days", value = days }
                                        end

                                        local input = lib.inputDialog("How Many Days?", {
                                            { 
                                                type = "select",
                                                label = "Choose the number of days",
                                                options = options
                                            }
                                        })

                                        if input and input[1] then
                                            local selectedDays = input[1]
                                            local basePrice = Config.carInsurance.insuranceTypes[1].price
                                            local finalPrice = basePrice * selectedDays
                                            if Config.carInsurance.vehicleClassPrices.enable then
                                                local vehicleClass = GetVehicleClassFromName(option.model)
                                                if vehicleClass and Config.carInsurance.vehicleClassPrices.prices[vehicleClass] then
                                                    local classMultiplier = Config.carInsurance.vehicleClassPrices.prices[vehicleClass]
                                                    finalPrice = finalPrice * classMultiplier
                                                else
                                                    Notify("This vehicle class is not supported", "error", 3500)
                                                    return
                                                end
                                            end
                                            finalPrice = math.floor(finalPrice)
                                            if IsBlacklistedVehicle(option.model) then 
                                                Notify("This vehicle is blacklisted", "error", 3500) 
                                                return 
                                            end
                                            TriggerServerEvent('m-Insurance:Server:RegisterVehicle', option.plate, option.model, finalPrice, selectedDays)
                                        end
                                    end
                                },
                                {
                                    title = "Get Insurance",
                                    description = option.hasInsurance and "This vehicle already has insurance" or "Apply for vehicle insurance",
                                    icon = 'fa-solid fa-shield',
                                    disabled = option.hasInsurance,
                                    onSelect = function()
                                        local options = {}
                                        for _, days in ipairs(Config.carInsurance.insuranceTypes[2].days) do
                                            options[#options + 1] = { label = "Insurance for " .. days .. " days", value = days }
                                        end

                                        local input = lib.inputDialog("How Many Days?", {
                                            { 
                                                type = "select",
                                                label = "Choose the number of days",
                                                options = options
                                            }
                                        })

                                        if input and input[1] then
                                            local selectedDays = input[1]
                                            local basePrice = Config.carInsurance.insuranceTypes[2].price
                                            local finalPrice = basePrice * selectedDays
                                            if Config.carInsurance.vehicleClassPrices.enable then
                                                local vehicleClass = GetVehicleClassFromName(option.model)                                        
                                                if vehicleClass and Config.carInsurance.vehicleClassPrices.prices[vehicleClass] then
                                                    local classMultiplier = Config.carInsurance.vehicleClassPrices.prices[vehicleClass]
                                                    finalPrice = finalPrice * classMultiplier
                                                else
                                                    Notify("This vehicle class is not supported", "error", 3500)
                                                    return
                                                end
                                            end
                                            finalPrice = math.floor(finalPrice)
                                            if IsBlacklistedVehicle(option.model) then 
                                                Notify("This vehicle is blacklisted", "error", 3500) 
                                                return 
                                            end
                                            TriggerServerEvent('m-Insurance:Server:ApplyInsurance', option.plate, option.model, finalPrice, selectedDays)
                                        end
                                    end
                                },
                                {
                                    title = "Get Camera Security",
                                    description = "Get a camera security for your vehicle\nPrice: $"..Config.CameraPrice,
                                    icon = 'fa-solid fa-camera',
                                    disabled = option.hasCamera,
                                    onSelect = function ()
                                        TriggerServerEvent('m-Insurance:Server:BuyCamera', option.plate)
                                    end
                                },
                                {
                                    title = "Recover Documentation",
                                    description = "Recover your vehicle documentation",
                                    icon = 'fa-solid fa-file',
                                    onSelect = function()
                                        local recoverDocumentsMenu = {
                                            id = 'recoverDocumentsMenu',
                                            title = "Choose an Option for: " .. option.plate,
                                            options = {
                                                {
                                                    title = "Recover Registration",
                                                    description = "Recover your vehicle registration",
                                                    icon = 'fa-solid fa-clipboard',
                                                    onSelect = function()
                                                        TriggerServerEvent('m-Insurance:Server:RecoverDocumentationInsurance', option.plate, "registration")
                                                    end
                                                },
                                                {
                                                    title = "Recover Insurance",
                                                    description = "Recover your vehicle insurance",
                                                    icon = 'fa-solid fa-shield',
                                                    onSelect = function()
                                                        TriggerServerEvent('m-Insurance:Server:RecoverDocumentationInsurance', option.plate, "insurance")
                                                    end
                                                },
                                                {
                                                    title = "Back",
                                                    description = "Go back to the previous menu",
                                                    icon = 'fa-solid fa-arrow-left',
                                                    onSelect = function()
                                                        lib.showContext('OpenInsuranceMenu')
                                                    end
                                                }
                                            }
                                        }
                                        lib.registerContext(recoverDocumentsMenu)
                                        lib.showContext('recoverDocumentsMenu')
                                    end
                                },
                                {
                                    title = "Back",
                                    description = "Go back to the previous menu",
                                    icon = 'fa-solid fa-arrow-left',
                                    onSelect = function()
                                        lib.showContext('OpenInsuranceMenu')
                                    end
                                }
                            }
                        }
                    
                        lib.registerContext(SubMenu)
                        lib.showContext('SubMenu')
                    end
                }
            end
    
            lib.registerContext(OpenInsuranceMenu)
            lib.showContext('OpenInsuranceMenu')
        else
            Notify("You don't have any vehicles to insure", "error", 3500)
        end
    end)
end

-- Open insurance menu if you use with job
function OpenInsuranceJobMenu()
    lib.registerContext({
        id = 'OpenInsuranceJobMenu',
        title = 'Car Insurance / Registration',
        icon = 'fa-solid fa-circle-up',
        options = {
            { 
                title = 'Check Vehicle Informations',         
                icon = 'fa-solid fa-car',
                description = 'Check if a vehicle is registered or insured',
                onSelect = function()
                    local input = lib.inputDialog("Enter the vehicle plate", {
                        { type = "input", label = "Vehicle Plate" }
                    })
                    if input and input[1] then
                        local plate = input[1]
                        QBCore.Functions.TriggerCallback('m-Insurance:Server:CheckAllVehiclesInformations', function(vehicleData)
                            if vehicleData then
                                lib.registerContext({
                                    id = 'CheckVehicleInsurance',
                                    title = 'Vehicle Insurance / Registration',
                                    icon = 'fa-solid fa-car',
                                    options = {
                                        {
                                            title = "Plate: " .. vehicleData.plate,
                                            description = "Model: " .. vehicleData.model,
                                            icon = 'fa-solid fa-car',
                                            readOnly = true
                                        },
                                        {
                                            title = "Insurance: " .. (vehicleData.hasInsurance and "Yes" or "No"),
                                            description = "Click to remove insurance",
                                            icon = 'fa-solid fa-shield',
                                            onSelect = function()
                                                TriggerServerEvent('m-Insurance:Server:RemoveInformationsJob', vehicleData.plate, "insurance")
                                            end
                                        },
                                        {
                                            title = "Registration: " .. (vehicleData.hasRegistration and "Yes" or "No"),
                                            description = "Click to remove registration",
                                            icon = 'fa-solid fa-clipboard',
                                            onSelect = function()
                                                TriggerServerEvent('m-Insurance:Server:RemoveInformationsJob', vehicleData.plate, "registration")
                                            end
                                        },

                                        {
                                            title = "Back",
                                            description = "Go back to the previous menu",
                                            icon = 'fa-solid fa-arrow-left',
                                            onSelect = function()
                                                lib.showContext('OpenInsuranceJobMenu')
                                            end
                                        }
                                    }
                                })
                                lib.showContext('CheckVehicleInsurance')
                            else
                                Notify("This vehicle does not exist", "error", 3500)
                            end
                        end, plate)
                    end
                end
            },
            {
                title = "Register Vehicle",
                description = "Register a specific vehicle",
                icon = 'fa-solid fa-clipboard',
                onSelect = function()
                    local options = {}
                    for _, days in ipairs(Config.carInsurance.insuranceTypes[1].days) do
                        options[#options + 1] = { label = "Registration for " .. days .. " days", value = days }
                    end

                    local input = lib.inputDialog('Write all vehicle information', {
                        { type = 'input', label = 'Player Name', description = 'Please fill with first and last name', required = true },
                        { type = 'input', label = 'Vehicle Model', description = 'Please fill with vehicle model', required = true },
                        { type = 'input', label = 'Vehicle Plate', description = 'Please fill with vehicle plate', required = true },
                        { type = "select", label = "Choose the number of days", options = options, required = true }
                    })
                    
                    if input then
                        if IsBlacklistedVehicle(input[2]) then Notify("This vehicle is blacklisted", "error", 3500) return end
                        local vehicleClass = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false))
                        local vehiclePrice = Config.carInsurance.vehicleClassPrices.prices[vehicleClass] or 1
                        local price = Config.carInsurance.insuranceTypes[1].price * vehiclePrice
                        TriggerServerEvent('m-Insurance:Server:ApplyDocumentsWithJob', input[1], input[2], input[3], input[4], price, "register")
                    end
                end
            },
            {
                title = "Insurance Vehicle",
                description = "Insurance a specific vehicle",
                icon = 'fa-solid fa-shield',
                onSelect = function()
                    local options = {}
                    for _, days in ipairs(Config.carInsurance.insuranceTypes[2].days) do
                        options[#options + 1] = { label = "Insurance for " .. days .. " days", value = days }
                    end

                    local input = lib.inputDialog('Write all vehicle information', {
                        { type = 'input', label = 'Player Name', description = 'Please fill with first and last name', required = true },
                        { type = 'input', label = 'Vehicle Model', description = 'Please fill with vehicle model', required = true },
                        { type = 'input', label = 'Vehicle Plate', description = 'Please fill with vehicle plate', required = true },
                        { type = "select", label = "Choose the number of days", options = options, required = true }
                    })
                    
                    if input then
                        if IsBlacklistedVehicle(input[2]) then Notify("This vehicle is blacklisted", "error", 3500) return end
                        local vehicleClass = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false))
                        local vehiclePrice = Config.carInsurance.vehicleClassPrices.prices[vehicleClass] or 1
                        local price = Config.carInsurance.insuranceTypes[2].price * vehiclePrice
                        TriggerServerEvent('m-Insurance:Server:ApplyDocumentsWithJob', input[1], input[2], input[3], input[4], price, "insurance")
                    end
                end
            },
            {
                title = "Get Camera Security",
                description = "Get a camera security for your vehicle\nPrice: $"..Config.CameraPrice,
                icon = 'fa-solid fa-camera',
                onSelect = function ()
                    local input = lib.inputDialog('Write the informations', {
                        { type = 'input', label = 'Vehicle Plate', description = 'Please fill with vehicle plate', required = true },
                    })
                    
                    if input then
                        TriggerServerEvent('m-Insurance:Server:BuyCamera', input[1])
                    end
                end
            },
            { 
                title = 'Open Stash',         
                icon = 'fas fa-box',
                description = 'Open the stash to store your items',
                onSelect = function()
                    OpenStash(Config.carInsurance.stash.weight, Config.carInsurance.stash.slots, Config.carInsurance.stash.name)
                end 
            },
            { 
                title = 'Close Menu',         
                icon = 'fas fa-times',
                description = 'Close the menu',
                onSelect = function()
                    lib.closeContext()
                end
            }
        }
    })
    lib.showContext('OpenInsuranceJobMenu')
end

-- Open health insurance menu if you use without job
function OpenHealthInsurancMenu()
    lib.registerContext({
        id = 'OpenHealthInsuranceMenu',
        title = 'Health Insurance',
        icon = 'fa-solid fa-user-shield',
        options = {
            {
                title = "Get Health Insurance",
                description = "Get health insurance to protect yourself",
                icon = 'fa-solid fa-user-shield',
                onSelect = function()
                    local options = {}
                    for _, days in ipairs(Config.healthInsurance.insuranceTypes[1].days) do
                        options[#options + 1] = { label = "Health Insurance for " .. days .. " days", value = days }
                    end

                    local input = lib.inputDialog("How Many Days?", {
                        { 
                            type = "select",
                            label = "Choose the number of days",
                            options = options
                        }
                    })

                    if input and input[1] then
                        local selectedDays = input[1]
                        local basePrice = Config.carInsurance.insuranceTypes[1].price
                        local finalPrice = basePrice * (selectedDays / 30)
                        
                        TriggerServerEvent('m-Insurance:Server:GiveHealthInsurance', finalPrice, selectedDays)
                    end
                end
            },
            {
                title = "Recover Documentation",
                description = "Recover your health insurance documentation",
                icon = 'fa-solid fa-file',
                onSelect = function()
                    local recoverDocumentsMenu = {
                        id = 'recoverDocumentsMenu',
                        title = "Choose an Option",
                        options = {
                            {
                                title = "Recover Health Insurance",
                                description = "Recover your health insurance documentation",
                                icon = 'fa-solid fa-user-shield',
                                onSelect = function()
                                    local myCitizenid = QBCore.Functions.GetPlayerData().citizenid
                                    TriggerServerEvent('m-Insurance:Server:RecoverDocumentationHealthInsurance', myCitizenid)
                                end
                            },
                            {
                                title = "Back",
                                description = "Go back to the previous menu",
                                icon = 'fa-solid fa-arrow-left',
                                onSelect = function()
                                    lib.showContext('OpenHealthInsuranceMenu')
                                end
                            }
                        }
                    }
                    lib.registerContext(recoverDocumentsMenu)
                    lib.showContext('recoverDocumentsMenu')
                end
            },
            { 
                title = 'Close Menu',         
                icon = 'fas fa-times',
                description = 'Close the menu',
                onSelect = function()
                    lib.closeContext()
                end
            }
        }
    })
    lib.showContext('OpenHealthInsuranceMenu')
end

-- Open health insurance menu if you use with job
function OpenHealthInsuranceJobMenu()
    lib.registerContext({
        id = 'OpenHealthInsuranceJobMenu',
        title = 'Health Insurance',
        icon = 'fa-solid fa-user-shield',
        options = {
            {
                title = "Apply Health Insurance",
                description = "Apply health insurance to protect yourself",
                icon = 'fa-solid fa-user-shield',
                onSelect = function()
                    local options = {}
                    for _, days in ipairs(Config.healthInsurance.insuranceTypes[1].days) do
                        options[#options + 1] = { label = "Health Insurance for " .. days .. " days", value = days }
                    end

                    local input = lib.inputDialog('Write all player information', {
                        { type = 'input', label = 'Player Name', description = 'Please fill with first and last name', required = true },
                        { type = 'input', label = 'Citizen ID', description = 'Please fill with the citizenid', required = true },
                        { type = "select", label = "Choose the number of days", options = options, required = true }
                    })
                    
                    if input then
                        local price = Config.healthInsurance.insuranceTypes[1].price * (input[3] / 30)
                        TriggerServerEvent('m-Insurance:Server:ApplyHealthInsuranceWithJob', input[1], input[2], input[3], price)
                    end
                end
            },
            {
                title = "Recover Documentation",
                description = "Recover your health insurance documentation",
                icon = 'fa-solid fa-file',
                onSelect = function()
                    local recoverDocumentsMenu = {
                        id = 'recoverDocumentsMenu',
                        title = "Choose an Option",
                        options = {
                            {
                                title = "Recover Health Insurance",
                                description = "Recover your health insurance documentation",
                                icon = 'fa-solid fa-user-shield',
                                onSelect = function()
                                    local input = lib.inputDialog("Enter the citizen ID", {
                                        { type = "input", label = "Citizen ID" }
                                    })
                                    if input and input[1] then
                                        TriggerServerEvent('m-Insurance:Server:RecoverDocumentationHealthInsurance', input[1])
                                    end
                                end
                            },
                            {
                                title = "Back",
                                description = "Go back to the previous menu",
                                icon = 'fa-solid fa-arrow-left',
                                onSelect = function()
                                    lib.showContext('OpenHealthInsuranceJobMenu')
                                end
                            }
                        }
                    }
                    lib.registerContext(recoverDocumentsMenu)
                    lib.showContext('recoverDocumentsMenu')
                end
            },
            { 
                title = 'Open Stash',         
                icon = 'fas fa-box',
                description = 'Open the stash to store your items',
                onSelect = function()
                    OpenStash(Config.healthInsurance.stash.weight, Config.healthInsurance.stash.slots, Config.healthInsurance.stash.name)
                end 
            },
            { 
                title = 'Close Menu',         
                icon = 'fas fa-times',
                description = 'Close the menu',
                onSelect = function()
                    lib.closeContext()
                end
            }
        }
    })
    lib.showContext('OpenHealthInsuranceJobMenu')
end

-- Open home insurance menu if you use without job
function OpenHomeInsuranceMenu()
    lib.registerContext({
        id = 'OpenHomeInsuranceMenu',
        title = 'Home Insurance',
        icon = 'fa-solid fa-user-shield',
        options = {
            {
                title = "Get Home Insurance",
                description = "Get home insurance to protect yourself",
                icon = 'fa-solid fa-user-shield',
                onSelect = function()
                    local options = {}
                    for _, days in ipairs(Config.homeInsurance.insuranceTypes[1].days) do
                        options[#options + 1] = { label = "Home Insurance for " .. days .. " days", value = days }
                    end

                    local input = lib.inputDialog("How Many Days?", {
                        { 
                            type = "select",
                            label = "Choose the number of days",
                            options = options
                        }
                    })

                    if input and input[1] then
                        local selectedDays = input[1]
                        local basePrice = Config.carInsurance.insuranceTypes[1].price
                        local finalPrice = basePrice * (selectedDays / 30)
                        
                        TriggerServerEvent('m-Insurance:Server:GiveHomeInsurance', finalPrice, selectedDays)
                    end
                end
            },
            {
                title = "Recover Documentation",
                description = "Recover your home insurance documentation",
                icon = 'fa-solid fa-file',
                onSelect = function()
                    local recoverDocumentsMenu = {
                        id = 'recoverDocumentsMenu',
                        title = "Choose an Option",
                        options = {
                            {
                                title = "Recover Home Insurance",
                                description = "Recover your home insurance documentation",
                                icon = 'fa-solid fa-user-shield',
                                onSelect = function()
                                    local myCitizenid = QBCore.Functions.GetPlayerData().citizenid
                                    TriggerServerEvent('m-Insurance:Server:RecoverDocumentationHomeInsurance', myCitizenid)
                                end
                            },
                            {
                                title = "Back",
                                description = "Go back to the previous menu",
                                icon = 'fa-solid fa-arrow-left',
                                onSelect = function()
                                    lib.showContext('OpenHomeInsuranceJobMenu')
                                end
                            }
                        }
                    }
                    lib.registerContext(recoverDocumentsMenu)
                    lib.showContext('recoverDocumentsMenu')
                end
            },
            { 
                title = 'Close Menu',         
                icon = 'fas fa-times',
                description = 'Close the menu',
                onSelect = function()
                    lib.closeContext()
                end
            }
        }
    })
    lib.showContext('OpenHomeInsuranceMenu')
end

-- Open home insurance menu if you use with job
function OpenHomeInsuranceJobMenu()
    lib.registerContext({
        id = 'OpenHomeInsuranceJobMenu',
        title = 'Home Insurance',
        icon = 'fa-solid fa-user-shield',
        options = {
            {
                title = "Apply Home Insurance",
                description = "Apply home insurance to protect yourself",
                icon = 'fa-solid fa-user-shield',
                onSelect = function()
                    local options = {}
                    for _, days in ipairs(Config.homeInsurance.insuranceTypes[1].days) do
                        options[#options + 1] = { label = "Home Insurance for " .. days .. " days", value = days }
                    end

                    local input = lib.inputDialog('Write all vehicle information', {
                        { type = 'input', label = 'Player Name', description = 'Please fill with first and last name', required = true },
                        { type = 'input', label = 'Citizen ID', description = 'Please fill with the citizenid', required = true },
                        { type = "select", label = "Choose the number of days", options = options, required = true }
                    })
                    
                    if input then
                        local price = Config.homeInsurance.insuranceTypes[1].price * (input[3] / 30)
                        TriggerServerEvent('m-Insurance:Server:ApplyHomeInsuranceWithJob', input[1], input[2], input[3], price)
                    end
                end
            },
            {
                title = "Recover Documentation",
                description = "Recover your home insurance documentation",
                icon = 'fa-solid fa-file',
                onSelect = function()
                    local recoverDocumentsMenu = {
                        id = 'recoverDocumentsMenu',
                        title = "Choose an Option",
                        options = {
                            {
                                title = "Recover Home Insurance",
                                description = "Recover your home insurance documentation",
                                icon = 'fa-solid fa-user-shield',
                                onSelect = function()
                                    local input = lib.inputDialog("Enter the citizen ID", {
                                        { type = "input", label = "Citizen ID" }
                                    })
                                    if input and input[1] then
                                        TriggerServerEvent('m-Insurance:Server:RecoverDocumentationHomeInsurance', input[1])
                                    end
                                end
                            },
                            {
                                title = "Back",
                                description = "Go back to the previous menu",
                                icon = 'fa-solid fa-arrow-left',
                                onSelect = function()
                                    lib.showContext('OpenHomeInsuranceJobMenu')
                                end
                            }
                        }
                    }
                    lib.registerContext(recoverDocumentsMenu)
                    lib.showContext('recoverDocumentsMenu')
                end
            },
            { 
                title = 'Open Stash',         
                icon = 'fas fa-box',
                description = 'Open the stash to store your items',
                onSelect = function()
                    OpenStash(Config.homeInsurance.stash.weight, Config.homeInsurance.stash.slots, Config.homeInsurance.stash.name)
                end 
            },
            { 
                title = 'Close Menu',         
                icon = 'fas fa-times',
                description = 'Close the menu',
                onSelect = function()
                    lib.closeContext()
                end
            }
        }
    })
    lib.showContext('OpenHomeInsuranceJobMenu')
end