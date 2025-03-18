Strings = {}

Strings.Notify = {
    error = 'An error has occured, please try again',
    cancel = 'You cancelled placing the table',
    restricted = 'You can\'t place that here',
    missing = 'You do not have a table to place down',
    cantPlace = 'You cannot place this table here',
    noPseudoephedrine = 'How am I supposed to crush pseudoephedrine if I have none?',
    missingIngredient = 'I don\'t think I have enough here..',
    noMeth = 'Am I high? I tried heating up meth I don\'t even have..',
    toxic = 'The toxic fumes are causing difficulty breathing and pain',
    max = 'I think I have enough tables already..',
    incomplete = 'You must complete all previous steps first',
    cantAfford = 'I do not have enough money for this..',
    pinCreated = 'You\'ve successfully added a passcode',
    pinReset = 'You\'ve successfully reset your passcode',
    pinRemoved = 'The passcode has been removed',
    wrongPin = 'Incorrect pin - unable to authorize access',
    visitorLocked = 'This door is currently locked',
    locked = 'You have locked the door',
    unlocked = 'You have unlocked the door',
    limit = 'I think I have more than enough warehouses..',
    targetLimit = 'User already owns the maximum amount of warehouses',
    targetLevel = 'User is not a high enough level to own this warehouse',
    transferred = 'You successfully transferred ownership of your warehouse',
    receivedTransfer = 'You have received ownership of a warehouse',
    unconfirmed = 'Incorrect confirmation message - please try again',
    noPolice = 'There are not enough police in the city',
    raidFail = 'You failed breaking in - try again',
    getRot = 'Your current rotation value was stored to your clipboard!',
    confiscated = 'Dispatch has been notified and they will begin confiscation on all the equipment requested shortly',
    notAuthorized = 'You are not authorized to do this',
    transferSelf = 'Wait.. I already own this.. what am I doing?',
    addSelf = 'Why would I try to give myself access.. silly',
    addSuccess = 'You\'ve successfully added %s',
    addFail = 'Invalid player - please try again',
    removeSuccess = 'You\'ve successfully removed %s',
    userNotFound = 'That user was not found in authorized users',
    noAccess = 'I\'m not interested in doing business with you..',
    notReady = 'I\'ll be here when you\'ve got that..',
    missingItem = 'Come on man.. don\'t waste my time..',
    startSupply = 'Your GPS has been updated',
    stopSupply = 'Successfully stopped generating new supply runs',
    supplyLimit = 'No one is available right now..',
    supplyLow = 'Hmm.. I don\'t seem to have enough supply for these inputs',
    cookStarted = 'The manufacturing process has already started',
    powerSurge = 'You hear the electrical hum as the power surges..',
    noMethBreak = 'I must be high.. I have no meth to break down',
    noMethBag = 'I should stop smoking this stuff.. I have nothing to bag',
    overdose = {
        'You feel your heart racing as your vision fades..',
        'You start feeling your anxiety increase rapidly..',
        'You start feeling increasingly ill..'
    },
    died = 'You have overdosed'
}

