db = {
    Queries = {
        GAME_STRUCTURE = {
            REGISTER_TRANSACTION =
            "INSERT INTO `rcore_prison_logs` (`action`, `desc`, `charId`, `officer_name`, `citizen_name`, `created_at`) VALUES (@action, @desc, @charId, @officer_name, @citizen_name, NOW())",
            REGISTER_ACCOUNT_TRANSACTION =
            "INSERT INTO `rcore_prison_accounts_log` (`action`, `desc`, `charId`, `amount`, `created_at`) VALUES (@action, @desc, @charId, @amount, NOW())",

            FETCH_GKSPHONE_NUMBER = "SELECT * FROM gksphone_settings WHERE phone_number = ?",
            NEW_PRISONER = 'INSERT INTO rcore_prison (owner, data) VALUES (?, ?)',
            NEW_COMS_PLAYER = 'INSERT INTO rcore_prison_coms (owner, state, perollTarget, name) VALUES (?, ?, ?, ?)',
            NEW_PRISONER_ACCOUNT = 'INSERT INTO rcore_prison_accounts (owner, giftstate) VALUES (?, ?)',
            NEW_PRISONER_STASH =
            'INSERT INTO rcore_prison_stash (owner, stash) VALUES (?, "[]") ON DUPLICATE KEY UPDATE stash = "[]";',
            HAS_STASHED_ITEMS = 'SELECT * FROM rcore_prison WHERE owner = ?',
            HAS_PRISONER_ACCOUNT = 'SELECT account_id FROM rcore_prison_accounts WHERE owner = ?',
            NEW_PRISONER_SET_DEFAULT_SOLITARY_TIME =
            'UPDATE rcore_prison SET solitary_time = DATE_ADD(NOW(), INTERVAL ? SECOND) WHERE prisoner_id = ?',
            NEW_PRISONER_SET_DEFAULT_TIME =
            'UPDATE rcore_prison SET jail_time = DATE_ADD(NOW(), INTERVAL LEAST(?, 60000000) SECOND) WHERE prisoner_id = ?',
            NEW_TRANSACTION =
            'INSERT INTO rcore_prison_transactions (account_id, transaction_name, message) VALUES (?, ?, ?)',

            SAVE_PRISONER_ACCOUNT = 'UPDATE rcore_prison_accounts SET balance = ?, giftstate = ? WHERE owner = ?',

            DOES_TABLE_EXIST = [[
                SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ?
            ]],

            REGISTER_COMS_ZONE_FOR_PLAYER = 'UPDATE rcore_prison_coms SET zoneId = ? WHERE owner = ?',
            UPDATE_PEROLL_AMOUNT = 'UPDATE rcore_prison_coms SET perollAmount = ? WHERE owner = ?',
            REGISTER_COMS_ZONE =
            'INSERT INTO rcore_prison_coms_sessions (zoneId, verticesTarget, verticesDone) VALUES (?, ?, ?)',
            REMOVE_PLAYER_COMS = 'DELETE FROM rcore_prison_coms WHERE owner = ?',
            REMOVE_PRISONER_ACCOUNT_DATA = 'DELETE FROM rcore_prison_accounts WHERE owner = @owner',
            REMOVE_PRISONER_DATA = 'DELETE FROM rcore_prison WHERE owner = @owner',
            REMOVE_PRISONER_TRANSACTIONS = 'DELETE FROM rcore_prison_transactions WHERE account_id = @account_id',
            REMOVE_PRISONER_CONTACTS = 'DELETE FROM rcore_prison_contacts WHERE owner = @owner',
            REMOVE_COMS_SESSION_ZONE = 'DELETE FROM rcore_prison_coms_sessions WHERE zoneId = @zoneId',
            REMOVE_PRISONER_STASH = 'DELETE from rcore_prison_stash WHERE owner = ?',
            REMOVE_COMS_ZONE = 'UPDATE rcore_prison_coms SET zoneId = NULL WHERE owner = owner AND zoneId = zoneId',
            UPDATE_ACCOUNT_BALANCE = 'UPDATE rcore_prison_accounts SET balance = ? WHERE owner = ?',
            UPDATE_JAIL_DATA = "UPDATE rcore_prison SET data = ? WHERE owner = ?",
            UPDATE_STASH = "UPDATE rcore_prison_stash SET stash = ? WHERE owner = ?",
            UPDATE_FRIEND_READ_MESSAGE = 'UPDATE rcore_prison_contacts SET isRead = ? WHERE owner = ?',
            FETCH_ALL_LOGS = 'SELECT * FROM rcore_prison_logs',
            FETCH_ALL_ACCOUNT_LOGS = 'SELECT * FROM rcore_prison_accounts_log',
            FETCH_ALL_PRISONERS = 'SELECT prisoner_id, owner, jail_time, data FROM rcore_prison',
            FETCH_ALL_COMS_USERS = 'SELECT * FROM rcore_prison_coms',
            FETCH_ALL_PRISONERS_ACCOUNTS = 'SELECT account_id, balance, owner, giftstate FROM rcore_prison_accounts',
            FETCH_ALL_PRISONERS_CONTACTS = 'SELECT * FROM rcore_prison_contacts',
            FETCH_PRISONER_SENTENCE_TIME_OFFLINE =
            'SELECT jail_time, TIMESTAMPDIFF(SECOND, NOW(), jail_time) AS time FROM rcore_prison WHERE owner = ?',
            FETCH_PRISONER_SENTENCE_TIME_ONLINE = 'SELECT data FROM rcore_prison WHERE OWNER = ?',
            FETCH_PRISONER_ALL_TRANSACTIONS = 'SELECT * FROM rcore_prison_transactions',
            FETCH_PRISONER_TRANSACTIONS =
            'SELECT rcore_prison_accounts.account_id, rcore_prison_accounts.owner, rcore_prison_transactions.message, rcore_prison_transactions.transaction_id, rcore_prison_transactions.createdAt,  rcore_prison_transactions.transaction_amount, rcore_prison_transactions.transaction_name FROM rcore_prison_accounts INNER JOIN rcore_prison_transactions ON rcore_prison_accounts.account_id = rcore_prison_transactions.account_id WHERE rcore_prison_accounts.owner = ?',
            FETCH_PRISONER_STASH_ITEMS = 'SELECT stash FROM rcore_prison_stash WHERE owner = ?',
        },
        FRAMEWORK = {
            FETCH_PHONE_NUMBER = 'SELECT charinfo FROM `{skin_table}` WHERE `{identifier}` = ?',
            FETCH_PRISONER_SKIN_ILLENIUM = 'SELECT skin FROM `{skin_table}` WHERE `{identifier}` = ? AND active = ?',
            FETCH_PRISONER_SKIN = 'SELECT skin FROM `{skin_table}` WHERE `{identifier}` = ?',
            SEARCH_FRIEND =
            "SELECT `{search_column}` FROM `{user_table}` WHERE CONCAT(firstname, ' ', lastname) LIKE @query OR (identifier) LIKE @query",
        },

        CREATE_STRUCTURE = {
            rcore_prison = [[
                CREATE TABLE IF NOT EXISTS `rcore_prison` (
                    `prisoner_id` INT(11) NOT NULL AUTO_INCREMENT,
                    `owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `solitary_time` DATETIME NULL DEFAULT NULL,
                    `jail_time` DATETIME NULL DEFAULT NULL,
                    `data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `createdAt` TIMESTAMP NULL DEFAULT current_timestamp(),
                    `updatedAt` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                    PRIMARY KEY (`prisoner_id`) USING BTREE,
                    INDEX `owner` (`owner`) USING BTREE
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]],
            rcore_prison_accounts = [[
                CREATE TABLE IF NOT EXISTS `rcore_prison_accounts` (
                    `account_id` INT(11) NOT NULL AUTO_INCREMENT,
                    `owner` VARCHAR(80) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `balance` BIGINT(20) NULL DEFAULT '0',
                    `giftstate` TINYINT(4) NULL DEFAULT '0',
                    `createdAt` TIMESTAMP NULL DEFAULT current_timestamp(),
                    `updatedAt` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                    PRIMARY KEY (`account_id`) USING BTREE,
                    INDEX `owner` (`owner`) USING BTREE
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]],
            rcore_prison_coms_sessions = [[
                CREATE TABLE IF NOT EXISTS `rcore_prison_coms_sessions` (
                    `zoneId` BIGINT(10) NOT NULL,
                    `verticesTarget` BIGINT(10) NOT NULL,
                    `verticesDone` BIGINT(10) NOT NULL DEFAULT '0',
                    PRIMARY KEY (`zoneId`),
                    INDEX `zoneId_index` (`zoneId`) USING BTREE
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]],
            rcore_prison_coms = [[
                CREATE TABLE IF NOT EXISTS `rcore_prison_coms` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `zoneId` BIGINT(10) NULL DEFAULT NULL,
                    `state` ENUM('IDLE','SWEEPING','RETURN') NOT NULL COLLATE 'utf8mb4_unicode_ci',
                    `perollAmount` INT(10) NULL DEFAULT '0',
                    `perollTarget` INT(10) NULL DEFAULT '0',
                    `createdAt` TIMESTAMP NULL DEFAULT current_timestamp(),
                    `name` VARCHAR(60) NOT NULL COLLATE 'utf8mb4_unicode_ci',
                    PRIMARY KEY (`id`) USING BTREE,
                    INDEX `owner` (`owner`) USING BTREE,
                    INDEX `zoneId` (`zoneId`) USING BTREE,
                    CONSTRAINT `FK_Q27L` FOREIGN KEY (`zoneId`) REFERENCES `rcore_prison_coms_sessions` (`zoneId`) ON UPDATE RESTRICT ON DELETE SET NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]],
            rcore_prison_stash = [[
                CREATE TABLE IF NOT EXISTS `rcore_prison_stash` (
                    `owner` VARCHAR(255) NOT NULL,
                    `stash` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
                    PRIMARY KEY (`owner`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]],
            rcore_prison_logs = [[
                CREATE TABLE IF NOT EXISTS `rcore_prison_logs` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `action` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `desc` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `charId` VARCHAR(70) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `officer_name` VARCHAR(70) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `citizen_name` VARCHAR(70) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `created_at` DATETIME NOT NULL DEFAULT current_timestamp(),
                    PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]],
            rcore_prison_accounts_logs = [[
                CREATE TABLE `rcore_prison_accounts_log` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `action` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `desc` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `charId` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
                    `amount` INT(11) NULL DEFAULT NULL,
                    `created_at` DATETIME NULL DEFAULT NULL,
                    PRIMARY KEY (`id`) USING BTREE
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]]
        },
    },
}

/* Functions */

db.DeletePrisonerData = function(charId)
    local query = {
        { query = db.Queries.GAME_STRUCTURE.REMOVE_PRISONER_DATA, values = { ['owner'] = charId } },
    }

    if Config.Accounts.DeleteAccountWhenReleased then
        query[#query + 1] = { query = db.Queries.GAME_STRUCTURE.REMOVE_PRISONER_ACCOUNT_DATA, values = { ['owner'] = charId } }
    end

    MySQL.transaction(query, function(state)
        if state then
            dbg.debug('Remove prisoner data from database with charId [%s]', charId)
        else
            dbg.debug('Failed to do transaction for removing data: %s', state)
        end
    end)
end

db.RemoveStashItems = function(charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REMOVE_PRISONER_STASH, { charId })
end

db.FetchStashItems = function(charId)
    return MySQL.Sync.fetchScalar(db.Queries.GAME_STRUCTURE.FETCH_PRISONER_STASH_ITEMS, { charId }) or {}
end

db.FetchPrisonTransactions = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_TRANSACTIONS) or {}
end


db.FetchPhoneNumberByCharId = function(charId)
    local retval = {}
    local fetch = MySQL.Sync.fetchAll(db.Queries.FRAMEWORK.FETCH_PHONE_NUMBER, { charId })

    if fetch and fetch[1] then
        retval = json.decode(fetch[1].charinfo).phone
    end

    return retval
end

db.UpdateJailData = function(data, charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.UPDATE_JAIL_DATA, { json.encode(data), charId })
end

db.SavePrisonerItems = function(invItems, charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.UPDATE_STASH, { json.encode(invItems), charId })
end

db.UpdatePlayerComsZoneId = function(zoneIdx, charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REGISTER_COMS_ZONE_FOR_PLAYER, { zoneIdx, charId })
end

db.UpdatePlayerComsPerollAmount = function(charId, amount)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.UPDATE_PEROLL_AMOUNT, { amount, charId })
end

db.UpdateReadState = function(state, charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.UPDATE_FRIEND_READ_MESSAGE, { state, charId })
end

db.FetchPrisonerTime = function(charId, fetchType)
    local query = nil

    if fetchType == 'online' then
        query = db.Queries.GAME_STRUCTURE.FETCH_PRISONER_SENTENCE_TIME_ONLINE
    else
        query = db.Queries.GAME_STRUCTURE.FETCH_PRISONER_SENTENCE_TIME_OFFLINE
    end

    if query == nil then
        return dbg.debug('Invalid fetch type [%s]', fetchType)
    end

    local success, retval = pcall(function()
        return MySQL.Sync.fetchSingle(query, { charId })
    end)

    if fetchType == 'offline' and type(retval) == 'table' then
        retval = retval.time
    elseif fetchType == 'online' and type(retval) == 'table' then
        retval = json.decode(retval.data)['jail_time']
    end

    if not success then
        dbg.critical('Failed to fetch prisoner time for charId [%s] with fetchType [%s] | Using DB: %s', charId,
            fetchType, Bridge.Database)
        if Bridge.Database == Database.OX then
            local version = GetResourceMetadata(Database.OX, 'version', 0)

            if version < '2.7.2' then
                dbg.critical(
                'Please update your %s resource to latest version since fetchSingle is not supported in version %s',
                    Database.OX, version)
            end
        end
        retval = 0
    end

    if fetchType == 'offline' then
        if retval <= 0 then
            retval = 0    
        end 
        
        local prisonerStorage = Object.getStorage(STORAGE_PRISONER)
        local prisonerModel = prisonerStorage.GetPrisonerById(charId)

        if not prisonerModel then
            return 
        end

        prisonerStorage.UpdatePlayerSentence(charId, retval)
    end
    
    return retval
end

db.RegisterCOMSZone = function(zoneIdx, verticesTarget, verticesDone)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REGISTER_COMS_ZONE, { zoneIdx, verticesTarget, verticesDone })
end

db.CreateStashForPrisoner = function(charId)
    return MySQL.Sync.insert(db.Queries.GAME_STRUCTURE.NEW_PRISONER_STASH, { charId })
end

db.HasStashedItems = function(owner)
    return MySQL.Sync.fetchSingle(db.Queries.GAME_STRUCTURE.HAS_STASHED_ITEMS, { owner }) or nil
end

db.FetchPrisoners = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_PRISONERS) or {}
end

db.FetchCOMSUsers = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_COMS_USERS) or {}
end

db.FetchPrisonersAccounts = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_PRISONERS_ACCOUNTS) or {}
end

