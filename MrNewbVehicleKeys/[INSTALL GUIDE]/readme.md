Please add the items in the qb-core/oxitems folder, then follow the install steps at -------> https://mrnewbs-scrips.gitbook.io/guide
Please be very aware, this is a beta. There will be bugs, by testing this you help ensure these bugs get squashed.





























New Command Added -       /proximitylocks         --- This will enable/disable the proxmity locks for the player for cases where they want to be immersed. (saved in kvp)












The below are a list of exports, some of these are only in the beta so they have not yet been documented but they are here if you need them.


EXPORTS!

Client Only

-- exported fob functs
exports.MrNewbVehicleKeys:ToggleEngine(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:StartVehicleAlarm(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:ToggleConveratble(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:ToggleAutoPilot() -- must be a in a vehicle, you must also have keys
exports.MrNewbVehicleKeys:ToggleRemoteStart(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:ToggleDoorLock(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:SummonVehicle(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:SelfParkVehicle(entity) -- must be a entity, you must also have keys
exports.MrNewbVehicleKeys:DanceMode(entity) -- must be a entity, you must also have keys

-- exported key functs
exports.MrNewbVehicleKeys:ToggleTempKey(bool) -- true/false to bypass keysystem for all cars. This is a catch all for any systems that arent compatable ie vehicleshops
exports.MrNewbVehicleKeys:GetTempKey() -- returns bool if temp key is enables or not
exports.MrNewbVehicleKeys:GiveKeys(entity) -- must pass the entity
exports.MrNewbVehicleKeys:GiveKeysByPlate(plate) -- plate is a string ("PLATENUMBER")
exports.MrNewbVehicleKeys:RemoveKeys(entity) -- must pass the entity
exports.MrNewbVehicleKeys:RemoveKeysByPlate(plate) -- plate is a string ("PLATENUMBER")
exports.MrNewbVehicleKeys:GetVehicleState() -- returns bool if you have keys to the nearest vehicle
exports.MrNewbVehicleKeys:HaveKeys(entity) -- returns bool if you have keys to the entity
exports.MrNewbVehicleKeys:HasKeys(entity) -- returns bool if you have keys to the entity
exports.MrNewbVehicleKeys:HasKeysByPlate(entity) -- returns bool if you have keys to the entity
exports.MrNewbVehicleKeys:HasInventoryKeys(entity) -- returns bool if you have keys to the entity (this is only applicable for item based, tbh its kinda useless but I dont wana break compatability)



Server Only
exports.MrNewbVehicleKeys:SetVehicleLock(netId, status) -- netID is a network id of a vehicle, this is a var, status is a number try to stick to 1 or 2
exports.MrNewbVehicleKeys:GiveKeys(source, netid)  -- netID is a network id of a vehicle, this is a var
exports.MrNewbVehicleKeys:GiveKeysByPlate(source, plate) -- plate is a string ("PLATENUMBER")
exports.MrNewbVehicleKeys:AddKeysByPlate(source, plate)  -- plate is a string ("PLATENUMBER")
exports.MrNewbVehicleKeys:RemoveKeys(source, netId) -- netID is a network id of a vehicle, this is a var
exports.MrNewbVehicleKeys:RemoveKeysByPlate(source, plate)  -- plate is a string ("PLATENUMBER")
exports.MrNewbVehicleKeys:HaveKeys(source, netId) -- netID is a network id of a vehicle, this is a var
exports.MrNewbVehicleKeys:HasKeys(source, netId) -- netID is a network id of a vehicle, this is a var
exports.MrNewbVehicleKeys:HasKeysByPlate(source, plate) -- plate is a string ("PLATENUMBER")