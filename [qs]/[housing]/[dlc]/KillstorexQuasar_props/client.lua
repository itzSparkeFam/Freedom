CreateThread(function()
    Wait(1500)
    -- Shelf
    local shelfItems = {
        ['img'] = 'https://i.ibb.co/wJ9YgmB/ks-anime-shelf01.webp',
        ['object'] = 'ks_anime_shelf01',
        ['price'] = 450,
        ['label'] = 'Anime shelf',
        ['description'] = 'The most modern gaming shelves on the market, thanks to Killstore for their incredible furniture and dolls!',
        ['colorlabel'] = 'White',
        ['colors'] = {
            {
                label = 'Black',
                object = 'ks_anime_shelf02',
                price = 450,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Gray',
                object = 'ks_anime_shelf03',
                price = 450,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Pink',
                object = 'ks_anime_shelf04',
                price = 450,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ks_anime_shelf05',
                price = 450,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', shelfItems)

    -- Chair
    local chairItems = {
        ['img'] = 'https://i.ibb.co/rM5qqvx/ks-gaming-chair01.webp',
        ['object'] = 'ks_gaming_chair01',
        ['price'] = 800,
        ['label'] = 'Gaming Chair',
        ['description'] = 'Killstore brand gamer chairs, the best on the Los Santos gaming market',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'White',
                object = 'ks_gaming_chair02',
                price = 800,
            },
            {
                label = 'Pink',
                object = 'ks_gaming_chair03',
                price = 800,
            },
            {
                label = 'Dark blue',
                object = 'ks_gaming_chair04',
                price = 800,
            },
            {
                label = 'Dark yellow',
                object = 'ks_gaming_chair05',
                price = 800,
            },
            {
                label = 'Light blue',
                object = 'ks_gaming_chair06',
                price = 800,
            },
            {
                label = 'Turquoise',
                object = 'ks_gaming_chair07',
                price = 800,
            },
            {
                label = 'Dark pink',
                object = 'ks_gaming_chair08',
                price = 800,
            },
            {
                label = 'Dark red',
                object = 'ks_gaming_chair09',
                price = 800,
            },
            {
                label = 'Light pink',
                object = 'ks_gaming_chair10',
                price = 800,
            },
        },
    }
    exports['qs-housing']:AddFurniture('chair', chairItems)

    -- Deck
    local deckItems = {
        ['img'] = 'https://i.ibb.co/4pQWNBg/ks-anime-shelf01.webp',
        ['object'] = 'ks_gaming_desk01',
        ['price'] = 1200,
        ['label'] = 'Gaming Deck',
        ['description'] = 'The best gaming tables on the market from our partners Killstore',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'White',
                object = 'ks_gaming_desk02',
                price = 1200,
            },
            {
                label = 'White and pink',
                object = 'ks_gaming_desk03',
                price = 1200,
            },
            {
                label = 'Black and blue',
                object = 'ks_gaming_desk04',
                price = 1200,
            },
            {
                label = 'Black and yellow',
                object = 'ks_gaming_desk05',
                price = 1200,
            },
            {
                label = 'White RGB',
                object = 'ks_gaming_desk06',
                price = 1200,
            },
            {
                label = 'Black RGB',
                object = 'ks_gaming_desk07',
                price = 1200,
            },
            {
                label = 'Black and red',
                object = 'ks_gaming_desk8',
                price = 1200,
            },
        },
    }
    exports['qs-housing']:AddFurniture('table', deckItems)
    exports['qs-housing']:AddFurniture('pc-table', deckItems)
    exports['qs-housing']:AddFurniture('couchtable', deckItems)

    -- Panels
    local panelsItems = {
        ['img'] = 'https://i.ibb.co/f18F1H9/ks-gaming-chair01.webp',
        ['object'] = 'ks_gaming_panels01',
        ['price'] = 250,
        ['label'] = 'Gaming Panels',
        ['description'] = 'Radiant panels with stunning colors and even RGB, Killstore brand, the best Gaming brand in all of FiveM!',
        ['colorlabel'] = 'Light pink',
        ['colors'] = {
            {
                label = 'Pink',
                object = 'ks_gaming_panels02',
                price = 250,
            },
            {
                label = 'Purple',
                object = 'ks_gaming_panels03',
                price = 250,
            },
            {
                label = 'Radiant pink',
                object = 'ks_gaming_panels04',
                price = 250,
            },
            {
                label = 'White',
                object = 'ks_gaming_panels05',
                price = 250,
            },
            {
                label = 'Green',
                object = 'ks_gaming_panels06',
                price = 250,
            },
            {
                label = 'Orange',
                object = 'ks_gaming_panels07',
                price = 250,
            },
            {
                label = 'Yellow',
                object = 'ks_gaming_panels08',
                price = 250,
            },
            {
                label = 'RGB',
                object = 'ks_gaming_panels09',
                price = 350,
            },
        },
    }
    exports['qs-housing']:AddFurniture('painting', panelsItems)

    -- Bar
    local barsItems = {
        ['img'] = 'https://i.ibb.co/zZscvms/ks-modern-bar01.webp',
        ['object'] = 'ks_modern_bar01',
        ['price'] = 935,
        ['label'] = 'Modern bar',
        ['description'] = 'A modern designer bar, with an embedded bar, elegance from Killstore',
        ['colorlabel'] = 'Marble',
        ['colors'] = {
            {
                label = 'Wood',
                object = 'ks_modern_bar02',
                price = 935,
            },
            {
                label = 'White',
                object = 'ks_modern_bar03',
                price = 935,
            },
            {
                label = 'Gray rock',
                object = 'ks_modern_bar04',
                price = 935,
            },
            {
                label = 'White marble',
                object = 'ks_modern_bar05',
                price = 935,
            },
            {
                label = 'Light marble',
                object = 'ks_modern_bar06',
                price = 935,
            },
        },
    }
    exports['qs-housing']:AddFurniture('hangingcaninets', barsItems)
    exports['qs-housing']:AddFurniture('kitchenetteleft', barsItems)
    exports['qs-housing']:AddFurniture('kitchenetteright', barsItems)
    exports['qs-housing']:AddFurniture('bedsidetable', barsItems)

    -- Dresser
    local dresserItems = {
        ['img'] = 'https://i.ibb.co/xDyrsnL/ks-modern-dresser01.webp',
        ['object'] = 'ks_modern_dresser01',
        ['price'] = 350,
        ['label'] = 'Modern dresser',
        ['description'] = 'A modern and feminine dressing table that will make your room look like that of a princess, Killstore knows very well about furniture',
        ['colorlabel'] = 'Gray',
        ['colors'] = {
            {
                label = 'White',
                object = 'ks_modern_dresser02',
                price = 350,
            },
            {
                label = 'Dark gray',
                object = 'ks_modern_dresser03',
                price = 350,
            },
            {
                label = 'Brown',
                object = 'ks_modern_dresser04',
                price = 350,
            },
            {
                label = 'Light white',
                object = 'ks_modern_dresser05',
                price = 350,
            },
            {
                label = 'Black radiant',
                object = 'ks_modern_dresser06',
                price = 350,
            },
        },
    }
    exports['qs-housing']:AddFurniture('table', dresserItems)

    -- Fireplace
    local fireItems = {
        ['img'] = 'https://i.ibb.co/YWZ09Fz/ks-modern-fireplace01.webp',
        ['object'] = 'ks_modern_fireplace01',
        ['price'] = 760,
        ['label'] = 'Modern fireplace',
        ['description'] = 'Designer fireplace made by our great partners Killstore',
        ['colorlabel'] = 'Wood',
        ['colors'] = {
            {
                label = 'Light wood',
                object = 'ks_modern_fireplace02',
                price = 760,
            },
            {
                label = 'Marble',
                object = 'ks_modern_fireplace03',
                price = 760,
            },
        },
    }
    exports['qs-housing']:AddFurniture('cooker', fireItems)
    exports['qs-housing']:AddFurniture('oven', fireItems)

    -- Puff
    local pufsItems = {
        ['img'] = 'https://i.ibb.co/72gN1fN/ks-modern-puf01.webp',
        ['object'] = 'ks_modern_puf01',
        ['price'] = 150,
        ['label'] = 'Modern puf',
        ['description'] = 'Incredibly comfortable beanbag chairs, thanks Killstore, we love you',
        ['colorlabel'] = 'Light green',
        ['colors'] = {
            {
                label = 'Black and white',
                object = 'ks_modern_puf02',
                price = 150,
            },
            {
                label = 'Black',
                object = 'ks_modern_puf03',
                price = 150,
            },
            {
                label = 'Light brown',
                object = 'ks_modern_puf04',
                price = 150,
            },
            {
                label = 'White',
                object = 'ks_modern_puf05',
                price = 150,
            },
            {
                label = 'Dark gray',
                object = 'ks_modern_puf06',
                price = 150,
            },
        },
    }
    exports['qs-housing']:AddFurniture('chair', pufsItems)

    -- Wardrobe
    local wardrobeItems = {
        ['img'] = 'https://i.ibb.co/PC87R7c/ks-modern-wardrobe00.webp',
        ['object'] = 'ks_modern_wardrobe00',
        ['price'] = 750,
        ['label'] = 'Modern wardrobe',
        ['description'] = 'Deluxe furniture with absurdly huge space for your clothes, Killstore knows what it\'s doing...',
        ['colorlabel'] = 'Gray',
        ['colors'] = {
            {
                label = 'Wood',
                object = 'ks_modern_wardrobe02',
                price = 750,
                type = 'gardrobe',
                offset = { x = 0.0, y = 0.0, z = 0.0 }
            },
            {
                label = 'Black',
                object = 'ks_modern_wardrobe03',
                price = 750,
                type = 'gardrobe',
                offset = { x = 0.0, y = 0.0, z = 0.0 }
            },
            {
                label = 'White',
                object = 'ks_modern_wardrobe04',
                price = 750,
                type = 'gardrobe',
                offset = { x = 0.0, y = 0.0, z = 0.0 }
            },
        },
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', wardrobeItems)

    -- Mirror
    local mirrorItems = {
        ['img'] = 'https://i.ibb.co/h7BvRSQ/ks-wave-mirror01.webp',
        ['object'] = 'ks_wave_mirror01',
        ['price'] = 750,
        ['label'] = 'Wave mirror',
        ['description'] = 'Beautiful mirrors for dressing tables, from Killstore',
        ['colorlabel'] = 'Light ocre',
        ['colors'] = {
            {
                label = 'Ocre',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'White ocre',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Pink',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Dark pink',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Pink skin',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'White',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Light green',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Green',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Light white',
                object = 'ks_wave_mirror01',
                price = 95,
            },
            {
                label = 'Gray',
                object = 'ks_wave_mirror01',
                price = 95,
            },
        },
    }
    exports['qs-housing']:AddFurniture('mirror', mirrorItems)

    print('The dlc [KillstorexQuasar_props] was completely imported, these furniture are a reality thanks to the collaboration with https://killstore.net')
end)
