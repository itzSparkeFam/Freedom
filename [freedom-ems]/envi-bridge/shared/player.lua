---Get Player
---@class Player
Framework.Player = {
    Identifier = "",
    Name = "",
    Firstname = "",
    Lastname = "",
    Job = {
        Name = "",
        Label = "",
        Duty = false,
        Boss = false,
        Grade = {
            Name = "",
            Level = 0

        }
    },
    Gang = {
        Name = "",
        Label = "",
        Boss = false,
        Grade = {
            Name = "",
            Level = 0
        },
    },
    Metadata = {}
}

Framework.HasJob = function(job, player, duty)
    if type(job) == 'table' then
        job = job[player.Job.Name]
        if job and player.Job.Grade.Level >= job then
            return (duty and player.Job.Duty or true)
        end
    elseif job == player.Job.Name then
        return (duty and player.Job.Duty or true)
    end
    return false
end

Framework.HasGang = function(gang, player)
    if type(gang) == 'table' then
        gang = gang[player.Gang.Name]
        if gang and player.Gang.Grade.Level >= gang then
            return true
        end
    elseif gang == player.Gang.Name then
        return true
    end
    return false
end