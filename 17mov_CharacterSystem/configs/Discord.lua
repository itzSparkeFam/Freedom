-- We moved this part of Selector.lua config there, because otherwise your Discord bot token can be easly leaked by cheaters who's using dumper
-- Here you can configure custom number of characters per specified player (based on discord roles)
Selector.Discord = {
    Enable = true,                                                                      -- Should enable system?
    Token = "MXaesQxMTEzNjE0NjM0ATx1OQ.R15g6p.w8xUmkb5j4XEQvl2Y5H3kxQ3pYCcc4fmok25os", -- Discord Bot token (bot must be on guild)
    Guild = "863814751468388392",                                                       -- DiscordId of your server guild
    Roles = {                                                                           -- There you can add roles and assign number of characters
        -- ["DISCORD_ID_OF_ROLE"] = NUMBER_OF_CHARACTERS,                               -- Template
        -- ["1111774118820446259"] = 10,                                                -- Example
    }
}