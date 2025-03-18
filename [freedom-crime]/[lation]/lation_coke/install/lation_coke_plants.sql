CREATE TABLE IF NOT EXISTS `lation_coke_plants` (
  `id` int(11) NOT NULL,
  `x` decimal(10,6) DEFAULT NULL,
  `y` decimal(10,6) DEFAULT NULL,
  `z` decimal(10,6) DEFAULT NULL,
  `hunger` decimal(5,2) DEFAULT NULL,
  `thirst` decimal(5,2) DEFAULT NULL,
  `yield` decimal(5,2) DEFAULT NULL,
  `growth` decimal(5,2) DEFAULT NULL,
  `stage` int(11) DEFAULT NULL,
  `bucket` int(11) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);