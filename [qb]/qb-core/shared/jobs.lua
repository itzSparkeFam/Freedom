QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	unemployed = { label = 'Civilian', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 250 } } },
	bus = { label = 'Bus', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	judge = { label = 'Honorary', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Judge', payment = 100 } } },
	lawyer = { label = 'Law Firm', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Associate', payment = 50 } } },
	reporter = { label = 'Reporter', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Journalist', payment = 50 } } },
	trucker = { label = 'Trucker', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	tow = { label = 'Towing', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	garbage = { label = 'Garbage', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Collector', payment = 50 } } },
	vineyard = { label = 'Vineyard', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Picker', payment = 50 } } },
	hotdog = { label = 'Hotdog', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Sales', payment = 50 } } },

	police = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Cadet', payment = 1000 },
			['1'] = { name = 'Probationary Officer', payment = 1500 },
			['2'] = { name = 'Officer', payment = 2400 },
			['3'] = { name = 'Senior Officer', payment = 2450 },
			['4'] = { name = 'Corporal', payment = 2500 },
			['5'] = { name = 'Sergeant', payment = 2550 },
			['6'] = { name = 'Lieutenant', payment = 2600 },
			['7'] = { name = 'Relations Officer', payment = 2650 },
			['8'] = { name = 'Commander', payment = 2700 },
			['9'] = { name = 'Assistant Chief', payment = 2750 },
			['10'] = { name = 'Chief of Staff', isboss = true, payment = 2800 },
			['11'] = { name = 'Chief of Police', isboss = true, payment = 3000 },
		},
	},
	sheriff = {
		label = 'Sheriff',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Cadet', payment = 1000 },
			['1'] = { name = 'Probationary Deputy', payment = 1500 },
			['2'] = { name = 'Deputy', payment = 2400 },
			['3'] = { name = 'Corporal', payment = 2500 },
			['4'] = { name = 'Sergeant', payment = 2550 },
			['5'] = { name = 'Lieutenant', payment = 2600 },
			['6'] = { name = 'Relations Officer', payment = 2650 },
			['7'] = { name = 'Captain', payment = 2700 },
			['8'] = { name = 'Chief Deputy', isboss = true, payment = 2800 },
			['9'] = { name = 'Sheriff', isboss = true, payment = 3000 },
		},
	},
	ambulance = {
		label = 'EMS',
		type = 'ems',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 1000 },
			['1'] = { name = 'EMT', payment = 1500 },
			['2'] = { name = 'Paramedic', payment = 2000 },
			['3'] = { name = 'Lead Paramedic', payment = 2500 },
			['4'] = { name = 'Doctor', payment = 3000 },
			['5'] = { name = 'Surgeon', payment = 3500 },
			['6'] = { name = 'Lead Surgeon', payment = 4000 },
			['7'] = { name = 'Lieutenant', payment = 3000 },
			['8'] = { name = 'Captain', payment = 3500 },
			['9'] = { name = 'Deputy Chief', isboss = true, payment = 4500 },
			['10'] = { name = 'Chief', isboss = true, payment = 5000 },
		},
	},
	['firefighter'] = {
		label = 'Firefighter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = {
				name = 'Candidate',
				payment = 1000
			},
			['1'] = {
				name = 'Junior Firefighter',
				payment = 1500
			},
			['2'] = {
				name = 'Senior Firefighter',
				payment = 2000
		    },
		    ['3'] = {
			    name = 'Lieutenant',
			    payment = 3000
		    },
			['4'] = {
				name = 'Captain',
				payment = 3500
			},
			['5'] = {
				name = 'Assistant Chief',
				payment = 4500
			},
			['6'] = {
				name = 'Chief',
				isboss = true, 
				bankAuth = true,
				payment = 5000
			},
		},
	},
	['cannabiscafe'] = {
        label = 'Cookies',
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Farmer',
                payment = 500
            },
            ['1'] = {
                name = 'Shopkeeper',
                payment = 600
            },
            ['2'] = {
                name = 'Manager',
                payment = 700
            },
            ['3'] = {
                name = 'Owner',
                payment = 800,
                isboss = true,
            },
        },
    },
	['realestate'] = {
        label = 'Realestate',
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Rookie',
                payment = 200
            },
            ['1'] = {
                name = 'Seller',
                payment = 400
            },
            ['2'] = {
                name = 'Manager',
                payment = 600
            },
            ['3'] = {
                name = 'Boss',
                payment = 800,
                isboss = true,
            },
        },
    },
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 200 },
			['1'] = { name = 'Driver', payment = 400 },
			['2'] = { name = 'Event Driver', payment = 500 },
			['3'] = { name = 'Sales', payment = 600 },
			['4'] = { name = 'Manager', isboss = true, payment = 700 },
		},
	},
	cardealer = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 450 },
			['1'] = { name = 'Showroom Sales', payment = 550 },
			['2'] = { name = 'Business Sales', payment = 650 },
			['3'] = { name = 'Finance', payment = 750 },
			['4'] = { name = 'Manager', isboss = true, payment = 800 },
		},
	},
	['mechanic1'] = {
		label = 'Red Line Performance',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = {
				name = 'Trainee',
				payment = 1500
			},
			['1'] = {
				name = 'Mechanic',
				payment = 2000
			},
			['2'] = {
				name = 'Manager',
				payment = 2500
			},
			['3'] = {
				name = 'Boss',
			isboss = true,
				payment = 3000
			},
		},
	},
	mechanic2 = {
		label = 'Hayes Mechanic',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 1500 },
			['1'] = { name = 'Novice', payment = 2000 },
			['2'] = { name = 'Experienced', payment = 2500 },
			['3'] = { name = 'Advanced', payment = 3000 },
			['4'] = { name = 'Owner', isboss = true, payment = 4000 },
		},
	},
	rideout = {
		label = 'Rideout Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 250 },
			['1'] = { name = 'Mechanic', payment = 500 },
			['2'] = { name = 'Mechanic2', payment = 750 },
			['3'] = { name = 'Supervisor', payment = 1000 },
			['4'] = { name = 'Manager', isboss = true, payment = 1500 },
			['5'] = { name = 'Co Owner', isboss = true, payment = 2000 },
			['6'] = { name = 'CEO', isboss = true, payment = 2000 },
		},
	},
	crusincraftsmen = {
		label = 'Crusin Craftsmen',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Receptionist', payment = 500 },
			['1'] = { name = 'Mechanic', payment = 750 },
			['2'] = { name = 'Head Mechanic', payment = 950 },
			['3'] = { name = 'Shop Foreman', payment = 1250 },
			['4'] = { name = 'Asst Manager', payment = 2500 },
			['5'] = { name = 'Manager', isboss = true, payment = 3800 },
			['6'] = { name = 'Owner', isboss = true, payment = 4000 },
		},
	},
	club77 = {
		label = 'Club77 Nightclub',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
			['0'] = { name = 'Helper', payment = 50 },
			['1'] = { name = 'Bartender', payment = 75 },
			['2'] = { name = 'Dancer', payment = 100 },
			['3'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	['catcafe'] = {
		label = 'Cat Cafe',
		defaultDuty = true,
		grades = {
			['0'] = { name = 'Kitten in Training', payment = 800 },
			['1'] = { name = 'Kitten', payment = 1000 },
			['2'] = { name = 'Cat', payment = 1500 },
			['3'] = { name = 'Big Cat', payment = 2500 },
			['4'] = { name = 'Owner', isboss = true, payment = 3000 },
		},
	},
	['pizzathis'] = {
		label = 'Pizza This',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 800 },
			['1'] = { name = 'Novice', payment = 1000 },
			['2'] = { name = 'Experienced', payment = 1500},
			['3'] = { name = 'Advanced', payment = 2500 },
			['4'] = { name = 'Manager', isboss = true, payment = 3000 },
        },
	},

	['limeys'] = {
		label = 'Limey\'s Juice Shop',
		defaultDuty = true,
		grades = {
			['0'] = { name = 'Trainee', payment = 300 },
			['1'] = { name = 'Worker', payment = 400 },
			['2'] = { name = 'Experienced', payment = 500 },
			['3'] = { name = 'Manager', payment = 600 },
			['4'] = { name = 'Owner', isboss = true, payment = 800 },
		},
	},
	burgershot = {
		label = 'BurgerShot',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 2000 },
			['1'] = { name = 'Novice', payment = 2500 },
			['2'] = { name = 'Experienced', payment = 3000 },
			['3'] = { name = 'Advanced', payment = 3500 },
			['4'] = { name = 'Manager', isboss = true, payment = 4000 },
        },
	},
	['upnatom'] = {
		label = "Up n Atom",
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 800 },
			['1'] = { name = 'Novice', payment = 1000 },
			['2'] = { name = 'Experienced', payment = 1200 },
			['3'] = { name = 'Advanced', payment = 1500 },
			['4'] = { name = 'Manager', isboss = true, payment = 2000 },
        },
	},
	['hornys'] = {
		label = "Horny's",
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 800 },
			['1'] = { name = 'Novice', payment = 1000 },
			['2'] = { name = 'Experienced', payment = 1200 },
			['3'] = { name = 'Advanced', payment = 1500 },
			['4'] = { name = 'Manager', isboss = true, payment = 2000 },
        },
	},
	['bahama'] = {
		label = 'Bahama Mamas',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 300 },
			['1'] = { name = 'Bar Staff', payment = 400 },
			['2'] = { name = 'Dancer', payment = 500 },
			['3'] = { name = 'Manager', isboss = true, payment = 600 },
			['4'] = { name = 'Owner', isboss = true, payment = 800 },
		},
}, 
['pearls'] = {
    label = "Pearls",
    defaultDuty = true,
    grades = {
        ['0'] = {
            name = 'Waiter',
            payment = 1000
        },
        ['1'] = {
            name = 'Delivery Driver',
            payment = 1500
        },
        ['2'] = {
            name = 'Cook',
            payment = 2000
        },
        ['3'] = {
            name = 'Manager',
            payment = 2500
        },
        ['4'] = {
            name = 'Owner',
            payment = 3000,
            isboss = true,
        },
    },
},
['beanmachine'] = {
	label = 'Bean Machine',
	defaultDuty = true,
	grades = {
		['0'] = { name = 'Recruit', payment = 800 },
		['1'] = { name = 'Novice', payment = 1000 },
		['2'] = { name = 'Experienced', payment = 1500 },
		['3'] = { name = 'Advanced', payment = 2500 },
		['4'] = { name = 'Manager', isboss = true, payment = 3000 },
	},
},

	['whitewidow'] = {
		label = 'White Widow',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = {
				name = 'Trainee',
				payment = 300
			},
			['1'] = {
				name = 'Deliveries',
				payment = 300
			},
			['2'] = {
				name = 'Sales',
				payment = 300
			},
			['3'] = {
				name = 'Grower',
				payment = 400
			},
			['4'] = {
				name = 'Assistant Manager',
				payment = 500
			},
			['5'] = {
				name = 'Manager',
				isboss = true,
				payment = 600
			},
			['6'] = {
				name = 'Owner',
				isboss = true,
				payment = 800
			},
		},
	},
	['chihotdog'] = {
        label = 'Chihuahua Hotdogs',
        defaultDuty = false,
        offDutyPay = true,
        grades = {
            ['0'] = { name = 'Recruit', payment = 300 },
            ['1'] = { name = 'Line Cook', payment = 400 },
            ['2'] = { name = 'Experienced', payment = 500 },
            ['3'] = { name = 'Manager', payment = 600 },
            ['4'] = { name = 'Owner', isboss=true, payment = 800 },
		},
	},
	['cookies'] = {
		label = "Cookies",
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 800 },
			['1'] = { name = 'Grower', payment = 1000 },
			['2'] = { name = 'Sales', payment = 1100 },
			['3'] = { name = 'Manager', payment = 1200 },
			['4'] = { name = 'Owner', isboss = true, payment = 1200 },
        },
	},
}


            -- Jobs Creator integration (jobs_creator)
            RegisterNetEvent("jobs_creator:injectJobs", function(jobs)
                QBShared.Jobs = jobs
            end)
        