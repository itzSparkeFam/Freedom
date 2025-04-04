-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.Language ~= 'de' then return end

Strings = {
    no_society_account = '[^3WARNUNG^0] Gesellschaftskonto existiert nicht für: %s',
    ems_worker = 'Rettungsdienstmitarbeiter',
    not_authorized = 'Nicht autorisiert',
    not_authorized_desc = 'Sie sind nicht berechtigt, dies zu verwenden!',
    not_on_duty = 'Nicht im Dienst',
    not_on_duty_desc = 'Sie sind nicht im Dienst!',
    gps_enabled = 'GPS aktiviert',
    gps_enabled_desc = 'Sie haben Ihr GPS aktiviert',
    gps_disabled = 'GPS deaktiviert',
    gps_disabled_desc = 'Sie haben Ihr GPS deaktiviert',

    possible_cause = 'Mögliche Ursache',

    full_name = 'Name',
    pulse = 'Puls',
    bpm = 'BPM: %s',
    bleed_rate = 'Blutungsrate',
    bleed_rate_low = 'Niedrig',
    bleed_rate_medium = 'Mittel',
    bleed_rate_high = 'Hoch',
    no_name = 'Kein Name',
    injuries = 'Aktuelle Verletzungen',


    get_off_stretcher_ui = '[E] - Von der Trage absteigen',
    move = 'Bewegen',
    move_desc = 'Die Trage bewegen',
    put_in_vehicle = 'In Fahrzeug legen',
    stretcher_in_vehicle = 'Trage im Fahrzeug ablegen',
    put_in_vehicle_desc = 'Die Trage in ein Fahrzeug legen',
    place_on_stretcher = 'Patient platzieren',
    place_on_stretcher_desc = 'Einen Patienten auf die Trage legen',
    remove_from_stretcher = 'Patient entfernen',
    remove_from_stretcher_desc = 'Einen Patienten von der Trage nehmen',
    not_found = 'Nicht gefunden',
    already_occupied_ambulance = 'Bereits besetzt',
    already_occupied_ambulance_desc = 'Dieser Krankenwagen ist bereits besetzt!',
    already_occupied_stretcher = 'Bereits besetzt',
    already_occupied_stretcher_desc = 'Diese Trage ist bereits besetzt!',
    vehicle_occupied = 'Fahrzeug besetzt',
    vehicle_occupied_desc = 'Dies kann nicht gemacht werden, während jemand fährt!',
    not_occupied_stretcher = 'Nicht besetzt',
    not_occupied_stretcher_desc = 'Diese Trage ist nicht besetzt!',
    stretcher_placement_blocked = 'Platzierung blockiert',
    stretcher_placement_blocked_desc = 'Die Trage kann hier nicht platziert werden!',
    knocked_out = 'Ausgeschaltet',
    knocked_out_desc = 'Du wurdest k.o. geschlagen!',
    checkin_cooldown = 'Check-in Abkühlung',
    checkin_cooldown_desc = 'Du versuchst zu schnell einzuchecken, bitte warte einen Moment.',
    checkingin_progress = 'Check-in läuft...',
    remove_dead_target = 'Bewusstlose Person entfernen',
    ply_injury_head = 'Kopf',
    ply_injury_neck = 'Nacken',
    ply_injury_spine = 'Wirbelsäule',
    ply_injury_upper = 'Oberkörper',
    ply_injury_lower = 'Unterkörper',
    ply_injury_left_arm = 'linker Arm',
    ply_injury_left_leg = 'linkes Bein',
    ply_injury_right_arm = 'rechter Arm',
    ply_injury_right_leg = 'rechtes Bein',
    diagnosing_patient_progress = 'Patient wird diagnostiziert...',
    treating_patient_progress = 'Patient wird behandelt...',
    recovering_progress = 'Erholung läuft...',
    injury_report = 'Verletzungsbericht',
    none = 'Keine',
    mild = 'Leicht',
    moderate = 'Mäßig',
    severe = 'Schwer',
    deadly = 'Tödlich',
    injury_report_locations = 'Ort',
    injury_report_type = 'Verletzungstyp: %s',
    injury_report_severity = 'Schweregrad: %s',
    injury_report_bleed = 'Blutverlust',
    light_injury_title = 'Leichte Verletzung',
    moderate_injury_title = 'Mäßige Verletzung',
    extreme_injury_title = 'Extreme Verletzung',
    injury_bleed_notify = 'Verletzungs- und Blutungsbenachrichtigung',
    light_injury_desc = 'Dein %s ist verletzt, erwäge einen Arztbesuch!',
    moderate_injury_desc = 'Dein %s ist stark verletzt, du brauchst einen Arzt!',
    extreme_injury_desc = 'Dein %s ist extrem verletzt. Du musst zum Arzt, bevor es zu spät ist!',
    injury_msg_one = 'Du hast eine erhebliche Verletzung.',
    injury_msg_two = 'Du hast eine schwere Verletzung.',
    injury_msg_three = 'Du hast eine sehr schwere Verletzung.',
    injury_msg_four = 'Du hast eine kritische Verletzung.',
    bleed_msg_one = 'Du blutest.',
    bleed_msg_two = 'Du blutest stark. Druck ausüben.',
    bleed_msg_three = 'Du wirst verbluten!',
    fainted_title = 'Ohnmächtig',
    fainted_so_high_desc = 'Du bist ohnmächtig geworden, weil du so high warst.',
    cant_jump_title = 'Kann nicht springen!',
    cant_jump_desc = 'Du bist zu verletzt, um zu springen',
    blackout_title = 'Bewusstlosigkeit',
    blackout_desc = 'Du hast wegen deiner %s Verletzung das Bewusstsein verloren! Suche sofort medizinische Hilfe!',
    treated_fully_desc = 'Du wurdest behandelt und fühlst dich besser als je zuvor!',
    treated_not_fully_desc = 'Du wurdest behandelt, benötigst aber weitere Behandlung.',
    prescription_menu = 'Rezeptmenü',
    prescription_menu_desc = 'Rezepte abrufen und verwalten',
    no_stretcher_detected = 'Keine Trage erkannt',
    no_stretcher_detected_desc = 'Es wurde keine aktive Trage erkannt!',
    cant_run = 'Kann nicht sprinten',
    cant_run_desc = 'Du bist zu verletzt, um zu sprinten!',
    no_back_seat = 'Keine verfügbaren Sitze',
    no_back_seat_desc = 'In diesem Krankenwagen gibt es hinten keine Sitze',
    enter_vehicle_back = 'Krankenwagen (hinten) betreten',
    stretcher_already_deployed = 'Trage bereits eingesetzt',
    stretcher_already_deployed_desc = 'Die diesem Krankenwagen zugeordnete Trage wurde bereits entfernt.',
    send_stretcher_home = 'Zum Fahrzeug zurückkehren',
    ambulance_not_found = 'Die Trage wurde entfernt, aber der Krankenwagen wurde nicht gefunden, um zurückzukehren!',
    bleedout = 'Blutung',
    player_injury_critical_desc = 'Spieler ist in kritischem Zustand aufgrund einer %s Wunde!',
    gps_active = 'GPS aktiviert',
    gps_active_desc = 'Spieler %s hat sein GPS aktiviert',
    gps_deactive = 'GPS deaktiviert',
    gps_deactive_desc = 'Spieler %s hat sein GPS deaktiviert',
    no_wsb = '^0[^3WARNUNG^0] wasabi_bridge wurde NICHT gestartet NACH Framework und/oder VOR Ressource: %s',
    spawn_blocked = 'Garage blockiert',
    spawn_blocked_desc = 'Du kannst dein Fahrzeug nicht herausfahren, da es blockiert ist!',
    menu_remove_crutch = 'Krücke entfernen',
    menu_remove_crutch_desc = 'Entfernen Sie eine Krücke von einem nahegelegenen Patienten',
    menu_remove_chair = 'Rollstuhl entfernen',
    menu_remove_chair_desc = 'Entfernen Sie einen Rollstuhl von einem nahegelegenen Patienten',
    toggle_stretcher = 'Trage nehmen',
    toggle_stretcher_desc = 'Nehmen Sie die Trage aus dem nächstgelegenen Fahrzeug',
    no_vehicle_nearby = 'Fahrzeug',
    no_vehicle_nearby_desc = 'Es ist kein Fahrzeug in der Nähe',
    no_ambulance_nearby_desc = 'Es ist kein Krankenwagen in der Nähe',
    on_duty = 'Im Dienst',
    on_duty_desc = 'Sie haben gerade zum Dienst gewechselt!',
    off_duty = 'Außer Dienst',
    off_duty_desc = 'Sie haben gerade den Dienst beendet!',
    amount = 'Betrag',
    mr = 'Herr',
    mrs = 'Frau',
    debt_collection = 'Schuldeintreibung',
    db_email =
    'Sehr geehrte/r %s %s, <br /><br />Die Zentrale Justiz-Einzugsstelle (CJCA) hat die von der Polizei erhaltenen Strafen eingezogen.<br />Es wurden <strong>$%s</strong> von Ihrem Konto abgebucht.<br /><br />Mit freundlichen Grüßen,<br />Herr Wasabi',
    fine_sent = 'Strafen gesendet',
    fine_sent_desc = 'Sie haben erfolgreich eine Strafe über $%s gesendet!',
    fine_received = 'Strafe erhalten',
    fine_received_desc = 'Sie haben eine Strafe über $%s erhalten',
    log_killed_title = 'Spieler getötet',
    log_killed_desc =
    '> *%s [%s] hat %s [%s] getötet\n\n**Informationen des Täters:**\nName: `%s`\nSpieler-ID: `%s`\nKennzeichner: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n**Informationen des Opfers:**\nCharaktername: `%s`\nSpieler-ID: `%s`\nKennzeichner: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n> **Todesursache:** `%s`',
    log_suicide_title = 'Spieler beging Selbstmord',
    log_suicide_desc =
    '> %s [%s] hat Selbstmord begangen\n\n**Spielerinformationen:**\nName: `%s`\nSpieler-ID: `%s`\nKennzeichner: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n> **Todesursache:** `%s`',
    unknown = 'UNBEKANNT',
    log_admin_revive_title = 'Spieler von Admin wiederbelebt',
    log_admin_revive_desc =
    '> *%s [%s] hat %s [%s] von einem Admin wiederbelebt\n\n**Informationen des Ziels:**\nName: `%s`\nSpieler-ID: `%s`\nKennzeichner: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||\n\n**Informationen des Admins:**\nCharaktername: `%s`\nSpieler-ID: `%s`\nKennzeichner: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    log_self_revive_title = 'Admin hat sich selbst wiederbelebt',
    log_self_revive_desc =
    '> %s [%s] hat sich selbst wiederbelebt\n\n**Spielerinformationen:**\nName: `%s`\nSpieler-ID: `%s`\nKennzeichner: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    log_death_logs = 'Todesprotokolle',
    log_revive_logs = 'Wiederbelebungsprotokolle',
    log_combat_logs = 'Kampfprotokolle',
    log_combatlog_title = 'Kampfprotokoll',
    log_combatlog_desc =
    '> %s [%s] Kampfprotokoll \n\n**Spielerinformationen:**\nName: `%s`\nSpieler-ID: `%s`\nKennung: `%s`\nSteam: `%s`\nDiscord: `%s`\nLizenz: `%s`\nLizenz2: `%s`\nXBL: `%s`\nFiveM: `%s`\nIP: ||%s||',
    medbag_crutch = 'Krücke',
    medbag_crutch_desc = 'Eine Krücke, um Patienten beim Gehen zu helfen',
    menu_crutch = 'Krücke anwenden',
    menu_crutch_desc = 'Fügen Sie einem nahegelegenen Patienten eine Krücke hinzu',
    medbag_chair = 'Rollstuhl',
    medbag_chair_desc = 'Ein Rollstuhl, um Patienten zu helfen, die nicht laufen können',
    menu_chair = 'Rollstuhl anwenden',
    menu_chair_desc = 'Fügen Sie einem nahegelegenen Patienten einen Rollstuhl hinzu',
    shot = 'Schusswunde',
    stabbed = 'Stichwunde',
    beat = 'Schlagverletzung',
    burned = 'Verbrennung',
    other = 'unbekannt',
    JobMenuTitle = 'EMS Menü',
    dispatch = 'Einsatzleitung',
    dispatch_desc = 'Nach Spielern suchen, die Hilfe benötigen',
    DispatchMenuTitle = 'Einsatzleitung',
    GoBack = 'Zurück',
    key_map_text = 'Menü für Krankenwagen-Job',
    assistance_title = 'Hilfe angefordert',
    assistance_desc = 'Jemand hat medizinische Hilfe angefordert!',
    respawn_available_in = 'Wiederbelebung verfügbar in ~r~%s Minuten %s Sekunden~s~\n',
    respawn_bleedout_in = 'Sie werden in ~r~%s Minuten %s Sekunden~s~ verbluten\n',
    respawn_bleedout_prompt = 'Halten Sie [~r~E~s~] gedrückt, um wiederzubeleben',
    distress_send = 'Drücken Sie [~r~G~s~], um ein Notrufsignal an den EMS zu senden',
    distress_sent_title = 'Hilfe angefordert',
    distress_sent_desc = 'Notrufsignal wurde an verfügbare Einheiten gesendet!',
    route_set_title = 'Route festgelegt',
    route_set_desc = 'Ein Wegpunkt wurde zur notleidenden Person gesetzt!',
    diagnose_patient = 'Diagnostizieren',
    diagnose_patient_desc = 'Diagnostizieren Sie die nächstgelegene verletzte Person',
    no_requests = 'Keine aktiven Anfragen',
    revive_patient = 'Wiederbeleben',
    revive_patient_desc = 'Versuchen Sie, eine nahegelegene Person wiederzubeleben',
    heal_patient = 'Heilen',
    heal_patient_desc = 'Versuchen Sie, eine nahegelegene Person zu heilen',
    sedate_patient = 'Sedieren',
    sedate_patient_desc = 'Sedieren Sie eine nahegelegene Person vorübergehend',
    drag_patient = 'Ziehen',
    drag_patient_desc = 'Ziehen Sie eine nahegelegene verletzte Person',
    place_stretcher_target = 'Patient hinzufügen oder entfernen',
    place_patient = 'Im/aus dem Fahrzeug platzieren',
    place_patient_desc = 'Platzieren Sie eine nahegelegene bewusstlose Person im/aus dem Fahrzeug',
    no_nearby = 'Nicht gefunden',
    no_nearby_desc = 'Es scheint niemanden in der Nähe zu geben',
    no_injury = 'Keine Verletzung',
    no_injury_desc = 'Die Person scheint keine Behandlung zu benötigen',
    no_injury_dead_desc =
    'Der Patient scheint keine zusätzliche Behandlung zu benötigen. Versuchen Sie, den Defibrillator zu benutzen und hoffen Sie auf das Beste!',
    player_injury = 'Person verletzt',
    player_injury_desc = 'Diese Person hat eine %s Verletzung',
    player_not_unconscious = 'Spieler bei Bewusstsein',
    player_not_unconscious_desc = 'Es scheint, dass der Spieler bei Bewusstsein ist',
    player_unconscious = 'Spieler bewusstlos',
    player_unconscious_desc = 'Der Patient muss bei dieser Behandlung bei Bewusstsein sein!',
    player_reviving = 'Wiederbeleben',
    player_reviving_desc = 'Wiederbelebung des Patienten im Gange',
    player_noitem = 'Fehlendes Objekt',
    player_noitem_desc = 'Ihnen fehlt das erforderliche Objekt dafür!',
    player_successful_revive = 'Erfolgreich wiederbelebt',
    player_successful_revive_reward_desc = 'Sie haben den Patienten erfolgreich wiederbelebt und $%s verdient!',
    player_successful_revive_desc = 'Sie haben den Patienten erfolgreich wiederbelebt!',
    player_healing = 'Heilung',
    player_healing_desc = 'Heilung des Patienten im Gange',
    player_successful_heal = 'Erfolgreich geheilt',
    player_successful_heal_desc = 'Patient erfolgreich geheilt!',
    player_healed_desc = 'Sie wurden erfolgreich vom Sanitäter geheilt!',
    not_medic = 'Unbefugt',
    not_medic_desc = 'Sie sind nicht befugt, dies zu verwenden!',
    target_sedated = 'Sediert',
    target_sedated_desc = 'Sie wurden von einem medizinischen Fachmann sediert',
    player_successful_sedate_desc = 'Sie haben den Patienten erfolgreich sediert',
    drop_bag_ui = '[E] - Tasche ablegen',
    drop_stretch_ui = '[E] - Trage ablegen',
    pickup_bag_target = 'Aufheben',
    move_target = 'Bewegen',
    interact_bag_target = 'Öffnen',
    successful = 'Erfolgreich',
    medbag_pickup = 'Sie haben die medizinische Tasche aufgehoben',
    medbag_pickup_civ = 'Sie haben die Tasche durchsucht und das mitgenommen, was nützlich sein könnte',
    stretcher_pickup = 'Sie haben die Trage zum Krankenwagen zurückgeschickt, von dem sie genommen wurde',
    medbag = 'Medizinische Tasche',
    medbag_tweezers = 'Pinzette',
    medbag_tweezers_desc = 'Verwendet, um Kugeln zu entfernen',
    medbag_suture = 'Naht-Set',
    medbag_suture_desc = 'Verwendet, um Wunden zu nähen',
    medbag_icepack = 'Kühlpack',
    medbag_icepack_desc = 'Verwendet, um Schwellungen zu reduzieren',
    medbag_burncream = 'Brandcreme',
    medbag_burncream_desc = 'Verwendet, um Verbrennungen zu behandeln',
    medbag_defib = 'Defibrillator',
    medbag_defib_desc = 'Zur Wiederbelebung von Patienten',
    medbag_medikit = 'Medizinisches Set',
    medbag_medikit_desc = 'Verwendet zur Heilung von Patienten',
    medbag_sedative = 'Beruhigungsmittel',
    medbag_sedative_desc = 'Verwendet, um Patienten zu beruhigen',
    medbag_stretcher = 'Faltbare Trage',
    medbag_stretcher_desc = 'Verwendet zum Transport von Patienten',
    item_grab = 'Sie haben ein Werkzeug aus Ihrer medizinischen Tasche genommen',
    wrong_equipment = 'Falsche Ausrüstung!',
    wrong_equipment_desc = 'Haben Sie überhaupt eine Schulung absolviert?',
    player_not_injured = 'Nicht verletzt',
    player_not_injured_desc =
    'Diese Person scheint keine zusätzliche Behandlung zu benötigen und ist für den Defibrillator bereit',
    player_treated = 'Behandelt',
    player_treated_desc = 'Sie haben den Patienten erfolgreich behandelt',
    revive_command_help = 'Ein Administrator-Befehl, um Spieler wiederzubeleben',
    revive_command_arg = 'Die Spieler-ID',
    reviveall_command_help = 'Ein Administrator-Befehl, um alle Spieler wiederzubeleben',
    revivearea_command_help = 'Ein Administrator-Befehl, um nahegelegene Spieler wiederzubeleben',
    revivearea_command_arg = 'Bereich zum Wiederbeleben von Spielern',
    resetdeathcount_command_help = 'Ein Administrator-Befehl, um den Todeszähler eines Spielers zurückzusetzen',
    resetdeathcount_command_arg = 'Die Spieler-ID',
    viewdeathcount_command_help = 'Ein Befehl, um Ihren Todeszähler anzuzeigen',
    alive_again = 'Wieder am Leben',
    alive_again_desc = 'Sie wurden von einem Einheimischen ins Krankenhaus gebracht!',
    request_supplies_target = 'Medizinische Vorräte',
    currency = 'USD',
    not_enough_funds = 'Nicht genug Geld',
    not_enough_funds_desc = 'Sie haben nicht genug Geld!',
    hospital_garage = 'Krankenhausgarage',
    used_meditkit = 'Medkit verwendet',
    used_medikit_desc = 'Du hast es geschafft, dich selbst zu versorgen',
    action_cancelled = 'Aktion abgebrochen',
    action_cancelled_desc = 'Du hast deine letzte Aktion abgebrochen!',
    healing_self_prog = 'Behandlung von Wunden',
    checkin_hospital = 'Erfolg',
    checkin_hospital_desc = 'Du wurdest erfolgreich vom Krankenhauspersonal behandelt',
    max_ems = 'Mediziner verfügbar',
    max_ems_desc = 'Es gibt genügend Mediziner in der Stadt! Fordere Hilfe an!',
    player_busy = 'Beschäftigt',
    player_busy_desc = 'Du bist derzeit zu beschäftigt, um diese Aktion auszuführen!',
    cloakroom = 'Umkleideraum',
    civilian_wear = 'Zivilkleidung',
    bill_patient = 'Patient abrechnen',
    bill_patient_desc = 'Sende einem Patienten in der Nähe eine Rechnung',
    invalid_entry = 'Ungültig',
    invalid_entry_desc = 'Deine Eingabe war ungültig!',
    medical_services = 'Medizinische Dienste',
    hospital = 'Krankenhaus',
    interact_stretcher_ui = '[E] - Interagieren',
    stretcher_menu_title = 'Interaktionen mit der Trage',
    open_shop_ui = '[E] - Apotheke öffnen'

}

UIStrings = {
    player_dying = "DU BIST AM STERBEN",
    player_passed = "DU BIST VERSTORBEN",
    ems_on_the_way = "Rettungsdienste sind unterwegs!",
    press_ems_services = "für Rettungsdienste",
    press_for_light = "um das Licht zu sehen",
    hold = "Halten",
    time_to_respawn = "Verbleibende Zeit bis zur Wiederbelebung",
    press = "Drücken",
    player_hurt_critical = "Kritischer Zustand!",
    player_hurt_severe = "Du bist schwer verletzt",
    player_hurt_unconscious = "Bewusstlos",
    player_hurt_unconscious_direct = "Du bist bewusstlos",
    player_hurt_find_help_or_ems = "Drücken Sie <span class='color'>G</span>, um Notdienste anzufordern",
    player_hurt_time_to_live = "Verblutend",
    player_hurt_auto_respawn = "Lebenszeichen schwinden",
    player_hurt_respawn = "Drücken Sie E, um das Licht zu sehen",

    ems_online = "HILFE IST ONLINE",
    ems_offline = "HILFE NICHT VERFÜGBAR",
    currently_online = "DERZEIT ONLINE: "
}
