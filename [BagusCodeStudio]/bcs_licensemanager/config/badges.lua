---@class Badge
---@field department string
---@field ped string
---@field coords table<number, vector4>

--- The name for this example will be 'lspd_badge'
Config.BadgeItemName = function(department)
    return department:lower() .. '_badge'
end

Config.Badges = {
    {
        department = "LSPD",
        ped = 's_m_y_hwaycop_01',
        coords = {
            vec4(469.051, -978.093, 30.692, 88.949)
        },
        color = '#3693ed',
        permissions = {
            viewManager = { ['police'] = 2 },
            creator = { ['police'] = 2 },
            edit = {
                ['police'] = 3,
            },
            delete = {
                ['police'] = 3
            }
        }
    },
}
