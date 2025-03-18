CREATE TABLE IF NOT EXISTS `lation_selling` (
  `identifier` varchar(255) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `rep` int(11) NOT NULL DEFAULT 0,
  `total_sales` int(11) NOT NULL DEFAULT 0,
  `total_earned` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
);