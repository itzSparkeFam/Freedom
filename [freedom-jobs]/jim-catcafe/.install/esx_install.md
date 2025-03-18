Thank you for your purchase <3 I hope you have fun with this script and that it brings jobs and RP to your server

If you need support I now have a discord available, it helps me keep track of issues and give better support.

https://discord.gg/xKgQZ6wZvS


# INSTALLATION

## Add the script to the server resources
- I highly recommend putting the `jim-catcafe` folder in a new folder called `[jim]`
- Then add `ensure [jim]` AFTER your other scripts in your server.cfg

---
# Item installation
- Add the images from `.install > images` to your inventory folder eg. `ox_inventory > data > items.lua`

- Add the `ox_items.lua` to your `ox_inventory > data > items.lua`

# Job installation

- Import the `esx_jobs.sql` into your database to add the jobs and their grades

--------------------------------------------------------------------------------------------------

## Emotes

Custom emotes currently run through dpemotes, its the easier option and adds extra emotes for you to use :)

These go in your `rpemotes` > `client` > `AnimationListCustom.lua`

Place these under `CustomDP.PropEmotes = {`

--Jim-CatCafe
["uwu1"] = {
	"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_sml_drink', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu2"] = {
	"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_lrg_drink', PropBone = 28422, PropPlacement = {0.03, 0.0, -0.08, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu3"] = {
	"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_cup_straw', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu4"] = {
	amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_mug', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu5"] = {
	"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{ Prop = 'uwu_pastry', PropBone = 18905, PropPlacement = {0.16, 0.06, -0.03, -50.0, 16.0, 60.0},
		EmoteMoving = true, }},
["uwu6"] = {
	"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{ Prop = 'uwu_cookie', PropBone = 18905, PropPlacement = {0.16, 0.08, -0.01, -225.0, 20.0, 60.0},
		EmoteMoving = true, }},
["uwu7"] = {
	"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{ Prop = 'uwu_sushi', PropBone = 18905, PropPlacement = {0.18, 0.03, 0.02, -50.0, 16.0, 60.0},
		EmoteMoving = true, }},
["uwu8"] = {
	"amb@world_human_seat_wall_eating@male@both_hands@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_eggroll', PropBone = 60309, PropPlacement = {0.10, 0.03, 0.08, -95.0, 60.0, 0.0},
		EmoteMoving = true, }},
["uwu9"] = {
	"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "", AnimationOptions =
	{ Prop = "uwu_salad_bowl", PropBone = 60309, PropPlacement = {0.0, 0.0300, 0.0100, 0.0, 0.0, 0.0},
		SecondProp = 'uwu_salad_spoon', SecondPropBone = 28422, SecondPropPlacement = {0.0, 0.0 ,0.0, 0.0, 0.0, 0.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu10"] = {
	"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{ Prop = 'uwu_sandy', PropBone = 18905, PropPlacement = {0.16, 0.08, 0.05, -225.0, 20.0, 60.0},
		EmoteMoving = true, }},
["uwu11"] = {
	"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_cupcake', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.03, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu12"] = {
	"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{ Prop = 'uwu_btea', PropBone = 28422, PropPlacement = {0.02, 0.0, -0.05, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }},
["uwu13"] = {
	"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{ Prop = 'uwu_gdasik', PropBone = 18905, PropPlacement = {0.16, 0.08, 0.02, -225.0, 20.0, 60.0},
		EmoteMoving = true, }},

--------------------------------------------------------------------------------------------------

## Jim-Consumables (Optional) - (https://github.com/jimathy/jim-consumables)
- If `jim-consumables` is installed, the script will attempt to reroute consumables
- The server side will automatically add the items to `jim-consumables` (edit any values you wish there)
- When used the item will trigger the `client:consume` event which detects wether to use built in event's or `jim-consuambles` (if found)

--------------------------------------------------------------------------------------------------