db.FetchPrisonLogs = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_LOGS) or {}
end

db.FetchAccountLogs = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_ACCOUNT_LOGS) or {}
end

db.FetchPrisonersContacts = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_ALL_PRISONERS_CONTACTS) or {}
end

db.DeletePlayerCOMS = function(charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REMOVE_PLAYER_COMS, { charId })
end

db.HasSearchedContact = function(owner, name)
    return MySQL.Sync.fetchSingle(db.Queries.GAME_STRUCTURE.HAS_CONTACT_IN_LIST, { owner, name })
end

db.SearchContact = function(input)
    return MySQL.Sync.fetchSingle(db.Queries.FRAMEWORK.SEARCH_FRIEND, {
        query = string.lower('%' .. tostring(input) ..
            '%')
    })
end

db.InsertNewTransaction = function(data, ...)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.NEW_TRANSACTION,
        { data.accountId, data.transanction.name, (data.transanction.text):format(...) })
end

db.UpdatePrisonAccountBalance = function(credits, charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.UPDATE_ACCOUNT_BALANCE, { credits, charId })
end

db.DefineNewPrisonerContact = function(accountId, charId, name, targetowner)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.NEW_PRISONER_CONTACT, { accountId, charId, name, targetowner })
end

db.SavePrisonerAccount = function(charId, balance, giftState)
    return MySQL.Async.execute(db.Queries.GAME_STRUCTURE.SAVE_PRISONER_ACCOUNT, { balance, giftState, charId })
