--
-- Discord Webhooks
--

Webhooks = {}
Webhooks.SelfService = ""
Webhooks.Orders = ""
Webhooks.TabletTuning = ""
Webhooks.Servicing = ""
Webhooks.Invoices = ""
Webhooks.Mechanic = "" -- mechanic management/employees events
Webhooks.Admin = ""

--[[
  EXAMPLE WEBHOOK CALL

  sendWebhook(src, Webhooks.Admin, "Webhook Title", "success", {
    { key = "Data fields", value = "Data value" },
    { key = "Data fields 2", value = "Data value 2" }
  })
]]--

---Send a Discord webhook
---@param playerId integer
---@param webhookUrl string
---@param title string
---@param type? "success" | "danger" | "default"
---@param data {key: string, value: any}[]
---@return boolean successful
function sendWebhook(playerId, webhookUrl, title, type, data)
  if not webhookUrl then return false end

  local player = Framework.Server.GetPlayerInfo(playerId)
  if not player then return false end

  local color = 0xff6700
  if type == "success" then color = 0x2ecc71 end
  if type == "danger" then color = 0xe74c3c end

  local fields = {
    {
      name = "Player",
      value = string.format("%s (id: %s)", player.name, tostring(playerId)),
      inline = false
    }
  }
  for _, row in pairs(data) do
    fields[#fields + 1] = {
      name = row.key,
      value = tostring(row.value),
      inline = true
    }
  end

  local body = {
    username = "JG Mechanic Webhook",
    avatar_url = "https://forum.cfx.re/user_avatar/forum.cfx.re/jgscripts/288/3621910_2.png",
    content = "",
    embeds = {
      {
        type = "rich",
        title = title,
        description = "",
        color = color,
        fields = fields
      }
    }
  }

  PerformHttpRequest(
    webhookUrl,
    function(err, text, header) end,
    "POST",
    json.encode(body),
    {["Content-Type"] = "application/json"}
  )

  return true
end

-- TODO: This event is unused, commented out to prevent abuse from client
-- -- For sending from client files
-- RegisterNetEvent("jg-mechanic:server:send-webhook", function(event, ...)
--   local src = source
--   sendWebhook(src, Webhooks[event], ...)
-- end)