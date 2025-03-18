function Framework.Client.TriggerCallback(cbRef, cb, ...)
  local args = {...}

  if Config.Framework == "QBCore" then
    return QBCore.Functions.TriggerCallback(cbRef, function(res)
      cb(res)
    end, table.unpack(args))
  elseif Config.Framework == "ESX" then
    return ESX.TriggerServerCallback(cbRef, function(res)
      cb(res)
    end, table.unpack(args))
  end
end

function Framework.Client.DrawText3D(coords, text)
  SetDrawOrigin(coords.x, coords.y, coords.z, 0)
  SetTextScale(0.0, 0.35)
  SetTextFont(4)
  SetTextColour(255, 255, 255, 215)
  SetTextDropshadow(0, 0, 0, 150, 1)
  SetTextEdge(2, 0, 0, 0, 150)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end