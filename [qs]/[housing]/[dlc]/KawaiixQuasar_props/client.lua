CreateThread(function()
    Wait(1500)
    -- Chair
    local chairItems = {
        ['img'] = 'https://i.ibb.co/c2hTgNq/kawaiispace-gamingchair.webp',
        ['object'] = 'kawaiispace_gamingchair',
        ['price'] = 1290,
        ['label'] = 'Kawaii Gaming Chair',
        ['description'] = 'Gaming chair for Kawaii games station',
        ['colorlabel'] = 'Pink',
        ['colors'] = {
            {
                label = 'Black',
                object = 'kawaiispace_chairbw',
                price = 1290,
            },
            {
                label = 'Gray',
                object = 'kawaiispace_chairgre',
                price = 1290,
            },
            {
                label = 'Orange',
                object = 'kawaiispace_chairorange',
                price = 1290,
            },
            {
                label = 'Pink',
                object = 'kawaiispace_chairpink',
                price = 1290,
            },
            {
                label = 'Purple',
                object = 'kawaiispace_chairpurp',
                price = 1290,
            },
            {
                label = 'Blue',
                object = 'kawaiispace_chairblue',
                price = 1290,
            },
        },
    }
    exports['qs-housing']:AddFurniture('chair', chairItems)

    -- Station
    local stationItems = {
        ['img'] = 'https://i.ibb.co/TLjLKFb/kawaiispace-gamingstation.webp',
        ['object'] = 'kawaiispace_gamingstation',
        ['price'] = 2550,
        ['label'] = 'Kawaii Gaming Station',
        ['description'] = 'Games station for the Kawaii gaming chair',
        ['colorlabel'] = 'Pink',
        ['colors'] = {
            {
                label = 'Green',
                object = 'kawaiispace_stationgreen',
                price = 2550,
            },
            {
                label = 'Pink',
                object = 'kawaiispace_stationpink',
                price = 2550,
            },
            {
                label = 'Purple',
                object = 'kawaiispace_stationpurple',
                price = 2550,
            },
            {
                label = 'White',
                object = 'kawaiispace_stationwhite',
                price = 2550,
            },
        },
    }
    exports['qs-housing']:AddFurniture('chair', stationItems)

    -- Keyboard
    local keyboardItems = {
        ['img'] = 'https://i.ibb.co/6DqNXB6/kawaiispace-keyboard.webp',
        ['object'] = 'kawaiispace_keyboard',
        ['price'] = 300,
        ['label'] = 'Kawaii Gaming Keyboard',
        ['description'] = 'A complete keyboard and mouse for the Kawaii setup!',
        ['colorlabel'] = 'Pink',
        ['colors'] = {
            {
                label = 'Gray',
                object = 'kawaiispace_keyboardgre',
                price = 300,
            },
            {
                label = 'Orange',
                object = 'kawaiispace_keyboardorg',
                price = 300,
            },
            {
                label = 'Pink',
                object = 'kawaiispace_keyboardpink',
                price = 300,
            },
            {
                label = 'Purple',
                object = 'kawaiispace_keyboardpurp',
                price = 300,
            },
        },
    }
    exports['qs-housing']:AddFurniture('laptop', keyboardItems)

    print('The dlc [KillstorexQuasar_props] was completely imported, these furniture are a reality thanks to the collaboration with https://killstore.net')
end)
