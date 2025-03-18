local QBCore = exports[Config.Core]:GetCoreObject()

-- Menu when police check a specific place
RegisterNetEvent('m-Insurance:Client:OpenInsuranceMenuPolice')
AddEventHandler("m-Insurance:Client:OpenInsuranceMenuPolice", function(data)
    local plate = data.plate
    local insuranceStatus = data.insurance and "Yes" or "No"
    local registrationStatus = data.registration and "Yes" or "No"
    local vehicleStolen = data.stolen and "Yes" or "No"
    local documentsSuspended = data.suspended and "Yes" or "No"
    local owner = data.owner or "Unknown"

    local menuOptions = {
        {
            title = "Plate Information",
            description = "Plate: " .. plate .. "\nInsurance: " .. insuranceStatus .. "\nRegistration: " .. registrationStatus .. "\nOwner: " .. owner .. "\nStolen: " .. vehicleStolen .. "\nDocuments Suspended: " .. documentsSuspended,
            readOnly = true,
            icon = 'fas fa-info-circle'
        },
        {
            title = "Accident Report",
            description = "Report an accident for this vehicle",
            icon = 'fas fa-check',
            onSelect = function()
                local playerCoords = GetEntityCoords(PlayerPedId())
                local streetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
                local roadLocation = GetStreetNameFromHashKey(streetHash)
        
                local input = lib.inputDialog('Accident Report', {
                    {
                        type = 'input',
                        label = 'Officer Name',
                        description = 'Enter your name',
                        name = 'officer_name',
                        icon = 'fas fa-user-shield',
                        placeholder = 'Enter your name'
                    },
                    {
                        type = 'input',
                        label = 'Vehicle Plate',
                        description = 'This is generated automatically',
                        name = 'vehicle_plate',
                        icon = 'fas fa-car',
                        default = plate,
                        disabled = true
                    },
                    {
                        type = 'input',
                        label = 'Vehicle Owner',
                        description = 'This is generated automatically',
                        name = 'vehicle_owner',
                        icon = 'fas fa-user',
                        default = owner,
                        disabled = true
                    },
                    {
                        type = 'input',
                        label = 'Road Location',
                        description = 'This is generated automatically',
                        name = 'road_location',
                        icon = 'fas fa-road',
                        default = roadLocation,
                        disabled = true
                    },
                    {
                        type = 'input',
                        label = 'Observations',
                        description = 'Enter the observations of the accident',
                        name = 'observations',
                        icon = 'fas fa-comment',
                        placeholder = 'Enter the observations of the accident'
                    },
                    {
                        type = 'input',
                        label = 'Screenshot URL',
                        description = 'Paste the URL of the screenshot (optional)',
                        name = 'screenshot',
                        icon = 'fas fa-camera',
                        placeholder = 'Paste the URL of the screenshot (optional)'
                    },
                })
        
                if input then
                    local officer_name = input[1] or 'Unknown'
                    local road_location = roadLocation
                    local observations = input[5] or 'No observations provided'
                    local screenshot = input[6] or nil
                
                    local information = {
                        officer_name = officer_name,
                        vehicle_plate = plate,
                        vehicle_owner = owner,
                        road_location = road_location,
                        observations = observations,
                        screenshot = screenshot,
                    }
                
                    TriggerServerEvent("m-Insurance:Server:SaveAccidentReport", information)
                else
                    Notify('You canceled the accident report.', 'error', 5000)
                end
            end
        },
        {
            title = "Vehicle Stolen",
            description = "Report the vehicle as stolen",
            icon = 'fas fa-exclamation-triangle',
            onSelect = function()
                local stolenMenu = {
                    id = 'stolenMenu',
                    title = "Report Vehicle Stolen",
                    options = {
                        {
                            title = "Report Stolen",
                            description = "Report the vehicle as stolen",
                            icon = 'fas fa-exclamation-triangle',
                            onSelect = function()
                                TriggerServerEvent("m-Insurance:Server:ReportStolenVehicle", plate)
                            end
                        },
                        {
                            title = "Recover Stolen",
                            description = "Recover the stolen vehicle",
                            icon = 'fas fa-exclamation-triangle',
                            onSelect = function()
                                TriggerServerEvent("m-Insurance:Server:RecoverStolenVehicle", plate)
                            end
                        },
                        {
                            title = "Back",
                            description = "Go back to the previous menu",
                            icon = 'fas fa-arrow-left',
                            onSelect = function()
                                lib.showContext('insurance_menu_police')
                            end
                        }
                    }
                }
                lib.registerContext(stolenMenu)
                lib.showContext('stolenMenu')
            end
        },
        {
            title = "Suspend Documents",
            description = "Suspend the vehicle documents",
            icon = 'fas fa-x',
            onSelect = function()
                local suspendDocumentsMenu = {
                    id = 'suspendDocumentsMenu',
                    title = "Suspend Vehicle Documents",
                    options = {
                        {
                            title = "Suspend Documents",
                            description = "Suspend the vehicle documents",
                            icon = 'fas fa-x',
                            onSelect = function()
                                TriggerServerEvent("m-Insurance:Server:SuspendDocuments", plate)
                            end
                        },
                        {
                            title = "Recover Documents",
                            description = "Recover the vehicle documents",
                            icon = 'fas fa-check',
                            onSelect = function()
                                TriggerServerEvent("m-Insurance:Server:RecoverDocuments", plate)
                            end
                        },
                        {
                            title = "Back",
                            description = "Go back to the previous menu",
                            icon = 'fas fa-arrow-left',
                            onSelect = function()
                                lib.showContext('insurance_menu_police')
                            end
                        }
                    }
                }
                lib.registerContext(suspendDocumentsMenu)
                lib.showContext('suspendDocumentsMenu')
            end
        },
        {
            title = "Check Accidents Reports",
            description = "Check the accidents reports for this vehicle",
            icon = 'fas fa-clipboard-list',
            onSelect = function()
                QBCore.Functions.TriggerCallback('m-Insurance:Server:GetCarAccident', function(accidents)
                    if accidents and #accidents > 0 then
                        local accidentOptions = {}
        
                        table.insert(accidentOptions, {
                            title = "Back",
                            description = "Go back to the previous menu",
                            icon = 'fas fa-arrow-left',
                            onSelect = function()
                                lib.showContext('insurance_menu_police')
                            end
                        })
        
                        for _, accident in ipairs(accidents) do
                            table.insert(accidentOptions, {
                                title = "Accident ID: " .. accident.id,
                                description = "Officer: " .. accident.officer_name .. "\nLocation: " .. accident.road_location .. "\nDate: " .. accident.date  .. "\nObservations: " .. accident.observations,
                                icon = 'fas fa-exclamation-circle',
                                image = accident.screenshot,
                                onSelect = function()
                                    local editOptions = {
                                        {
                                            title = "Edit Report",
                                            description = "Edit the accident report",
                                            icon = 'fas fa-edit',
                                            onSelect = function()
                                                local input = lib.inputDialog('Edit Accident Report', {
                                                    {
                                                        type = 'input',
                                                        label = 'Observations',
                                                        description = 'Enter the observations of the accident',
                                                        name = 'observations',
                                                        icon = 'fas fa-comment',
                                                        default = accident.observations
                                                    },
                                                    {
                                                        type = 'input',
                                                        label = 'Screenshot URL',
                                                        description = 'Paste the URL of the screenshot (optional)',
                                                        name = 'screenshot',
                                                        icon = 'fas fa-camera',
                                                        default = accident.screenshot
                                                    },
                                                })
                                            
                                                if input then
                                                    local observations = input[1] or 'No observations provided'
                                                    local screenshot = input[2] or nil
                                                
                                                    local information = {
                                                        id = accident.id,
                                                        observations = observations,
                                                        screenshot = screenshot,
                                                    }
                                                
                                                    TriggerServerEvent("m-Insurance:Server:EditAccidentReport", information)
                                                else
                                                    Notify("You canceled the accident report.", "error", 5000)
                                                end
                                            end
                                        },
                                        {
                                            title = "Delete Report",
                                            description = "Delete the accident report",
                                            icon = 'fas fa-trash',
                                            onSelect = function()
                                                TriggerServerEvent("m-Insurance:Server:DeleteAccidentReport", accident.id)
                                            end
                                        },
                                        {
                                            title = "Back",
                                            description = "Go back to the previous menu",
                                            icon = 'fas fa-arrow-left',
                                            onSelect = function()
                                                lib.showContext('accident_reports_menu')
                                            end
                                        }
                                    }
                                    lib.registerContext({
                                        id = 'edit_accident_report',
                                        title = 'Edit Accident Report',
                                        options = editOptions
                                    })
                                    lib.showContext('edit_accident_report')
                                end
                            })
                        end
        
                        lib.registerContext({
                            id = 'accident_reports_menu',
                            title = 'Accident Reports',
                            options = accidentOptions
                        })
                        lib.showContext('accident_reports_menu')
                    else
                        Notify("There are no accidents reports for this vehicle", "error", 5000)
                    end
                end, plate)
            end
        },
        {
            title = "Close Menu",
            description = "Exit the menu.",
            icon = 'fas fa-arrow-left',
            event = "ox_lib:closeMenu"
        }
    }

    lib.registerContext({
        id = 'insurance_menu_police',
        title = 'Insurance & Registration Menu',
        options = menuOptions
    })

    lib.showContext('insurance_menu_police')
end)

