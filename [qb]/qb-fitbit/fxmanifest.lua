shared_script "@ReaperV4/await.lua"
client_script "@ReaperV4/c-bypass.lua"
server_script "@ReaperV4/s-bypass.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Functional item that allows players to track their hunger and thirst'
version '1.2.0'

ui_page 'html/index.html'

files {
    'html/*'
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

server_script 'server/main.lua'
client_script 'client/main.lua'
