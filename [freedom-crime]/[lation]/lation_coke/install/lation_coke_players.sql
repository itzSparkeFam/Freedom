CREATE TABLE IF NOT EXISTS `lation_coke_players` (
  `identifier` varchar(255) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `exp` int(11) NOT NULL DEFAULT 0,
  `gas_inputs` longtext DEFAULT NULL,
  `cement_inputs` longtext DEFAULT NULL,
  `inside` int(11) NOT NULL DEFAULT 0,
  `leaves` int(11) NOT NULL DEFAULT 0,
  `grown` int(11) NOT NULL DEFAULT 0,
  `cement` int(11) NOT NULL DEFAULT 0,
  `bricks` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
);