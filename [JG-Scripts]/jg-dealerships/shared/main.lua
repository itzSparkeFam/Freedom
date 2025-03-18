Globals = {}
Functions = {}
Locale = Locales[Config.Locale or "en"]

exports("locale", function() return Locale end)
exports("config", function() return Config end)

---@param text string
---@param debugtype? "warning"|"debug"
function debugPrint(text, debugtype, ...)
  if not Config.Debug then return end
    
  local prefix = "^2[DEBUG]^7"
  if debugtype == "warning" then prefix = "^3[WARNING]^7" end 

  local args = {...}
  local output = ""
  for i = 1, #args do
    if type(args[i]) == "table" then
      output = output .. json.encode(args[i])
    elseif type(args[i]) ~= "string" then
      output = output .. tostring(args[i])
    else
      output = output .. args[i]
    end

    if i ~= #args then output = output .. " " end
  end
  
  print(prefix, text, output)
end

---@param vehicle integer
function deleteVehicle(vehicle)
  if GetResourceState("AdvancedParking") == "started" then
    exports["AdvancedParking"]:DeleteVehicle(vehicle, false)
  else
    DeleteEntity(vehicle)
  end
end

---@param vehicle integer
---@param plate string
function setVehiclePlateText(vehicle, plate)
  if GetResourceState("AdvancedParking") == "started" then
    exports["AdvancedParking"]:UpdatePlate(vehicle, plate)
  else
    SetVehicleNumberPlateText(vehicle, plate)
  end
end

---@param model string | number
---@return number hash
function convertModelToHash(model)
  return type(model) == "string" and joaat(model) or model --[[@as number]]
end

---@param plate string
function isValidGTAPlate(plate)
  -- Check if the plate matches the pattern and is not longer than 8 characters
  -- %w matches alphanumeric characters, %s matches space characters
  -- The pattern checks for a string starting with 0 or more alphanumeric or space characters
  if #plate <= 8 and plate:match("^[%w%s]*$") then return true end
  return false
end

---@param table table
function tableKeys(table)
  local keys = {}
  
  for k, _ in pairs(table) do
    keys[#keys+1] = k  
  end

  return keys
end

-- Round a number to so-many decimal of places,
-- Which can be negative, e.g. -1 places rounds to 10's
---@param num integer
---@param dp? integer
---@return number
function round(num, dp)
  dp = dp or 0
  local mult = 10^(dp or 0)
  return math.floor(num * mult + 0.5) / mult
end

---@param list table
---@param item string|number
---@return boolean
function isItemInList(list, item)
  if #list == 0 then
    return true
  end

  for _, value in ipairs(list) do
    if value == item then
      return true
    end
  end

  return false
end

---@param s string
---@return string
function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end