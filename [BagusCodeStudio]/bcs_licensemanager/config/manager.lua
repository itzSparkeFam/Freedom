Config.Manager = {
    police = {        -- The name can be anything, does not have to be a job name
        type = 'job', -- type either shop or job this is for non-qtarget server
        job = {
            ['police'] = 0,
            ['government'] = 0,
        },
        background = 'lspd',
        ped = "s_f_y_cop_01",
        coord = {
            vector4(445.841, -990.594, 30.69, 261.853),
            -- vector4(450.2244, -978.7199, 30.68951, 261.2998),
            -- vector4(450.2244, -978.7199, 30.68951, 261.2998)
        },
        canOpen = function() -- THIS IS OPTIONAL!
            -- you can put an additional verification if you use external verification
            return true
        end,
        options = {
            creation = true,
            management = true,
            history = true,
        },
        target = { -- if you are using qtarget and the type is job
            {
                event = "LicenseManager:client:OpenManagerMenu",
                icon = "fas fa-box-circle-check",
                label = "Manage Licenses",
                name = 'police',
                background = 'lspd',
                job = {
                    ['police'] = 0,
                    ['government'] = 0,
                }
            },
        }
    },
    ambulance = {
        type = 'job',
        job = {
            ['ambulance'] = 0,
        },
        ped = "s_m_m_paramedic_01",
        background = 'lsfd',
        coord = {
            vector4(340.7231, -590.1428, 43.28407, 76.19474)
        },
        options = {
            creation = true,
            management = true,
            history = true,
        },
        target = {
            {
                event = "LicenseManager:client:OpenManagerMenu",
                icon = "fas fa-box-circle-check",
                label = "Manage Licenses",
                name = 'ambulance',
                background = 'lsfd',
                job = {
                    ['ambulance'] = 0,
                },
            },
        }
    },
    public = {
        type = 'shop',
        ped = "a_f_y_business_01",
        disableBuy = false, -- Set to true if you want the shop to only be for renewing and retrieving lost license
        coord = {
            vector4(-545.003, -204.12, 38.215, 207.91)
        },
        target = {
            {
                event = "LicenseManager:client:OpenLicenseShop",
                icon = "fas fa-box-circle-check",
                label = "License Request",
                name = 'public',
            }
        }
    },

    illegal_fake = {
        type = 'illegal',
        ped = 'g_m_m_chicold_01',
        coord = {
            vector4(-496.5814, -310.1053, 42.2217, 297.9025)
        },
        target = {
            {
                event = "LicenseManager:client:OpenIllegalShop",
                icon = "fas fa-box-circle-check",
                label = "Buy Fake License",
                name = 'illegal_fake',
            }
        }
    }
}
