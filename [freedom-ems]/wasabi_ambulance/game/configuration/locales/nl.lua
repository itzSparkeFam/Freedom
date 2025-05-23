-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.Language ~= 'nl' then return end

Strings = {
    no_society_account = '[^3WAARSCHUWING^0] De maatschappelijke rekening bestaat niet voor: %s',
    ems_worker = 'Ambulancewerker',
    not_authorized = 'Niet gemachtigd',
    not_authorized_desc = 'Je bent niet gemachtigd om dit te gebruiken!',
    not_on_duty = 'Niet in dienst',
    not_on_duty_desc = 'Je bent niet in dienst!',
    gps_enabled = 'GPS ingeschakeld',
    gps_enabled_desc = 'Je hebt je GPS ingeschakeld',
    gps_disabled = 'GPS uitgeschakeld',
    gps_disabled_desc = 'Je hebt je GPS uitgeschakeld',

    possible_cause = 'Mogelijke oorzaak',

    full_name = 'Naam',
    pulse = 'Pols',
    bpm = 'BPM: %s',
    bleed_rate = 'Bloedingsgraad',
    bleed_rate_low = 'Laag',
    bleed_rate_medium = 'Gemiddeld',
    bleed_rate_high = 'Hoog',
    no_name = 'Geen naam',
    injuries = 'Huidige verwondingen',

    get_off_stretcher_ui = '[E] - Van brancard afstappen',
    move = 'Bewegen',
    move_desc = 'De brancard bewegen',
    put_in_vehicle = 'In voertuig plaatsen',
    stretcher_in_vehicle = 'Brancard in voertuig plaatsen',
    put_in_vehicle_desc = 'De brancard in een voertuig plaatsen',
    place_on_stretcher = 'Patiënt plaatsen',
    place_on_stretcher_desc = 'Een patiënt op de brancard plaatsen',
    remove_from_stretcher = 'Patiënt verwijderen',
    remove_from_stretcher_desc = 'Een patiënt van de brancard verwijderen',
    not_found = 'Niet gevonden',
    already_occupied_ambulance = 'Al bezet',
    already_occupied_ambulance_desc = 'Deze ambulance is al bezet!',
    already_occupied_stretcher = 'Al bezet',
    already_occupied_stretcher_desc = 'Deze brancard is al bezet!',
    vehicle_occupied = 'Voertuig bezet',
    vehicle_occupied_desc = 'Dit kan niet gedaan worden terwijl iemand aan het rijden is!',
    not_occupied_stretcher = 'Niet bezet',
    not_occupied_stretcher_desc = 'Deze brancard is niet bezet!',
    stretcher_placement_blocked = 'Plaatsing geblokkeerd',
    stretcher_placement_blocked_desc = 'Je kunt hier de brancard niet plaatsen!',
    knocked_out = 'Knock-out',
    knocked_out_desc = 'Je bent knock-out geslagen!',
    checkin_cooldown = 'Check-in Afkoelperiode',
    checkin_cooldown_desc = 'Je probeert te snel in te checken, wacht even alsjeblieft.',
    checkingin_progress = 'Inchecken bezig...',
    remove_dead_target = 'Bewusteloos Persoon Verwijderen',
    ply_injury_head = 'hoofd',
    ply_injury_neck = 'nek',
    ply_injury_spine = 'wervelkolom',
    ply_injury_upper = 'bovenlichaam',
    ply_injury_lower = 'onderlichaam',
    ply_injury_left_arm = 'linkerarm',
    ply_injury_left_leg = 'linkerbeen',
    ply_injury_right_arm = 'rechterarm',
    ply_injury_right_leg = 'rechterbeen',
    diagnosing_patient_progress = 'Patiënt Diagnostiseren...',
    treating_patient_progress = 'Patiënt Behandelen...',
    recovering_progress = 'Herstellende...',
    injury_report = 'Letselrapport',
    none = 'Geen',
    mild = 'Mild',
    moderate = 'Matig',
    severe = 'Ernstig',
    deadly = 'Dodelijk',
    injury_report_locations = 'Locatie',
    injury_report_type = 'Letseltype: %s',
    injury_report_severity = 'Ernst: %s',
    injury_report_bleed = 'Bloedverlies',
    light_injury_title = 'Lichte Verwonding',
    moderate_injury_title = 'Matige Verwonding',
    extreme_injury_title = 'Ernstige Verwonding',
    injury_bleed_notify = 'Verwonding & Bloeding Alarm',
    light_injury_desc = 'Je %s is gewond, overweeg een dokter te bezoeken!',
    moderate_injury_desc = 'Je %s is ernstig gewond, je hebt een dokter nodig!',
    extreme_injury_desc = 'Je %s is extreem gewond. Ga naar de dokter voordat het te laat is!',
    injury_msg_one = 'Je hebt een aanzienlijke verwonding.',
    injury_msg_two = 'Je hebt een ernstige verwonding.',
    injury_msg_three = 'Je hebt een zeer ernstige verwonding.',
    injury_msg_four = 'Je hebt een kritieke verwonding.',
    bleed_msg_one = 'Je bloedt.',
    bleed_msg_two = 'Je bloedt hevig. Druk uitoefenen.',
    bleed_msg_three = 'Je gaat doodbloeden!',
    fainted_title = 'Flauwgevallen',
    fainted_so_high_desc = 'Je bent flauwgevallen vanwege de hoogte.',
    cant_jump_title = 'Kan Niet Springen!',
    cant_jump_desc = 'Je bent te gewond om te springen',
    blackout_title = 'Bewusteloos',
    blackout_desc = 'Je bent bewusteloos geraakt door je verwonding aan %s! Zoek onmiddellijk medische hulp!',
    treated_fully_desc = 'Je bent behandeld en voelt je beter dan ooit!',
    treated_not_fully_desc = 'Je bent behandeld, maar hebt aanvullende behandeling nodig.',
    prescription_menu = 'Recepten Menu',
    prescription_menu_desc = 'Toegang tot en beheren van recepten',
    no_stretcher_detected = 'Geen Brancard Gedetecteerd',
    no_stretcher_detected_desc = 'Er is geen actieve brancard gedetecteerd!',
    cant_run = 'Kan Niet Sprinten',
    cant_run_desc = 'Je bent te gewond om te sprinten!',
    no_back_seat = 'Geen Beschikbare Zitplaatsen',
    no_back_seat_desc = 'Er zijn geen zitplaatsen achterin deze ambulance',
    enter_vehicle_back = 'Ambulance Betreden (Achterzijde)',
    stretcher_already_deployed = 'Brancard Al Uitgeklapt',
    stretcher_already_deployed_desc = 'De brancard die aan deze ambulance is toegewezen, is al verwijderd.',
    send_stretcher_home = 'Terug naar Voertuig',
    ambulance_not_found = 'De brancard is verwijderd maar de ambulance werd niet gevonden om terug te keren!',
    bleedout = 'bloeden',
    player_injury_critical_desc = 'Speler verkeert in kritieke toestand door een %s wond!',
    gps_active = 'GPS Geactiveerd',
    gps_active_desc = 'Speler %s heeft hun GPS geactiveerd',
    gps_deactive = 'GPS Gedeactiveerd',
    gps_deactive_desc = 'Speler %s heeft hun GPS gedeactiveerd',
    no_wsb = '^0[^3WAARSCHUWING^0] wasabi_bridge is NIET gestart NA het framework en/of VOOR de resource: %s',
    spawn_blocked = 'Garage Geblokkeerd',
    spawn_blocked_desc = 'Je kunt je voertuig niet uithalen omdat het geblokkeerd is!',
    menu_remove_crutch = 'Kruk Verwijderen',
    menu_remove_crutch_desc = 'Verwijder een kruk bij een nabije patiënt',
    menu_remove_chair = 'Rolstoel verwijderen',
    menu_remove_chair_desc = 'Verwijder een rolstoel bij een nabije patiënt',
    toggle_stretcher = 'Brancard nemen',
    toggle_stretcher_desc = 'Neem de brancard van het dichtstbijzijnde voertuig',
    no_vehicle_nearby = 'Voertuig',
    no_vehicle_nearby_desc = 'Er is geen voertuig in de buurt',
    no_ambulance_nearby_desc = 'Er is geen ambulance in de buurt',
    on_duty = 'Dienst',
    on_duty_desc = 'Je bent zojuist in dienst gegaan!',
    off_duty = 'Uit dienst',
    off_duty_desc = 'Je bent zojuist uit dienst gegaan!',
    amount = 'Bedrag',
    mr = 'Meneer',
    mrs = 'Mevrouw',
    debt_collection = 'Schuldinning',
    db_email =
    'Beste %s %s, <br /><br />Het Central Judicial Collection Agency (CJCA) heeft de boetes die je van de politie hebt ontvangen in rekening gebracht.<br />Er is <strong>$%s</strong> van je account afgeschreven.<br /><br />Met vriendelijke groet,<br />Mr. Wasabi',
    fine_sent = 'Boetes Verstuurd',
    fine_sent_desc = 'Je hebt de boetes succesvol verstuurd voor $%s!',
    fine_received = 'Boete Ontvangen',
    fine_received_desc = 'Je hebt een boete ontvangen van $%s',
    log_killed_title = 'Speler Gedood',
    log_killed_desc =
    '> *%s [%s] heeft %s [%s] gedood\n\n**Informatie van de Dader:**\nNaam: `%s`\nSpeler ID: `%s`\nIdentificatie: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n**Informatie van het Slachtoffer:**\nPersonage Naam: `%s`\nSpeler ID: `%s`\nIdentificatie: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n> **Doodsoorzaak:** `%s`',
    log_suicide_title = 'Speler Heeft Zelfmoord Gepleegd',
    log_suicide_desc =
    '> %s [%s] heeft zelfmoord gepleegd\n\n**Informatie van de Speler:**\nNaam: `%s`\nSpeler ID: `%s`\nIdentificatie: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n> **Doodsoorzaak:** `%s`',
    unknown = 'ONBEKEND',
    log_admin_revive_title = 'Beheerder Heeft Speler Herrezen',
    log_admin_revive_desc =
    '> *%s [%s] heeft %s [%s] als beheerder herrezen\n\n**Informatie van het Doelwit:**\nNaam: `%s`\nSpeler ID: `%s`\nIdentificatie: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n**Informatie van de Beheerder:**\nPersonage Naam: `%s`\nSpeler ID: `%s`\nIdentificatie: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    log_self_revive_title = 'Beheerder Heeft Zichzelf Herrezen',
    log_self_revive_desc =
    '> %s [%s] heeft zichzelf als beheerder herrezen\n\n**Informatie van de Speler:**\nNaam: `%s`\nSpeler ID: `%s`\nIdentificatie: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    log_death_logs = 'Doodlogs',
    log_revive_logs = 'Herleeflogs',
    log_combat_logs = 'Gevechtslogs',
    log_combatlog_title = 'Gevechtslogboek',
    log_combatlog_desc =
    '> %s [%s] gevechtslogboek \n\n**Spelerinformatie:**\nNaam: `%s`\nSpeler-ID: `%s`\nIdentificator: `%s`\nSteam: `%s`\nDiscord: `%s`\nLicentie: `%s`\nLicentie2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    medbag_crutch = 'Kruk',
    medbag_crutch_desc = 'Een kruk om patiënten te helpen bij het lopen',
    menu_crutch = 'Kruk Toepassen',
    menu_crutch_desc = 'Voeg een kruk toe aan een nabije patiënt',
    medbag_chair = 'Rolstoel',
    medbag_chair_desc = 'Een rolstoel om patiënten te helpen die niet kunnen lopen',
    menu_chair = 'Rolstoel Toepassen',
    menu_chair_desc = 'Voeg een rolstoel toe aan een nabije patiënt',
    shot = 'schot',
    stabbed = 'steek',
    beat = 'slagkrachtig letsel',
    burned = 'verbrand',
    other = 'onbekend',
    JobMenuTitle = 'EMS Menu',
    dispatch = 'Dispatch',
    dispatch_desc = 'Controleer of er spelers zijn die hulp nodig hebben',
    DispatchMenuTitle = 'Dispatch',
    GoBack = 'Terug',
    key_map_text = 'Ambulance Job Menu',
    assistance_title = 'Hulp Gevraagd',
    assistance_desc = 'Iemand heeft medische hulp gevraagd!',
    respawn_available_in = 'Herstart beschikbaar in ~r~%s minuten %s seconden~s~\n',
    respawn_bleedout_in = 'Je zult doodbloeden in ~r~%s minuten %s seconden~s~\n',
    respawn_bleedout_prompt = 'Houd [~r~E~s~] ingedrukt om te herstarten',
    distress_send = 'Druk op [~r~G~s~] om een noodsignaal naar EMS te sturen',
    distress_sent_title = 'Hulp Gevraagd',
    distress_sent_desc = 'Een noodsignaal is naar beschikbare eenheden gestuurd!',
    route_set_title = 'Route Ingesteld',
    route_set_desc = 'Een waypoint is ingesteld naar de persoon in nood!',
    diagnose_patient = 'Diagnosticeer',
    diagnose_patient_desc = 'Diagnoseer de dichtstbijzijnde gewonde persoon',
    no_requests = 'Geen actieve verzoeken',
    revive_patient = 'Herleef',
    revive_patient_desc = 'Probeer een nabije persoon te herleven',
    heal_patient = 'Genees',
    heal_patient_desc = 'Probeer een nabije persoon te genezen',
    sedate_patient = 'Sedeer',
    sedate_patient_desc = 'Dien tijdelijk een kalmerend middel toe aan een nabije persoon',
    drag_patient = 'Slepen',
    drag_patient_desc = 'Sleep een nabij gewonde persoon',
    place_stretcher_target = 'Voeg of Verwijder Patiënt Toe',
    place_patient = 'Plaats in/uit Voertuig',
    place_patient_desc = 'Plaats bewusteloze nabije persoon in/uit voertuig',
    no_nearby = 'Niet Gevonden',
    no_nearby_desc = 'Er lijkt niemand in de buurt te zijn',
    no_injury = 'Geen Letsel',
    no_injury_desc = 'De persoon lijkt geen behandeling nodig te hebben',
    no_injury_dead_desc =
    'De patiënt lijkt geen aanvullende behandeling nodig te hebben. Probeer de defibrillator te gebruiken en hoop op het beste!',
    player_injury = 'Persoon Gewond',
    player_injury_desc = 'Deze persoon lijkt een %s wond te hebben',
    player_not_unconscious = 'Speler Bewust',
    player_not_unconscious_desc = 'Het lijkt erop dat de speler bij bewustzijn is',
    player_unconscious = 'Speler Bewusteloos',
    player_unconscious_desc = 'De patiënt moet bij bewustzijn zijn voor deze behandeling!',
    player_reviving = 'Bezig met reanimeren',
    player_reviving_desc = 'Bezig met reanimeren van de patiënt',
    player_noitem = 'Ontbrekend Item',
    player_noitem_desc = 'Je hebt het vereiste item niet voor dit!',
    player_successful_revive = 'Herrezen',
    player_successful_revive_reward_desc = 'Je hebt de patiënt succesvol gereanimeerd en $%s verdiend!',
    player_successful_revive_desc = 'Je hebt de patiënt succesvol gereanimeerd!',
    player_healing = 'Aan het Genezen',
    player_healing_desc = 'Bezig met het genezen van de patiënt',
    player_successful_heal = 'Genezen',
    player_successful_heal_desc = 'Patiënt succesvol genezen!',
    player_healed_desc = 'Je bent succesvol genezen door de medic!',
    not_medic = 'Onbevoegd',
    not_medic_desc = 'Je bent niet opgeleid om dit te gebruiken!',
    target_sedated = 'Gesedeerd',
    target_sedated_desc = 'Je bent verdoofd door een medische professional',
    player_successful_sedate_desc = 'Je hebt de patiënt succesvol verdoofd',
    drop_bag_ui = '[E] - Tas Laten Vallen',
    drop_stretch_ui = '[E] - Brancard Plaatsen',
    pickup_bag_target = 'Ophalen',
    move_target = 'Verplaatsen',
    interact_bag_target = 'Openen',
    successful = 'Succesvol',
    medbag_pickup = 'Je hebt de medische tas opgepakt',
    medbag_pickup_civ = 'Je hebt de tas doorzocht en hebt meegenomen wat van nut zou zijn',
    stretcher_pickup = 'Je hebt de brancard teruggestuurd naar de ambulance waar hij vandaan kwam',
    medbag = 'Medische Tas',
    medbag_tweezers = 'Pincet',
    medbag_tweezers_desc = 'Gebruikt om kogels te verwijderen',
    medbag_suture = 'Hechtingsset',
    medbag_suture_desc = 'Gebruikt om wonden te hechten',
    medbag_icepack = 'IJspak',
    medbag_icepack_desc = 'Gebruikt om zwelling te verminderen',
    medbag_burncream = 'Brandwondenzalf',
    medbag_burncream_desc = 'Gebruikt om brandwonden te behandelen',
    medbag_defib = 'Defibrillator',
    medbag_defib_desc = 'Voor het reanimeren van patiënten',
    medbag_medikit = 'Medikit',
    medbag_medikit_desc = 'Gebruikt voor het genezen van patiënten',
    medbag_sedative = 'Verdovingsmiddel',
    medbag_sedative_desc = 'Gebruikt om patiënten te verdoven',
    medbag_stretcher = 'Opvouwbare Brancard',
    medbag_stretcher_desc = 'Gebruikt voor het verplaatsen van patiënten',
    item_grab = 'Je hebt een instrument uit je medische tas gehaald',
    wrong_equipment = 'Verkeerde Uitrusting!',
    wrong_equipment_desc = 'Ben je wel opgeleid?',
    player_not_injured = 'Niet Gewond',
    player_not_injured_desc =
    'Deze persoon lijkt geen extra behandeling nodig te hebben en is klaar voor de defibrillator',
    player_treated = 'Behandeld',
    player_treated_desc = 'Je hebt de patiënt succesvol behandeld',
    revive_command_help = 'Een beheerderscommando om spelers te reanimeren',
    revive_command_arg = 'Het speler-ID',
    reviveall_command_help = 'Een beheerderscommando om elke speler te reanimeren',
    revivearea_command_help = 'Een beheerderscommando om nabije spelers te reanimeren',
    revivearea_command_arg = 'Gebied om spelers te reanimeren',
    resetdeathcount_command_help = 'Een beheerderscommando om het aantal sterfgevallen van spelers te resetten',
    resetdeathcount_command_arg = 'Het speler-ID',
    viewdeathcount_command_help = 'Een commando om je aantal sterfgevallen te bekijken',
    alive_again = 'Levend',
    alive_again_desc = 'Je bent afgezet door een lokale bewoner bij het ziekenhuis!',
    request_supplies_target = 'Medische Benodigdheden',
    currency = '$',
    not_enough_funds = 'Onvoldoende Fondsen',
    not_enough_funds_desc = 'Je hebt niet genoeg geld!',
    hospital_garage = 'Ziekenhuisgarage',
    used_meditkit = 'Medkit Gebruikt',
    used_medikit_desc = 'Je hebt jezelf weten te verzorgen',
    action_cancelled = 'Actie Geannuleerd',
    action_cancelled_desc = 'Je hebt je laatste actie geannuleerd!',
    healing_self_prog = 'Behandelen van Wonden',
    checkin_hospital = 'Succes',
    checkin_hospital_desc = 'Je bent succesvol behandeld door het ziekenhuispersoneel',
    max_ems = 'Maximaal Aantal Medewerkers',
    max_ems_desc = 'Er zijn genoeg medewerkers in de stad! Vraag om hulp!',
    player_busy = 'Bezig',
    player_busy_desc = 'Je bent momenteel te druk om deze actie uit te voeren!',
    cloakroom = 'Kleedkamer',
    civilian_wear = 'Burgerkleding',
    bill_patient = 'Patiënt Factureren',
    bill_patient_desc = 'Stuur een factuur naar een nabije patiënt',
    invalid_entry = 'Ongeldige Invoer',
    invalid_entry_desc = 'Je invoer was ongeldig!',
    medical_services = 'Medische Diensten',
    hospital = 'Ziekenhuis',
    interact_stretcher_ui = '[E] - Interageren',
    stretcher_menu_title = 'Stretcher Interacties',
    open_shop_ui = '[E] - Apotheek Openen'

}

UIStrings = {
    player_dying = "JE GAAT DOOD",
    player_passed = "JE BENT OVERLEDEN",
    ems_on_the_way = "Nooddiensten zijn onderweg!",
    press_ems_services = "voor Nooddiensten",
    press_for_light = "om het licht te zien",
    hold = "Houden",
    time_to_respawn = "Tijd tot respawn",
    press = "Druk",
    player_hurt_critical = "Kritieke toestand!",
    player_hurt_severe = "Je bent ernstig gewond",
    player_hurt_unconscious = "Bewusteloos",
    player_hurt_unconscious_direct = "Je bent bewusteloos",
    player_hurt_find_help_or_ems = "Druk op <span class='color'>G</span> om noodhulp aan te vragen",
    player_hurt_time_to_live = "Bloedt uit",
    player_hurt_auto_respawn = "Levensfuncties vervagen",
    player_hurt_respawn = "Druk op E om het licht te zien",

    ems_online = "HULP IS ONLINE",
    ems_offline = "HULP NIET BESCHIKBAAR",
    currently_online = "MOMENTEEL ONLINE: "
}
