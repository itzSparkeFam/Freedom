shared_script "@ReaperV4/await.lua"
client_script "@ReaperV4/c-bypass.lua"
server_script "@ReaperV4/s-bypass.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

description 'QB-Skillbar'
version '1.2.0'

ui_page 'html/index.html'

client_script 'client/main.lua'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
}

dependency 'qb-core'

lua54 'yes'