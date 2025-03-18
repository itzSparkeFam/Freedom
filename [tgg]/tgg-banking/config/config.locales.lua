Config = Config or {}

Config.DefaultLanguage = "en" -- Default locale. 

-- HOW TO ADD A NEW LANGUAGE --
-- Add a new entry to the Config.Languages table with the key(value) of the language code(e.g. 'en', 'de'...) and the label of the language.
-- Add your resource file to `ui\public\locales` with the language code as the filename (e.g. en.json, de.json...).
Config.Languages = {
    {
        value = 'en',
        label = 'English',
    },
}