-- Menu when employes of the insurance company open with command ( This is only if you use with job )
RegisterNetEvent('m-Insurance:Client:OpenInsuranceMenu')
AddEventHandler('m-Insurance:Client:OpenInsuranceMenu', function()
    local OpenInsuranceMenu = {
        id = 'OpenInsuranceMenu',
        title = "Insurance Menu",
        icon = 'fa-solid fa-shield',
        options = {
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
                        local vehicleClass = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false))
                        local vehiclePrice = Config.carInsurance.vehicleClassPrices.prices[vehicleClass] or 1
                        local price = Config.carInsurance.insuranceTypes[2].price * vehiclePrice
                        TriggerServerEvent('m-Insurance:Server:ApplyDocumentsWithJob', input[1], input[2], input[3], input[4], price, "insurance")
                    end
                end
            },
            {
                title = "Recover Documentation",
                description = "Recover the documentation of a vehicle",
                icon = 'fa-solid fa-file',
                onSelect = function()
                    local input = lib.inputDialog('Vehicle Information', {
                        { type = 'input', label = 'Plate of Vehicle', description = 'Please fill with the vehicle plate', required = true },
                    })
            
                    if input then
                        QBCore.Functions.TriggerCallback('m-Insurance:Server:CheckVehicleInformations', function(result)
                            if result then
                                local recoverDocumentsMenu = {
                                    id = 'recoverDocumentsMenu',
                                    title = "Choose an Option for: " .. input[1],
                                    options = {
                                        {
                                            title = "Recover Registration",
                                            description = "Recover your vehicle registration\nPrice: $" .. Config.carInsurance.recoverDocumentation.registration,
                                            icon = 'fa-solid fa-clipboard',
                                            onSelect = function()
                                                TriggerServerEvent('m-Insurance:Server:RecoverDocumentationInsurance', input[1], "registration")
                                            end
                                        },
                                        {
                                            title = "Recover Insurance",
                                            description = "Recover your vehicle insurance\nPrice: $" .. Config.carInsurance.recoverDocumentation.insurance,
                                            icon = 'fa-solid fa-shield',
                                            onSelect = function()
                                                TriggerServerEvent('m-Insurance:Server:RecoverDocumentationInsurance', input[1], "insurance")
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
                            else
                                TriggerEvent('m-Insurance:Client:Notify', 'You do not have any vehicle documentation', 'error')
                            end
                        end, input[1]) 
                    end
                end
            }
        }
    }
    lib.registerContext(OpenInsuranceMenu)
    lib.showContext('OpenInsuranceMenu')
end)

