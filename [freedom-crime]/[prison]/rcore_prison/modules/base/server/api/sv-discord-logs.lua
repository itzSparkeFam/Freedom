Discord = {}

Discord.SendMessage = function(title, desc, fields)
	local payload = {
		{
			color = 16007897,
			title = title,
			description = desc,
			type = 'rich',
			fields = fields,
		}
	}

	dbg.debug('Sending message to Discord: %s', title)

	PerformHttpRequest(
		SConfig.Webhook,
		function(err, text, headers) end,
		'POST',
		json.encode(
			{ username = 'rcore_prison_v2', embeds = payload }
		),
		{ ['Content-Type'] = 'application/json' }
	)
end
