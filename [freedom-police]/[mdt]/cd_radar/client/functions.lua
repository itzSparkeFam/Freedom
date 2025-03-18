RegisterNetEvent('cd_radar:ScriptRestarted')
AddEventHandler('cd_radar:ScriptRestarted', function()
    while not Authorised do Wait(1000) end
    Wait(1000)
    if IsAllowed() then
        TriggerServerEvent('cd_radar:RadarDatabase_UPDATE')
    end
    if Config.VehiclesData.ENABLE then
        TriggerServerEvent('cd_radar:VehicleData')
    end
end)

function GetPlate(vehicle)
    return GetVehicleNumberPlateText(vehicle)
end

RegisterNetEvent('cd_radar:ToggleNUIFocus_1')
AddEventHandler('cd_radar:ToggleNUIFocus_1', function()
    Wait(100)
    NUI_status = true
    while NUI_status do
        Wait(5)
        SetNuiFocus(NUI_status, NUI_status)
    end
    SetNuiFocus(false, false)
end)

RegisterNetEvent('cd_radar:ToggleNUIFocus_2')
AddEventHandler('cd_radar:ToggleNUIFocus_2', function()
    NUI_status = true
    SetUserRadioControlEnabled(false)
    while NUI_status do
        Wait(0)
        SetNuiFocus(NUI_status, NUI_status)
        SetNuiFocusKeepInput(NUI_status)
        for cd = 1, #Config.DisabledKeys do
            DisableControlAction(0, Config.DisabledKeys[cd], true)
        end
        SetPlayerCanDoDriveBy(PlayerId(), false)
        HudWeaponWheelIgnoreSelection(true)
    end
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    SetPlayerCanDoDriveBy(PlayerId(), true)
    SetUserRadioControlEnabled(true)
    HudWeaponWheelIgnoreSelection(false)
    local count, keys = 0, {177, 200, 202, 322}
    while count < 100 do 
        Wait(0)
        count=count+1
        for cd = 1, #keys do
            DisableControlAction(0, keys[cd], true)
        end
    end
end)

RegisterNetEvent('cd_radar:Callback')
AddEventHandler('cd_radar:Callback', function(id, result)
    CB[id] = result
    Wait(5000)
    CB[id] = nil
end)

function Callback(action, data)
    CB_id = CB_id + 1
    TriggerServerEvent('cd_radar:Callback', CB_id, action, data)
    local timeout = 0 while CB[CB_id] == nil and timeout <= 50 do Wait(0) timeout=timeout+1 end
    return CB[CB_id]
end

function IsEmergancyVehicle(vehicle)
    if not vehicle then
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    end
    local vehicle_class = GetVehicleClass(vehicle)
    if vehicle and vehicle_class == 18 then
        return true
    end
    return false
end




