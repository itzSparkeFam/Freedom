return {
    ----------------------------------------------
    --          ⌨️ Customize controls
    ----------------------------------------------

    -- Prop placement controls
    controls = {
        -- How fast the prop placement system moves the object
        speed = 0.025,
        -- Rotate left
        rotateL = 44, -- Q
        -- Rotate right
        rotateR = 38, -- E
        -- Move forward
        forward = 32, -- W
        -- Move backward
        backward = 33, -- S
        -- Move left
        left = 34, -- A
        -- Move right
        right = 35, -- D
        -- Cancel placement
        cancel = 73, -- X
        -- Confirm placement
        confirm = 22, -- Space

        -- The keys below will be disabled during placement
        disable = {
            30, -- Disables left/right movement
            31, -- Disables forward/backward movement
            44, -- Disables Q (crouch)
            22, -- Disables Spacebar (jump)
            200, -- Disables Escape
            -- Add more here if needed
        },
    },

    ----------------------------------------------
    --    📹 Customize lab security cameras
    ----------------------------------------------

    cameras = {
        -- The speed at which the camera will pan & zoom
        -- Increase this number to move faster, decrease to move slower
        speed = 0.15,
        -- When a player views their warehouse's security camera, this is the timecycle
        -- Modifier that is used - update it below if you wish for a different effect!
        -- More timecycle mods: https://forge.plebmasters.de/timecyclemods
        timecycle = 'scanline_cam_cheap',
        -- If you would like to or need to configure the keys used for camera viewing
        -- You can do it here
        -- control IDs: https://docs.fivem.net/docs/game-references/controls/)
        controls = {
            panUp = 32, -- W
            panDown = 33, -- S
            panLeft = 34, -- A
            panRight = 35, -- D
            zoomIn = 44, -- Q
            zoomOut = 38, -- E
            exit = 177 -- Backspace
        },
        -- While a player is inside the camera viewing mode, these are the controls that
        -- Get disabled until they have exited (control IDs: https://docs.fivem.net/docs/game-references/controls/)
        -- Default controls disabled: W, A, S, D, Q, E, B, movement left/right, movement up/down
        disable = { 32, 33, 34, 35, 44, 38, 29, 30, 31 },
        -- The limits section below is the limiting factors to determine max camera pan & zoom
        limits = {
            -- Pitch limits (up/down) relative to initial rotation
            pitch = 30.0,
            -- Yaw limits (left/right) relative to initial rotation
            yaw = 45.0,
            -- FOV limits (lower value = more zoomed in, higher value = more zoomed out)
            -- To allow further "zoom in", set min to a lower value
            -- To allow further "zoom out", set max to a higher value
            fov = { min = 35.0, max = 80.0 }
        }
    },

    ----------------------------------------------
    --       📊 Customize stats menu
    ----------------------------------------------

    -- Don't want to show the stats menu option at all?
    -- Set all stats below to false!
    stats = {
        -- Do you want to show the leaves harvested stat?
        leaves = true,
        -- Do you want to show the total plants grown stat?
        grown = true,
        -- Do you want to show the total cement collected stat?
        cement = true,
        -- Do you want to show the total bricks produced stat?
        bricks = true,
    },

    ----------------------------------------------
    --    💃 Customize animations and props
    ----------------------------------------------

    animations = {
        searching = {
            label = 'Searching..',
            duration = 6000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'amb@prop_human_bum_bin@base', clip = 'base' },
            prop = { }
        },
        use_table = {
            label = 'Placing table..',
            duration = 1500,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 0 },
            prop = {}
        },
        -- The animations below are for table cooking specifically
        -- Ensure the step number from config/shared.lua matches the number here!
        table = {
            [1] = {
                label = 'Processing leaves..',
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [2] = {
                label = 'Adding gasoline..',
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [3] = {
                label = 'Adding cement..',
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [4] = {
                label = 'Placing down..',
                duration = 1500,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim_casino_b@amb@casino@games@blackjack@dealer', clip = 'check_and_turn_card', flag = 0 },
                prop = {}
            },
            [5] = {
                label = 'Packaging..',
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
        },
        -- The animations below are for lab station cooking specifically
        -- Ensure the step number from config/shared.lua matches the number here!
        lab = {
            [1] = {
                label = 'Processing leaves..',
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [2] = {
                label = 'Adding gasoline..',
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [3] = {
                label = 'Adding cement..',
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [4] = {
                label = 'Placing down..',
                duration = 1500,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim_casino_b@amb@casino@games@blackjack@dealer', clip = 'check_and_turn_card', flag = 0 },
                prop = {}
            },
            [5] = {
                label = 'Placing down..',
                duration = 1500,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim_casino_b@amb@casino@games@blackjack@dealer', clip = 'check_and_turn_card', flag = 0 },
                prop = {}
            },
            [6] = {
                label = 'Cutting..',
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
            [7] = {
                label = 'Packaging..',
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v4_cokecutter', flag = 0 },
                prop = {}
            },
        },
        pickup_table = {
            label = 'Picking up table..',
            duration = 1500,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 0 },
            prop = {}
        },
        place_seed = {
            label = 'Placing seed..',
            duration = 1200,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'pickup_object', clip = 'pickup_low' },
            prop = { }
        },
        watering = {
            part1 = {
                label = 'Watering..',
                duration = 4000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'weapon@w_sp_jerrycan', clip = 'fire', flag = 1 },
                prop = { }
            },
            part2 = {
                prop = { model = 'prop_wateringcan', bone = 28422, pos = vec3(0.4, 0.125, -0.05), rot = vec3(90.0, 180.0, 0.0) },
                fx = { dict = 'core', name = 'ent_sht_water', offset = vec3(0.35, 0.0, 0.25), rot = vec3(0.0, 0.0, 0.0), scale = 2.0 }
            }
        },
        fertilizing = {
            part1 = {
                label = 'Fertilizing..',
                duration = 4000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'weapon@w_sp_jerrycan', clip = 'fire', flag = 1 },
                prop = { }
            },
            part2 = {
                prop = { model = 'p_cs_sack_01_s', bone = 28422, pos = vec3(0.3239, -0.0328, 0.1253), rot = vec3(49.4678, -18.1732, -79.2577) },
                fx = { dict = 'scr_fbi3', name = 'scr_fbi3_dirty_water_pour', offset = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0), scale = 2.0 }
            }
        },
        harvesting = {
            label = 'Harvesting..',
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'amb@prop_human_bum_bin@base', clip = 'base' },
            prop = { }
        },
        destroy_plant = {
            label = 'Destroying..',
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'amb@prop_human_bum_bin@base', clip = 'base' },
            prop = { }
        },
        take_cement = {
            label = 'Taking cement..',
            duration = 750,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'anim@scripted@heist@ig1_table_grab@gold@male@', clip = 'grab' },
            prop = { }
        },
        manage_lab = {
            dict = 'anim@scripted@player@mission@tunf_bunk_ig3_nas_upload@',
            clip = 'normal_typing',
            flag = 51
        },
        raid_entry = {
            dict = 'missheistfbisetup1',
            clip = 'hassle_intro_loop_f',
            flag = 51
        },
        raid_stash = {
            dict = 'missheistfbisetup1',
            clip = 'hassle_intro_loop_f',
            flag = 51
        },
        use_drug = {
            label = 'Snorting..',
            duration = 4500,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'anim@amb@nightclub@peds@', clip = 'missfbi3_party_snort_coke_b_male3' },
            prop = {}
        },
        busy = { -- Used when interacting with table, plants and other misc actions
           dict = 'missheist_jewelleadinout',
           clip = 'jh_int_outro_loop_a',
           flag = 51
        },
    },

}