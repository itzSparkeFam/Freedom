return {


	--// Police Stashes
	{
		coords = vec3(452.3, -991.4, 30.7),
		target = {
			loc = vec3(451.25, -994.28, 30.69),
			length = 1.2,
			width = 5.6,
			heading = 0,
			minZ = 29.49,
			maxZ = 32.09,
			label = 'Open personal locker'
		},
		name = 'policelocker',
		label = 'Personal locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = shared.police
	},


	--// EMS Stashes
	{
		coords = vec3(301.3, -600.23, 43.28),
		target = {
			loc = vec3(301.82, -600.99, 43.29),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open personal locker'
		},
		name = 'emslocker',
		label = 'Personal Locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = {['ambulance'] = 0}
	},


	--// Cluckin Bell Stashes
	{
		coords = vector3(-152.522, -277.998, 43.419),
		target = {
			loc = vector3(-152.522, -277.998, 43.419),
			length = 0.6,
			width = 1.8,
			heading = 322.82,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Storage'
		},
		name = 'cluckinbell1',
		label = 'Storage',
		owner = false,
		slots = 70,
		weight = 1000000,
		groups = {['cluckinbell'] = 1}
	},
	{
		coords = vector3(-157.356, -276.952, 43.599),
		target = {
			loc = vector3(-157.356, -276.952, 43.599),
			length = 0.6,
			width = 1.8,
			heading = 336.54,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Storage'
		},
		name = 'cluckinbell2',
		label = 'Storage',
		owner = false,
		slots = 70,
		weight = 1000000,
		groups = {['cluckinbell'] = 1}
	},
	{
		coords = vector3(-158.41, -274.859, 43.599),
		target = {
			loc = vector3(-158.41, -274.859, 43.599),
			length = 0.6,
			width = 1.8,
			heading = 246.54,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Storage'
		},
		name = 'cluckinbell2',
		label = 'Storage',
		owner = false,
		slots = 70,
		weight = 1000000,
		groups = {['cluckinbell'] = 1}
	},
	{
		coords = vector3(-152.386, -268.739, 43.299),
		target = {
			loc = vector3(-152.386, -268.739, 43.299),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Food Warmer'
		},
		name = 'cluckinbell2',
		label = 'Food Warmer',
		owner = false,
		slots = 100,
		weight = 1000000,
		groups = {['cluckinbell'] = 1}
	},


	--// Bennys Stashes
	{
		coords = vector3(-929.057, -2050.563, 8.100),
		target = {
			loc = vector3(-929.057, -2050.563, 8.100),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bennys1',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bennys'] = 1}
	},
	{
		coords = vector3(-935.706, -2053.427, 8.100),
		target = {
			loc = vector3(-935.706, -2053.427, 8.100),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bennys2',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bennys'] = 1}
	},
	{
		coords = vector3(-957.37, -2025.174, 8.100),
		target = {
			loc = vector3(-957.37, -2025.174, 8.100),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bennys3',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bennys'] = 1}
	},
	{
		coords = vector3(-961.677, -2034.637, 8.100),
		target = {
			loc = vector3(-961.677, -2034.637, 8.100),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bennys4',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bennys'] = 1}
	},
	{
		coords = vector3(-971.652, -2044.27, 8.100),
		target = {
			loc = vector3(-971.652, -2044.27, 8.100),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bennys5',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bennys'] = 1}
	},
	{
		coords = vector3(-934.721, -2035.316, 8.100),
		target = {
			loc = vector3(-934.721, -2035.316, 8.100),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Main Parts Storage'
		},
		name = 'bennys6',
		label = 'Main Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bennys'] = 1}
	},



	--// Bayside Mechanic Stashes
	----// Bay 2 Big Toolbox
	{
		coords = vector3(75.55, 6535.854, 31.2),
		target = {
			loc = vector3(75.55, 6535.854, 31.2),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bayside1',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bayside'] = 1}
	},
	--//Tires Stash
	{
		coords = vector3(79.878, 6531.524, 31.2),
		target = {
			loc = vector3(79.878, 6531.524, 31.2),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bayside2',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bayside'] = 1}
	},
	{
		coords = vector3(91.07, 6525.943, 33.96),
		target = {
			loc = vector3(91.07, 6525.943, 33.96),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bayside3',
		label = 'Boss Stash',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bayside'] = 4}
	},
	{
		coords = vector3(79.625, 6531.426, 31.38),
		target = {
			loc = vector3(79.625, 6531.426, 31.38),
			length = 0.6,
			width = 1.8,
			heading = 337.02,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Open Parts Storage'
		},
		name = 'bayside4',
		label = 'Parts Storage',
		owner = false,
		slots = 100,
		weight = 10000000,
		groups = {['bayside'] = 4}
	},
}
