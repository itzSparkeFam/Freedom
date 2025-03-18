CREATE TABLE IF NOT EXISTS `rx_fishers` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(50) NOT NULL,
    `license` tinyint(1) DEFAULT 0,	
    `level` int(11) DEFAULT 0,
    `xp` int(11) DEFAULT 0,
    `name` varchar(50) NOT NULL,
    `equippedBait` varchar(50) DEFAULT NULL,
    `catches` longtext DEFAULT '[]',
    `missions` longtext DEFAULT '[]',
    `nets` longtext DEFAULT '[]',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;