end

db.DefinePrisonerData = function(charId, data)
    return MySQL.Sync.insert(db.Queries.GAME_STRUCTURE.NEW_PRISONER, { charId, json.encode(data.prisonerData) })
end

db.CreateCitizenPeroll = function(charId, state, perollTarget, name)
    return MySQL.Sync.insert(db.Queries.GAME_STRUCTURE.NEW_COMS_PLAYER, { charId, state, perollTarget, name })
end

db.RemovePerollByOwner = function(charId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REMOVE_PRISONER_DATA, { charId })
end

db.DeleteCOMSZone = function(charId, zoneId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REMOVE_COMS_ZONE, { charId, zoneId })
end

db.DeleteCOMSSessionZone = function(zoneId)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REMOVE_COMS_SESSION_ZONE, { zoneId })
end

db.CreatePrisonerAccount = function(charId, giftState)
    return MySQL.Sync.insert(db.Queries.GAME_STRUCTURE.NEW_PRISONER_ACCOUNT, { charId, giftState })
end

db.RegisterTransaction = function(action, desc, targetCharId, officerName, citizenName)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REGISTER_TRANSACTION, {
        ['@action'] = action,
        ['@desc'] = desc,
        ['@charId'] = targetCharId,
        ['@officer_name'] = officerName,
        ['@citizen_name'] = citizenName
    })
