CreateThread(function()
    Wait(1500)
    -- Bed 1
    local bed1Items = {
        ['img'] = 'https://i.ibb.co/LZ4C4nn/ls-quasar-bed1-a.webp',
        ['object'] = 'ls_quasar_bed1_a',
        ['price'] = 1230,
        ['label'] = 'Lunatic bed',
        ['description'] = 'Luxury beds with fabric backrests, thanks to Lunatic Studios for such a bed!',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'White',
                object = 'ls_quasar_bed1_a',
                price = 1230,
            },
            {
                label = 'Black and gray',
                object = 'ls_quasar_bed1_c',
                price = 1230,
            },
            {
                label = 'Black and white',
                object = 'ls_quasar_bed1_d',
                price = 1230,
            },
            {
                label = 'Green and white',
                object = 'ls_quasar_bed1_e',
                price = 1230,
            },
            {
                label = 'Red and white',
                object = 'ls_quasar_bed1_f',
                price = 1230,
            },
            {
                label = 'Blue and white',
                object = 'ls_quasar_bed1_g',
                price = 1230,
            },
            {
                label = 'Gray and white',
                object = 'ls_quasar_bed1_h',
                price = 1230,
            },
        },
    }
    exports['qs-housing']:AddFurniture('bed', bed1Items)

    -- Bed 2
    local bed2Items = {
        ['img'] = 'https://i.ibb.co/tKZFWfr/ls-quasar-bed2-a.webp',
        ['object'] = 'ls_quasar_bed2_a',
        ['price'] = 1230,
        ['label'] = 'Lunatic bed Colored',
        ['description'] = 'Luxury beds with fabric backrests, thanks to Lunatic Studios for such a bed and colored!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {
            {
                label = 'Green',
                object = 'ls_quasar_bed2_a',
                price = 1230,
            },
            {
                label = 'Red',
                object = 'ls_quasar_bed2_c',
                price = 1230,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_bed2_d',
                price = 1230,
            },
            {
                label = 'Blue',
                object = 'ls_quasar_bed2_e',
                price = 1230,
            },
            {
                label = 'White',
                object = 'ls_quasar_bed2_f',
                price = 1230,
            },
            {
                label = 'Gray',
                object = 'ls_quasar_bed2_g',
                price = 1230,
            },
            {
                label = 'Dark green',
                object = 'ls_quasar_bed2_h',
                price = 1230,
            },
        },
    }
    exports['qs-housing']:AddFurniture('bed', bed2Items)

    -- Bookshelf
    local bookshelfItems = {
        ['img'] = 'https://i.ibb.co/HXyQtT9/ls-quasar-book1-a.webp',
        ['object'] = 'ls_quasar_book1_a',
        ['price'] = 250,
        ['label'] = 'Lunatic Bookshelf',
        ['description'] = 'The best furniture for the bed from Lunatic Studios',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'Blue',
                object = 'ls_quasar_book1_b',
                price = 250,
            },
            {
                label = 'White',
                object = 'ls_quasar_book1_c',
                price = 250,
            },
            {
                label = 'Gray',
                object = 'ls_quasar_book1_d',
                price = 250,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_book1_e',
                price = 250,
            },
            {
                label = 'Brown',
                object = 'ls_quasar_book1_f',
                price = 250,
            },
            {
                label = 'Dark green',
                object = 'ls_quasar_book1_g',
                price = 250,
            },
            {
                label = 'Light green',
                object = 'ls_quasar_book1_h',
                price = 250,
            },
        },
    }
    exports['qs-housing']:AddFurniture('bedsidetable', bookshelfItems)

    -- Caffee table
    local caffeeItems = {
        ['img'] = 'https://i.ibb.co/6Jk80qC/ls-quasar-ctal1-a.webp',
        ['object'] = 'ls_quasar_ctal1_a',
        ['price'] = 410,
        ['label'] = 'Lunatic coffee table',
        ['description'] = 'Elegant coffee tables from the Lunatic Studios winter collection',
        ['colorlabel'] = 'Gray',
        ['colors'] = {
            {
                label = 'Dark green',
                object = 'ls_quasar_ctal1_b',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Green',
                object = 'ls_quasar_ctal1_c',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ls_quasar_ctal1_d',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Red',
                object = 'ls_quasar_ctal1_e',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Black',
                object = 'ls_quasar_ctal1_f',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'White',
                object = 'ls_quasar_ctal1_g',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Blue',
                object = 'ls_quasar_ctal1_h',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('table', caffeeItems)
    exports['qs-housing']:AddFurniture('pc-table', caffeeItems)
    exports['qs-housing']:AddFurniture('couchtable', caffeeItems)

    -- End table
    local caffeeItems = {
        ['img'] = 'https://i.ibb.co/k47TLjs/ls-quasar-endt1-a.webp',
        ['object'] = 'ls_quasar_endt1_a',
        ['price'] = 360,
        ['label'] = 'Lunatic end table',
        ['description'] = 'Elegant and small table, ready to use as an end table, thanks to Lunatic Store',
        ['colorlabel'] = 'Dark green',
        ['colors'] = {
            {
                label = 'Gray',
                object = 'ls_quasar_endt1_b',
                price = 360,
            },
            {
                label = 'Green',
                object = 'ls_quasar_endt1_c',
                price = 360,
            },
            {
                label = 'Blue',
                object = 'ls_quasar_endt1_d',
                price = 360,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_endt1_e',
                price = 360,
            },
            {
                label = 'Black',
                object = 'ls_quasar_endt1_f',
                price = 360,
            },
            {
                label = 'Red',
                object = 'ls_quasar_endt1_g',
                price = 360,
            },
            {
                label = 'Brown',
                object = 'ls_quasar_endt1_h',
                price = 360,
            },
        },
    }
    exports['qs-housing']:AddFurniture('table', caffeeItems)
    exports['qs-housing']:AddFurniture('pc-table', caffeeItems)
    exports['qs-housing']:AddFurniture('couchtable', caffeeItems)

    -- Seat left
    local seatLeftItems = {
        ['img'] = 'https://i.ibb.co/rMmfyf9/ls-quasar-lsea1-a.webp',
        ['object'] = 'ls_quasar_lsea1_a',
        ['price'] = 290,
        ['label'] = 'Lunatic love seat left',
        ['description'] = 'Lunatic Studios brings us here a sofa with left direction and drawers, beautiful design',
        ['colorlabel'] = 'Skin',
        ['colors'] = {
            {
                label = 'Black',
                object = 'ls_quasar_lsea1_b',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Gray',
                object = 'ls_quasar_lsea1_c',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ls_quasar_lsea1_d',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'White',
                object = 'ls_quasar_lsea1_e',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Green',
                object = 'ls_quasar_lsea1_f',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Blue',
                object = 'ls_quasar_lsea1_g',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Red',
                object = 'ls_quasar_lsea1_h',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('sofa', seatLeftItems)
    exports['qs-housing']:AddFurniture('couch', seatLeftItems)

    -- Seat right
    local seatRightItems = {
        ['img'] = 'https://i.ibb.co/mtG0Cgx/ls-quasar-lsea2-a.webp',
        ['object'] = 'ls_quasar_lsea2_a',
        ['price'] = 290,
        ['label'] = 'Lunatic love seat right',
        ['description'] = 'Lunatic Studios brings us here a sofa with right direction and drawers, beautiful design',
        ['colorlabel'] = 'White',
        ['colors'] = {
            {
                label = 'Green',
                object = 'ls_quasar_lsea2_b',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Blue',
                object = 'ls_quasar_lsea2_c',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Gray',
                object = 'ls_quasar_lsea2_d',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ls_quasar_lsea2_e',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Skin',
                object = 'ls_quasar_lsea2_f',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Black',
                object = 'ls_quasar_lsea2_g',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Dark green',
                object = 'ls_quasar_lsea2_h',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('sofa', seatRightItems)
    exports['qs-housing']:AddFurniture('couch', seatRightItems)

    -- End table
    local stereoItems = {
        ['img'] = 'https://i.ibb.co/CH3fgFW/ls-quasar-ster1-a.webp',
        ['object'] = 'ls_quasar_ster1_a',
        ['price'] = 360,
        ['label'] = 'Lunatic stereo',
        ['description'] = 'Musical stereos that are included with a phone similar to a Smartphone, but created by Lunatic Studios',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'Brown',
                object = 'ls_quasar_ster1_b',
                price = 360,
            },
            {
                label = 'White',
                object = 'ls_quasar_ster1_c',
                price = 360,
            },
            {
                label = 'Green',
                object = 'ls_quasar_ster1_d',
                price = 360,
            },
            {
                label = 'Blue',
                object = 'ls_quasar_ster1_e',
                price = 360,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_ster1_f',
                price = 360,
            },
            {
                label = 'Gray',
                object = 'ls_quasar_ster1_g',
                price = 360,
            },
            {
                label = 'Red',
                object = 'ls_quasar_ster1_h',
                price = 360,
            },
        },
    }
    exports['qs-housing']:AddFurniture('laptop', stereoItems)

    print('The dlc [lunaticstudio_promo001] was completely imported, these furniture are a reality thanks to the collaboration with https://lunaticstudio.tebex.io')
end)
