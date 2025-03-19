fx_version "cerulean"
game "gta5"
lua54 "yes"

author "17Movement"
version "1.0.81"
this_is_a_map 'yes'

shared_scripts {
    "shared/locale.lua",
    "locale/*.lua",
    "configs/Config.lua",
    "configs/Location.lua",
    "configs/Photos.lua",
    "configs/Register.lua",
    "configs/Selector.lua",
    "configs/Skin.lua",
    "shared/core.lua",
    "shared/skingenerator.lua",
    "shared/translator.lua",
}

client_script {
    "client/core.lua",
    "client/functions.lua",
    "client/photos.lua",
    "client/skin.lua",
    "client/selector.lua",
    "client/register.lua",
    "client/location.lua",
    "client/loadingscreen.lua",
    "client/stores.lua",
    "bridge/**/client.lua",
    "bridge/illenium.lua",
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    "configs/Discord.lua",
    "server/functions.lua",
    "server/core.lua",
    "server/photos.lua",
    "server/selector.lua",
    "server/register.lua",
    "server/location.lua",
    "server/skin.lua",
    "bridge/**/server.lua",
}

ui_page "web/index.html"
files {
    "web/**.*",
    "web/**/**.*",
    "web/**/**/**.*"
}

provides {
    -- QB:
    "qb-loading",
    "qb-multicharacter",
    "qb-spawn",
    "qb-clothing",

    -- ESX:
    "esx_multicharacter",
    "esx_identity",
    "esx_skin",
    "esx_loadingscreen",
    "skinchanger",
}

loadscreen "web/index.html"
loadscreen_manual_shutdown "yes"
loadscreen_cursor "yes"

data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/17mov_clothes_greenscreen.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/17mov_apartment_items.ytyp'

escrow_ignore {
    "configs/*.lua",
    "locale/*.lua",

    "bridge/**/**.*",
    "bridge/illenium.lua",

    "client/functions.lua",
    "client/location.lua",
    "client/main.lua",
    "client/stores.lua",

    "server/functions.lua",
    "server/main.lua",
    "server/skin.lua",
    "server/location.lua",
}
dependency '/assetpacks'