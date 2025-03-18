Config.Licenses = {
    weapon = {
        id_length = 5,                          -- random number generated
        label = "Weapon License",
        manager = { 'police' }, -- the shop or manager menu in Config.Manager
        job = { 'police', 'government' },       -- the job that can revoke the license
        validFor = 30,                          -- valid for how many days?
        price = 5000,
        lostPrice = 2500,                       -- Price to retrieve the license when the card is lost (will be enabled if Config.inventory is true)
        illegalPrice = 25000
    },
    weapon2 = {
        id_length = 5,                          -- random number generated
        label = "Weapon License C2",
        manager = { 'police' }, -- the shop or manager menu in Config.Manager
        job = { 'police', 'government' },       -- the job that can revoke the license
        validFor = 14,                          -- valid for how many days?
        price = 7500,
        lostPrice = 7000,                       -- Price to retrieve the license when the card is lost (will be enabled if Config.inventory is true)
        illegalPrice = 500000
    },
    weapon3 = {
        id_length = 5,                          -- random number generated
        label = "Weapon License C3",
        manager = { 'police' }, -- the shop or manager menu in Config.Manager
        job = { 'police', 'government' },       -- the job that can revoke the license
        validFor = 14,                          -- valid for how many days?
        price = 10000,
        lostPrice = 7000,                       -- Price to retrieve the license when the card is lost (will be enabled if Config.inventory is true)
        illegalPrice = 500000
    },
    driver = {
        id_length = 8,
        label = "Driver License",
        manager = 'public', -- must belong to one of Config.Manager list
        job = 'police',
        validFor = 30,
        price = 200,
        lostPrice = 100
    },
    boating = {
        id_length = 8,
        label = "Boating License",
        manager = 'public',
        requires = {
            'boatingpermit',
        },
        job = 'police',
        validFor = 30,
        price = 2500,
        lostPrice = 1000
    },
    pilot = {
        id_length = 8,
        label = "Pilots License",
        manager = 'public', -- must belong to one of Config.Manager list
        requires = {
            'pilotpermit',
        },
        job = { 'police', 'government' },
        validFor = 30,
        price = 60000,
        lostPrice = 1000
    },
    hunting = {
        id_length = 5,
        label = "Hunting License",
        manager = { 'police' }, 
        job = { 'police', 'government' },       
        validFor = 31,                          
        price = 5000,
        lostPrice = 2500,
    },
    paramedic = {
        id_length = 5,
        label = "Paramedic License",
        manager = 'ambulance',
        job = 'ambulance',
        validFor = 31,
        price = 1000,
        lostPrice = 500
    },
    identification = {
        id_length = 10,
        label = "Identification Card",
        manager = 'public',
        job = 'police',
        validFor = 31,
        price = 50,
        lostPrice = 25
    },
    business = {
        id_length = 5,                          -- random number generated
        label = "Business License",
        manager = { 'police' }, -- the shop or manager menu in Config.Manager
        job = { 'police', 'government' },       -- the job that can revoke the license
        validFor = 31,                          -- valid for how many days?
        price = 12000,
        lostPrice = 100,                       -- Price to retrieve the license when the card is lost (will be enabled if Config.inventory is true)
    },
    pilotpermit = {
        id_length = 8,
        label = "Pilot Permit",
        manager = 'police',
        job = 'police',
        validFor = 31,
        price = 2500,
        nonItem = true,
        lostPrice = 1000
    },
    boatingpermit = {
        id_length = 8,
        label = "Boating Permit",
        manager = 'police',
        job = 'police',
        validFor = 31,
        price = 2500,
        nonItem = true,
        lostPrice = 1000
    }
}

Config.JobLicenses = {}

for k, v in pairs(Config.Licenses) do
    if type(v.job) == 'string' and Config.JobLicenses[v.job] then
        Config.JobLicenses[v.job][#Config.JobLicenses[v.job] + 1] = k
    elseif type(v.job) == 'string' then
        Config.JobLicenses[v.job] = { k }
    elseif type(v.job) == 'table' then
        for _, job in pairs(v.job) do
            if Config.JobLicenses[job] then
                Config.JobLicenses[job][#Config.JobLicenses[job] + 1] = k
            else
                Config.JobLicenses[job] = { k }
            end
        end
    end
    if type(v.manager) == 'string' and Config.Manager[v.manager] then
        if Config.Manager[v.manager].licenses then
            Config.Manager[v.manager].licenses[k] = v
            Config.Manager[v.manager].licenses[k].illegalPrice = v.illegalPrice or v.price
        elseif Config.Manager[v.manager] then
            Config.Manager[v.manager].licenses = {}
            Config.Manager[v.manager].licenses[k] = v
            Config.Manager[v.manager].licenses[k].illegalPrice = v.illegalPrice or v.price
        end
    elseif type(v.manager) == 'table' then
        for _, manager in pairs(v.manager) do
            if Config.Manager[manager].licenses then
                Config.Manager[manager].licenses[k] = v
                Config.Manager[manager].licenses[k].illegalPrice = v.illegalPrice or v.price
            elseif Config.Manager[manager] then
                Config.Manager[manager].licenses = {}
                Config.Manager[manager].licenses[k] = v
                Config.Manager[manager].licenses[k].illegalPrice = v.illegalPrice or v.price
            end
        end
    else
        print(string.format('[^1ERROR^0]: Please make sure ^2%s^0 in the license ^2%s^0 exists in the ^3manager.lua',
            v.manager, k))
    end
end
