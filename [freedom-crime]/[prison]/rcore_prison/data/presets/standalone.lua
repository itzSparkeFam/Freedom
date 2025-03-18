return {
    releasePos = vec4(1852.885, 2586.028, 45.671 - 1, 271.249),
    outfitMenu = vec4(402.704010, -996.795166, -99.000252, 180.0),
    prisonYard = vec4(1696.727, 2565.864, 45.564, 170),
    outfitCameraOffset = vector3(0.0, -8.0, 0.0),

    YardPosPool = {
        {pos = vec4(1775.348, 2550.491, 45.564, 88.863)},
        {pos = vec4(1775.259, 2553.737, 45.564, 88.912)},
        {pos = vec4(1715.949, 2525.946, 45.564, 203.378)},
        {pos = vec4(1705.124, 2521.298, 45.564, 114.265)},
    },

    BasketBallHoops = {
        {
            pos = vector3(1671.603149, 2502.791748, 44.557007), 
            rot = vector4(0.000000, 0.000000, 0.934286, 0.356523),
            State = nil,
            Model = `prop_basketball_net`,
            IsSubscribed = false,
            threePointFwdDist = 0.0,
            threePointSideDist = 0.0,
            threePointRadius = 30.0,
            hideBlip = true,
        },
        {
            pos = vector3(1689.082520, 2523.234863, 44.557262), 
            rot = vector4(0.000000, 0.000000, -0.318232, 0.948013),
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
            coords = vec3(1691.363, 2542.296, 45.632),
            heading = 268.936,
        },
        {
            coords = vec3(1691.179, 2545.784, 45.631),
            heading = 268.936,
        },
        {
            coords = vec3(1691.791, 2549.076, 45.631),
            heading = 268.936,
        },
        {
            coords = vec3(1692.100, 2552.498, 45.631),
            heading = 268.936,
        },
        {
            coords = vec3(1691.906, 2555.127, 45.631),
            heading = 268.936,
        },
    },

    [STRUCT_GUARDS] = {
        {
            [STRUCT_POS] = vector3(1770.100, 2538.464, 45.564),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_A'
        },
        {
            [STRUCT_POS] = vector3(1767.925, 2565.082, 55.467),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_B'
        },
        {
            [STRUCT_POS] = vector3(1753.888, 2502.016, 45.611),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_C'
        },
        {
            [STRUCT_POS] = vector3(1693.096, 2493.947, 45.564),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_D'
        },
        {
            [STRUCT_POS] = vector3(1656.658, 2488.947, 45.564),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_E'
        },
        {
            [STRUCT_POS] = vector3(1587.6637, 2671.749, 45.47485),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_06'
        },
        {
            [STRUCT_POS] = vector3(1757.54907, 2431.591, 45.5023),
            [STRUCT_HEADING] = 315.853,
            [STRUCT_MODEL] = GetHashKey('mp_s_m_armoured_01'),
            [STRUCT_WEAPON] = GetHashKey('WEAPON_PISTOL'),
            [STRUCT_ROUTE] = 'TYPE_07'
        },
    },

    PrisonBreak = {
        ['WALLS'] = {
            ['ALL_WALLS'] = {
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1772.619995, 2534.912842, 44.537308),
                    interactCoords = vec3(1771.966187, 2533.789307, 44.537308),
                    zoneType = 'INNER'
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1660.881226, 2487.797607, 44.537308),
                    interactCoords = vec3(1661.753906, 2486.833984, 44.537308),
                    zoneType = 'INNER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1725.128784, 2489.148682, 44.537308),
                    interactCoords = vec3(1723.836792, 2489.292969, 44.537308),
                    zoneType = 'INNER'
                },

                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1655.700073, 2758.097412, 44.715355),
                    interactCoords = vec3(1654.400635, 2758.060059, 44.715355),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1545.608765, 2465.994873, 44.690941),
                    interactCoords = vec3(1544.492065, 2466.660400, 44.690941),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1646.324585, 2753.205811, 44.717018),
                    interactCoords = vec3(1647.226562, 2754.141846, 44.717018),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1536.942993, 2579.814209, 44.726524),
                    interactCoords = vec3(1536.740356, 2581.098389, 44.726524),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1777.257935, 2758.835205, 44.692490),
                    interactCoords = vec3(1776.056763, 2759.332275, 44.692490),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1823.912476, 2481.726318, 45.332314),
                    interactCoords = vec3(1824.088989, 2480.438477, 45.332314),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1765.101929, 2415.095459, 44.738335),
                    interactCoords = vec3(1764.183594, 2414.175293, 44.738335),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1653.912476, 2397.722412, 44.789825),
                    interactCoords = vec3(1655.114868, 2397.228271, 44.789825),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1769.781616, 2762.339600, 44.723412),
                    interactCoords = vec3(1768.482178, 2762.302246, 44.723412),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1822.914429, 2624.615234, 44.729828),
                    interactCoords = vec3(1823.225220, 2625.877441, 44.729828),
                    zoneType = 'OUTTER',
                }
            },
            ['FIRST_LAYER'] = {
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1772.619995, 2534.912842, 44.537308),
                    interactCoords = vec3(1771.966187, 2533.789307, 44.537308),
                    zoneType = 'INNER'
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1660.881226, 2487.797607, 44.537308),
                    interactCoords = vec3(1661.753906, 2486.833984, 44.537308),
                    zoneType = 'INNER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1725.128784, 2489.148682, 44.537308),
                    interactCoords = vec3(1723.836792, 2489.292969, 44.537308),
                    zoneType = 'INNER'
                },
            },
            ['SECOND_LAYER'] = {
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1655.700073, 2758.097412, 44.715355),
                    interactCoords = vec3(1654.400635, 2758.060059, 44.715355),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1545.608765, 2465.994873, 44.690941),
                    interactCoords = vec3(1544.492065, 2466.660400, 44.690941),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1646.324585, 2753.205811, 44.717018),
                    interactCoords = vec3(1647.226562, 2754.141846, 44.717018),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1536.942993, 2579.814209, 44.726524),
                    interactCoords = vec3(1536.740356, 2581.098389, 44.726524),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1777.257935, 2758.835205, 44.692490),
                    interactCoords = vec3(1776.056763, 2759.332275, 44.692490),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1823.912476, 2481.726318, 45.332314),
                    interactCoords = vec3(1824.088989, 2480.438477, 45.332314),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1765.101929, 2415.095459, 44.738335),
                    interactCoords = vec3(1764.183594, 2414.175293, 44.738335),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1653.912476, 2397.722412, 44.789825),
                    interactCoords = vec3(1655.114868, 2397.228271, 44.789825),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1769.781616, 2762.339600, 44.723412),
                    interactCoords = vec3(1768.482178, 2762.302246, 44.723412),
                    zoneType = 'OUTTER',
                },
                {
                    model = 'prop_fnclink_10d',
                    coords = vec3(1822.914429, 2624.615234, 44.729828),
                    interactCoords = vec3(1823.225220, 2625.877441, 44.729828),
                    zoneType = 'OUTTER',
                }
            }
        }
    },


    RestrictCommandZones = {
        {
            access = Config.RestrictZones.Access,
            name = 'PRISON_RELEASE_PLAYER_POSITION',
            vertices = {
                vec3(1846.287, 2584.393, 45.672),
                vec3(1846.357, 2588.045, 45.672),
                vec3(1852.263, 2587.999, 45.672),
                vec3(1851.759, 2583.736, 45.672),
            }
        }
    },

    Chairs = {
        [`sanhje_prison_playground_table`] = {
            model = 'sanhje_prison_playground_table',
            debug = true,
            type = 'back',
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
                { offset = vec3(1.0, 0.05, 0.1) },
                { offset = vec3(-0.1, -0.90, 0.1) },
                { offset = vec3(0.0, 1.05, 0.1) },
                { offset = vec3(-1.0, 0.05, 0.1) },
            }
        },

        [`sanhje_Prison_block_table`] = {
            model = 'sanhje_Prison_block_table',
            debug = true,
            type = 'back',
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
                { offset = vec3(1.0, 0.05, 0.1) },
                { offset = vec3(-0.1, -0.90, 0.1) },
                { offset = vec3(0.0, 1.05, 0.1) },
                { offset = vec3(-1.0, 0.05, 0.1) },
            }
        },

        [`prisoncanteen_tables`] = {
            model = 'prisoncanteen_tables',
            debug = true,
            type = 'back',
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
                { offset = vec3(1.4, -0.15, 0.2) },
                { offset = vec3(-0.1, -1.4, 0.2) },
                { offset = vec3(0.0, 1.4, 0.2) },
                { offset = vec3(-1.4, -0.15, 0.2) },
            }
        },

        [`sanhje_Prison_Cafeteria_table`] = {
            model = 'sanhje_Prison_Cafeteria_table',
            debug = true,
            type = 'back',
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
                { offset = vec3(-0.75, 0.9, 0.0) },
                { offset = vec3(0.0, 0.9, 0.0) },
                { offset = vec3(0.65, 0.9, 0.0) },
                { offset = vec3(1.4, 0.9, 0.0) },
                { offset = vec3(1.4, -1.0, 0.0) },
                { offset = vec3(0.65, -1.0, 0.0) },
                { offset = vec3(0.0, -1.0, 0.0) },
                { offset = vec3(-0.75, -1.0, 0.0) },
            }
        },

        [`prop_bench_02`] = {
            model = 'prop_bench_02',
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
                { offset = vec3(-1.1, 0.0, 0.5) },
                { offset = vec3(0.0, 0.0, 0.5) },
                { offset = vec3(0.9, 0.0, 0.5) },
            }
        },

        [`brofx_hei_heist_toilet03`] = {
            model = 'brofx_hei_heist_toilet03',
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
                { offset = vec3(0.05, -0.10, 0.13) },
            }
        },

        [`sanhje_Prison_block_cell_detail_01`] = {
            model = 'sanhje_Prison_block_cell_detail_01',
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
                { offset = vec3(-0.9, -0.5, -0.9) },
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

    prisonVertices = {
        vec3(1829.326, 2474.521, 45.307),
        vec3(1853.348, 2621.093, 46.684),
        vec3(1828.696, 2624.533, 45.482),
        vec3(1856.145, 2700.803, 45.883),
        vec3(1774.818, 2768.410, 45.732),
        vec3(1646.250, 2762.964, 45.798),
        vec3(1565.218, 2683.529, 45.682),
        vec3(1529.485, 2588.008, 45.587),
        vec3(1536.877, 2465.795, 45.545),
        vec3(1660.074, 2387.879, 45.217),
        vec3(1764.278, 2403.568, 45.309)
    },

    cameraProlog = {
        initCameraPosition = vector3(1692.123291, 2564.680176, 57.360081),
        initCameraRot = vector3(-2.981497, 0.06393559, 233.0),
        initGameplayCamRot = vec3(-10.6386, -0, 233.0),
        points = {
            {
                pos = vec3(1715.306152, 2564.119385, 55.278774),
                rot = vector3(-5.106454, 0.06342217, 197.89619445801),
                duration = 8000,
                text = _U('CAMERA_PROLOG.WELCOME_TO_PRISON'),
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
                pos = vector3(1720.03, 2527.28, 47.56),
                rot = vector3(-5.106454, 0.06342217, 343.18),
                duration = 8000,
                text = _U('CAMERA_PROLOG.BASKETBALL_PLACE'),
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
                pos = vector3(1643.2, 2511.05, 53.07),
                rot = vector3(-5.106454, 0.06342217, 5.35),
                duration = 10000,
                text = _U('CAMERA_PROLOG.GYM_PLACE'),
                textTimeout = 6000,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    -- this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vector3(1630.04, 2548.59, 51.26),
                rot = vector3(-5.106454, 0.06342217, 232.75),
                duration = 4000,
                text = '',
                textTimeout = 4000,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vector3(1682.34, 2559.26, 45.1),
                rot = vector3(-5.106454, 0.06342217, 270.47),
                duration = 6000,
                text = '',
                textTimeout = 4000,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vector3(1747.37, 2545.54, 45.57),
                rot = vector3(-5.106454, 0.06342217, 348.46),
                duration = 7000,
                text = '',
                textTimeout = 4000,
                textRenderTime = 4500,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vector3(1754.4, 2563.8, 47),
                rot = vector3(-5.106454, 0.06342217, 29.43),
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
                pos = vector3(1763.562866, 2556.079102, 46.409992),
                rot = vector3(-2.428856, 0.05924932, 334.92651367188),
                duration = 6000,
                text = _U('CAMERA_PROLOG.ACCOUNT_PLACE'),
                textTimeout = 4000,
                textRenderTime = 2500,
                options = {
                    fov = 90.0,
                    copyEffects = false,

                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vector3(1768.131958, 2552.756104, 46.770012),
                rot = vector3(-2.981497, 0.06393559, 267.0),
                duration = 7000,
                text = _U('CAMERA_PROLOG.CANTEEN_PLACE'),
                textTimeout = 2000,
                textRenderTime = 4000,
                options = {
                    fov = 90.0,
                    copyEffects = false,

                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },

            {
                pos = vector3(1764.03, 2534.94, 45.57),
                rot = vector3(-5.106454, 0.06342217, 222.11),
                duration = 8000,
                text = _U('CAMERA_PROLOG.BOOTH_PLACE'),
                textTimeout = 6000,
                textRenderTime = 2000,
                options = {
                    fov = 90.0,
                    copyEffects = false,
                    --this will cause the movement of the camera to feel more smooth becuase it wont wait till will be on the defined destination
                    offsetDuration = 1500,
                }
            },
        }
    },

    jobs = {
        {
            name = _U('JOB.ELECTRICIAN_TITLE'),
            type = JOBS.ELECTRICIAN,
            description = _U('JOB.ELECTRICIAN_DESCRIPTION'),
            points = {
                {pos = vec4(1679.566, 2480.351, 45.564, 134.159)},
                {pos = vec4(1643.321, 2490.787, 45.564, 185.544)},
                {pos = vec4(1622.379, 2508.418, 45.564, 95.21)},
                {pos = vec4(1609.502, 2540.015, 45.564, 145.058)},
                {pos = vec4(1629.602, 2564.378, 45.564, 359.983)},
                {pos = vec4(1652.630, 2564.311, 45.564, 359.733)},
                {pos = vec4(1699.430, 2533.596, 45.564, 92.172)},
            }
        },
        {
            name = _U('JOB.CLEAR_YARD_TITLE'),
            type = JOBS.CLEAN_GROUND,
            description = _U('JOB.LEAF_DESCRIPTION'),
            points = {
                {pos = vec4(1758.37, 2566.15, 45.55, 102.74)},
                {pos = vec4(1756.89, 2514.18, 45.55, 128.11)},
                {pos = vec4(1622.82, 2563.98, 45.56, 33.26)},
                {pos = vec4(1689.13, 2517.97, 45.56, 278.94)},
                {pos = vec4(1663.636, 2496.898, 45.565, 117.869)},
                {pos = vec4(1710.316, 2535.698, 45.564, 94.229)},
                {pos = vec4(1698.954, 2504.914, 45.564, 167.587)},
                {pos = vec4(1687.754, 2475.003, 45.564, 310.722)},
            } 
        },
        {
            name = _U('JOB.BUSHES_TRIMMING_TITLE'),
            type = JOBS.BUSH_TRIMMING,
            description = _U('JOB.BUSHES_DESCRIPTION'),
            points = {
                {pos = vec4(1758.37, 2566.15, 45.55, 102.74)},
                {pos = vec4(1756.89, 2514.18, 45.55, 128.11)},
                {pos = vec4(1622.82, 2563.98, 45.56, 33.26)},
                {pos = vec4(1689.13, 2517.97, 45.56, 278.94)},
                {pos = vec4(1663.636, 2496.898, 45.565, 117.869)},
                {pos = vec4(1710.316, 2535.698, 45.564, 94.229)},
                {pos = vec4(1698.954, 2504.914, 45.564, 167.587)},
                {pos = vec4(1687.754, 2475.003, 45.564, 310.722)},
            } 
        },
        {
            name = _U('JOB.JANITOR_TITLE'),
            type = JOBS.JANITOR,
            description = _U('JOB.JANITOR_DESCRIPTION'),
            points = {
                {pos = vec4(1758.37, 2566.15, 45.55, 102.74)},
                {pos = vec4(1756.89, 2514.18, 45.55, 128.11)},
                {pos = vec4(1622.82, 2563.98, 45.56, 33.26)},
                {pos = vec4(1689.13, 2517.97, 45.56, 278.94)},
                {pos = vec4(1663.636, 2496.898, 45.565, 117.869)},
                {pos = vec4(1710.316, 2535.698, 45.564, 94.229)},
                {pos = vec4(1698.954, 2504.914, 45.564, 167.587)},
                {pos = vec4(1687.754, 2475.003, 45.564, 310.722)},
            } 
        }
    },
    

    interaction = {
        {
            coords = vec3(1758.491, 2568.952, 45.564),
            type = INTERACT_TYPES.BOOTH,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-phone"
            },
            prop = {
                coords = vec3(1758.491, 2568.952, 45.564),
                heading = 320.0,
                model = 'sf_prop_sf_phonebox_01b_s'
            },
            booth = {
                number = 1002,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(1762.021, 2568.468, 45.564),
            type = INTERACT_TYPES.BOOTH,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-phone"
            },
            prop = {
                coords = vec3(1762.154, 2569.087, 45.564),
                heading = 320.0,
                model = 'sf_prop_sf_phonebox_01b_s'
            },
            booth = {
                number = 1001,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(1775.73, 2553.60, 45.556),
            type = INTERACT_TYPES.CANTEEN,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.CANTEEN_LABEL'),
                distance = 3
            },
            npc = {
                coords = vec3(1775.73, 2553.60, 45.556),
                heading = 87.87,
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
            coords = vec3(1631.953, 2527.754, 45.564),
            type = INTERACT_TYPES.DEALER,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.DEALER_LABEL'),
                distance = 1.0
            },
            npc = {
                coords = vec3(1631.953, 2527.754, 45.564),
                heading = 51.067,
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
            coords = vec3(1765.698, 2566.052, 45.565),
            type = INTERACT_TYPES.QUEST,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = 'Warden'
            },
            npc = {
                coords = vec3(1765.698, 2566.052, 45.565),
                heading = 179.142,
                model = 's_m_m_prisguard_01'
            },
            releasePlayerOption = true,
            quest = {
                name = 'Warden',
                description = 'What i can do for you?',
                options = {
                    {
                        label = 'Prison account',
                        action = Actions.SHOW_ACCOUNT
                    },
                    {
                        label = 'Jail time',
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
            coords = vec3(1606.681, 2565.713, 45.564),
            type = INTERACT_TYPES.QUEST,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.GENERAL_LABEL')
            },
            npc = {
                coords = vec3(1606.681, 2565.713, 45.564),
                heading = 228.878,
                model = 's_m_y_prismuscl_01'
            },
            quest = {
                name = _U('QUEST.PRISON_BREAK_NPC_NAME'),
                description = _U('QUEST.PRISON_BREAK_DESC'),
                options = {
                    {
                        label = _U('QUEST.PRISON_BREAK_LABEL'),
                        action = Actions.PRISON_BREAK
                    },
                }
            },
            blip = {
                state = Config.RenderNPCBlips,
                name = _U('BLIPS.PRISON_BREAK'),
                sprite = 126,
                scale = 1.0,
                color = 0,
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(1753.796, 2566.465, 45.8),
            type = INTERACT_TYPES.JOBS,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            npc = {
                coords = vec3(1753.796, 2566.465, 45.564),
                heading = 226.0,
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
            coords = vec3(1766.923, 2531.067, 45.565),
            type = INTERACT_TYPES.CIGAR_PRODUCTION,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            prop = {
                coords = vec3(1766.923, 2531.067, 45.565),
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
            coords = vec3(1779.595, 2563.859, 45.623),
            type = INTERACT_TYPES.PROP_ONLY,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            prop = {
                coords = vec3(1779.595, 2563.859, 45.623),
                heading = -90.0,
                model = 'prop_cooker_03'
            },
            access = INTERACT_ACCESS_TYPES.PRISONER_ONLY
        },
        {
            coords = vec3(1845.988, 2587.849, 45.672),
            type = INTERACT_TYPES.LOBBY,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            npc = {
                coords = vec3(1845.988, 2587.849, 45.672),
                heading = 222.48,
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
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            place = {
                model = 'prop_pris_bench_01',
            },
            coords = vec3(1635.517090, 2526.889404, 45.953522 - 1),
            exercise = EXERCISE_MAP.SITUPS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL,
        },

        {
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            place = {
                model = 'prop_pris_bench_01',
            },
            coords = vec3(1638.194, 2529.714, 45.956 - 1),
            exercise = EXERCISE_MAP.SITUPS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },

        {
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            place = {
                model = 'prop_pris_bench_01',
            },
            coords = vec3(11640.908, 2532.774, 45.948 - 1),
            exercise = EXERCISE_MAP.SITUPS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },

        {
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            place = {
                model = 'prop_pris_bench_01',
            },
            coords = vec3(1642.912, 2535.447, 45.953 - 1),
            exercise = EXERCISE_MAP.SITUPS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },

        {
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            place = {
                model = 'prop_pris_bench_01',
            },
            coords = vec3(1640.624, 2532.729, 45.948 - 1),
            exercise = EXERCISE_MAP.SITUPS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },

        {
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane"
            },
            place = {
                model = 'prop_pris_bench_01',
            },
            coords = vec3(1640.488, 2522.329, 45.948 - 1),
            exercise = EXERCISE_MAP.SITUPS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },

        
        {
            zone = {
                size = vec3(2, 2, 5),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.CRANKS_LABEL')
            },
            place = {
                model = 'prop_pris_bars_01',
            },
            coords = vec3(1643.273, 2527.875, 45.564),
            exercise = EXERCISE_MAP.CRANKS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },

        {
            zone = {
                size = vec3(2, 2, 5),
                icon = "fa-solid fa-paper-plane",
                label = _U('TARGET_ZONE.CRANKS_LABEL')
            },
            place = {
                model = 'prop_pris_bars_01',
            },
            coords = vec3(1649.9425, 2530.74463, 44.565),
            exercise = EXERCISE_MAP.CRANKS,
            type = INTERACT_TYPES.GYM,
            access = INTERACT_ACCESS_TYPES.ALL
        },
    }
}
