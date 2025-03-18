CREATE TABLE IF NOT EXISTS `licenses` (
  `cardid` varchar(50) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `name` varchar(70) DEFAULT NULL,
  `license` varchar(50) NOT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`cardid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `license_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `issuer` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) COLLATE armscii8_bin NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `callsign` varchar(10) NOT NULL,
  `rank` varchar(50) NOT NULL,
  `department` varchar(10) NOT NULL,
  `mugshot` mediumtext DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
);