end

db.RegisterAccountTransaction = function(action, desc, charId, amount)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.REGISTER_ACCOUNT_TRANSACTION, {
        ['@action'] = action,
        ['@desc'] = desc,
        ['@charId'] = charId,
        ['@amount'] = amount,
    })
end

db.DefinePrisonerJailTime = function(accountId, sentenceTime)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.NEW_PRISONER_SET_DEFAULT_TIME, { sentenceTime, accountId })
end

db.DefinePrisonerSolitaryTime = function(accountId, sentenceTime)
    return MySQL.Sync.execute(db.Queries.GAME_STRUCTURE.NEW_PRISONER_SET_DEFAULT_SOLITARY_TIME,
        { sentenceTime, accountId })
end

db.FetchAllPrisonerAccountTransactions = function()
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_PRISONER_ALL_TRANSACTIONS)
end

db.FetchPrisonerAccountTransactions = function(charId)
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_PRISONER_TRANSACTIONS, { charId })
end

db.GetPhoneForGKSPhone = function(number)
    return MySQL.Sync.fetchAll(db.Queries.GAME_STRUCTURE.FETCH_GKSPHONE_NUMBER, { number })
end

db.DoesTableExist = function(tableName)
    local retval = false
    local state = MySQL.Sync.fetchScalar(db.Queries.GAME_STRUCTURE.DOES_TABLE_EXIST, { tableName })

    if state ~= nil then
        retval = true
    end

    return retval
end
