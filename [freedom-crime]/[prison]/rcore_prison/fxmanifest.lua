--[[ FX Information ]]--
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'rcore_prison'
author       'NewEdit | rcore.cz'
version      '2.0.41'
description  'Standalone unique Prison system - prison break, prison jobs and more!'

shared_scripts {
    'shared/sh-utils.lua',
    'shared/sh-const.lua',
    'shared/sh-locale.lua',
    'data/locales/*.lua',
    'config.lua',
    'shared/sh-init.lua',
    'modules/base/shared/api/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    'sconfig.lua',
    'permissions.lua',
    
    'modules/base/server/sv-ace.lua',
    'modules/base/server/models/*.lua',

    'modules/bridge/server/sv-deployer.lua',
    'modules/bridge/server/sv-bridge.lua',


    'modules/bridge/server/database/sv-ghmatti.lua',
    'modules/bridge/server/database/sv-db.lua',

    'modules/bridge/server/framework/*.lua',
    
    'modules/bridge/server/inventory/sv-ox_inventory.lua',
    'modules/bridge/server/inventory/sv-qs_inventory.lua',
    'modules/bridge/server/inventory/sv-cheeza_inventory.lua',
    'modules/bridge/server/inventory/sv-esx_inventory.lua',
    'modules/bridge/server/inventory/sv-qb_inventory.lua',
    'modules/bridge/server/inventory/sv-origen_inventory.lua',
    'modules/bridge/server/inventory/sv-mf_inventory.lua',
    'modules/bridge/server/inventory/sv-ps_inventory.lua',
    'modules/bridge/server/inventory/sv-lj_inventory.lua',
    'modules/bridge/server/inventory/sv-core_inventory.lua',
    'modules/bridge/server/inventory/sv-codem_inventory.lua',
    'modules/bridge/server/inventory/sv-tgiann-inventory.lua',
    'modules/bridge/server/inventory/sv-standalone.lua',


    'modules/bridge/server/booths/*.lua',
    'modules/bridge/server/other/*.lua',
    'modules/bridge/server/dispatch/*.lua',

    'modules/bridge/server/sv-integration-test.lua',

    'modules/bridge/server/rcore/*.lua',

    'modules/bridge/server/notify/*.lua',
    'modules/bridge/server/doorlocks/*.lua',
    'modules/bridge/server/consumables/*.lua',
    'modules/bridge/server/maps/*.lua',

    'modules/base/server/sv-callback.lua',

    'modules/base/server/init/*.lua',
    'modules/base/server/models/*.lua',
    'modules/base/server/services/*.lua',
    'modules/base/server/lib/*.lua',
    'modules/base/server/storage/*.lua',
    'modules/base/server/lifecycle/init/*.lua',
    'modules/base/server/api/*.lua',
    'modules/base/server/sv-commands.lua',
    'modules/base/server/*.lua',

    'modules/bridge/server/sv-migration.lua',
}


client_scripts {
    'outfits.lua',

    'modules/bridge/client/cl-bridge.lua',

    'modules/bridge/client/framework/*.lua',

    'modules/bridge/client/target/cl-main.lua',
    'modules/bridge/client/menu/cl-main.lua',

    'modules/base/client/cl-callback.lua',

    'modules/base/client/init/*.lua',
    'modules/base/client/models/*.lua',
    'modules/base/client/services/*.lua',
    'modules/base/client/lib/menu/*.lua',
    'modules/base/client/lib/menu/menus/*.lua',
    'modules/base/client/lib/*.lua',
    'modules/base/client/storage/*.lua',
    'modules/base/client/lifecycle/**/*.lua',
    'modules/base/client/api/*.lua',

    'modules/bridge/client/clothing/utils/*.lua',
    'modules/bridge/client/clothing/*.lua',
    
    'modules/bridge/client/notify/cl-main.lua',
    'modules/bridge/client/textUI/cl-main.lua',
    'modules/bridge/client/dispatch/*.lua',
}


escrow_ignore {
    'modules/base/server/services/sv-se-chat.lua',
    'modules/bridge/client/clothing/*.lua',
    'modules/bridge/client/clothing/utils/*.lua',
    'modules/bridge/client/dispatch/*.lua',
    'modules/bridge/client/framework/*.lua',
    'modules/bridge/client/notify/*.lua',
    'modules/bridge/client/textUI/*.lua',

    'assets/includedLibrary',
    'assets/includedMaps',
    'assets/inventoryImages',

    'modules/bridge/server/database/*.lua',
    'modules/bridge/server/dispatch/*.lua',
    'modules/bridge/server/framework/*.lua',
    'modules/bridge/server/inventory/*.lua',
    'modules/bridge/server/notify/*.lua',
    'modules/bridge/server/booths/*.lua',

    'modules/base/shared/api/sh-time.lua',
    'modules/base/server/api/*.lua',
    'modules/base/server/sv-commands.lua',

    'modules/base/client/api/*.lua',
    'permissions.lua',
    'config.lua',
    'sconfig.lua',
    'outfits.lua',
    'zones.json',
    'hideModels.json',
    'data/locales/*.lua',
    'data/presets/*.lua',
}


ui_page 'modules/nui/web/build/index.html'

files {
	'zones.json',
    'hideModels.json',
    'modules/nui/web/build/index.html',
    'modules/nui/web/build/config.js',
    'modules/nui/web/build/images/*.png',
    'modules/nui/web/build/images/*.jpg',
    'modules/nui/web/build/images/*.jpeg',
	'modules/nui/web/build/**/*',
    'assets/inventoryImages/png/*.png',
    'assets/inventoryImages/webp/*.webp',
	'data/*.lua',
	'data/**/*.lua',
}

dependencies {
	'/server:5104',
	'/onesync',
    'rcore_prison_assets'
}

dependency '/assetpacks'