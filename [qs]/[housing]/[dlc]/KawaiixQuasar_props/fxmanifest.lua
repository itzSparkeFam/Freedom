fx_version 'bodacious'

games { 'rdr3', 'gta5' }

lua54 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/kawaiispace_gaming.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/kawaiispace_stations.ytyp'

client_scripts {
    'client.lua'
}

escrow_ignore {
    'client.lua'
}

dependency '/assetpacks'