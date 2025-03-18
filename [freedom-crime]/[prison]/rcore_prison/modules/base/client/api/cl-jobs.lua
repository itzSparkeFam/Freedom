function HandleStepperMinigame()
    local retval = false

    if lib then
        retval = lib.skillCheck({ 'easy', 'easy', { areaSize = 50, speedMultiplier = 1 }, 'easy' }, { 'w', 'a', 'd' })
    else
        retval = true
    end

    dbg.debug('Loading job minigame skill check.')

    return retval
end