-- Menu when employes of the health insurance company open with command ( This is only if you use with job )
RegisterNetEvent('m-Insurance:Client:OpenHealthInsuranceMenu')
AddEventHandler('m-Insurance:Client:OpenHealthInsuranceMenu', function()
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

                    local input = lib.inputDialog('Write all vehicle information', {
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
end)

-- Menu when a player open the information about own insurance
RegisterNetEvent("m-Insurance:Client:OpenMainInsuranceMenu")
AddEventHandler("m-Insurance:Client:OpenMainInsuranceMenu", function(allInsuranceData)
    local mainMenuOptions = {}

    if #allInsuranceData.carInsurance > 0 then
        table.insert(mainMenuOptions, {
            title = "Car Insurance",
            icon = 'fa-solid fa-car',
            onSelect = function()
                OpenOwnCarInsuranceMenu(allInsuranceData.carInsurance)
            end
        })
    end

    if #allInsuranceData.healthInsurance > 0 then
        table.insert(mainMenuOptions, {
            title = "Health Insurance",
            icon = 'fa-solid fa-user-shield',
            onSelect = function()
                OpenOwnHealthInsuranceMenu(allInsuranceData.healthInsurance)
            end
        })
    end

    if #allInsuranceData.homeInsurance > 0 then
        table.insert(mainMenuOptions, {
            title = "Home Insurance",
            icon = 'fa-solid fa-home',
            onSelect = function()
                OpenOwnHomeInsuranceMenu(allInsuranceData.homeInsurance)
            end
        })
    end

    local mainMenu = {
        id = 'MainInsuranceMenu',
        title = "All of your insurances",
        icon = 'fa-solid fa-shield',
        options = mainMenuOptions
    }

    lib.registerContext(mainMenu)
    lib.showContext('MainInsuranceMenu')
end)

function OpenOwnCarInsuranceMenu(carInsuranceData)
    local carOptions = {}
    for _, vehicle in ipairs(carInsuranceData) do
        local suspendedDocuments = vehicle.suspended and "Yes" or "No"
        local stolenVehicle = vehicle.stolen and "Yes" or "No"
        local registerVehicle = vehicle.registration and "Yes" or "No"
        local insuranceVehicle = vehicle.insurance and "Yes" or "No"
        table.insert(carOptions, {
            title = "Plate: " .. vehicle.plate,
            description = "Owner: " .. vehicle.owner .. "\nInsurance: " .. insuranceVehicle .. "\nRegistration: " .. registerVehicle .. "\nStolen: " .. stolenVehicle .. "\nDocuments Suspended: " .. suspendedDocuments .. "\nExpire: ".. vehicle.registrationExpire,
            icon = 'fa-solid fa-car',
            onlyRead = true,
        })
    end
   
    table.insert(carOptions, {
        title = "Back",
        icon = 'fa-solid fa-arrow-left',
        onSelect = function()
            lib.showContext('MainInsuranceMenu')
        end
    })
    
    local menu = {
        id = 'CarInsuranceMenu',
        title = "Car Insurance Details",
        icon = 'fa-solid fa-car',
        options = carOptions
    }
    lib.registerContext(menu)
    lib.showContext('CarInsuranceMenu')
end

function OpenOwnHealthInsuranceMenu(healthInsuranceData)
    local menuOptions = {}

    for _, health in ipairs(healthInsuranceData) do
        table.insert(menuOptions, {
            title = "Owner: " .. health.owner_name,
            description = "Expire: " .. health.expire_date,
            icon = 'fa-solid fa-user-shield',
            readOnly = true,
        })
    end

    table.insert(menuOptions, {
        title = "Back",
        icon = 'fa-solid fa-arrow-left',
        onSelect = function()
            lib.showContext('MainInsuranceMenu')
        end
    })

    local menu = {
        id = 'HealthInsuranceMenu',
        title = "Health Insurance Details",
        icon = 'fa-solid fa-user-shield',
        options = menuOptions
    }

    lib.registerContext(menu)
    lib.showContext('HealthInsuranceMenu')
end

function OpenOwnHomeInsuranceMenu(homeInsuranceData)
    local menuOptions = {}

    for _, home in ipairs(homeInsuranceData) do
        table.insert(menuOptions, {
            title = "Owner: " .. home.owner_name,
            description = "Expire: " .. home.expire_date,
            icon = 'fa-solid fa-home',
            readOnly = true,
        })
    end
    
    table.insert(menuOptions, {
        title = "Back",
        icon = 'fa-solid fa-arrow-left',
        onSelect = function()
            lib.showContext('MainInsuranceMenu')
        end
    })

    local menu = {
        id = 'HomeInsuranceMenu',
        title = "Home Insurance Details",
        icon = 'fa-solid fa-home',
        options = menuOptions
    }

    lib.registerContext(menu)
    lib.showContext('HomeInsuranceMenu')
end
