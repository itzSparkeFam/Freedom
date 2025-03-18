if Config.Dispatch ~= 'default' then return end

function AlarmDispatch()
    local house = CurrentHouse
    -- Your alarm dispatch
    print('Alarm Dispatched', house)
end

function SensorDispatch()
    local house = CurrentHouse
    -- Your sensor dispatch
    print('Sensor Dispatched', house)
end
