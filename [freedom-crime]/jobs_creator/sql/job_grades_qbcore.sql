CREATE TABLE IF NOT EXISTS `job_grades` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`job_name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`grade` INT(11) NOT NULL,
	`name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`label` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`salary` INT(11) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;