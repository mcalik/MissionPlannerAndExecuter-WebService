-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.17 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for mpe
DROP DATABASE IF EXISTS `mpe`;
CREATE DATABASE IF NOT EXISTS `mpe` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_turkish_ci */;
USE `mpe`;


-- Dumping structure for table mpe.commander
DROP TABLE IF EXISTS `commander`;
CREATE TABLE IF NOT EXISTS `commander` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `rankID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_commander_rank` (`rankID`),
  CONSTRAINT `FK_commander_rank` FOREIGN KEY (`rankID`) REFERENCES `rank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.commander: ~0 rows (approximately)
DELETE FROM `commander`;
/*!40000 ALTER TABLE `commander` DISABLE KEYS */;
/*!40000 ALTER TABLE `commander` ENABLE KEYS */;


-- Dumping structure for table mpe.enemy
DROP TABLE IF EXISTS `enemy`;
CREATE TABLE IF NOT EXISTS `enemy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missionID` int(11) NOT NULL,
  `soldierID` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_location_mission` (`missionID`),
  KEY `FK_location_soldier` (`soldierID`),
  CONSTRAINT `enemy_ibfk_1` FOREIGN KEY (`missionID`) REFERENCES `mission` (`id`),
  CONSTRAINT `enemy_ibfk_2` FOREIGN KEY (`soldierID`) REFERENCES `soldier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- Dumping data for table mpe.enemy: ~0 rows (approximately)
DELETE FROM `enemy`;
/*!40000 ALTER TABLE `enemy` DISABLE KEYS */;
/*!40000 ALTER TABLE `enemy` ENABLE KEYS */;


-- Dumping structure for table mpe.location
DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missionID` int(11) NOT NULL,
  `soldierID` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_location_mission` (`missionID`),
  KEY `FK_location_soldier` (`soldierID`),
  CONSTRAINT `FK_location_mission` FOREIGN KEY (`missionID`) REFERENCES `mission` (`id`),
  CONSTRAINT `FK_location_soldier` FOREIGN KEY (`soldierID`) REFERENCES `soldier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.location: ~0 rows (approximately)
DELETE FROM `location`;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;


-- Dumping structure for table mpe.message_list
DROP TABLE IF EXISTS `message_list`;
CREATE TABLE IF NOT EXISTS `message_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(20) COLLATE utf8_turkish_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- Dumping data for table mpe.message_list: ~15 rows (approximately)
DELETE FROM `message_list`;
/*!40000 ALTER TABLE `message_list` DISABLE KEYS */;
INSERT INTO `message_list` (`id`, `message`) VALUES
	(1, 'Cover Me!'),
	(2, 'Hold This Position!'),
	(3, 'Regroup, Team!'),
	(4, 'Follow Me!'),
	(5, 'Taking Fire!'),
	(6, 'Go!'),
	(7, 'Team, Fall Back! '),
	(8, 'Stick Together!'),
	(9, 'Get in Position!'),
	(10, 'Affirmative/Roger'),
	(11, 'Need Backup'),
	(12, 'Sector Clear'),
	(13, 'I\'m in Position'),
	(14, 'Negative '),
	(15, 'Enemy Down');
/*!40000 ALTER TABLE `message_list` ENABLE KEYS */;


-- Dumping structure for table mpe.mission
DROP TABLE IF EXISTS `mission`;
CREATE TABLE IF NOT EXISTS `mission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `teamID` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `details` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mission_team` (`teamID`),
  CONSTRAINT `FK_mission_team` FOREIGN KEY (`teamID`) REFERENCES `team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.mission: ~2 rows (approximately)
DELETE FROM `mission`;
/*!40000 ALTER TABLE `mission` DISABLE KEYS */;
INSERT INTO `mission` (`id`, `name`, `teamID`, `latitude`, `longitude`, `time`, `details`) VALUES
	(1, 'Rehine Kurtar', 1, 39.909065, 32.863867, '2015-05-01 14:13:13', 'deneme'),
	(2, 'Fidye', 3, 39.871522, 32.76434, '2015-05-01 14:25:39', 'deneme');
/*!40000 ALTER TABLE `mission` ENABLE KEYS */;


