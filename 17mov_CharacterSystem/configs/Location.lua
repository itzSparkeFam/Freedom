Location = {}
Location.Enable = true
Location.EnableForNewCharacters = true
Location.EnableForExistingCharacters = true

-- Supported only on QBCore
Location.EnableApartments = 'qb-apartments'                  -- Let players choose a starting apartment on first spawn. You can use values: false, "qb-apartments", "ps-housing"
Location.EnableSpawningInHouses = true            -- Let players spawn in their houses
Location.EnableQBHousing = true                    -- Enabling support for qb-housing | ps-housing

Location.DefaultSpawnLocation = vector3(-1037.58, -2737.48, 20.17)  -- Used if Location.Enable is false, this is coordinates where player spawns
Location.InvalidLastLocationSpawnLocation = vector3(200.17, -936.96, 30.69) -- Position where character will spawn in case when your framework incorrectly saves the last position (SEE: https://github.com/esx-framework/esx_core/issues/1421)

Location.Spawns = {
    {
        name = "legion",
        coords = vector4(195.17, -933.77, 29.7, 144.5),
        label = "Legion Square",
        type = "location",
    },
    {
        name = "policedp",
        coords = vector4(-574.534, -404.123, 35.182, 92.92),
        label = "Police Department",
        type = "location",
    },
    {
        name = "paleto",
        coords = vector4(80.35, 6424.12, 31.67, 45.5),
        label = "Paleto Bay",
        type = "location",
    },
    {
        name = "motel",
        coords = vector4(327.56, -205.08, 53.08, 163.5),
        label = "Motels",
        type = "location",
    },
}