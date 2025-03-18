Strings = {}

Strings.Symbols = {
    dollar = '$',
    quantity = 'x',
    each = 'each',
    plus = '+'
}

Strings.Notify = {
    rejects = {
        'Are you kidding?! Get away from me',
        'I\'m calling the cops on you, dirtbag!',
        'People like you are the problem with this city.. goodbye',
        'Do I look like a criminal to you?',
        'Beat it, punk!',
        'I don\'t do business with lowlifes!',
        'Get lost before I make you regret it!',
        'You must be out of your mind!',
        'I have no interest in your shady deals.',
        'You\'re barking up the wrong tree, pal!',
        'I don\'t want this junk, scram!',
        'Save your breath, I\'m not interested!',
        'I don\'t want any part of this!',
        'Do I have a sign that says "druggie" on my forehead?',
        'This conversation is over!',
        'Don\'t ever approach me with that nonsense again!',
        'You\'ve got the wrong person, get out of here!'
        -- Add or remove rejection messages here
    },
    robbed = 'The buyer took your drugs without paying, get them back!',
    escaped = 'The thief got away with all your drugs..',
    daytime = 'Doesn\'t seem wise to sell drugs in broad daylight here..',
    police = 'There are not enough Police on duty to do this right now..',
    ignoreModel = 'The buyer completely ignores you',
    cooldown = 'You cannot sell this often - try again later',
    limit = 'This spot is getting hot.. you should go somewhere else',
    levelUp = 'Congratulations, you\'ve leveled up!',
    noVehicle = 'You cannot sell from inside your vehicle'
}

Strings.TextUI = {
    selling = {
        label = '**Sell Drugs**  \n E - Open Menu',
        icon = 'fas fa-capsules'
    },
    robbed = {
        label = '**Claim Drugs**  \n E - Take Back',
        icon = 'fas fa-capsules'
    }
}

Strings.Target = {
    selling = {
        label = 'Sell drugs',
        icon = 'fas fa-capsules',
        color = '',
        dist = 3.0
    },
    robbed = {
        label = 'Take drugs',
        icon = 'fas fa-capsules',
        color = '',
        dist = 3.0
    }
}

Strings.Menu = {
    selling = {
        title = 'Drug Sales',
        drugs = {
            desc = 'You currently have ',
            meta = {
                each = 'Buyer will buy for',
                risk = 'Risk bonus',
                rep = 'Rep. bonus',
                quantity = 'Buyer wants a total of',
                total = 'Total sale is worth',
            }
        },
        rep = {
            title = 'Reputation | Level ',
            -- Description found in Config.Reputation.levels
            icon = 'fas fa-chart-line',
            iconColor = '',
            meta = {
                currentRep = 'Current Rep',
                repUntilLevel = 'Rep. Until Level Up'
            }
        },
        stats = {
            title = 'Your Stats',
            desc = 'View your all time statistics',
            icon = 'fas fa-chart-simple',
            iconColor = ''
        },
        cancel = {
            title = 'Nevermind',
            desc = 'Cancel the drug sale with this buyer',
            icon = 'fas fa-delete-left',
            iconColor = '#FF4444'
        },
    },
    stats = {
        title = 'Your Statistics',
        sales = {
            title = 'Total Sales',
            desc = 'You\'ve sold a total of ',
            desc2 = ' drugs',
            icon = 'fas fa-capsules',
            iconColor = ''
        },
        earned = {
            title = 'Money Earned',
            desc = 'You\'ve made a total of $',
            icon = 'fas fa-money-bill-wave',
            iconColor = ''
        }
    }
}

Strings.Logs = {
    selling = {
        title = 'Drug Sale Complete',
        message = '%s (identifier: %s) successfully sold x%s %s for $%s'
    },
    robbed = {
        title = 'Player Robbed',
        message = '%s (identifier: %s) was just robbed of x%s %s'
    },
    claimed = {
        title = 'Items Claimed',
        message = '%s (identifier: %s) has just recovered all their items'
    },
    leveled = {
        title = 'Player Leveled Up',
        message = '%s (identifier: %s) has just leveled up to level %s'
    }
}