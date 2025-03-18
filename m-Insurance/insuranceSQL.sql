CREATE TABLE IF NOT EXISTS `m_insurance_registration` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `plate` varchar(255) NOT NULL,
    `model` varchar(255) NOT NULL,
    `expire_date` datetime NOT NULL,
    `citizenid` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `m_insurance_vehicles` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `plate` varchar(20) NOT NULL,
    `model` varchar(50) NOT NULL,
    `expire_date` datetime NOT NULL,
    `citizenid` varchar(50) DEFAULT NULL,
    `owner_name` varchar(100) DEFAULT NULL,
    `stolen` tinyint(1) DEFAULT 0,
    `accident_reports` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`accident_reports`)),
    `documents_suspended` tinyint(1) DEFAULT 0,
    `camera_installed` tinyint(1) DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `m_insurance_health` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(255) NOT NULL,
    `expire_date` datetime NOT NULL,
    `owner_name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `m_insurance_home` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(255) NOT NULL,
    `expire_date` datetime NOT NULL,
    `owner_name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `m_insurance_accidents` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `vehicle_plate` varchar(255) NOT NULL,
    `citizen_name` varchar(255) NOT NULL,
    `officer_name` varchar(255) NOT NULL,
    `road_location` varchar(255) NOT NULL,
    `screenshot` TEXT,
    `date` DATETIME NOT NULL,
    `observations` TEXT,
    PRIMARY KEY (`id`)
);