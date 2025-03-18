Locales['fr'] = {
    PERMISSION = {
        NOT_ENOUGH_RANK = "Vous devez avoir un rang plus élevé pour accéder à cette commande.",
        GENERAL_MESSAGE = "A accès : %s",
    },

    START_CLEANING_LABEL = "Commencer le nettoyage",

    ALCATRAZ_TELEPORT_TO_MAP = "Vous avez été transféré à Los Santos !",

    RESTRICT_ZONE = {
        NOT_IN_ZONE = "Cette commande peut être utilisée uniquement dans une zone restreinte ! (%s)",
    },

    CHAT = {
        COMMAND_STOPALARM = "Commande utilisée pour arrêter l'alarme",
        COMMAND_JAIL = "Commande utilisée pour emprisonner",
        COMMAND_UNJAIL = "Commande utilisée pour libérer",
        COMMAND_STARTCS = "Commande utilisée pour démarrer le service communautaire",
        COMMAND_JAILCP = "Prison MDT",
        COMMAND_REMOVECS = "Commande utilisée pour retirer le service communautaire",
        COMMAND_RESETESCAPE = "Commande utilisée pour réinitialiser l'évasion de prison",
        COMMAND_SOLITARY = "Commande utilisée pour mettre en cellule d'isolement",
        COMMAND_RSOLITARY = "Commande utilisée pour retirer de la cellule d'isolement",
    },

    COMMANDS_MESSAGES = {
        INVALID_PLAYER_ID = "Joueur invalide - ID du joueur non valide !",
        INVALID_JAIL_TIME = "Temps de prison invalide - valeur du temps manquante !",
        INVALID_JAIL_TIME_VALUE = "Temps de prison invalide - doit être un nombre > 0 !",
        PLAYER_NEEDS_TO_BE_JAILED = "Le joueur doit d'abord être emprisonné !",
        PLAYER_ALREADY_HAS_SENTENCE = "Le joueur a déjà une peine active !",
        RESOURCE_LOADING = "Ressource en cours de chargement, veuillez patienter 10 secondes !",
        TOO_FAR_AWAY = "Vous êtes trop loin du joueur !",
    },

    CAMERA_PROLOG = {
        WELCOME_TO_PRISON = "Bienvenue en ~o~prison~o~.",
        WELCOME_TO_ALCATRAZ = "Bienvenue à ~o~Alcatraz~o~.",
        ALCATRAZ_PEAK_INSIDE = "Jetons un coup d'œil à l'intérieur. ~o~Alcatraz~o~.",
        BASKETBALL_PLACE = "Il y a un endroit pour jouer au ~o~basket~o~",
        GYM_PLACE = "Vous pouvez rester en forme même en prison ~o~gym~o~",
        JOB_PLACE = "Vous pouvez faire des ~o~travaux~o~ et ~o~réduire~o~ votre peine de prison.",
        ACCOUNT_PLACE = "Créez votre ~o~compte de prisonnier~o~ chez ce Gardien.",
        CANTEEN_PLACE = "Vous avez faim ? Vous pouvez obtenir un ~o~repas gratuit~o~ ici.",
        BOOTH_PLACE = "Ici, vous trouverez des ~o~cabines téléphoniques~o~.",
    },

    HELPKEYS_LABELS = {
        CONFIRM = "Confirmer",
        EXIT_MENU = "Quitter le menu",
        INTERACT = "Interagir",
    },

    BOOTHS = {
        HANGUP_LABEL = "Appuyez pour raccrocher",
        DURATION_LABEL = "Durée : %ss",
        LEAVE_CALL_ENDED = "L'appel actuel a été terminé !",

        CALL_ENDED = "L'appel a été terminé !",
        CALL_STARTED_FAILED_SINCE_NO_PLAYER = "Impossible de démarrer l'appel car ce numéro n'est pas actif !",
        CALL_STARTED_FROM_BOOTH = "Vous avez démarré un appel depuis la cabine !",
        CALL_ENDED_FROM_BOOTH = "L'appel a été terminé depuis la cabine faute de réponse !",
    },

    RELEASE = {
        LABEL = "Libérer joueur",
        RELEASE_READY_TEXT = "Vous pouvez être libéré, rendez-vous au point de contrôle !",
        RELEASE_READY_SUBTITLE = "Un lieu vous a été marqué, où vous pouvez demander au Gardien d'être libéré !",
    },

    PLAYER_RELEASED = "Vous avez été libéré de prison !",
    CANNOT_BE_RELEASED = "Vous ne pouvez pas être libéré - restant : %s",
    CANNOT_BE_RELEASED_SINCE_HAVING_SOLITARY = "Vous ne pouvez pas être libéré de la prison car vous êtes en cellule d'isolement !",

    NOTIFY = {
        TITLE = "Prison"
    },

    DISPATCH = {
        BREAKOUT_MESSAGE = "Évasion de prison en cours !",
        BREAKOUT_ALERT = "Alerte ici !",
        BREAKOUT_BLIP_TEXT = "Évasion de prison",
        BREAKOUT_ACTIVE_MESSAGE = "Évasion de prison en cours !",
    },

    PROLOG = {
        SKIP_HELP_LABEL = "Pour sauter le prologue",
    },

    PRISON_BREAK_PROLOG_SUBTITLE = {
        START_FIRST = "Je vous ai ~h~marqué~h~ un lieu où vous pouvez percer le mur et sortir.",
        START_SEC = "Soyez ~h~prudent~h~ et ne vous faites pas ~h~attraper~h~ !",
        START_THIRD = "Soyez discret, ~h~les gardiens~h~ sont partout !",
        START_FOURTH = "Tâche : Évadez-vous de prison",
    },

    PRISON_BREAK = {
        NOT_ENOUGH_POLICE = "Désolé, mais il n'est pas possible de s'évader pour le moment !",

        INTERACT_CUTTERS = "Utiliser les pinces",
        INTERACT_PLACE_WOODEN_BAR = "Placer une barrière en bois",
        INTERACT_REPAIR_WALL = "Réparer le mur",
        CAUGHT_BY_GUARD = "Vous avez été attrapé par le gardien en coupant le mur !",

        ITEM_REQUIRED = "Vous devez avoir %s pour effectuer cette action !",
        NO_ITEM = "Vous n'avez pas l'élément requis pour effectuer cette action !",
        ACTIVE = "Je ne vais pas parler avec vous.",
        ACTIVATED = "Une évasion de prison a été activée ! Trouvez un moyen de vous échapper !",
        IS_NOT_ACTIVE = "L'évasion de prison n'est pas active !",

        WALL_BLIP_TEXT = "Point d'évasion : %s",
        INTERACT_NOT_DONE = "Il n'y a rien à réparer sur cet objet !",
        INTERACT_ALREADY_DONE = "Quelqu'un interagit déjà avec cet objet !",
        INTERACT_DONE = "Vous avez interagi avec succès avec cet objet !",
        NOT_AT_INTERACTION = "Vous n'êtes pas dans la zone d'interaction !",
        PRISONER_ESCAPED_RELEASE_MESSAGE = "Vous vous êtes évadé avec succès de la prison !",

        DISCORD_PRISONER_HAS_FINISHED_TASK_LABEL = "Le prisonnier a terminé la tâche",
        DISCORD_PRISONER_HAS_ESCAPED_FROM_PRISON_LABEL = "Le prisonnier s'est évadé de la prison",

        DISCORD_OOC_LABEL = "Nom OOC",
        DISCORD_CHAR_ID_LABEL = "ID du personnage",
        DISCORD_PLAYER_ID_LABEL = "ID du joueur",
        DISCORD_BREAK_TYPE_LABEL = "Type d'évasion",
        DISCORD_PATH_LAYER_LABEL = "Chemin de la couche",
        DISCORD_ZONE_ID_LABEL = "ID de la zone",
    },

    INVENTORY = {
        FULL_INVENTORY_CAN_CARRY_ITEM = "Votre inventaire est plein, vous ne pouvez pas transporter cet objet !",
    },

    JAIL = {
        WELCOME_BACK_TO_PRISON = "Bienvenue de retour en prison : peine restante : %s !",

        PLAYER_INPUT_LABEL = "Emprisonner un citoyen",
        PLAYER_INPUT_DESC = "Entrer la durée de prison",

        PLAYER_JAIL_TIME_NOT_NUMBER = "La durée de prison doit être un nombre",
        PLAYER_JAIL_TIME_REQUIRED = "La durée de prison est requise",
        PLAYER_CLOSEST_PLAYER_NOT_FOUND = "Impossible de trouver un citoyen à proximité.",
        PLAYER_CLOSEST_PLAYER_JAIL_SUCC = "Le citoyen est emprisonné.",
        PLAYER_CLOSEST_PLAYER_JAIL_FAIL = "Impossible d'emprisonner le citoyen, durée invalide.",
    },

    UNJAIL = {
        FAILED_TO_UNJAIL_TARGET_NOT_FOUND = "Impossible de libérer la cible, utilisateur introuvable !",
        FAILED_PLAYER_INPUT_LABEL = "Échec de la libération du joueur",

        PLAYER_INPUT_LABEL = "Libérer un citoyen",
        PLAYER_INPUT_DESC = "Appuyez sur Entrée pour confirmer.",

        PLAYER_NOT_CONFIRM = "Vous devez confirmer l'action de libération en appuyant sur Entrée.",
        PLAYER_NOT_CONFIRM_EMPTY = "Le formulaire était vide, vous devez confirmer l'action de libération en appuyant sur Entrée.",
    },

    LOGS_ACTIONS = {
        LOG_CITIZEN_JAILED_BY_OFFICER = "%s emprisonné par l'officier nommé %s",
        LOG_CITIZEN_PAROLLED_BY_OFFICER = "%s libéré sous caution par l'officier nommé %s",
        LOG_CITIZEN_CHANGED_SENTENCE_BY_OFFICER = "%s a vu sa peine modifiée de %s à %s",
        LOG_CITIZEN_CITIZEN_RELEASED_BY_OFFICER = "%s a été libéré par l'officier nommé %s",
        LOG_CITIZEN_CITIZEN_RELEASED_BY_OFFICER_FROM_PAROLLE = "%s a été libéré de sa conditionnel par l'officier nommé %s",
        LOG_CITIZEN_ESCAPED_PRISON = "%s s'est évadé de la prison",
        LOG_CITIZEN_PAROLLED = "%s a été libéré sous caution par %s pour un montant de %s",

    },

    LOGS_DISCORD = {
        PRISON_BREAK_TITLE_LABEL = "Session d'évasion de prison commencée",
        PRISON_BREAK_DESC_LABEL = "Le joueur a tenté de s'évader de la prison...",

        PRISONER_RELEASED_TITLE_LABEL = "Prisonnier libéré",
        PRISONER_RELEASED_DESC_LABEL = "Le joueur a été libéré de la prison",

        NEW_PRISONER_TITLE_LABEL = "Nouveau prisonnier",
        NEW_PRISONER_DESC_LABEL = "Le joueur a été emprisonné",

        CANTEEN_TITLE_LABEL = "Cantine de la prison",
        CANTEEN_DESC_LABEL = "Le joueur a pris son colis gratuit",
        CANTEEN_BOUGH_ITEM_LABEL = "Le joueur a acheté un objet",

        OOC_NAME = "Nom OOC",
        IC_NAME = "Nom IC",
        CHARACTER_ID = "ID du personnage",
        REMAINING_JAIL_TIME = "Temps de prison restant",
        JAIL_TIME = "Temps de prison",
        JAIL_REASON = "Raison de l'emprisonnement",
        ITEM = "Objet",
        AMOUNT = "Quantité",
        TOTAL_COST = "Coût total",
    },

    LOGS = {
        JAIL_LOG_TITLE = "Joueur emprisonné (%s)",
        JAIL_LOG_FIELD_PRISONER_NAME = "Nom du prisonnier",
        JAIL_LOG_FIELD_PRISONER_ID = "ID du prisonnier",
        JAIL_LOG_FIELD_CHAR_ID = "ID du personnage du prisonnier",
        JAIL_LOG_FIELD_JAIL_TIME = "Temps de prison",
        JAIL_LOG_FIELD_JAIL_REASON = "Raison de l'emprisonnement",
        JAIL_LOG_FIELD_JAILED_BY_OFFICER = "Emprisonné par",

        UNJAIL_LOG_TITLE = "Joueur libéré (%s)",
        UNJAIL_LOG_FIELD_PRISONER_NAME = "Nom du prisonnier",
        UNJAIL_LOG_FIELD_PRISONER_ID = "ID du prisonnier",
        UNJAIL_LOG_FIELD_CHAR_ID = "ID du personnage du prisonnier",
    },

    ANNOUCEMENT = {
        PRISON = "Prison",
        CITIZEN_JAILED_ANNOUCEMENT = "Le prisonnier nommé %s a été condamné à passer %s en prison !",
    },

    STASH = {
        YOU_DONT_HAVE_STASHED_ITEMS = "Vous n'avez pas d'objets stockés",
        ITEMS_RETURNED = "Vos objets stockés ont été retournés",
        VIRTUAL_MONEY_RETURNED = "Votre argent de poche stocké a été retourné pour un montant total de : %s",
        VIRTUAL_MONEY_SAVED = "Votre argent de poche a été sauvegardé pour un montant total de : %s",
    },

    OUTFITS = {
        WITH_TOP = "Tenue par défaut avec haut",
        WITHOUT_TOP = "Tenue par défaut sans haut",
    },

    CHAT_SUGGESTIONS = {
        JAIL_PLAYER_PARAM = "ID du joueur ou nom du joueur",
        JAIL_TIME_PARAM = "Temps en sec, min, heures, jours, semaines, mois",
        JAIL_PLAYER_HELP_PARAM = "Emprisonnez par ID de joueur ou utilisez le nom du joueur pour l'emprisonner",

        UNJAIL_PLAYER_PARAM = "ID du joueur ou nom du joueur",
        UNJAIL_PLAYER_HELP_PARAM = "Libérez par ID de joueur ou utilisez le nom du joueur pour le libérer",

        SOLITARY_PLAYER_PARAM = "ID du joueur ou nom du joueur",
        SOLITARY_PLAYER_HELP_PARAM = "Placez un joueur en cellule d'isolement par ID de joueur ou utilisez le nom du joueur pour le placer en cellule d'isolement",

        REMOVE_SOLITARY_PLAYER_PARAM = "ID du joueur ou nom du joueur",
        REMOVE_SOLITARY_PLAYER_HELP_PARAM = "Retirez un joueur de la cellule d'isolement par ID de joueur ou utilisez le nom du joueur pour le retirer de la cellule d'isolement",

        TIME_SEC = "Temps de prison en secondes",
        TIME_MIN = "Temps de prison en minutes",
        TIME_HOURS = "Temps de prison en heures",
        TIME_DAYS = "Temps de prison en jours",
        TIME_WEEK = "Temps de prison en semaines",
        TIME_MONTHS = "Temps de prison en mois",
    },

    CS = {
        DISPLAY_PEROLL_TIME = "Service communautaire restant : %s",

        STARTED_PEROLL = "Vous avez commencé votre service communautaire, allez à l'emplacement marqué !",

        AREA_CLEANED_RETURN = "Vous avez nettoyé la zone, retournez voir le gardien !",
        PEROLL_FINISHED = "Vous avez terminé votre service communautaire !",

        NOT_OWNER_OF_ZONE = "Vous n'êtes pas le propriétaire de cette zone !",

        NOT_IN_SWEEPING_STATE = "Vous n'êtes pas en état de balayage !",
        NOT_IN_RETURN_STATE = "Vous n'êtes pas en état de retour !",

        NOT_IN_OWN_ZONE = "Vous n'êtes pas dans votre zone !",

        NOT_IN_SWEEPING_RANGE = "Vous n'êtes pas dans la plage de balayage !",

        NOT_CS_USER = "Vous n'avez pas de service communautaire actif !",

        COMMUNITY_SERVICE_STARTED_PROLOG = "Bienvenue de retour ~o~%s~o~, il vous reste : (~y~%s~y~ sur ~y~%s~y~)",
        COMMUNITY_SERVICE_FINISH_PROLOG = "Un lieu vous a été ~o~marqué~o~, où vous effectuez votre service communautaire !",
    },

    CIRCUIT_MINIGAME = {
        RECONNECT_TITLE = "CONNEXION PERDUE",
        RECONNECT_MESSAGE = "Reconnexion...",
        FAILED_MESSAGE = "Connexion perdue, réessayez.",
        FAILED_TITLE = "CIRCUIT ÉCHOUÉ",
        FINISH_TITLE = "CIRCUIT TERMINÉ",
        FINISH_MESSAGE = "Connexion établie, passez au point suivant.",
        GUIDE = "Guidez le signal vers le port de sortie.",
        EXIT = "Quitter le mini-jeu",
        ARROW_UP = "Déplacer vers le haut",
        ARROW_DOWN = "Déplacer vers le bas",
        ARROW_LEFT = "Déplacer vers la gauche",
        ARROW_RIGHT = "Déplacer vers la droite",
    },

    RELEASE_COMS_MESSAGE = "Vous avez été libéré du service communautaire !",

    COMS_MENU = {
        TITLE = "Service communautaire",

        START_MISSION_TITLE = "Demander une tâche",
        START_MISSION_DESC = "Demandez un service communautaire au gardien.",

        REPORT_MISSION_TITLE = "Pointer le service communautaire",
        REPORT_MISSION_DESC = "Pointer votre service communautaire au gardien.",
    },
    MENU = {
        LOBBY_TITLE = 'Menu de l\'accueil',
        LOBBY_RETURN_STASHED_ITEMS_TITLE = 'Récupérer les objets stockés',
        LOBBY_RETURN_STASHED_ITEMS_DESC = 'Obtenez vos objets stockés depuis le stockage de la prison.',
        LOBBY_GIFT_CREDITS_TITLE = 'Offrir des crédits',
        LOBBY_GIFT_CREDITS_DESC = 'Envoyez des crédits à votre ami en prison.',

        LOBBY_RESTORE_OUTFIT_TITLE = 'Restaurer la tenue',
        LOBBY_RESTORE_OUTFIT_DESC = 'Restaurez votre tenue depuis le stockage de la prison.',

        JOB_TITLE = 'Emplois en prison',
    },

    HELPKEYS = {
        INTERACTION_ZONE_LABEL = 'Pour ouvrir le menu',
    },

    DISPLAY_JAIL_TIME = 'Temps restant : %s',
    DISPLAY_SOLITARY_TIME_WITH_JAIL = 'Temps restant : %s | Temps en isolement : %s',


    SOLITARY = {

        MDW_LOG_TITLE = 'Isolement',
        MDW_LOG_DESC = 'Le joueur a été envoyé en isolement pour %s !',

        MDW_LOG_TITLE_RELEASED = 'Isolement',
        MDW_LOG_DESC_RELEASED = 'Le joueur a été libéré de l\'isolement',

        DISCORD_LOG_SENT_TITLE = 'Isolement',
        DISCORD_LOG_SENT_DESC = 'Le joueur a été envoyé en isolement !',

        DISCORD_LOG_OOC_NAME_LABEL = 'Nom OOC',
        DISCORD_LOG_IC_NAME_LABEL = 'Nom IC',
        DISCORD_LOG_REASON_LABEL = 'Raison',
        DISCORD_LOG_TIME_LABEL = 'Temps',

        DISCORD_LOG_REASON_PRISONER_ATTACKED_GUARD = 'A attaqué le gardien',

        DISCORD_LOG_SENT_TITLE_RELEASED = 'Isolement',
        DISCORD_LOG_SENT_DESC_RELEASED = 'Le joueur a été libéré de l\'isolement',

        PLACED_IN_SOLITARY = 'Vous avez été placé en isolement pour %s !',
        ALREADY_IN_SOLITARY = 'Ce prisonnier est déjà en isolement !',
        RELEASED = 'Vous avez été libéré de l\'isolement !',
        PRISONER_ATTACKED_GUARD = 'Vous avez attaqué le gardien, vous êtes envoyé en isolement pour %s !',
    },

    JOB_STEPPER = {
        EXIT_TASK = 'Quitter la tâche',
    },

    KEYS = {
        JOB_LEAVE_DSC = 'Quitter l\'emploi',
    },

    MINIGAME_CIGAR_PRODUCTION = {
        KEY_MAPPING_PRESS_LEFT_W = 'Minigame: Press left [W] key',
        KEY_MAPPING_PRESS_LEFT_S = 'Minigame: Press left [S] key',
        KEY_MAPPING_PRESS_LEFT_A = 'Minigame: Press left [A] key',
        KEY_MAPPING_PRESS_LEFT_D = 'Minigame: Press left [D] key',

        KEY_MAPPING_PRESS_RIGHT_W = 'Minigame: Press right [ARROW_UP] key',
        KEY_MAPPING_PRESS_RIGHT_S = 'Minigame: Press right [ARROW_DOWN] key',
        KEY_MAPPING_PRESS_RIGHT_A = 'Minigame: Press right [ARROW_LEFT] key',
        KEY_MAPPING_PRESS_RIGHT_D = 'Minigame: Press right [ARROW_RIGHT] key',
    },

    MINIGAME_STATES = {
        CIRCUIT_NOT_ENOUGH_LIFES = 'Pas assez de vies pour continuer le mini-jeu !',
    },

    ITEM_LABELS = {
        KNIFE = 'Couteau',
        WIRE_CUTTER = 'Coupe-fil',
    },


    TARGET_ZONE = {
        GENERAL_LABEL = 'Que puis-je faire pour vous ?',
        WARDEN_LABEL = 'Gardien',
        CRANKS_LABEL = 'Manivelles',
        DEALER_LABEL = 'Marchand',
        CANTEEN_LABEL = 'Cantine',
        HOSPITAL_BED_LABEL = 'Lit d\'hôpital',
        COMS_LABEL = 'Service communautaire',
    },

    QUEST = {
        WARDEN_NPC_NAME = 'Gardien',
        WARDEN_DESCRIPTION = 'Que puis-je faire pour vous ?',
        PRISON_BREAK_NPC_NAME = 'John',
        PRISON_BREAK_LABEL = 'Commencer l\'évasion de prison',
        PRISON_BREAK_DESC = 'Hmm, que diriez-vous de vous évader ?',
        PRISON_ACCOUNT_LABEL = 'Compte',
        JAIL_TIME_LABEL = 'Temps restant',
    },

    JOB = {
        LEAVE_JOB_DIALOG = 'Quitter l\'emploi',
        LEAVE_JOB_DIALOG_DESC = 'Êtes-vous sûr de vouloir quitter l\'emploi ?\nVous ne recevrez aucune récompense.',

        CLEAR_YARD_TITLE = 'Nettoyage des feuilles',
        ELECTRICIAN_TITLE = 'Électricien',
        BUSHES_TRIMMING_TITLE = 'Taille des buissons',
        JANITOR_TITLE = 'Concierge',
        COOKING_TITLE = 'Cuisinier',

        IN_ACTIVE_SESSION_LEFT = 'Vous avez quitté l\'emploi.',
        IN_ACTIVE_SESSION_LEFT_REASON = 'Vous devez recommencer le travail car : %s.',
        IN_ACTIVE_SESSION_FINISHED = 'Vous avez terminé l\'emploi, profitez de votre récompense.',
        IN_ACTIVE_SESSION_ACTIVE_JOB = 'Vous ne pouvez pas prendre un nouvel emploi lorsque votre travail actuel est actif.',
        IN_ACTIVE_SESSION_COOLDOWN = 'Vous ne pouvez pas prendre un autre emploi pour le moment, faites une pause.',
        IN_ACTIVE_SESSION_DELIVERED = 'Vous avez livré %s / %s, continuez !',

        RECEIVED_CREDITS = 'Vous avez reçu %s crédits pour votre travail !',

        TASK_BLIP_AREA_NAME = 'Zone de tâche',
        CURRENT_JOB_NOT_FREE_SPACE = 'Il n\'y a pas assez de place dans le travail actuel, veuillez attendre.',

        ELECTRICIAN_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Souder les fils !',

        COOKING_HELPKEYS_TASK_LABEL = 'Cuisine',
        COOKING_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Allez à la cuisine et préparez la nourriture au cuiseur marqué !',
        COOKING_SUBTITLES_ACTIVE_COOKING_LABEL = 'Maintenant, cuisinez la nourriture sur le grill !',


        CLEAN_GROUND_SUBTITLES_ACTIVE_STATE_LABEL = 'Nettoyez ce désordre maintenant !',
        JANITOR_SUBTITLES_ACTIVE_STATE_LABEL = 'Balayez le sol jusqu\'à ce que ce soit terminé !',

        CLEAN_GROUND_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Rendez-vous dans la zone marquée et nettoyez le sol !',
        JANITOR_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Rendez-vous dans la zone marquée et balayez le sol !',
        BUSHES_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Rendez-vous dans la zone marquée et taillez les buissons !',
        LEAF_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Rendez-vous dans la zone marquée et nettoyez les feuilles !',
        GARDENER_SUBTITLES_INIT_STATE_LABEL = 'Tâche : Rendez-vous dans la zone marquée et plantez les fleurs !',

        STOP_CURRENT_JOB_LABEL = 'Arrêter le travail actuel',
        START_TASK_LABEL = 'Commencer la tâche',

        STEPPER_TASK_LABEL = 'Tâche : %s',
        STEPPER_PROGRESS_LABEL = 'Progression : %s%%',
        STEPPER_DO_TASK_LABEL = 'Effectuer la tâche',
        STEPPER_EXIT_TASK_LABEL = 'Quitter la tâche',


        REWARD_LOG_TITLE = 'Récompense du travail',
        REWARD_LOG_DESC = 'Vous avez reçu %s crédits pour votre travail !',

        ELECTRICIAN_DESCRIPTION = 'Connectez les fils aux bons endroits.',
        COOK_DESCRIPTION = 'Préparez la nourriture pour les prisonniers.',
        LEAF_DESCRIPTION = 'Nettoyez les feuilles de la cour.',
        BUSHES_DESCRIPTION = 'Taillez les buissons.',
        JANITOR_DESCRIPTION = 'Nettoyez le sol.',
    },

    CIGAR_PRODUCTION = {
        REQUIRED_ITEM_NOT_FOUND = 'L\'élément requis est introuvable sur le serveur [%s]',
        YOU_RECEIVED_REWARD = 'Vous avez reçu votre récompense !',
        COOLDOWN = 'Vous devez attendre avant de recommencer !',
    },

    JAIL_REASONS = {
        JAIL_BY_NPC = 'Emprisonné par un PNJ',
    },


    GENERAL = {
        YOU_HAVE_BEEN_SENT_TO_COMS_BY = 'Vous avez été envoyé au service communautaire par %s',
        NOT_ACCESS_TO_INTERACT_ZONE = 'Désolé, mais je ne vais pas parler avec vous',
        WIRE_CUTTER_LABEL = 'Coupe-fil',
        YOU_HAVE_BEEN_PAROLLED = 'Vous avez été libéré sous caution pour un montant de %s !',
        YOU_NEED_TO_BE_ADMIN = 'Vous devez être administrateur pour effectuer cette action !',
        TARGET_PLAYER_NOT_FOUND = 'Joueur cible introuvable !',
        ACTIVE_PAROLLE = 'Le joueur a déjà une libération conditionnelle active !!',
        CANNOT_EXECUTE_ACTION_ON_YOURSELF = 'Vous ne pouvez pas exécuter cette action sur vous-même !',
        AMOUNT_CANNOT_BE_LESS_THAN_0 = 'Le montant ne peut pas être inférieur à 0',
        REMAINING_JAIL_TIME = 'Temps restant : %s',
        TARGET_PLAYER_NOT_PRISONER = 'Le joueur cible n\'est pas prisonnier !',
        TARGET_PLAYER_IS_OFFLINE = 'Le joueur cible est hors ligne !',
        YOU_NEED_TO_BE_IN_JOB = 'Vous devez être en emploi pour effectuer cette action !',
        CITIZEN_ALREADY_JAILED = 'Ce citoyen est déjà emprisonné !',
        ITEM_NOT_FOUND  = 'Objet %s introuvable sur le serveur !',
        YOUT_ARE_NOT_PRISONER = 'Vous n\'êtes pas prisonnier !',
        YOU_DONT_HAVE_PRISONER_ACCOUNT = 'Vous n\'avez pas de compte de prisonnier !',
        INVALID_ITEM_AMOUNT = 'Quantité d\'objet invalide !',
        TARGET_PLAYER_HAS_BEEN_RELEASED = 'Le joueur cible a été libéré !',
    },

    DEALER = {
        BOUGHT_ITEM = 'Vous avez acheté un objet nommé %s en quantité %s pour (%s) %s',
        NOT_ENOUGH_ITEM = 'Vous n\'avez pas assez de %s %s pour acheter cet objet !',
        NO_ECONOMY_ITEM = 'Cet objet n\'est pas défini sur le serveur, veuillez contacter le propriétaire du serveur !',
    },

    CANTEEN = {
        FREE_FOOD_PACKAGE_RECEIVED_SUCCESS = 'Vous avez reçu un colis alimentaire gratuit !',
        FREE_FOOD_PACKAGE_RECEIVED = 'Vous avez déjà reçu un colis alimentaire gratuit',
        NO_ECONOMY_ITEM = 'Cet objet n\'est pas défini sur le serveur, veuillez contacter le propriétaire du serveur !',
        BOUGHT_ITEM = 'Vous avez acheté un(e) %s pour %s crédits',
        NOT_ENOUGH_CREDITS = 'Vous n\'avez pas assez de crédits pour acheter cet objet',
        TITLE = 'Cantine',
    },

    INTERACT = {
        BOOTH = 'Cabine téléphonique de la prison',
        LOBBY = 'Accueil',
        CANTEEN = 'Cantine des prisonniers',
        DEALER = 'Marchand de la prison',
        JOBS = 'Emplois en prison',
        ACCOUNT = 'Compte',
        CIGAR_PRODUCTION = 'Production de cigares',
        QUEST = 'Quête',
        WARDEN = 'Gardien',
        GYM = 'Exercice',
        PROP_ONLY = 'PROP',
        TELEPORT = "Transport vers Los Santos"
    },

    GYM = {
        HELPKEY_EXERCISE_LABEL = 'Exercice : %s',
        HELPKEY_EXERCISE_PROGRESS_LABEL = 'Progression : %s',
        HELPKEY_EXERCISE_DO_LABEL = 'Faire l\'exercice',
        HELPKEY_EXERCISE_EXIT = 'Quitter l\'exercice',
    },

    TRANSACTIONS = {
        ECONOMY_ITEM_NOT_FOUND = 'L\'élément économique est introuvable sur votre serveur [%s] !',
        NOT_ENOUGH_CREDITS_ON_ACCOUNT = 'Vous n\'avez pas assez de crédits sur votre compte !',
        NOT_ENOUGH_ECONOMY_ITEM = 'Vous n\'avez pas assez de %s sur vous',
        AMOUNT_BELOW_ZERO = 'Le montant ne peut pas être inférieur à zéro',
        SUCCESSFULLY_WITHDRAWN = 'Vous avez retiré avec succès %s crédits',
        SUCCESSFULLY_DEPOSITED = 'Vous avez déposé avec succès %s crédits',
    },

    CHAIRS ={
        SIT_FRONT = 'S\'asseoir devant',
        SIT_BACK = 'S\'asseoir derrière',
        LAY = 'S\'allonger',
        EXIT = 'Pour se lever',

        YOU_ARE_NOW_LAYING = 'Vous êtes maintenant allongé',
        YOU_ARE_NOW_SITTING = 'Vous êtes maintenant assis',

        SOMEBODY_IS_SITTING = 'Cet endroit est occupé !.',
    },

    BLIPS = {
        PRISON_BREAK = 'Évasion de prison',
        COMS = 'Service communautaire',
        DEALER = 'Marchand de la prison',
        LOBBY = 'Accueil de la prison',
        JOBS = 'Emplois en prison',
        CIGAR = 'Production de cigares',
        CANTEEN = 'Cantine de la prison',
        ACCOUNT = 'Gardien'
    }
}