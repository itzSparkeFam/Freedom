Citizen.CreateThread(function()
	RequestIpl("k4mb1_bobcat_v_cashdepot_milo_")
	
-- Bobcat
	local interiorid = GetInteriorAtCoords(1378.81700000, -2622.62700000, 48.67468000)
	
	ActivateInteriorEntitySet(interiorid, "k4_bobcat_crates")
	ActivateInteriorEntitySet(interiorid, "k4_bobcat_gold")
	-- ActivateInteriorEntitySet(interiorid, "k4mb1_bobcat_no_heist") -- Shoot or script to open
	ActivateInteriorEntitySet(interiorid, "k4mb1_bobcat_start") -- Start before explosion
	-- ActivateInteriorEntitySet(interiorid, "k4mb1_bobcat_destroyed") -- Enable after explosion

	RefreshInterior(interiorid)
	
end)