Config = Config or {}

Config.MinimapDefaultOn = true     -- Whether the minimap should be always on by default.
Config.MapTypeByDefault = 'square' -- or "square", "circle"

Config.EnableCycleMap = true
Config.CycleMapFirstBind = 'Z'

function UpdateMap()
    local defaultAspectRatio = 1920 / 1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapOffset = aspectRatio > defaultAspectRatio and ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008 or 0

    if MapType == "square" then
        lib.requestStreamedTextureDict("squaremap")

        SetMinimapClipType(0)

        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
        -- 0.0 = nav symbol and icons left
        -- 0.1638 = nav symbol and icons stretched
        -- 0.216 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

        -- -0.01 = map pulled left
        -- 0.025 = map raised up
        -- 0.262 = map stretched
        -- 0.315 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)

        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetMinimapClipType(0)

        SetRadarBigmapEnabled(true, false)
        Wait(50)
        SetRadarBigmapEnabled(false, false)

        Wait(1200)
        SetRadarZoom(1200)
    elseif MapType == "circle" then
        lib.requestStreamedTextureDict('circlemap')

        SetMinimapClipType(1)

        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
        -- -0.0100 = nav symbol and icons left
        -- 0.180 = nav symbol and icons stretched
        -- 0.258 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", -0.0100 + minimapOffset, -0.030, 0.180, 0.258)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200 + minimapOffset, 0.0, 0.065, 0.20)

        -- -0.00 = map pulled left
        -- 0.015 = map raised up
        -- 0.252 = map stretched
        -- 0.338 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00 + minimapOffset, 0.015, 0.252, 0.338)

        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetMinimapClipType(1)

        SetRadarBigmapEnabled(true, false)
        Wait(50)
        SetRadarBigmapEnabled(false, false)

        Wait(1200)
        SetRadarZoom(1200)
    end
end
