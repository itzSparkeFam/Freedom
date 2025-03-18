fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

name 'tgg-hud'
description 'A simple and clean HUD for FiveM'
author 'TeamsGG Development'
version '1.1.5'

ui_page 'ui/build/index.html'

files {
    'ui/build/**/*',
    'locales/*.json',
    'data/tgg-hud.dat54.rel',
    'audiodirectory/teamsgg.awc'
}

data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'data/tgg-hud.dat'

ox_libs {
    'locale',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/init.lua',
    'config/*.lua'
}

client_script 'client/**/*.lua'

server_scripts {
    'server/frameworks/*.lua',
    'server/*.lua'
}

escrow_ignore {
    'config/*',

    'client/custom/**/*',
    'server/frameworks/*'
}

dependency '/assetpacks'
dependency '/assetpacks'