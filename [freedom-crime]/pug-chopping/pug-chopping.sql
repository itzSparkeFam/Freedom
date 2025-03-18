CREATE TABLE IF NOT EXISTS `pug_chopping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `bucketid` int(11) DEFAULT NULL,
  `cars` text DEFAULT NULL,
  `upgrades` text DEFAULT NULL,
  `access` text DEFAULT NULL,
  `membercap` int(11) DEFAULT NULL,
  `vehiclecap` int(11) DEFAULT NULL,
  `password` int(11) DEFAULT NULL,
  `garageloc` text DEFAULT NULL,
  `carsstored` text DEFAULT NULL,
  `arcadegames` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
