local points = {}
local insidePoints = {}
local insideCount = 0
local closestPoint
local DrawLine = DrawLine
local thread = false

local function DebugPoint(coords, radius, color)
    local startPoint = coords + vec3(0.0, 0.0, 4.0)
    local endPoint = coords - vec3(0.0, 0.0, -0.01)
    DrawLine(startPoint.x, startPoint.y, startPoint.z, endPoint.x, endPoint.y, endPoint.z, 255, 42, 24, 255)
    DrawMarker(28, endPoint.x, endPoint.y, endPoint.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, radius, color.x, color.y, color.z, 48, false, false, 2, nil, nil, false)
    DrawMarker(25, endPoint.x, endPoint.y, endPoint.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 42, 24, 48, false, false, 2, nil, nil, false)
end

CreateThread(function()
    while true do
        local sleep = 300

        if insideCount ~= 0 then
			table.wipe(insidePoints)
			insideCount = 0
		end

        local coords = GetEntityCoords(Store.Ped)

        if closestPoint and #(coords - closestPoint.coords) > closestPoint.distance then
            closestPoint = nil
        end

        for _, point in pairs(points) do
			local distance = #(coords - point.coords)

            if point.debug then
                DebugPoint(point.coords, point.distance, point.isinside and vec3(114, 204, 114) or vec3(255, 42, 24))
                sleep = 0
            end

			if distance <= point.distance then
				point.currentDistance = distance

                if closestPoint then
                    if distance < closestPoint.currentDistance then
                        closestPoint.isClosest = nil
                        point.isClosest = true
                        closestPoint = point
                    end
                elseif distance < point.distance then
                    point.isClosest = true
                    closestPoint = point
                end

				if point.inside then
                    insideCount += 1
					insidePoints[insideCount] = point
				end

				if point.onEnter and not point.isinside then
					point.isinside = true
					point:onEnter()
				end
			elseif point.currentDistance then
				if point.onExit then
                    point:onExit()
                end
				point.isinside = nil
				point.currentDistance = nil
			end
		end

        if not thread then
            if insideCount ~= 0 then
                thread = true
                CreateThread(function()
                    while insideCount ~= 0 do
                        for i = 1, insideCount do
                            local point = insidePoints[i]
                            if point then
                                point:inside()
                            end
                        end
                        Wait(100)
                    end
                end)
            end
        elseif insideCount == 0 then
            thread = false
        end
        
        Wait(sleep)
    end
end)

Points = {
    New = function(data)
        local point = {
            id = #points + 1
        }

        points[point.id] = point

        for key, value in pairs(data) do
            point[key] = value
        end

        point.remove = function()
            Points.Remove(point.id)
        end

        if data.onEnter then
            point.onEnter = function()
                data.onEnter(point)
            end
        end

        if data.onExit then
            point.onExit = function()
                data.onExit(point)
            end
        end

        if data.inside then
            point.inside = function()
                data.inside(point)
            end
        end

        return point
    end,
    Remove = function(id)
        if not points[id] then return end
        
        if closestPoint?.id == id then
            closestPoint = nil
        end

        points[id].onExit()
        points[id] = nil
    end,
    All = function()
        return points
    end,
    Inside = function()
        return insidePoints
    end,
    Closest = function()
        return closestPoint
    end
}