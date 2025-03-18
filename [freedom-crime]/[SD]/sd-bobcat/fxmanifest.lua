server_script "HAC3.lua"
client_script "HAC3.lua"
fx_version 'cerulean'
game 'gta5'

Author 'Samuel#0008'
Version '1.5.71'

client_scripts { 'client/*.lua', }

shared_scripts { '@ox_lib/init.lua', '@sd_lib/init.lua', 'config.lua', }

server_scripts { 'server/*.lua'} 

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua', 'doorlock/qb-nui_doorlock/*.lua', }
dependency '/assetpacks'