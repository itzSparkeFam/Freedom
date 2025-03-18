CREATE TABLE IF NOT EXISTS `lation_coke_labs` (
  `owner` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `style` text DEFAULT NULL,
  `security` text DEFAULT NULL,
  `passcode` text DEFAULT NULL,
  `locked` varchar(10) NOT NULL DEFAULT 'unlocked',
  `upgrade` longtext DEFAULT NULL,
  `users` longtext DEFAULT NULL,
  `stations` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
);