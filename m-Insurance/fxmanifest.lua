fx_version 'cerulean'
author 'marcinhu'
Description 'm-Insurance - marcinhu.tebex.io'
game 'gta5'

data_file 'DLC_ITYP_REQUEST' 'stream/m_insurance_cards.ytyp'

ui_page 'html/index.html'

shared_scripts {
    "@ox_lib/init.lua",
    "configs/**",
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    "server/**.lua",
}

client_script {
    "client/**.lua",
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/main.js',
    'html/img/*'
}

escrow_ignore {
    "client/c_events.lua",
    "client/c_functions.lua",
    "configs/**.lua",
    "server/s_commands.lua",
    "server/s_utils.lua",
}

lua54 'yes'
dependency '/assetpacks'

dependency '/assetpacks'