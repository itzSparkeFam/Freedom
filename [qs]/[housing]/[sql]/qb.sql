ALTER TABLE
    `players`
ADD
    IF NOT EXISTS `inside` VARCHAR(50) NULL DEFAULT '';

CREATE TABLE IF NOT EXISTS `houselocations` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'latin1_swedish_ci',
	`label` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`coords` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`owned` TINYINT(2) NULL DEFAULT NULL,
	`price` INT(11) NULL DEFAULT NULL,
	`defaultPrice` INT(11) NULL DEFAULT NULL,
	`tier` TINYINT(2) NULL DEFAULT NULL,
	`garage` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`garageShell` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`creator` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`mlo` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`ipl` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`console` INT(11) NULL DEFAULT NULL,
	`board` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`for_sale` INT(11) NULL DEFAULT '1',
	`extra_imgs` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`description` TEXT NOT NULL DEFAULT '' COLLATE 'latin1_swedish_ci',
	`creatorJob` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`blip` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`upgrades` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`apartmentCount` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`name`) USING BTREE,
	INDEX `name` (`name`) USING BTREE,
	INDEX `id` (`id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

CREATE TABLE IF NOT EXISTS `player_houses` (
	`id` INT(255) NOT NULL AUTO_INCREMENT,
	`house` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`citizenid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`keyholders` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`stash` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`outfit` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`logout` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`decorateStash` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`charge` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`credit` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`creditPrice` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`console` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`decorateCoords` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`rented` INT(11) NULL DEFAULT NULL,
	`rentPrice` INT(11) NULL DEFAULT NULL,
	`rentable` INT(11) NULL DEFAULT NULL,
	`purchasable` INT(11) NULL DEFAULT NULL,
	`vaultCodes` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `house` (`house`) USING BTREE,
	INDEX `owner` (`owner`) USING BTREE,
	INDEX `citizenid` (`citizenid`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=3
;



CREATE TABLE IF NOT EXISTS `house_rents` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`house` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`identifier` VARCHAR(80) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`payed` INT(11) NOT NULL DEFAULT '0',
	`date` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `house_objects` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`creator` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'latin1_swedish_ci',
	`model` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'latin1_swedish_ci',
	`coords` TEXT NOT NULL COLLATE 'latin1_swedish_ci',
	`house` VARCHAR(80) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`construction` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`created` TIMESTAMP NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;


ALTER TABLE `house_objects`
	ADD IF NOT EXISTS `construction` VARCHAR(50) NULL DEFAULT NULL,
	ADD IF NOT EXISTS `created` TIMESTAMP NULL DEFAULT current_timestamp()
;

DROP TABLE IF EXISTS `house_plants`;

CREATE TABLE IF NOT EXISTS `house_plants` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`building` varchar(50) DEFAULT NULL,
	`stage` varchar(50) DEFAULT 'stage-a',
	`sort` varchar(50) DEFAULT NULL,
	`gender` varchar(50) DEFAULT NULL,
	`food` int(11) DEFAULT 100,
	`health` int(11) DEFAULT 100,
	`progress` int(11) DEFAULT 0,
	`coords` text DEFAULT NULL,
	`plantid` varchar(50) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `building` (`building`),
	KEY `plantid` (`plantid`)
) ENGINE = InnoDB AUTO_INCREMENT = 7123 DEFAULT CHARSET = utf8mb4;

ALTER TABLE `player_houses`
    CHANGE COLUMN IF EXISTS `identifier`  `owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci';

ALTER TABLE `houselocations`
	ADD IF NOT EXISTS `blip` TEXT NULL DEFAULT NULL,
	ADD IF NOT EXISTS `upgrades` TEXT NULL DEFAULT NULL,
	ADD IF NOT EXISTS `apartmentCount` TEXT NULL DEFAULT NULL
;

ALTER TABLE `player_houses`
	ADD IF NOT EXISTS `rented` INT(11) NULL DEFAULT NULL,
	ADD IF NOT EXISTS `rentPrice` INT(11) NULL DEFAULT NULL,
	ADD IF NOT EXISTS `rentable` INT(11) NULL DEFAULT NULL,
	ADD IF NOT EXISTS `purchasable` INT(11) NULL DEFAULT NULL,
	ADD IF NOT EXISTS `console` TEXT NULL DEFAULT NULL,
	ADD IF NOT EXISTS `decorateCoords` TEXT NULL DEFAULT NULL,
	ADD IF NOT EXISTS `vaultCodes` TEXT NULL DEFAULT NULL
;

ALTER TABLE `houselocations`
	DROP IF EXISTS `houseID`
;
	

ALTER TABLE `player_houses`
	DROP IF EXISTS `houseID`,
	DROP IF EXISTS `timer`,
	DROP IF EXISTS `insideId`
;
	
CREATE TABLE IF NOT EXISTS `house_decorations` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`house` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`creator` VARCHAR(70) NOT NULL DEFAULT '0' COLLATE 'utf8mb3_general_ci',
	`modelName` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb3_general_ci',
	`coords` TEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`rotation` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb3_general_ci',
	`inStash` TINYINT(1) NOT NULL DEFAULT '0',
	`inHouse` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`uniq` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`created` TIMESTAMP NULL DEFAULT NULL,
	`lightData` TEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `id` (`id`, `house`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;
