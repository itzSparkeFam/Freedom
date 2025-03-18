Citizen.CreateThread(function()
	while true do
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(1350668494596866099)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo_name')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('FreedomRP')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('small_logo')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('FreedomRP')


        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "Freedom RP Discord", "https://discord.gg/FWstpw29Nx")
        SetDiscordRichPresenceAction(1, "Connect To Server", "cfx.re/join/q6kk99")

        -- It updates every minute just in case.
		Citizen.Wait(60000)
	end
end)