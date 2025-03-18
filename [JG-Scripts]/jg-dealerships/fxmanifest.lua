fx_version "cerulean"
game "gta5"
lua54 "yes"

description "For support or other queries: discord.gg/jgscripts"
version 'v1.4.1'
author "JG Scripts"

dependencies {
  "oxmysql",
  "ox_lib",
  "/server:7290",
  "/onesync",
}

shared_scripts {
  "@ox_lib/init.lua",
  "config/config.lua",
  "locales/*.lua",
  "shared/main.lua",
  "framework/main.lua"
}

client_scripts {
  "framework/**/cl-*.lua",
  "client/cl-main.lua",
  "client/*.lua",
  "config/config-cl.lua"
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server/sv-webhooks.lua",
  "framework/**/sv-*.lua",
  "server/*.lua",
  "config/config-sv.lua"
}

ui_page "web/dist/index.html"

files {
  "web/dist/index.html",
  "web/dist/**/*"
}

escrow_ignore {
  "shared/*",
  "config/**/*",
  "framework/**/*",
  "locales/*",
  "client/cl-locations.lua",
  "server/sv-webhooks.lua",
  "client/cl-purchase.lua",
  "server/sv-purchase.lua"
}

dependency '/assetpacks'