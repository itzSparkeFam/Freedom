return {
    ---@type boolean
    debug = true,

    ---@type string
    licenseScript = "bcs_licensemanager",

    ---@type string
    accountType = "bank", -- "bank" or "money" or "cash"

    ---@type string
    locale = 'en',

    ---@type string[]
    vehicles = {
        'enduro',
        'defiler',
        'blista',
        'aleutian',
        'phantom',
        'dinghy',
        'squalo',
        'seasparrow',
        'supervolito',
        'mammatus',
        'duster'
    },

    ---@type string[]
    licenses = {
        'boating',
        'pilot',
        'driver'
    },

    ---@type string[]
    theoryLicenses = {
        'boatingpermit',
        'pilotpermit'
    },
}
