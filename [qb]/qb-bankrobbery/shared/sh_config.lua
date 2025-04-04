Config = {}

Config.MinCops = {
    Fleeca = 0,
    Paleto = 0,
    Pacific = 0,
    Vault = 0
}

Config.Banks = {
    ['PinkCage'] = {
        label = 'Pink Cage Motels',
        type = 'fleeca',
        coords = vector3(311.15, -284.49, 54.16),
        hacked = false,
        policeClose = false,
        object = `v_ilev_gb_vauldr`,
        heading = {
            closed = 250.0,
            open = 160.0
        },
        camId = 21,
        laptop = vector4(311.57, -284.0903, 53.974, 259.00),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(314.18, -283.07, 54.14, 339.50)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(315.92, -285.14, 54.14, 249.50)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(313.47702, -289.2542, 54.1431, 320.27249)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(311.61235, -287.6962, 54.143051, 305.18524)
            }
        }
    },
    ['Legion'] = {
        label = 'Legion Square',
        type = 'fleeca',
        coords = vector3(146.92, -1046.11, 29.36),
        hacked = false,
        policeClose = false,
        object = `v_ilev_gb_vauldr`,
        heading = {
            closed = 250.0,
            open = 160.0
        },
        camId = 22,
        laptop = vector4(148.10859, -1046.593, 30.00808, 246.72924),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(151.64, -1046.71, 29.35, 250.00)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(150.04, -1044.54, 29.29, 343.00)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(147.13935, -1049.607, 29.34633, 311.47201)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(149.51391, -1050.767, 29.346384, 291.46362)
            }
        }
    },
    ['Hawick'] = {
        label = 'Hawick Ave',
        type = 'fleeca',
        coords = vector3(-353.82, -55.37, 49.03),
        hacked = false,
        policeClose = false,
        object = `v_ilev_gb_vauldr`,
        heading = {
            closed = 250.0,
            open = 160.0
        },
        camId = 23,
        laptop = vector4(-354.08, -55.27648, 49.8666, 257.45),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(-349.16, -55.93, 49.01, 250.00)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(-350.82, -53.7, 49.01, 340.00)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(-353.644, -59.04, 49.0148, 309.626)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(-351.6271, -59.91, 49.0148, 296.23211)
            }
        }
    },
    ['DelPerro'] = {
        label = 'Del Perro Blvd',
        type = 'fleeca',
        coords = vector3(-1210.77, -336.57, 37.78),
        hacked = false,
        policeClose = false,
        object = `v_ilev_gb_vauldr`,
        heading = {
            closed = 296.863,
            open = 206.863
        },
        camId = 24,
        laptop = vector4(-1209.822, -336.4793, 37.381, 299.439),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(-1207.14, -333.59, 37.76, 297.0)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(-1209.64, -333.26, 37.76, 27.0)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(-1207.97, -338.9731, 37.759284, 353.9089)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(-1205.895, -338.0665, 37.759326, 340.50067)
            }
        }
    },
    ['GreatOcean'] = {
        label = 'Great Ocean Hwy',
        type = 'fleeca',
        coords = vector3(-2956.55, 481.74, 15.69),
        hacked = false,
        policeClose = false,
        object = `hei_prop_heist_sec_door`,
        heading = {
            closed = 357.542,
            open = 267.542
        },
        camId = 25,
        laptop = vector4(-2956.564, 481.957, 15.297, 347.02),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(-2958.77, 484.18, 15.68, 87.06)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(-2957.33, 486.25, 15.68, 358.00)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(-2953.083, 482.7803, 15.675336, 49.137405)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(-2952.881, 485.22781, 15.675389, 37.428142)
            }
        }
    },
    ['Sandy'] = {
        label = 'Sandy Shores',
        type = 'fleeca',
        coords = vector3(1175.28, 2712.72, 38.08),
        hacked = false,
        policeClose = false,
        object = `v_ilev_gb_vauldr`,
        heading = {
            closed = 90.00,
            open = 0.00
        },
        camId = 99,
        laptop = vector4(1175.34, 2713.09, 39.35, 84.60),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(1171.43, 2711.87, 38.07, 91.2)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(1173.79, 2710.41, 38.07, 181.2)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(1174.6406, 2716.2036, 38.066295, 141.10868)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(1171.6578, 2716.2761, 38.066303, 231.91242)
            }
        }
    },
    ['Maze'] = {
        label = 'Maze Bank',
        type = 'fleeca',
        coords = vector3(-1306.52, -818.39, 17.15),
        hacked = false,
        policeClose = false,
        object = 961976194,
        heading = {
            closed = 37.00,
            open = 227.00
        },
        camId = 99,
        laptop = vector4(-1304.17, -815.56, 18.05, 311.46),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(-1307.53, -810.4, 17.15, 307.00)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(-1311.2, -813.01, 17.15, 126.65)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(-1310.97, -811.23, 17.15, 221.28)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(-1308.99, -809.94, 17.15, 187.48)
            }
        },
        thermite = {
            [1] = {
                coords = vector4(-1308.46, -814.2, 17.20, 38.56),
                ptfx = vector3(-1308.57, -813.1, 17.20),
                doorId = 42,
                hit = false
            }
        }
    },
    ['Paleto'] = {
        label = 'Blaine County Savings Bank',
        type = 'paleto',
        coords = vector3(-105.61, 6472.03, 31.62),
        outsideHack = false,
        hacked = false,
        policeClose = false,
        object = -1185205679,
        heading = {
            closed = 45.45,
            open = 130.45
        },
        camId = 26,
        laptop = vector4(-109.6426, 6483.5849, 31.00846, 223.6921),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(-107.37, 6473.08, 31.63, 133.94)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(-107.99, 6475.9, 31.63, 44.67)
            },
            [3] = {
                busy = false,
                taken = false,
                coords = vector4(-102.84, 6478.43, 31.63, 315.79)
            },
            [4] = {
                busy = false,
                taken = false,
                coords = vector4(-102.47, 6475.33, 31.63, 225.12)
            }
        },
        trolly = {
            [1] = {
                type = 'money',
                taken = false,
                coords = vector4(-106.2033, 6477.7485, 31.626792, 175.3149)
            },
            [2] = {
                type = 'money',
                taken = false,
                coords = vector4(-104.9971, 6478.7548, 31.649032, 257.95233)
            }
        },
        thermite = {
            [1] = {
                coords = vector4(-105.3955, 6475.019, 31.826705, 313.00),
                ptfx = vector3(-105.4855, 6475.999, 31.926705),
                doorId = 41,
                hit = false
            }
        }
    },
    ['Pacific'] = {
        label = 'Pacific Standard Bank',
        type = 'pacific',
        coords = vector3(254.55, 224.96, 101.88),
        hacked = false,
        card = false,
        policeClose = false,
        object = 961976194,
        heading = {
            closed = 160.00,
            open = 35.00
        },
        camId = 26,
        laptop = vector4(253.18, 228.24, 101.42, 72.19),
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(259.9, 218.46, 101.68, 340.00)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(257.11, 214.04, 101.68, 160.00)
            }
        },
        trolly = {
            [1] = {
                type = 'gold',
                taken = false,
                coords = vector4(263.58, 216.02, 101.68, 108.98)
            },
            [2] = {
                type = 'gold',
                taken = false,
                coords = vector4(265.53, 213.55, 101.68, 154.02)
            },
            [3] = {
                type = 'money',
                taken = false,
                coords = vector4(262.24, 213.16, 101.68, 31.58)
            },
            [4] = {
                type = 'money',
                taken = false,
                coords = vector4(259.32, 214.94, 101.68, 114.46)
            }
        },
        thermite = {
            [1] = {
                coords = vector4(257.37, 220.22, 106.39, 342.15),
                ptfx = vector3(257.45, 221.22, 106.39),
                doorId = 32,
                hit = false
            },
            [2] = {
                coords = vector4(253.01703, 220.73141, 101.78381, 162.6746),
                ptfx = vector3(253.11703, 221.53141, 101.78381),
                doorId = 43,
                hit = false
            },
            [3] = {
                coords = vector4(261.66752, 215.73648, 101.78382, 261.99899),
                ptfx = vector3(261.69946, 216.82735, 101.78382),
                doorId = 44,
                hit = false
            }
        }
    },
    ['Vault'] = {
        label = 'Pacific Lower Vault',
        type = 'vault',
        coords = vector3(256.7, 240.11, 101.69),
        goldhacked = false,
        lockdown = false,
        laptopDoor = 124,
        powerplantHit = false,
        lasersActive = false,
        hacked = false,
        code = false,
        policeClose = false,
        object = -1520917551,
        heading = {
            closed = 160.00,
            open = 295.00
        },
        laptop = vector4(257.5, 227.83, 101.42, 345.84),
        stacks = {
            [1] = {
                model = `h4_prop_h4_cash_stack_01a`,
                coords = vector4(265.812, 241.233, 101.581, 250.00),
                taken = false
            },
            [2] = {
                model = `h4_prop_h4_cash_stack_01a`,
                coords = vector4(268.112, 247.533, 101.581, 250.00),
                taken = false
            },
            [3] = {
                model = `h4_prop_h4_cash_stack_01a`,
                coords = vector4(254.062, 258.454, 101.581, 70.00),
                taken = false
            },
            [4] = {
                model = `h4_prop_h4_gold_stack_01a`,
                coords = vector4(250.019, 247.602, 101.581, 70.00),
                taken = false
            },
            [5] = {
                model = `h4_prop_h4_gold_stack_01a`,
                coords = vector4(251.988, 252.979, 101.581, 70.00),
                taken = false
            }
        },
        lockers = {
            [1] = {
                busy = false,
                taken = false,
                coords = vector4(261.67, 234.51, 101.68, 250.00)
            },
            [2] = {
                busy = false,
                taken = false,
                coords = vector4(259.79, 232.97, 101.68, 340.00)
            },
            [3] = {
                busy = false,
                taken = false,
                coords = vector4(257.46, 234.39, 101.68, 160.00)
            }
        },
        trolly = {
            [1] = {
                type = 'gold',
                taken = false,
                coords = vector4(262.67, 262.21, 101.68, 200.53)
            },
            [2] = {
                type = 'gold',
                taken = false,
                coords = vector4(266.18, 260.96, 101.68, 114.51)
            },
            [3] = {
                type = 'money',
                taken = false,
                coords = vector4(266.05, 258.54, 101.68, 70.56)
            },
            [4] = {
                type = 'money',
                taken = false,
                coords = vector4(261.49, 260.25, 101.68, 287.52)
            }
        },
        explosion = {
            [1] = vector4(255.35, 245.21, 101.74, 70.86),
            [2] = vector4(260.50, 243.08, 101.74, 252.3),
            [3] = vector4(257.41, 251.00, 101.74, 70.7),
            [4] = vector4(262.43, 248.50, 101.74, 249.4),
            [5] = vector4(259.43, 256.39, 101.74, 70.82)
        }
    }
}

Config.MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [16] = true,
    [17] = true,
    [18] = true,
    [19] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [101] = true,
    [102] = true,
    [116] = true,
    [117] = true,
    [118] = true,
    [129] = true,
    [136] = true,
    [173] = true,
}

Config.FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [16] = true,
    [17] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [23] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [72] = true,
    [73] = true,
    [74] = true,
    [75] = true,
    [133] = true,
    [134] = true,
    [135] = true,
    [146] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
    [169] = true,
}