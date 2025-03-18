# Pug Chopping.
For any questions please contact me here: here https://discord.gg/jYZuWYjfvq.
For any of my other scripts you can purchase here: https://pug-webstore.tebex.io/category/custom-scripts

# If you are a QBCore framework the script is basically drag and drop with a few small changes to the config and running the sql.
# Esx will as well be mostly drag and drop with config changes.

# Installation (ALL FRAMEWORKS)
Run the pug-criminals.sql before doing anything else.
Add the item pngs found in pug-chopping/itemPNGS to your inventory.
Make sure you have the dependencies installed. (Polyzone, qb-menu OR ox_lib, qb-target OR ox_target, ps-inventory OR ox_inventory)
Thouroughly read the config and adjust to you liking. (VERY IMPORTANT)
Adjust the CallPoliceForCarJack() function in open.lua to fit your server (defualt is already setup for ps-dispatch).
Adjust the ChoppingNotify() function in open.lua to fit your server (defualt is already setup for qb-core).
Adjust the ChoppingEmail() function in open.lua to fit your server (defualt is already setup for qb-phone).
Adjust the DrawTextChopping() and HideDrawTextChopping() functions in open.lua to fit your server (defualt is already setup for qb-core).
For QBCore framework the default minigame used in the "Pug:client:CustomRemoveTrackerEvent" event in open.lua uses ps-ui minigame to remove the tracker. (make sure to change this if you like)
Make sure to change the mini game events for the arcade machines at the bottom of open.lua if you are not using ps-ui (esx must change the events or remove the arcade machine from the config.)


--
# Removing trakcer item
If you want to use a different item name make sure to change the useableitem name at the bottom of the server.lua
# QBCore ONLY - Install this in to your qb-core/shared/items.lua
['chop_wheel'] 			     = {['name'] = 'chop_wheel', 					['label'] = 'Car Wheel', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'chop_wheel.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,  ["created"] = nil, ["decay"] = 30.0,   ['description'] = 'A wheel from a vehicle'},
['chop_door'] 			     = {['name'] = 'chop_door', 					['label'] = 'Car Door', 				['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'chop_door.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,  ["created"] = nil, ["decay"] = 30.0,   ['description'] = 'A door from a vehicle'},
['chop_hood'] 			     = {['name'] = 'chop_hood', 					['label'] = 'Car Hood', 				['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'chop_hood.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,  ["created"] = nil, ["decay"] = 30.0,   ['description'] = 'A hood from a vehicle'},
['chop_trunk'] 			     = {['name'] = 'chop_trunk', 					['label'] = 'Car Trunk', 				['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'chop_trunk.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,  ["created"] = nil, ["decay"] = 30.0,   ['description'] = 'A trunk from a vehicle'}, 	['trackeritem'] 				 = {['name'] = 'trackeritem', 			  	  	['label'] = "Tracker Disabler", 			['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'trackeritem.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,  ["created"] = nil, ["decay"] = 9.0,   ['description'] = 'A tracking disabler'},
--

--
# ESX ONLY - Install this in to your ox_inventory/data/items.lua
['trackeritem'] = {
    label = 'Tracker Disabler',
    weight = 160,
},

['chop_wheel'] = {
    label = 'Car Wheel',
    weight = 400,
},
['chop_door'] = {
    label = 'Car Door',
    weight = 400,
},
['chop_hood'] = {
    label = 'Car Hood',
    weight = 400,
},
['chop_trunk'] = {
    label = 'Car Trunk',
    weight = 400,
},
--

# (OPTIONAL)
Install the files in the pug-chopping/InteractSoundFiles into [standalone]/interact-sound/client/html/sounds if you want the 4 sound effects along with the script

# Quick commands
in the bottom of the server.lua i made 5 admin only commands to quickly get to any of the garages.
the commands are g1, g2, g3, g4, g5. (these will instantly teleport you to whatever garage number you want)


# PUG-CHOPPING: For any questions please contact me here:  https://discord.com/invite/jYZuWYjfvq

PREVIEW HERE:(VERY SOON)

​Full QBCore & ESX Compatibility. (supports custom qb-core names and all qb custom file dependency names)

This script is partially locked using escrow encryption. 90% of the script is accessible in client/open.lua, server/server.lua, and config.lua

Config: https://i.imgur.com/Wgmp8FM.png
Readme: https://i.imgur.com/pS5ibSD.png

Script description: You find yourself stumbling upon one of 5 different garages around the map that you can go up to and purchase for a big price. You purchase this garage for the big price and are introduced with a cutscene of an adhawk autos agent letting you know how your new shop works and operates. You have a center laptop in the garage where you can access and upgrade many things. On this laptop is displayed information like how many cars your garage has obtained over time and how many cars your garage is currently holding. You can either manage your garage or manage your stolen vehicles. If you manage your vehicles, you can either select to pick one up where you will be sent an email and a circle of where the car being requested is. You will then make your way to the vehicle and try to get it out of there before the police show up, or you can manage one of your already stolen vehicles and fix them up if there are any damages done on the trip to trying to obtain it. Once your vehicle is fixed of any damages if there is any, then you can take the vehicle to a random drop off location and break the car down for all of its parts. If you decide to manage your garage on this center laptop, you can adjust and change things such as making a password for your garage to allow friends in if they want to hang out or see your collection. These friends who enter your garage will not be able to use your laptop. You can also manage members, upgrade garage features, and upgrade the vehicle slots your garage can hold. You can add or remove members to your garage, but you need to upgrade the members capacity of your garage as you go. You can upgrade your garage with new features such as a clothing area, storage locker, crafting bench, welding bench to break down the car parts for money and scraps, arcade machine to play hack puzzles, and a printer machine to make rare items. All of this though is all obtained through earning more cars in your garage and unlocking things over time.

This completely configurable script consist of:
● Full development support and custom script adjustment request support.
● Advanced methods of making sure the vehicles NEVER poof unlike other vehicle related scripts.
● 380 different vehicle pickup locations already configured and all changeable.
● 65 pre configured cars to steal or the option to used any vehicle in QBCore.Shared (blackisted boats,air,police).
● 8 pre configured locations to chop down a vehicle.
● Incredibly balanced unlock progression already configured and can be changed.
● Uses configurable polyzones to setup unlimited different garage areas.
● Group activity that benifit with the more players that are involved.
● Upgradable welding bench you use to break down car parts and make money.
● Upgradable garage member slots.
● Upgradable garage vehicle storage.
● Upgradable item storage.
● Random Rare item drops.
● Custom Crafting tables that require progression and unlocks to craft things.
● custom arcade machine obtained through progression to play minigames.
● Custom animations, cutscenes, camera work, and sound effects all configurable.
● Custom welding bench to break down parts stolen from cars.
● Database table storing and keeping track of important data and information.
● Very extensive config.lua with options to customize everything.
● Custom configurable lang system to support multiple languages.
● Support for other core names, other target systems and any resource name changes.
● Runs at 0.0 ms resmon.

Requirements/Dependencies consist of:
QBCore OR ESX (other frameworks will work but not supported)
qb-menu OR ox_lib (ps-ui or any qb-menu resource name changed will work)
qb-target OR ox_target (any ps-inventory resource name changed will work)
Polyzone

Not required but defauly supported:
ps-ui. Small changes will be required for the arcade machine if you are not using ps-ui