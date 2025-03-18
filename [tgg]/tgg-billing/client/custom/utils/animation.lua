local tabletObj

function PlayAnimation()
    local tabletModel = 'prop_cs_tablet'
    local animDict = 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a'
    local animName = 'idle_a'
    local boneIndex = 28422
    local attachPosition = vector3(-0.05, 0.0, 0.0)
    local attachRotation = vector3(0.0, 0.0, 0.0)

    lib.requestAnimDict(animDict)

    -- Create the tablet prop and attach it to the player's hand
    tabletObj = CreateObject(joaat(tabletModel), 0, 0, 0, true, true, true)
    AttachEntityToEntity(
        tabletObj,
        cache.ped,
        GetPedBoneIndex(cache.ped, boneIndex),
        attachPosition.x,
        attachPosition.y,
        attachPosition.z,
        attachRotation.x,
        attachRotation.y,
        attachRotation.z,
        true, true, false, true, 1, true
    )

    -- Play the animation
    TaskPlayAnim(cache.ped, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)
    RemoveAnimDict(animDict)
end

function StopAnimation()
    DeleteObject(tabletObj)
    ClearPedTasks(cache.ped)
end
