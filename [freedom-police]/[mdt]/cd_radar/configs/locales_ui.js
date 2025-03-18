// The icons used are from https://icons.getbootstrap.com/

// Example <i class="bi bi-exclamation-triangle"></i>
// As seen on https://icons.getbootstrap.com/icons/exclamation-triangle/

window['locales'] = {
    "front_camera":"Front",
    "rear_camera":"Rear",

    "toggle_typing":"Click to toggle menu",
    "toggle_typing_message":`Make sure you are safely parked. <i class="bi bi-exclamation-triangle"></i>`,

    // BOLO
    "create_bolo_title":"Create a BOLO",

    "create_bolo_type":"Type",
    "create_type_bolo":"BOLO",
    "create_type_marker":"Marker",

    "create_bolo_plate":"Plate",
    "create_plate_helper":"Plate needs to be set or less than 8 characters long (including whitespaces)",

    "create_bolo_model":"Model",
    "create_model_helper":"Model needs to be set or less than 32 characters.",

    "create_bolo_colour":"Colour",
    "create_colour_helper":"Colour needs to be set and less than 16 characters long.",

    "create_bolo_marker":"Reason",
    "create_marker_helper":"Reason needs to be set.",

    "create_bolo_notes":"Notes",
    "create_notes_helper":"",

    "create_bolo_button":"Create BOLO",
    "create_bolo_button_success":"Success!",
    "create_bolo_button_fail":"Cannot create",

    // Search
    "search_plate_placeholder":"Start typing to search...",
    "search_delete":"Delete",
    "search_confirm":`Are you sure?`,

    // Settings
    "settings_autolock":"Toggle auto lock",
    "settings_autolock_helper":"Toggles auto-locking on marked vehicles.",

    "settings_log_size":"Log size",
    "settings_log_size_helper":"Changes how many logs are saved per camera.",
    
    "settings_speed_increment":"Speed increment",
    "settings_speed_increment_helper":"Changes the increment/decrement value for setting speed limits.",

    "settings_sound":"Sound volume",
    "settings_sound_helper":"Mute, have your ears bleed, or somewhere in between.",

    "settings_scale":"Scale",
    "settings_scale_helper":"Increase or decrease the radar size.",

    "settings_theme":"Theme",
    "settings_theme_helper":"Pick your poison...",

    "settings_reset":"Reset settings",

    // Context (Right click) menu on logs
    "context_menu_copy":`<a href="#"><i class="bi bi-clipboard-fill"></i> Copy to clipboard</a>`,
    "context_menu_create":`<a href="#"><i class="bi bi-file-earmark-plus-fill"></i> Create alert</a>`,
    "context_menu_owner":`<a href="#"><i class="bi bi-person-bounding-box"></i> Owner lookup</a>`,
    "context_menu_delete":`<a href="#"><i class="bi bi-x-circle-fill"></i> Delete this log</a>`,

    // Other
    "bolo_shorthand":'B',
    "marker_shorthand":'M',

    "speed_unit":"MPH" // MAKE SURE TO CHANGE THE Config.SpeedMultiplier IN ./config.lua IF YOU ARE CHANGING TO KMH
};

window['screenNames'] = {
    "radar":"Radar",
    "alerts": "Alerts",
    "search": "Search",
    "logs": "Logs",
    "settings":"Settings"
}