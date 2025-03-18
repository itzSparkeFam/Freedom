CREATE TABLE IF NOT EXISTS `lation_weed_tables` (
  `id` int(11) DEFAULT NULL,
  `x` decimal(10,6) DEFAULT NULL,
  `y` decimal(10,6) DEFAULT NULL,
  `z` decimal(10,6) DEFAULT NULL,
  `heading` decimal(10,6) DEFAULT NULL,
  `bucket` int(11) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);