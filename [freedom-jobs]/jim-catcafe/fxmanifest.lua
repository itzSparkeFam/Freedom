name "Jim-CatCafe"
author "Jimathy"
version "2.0"
description "CatCafe Script By Jimathy - Props by idRP - ZenKat"
fx_version "cerulean"
game "gta5"
lua54 'yes'

server_script '@oxmysql/lib/MySQL.lua'

shared_scripts {
    'locales/*.lua*',
    'config.lua',
    'locations/*.lua',

    -- Required core scripts
    '@ox_lib/init.lua',
    '@ox_core/imports/client.lua',
    '@es_extended/imports.lua',
    '@qbx_core/modules/playerdata.lua',

    --Jim Bridge
    '@jim_bridge/exports.lua',
    '@jim_bridge/functions.lua',
    '@jim_bridge/wrapper.lua',
    '@jim_bridge/crafting.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@warmenu/warmenu.lua',

    'client/*.lua',
}

server_script 'server/*.lua'

escrow_ignore {
    '*.lua',
    'client/client.lua',
    'client/chairs.lua',
    'client/consume.lua',
    'server/server.lua',
    'locales/*.lua',
    'locations/*.lua',
    '.install/*.lua',
    '.install/*.md',
    '.install/*.sql',
}

dependency 'jim_bridge'

file 'stream/**.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
dependency '/assetpacks'