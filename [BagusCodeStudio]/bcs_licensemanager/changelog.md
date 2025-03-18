# Changelog

Always replace your **server/main.lua** and **client/main.lua**

## 30/01/2022

- Fix query error in server/main.lua
- Replace fxmanifest.lua for mysql-async compability
- Add Config.usableCardItems for normal ESX item use
  Update instruction:
- add `Config.usableCardItems` in config
- add `RegisterNetEvent('LicenseManager:useCard')` in client/functions.lua
- add `ESX.RegisterUsableItem()` in server/functions.lua
- replace `server/main.lua`
- replace `fxmanifest.lua`

## 04/02/2022

- Add notification if not enough money from shop license
- Add notification if player already has that license
- Translate gender to english when creating license
- Fix when changing job ingame

### Update instruction:

- Config.lua at locale section at the bottom at the `not_enough_money` and `already_have_license`
- replace server/main.lua
- add setjob listener in client/functions.lua
- replace html/index.html and html/assets/

## 12/02/2022

- Add convert mode to easily convert from old esx_license `licenses` and `user_licenses` table
- Change location of config.lua to config folder
- Separate Config.Licenses for easy reading in config/licenses.lua
- Add managers for shop licenses in job property in licenses.lua
- Add lostPrice in licenses.lua for players to retrieve/get license item if they lost it
- Players can get/retrieve their license in shop if they lost the item, and managers can create another one for them
- Add license_items.sql for easy/example of using licenses as items
- Add esx_license:removeLicense in the server event for compability with esx_policejob
- Refactor the format of listing the license from array to object
- name property in Config.Licenses has been removed

### Update instruction:

- Replace server, client, html/assets, html/index.html
- Add config folder, move the config to config/config.lua and separate Config.Licenses to licenses.lua

## 22/02/2022

- Add client and server functions for easy compability with esx_dmvschool
- Add backspace key to close card or license
- Add option to use mugshot instead of MugShotBase64. This is to optimize resource usage when fetching the data, since
  base64 format has thousands of characters which eats up resource usage.
- Add documentation on website for dmvschool integrations

### Update instruction

- Replace client/functions.lua and server/functions.lua
- Replace html/assets and html/index.html

## 17/03/2022

- Fixed removing items when revoking a license
- Add renewing license ability. It will update the existing card (setting the metadata for ox_inventory and updating the sql for other inventory).

### Update instruction

- Replace html/assets and html/index.html
- Replace client/main.lua and server/functions.lua

## 01/06/2022

- Configurable language of UI
- Changed default html dropdown to a custom one
- Backspace while searching in history or manage will not close the UI
- Removed optional ped_spawner script, you can just enable it now in the config.lua

### Update instruction

- Replace html/assets and html/index.html
- Replace client/main.lua and config/config.lua (LocalesUI)
- Replace client/functions.lua for ped_spawner removal

## 12/07/2022

- Fix retrieval for job manager by creating an existing license for a user, it will cost based on the lostPrice of licenses.lua
- Fix mixed up locales while renewing license

### Update instruction

- Replace html/assets and html/index.html
- Replace client/main.lua, server/main.lua, server/functions.lua and config/config.lua (LocalesUI)

## 13/07/2022

- Refactor job system to enable Multiple job support
  License can now be managed by multiple jobs not just one
- Change animation from givetake to show badge like
- Add currency config.UI for changing License Shop currency

### Update isntruction

- Replace client and server folder
- Add Config.UI and job property in Config.Manager (or just replace Config.lua)
