--[[
BY RX Scripts © rxscripts.xyz
--]]

fx_version 'cerulean'
games { 'gta5' }

author 'Rejox | rxscripts.xyz'
description 'Advanced Hunting'
version '1.6.5'

shared_script {
  '@ox_lib/init.lua',
  'config/config.lua',
  'config/levels.lua',
  'config/cutweapons.lua',
  'config/animals.lua',
  'config/zones.lua',
  'config/usables.lua',
  'config/missions.lua',
  'init.lua',
  'locales/*.lua',
  'shared/*.lua',
}

client_scripts {
  'client/utils.lua',
  'client/functions.lua',
  'client/opensource.lua',
  'client/main.lua',
}

server_scripts {
  'server/utils.lua',
  'server/functions.lua',
  'server/opensource.lua',
  'server/main.lua',
}

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/img/*.*',
  'web/build/**/*',
}

lua54 'yes'

escrow_ignore {
  'server/opensource.lua',
  'client/opensource.lua',
  'config/*.lua',
  'locales/*.lua',
  'fxmanifest.lua'
}
dependency '/assetpacks'