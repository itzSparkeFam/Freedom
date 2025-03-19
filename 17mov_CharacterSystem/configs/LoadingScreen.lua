-- Loading screen as name said is displaying when scripts are loading. That means that it cannot just get data from .lua file.
-- Anyway you can still configure it, but you need to do that into /web/public/loadingscreen

-- NOTE: If you want to fully remove loadingscreen, you need to go into the fxmanifest.lua file. Then find these three lines and remove them:
-- loadscreen "web/index.html"
-- loadscreen_manual_shutdown "yes"
-- loadscreen_cursor "yes"