CREATE TABLE IF NOT EXISTS `lation_weed_players` (
  `identifier` varchar(255) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `exp` int(11) NOT NULL DEFAULT 0,
  `plants_searched` int(11) NOT NULL DEFAULT 0,
  `plants_grown` int(11) NOT NULL DEFAULT 0,
  `bud_produced` int(11) NOT NULL DEFAULT 0,
  `joints_rolled` int(11) NOT NULL DEFAULT 0,
  `weed_bagged` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
);