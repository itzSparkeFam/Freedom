ALTER TABLE `tgg_banking_cards`
    CHANGE COLUMN `isFrozen` `frozen` BOOLEAN DEFAULT FALSE;

ALTER TABLE `tgg_banking_cards`
    ADD COLUMN `terminated` BOOLEAN DEFAULT FALSE AFTER `frozen`,
    ADD COLUMN `displayName` VARCHAR(100) NULL AFTER `pinCode`,
    ADD COLUMN `color` VARCHAR(15) DEFAULT '#76abae' AFTER `displayName`,
    CHANGE COLUMN `dailyLimit` `dailyLimit` DECIMAL(15,2) DEFAULT 10000.00,
    CHANGE COLUMN `weeklyLimit` `weeklyLimit` DECIMAL(15,2) DEFAULT 50000.00,
    CHANGE COLUMN `monthlyLimit` `monthlyLimit` DECIMAL(15,2) DEFAULT 100000.00,
    ADD COLUMN `createdBy` VARCHAR(80) NOT NULL AFTER `monthlyLimit`;

ALTER TABLE `tgg_banking_transactions` MODIFY COLUMN `playerId` VARCHAR(80) NULL;