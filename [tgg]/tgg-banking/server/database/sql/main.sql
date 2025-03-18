CREATE TABLE IF NOT EXISTS `tgg_banking_metadata` (
    -- A table to hold data about the database version and handle automatic migrations during updates.
    `dbVersion` VARCHAR(10) NOT NULL,
    `lastUpdate` TIMESTAMP NOT NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (`dbVersion`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tgg_banking_accounts` (
    `iban` VARCHAR(20) NOT NULL PRIMARY KEY,
    `ownerId` VARCHAR(80) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `type` VARCHAR(255) DEFAULT 'shared', -- shared, business, personal
    `balance` DECIMAL(15,2) DEFAULT 0.00,
    `color` VARCHAR(15) DEFAULT '#76abae',
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `frozen` BOOLEAN DEFAULT FALSE,
    `closed` BOOLEAN DEFAULT FALSE,
    `settings` JSON NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tgg_banking_account_members` (
    `id` INT AUTO_INCREMENT,
    `accountIban` VARCHAR(20) NOT NULL,
    `memberId` VARCHAR(80) NOT NULL,
    `permissions` VARCHAR(4096) NOT NULL, -- e.g., {"withdraw": true, "deposit": true, "transfer": false}
    `addedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`accountIban`) REFERENCES `tgg_banking_accounts`(`iban`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tgg_banking_cards` (
    `cardId` INT AUTO_INCREMENT PRIMARY KEY,
    `accountIban` VARCHAR(20) NOT NULL,
    `cardNumber` VARCHAR(16) NOT NULL UNIQUE,
    `expirationDate` DATE NOT NULL,
    `cvv` VARCHAR(4) NOT NULL,
    `pinCode` VARCHAR(6) NOT NULL,
    `displayName` VARCHAR(100) NULL,
    `color` VARCHAR(15) DEFAULT '#76abae',
    `frozen` BOOLEAN DEFAULT FALSE,
    `terminated` BOOLEAN DEFAULT FALSE,
    `dailyLimit` DECIMAL(15,2) DEFAULT 10000.00,
    `weeklyLimit` DECIMAL(15,2) DEFAULT 50000.00,
    `monthlyLimit` DECIMAL(15,2) DEFAULT 100000.00,
    `createdBy` VARCHAR(80) NOT NULL,
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`accountIban`) REFERENCES `tgg_banking_accounts`(`iban`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tgg_banking_transactions` (
    `toIban` VARCHAR(20),
    `fromIban` VARCHAR(20),
    `transactionId` INT AUTO_INCREMENT PRIMARY KEY,
    `cardId` INT,
    `playerId` VARCHAR(80) NOT NULL,
    `transactionType` VARCHAR(255) NOT NULL, -- e.g. deposit, withdrawal, transfer
    `amount` DECIMAL(15,2) NOT NULL,
    `description` VARCHAR(255),
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`cardId`) REFERENCES `tgg_banking_cards`(`cardId`) ON DELETE SET NULL,
    FOREIGN KEY (`toIban`) REFERENCES `tgg_banking_accounts`(`iban`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`fromIban`) REFERENCES `tgg_banking_accounts`(`iban`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tgg_banking_settings` (
    `settingId` INT AUTO_INCREMENT PRIMARY KEY,
    `accountIban` VARCHAR(20) NOT NULL,
    `twoFactorThreshold` DECIMAL(15,2) DEFAULT 5000.00, -- Amount above which 2FA is required
    `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`accountIban`) REFERENCES `tgg_banking_accounts`(`iban`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tgg_banking_logs` (
    `logId` INT AUTO_INCREMENT PRIMARY KEY,
    `accountIban` VARCHAR(20) NOT NULL,
    `playerId` VARCHAR(80) NOT NULL,
    `logType` VARCHAR(255) NOT NULL,
    `logMessage` VARCHAR(1000) NOT NULL,
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`accountIban`) REFERENCES `tgg_banking_accounts`(`iban`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;