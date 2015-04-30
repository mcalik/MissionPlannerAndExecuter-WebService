-- phpMyAdmin SQL Dump
-- version 4.3.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 16, 2015 at 06:54 AM
-- Server version: 5.5.40-36.1
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mustafac_mpe`
--

-- --------------------------------------------------------

--
-- Table structure for table `commander`
--

CREATE TABLE IF NOT EXISTS `commander` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rankID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL,
  `missionID` int(11) NOT NULL,
  `soldierID` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `missionID`, `soldierID`, `latitude`, `longitude`, `time`, `status`) VALUES
(2, 1, 1, 23, 13, '2014-12-08 18:44:55', 'ACTIVATE'),
(6, 1, 2, 1, 1, '2015-02-17 11:02:21', 'READY'),
(8, 1, 4, 23, 13, '2014-12-08 18:44:55', 'READY');

-- --------------------------------------------------------

--
-- Table structure for table `mission`
--

CREATE TABLE IF NOT EXISTS `mission` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `teamID` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `details` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mission`
--

INSERT INTO `mission` (`id`, `name`, `teamID`, `latitude`, `longitude`, `time`, `details`) VALUES
(1, 'Rehine Kurtar', 1, 36.907583, 38.362778, '2014-11-22 22:57:42', 'deneme'),
(2, 'Fidye', 3, 39.907583, 40.362778, '2014-11-19 19:06:36', 'deneme');

-- --------------------------------------------------------

--
-- Table structure for table `rank`
--

CREATE TABLE IF NOT EXISTS `rank` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rank`
--

INSERT INTO `rank` (`id`, `name`) VALUES
(1, 'Private'),
(2, 'Specialist'),
(3, 'Corporal'),
(4, 'Sergeant'),
(5, 'Lieutenant'),
(6, 'Captain'),
(7, 'Colonel');

-- --------------------------------------------------------

--
-- Table structure for table `soldier`
--

CREATE TABLE IF NOT EXISTS `soldier` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rankID` int(11) NOT NULL,
  `serial` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `soldier`
--

INSERT INTO `soldier` (`id`, `name`, `rankID`, `serial`) VALUES
(1, 'Mustafa Calik', 6, 'QWRGUGKFTGSOYLSK'),
(2, 'Barış Argun Polatkan', 1, '00199d163dd78e'),
(3, 'Erman Yılmaz', 1, '4100bae340e96000'),
(4, 'deneme', 1, '2'),
(5, 'deneme', 1, '4');

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE IF NOT EXISTS `team` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `leaderID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`id`, `name`, `leaderID`) VALUES
(1, 'first team', 1),
(3, 'second team', 3);

-- --------------------------------------------------------

--
-- Table structure for table `teammember`
--

CREATE TABLE IF NOT EXISTS `teammember` (
  `teamID` int(11) NOT NULL,
  `soldierID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teammember`
--

INSERT INTO `teammember` (`teamID`, `soldierID`) VALUES
(1, 1),
(3, 1),
(1, 2),
(3, 2),
(1, 3),
(3, 3),
(1, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `commander`
--
ALTER TABLE `commander`
  ADD PRIMARY KEY (`id`), ADD KEY `FK_commander_rank` (`rankID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`), ADD KEY `FK_location_mission` (`missionID`), ADD KEY `FK_location_soldier` (`soldierID`);

--
-- Indexes for table `mission`
--
ALTER TABLE `mission`
  ADD PRIMARY KEY (`id`), ADD KEY `FK_mission_team` (`teamID`);

--
-- Indexes for table `rank`
--
ALTER TABLE `rank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `soldier`
--
ALTER TABLE `soldier`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `serial` (`serial`), ADD KEY `FK_soldier_rank` (`rankID`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`), ADD KEY `FK_team_leaderSoldier` (`leaderID`);

--
-- Indexes for table `teammember`
--
ALTER TABLE `teammember`
  ADD UNIQUE KEY `teamID_soldierID` (`teamID`,`soldierID`), ADD KEY `FK_teammember_soldier` (`soldierID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `commander`
--
ALTER TABLE `commander`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `mission`
--
ALTER TABLE `mission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `rank`
--
ALTER TABLE `rank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `soldier`
--
ALTER TABLE `soldier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `commander`
--
ALTER TABLE `commander`
ADD CONSTRAINT `FK_commander_rank` FOREIGN KEY (`rankID`) REFERENCES `rank` (`id`);

--
-- Constraints for table `location`
--
ALTER TABLE `location`
ADD CONSTRAINT `FK_location_mission` FOREIGN KEY (`missionID`) REFERENCES `mission` (`id`),
ADD CONSTRAINT `FK_location_soldier` FOREIGN KEY (`soldierID`) REFERENCES `soldier` (`id`);

--
-- Constraints for table `mission`
--
ALTER TABLE `mission`
ADD CONSTRAINT `FK_mission_team` FOREIGN KEY (`teamID`) REFERENCES `team` (`id`);

--
-- Constraints for table `soldier`
--
ALTER TABLE `soldier`
ADD CONSTRAINT `FK_soldier_rank` FOREIGN KEY (`rankID`) REFERENCES `rank` (`id`);

--
-- Constraints for table `team`
--
ALTER TABLE `team`
ADD CONSTRAINT `FK_team_leaderSoldier` FOREIGN KEY (`leaderID`) REFERENCES `soldier` (`id`);

--
-- Constraints for table `teammember`
--
ALTER TABLE `teammember`
ADD CONSTRAINT `FK_teammember_soldier` FOREIGN KEY (`soldierID`) REFERENCES `soldier` (`id`),
ADD CONSTRAINT `FK_teammember_team` FOREIGN KEY (`teamID`) REFERENCES `team` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
