CREATE TABLE IF NOT EXISTS `mdt_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `players` TEXT DEFAULT NULL,
  `victims` TEXT DEFAULT NULL,
  `cops` TEXT DEFAULT NULL,
  `vehicles` TEXT DEFAULT NULL,
  `evidences` TEXT DEFAULT NULL,
  `charges` TEXT DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_evidences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `players` TEXT DEFAULT NULL,
  `cops` TEXT DEFAULT NULL,
  `vehicles` TEXT DEFAULT NULL,
  `weapons` TEXT DEFAULT NULL,
  `images` TEXT DEFAULT NULL,
  `archive` TEXT DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` TEXT NOT NULL,
  `players` TEXT NOT NULL DEFAULT '[]',
  `house` TEXT DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `date` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `player` varchar(255) DEFAULT NULL,
  `vehicle` varchar(255) DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `date` varchar(64) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_gallery` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(64) NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `value` TEXT NOT NULL,
    `description` TEXT DEFAULT NULL,
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_weapons` (
    `label` VARCHAR(64) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `serial` VARCHAR(20) NOT NULL,
    `identifier` VARCHAR(64) DEFAULT NULL,
    `notes` TEXT DEFAULT NULL,
    PRIMARY KEY (`serial`)
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_charges` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL DEFAULT '',
    `jail` int(11) DEFAULT 0,
    `fine` FLOAT DEFAULT 0,
    `tag` VARCHAR(64) DEFAULT NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_tags` (
    `identifier` VARCHAR(64) NOT NULL,
    `type` VARCHAR(64) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT DEFAULT NULL,
    `color` VARCHAR(64) NOT NULL,
    PRIMARY KEY (`identifier`)
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_activity` (
    `identifier` VARCHAR(64) NOT NULL,
    `amount` FLOAT NOT NULL,
    `clockIn` VARCHAR(128) NOT NULL,
    `clockOut` TIMESTAMP NOT NULL DEFAULT current_timestamp()
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `content` TEXT NOT NULL,
  `author` varchar(255) NOT NULL,
  `pinned` BOOLEAN DEFAULT FALSE,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `code` varchar(32) NOT NULL UNIQUE,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `mdt_citizens` (
    `identifier` VARCHAR(64) NOT NULL UNIQUE,
    `firstname` VARCHAR(20) NOT NULL,
    `lastname` VARCHAR(20) NOT NULL,
    `gender` VARCHAR(10) NOT NULL,
    `birthdate` varchar(64) NOT NULL,
    `job` VARCHAR(128) DEFAULT '{}',
    `licenses` TEXT DEFAULT '[]',
    `fingerprint` VARCHAR(64) DEFAULT NULL,
    `notes` TEXT DEFAULT NULL,
    `image` TEXT DEFAULT NULL,
    PRIMARY KEY (`identifier`)
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `mdt_vehicles` (
    `plate` VARCHAR(32) NOT NULL UNIQUE,
    `model` VARCHAR(32) NOT NULL,
    `owner` VARCHAR(64) NOT NULL,
    `notes` TEXT DEFAULT NULL,
    `image` TEXT DEFAULT NULL,
    PRIMARY KEY (`plate`)
) CHARACTER SET utf8mb4;

-- Delete triggers (for avoiding attached unexisting records)

DELIMITER //
  CREATE TRIGGER delete_evidence AFTER DELETE ON mdt_evidences FOR EACH ROW BEGIN
      UPDATE mdt_incidents SET
        evidences = JSON_REMOVE(mdt_incidents.evidences, JSON_UNQUOTE(
          JSON_SEARCH(mdt_incidents.evidences, 'one', OLD.id)
        ))
      WHERE
        JSON_CONTAINS(mdt_incidents.evidences, OLD.id);
  END;
// DELIMITER ;