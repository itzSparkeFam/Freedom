CREATE TABLE IF NOT EXISTS `lation_meth_players` (
  `identifier` varchar(255) DEFAULT NULL,
  `ammonia` int(11) DEFAULT NULL,
  `iodine` int(11) DEFAULT NULL,
  `acetone` int(11) DEFAULT NULL,
  `inside` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `exp` int(11) NOT NULL DEFAULT 0,
  `total_produced` int(11) NOT NULL DEFAULT 0,
  `total_supply_runs` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
);