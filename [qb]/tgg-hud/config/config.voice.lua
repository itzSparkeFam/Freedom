Config = Config or {}

Config.Voice = 'pma-voice' -- or "pma-voice", "saltychat"
Config.VoiceRanges = {
    pma = {
        [1] = 25,
        [2] = 50,
        [3] = 100,
    },
    salty = {
        [3.0] = 10,
        [8.0] = 30,
        [15.0] = 65,
        [32.0] = 100,
    }
}