-- Dumping structure for table mpe.mobile_login_attempts
DROP TABLE IF EXISTS `mobile_login_attempts`;
CREATE TABLE IF NOT EXISTS `mobile_login_attempts` (
  `serial` varchar(30) COLLATE utf8_turkish_ci NOT NULL,
  `time` varchar(30) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- Dumping data for table mpe.mobile_login_attempts: ~0 rows (approximately)
DELETE FROM `mobile_login_attempts`;
/*!40000 ALTER TABLE `mobile_login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_login_attempts` ENABLE KEYS */;


-- Dumping structure for table mpe.radio_message
DROP TABLE IF EXISTS `radio_message`;
CREATE TABLE IF NOT EXISTS `radio_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missionID` int(11) NOT NULL DEFAULT '0',
  `soldierID` int(11) NOT NULL DEFAULT '0',
  `toSoldier` int(11) DEFAULT '0',
  `messageID` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `misID` (`missionID`),
  KEY `solID` (`soldierID`),
  KEY `mesID` (`messageID`),
  CONSTRAINT `mesID` FOREIGN KEY (`messageID`) REFERENCES `message_list` (`id`),
  CONSTRAINT `misID` FOREIGN KEY (`missionID`) REFERENCES `mission` (`id`),
  CONSTRAINT `solID` FOREIGN KEY (`soldierID`) REFERENCES `soldier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- Dumping data for table mpe.radio_message: ~1 rows (approximately)
DELETE FROM `radio_message`;
/*!40000 ALTER TABLE `radio_message` DISABLE KEYS */;
INSERT INTO `radio_message` (`id`, `missionID`, `soldierID`, `toSoldier`, `messageID`, `time`) VALUES
	(1, 1, 1, -1, 1, '2015-05-02 02:03:16');
/*!40000 ALTER TABLE `radio_message` ENABLE KEYS */;


-- Dumping structure for table mpe.rank
DROP TABLE IF EXISTS `rank`;
CREATE TABLE IF NOT EXISTS `rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.rank: ~7 rows (approximately)
DELETE FROM `rank`;
/*!40000 ALTER TABLE `rank` DISABLE KEYS */;
INSERT INTO `rank` (`id`, `name`) VALUES
	(1, 'Private'),
	(2, 'Specialist'),
	(3, 'Corporal'),
	(4, 'Sergeant'),
	(5, 'Lieutenant'),
	(6, 'Captain'),
	(7, 'Colonel');
/*!40000 ALTER TABLE `rank` ENABLE KEYS */;


-- Dumping structure for table mpe.soldier
DROP TABLE IF EXISTS `soldier`;
CREATE TABLE IF NOT EXISTS `soldier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `rankID` int(11) NOT NULL,
  `serial` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`),
  KEY `FK_soldier_rank` (`rankID`),
  CONSTRAINT `FK_soldier_rank` FOREIGN KEY (`rankID`) REFERENCES `rank` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.soldier: ~5 rows (approximately)
DELETE FROM `soldier`;
/*!40000 ALTER TABLE `soldier` DISABLE KEYS */;
INSERT INTO `soldier` (`id`, `name`, `rankID`, `serial`) VALUES
	(-1, 'Team', 1, ''),
	(1, 'Mustafa Calik', 6, '45b2d3d9eae1252c'),
	(2, 'Baris Argun Polatkan', 1, '00199d163dd78e'),
	(3, 'Erman Yilmaz', 1, '3c32ad3da85dfc54'),
	(4, 'Deniz Ozkayalar', 1, '5cc8c889b8c6699d');
/*!40000 ALTER TABLE `soldier` ENABLE KEYS */;


-- Dumping structure for table mpe.team
DROP TABLE IF EXISTS `team`;
CREATE TABLE IF NOT EXISTS `team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `leaderID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_team_leaderSoldier` (`leaderID`),
  CONSTRAINT `FK_team_leaderSoldier` FOREIGN KEY (`leaderID`) REFERENCES `soldier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.team: ~2 rows (approximately)
DELETE FROM `team`;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` (`id`, `name`, `leaderID`) VALUES
	(1, 'first team', 1),
	(3, 'second team', 3);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;


-- Dumping structure for table mpe.teammember
DROP TABLE IF EXISTS `teammember`;
CREATE TABLE IF NOT EXISTS `teammember` (
  `teamID` int(11) NOT NULL,
  `soldierID` int(11) NOT NULL,
  UNIQUE KEY `teamID_soldierID` (`teamID`,`soldierID`),
  KEY `FK_teammember_soldier` (`soldierID`),
  CONSTRAINT `FK_teammember_soldier` FOREIGN KEY (`soldierID`) REFERENCES `soldier` (`id`),
  CONSTRAINT `FK_teammember_team` FOREIGN KEY (`teamID`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mpe.teammember: ~8 rows (approximately)
DELETE FROM `teammember`;
/*!40000 ALTER TABLE `teammember` DISABLE KEYS */;
INSERT INTO `teammember` (`teamID`, `soldierID`) VALUES
	(1, 1),
	(3, 1),
	(1, 2),
	(3, 2),
	(1, 3),
	(3, 3),
	(1, 4),
	(3, 4);
/*!40000 ALTER TABLE `teammember` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
