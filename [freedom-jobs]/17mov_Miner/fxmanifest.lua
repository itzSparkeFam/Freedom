fx_version "cerulean"
version "1.0.26"
game "gta5"
author "17Movement"
lua54 'yes'
this_is_a_map 'yes'

shared_script "Config.lua"

server_scripts {
    "server/functions.lua",
    "server/core.lua",
    "server/server.lua",
}

client_scripts {
    "client/functions.lua",
    "client/core.lua",
    "client/client.lua",
    "client/target.lua",
}

ui_page "web/index.html"

files {
    "web/index.html",
    "web/assets/**/*.*",
    'stream/data/17mov_door_game.dat151.rel',
    'stream/data/17movtimecycleinteriorminer.xml',
    'stream/data/17movmineshafttimecycle.xml',
}

escrow_ignore {
    "Config.lua",
    "client/target.lua",
    "client/functions.lua",
    "server/functions.lua",
}

data_file 'AUDIO_GAMEDATA' 'stream/data/17mov_door_game.dat'

data_file 'TIMECYCLEMOD_FILE' 'stream/data/17movtimecycleinteriorminer.xml'
data_file 'TIMECYCLEMOD_FILE' 'stream/data/17movmineshafttimecycle.xml'

data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/mineshaft_main.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/mineshaft_building_mlo_main.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/17mov_miner_door.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/17mov_casino_door_01c.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/mineshaft_building_mlo_shell_lod.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ytyp/17mov_mining_ytyp.ytyp'
dependency '/assetpacks'