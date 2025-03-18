--[[
    Welcome to the qs-apartments configuration guide!

    Before you dive into setting up your new asset, make sure to read this guide carefully.
    We'll explain each key part of the configuration, step by step, so that you can
    customize everything to fit your server perfectly.

    Important configuration sections will be clearly marked, like this one you're reading now.
    These sections will guide you through each setting available in this file.

    Flexibility is a big part of this setup. Most settings can be adapted to work with
    your specific framework (ESX, QBCore, etc.), so feel free to tweak them as needed.
    You’ll find all the customizable files under client/custom/* or server/custom/*.

    Before you get started, check out our detailed documentation for full guidance:
    https://docs.quasar-store.com/information/welcome

    This resource offers full customization, making it easy to adjust features to your server’s needs.
    Take your time to explore and enjoy building your apartments system!
]]

Config = {}
Locales = {}

--[[
    Choose your preferred language!

    In this section, you can select the main language for your asset. We have a wide
    selection of default languages available, located in the locales/* folder.

    If your language is not listed, don't worry! You can easily create a new one
    by adding a new file in the locales folder and customizing it to your needs.

    Default languages available:
        'ar'     -- Arabic
        'bg'     -- Bulgarian
        'ca'     -- Catalan
        'cs'     -- Czech
        'da'     -- Danish
        'de'     -- German
        'el'     -- Greek
        'en'     -- English
        'es'     -- Spanish
        'fa'     -- Persian
        'fr'     -- French
        'hi'     -- Hindi
        'hu'     -- Hungarian
        'it'     -- Italian
        'ja'     -- Japanese
        'ko'     -- Korean
        'nl'     -- Dutch
        'no'     -- Norwegian
        'pl'     -- Polish
        'pt'     -- Portuguese
        'ro'     -- Romanian
        'ru'     -- Russian
        'sl'     -- Slovenian
        'sv'     -- Swedish
        'th'     -- Thai
        'tr'     -- Turkish
        'zh-CN'  -- Chinese (Simplified)
        'zh-TW'  -- Chinese (Traditional)

    After selecting your preferred language, be sure to save your changes and test
    the asset to ensure everything works as expected!
]]

Config.Language = 'en'

--[[
    This script automatically detects your framework (qb-core, es_extended, etc.)
    based on the mappings in the `frameworks` table below. If you’ve renamed your
    framework, you can set `Config.Framework` to an empty value and manually add
    your custom framework name to the `frameworks` table.

    Example:
        If your framework is named 'custom-core' and based on qb-core,
        add ['custom-core'] = 'qb' to the `frameworks` table.

    **Important:** Do not modify this code unless you fully understand how the
    framework integration works. Incorrect edits may cause script errors.
]]

local function dependencyCheck(data)
    for k, v in pairs(data) do
        if GetResourceState(k) == 'started' then
            return v
        end
    end
    return false
end

local frameworks = {
    ['es_extended'] = 'esx',
    ['qb-core'] = 'qb',
    ['qbx_core'] = 'qb'
}

Config.Framework = dependencyCheck(frameworks)
Config.HasQBX = GetResourceState('qbx_core') == 'started'
Config.FiveGuard = false -- Your fiveguard script name if exists, if not false.

--[[
    Explanation about target system: This script supports `ox_target`, `qb-target` and `qtarget` for interactions.
    Other target systems are not compatible.
]]

Config.UseTarget = true    -- Enables or disables the use of the target system for interaction with objects or zones.
Config.TargetDistance = 5.0 -- Defines the interaction distance for the target system.
Config.TargetWidth = 5.0    -- Specifies the width of the interaction zone.
Config.TargetLength = 5.0   -- Specifies the length of the interaction zone.
Config.ZoneDebug = false    -- Toggles debugging for interaction zones (shows zone boundaries).

--[[
    This script provides an automated configuration for the wardrobe system, detecting your current
    wardrobe system and applying the appropriate settings automatically from the `wardrobes` table.

    If your wardrobe system is not listed here, you can manually configure it by editing the files
    located in `client/custom/wardrobe/*.lua`. To add your wardrobe system, follow the same
    structure as the examples in the `wardrobes` table.

    Example:
        If your wardrobe system is named 'custom-clothes' and works like 'qb-clothing',
        add ['custom-clothes'] = 'qb-clothing' to the table.

    **Important:** If you need help or have questions, reach out to the asset seller.
    Incorrect configurations may result in wardrobe integration issues.
]]

local wardrobes = {
    ['qb-clothing'] = 'qb-clothing',
    ['ak47_clothing'] = 'ak47_clothing',
    ['esx_skin'] = 'esx_skin',
    ['illenium-appearance'] = 'illenium-appearance',
    ['raid_clothes'] = 'raid_clothes',
    ['rcore_clothes'] = 'rcore_clothes'
}

Config.Wardrobe = dependencyCheck(wardrobes)

--[[
    The inventory system in this script allows you to assign a personalized stash to each house in the asset.
    This function automatically detects which inventory system you are using by referencing the `inventories` table.

    If your inventory system is not listed, you can manually configure it by editing the corresponding file in
    `client/custom/inventory/*.lua`. Add your inventory system to the `inventories` table following the same
    structure as the existing entries.

    Example:
        If your inventory system is named 'custom-inventory' and behaves like 'qs-inventory',
        add ['custom-inventory'] = 'qs-inventory' to the table.

    **Important:** If you have questions or issues setting this up, contact the asset seller for assistance.
    Incorrect configurations may result in inventory integration issues.
]]

function TriggerCharacterCreation()
    print('create character')
    TriggerEvent('qb-clothes:client:CreateFirstCharacter')
end

local inventories = {
    ['qs-inventory'] = 'qs-inventory',
    ['qb-inventory'] = 'qb-inventory',
    ['ps-inventory'] = 'ps-inventory',
    ['ox_inventory'] = 'ox_inventory',
    ['core_inventory'] = 'core_inventory',
    ['codem-inventory'] = 'codem-inventory',
    ['inventory'] = 'inventory',
    ['origen_inventory'] = 'origen_inventory'
}

Config.Inventory = dependencyCheck(inventories) or 'default'

Config.DefaultStashData = {
    maxweight = 1000000,
    slots = 30,
}

--[[
    Shell and 3D Model Configuration:

    This section configures the shells (interior models) and 3D props used for house creation.
    You can define props or specify shell models here, with no limit to the number you can add.

    Each shell includes options for `model` (the interior model name) and `stash` settings,
    allowing customization of inventory weight and slots.

    If you're looking for more shells, check out our trusted partner at
    https://www.k4mb1maps.com, known for excellent FiveM-compatible shells.

    **Note:** Expand this configuration to meet your server’s requirements as needed.
]]

Config.Shells = {
    [1] = { model = 'shell_v16low', stash = { maxweight = 1000000, slots = 5 } },
    [2] = { model = 'shell_office1', stash = { maxweight = 1000000, slots = 5 } },
    [3] = { model = 'shell_v16low', stash = { maxweight = 1000000, slots = 5 } },
    [4] = { model = 'shell_v16mid', stash = { maxweight = 1000000, slots = 5 } },
}

Apartments = {}
Apartments.Starting = true
Apartments.SpawnOffset = 30
Apartments.Locations = {
    ['apartment1'] = {
        name = 'apartment1',
        label = 'South Rockford Drive',
        price = 5000, -- move price
        tier = 1,
        coords = {
            enter = vector4(-667.02, -1105.24, 14.63, 242.32),
        },
        polyzoneBoxData = {
            heading = 245,
            minZ = 13.5,
            maxZ = 16.0,
            debug = false,
            length = 1,
            width = 3,
            distance = 2.0,
            created = false
        }
    },
    ['apartment2'] = {
        name = 'apartment2',
        label = 'Morningwood Blvd',
        price = 5000, -- move price
        tier = 2,
        coords = {
            enter = vector4(-1288.52, -430.51, 35.15, 124.81),
        },
        polyzoneBoxData = {
            heading = 124,
            minZ = 34.0,
            maxZ = 37.0,
            debug = false,
            length = 1,
            width = 3,
            distance = 2.0,
            created = false
        }
    },
    ['apartment3'] = {
        name = 'apartment3',
        label = 'Integrity Way',
        price = 5000, -- move price
        tier = 3,
        coords = {
            enter = vector4(269.73, -640.75, 42.02, 249.07),
        },
        polyzoneBoxData = {
            heading = 250,
            minZ = 40,
            maxZ = 43.5,
            debug = false,
            length = 1,
            width = 1,
            distance = 2.0,
            created = false
        }
    },
    ['apartment4'] = {
        name = 'apartment4',
        label = 'Tinsel Towers',
        price = 5000, -- move price
        tier = 4,
        coords = {
            enter = vector4(-619.29, 37.69, 43.59, 181.03),
        },
        polyzoneBoxData = {
            heading = 180,
            minZ = 41.0,
            maxZ = 45.5,
            debug = false,
            length = 1,
            width = 2,
            distance = 2.0,
            created = false
        }
    },
    ['apartment5'] = {
        name = 'apartment5',
        label = 'Fantastic Plaza',
        price = 5000, -- move price
        tier = 1,
        coords = {
            enter = vector4(291.517, -1078.674, 29.405, 270.75),
        },
        polyzoneBoxData = {
            heading = 270,
            minZ = 28.5,
            maxZ = 31.0,
            debug = false,
            length = 1,
            width = 2,
            distance = 2.0,
            created = false
        }
    },
}


exports('GetApartments', function()
    return Apartments
end)

ActionControls = {
    forward = { label = 'Forward +/-', codes = { 33, 32 } },             -- Moves the object forward or backward.
    right = { label = 'Right +/-', codes = { 35, 34 } },                 -- Moves the object left or right.
    up = { label = 'Up +/-', codes = { 52, 51 } },                       -- Adjusts vertical positioning.
    add_point = { label = 'Add Point', codes = { 24 } },                 -- Adds a new point in the editor.
    set_any = { label = 'Set', codes = { 24 } },                         -- Sets a generic property.
    undo_point = { label = 'Undo Last', codes = { 25 } },                -- Reverts the last added point.
    set_position = { label = 'Set Position', codes = { 24 } },           -- Sets the position of an object.
    add_garage = { label = 'Add Garage', codes = { 24 } },               -- Adds a garage to the map.
    rotate_z = { label = 'RotateZ +/-', codes = { 20, 73 } },            -- Rotates the object around the Z-axis.
    rotate_z_scroll = { label = 'RotateZ +/-', codes = { 17, 16 } },     -- Rotates Z-axis using scroll.
    increase_z = { label = 'Z Boundary +/-', codes = { 180, 181 } },     -- Increases the Z-axis boundary.
    decrease_z = { label = 'Z Boundary +/-', codes = { 21, 180, 181 } }, -- Decreases the Z-axis boundary.
    done = { label = 'Done', codes = { 191 } },                          -- Confirms actions and exits the editor.
    change_player = { label = 'Player +/-', codes = { 82, 81 } },        -- Cycles through available players.
    change_shell = { label = 'Change Shell +/-', codes = { 189, 190 } }, -- Switches between shell models.
    select_player = { label = 'Select Player', codes = { 191 } },        -- Selects a specific player.
    cancel = { label = 'Cancel', codes = { 194 } },                      -- Cancels the current action.
    change_outfit = { label = 'Outfit +/-', codes = { 82, 81 } },        -- Changes between outfits.
    delete_outfit = { label = 'Delete Outfit', codes = { 178 } },        -- Deletes the selected outfit.
    select_vehicle = { label = 'Vehicle +/-', codes = { 82, 81 } },      -- Cycles through vehicles.
    spawn_vehicle = { label = 'Spawn Vehicle', codes = { 191 } },        -- Spawns the selected vehicle.
    leftApt = { label = 'Previous Apartment', codes = { 174 } },         -- Navigates to the previous apartment.
    rightApt = { label = 'Next Apartment', codes = { 175 } },            -- Navigates to the next apartment.
    testPos = { label = 'Test Pos', codes = { 47 } },                    -- Tests the position of an object or point.
}

--[[
    Key Bindings:

    This section defines key mappings used in the script. You can add or modify
    keys by changing their values in the `Keys` table.

    For example:
        To change the key for 'MoreSpeed' from '.' to '/', replace `Keys['.']`
        with `Keys['/']` in the `Config.FreeModeKeys` section.
]]

Keys = {
    -- Define key codes for various actions.
    ['ESC'] = 322,
    ['F1'] = 288,
    ['F2'] = 289,
    ['F3'] = 170,
    ['F5'] = 166,
    ['F6'] = 167,
    ['F7'] = 168,
    ['F8'] = 169,
    ['F9'] = 56,
    ['F10'] = 57,
    ['~'] = 243,
    ['1'] = 157,
    ['2'] = 158,
    ['3'] = 160,
    ['4'] = 164,
    ['5'] = 165,
    ['6'] = 159,
    ['7'] = 161,
    ['8'] = 162,
    ['9'] = 163,
    ['-'] = 84,
    ['='] = 83,
    ['BACKSPACE'] = 177,
    ['TAB'] = 37,
    ['Q'] = 44,
    ['W'] = 32,
    ['E'] = 38,
    ['R'] = 45,
    ['T'] = 245,
    ['Y'] = 246,
    ['U'] = 303,
    ['P'] = 199,
    ['['] = 39,
    [']'] = 40,
    ['ENTER'] = 18,
    ['CAPS'] = 137,
    ['A'] = 34,
    ['S'] = 8,
    ['D'] = 9,
    ['F'] = 23,
    ['G'] = 47,
    ['H'] = 74,
    ['K'] = 311,
    ['L'] = 182,
    ['LEFTSHIFT'] = 21,
    ['Z'] = 20,
    ['X'] = 73,
    ['C'] = 26,
    ['V'] = 0,
    ['B'] = 29,
    ['N'] = 249,
    ['M'] = 244,
    [','] = 82,
    ['.'] = 81,
    ['LEFTCTRL'] = 36,
    ['LEFTALT'] = 19,
    ['SPACE'] = 22,
    ['RIGHTCTRL'] = 70,
    ['HOME'] = 213,
    ['PAGEUP'] = 10,
    ['PAGEDOWN'] = 11,
    ['DELETE'] = 178,
    ['LEFT'] = 174,
    ['RIGHT'] = 175,
    ['TOP'] = 27,
    ['DOWN'] = 173,
    ['NENTER'] = 201,
    ['N4'] = 108,
    ['N5'] = 60,
    ['N6'] = 107,
    ['N+'] = 96,
    ['N-'] = 97,
    ['N7'] = 117,
    ['N8'] = 61,
    ['N9'] = 118
}

--[[
    Free Mode Controls:

    Customize the controls for moving, rotating, and tilting objects in free mode.
    Use the keys defined in the `Keys` table to assign actions.

    Examples:
    - `MoveToTop` moves the object upwards.
    - `RotateToLeft` rotates the object to the left.
    - `StickToTheGround` snaps the object to the ground level.
]]

Config.FreeModeKeys = {
    ChangeKey = Keys['LEFTCTRL'],       -- Key to toggle free mode controls.

    MoreSpeed = Keys['.'],              -- Increase movement speed.
    LessSpeed = Keys[','],              -- Decrease movement speed.

    MoveToTop = Keys['TOP'],            -- Move the object upward.
    MoveToDown = Keys['DOWN'],          -- Move the object downward.

    MoveToForward = Keys['TOP'],        -- Move the object forward.
    MoveToBack = Keys['DOWN'],          -- Move the object backward.
    MoveToRight = Keys['RIGHT'],        -- Move the object to the right.
    MoveToLeft = Keys['LEFT'],          -- Move the object to the left.

    RotateToTop = Keys['6'],            -- Rotate the object upward.
    RotateToDown = Keys['7'],           -- Rotate the object downward.
    RotateToLeft = Keys['8'],           -- Rotate the object to the left.
    RotateToRight = Keys['9'],          -- Rotate the object to the right.

    TiltToTop = Keys['Z'],              -- Tilt the object upward.
    TiltToDown = Keys['X'],             -- Tilt the object downward.
    TiltToLeft = Keys['C'],             -- Tilt the object to the left.
    TiltToRight = Keys['V'],            -- Tilt the object to the right.

    StickToTheGround = Keys['LEFTALT'], -- Snap the object to the ground.
}

Config.InteractInDoor = false                      -- DrawText interaction in door.
Config.HideRadarInDecorate = true                  -- Hides the radar when in decoration mode.
Config.ModernDecorateMode = true                   -- Enables modern decoration mode with an updated interface.
Config.DynamicDoors = true                         -- Enable dynamic doors? Requires `setr game_enableDynamicDoorCreation "true"` in your server configuration.
Config.SpawnDistance = 100.0                       -- Distance in meters for spawning related objects/entities.
Config.DecorationMappingKey = 'F9'                 -- The keybind used to open the decoration mapping interface.
Config.ApartmentLocation = 'ApartmentLocation'     -- Defines interaction points inside the van, such as stash, wardrobe, or charger.
Config.ApartmentDecoration = 'ApartmentDecoration' -- Command or configuration for customizing the van's appearance or decorations.
Config.ApartmentSelector = 'Apartment'             -- Select your apartment.

Config.HandleHud = {
    enable = function()
        Debug('Enable hud triggered')
        -- Place your code here to enable the HUD when needed.
    end,
    disable = function()
        Debug('Disable hud triggered')
        -- Place your code here to disable the HUD when needed.
    end
}

Config.CreatorAlpha = 200                                   -- Adjust the alpha transparency of certain visual elements in the creator (ignore if unnecessary).
Config.ShellSpawnCoords = vec4(279.46, 335.1, 98.57, 67.26) -- Coordinates for spawning shells.
Config.SellObjectCommision = 0.3                            -- Commission that will be charged when selling a piece of furniture

CameraOptions = {
    lookSpeedX = 500.0, -- Horizontal camera movement speed.
    lookSpeedY = 500.0, -- Vertical camera movement speed.
    moveSpeed = 10.0,   -- Speed at which the camera moves in free mode.
    climbSpeed = 10.0,  -- Speed for vertical camera movement (up/down).
    rotateSpeed = 50.0, -- Rotation speed of the camera in free mode.
}

Config.HandleHud = {
    enable = function()
        Debug('Enable hud triggered')
        -- Place your code here to enable the HUD when needed.
    end,
    disable = function()
        Debug('Disable hud triggered')
        -- Place your code here to disable the HUD when needed.
    end
}

--[[
    Debug Mode Configuration:

    Debug mode provides constant logs and information about the system’s operations.
    It is mainly intended for developers to diagnose issues or understand how the
    resource works.

    **Note:** It is not recommended to enable this mode in production environments
    as it may generate excessive logs that could impact performance.
]]

Config.Debug = true
