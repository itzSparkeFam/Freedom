fx_version 'cerulean'

description 'An advanced billing system for FiveM.'
author 'TeamsGG Development'
version '1.3.3'

lua54 'yes'

games {
  'gta5',
}

ui_page 'ui/build/index.html'

shared_scripts {
  '@ox_lib/init.lua',
  'config/*.lua',
  'shared/**/*.lua',
}

client_script 'client/**/*.lua'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/**/*.lua'
}

files {
  'ui/build/**/*',
}

escrow_ignore {
  'client/custom/**/*',
  'client/functions/**/*',

  'server/custom/**/*',
  'server/functions/**/*',

  'shared/*.lua',

  'config/*.lua',
}

dependencies {
  'ox_lib',
  'oxmysql'
}

dependency '/assetpacks'