DROP TABLE IF EXISTS `player_apartments`;

CREATE TABLE `player_apartments` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`type` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`label` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`citizenid` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`stash` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`wardrobe` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`charge` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `name` (`name`) USING BTREE,
	INDEX `citizenid` (`citizenid`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=4148
;

DROP TABLE IF EXISTS `apartment_decorations`;

CREATE TABLE `apartment_decorations` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`apartmentId` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`creator` VARCHAR(70) NOT NULL DEFAULT '0' COLLATE 'utf8mb3_general_ci',
	`modelName` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb3_general_ci',
	`coords` TEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`rotation` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb3_general_ci',
	`inStash` TINYINT(1) NOT NULL DEFAULT '0',
	`created` TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `id` (`id`, `apartmentId`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=7
;