Strings.Menu = {
    warehouseShop = {
        details = {
            mainTitle = 'Warehouse Availability',
            title = 'Purchase for $'
            -- Icons, images, etc for each warehouse is set in the config.lua file
        },
        confirm = {
            mainTitle = 'Confirm Purchase',
            confirm = {
                title = 'Yes',
                description = 'Confirm warehouse purchase for $',
                icon = 'fas fa-circle-check',
                iconColor = '#82E58B'
            },
            cancel = {
                title = 'No',
                description = 'Cancel purchase and go back to selection',
                icon = 'fas fa-circle-xmark',
                iconColor = '#FF5C5C'
            },
            waypoint = {
                title = 'Set Waypoint',
                description = 'Set a waypoint to see where this warehouse is',
                icon = 'fas fa-map-location-dot',
                iconColor = ''
            }
        }
    },
    operations = {
        title = 'Manage Operations',
        status = {
            inactive = {
                title = 'Current Status',
                description = 'Nothing is currently happening',
                icon = 'fas fa-pause',
                iconColor = '',
                iconAnimation = ''
            },
            active = {
                title = 'Current Status | Stage %d of %d',
                -- Descriptions are available in Config.Cooking.warehouse.stages
                icon = 'fas fa-rotate',
                iconColor = '',
                iconAnimation = 'spin',
            }
        },
        supply = {
            title = 'View Supply',
            description = 'View your facility\'s current supply levels',
            icon = 'fas fa-chart-simple',
            iconColor = '',
            metadata = {
                ammonia = { label = 'Ammonia', value = '%d%%' },
                iodine = { label = 'Iodine', value = '%d%%' },
                acetone = { label = 'Acetone', value = '%d%%' }
            },
            colors = { red = 'red', yellow = 'yellow', green = 'green' }
        },
        inputs = {
            title = 'View Inputs',
            description = 'View your facility\'s current input values',
            icon = 'fas fa-list-check',
            iconColor = '',
            metadata = {
                ammonia = 'Ammonia',
                iodine = 'Iodine',
                acetone = 'Acetone',
                temp = 'Temperature'
            }
        },
        power = {
            on = {
                title = 'Power On',
                description = 'Power on manufacturing equipment to begin cooking',
                icon = 'fas fa-power-off',
                iconColor = '#82E58B'
            },
            off = {
                title = 'Power Off',
                description = 'Terminate all manufacturing processes immediately',
                icon = 'fas fa-power-off',
                iconColor = '#FF5C5C'
            }
        }
    },
    security = {
        title = 'Manage Security',
        door = {
            title = 'Door Status |',
            description = 'The door to the warehouse is currently',
            locked = {
                status = 'Locked',
                icon = 'fas fa-lock',
                iconColor = '#FF5C5C'
            },
            unlocked = {
                status = 'Unlocked',
                icon = 'fas fa-unlock',
                iconColor = '#82E58B'
            }
        },
        camera = {
            title = 'View Camera',
            description = 'Take a look at your front door security camera',
            icon = 'fas fa-video',
            iconColor = ''
        },
        passcode = {
            create = {
                title = 'Create Passcode',
                description = 'Add a numerical passcode to access stash(es)',
                icon = 'fas fa-key',
                iconColor = ''
            },
            reset = {
                title = 'Reset Passcode',
                description = 'Change your stash(es) current passcode',
                icon = 'fas fa-rotate',
                iconColor = ''
            },
            remove = {
                title = 'Remove Passcode',
                description = 'Remove your stash(es) current passcode',
                icon = 'fas fa-delete-left',
                iconColor = '#FF5C5C'
            }
        },
        auth_users = {
            title = 'Authorized Users',
            description = 'Manage who has access to your warehouse',
            icon = 'fas fa-user-lock',
            iconColor = '',
            add = {
                title = 'Add User',
                description = 'Add a new authorized user',
                icon = 'fas fa-circle-plus',
                iconColor = '#82E58B',
            },
            remove = {
                -- title of this menu is the authorized users name
                description = 'Remove %s\'s access from your warehouse',
                icon = 'fas fa-user-minus',
                iconColor = '#FF5C5C',
            }
        }
    },
    facility = {
        title = 'Manage Facility',
        pending = {
            notice = {
                title = 'Upgrade Pending',
                description = 'No upgrades available until current one is complete',
                icon = 'fas fa-circle-info',
                iconColor = ''
            },
            ttd = {
                title = 'Time To Delivery (TTD)',
                description = 'Time remaining until upgrade is complete:',
                icon = 'fas fa-rotate',
                iconColor = '',
                iconAnimation = 'spin',
                -- Colors also accept HTML Colors
                colors = { red = 'red', yellow = 'yellow', green = 'green' }
            }
        },
        operations = {
            title = 'Manage Operations',
            description = 'View & manage your facility\'s operations',
            icon = 'fas fa-bars-progress',
            iconColor = '',
        },
        security = {
            title = 'Manage Security',
            description = 'Manage your facility\'s security operations',
            icon = 'fas fa-shield-halved',
            iconColor = ''
        },
        upgrades = {
            -- Title, description, icon & iconColor are handled via config.lua
            meta = {
                price = { label = 'Price', value = '$' },
                ttd = { label = 'TTD', abb = { hours = 'H', mins = 'M', ltm = '< 1M'} }
            }
        },
        transfer = {
            title = 'Transfer Ownership',
            description = 'Transfer the ownership of your warehouse',
            icon = 'fas fa-right-left',
            iconColor = ''
        },
        sell = {
            title = 'Sell Warehouse to State',
            description = 'Sell your warehouse back to the State if desired',
            icon = 'fas fa-sack-dollar',
            iconColor = ''
        },
        level = {
            title = 'Cooking | Level %s/%s',
            description = 'You currently have %sXP',
            icon = 'fas fa-chart-simple',
            iconColor = '',
            metadata = {
                nextLevel = 'Next Level',
                remainder = 'Remainder',
                efficiency = 'Efficiency Bonus',
                maxed = 'Maxed Level Reached'
            }
        },
        stats = {
            main = {
                title = 'Lifetime Statistics',
                description = 'View your lifetime cooking stats',
                icon = 'fas fa-chart-pie',
                iconColor = ''
            },
            title = 'Lifetime Statistics',
            produced = {
                title = 'Produced',
                description = 'You\'ve produced a total of %s bags of meth',
                icon = 'fas fa-snowflake',
                iconColor = ''
            },
            supply = {
                title = 'Supply Runs',
                description = 'You\'ve completed a total of %s supply runs',
                icon = 'fas fa-person-running',
                iconColor = ''
            }
        },
        -- Colors also accept HTML Colors
        colors = { red = 'red', yellow = 'yellow', green = 'green' }
    },
    table = {
        title = 'Meth Table',
        steps = {
            mainTitle = 'Cooking',
            subTitle = 'Step',
            create = {
                title = 'Create Base',
                description = 'Establish a base of crushed pseudoephedrine'
            },
            mix = {
                title = 'Mix Chemicals',
                description = 'Mix base with ammonia, iodine and acetone'
            },
            heat = {
                title = 'Heat Mixture',
                description = 'Start heating the mixture to the perfect temperature'
            },
            acid = {
                title = 'Add Acid',
                description = 'Add hydrochloric acid to the heated mixture'
            },
            pour = {
                title = 'Pour & Cool',
                description = 'Pour mixture into tray and let it cool until hardened'
            },
            breakdown = {
                title = 'Break Down',
                description = 'Break down the sheet into finer crystals'
            },
            icons = { complete = 'fas fa-check', incomplete = 'fas fa-x' },
            iconColors = { complete = '', incomplete = '#FF5555' }
        },
        stats = {
            title = 'Lifetime Statistics',
            produced = {
                title = 'Produced',
                description = 'You\'ve produced a total of %s bags of meth',
                icon = 'fas fa-snowflake',
                iconColor = ''
            },
            supply = {
                title = 'Supply Runs',
                description = 'You\'ve completed a total of %s supply runs',
                icon = 'fas fa-person-running',
                iconColor = ''
            }
        },
        main = {
            level = {
                title = 'Cooking | Level %s/%s',
                description = 'You currently have %sXP',
                icon = 'fas fa-chart-simple',
                iconColor = '',
                metadata = {
                    nextLevel = 'Next Level',
                    remainder = 'Remainder',
                    efficiency = 'Efficiency Bonus',
                    maxed = 'Maxed Level Reached'
                }
            },
            stats = {
                title = 'Lifetime Statistics',
                description = 'View your lifetime cooking stats',
                icon = 'fas fa-chart-pie',
                iconColor = ''
            },
            status = {
                title = 'Current Status',
                heating = {
                    description = 'A batch of meth is currently being heated..',
                    icon = 'fas fa-rotate',
                    iconColor = '',
                    iconAnimation = 'spin',
                },
                cooling = {
                    description = 'A batch of meth is currently being cooled..',
                    icon = 'fas fa-rotate',
                    iconColor = '',
                    iconAnimation = 'spin',
                },
                inactive = {
                    description = 'Nothing is currently happening here',
                    icon = 'fas fa-pause',
                    iconColor = '',
                    iconAnimation = '',
                },
            },
            start = {
                title = 'Start Cooking',
                description = 'Begin producing a batch of meth',
                icon = 'fas fa-circle-play',
                iconColor = '#74F37C'
            },
            packup = {
                title = 'Pack Up',
                description = 'Pack everything up and move this table',
                icon = 'fas fa-dolly',
                iconColor = '#FF5555'
            },
            -- Colors also accept HTML Colors
            colors = { red = 'red', yellow = 'yellow', green = 'green' }
        }
    }
}