local car_colours = {    --[[Black]]    { index = 0, label = 'black'},    { index = 1, label = 'black'},    { index = 2, label = 'black'},    { index = 3, label = 'grey'},    { index = 11, label = 'black'},    { index = 12, label = 'matte black'},    { index = 15, label = 'black'},    { index = 16, label = 'black'},    { index = 21, label = 'oil'},    { index = 147, label = 'carbon'},     --[[White]]    { index = 106, label = 'white'},    { index = 107, label = 'creme'},    { index = 111, label = 'white'},    { index = 112, label = 'white'},    { index = 113, label = 'beige'},    { index = 121, label = 'white'},    { index = 122, label = 'white'},    { index = 131, label = 'white'},    { index = 132, label = 'white'},    { index = 134, label = 'white'},    --[[Grey]]    { index = 4, label = 'silver'},    { index = 5, label = 'grey'},    { index = 6, label = 'grey'},    { index = 7, label = 'grey'},    { index = 8, label = 'grey'},    { index = 9, label = 'night'},    { index = 10, label = 'aluminum'},    { index = 13, label = 'grey'},    { index = 14, label = 'grey'},    { index = 17, label = 'grey'},    { index = 18, label = 'grey'},    { index = 19, label = 'silver'},    { index = 20, label = 'grey'},    { index = 22, label = 'grey'},    { index = 23, label = 'grey'},    { index = 24, label = 'grey'},    { index = 25, label = 'silver'},    { index = 26, label = 'titanium'},    { index = 66, label = 'grey'},    { index = 93, label = 'champagne'},    { index = 144, label = 'grey'},    { index = 156, label = 'grey'},    --[[Red]]    { index = 27, label = 'red'},    { index = 28, label = 'red'},    { index = 29, label = 'red'},    { index = 30, label = 'red'},    { index = 31, label = 'red'},    { index = 32, label = 'red'},    { index = 33, label = 'red'},    { index = 34, label = 'red'},    { index = 35, label = 'red'},    { index = 39, label = 'red'},    { index = 40, label = 'red'},    { index = 43, label = 'red'},    { index = 44, label = 'red'},    { index = 46, label = 'red'},    { index = 143, label = 'red'},    { index = 150, label = 'red'},    --[[Pink]]    { index = 135, label = 'pink'},    { index = 136, label = 'pink'},    { index = 137, label = 'pink'},    --[[Blue]]    { index = 54, label = 'blue'},    { index = 60, label = 'blue'},    { index = 61, label = 'blue'},    { index = 62, label = 'blue'},    { index = 63, label = 'blue'},    { index = 64, label = 'blue'},    { index = 65, label = 'blue'},    { index = 67, label = 'blue'},    { index = 68, label = 'blue'},    { index = 69, label = 'blue'},    { index = 70, label = 'blue'},    { index = 73, label = 'blue'},    { index = 74, label = 'blue'},    { index = 75, label = 'blue'},    { index = 77, label = 'blue'},    { index = 78, label = 'blue'},    { index = 79, label = 'blue'},    { index = 80, label = 'blue'},    { index = 82, label = 'blue'},    { index = 83, label = 'blue'},    { index = 84, label = 'blue'},    { index = 85, label = 'blue'},    { index = 86, label = 'blue'},    { index = 87, label = 'blue'},    { index = 127, label = 'blue'},    { index = 140, label = 'blue'},    { index = 141, label = 'blue'},    { index = 146, label = 'blue'},    { index = 157, label = 'blue'},    --[[Yellow]]    { index = 42, label = 'yellow'},    { index = 88, label = 'yellow'},    { index = 89, label = 'yellow'},    { index = 91, label = 'yellow'},    { index = 126, label = 'yellow'},    --[[Green]]    { index = 49, label = 'green'},    { index = 50, label = 'green'},    { index = 51, label = 'green'},    { index = 52, label = 'green'},    { index = 53, label = 'green'},    { index = 55, label = 'green'},    { index = 56, label = 'green'},    { index = 57, label = 'green'},    { index = 58, label = 'green'},    { index = 59, label = 'green'},    { index = 92, label = 'green'},    { index = 125, label = 'green'},    { index = 128, label = 'green'},    { index = 133, label = 'green'},    { index = 151, label = 'green'},    { index = 152, label = 'green'},    { index = 155, label = 'green'},    --[[Orange]]    { index = 36, label = 'orange'},    { index = 38, label = 'orange'},    { index = 41, label = 'orange'},    { index = 123, label = 'orange'},    { index = 124, label = 'orange'},    { index = 130, label = 'orange'},    { index = 138, label = 'orange'},    --[[Brown]]    { index = 45, label = 'copper'},    { index = 47, label = 'brown'},    { index = 48, label = 'brown'},    { index = 90, label = 'bronze'},    { index = 94, label = 'brown'},    { index = 95, label = 'brown'},    { index = 96, label = 'brown'},    { index = 97, label = 'brown'},    { index = 98, label = 'brown'},    { index = 99, label = 'beige'},    { index = 100, label = 'brown'},    { index = 101, label = 'brown'},    { index = 102, label = 'brown'},    { index = 103, label = 'brown'},    { index = 104, label = 'brown'},    { index = 105, label = 'brown'},    { index = 108, label = 'brown'},    { index = 109, label = 'brown'},    { index = 110, label = 'brown'},    { index = 114, label = 'brown'},    { index = 115, label = 'brown'},    { index = 116, label = 'beige'},    { index = 129, label = 'brown'},    { index = 153, label = 'brown'},    { index = 154, label = 'beige'},    --[[Purple]]    { index = 71, label = 'purple'},    { index = 72, label = 'purple'},    { index = 76, label = 'violet'},    { index = 81, label = 'purple'},    { index = 142, label = 'violet'},    { index = 145, label = 'purple'},    { index = 148, label = 'purple'},    { index = 149, label = 'purple'},    --[[Chrome]]    { index = 117, label = 'chrome'},    { index = 118, label = 'chrome'},    { index = 119, label = 'aluminum'},    --[[Metal]]    { index = 120, label = 'chrome'},    { index = 37, label = 'gold'},    { index = 158, label = 'gold'},    { index = 159, label = 'gold'},    { index = 160, label = 'gold'}}
function GetVehicleColour(vehicle)
    local colour, primary, secondary = L('unknown'), GetVehicleColours(vehicle)
    for c, d in pairs (car_colours) do
        if d.index == primary then
            colour = d.label
            break
        end
    end
    return colour
end

function GetVehicleLabel(hash)
    local vehicle_label = string.lower(GetDisplayNameFromVehicleModel(hash))
    if vehicle_label == 'null' or vehicle_label == 'carnotfound' or vehicle_label == 'NULL' then
        vehicle_label = L('vehicle')
    end
    if vehicle_label ~= 'null' or vehicle_label ~= 'carnotfound' or vehicle_label ~= 'NULL'then
        local text = GetLabelText(vehicle_label)
        if text == nil or text == 'null' or text == 'NULL' then
            vehicle_label = vehicle_label
        else
            vehicle_label = text
        end
    end
    return vehicle_label
end

function GetVehicleData(vehicle)
    local hash = GetEntityModel(vehicle)
    local default = {
       name = GetVehicleLabel(hash),
       colour = GetVehicleColour(vehicle),
       plate = GetPlate(vehicle)
    }
    local self = {}
    if Config.VehiclesData.ENABLE and VehicleData and VehicleData[hash] then
        self.name = VehicleData[hash] or default.name
        self.colour = default.colour
        self.plate = default.plate

    else
        self.name = default.name
        self.colour = default.colour
        self.plate = default.plate
    end
    return self
end
