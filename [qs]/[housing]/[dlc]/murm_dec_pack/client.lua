CreateThread(function()
    Wait(1500)
    -- Cabinet 1
    local cabinet1Items = {
        ['img'] = 'https://i.ibb.co/kXJcYmv/gcom-dec-pack-cabinet.webp',
        ['object'] = 'gcom_dec_pack_cabinet',
        ['price'] = 220,
        ['label'] = 'GCOM cabinet',
        ['description'] = 'A luxurious and very detailed cabinet, really good!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('hangingcaninets', cabinet1Items)
    exports['qs-housing']:AddFurniture('kitchenetteleft', cabinet1Items)
    exports['qs-housing']:AddFurniture('kitchenetteright', cabinet1Items)
    exports['qs-housing']:AddFurniture('bedsidetable', cabinet1Items)

    -- Cabinet 2
    local cabinet2Items = {
        ['img'] = 'https://i.ibb.co/86kxgdH/gcom-dec-pack-cabinet-2.webp',
        ['object'] = 'gcom_dec_pack_cabinet_2',
        ['price'] = 150,
        ['label'] = 'GCOM cabinet Small',
        ['description'] = 'A luxurious and very detailed cabinet, really good, but very small!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('bedsidetable', cabinet2Items)

    -- Bathcab
    local bathcabItems = {
        ['img'] = 'httpsi.ibb.co86kxgdHgcom-dec-pack-cabinet-2.webp',
        ['object'] = 'gcom_dec_pack_bathcab',
        ['price'] = 150,
        ['label'] = 'GCOM bathcab',
        ['description'] = 'Beautiful floating shelf, very small and delicate, like a flower',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('bedsidetable', bathcabItems)

    -- Table 1
    local table1Items = {
        ['img'] = 'https://i.ibb.co/pQGYJXd/gcom-dec-pack-table-1.webp',
        ['object'] = 'gcom_dec_pack_table_1',
        ['price'] = 150,
        ['label'] = 'GCOM table Single',
        ['description'] = 'Modern table, minimalist style with white and brown details',
        ['colorlabel'] = 'Brown',
        ['colors'] = {}
    }
    exports['qs-housing']:AddFurniture('table', table1Items)
    exports['qs-housing']:AddFurniture('pc-table', table1Items)
    exports['qs-housing']:AddFurniture('couchtable', table1Items)

    -- Table 2
    local table2Items = {
        ['img'] = 'https://i.ibb.co/DMnVMHP/gcom-dec-pack-table-2.webp',
        ['object'] = 'gcom_dec_pack_table_2',
        ['price'] = 150,
        ['label'] = 'GCOM crystal table',
        ['description'] = 'Huge glass table, with high quality brown details',
        ['colorlabel'] = 'Brown',
        ['colors'] = {}
    }
    exports['qs-housing']:AddFurniture('table', table2Items)
    exports['qs-housing']:AddFurniture('pc-table', table2Items)
    exports['qs-housing']:AddFurniture('couchtable', table2Items)

    -- Wardrobe 1
    local wardrobe1Items = {
        ['img'] = 'https://i.ibb.co/hsFvs3p/gcom-dec-pack-wall.webp',
        ['object'] = 'gcom_dec_pack_wall',
        ['price'] = 150,
        ['label'] = 'GCOM wall wardrobe',
        ['description'] = 'Giant shelf where you can store everything except clothes!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', wardrobe1Items)

    -- Wardrobe 2
    local wardrobe2Items = {
        ['img'] = 'https://i.ibb.co/gwK69Wm/gcom-dec-pack-wardrobe-1.webp',
        ['object'] = 'gcom_dec_pack_wardrobe_1',
        ['price'] = 450,
        ['label'] = 'GCOM clear wardrobe',
        ['description'] = 'Set of beautiful shelves with glass and rhinestones',
        ['colorlabel'] = 'Big',
        ['colors'] = {
            {
                label = 'Small',
                object = 'gcom_dec_pack_wardrobe_2',
                price = 320,
                type = 'gardrobe',
                offset = { x = 0.0, y = 0.0, z = 0.0 }
            },
        },
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', wardrobe2Items)

    -- Wardrobe mumrm
    local murmCabinetItems = {
        ['img'] = 'https://i.ibb.co/10myYTG/murm-dec-pack-cabinet.webp',
        ['object'] = 'murm_dec_pack_cabinet',
        ['price'] = 550,
        ['label'] = 'MURM wardrobe',
        ['description'] = 'Outsizedly beautiful wardrobe!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', murmCabinetItems)

    -- Chair mumrm 1
    local chair1tItems = {
        ['img'] = 'https://i.ibb.co/QkfRt8c/murm-dec-pack-chair-1.webp',
        ['object'] = 'murm_dec_pack_chair_1',
        ['price'] = 90,
        ['label'] = 'MURM single chair',
        ['description'] = 'Simple and minimalist chair with beautiful brown details',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('chair', chair1tItems)

    -- Dresset mumrm
    local dressertItems = {
        ['img'] = 'https://i.ibb.co/pRB9cCn/10.webp',
        ['object'] = 'murm_dec_pack_dresser',
        ['price'] = 220,
        ['label'] = 'MURM dresser',
        ['description'] = 'A super antique dresser made of painted and varnished pine wood',
        ['colorlabel'] = 'Black',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('bedsidetable', dressertItems)

    -- Sofa mumrm
    local sofaMItems = {
        ['img'] = 'https://i.ibb.co/y4s3WRv/murm-dec-pack-sofa.webp',
        ['object'] = 'murm_dec_pack_sofa',
        ['price'] = 350,
        ['label'] = 'MURM sofa',
        ['description'] = 'A large beautiful sofa, I dear Murm!',
        ['colorlabel'] = 'Black',
        ['colors'] = {}
    }
    exports['qs-housing']:AddFurniture('sofa', sofaMItems)
    exports['qs-housing']:AddFurniture('couch', sofaMItems)

    print('The dlc [murm_dec_pack] was completely imported, these furniture are a reality thanks to the collaboration with https://es.gta5-mods.com/users/DaMax_xY')
end)
