RegisterNetEvent('jim-catcafe:client:Consume', function(data)
	local name, type = "", ""
	if data.client then name, type = data.client.item, data.client.type
	else name, type = data.item, data.type end
	if GetResourceState("jim-consumables"):find("start") or GetResourceState("jim-consumables-main"):find("start") then
		TriggerEvent("jim-consumables:Consume", name)
	else
		local emoteTable = {
			["sake"] = "flute",
			["bobatea"] = "uwu12",
			["bbobatea"] = "uwu12",
			["gbobatea"] = "uwu12",
			["obobatea"] = "uwu12",
			["pbobatea"] = "uwu12",
			["nekolatte"] = "uwu2",
			["mocha"] = "uwu1",
			["catcoffee"] = "uwu4",
			["bmochi"] = "uwu13",
			["gmochi"] = "uwu13",
			["omochi"] = "uwu13",
			["pmochi"] = "uwu13",
			["miso"] = "uwu9",
			["nekodonut"] = "uwu5",
			["purrito"] = "uwu8",
			["noodlebowl"] = "uwu9",
			["ramen"] = "uwu9",
			["bento"] = "uwu7",
			["nekocookie"] = "uwu6",
		}
		local progstring = type == "food" and Loc[Config.Lan].progressbar["progress_eat"] or Loc[Config.Lan].progressbar["progress_drink"]
		local emote = emoteTable[name] or "drink"
		ExecuteCommand("e "..emote)
		if progressBar({
			label = progstring..Items[name].label.."..",
			time = math.random(5000, 8000),
			cancel = true,
			icon = name
		}) then
			ConsumeSuccess(name, type)
		else
			ExecuteCommand("e c")
		end
	end
end)