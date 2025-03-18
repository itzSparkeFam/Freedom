fx_version "bodacious"
games {"gta5"}

ui_page 'html/index.html'

client_scripts {
    'client/framework/*.lua',
    'client/client.lua',
    'client/utils.lua',
} 

shared_scripts {
    'config.lua',
	'excrow_shared.lua',
}

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/app.js',
	'html/img/*.png',
    'html/fonts/BrittanySignature-LjyZ.otf'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/framework/*.lua',
    'server/server.lua',
    'server/utils.lua',
}

escrow_ignore {
	'config.lua',
	'excrow_shared.lua',
    'client/utils.lua',
    'server/utils.lua',
    'client/framework/*.lua',
    'server/framework/*.lua',
}

lua54 'yes'
dependency '/assetpacks'