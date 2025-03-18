fx_version 'cerulean'
game 'gta5'

description 'Clean UI to view connected players and job counts'
version '1.3.1'
author 'JG Scripts'

shared_scripts {'config.lua', 'framework/main.lua'}

client_scripts {'framework/cl-functions.lua', 'client/main.lua'}

server_scripts {'framework/sv-functions.lua', 'server/main.lua'}

ui_page 'html/index.html'

files {'html/**/*'}

escrow_ignore {'config.lua', 'framework/**/*'}

lua54 'yes'

dependency '/assetpacks'