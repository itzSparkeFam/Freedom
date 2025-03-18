fx_version 'cerulean'

game 'gta5'

lua54 'yes'

version '1.0.5'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/utils.lua',
    'shared/furniture.lua',
    'shared/functions.lua',
    'locales/*.lua'
}

ox_libs {
    'table',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/modules/**',
    'server/custom/**',
    'server/main.lua'
}

client_scripts {
    'client/custom/**',
    'client/modules/*.lua',
    'client/main.lua'
}

ui_page 'html/index.html'
files {
    'shell_offsets.json',
    'html/**'
}

escrow_ignore {
    'shared/config.lua',
    'shared/furniture.lua',
    'locales/*.lua',
    'client/custom/**/**.lua',
    'server/custom/**/**.lua'
}

provide {
    'qb-apartments',
    'qbx_apartments'
}

dependencies {
    'ox_lib',
}

dependency '/assetpacks'