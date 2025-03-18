return {
    releasePos = vec4(3865.425537, -26.172321, 6.706453, 183.0),
    outfitMenu = vec4(3859.153, -10.287, 6.708, 275.0),
    prisonYard = vec4(3952.893555, 45.012665, 22.341509, 0.0),
    outfitCameraOffset = vector3(3.5, -0.5, 0.0),

    cameraProlog = {
        initCameraPosition = vec3(3925.097656, -64.713615, 10.491981),
        initCameraRot = vector3(-2.981497, 0.06393559, 41.631992340088),
        initGameplayCamRot = vec3(-10.6386, -0, 41.631992340088),
        points = {
            {
                pos = vec3(3827.336670, -82.593094, 39.329884),
                rot = vector3(-5.106454, 0.06342217, 39.0),
                duration = 6000,
                text = _U('CAMERA_PROLOG.WELCOME_TO_ALCATRAZ'),
                textTimeout = 1500,
                textRenderTime = 5500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3797.043213, 35.610138, 36.373840),
                rot = vector3(-5.106454, 0.06342217, 252.24160766602),
                duration = 6000,
                text = '',
                textTimeout = 1500,
                textRenderTime = 5500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3993.007813, 54.730854, 31.231415),
                rot = vector3(-5.106454, 0.06342217, 122.24160766602),
                duration = 10000,
                text = _U('CAMERA_PROLOG.BASKETBALL_PLACE'),
                textTimeout = 7500,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3987.071777, 31.392529, 31.992109),
                rot = vector3(-5.106454, 0.06342217, 31.992109),
                duration = 8000,
                text = '',
                textTimeout = 1500,
                textRenderTime = 5500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3948.890381, 44.574039, 22.342033),
                rot = vector3(-5.106454, 0.06342217, 338.02429199219),
                duration = 10000,
                text = _U('CAMERA_PROLOG.GYM_PLACE'),
                textTimeout = 6500,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                   -- this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3957.969238, 36.522171, 23.875549),
                rot = vector3(-5.106454, 0.06342217, 139.50),
                duration = 10000,
                text = _U('CAMERA_PROLOG.JOB_PLACE'),
                textTimeout = 7000,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            
            {
                pos = vec3(3943.223389, 35.831207, 23.875374),
                rot = vector3(-5.106454, 0.06342217, 84),
                duration = 6000,
                text = _U('CAMERA_PROLOG.ALCATRAZ_PEAK_INSIDE'),
                textTimeout = 9000 / 2,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vec3(3924.452881, 37.428947, 23.914814),
                rot = vector3(-5.106454, 0.06342217, 174.24160766602),
                duration = 6000,
                text = '',
                textTimeout = 9000 / 2,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3922.576416, 21.641352, 24.357059),
                rot = vector3(-5.106454, 0.06342217, 346.24160766602),
                duration = 7000,
                text = _U('CAMERA_PROLOG.CANTEEN_PLACE'),
                textTimeout = 4000,
                textRenderTime = 4000,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    offsetDuration = 1500,
                }
            },
            {
                pos = vec3(3922.744629, 24.455950, 23.887993),
                rot = vector3(-5.106454, 0.06342217, 84.24160766602),
                duration = 6000,
                text = '',
                textTimeout = 9000 / 2,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vec3(3916.605225, 25.088234, 23.888031),
                rot = vector3(-5.106454, 0.06342217, 210.24160766602),
                duration = 6000,
                text = '',
                textTimeout = 9000 / 2,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
        },
    },

    
    prisonVertices = {
        vec3(3891.061, -28.325, 8.399),
        vec3(3948.358, -29.539, 15.696),
        vec3(4066.693, -23.641, 11.853),
        vec3(4108.456, 23.347, 19.888),
        vec3(4096.523, 77.741, 24.481),
        vec3(3943.540, 87.993, 18.023),
        vec3(3806.903, 85.461, 18.562),
        vec3(3762.878, 33.476, 10.818),
        vec3(3767.667, 2.973, 10.761),
        vec3(3811.021, -23.748, 8.355),
        vec3(3884.529, -30.838, 8.066),
    },


    YardPosPool = {
        {pos = vec4(3968.723, 52.369, 22.341, 356.458)},
        {pos = vec4(3944.785, 51.411, 22.568, 234.235)},
    },

    BasketBallHoops = {
        {
            pos = vector3(3988.960938, 42.285355, 20.766180), 
            rot = vector4(-0.000000, 0.000000, 0.721432, -0.692485),
            State = nil,
            Model = `prop_basketball_net`,
            IsSubscribed = false,
            threePointFwdDist = 0.0,
            threePointSideDist = 0.0,
            threePointRadius = 30.0,
            hideBlip = true,
        },
        {
            pos = vector3(3970.222412, 43.859642, 20.724367), 
            rot = vector4(0.000000, 0.000000, 0.676176, 0.736740),
            State = nil,
            Model = `prop_basketball_net`,
            IsSubscribed = false,
            threePointFwdDist = 0.0,
            threePointSideDist = 0.0,
            threePointRadius = 30.0,
            hideBlip = true,
        },
    },

    SolitaryCells = {
        {
            coords = vec3(4050.124, -1.795, 18.787),
            heading = 88.502,
        },
        {
            coords = vec3(4047.801, -8.573, 18.787),
            heading = 84.778,
        },
        {
            coords = vec3(4039.408, -2.061, 18.787),
            heading = 268.936,
        },
        {
            coords = vec3(4041.885, -8.789, 18.787),
            heading = 268.936,
        },
    },

    
    RestrictCommandZones = {
        {
            access = Config.RestrictZones.Access,
            name = 'PRISON_RELEASE_PLAYER_POSITION',
            vertices = {
                vector3(3870.51, -19.45, 6.71),
                vector3(3860.61, -20.25, 6.71),
                vector3(3861.77, -34.5, 6.71),
                vector3(3871.53, -34.88, 6.71),
            }
        }
    },

    Chairs = {
        [`molo_props_prisontable`] = {
            model = 'molo_props_prisontable',
            debug = true,
            type = 'nobed',
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
            },
            positions = {
                { offset = vec3(1.0, 0.05, 0.1) },
                { offset = vec3(-0.1, -0.90, 0.1) },
                { offset = vec3(0.0, 1.05, 0.1) },
                { offset = vec3(-1.0, 0.05, 0.1) },
            }
        },


        [`prop_bench_02`] = {
            model = 'prop_bench_02',
            debug = true,
            type = 'nobed',
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
            },
            positions = {
                { offset = vec3(-1.1, 0.0, 0.5) },
                { offset = vec3(0.0, 0.0, 0.5) },
                { offset = vec3(0.9, 0.0, 0.5) },
            }
        },

        [`prop_rub_matress_04`] = {
            model = 'prop_rub_matress_04',
            debug = true,
            type = 'bed',
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
                lay = {
                    dict = "timetable@tracy@sleep@",
                    name = "idle_c"
                },
            },
            positions = {
                { offset = vec3(0.0, 0.0, 0.5) },
                { offset = vec3(0.0, 0.0, -0.8) },
            }
        },

       
        [`brofx_hei_heist_beds03`] = {
            model = 'brofx_hei_heist_beds03',
            debug = true,
            type = 'bed',
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
                lay = {
                    dict = "timetable@tracy@sleep@",
                    name = "idle_c"
                },
            },
            positions = {
                { offset = vec3(-1.0, -0.35, 0.15) },
                { offset = vec3(-0.0, -0.35, 0.15) },
                { offset = vec3(1.0, -0.35, 0.15) },
            }
        },

        [`prop_picnictable_02`] = {
            model = 'prop_picnictable_02',
            type = 'back',
            debug = true,
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
                lay = {
                    dict = "timetable@tracy@sleep@",
                    name = "idle_c"
                },
            },
            positions = {
                { offset = vec3(0.0, 0.5, 0.5) },
                { offset = vec3(0.0, -0.5, 0.5) },
            }
        },

        [`brofx_hei_heist_bench03`] = {
            model = 'brofx_hei_heist_bench03',
            debug = true,
            type = 'noback',
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
                lay = {
                    dict = "timetable@tracy@sleep@",
                    name = "idle_c"
                },
            },
            positions = {
                { offset = vec3(-0.0, 0.2, 0.2) },
            }
        },


        [`prop_bleachers_04`] = {
            model = 'prop_bleachers_04',
            debug = true,
            type = 'noback',
            anim = {
                scenario = {
                    name = "PROP_HUMAN_SEAT_BENCH"
                },
                lay = {
                    dict = "timetable@tracy@sleep@",
                    name = "idle_c"
                },
            },
            positions = {
                { offset = vec3(1.75, -1.0, 0.45) },
                { offset = vec3(0.7, -1.0, 0.45) },
                { offset = vec3(-0.7, -1.0, 0.45) },
                { offset = vec3(-1.85, -1.0, 0.45) },
            }
        },
    },

    jobs = {
        {
            name = _U('JOB.ELECTRICIAN_TITLE'),
            type = JOBS.ELECTRICIAN,
            description = _U('JOB.ELECTRICIAN_DESCRIPTION'),
            points = {
                {pos = vec4(3944.306, 50.921, 22.342, 0)},
                {pos = vec4(3966.699, 53.239, 22.342, 0)},
                {pos = vec4(3968.275, 31.438, 22.341, 0)},
                {pos = vec4(3988.880, 29.084, 22.341, 0)},
            }
        },
        {
            name = _U('JOB.JANITOR_TITLE'),
            type = JOBS.JANITOR,
            description = _U('JOB.JANITOR_DESCRIPTION'),
            points = {
                {pos = vec4(3963.174, 32.523, 22.435, 0)},
                {pos = vec4(3980.846, 35.556, 22.341, 0)},
                {pos = vec4(3988.558, 29.685, 22.341, 0)},
                {pos = vec4(3990.260, 51.440, 22.341, 0)},
                {pos = vec4(3974.473, 54.493, 22.341, 0)},
            } 
        }
    },
    

    interaction = {
        {
            coords = vec3(3943.753, 59.090, 22.342),
            type = INTERACT_TYPES.BOOTH,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-phone"
            },
            prop = {
                coords = vec3(3943.753, 59.090, 22.342),
                heading = 354.0,
                model = 'sf_prop_sf_phonebox_01b_s'
            },
            booth = {
                number = 1002,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(3921.065, 29.944, 23.887),
            type = INTERACT_TYPES.CANTEEN,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.CANTEEN_LABEL'),
                distance = 3
            },
            npc = {
                coords = vec3(3921.065, 29.944, 23.887),
                heading = 258.176,
                model = 's_m_m_armoured_01',
                scenario = {
                    name = 'WORLD_HUMAN_CLIPBOARD',
                    state = true,
                }
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.CANTEEN'),
                sprite = 214,
                scale = 0.5,
                color = 0,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(3966.127, 57.288, 22.341),
            type = INTERACT_TYPES.DEALER,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.DEALER_LABEL'),
                distance = 1.0
            },
            npc = {
                coords = vec3(3966.127, 57.288, 22.341),
                heading = 174.566,
                model = 's_m_y_prismuscl_01'
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.DEALER'),
                sprite = 155,
                scale = 1.0,
                color = 0,
            },
            items = {
                {
                    name = "WEAPON_KNIFE",
                    label = _U('ITEM_LABELS.KNIFE'),
                    price = 40,
                },
                {
                    name = "ecola",
                    price = 8,
                },
                {
                    name = "donut",
                    price = 5,
                },
                {
                    name = "wire_cutter",
                    label = _U('ITEM_LABELS.WIRE_CUTTER'),
                    price = 30,
                }
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(3957.068, 31.598, 23.875),
            type = INTERACT_TYPES.QUEST,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.WARDEN_LABEL')
            },
            npc = {
                coords = vec3(3957.068, 31.598, 23.875),
                heading = 352.0,
                model = 's_m_m_prisguard_01'
            },
            releasePlayerOption = true,
            quest = {
                name = _U('QUEST.WARDEN_NPC_NAME'),
                description = _U('QUEST.WARDEN_DESCRIPTION'),
                options = {
                    {
                        label = _U('QUEST.PRISON_ACCOUNT_LABEL'),
                        action = Actions.SHOW_ACCOUNT
                    },
                    {
                        label = _U('QUEST.JAIL_TIME_LABEL'),
                        action = Actions.SHOW_JAIL_TIME
                    },
                }
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.ACCOUNT'),
                sprite = 280,
                scale = 0.5,
                color = 0,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(3945.713, 34.242, 23.875),
            type = INTERACT_TYPES.JOBS,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            npc = {
                coords = vec3(3945.713, 34.242, 23.875),
                heading = 355.141,
                model = 's_m_m_prisguard_01'
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.LOBBY'),
                sprite = 402,
                scale = 0.5,
                color = 0,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(3941.480, 48.315, 22.342),
            type = INTERACT_TYPES.CIGAR_PRODUCTION,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            prop = {
                coords = vec3(3941.480, 48.315, 22.7),
                heading = 208.844,
                model = 'prop_table_01'
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.CIGAR'),
                sprite = 214,
                scale = 0.5,
                color = 0,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(3865.852, -18.466, 6.713),
            type = INTERACT_TYPES.LOBBY,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            npc = {
                coords = vec3(3865.852, -18.466, 6.713),
                heading = 180.929,
                model = 's_m_m_prisguard_01'
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.LOBBY'),
                sprite = 280,
                scale = 0.5,
                color = 0,
            },
            access = INTERACT_ACCESS_TYPES.ALL
        },
        {
            coords = vec3(3864.48, -41.71, 6.71),
            type = INTERACT_TYPES.TELEPORT,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            npc = {
                coords = vec3(3864.48, -41.71, 6.71),
                heading = 358.0,
                model = 'a_m_m_bevhills_02'
            },
            access = INTERACT_ACCESS_TYPES.ALL
        },
    }
}