Strings.Target = { -- These strings are also used for "interact" labels
    table = {
        label = 'Use',
        icon = 'fas fa-flask',
        dist = 1.5
    },
    warehouse = {
        enter = {
            name = 'enter',
            label = 'Enter',
            icon = 'fas fa-right-to-bracket',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        exit = {
            name = 'exit',
            label = 'Exit',
            icon = 'fas fa-right-from-bracket',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        manage = {
            name = 'manage',
            label = 'Manage Facility',
            icon = 'fas fa-gears',
            iconColor = '',
            radius = 0.35,
            dist = 2.0
        },
        stash = {
            name = 'stash',
            label = 'Open Stash',
            icon = 'fas fa-box',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        confiscate = {
            name = 'confiscate',
            label = 'Confiscate Equipment',
            icon = 'fas fa-shield-halved',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        addsupply = {
            name = 'addsupply',
            label = 'Add Supplies',
            icon = 'fas fa-flask',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        inputs = {
            name = 'inputs',
            label = 'Set Values',
            icon = 'fas fa-gears',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        temp = {
            name = 'temp',
            label = 'Set Temp',
            icon = 'fas fa-temperature-half',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        break_down = {
            name = 'break_down',
            label = 'Break Down',
            icon = 'fas fa-hammer',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        },
        bagging = {
            name = 'bagging',
            label = 'Start Bagging',
            icon = 'fas fa-weight-scale',
            iconColor = '',
            radius = 1.0,
            dist = 2.0
        }
    },
    shop = {
        label = 'Talk',
        icon = 'fas fa-comment',
        dist = 2.0
    },
    mission = {
        label = 'Talk',
        icon = 'fas fa-comment',
        dist = 2.0
    },
    supplies = {
        start = {
            label = 'Talk',
            icon = 'fas fa-comment',
            dist = 2.0
        },
        collect = {
            label = 'Collect',
            icon = 'fas fa-box',
            dist = 2.0
        }
    }
}

Strings.TextUI = {
    table = { label = '**Meth Table**  \n E - Use', icon = 'fas fa-flask' },
    warehouse = {
        enter = { label = '**Warehouse**  \n E - Enter', icon = 'fas fa-right-to-bracket' },
        exit = { label = '**Warehouse**  \n E - Exit', icon = 'fas fa-right-from-bracket' },
        manage = { label = '**Warehouse**  \n E - Manage', icon = 'fas fa-gears' },
        stash = { label = '**Stash**  \n E - Open', icon = 'fas fa-box' },
        confiscate = { label = '**Police**  \n E - Confiscate Equipment', icon = 'fas fa-shield-halved' },
        addsupply = { label = '**Supply Tank**  \n E - Add Supplies', icon = 'fas fa-flask' },
        inputs = { label = '**Input Panel**  \n E - Set Values', icon = 'fas fa-gears' },
        temp = { label = '**Temperature**  \n E - Set Temp', icon = 'fas fa-temperature-half', },
        break_down = { label = '**Break Down**  \n E - Start', icon = 'fas fa-hammer' },
        bagging = { label = '**Bagging**  \n E - Start', icon = 'fas fa-weight-scale' }
    },
    controls = {
        table = {
            label = '**Controls**  \n **Q**: Rotate Left  \n **E**: Rotate Right  \n **W**: Move Forward  \n **S**: Move Backward  \n **A**: Move Left  \n **D**: Move Right  \n **X**: Cancel  \n **Space**: Confirm',
            icon = 'fas fa-hand'
        },
        camera = {
            label = '**Controls**  \n **W**: Rotate Up  \n **A**: Rotate Left  \n **S**: Rotate Down  \n **D**: Rotate Right  \n **Q**: Zoom Out  \n **E**: Zoom In  \n **Backspace**: Exit',
            icon = 'fas fa-video'
        }
    },
    shop = {
        label = '**Benjamin**  \n E - Talk',
        icon = 'fas fa-comment'
    },
    mission = {
        label = '**James**  \n E - Talk',
        icon = 'fas fa-comment'
    },
    supplies = {
        start = {
            label = '**William**  \n E - Talk',
            icon = 'fas fa-comment'
        },
        collect = {
            label = '**Supplier**  \n E - Collect',
            icon = 'fas fa-hand'
        }
    }
}

Strings.Input = {
    mixing = {
        title = 'Ingredient Quantities',
        ammonia = 'Ammonia',
        iodine = 'Iodine',
        acetone = 'Acetone'
    },
    heating = {
        title = 'Heat Mixture',
        label = 'Temperature (c)',
    },
    createPin = {
        title = 'Create Passcode',
        data = {
            type = 'number',
            label = 'Create Pin',
            description = 'Create your numerical passcode below',
            icon = 'key',
            required = true
        }
    },
    resetPin = {
        title = 'Reset Passcode',
        data = {
            type = 'number',
            label = 'Reset Pin',
            description = 'Create your new numerical passcode below',
            icon = 'key',
            required = true
        }
    },
    inputPin = {
        title = 'Stash Passcode',
        data = {
            type = 'number',
            label = 'Input Pin',
            description = 'A pin is required to access this stash',
            icon = 'key',
            required = true
        }
    },
    confirm = {
        title = 'Confirm Transfer',
        data = {
            type = 'input',
            label = 'Are you sure?',
            description = 'Transferring ownership is irreversible - type "' ..Config.WarehouseSettings.transfer.. '" in the box below to continue',
            icon = 'quote-left',
            required = true
        }
    },
    transfer = {
        title = 'Transfer To',
        data = {
            type = 'number',
            label = 'Player ID',
            description = 'Input the player ID you want to transfer too',
            icon = 'fas fa-user',
            required = true
        }
    },
    sell = {
        title = 'Confirm Sale',
        data = {
            type = 'input',
            label = 'Are you sure?',
            description = 'Selling your warehouse is irreversible and your stash(es) will be emptied - type "' ..Config.WarehouseSettings.selling.sell.. '" in the box below to continue',
            icon = 'fas fa-user',
            required = true
        }
    },
    add_user = {
        title = 'Add User',
        data = {
            type = 'number',
            label = 'Player ID',
            description = 'Input the player ID you want to give access',
            icon = 'fas fa-user',
            required = true
        }
    },
    confiscate = {
        title = 'Police Actions',
        manufacturing = 'Confiscate Manufacturing Equipment',
        security = 'Confiscate Security Equipment'
    },
    addsupply = {
        title = 'Refill Supply Tank',
        ammonia = { label = 'Ammonia', desc = 'Current ammonia level: %d%% | %d%% until full', icon = 'fas fa-fill-drip' },
        iodine = { label = 'Iodine', desc = 'Current iodine level: %d%% | %d%% until full', icon = 'fas fa-fill-drip' },
        acetone = { label = 'Acetone', desc = 'Current acetone level: %d%% | %d%% until full', icon = 'fas fa-fill-drip' }
    }
}

Strings.Alert = {
    pickup = {
        header = '**Confirm Action**',
        content = 'Are you sure you want to pack up the table? You will destroy and lose any progress made on this table!',
        centered = true,
        cancel = true
    },
    confirmRaid = {
        header = '**Confirm Raid**',
        content = 'You are about to break into a citizen\'s property, are you sure you want to proceed?',
        centered = true,
        cancel = true
    },
    confirmRaidStash = {
        header = '**Confirm Raid**',
        content = 'You are about to begin breaking into this stash, are you sure you want to proceed?',
        centered = true,
        cancel = true
    },
    mission = {
        require = {
            header = '**James**',
            content = 'Who the f.. OH, it\'s you. I heard you were coming. I need x%s %s before I can give this to you.. do you got that for me?',
            centered = true,
            labels = { confirm = 'Yes', cancel = 'No' }
        },
        notRequire = {
            hasTable = {
                header = '**James**',
                content = 'I already gave you it! If at some point you need another I\'m here.. but use what you got first.',
                centered = true,
                cancel = false,
                labels = { confirm = 'Thanks' }
            },
            noTable = {
                header = '**James**',
                content = 'Who the f.. OH, it\'s you. I heard you were coming. Here, I got the shit you wanted..',
                centered = true,
                cancel = false,
                labels = { confirm = 'Thanks' }
            }
        }
    },
    supplies = {
        start = {
            require = {
                header = '**William**',
                content = 'I got connects all around the area with the stuff you need.. but this access don\'t come free. You got x%s %s for me?',
                centered = true,
                cancel = true,
                labels = { confirm = 'Yes', cancel = 'No' }
            },
            notRequire = {
                header = '**William**',
                content = 'I got connects all around the area with the stuff you need.. I\'ll let you know where you can find them!',
                centered = true,
                cancel = false,
                labels = { confirm = 'Thanks' }
            },
        },
        continue = {
            header = '**Supply Run**',
            content = 'Would you like to continue your supply runs?',
            centered = true,
            cancel = true,
            labels = { confirm = 'Yes', cancel = 'No' }
        }
    },
    power = {
        on = {
            header = '**Confirm Power On**',
            content = 'Are you sure you want to proceed with your current ingredient and temperature values?',
            centered = true,
            cancel = true,
            labels = { confirm = 'Yes', cancel = 'No' }
        },
        off = {
            header = '**Confirm Power Off**',
            content = 'You will immediately lose any & all progress made during your current production run.. are you sure you want to continue?',
            centered = true,
            cancel = true,
            labels = { confirm = 'Yes', cancel = 'No' }
        }
    }
}

Strings.Dispatch = {
    toxic_smell = {
        title = 'Suspicious Area',
        code = '10-87',
        message = 'An anonymous caller has reported a strong toxic odor in the area near %s',
        blip = {
            sprite = 310,
            scale = 1.0,
            colour = 1,
            radius = 100,
        }
    },
    power_surge = {
        title = 'Power Surge',
        code = '10-25',
        message = 'Citizens have reported an unusual power surge in the area near %s',
        blip = {
            sprite = 354,
            scale = 1.0,
            colour = 5,
            radius = 100
        }
    }
}

Strings.Logs = {
    table_received = {
        title = 'Table Received',
        message = '%s (identifier: %s) has received/purchased a new table'
    },
    table_placed = {
        title = 'Table Placed',
        message = '%s (identifier: %s) has placed a table (id: %s) at %s',
    },
    table_removed = {
        title = 'Table Removed',
        message = '%s (identifier: %s) has packed up a table (id: %s)',
    },
    table_batch = {
        title = 'Batch Completed (table)',
        message = '%s (identifier: %s) has produced a batch of x%s %s (purity: %s) meth (id: %s)',
    },
    supply_run_completed = {
        title = 'Supply Run Completed',
        message = '%s (identifier: %s) has completed a supply run and received x1 %s'
    },
    supply_crate_opened = {
        title = 'Supply Crate Opened',
        message = '%s (identifier: %s) has opened a supply crate and received x%s %s'
    },
    warehouse_buy = {
        title = 'Warehouse Purchased',
        message = '%s (identifier: %s) has purchased a warehouse (id: %s) for $%s'
    },
    warehouse_upgrade = {
        title = 'Warehouse Upgraded',
        message = 'Warehouse (id: %s) has completed upgrading its %s to "%s"'
    },
    warehouse_door = {
        title = 'Warehouse Door Status',
        message = '%s (identifier: %s) has %s their warehouse (id: %s) door',
        locked = 'locked',
        unlocked = 'unlocked'
    },
    warehouse_transfer = {
        title = 'Warehouse Transfer',
        message = '%s (identifier: %s) has transferred ownership of their warehouse (id: %s) to %s (identifier: %s)'
    },
    warehouse_sale = {
        title = 'Warehouse Sold',
        message = '%s (identifier: %s) has sold their warehouse (id: %s) back to the State for $%s'
    },
    warehouse_batch = {
        title = 'Batch Complete (warehouse)',
        message = '%s (identifier: %s) has produced a batch of x%s %s (purity: %s) meth (id: %s)',
    },
    raid_warehouse = {
        title = 'Warehouse Raided',
        message = 'LEO %s (identifier: %s) has broken into a warehouse (id: %s)'
    },
    raid_stash = {
        title = 'Stash Raided',
        message = 'LEO %s (identifier: %s) has broken into a stash in a warehouse (id: %s)'
    }
}