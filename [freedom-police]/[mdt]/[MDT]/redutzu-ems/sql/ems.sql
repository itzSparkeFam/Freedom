CREATE TABLE IF NOT EXISTS `ems_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `victims` TEXT DEFAULT NULL,
  `doctors` TEXT DEFAULT NULL,
  `invoices` TEXT DEFAULT NULL,
  `images` TEXT DEFAULT '[]',
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `ems_gallery` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(64) NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `value` TEXT NOT NULL,
    `description` TEXT DEFAULT NULL,
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `ems_invoices` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL DEFAULT '',
    `amount` FLOAT DEFAULT 0,
    `tag` VARCHAR(64) DEFAULT NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `ems_tags` (
    `identifier` VARCHAR(64) NOT NULL,
    `type` VARCHAR(64) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT DEFAULT NULL,
    `color` VARCHAR(64) NOT NULL,
    PRIMARY KEY (`identifier`)
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `ems_activity` (
    `identifier` VARCHAR(64) NOT NULL,
    `amount` FLOAT NOT NULL,
    `clockIn` VARCHAR(128) NOT NULL,
    `clockOut` TIMESTAMP NOT NULL DEFAULT current_timestamp()
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `ems_announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `content` TEXT NOT NULL,
  `author` varchar(255) NOT NULL,
  `pinned` BOOLEAN DEFAULT FALSE,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `ems_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `code` varchar(32) NOT NULL UNIQUE,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `ems_citizens` (
    `identifier` VARCHAR(64) NOT NULL UNIQUE,
    `firstname` VARCHAR(20) NOT NULL,
    `lastname` VARCHAR(20) NOT NULL,
    `gender` VARCHAR(10) NOT NULL,
    `birthdate` varchar(64) NOT NULL,
    `job` VARCHAR(128) DEFAULT '{}',
    `bloodtype` VARCHAR(64) DEFAULT NULL,
    `fingerprint` VARCHAR(64) DEFAULT NULL,
    `notes` TEXT DEFAULT NULL,
    `image` TEXT DEFAULT NULL,
    PRIMARY KEY (`identifier`)
) CHARACTER SET utf8mb4;