-- Adminer 4.8.0 MySQL 5.7.38-log dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `fe_comics`;
CREATE TABLE `fe_comics` (
  `comicId` int(11) NOT NULL AUTO_INCREMENT,
  `comicUrl` varchar(900) NOT NULL,
  `comicTitle` varchar(255) NOT NULL,
  `comicSiteId` int(11) NOT NULL,
  `comicDate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`comicId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `fe_comics` (`comicId`, `comicUrl`, `comicTitle`, `comicSiteId`, `comicDate`) VALUES
(1, 'https://www.bunicomic.com/wp-content/uploads/2015/03/2015-03-02-Buni.jpg', 'Fish Escape',  4,  '2015-03-02'),
(2, 'https://www.bunicomic.com/wp-content/uploads/2015/10/2015-10-09-Buni.jpg', 'Bats', 4,  '2015-10-05'),
(3, 'https://imgs.xkcd.com/comics/ceres.png', 'Ceres 2x', 2,  '2022-10-29'),
(4, 'https://assets.amuniversal.com/102552a06d5c01301d80001dd8b71c47',  'Database Bugs',  3,  '2002-02-07'),
(5, 'https://imgs.xkcd.com/comics/exploits_of_a_mom.png', 'Exploids of a Mom',  2,  '2005-03-19'),
(6, 'https://imgs.xkcd.com/comics/sandwich.png',  'Sudo Sandwich',  2,  '2007-05-11'),
(7, 'https://www.savagechickens.com/wp-content/uploads/chickenrelaxationparadox.jpg', 'Relaxation Paradox', 1,  '2022-11-16'),
(8, 'https://www.savagechickens.com/wp-content/uploads/chickenworktrouble.jpg', 'Work Trouble', 1,  '2022-11-10'),
(9, 'https://assets.amuniversal.com/b1e4d2d09fcd012f2fe600163e41dd5b',  'SQL Database', 3,  '1995-11-17');

DROP TABLE IF EXISTS `fe_comic_sites`;
CREATE TABLE `fe_comic_sites` (
  `comicSiteId` int(11) NOT NULL AUTO_INCREMENT,
  `comicSiteUrl` varchar(255) NOT NULL,
  `comicSiteName` varchar(255) NOT NULL,
  PRIMARY KEY (`comicSiteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `fe_comic_sites` (`comicSiteId`, `comicSiteUrl`, `comicSiteName`) VALUES
(1, 'https://www.savagechickens.com/',  'Savage Chickens'),
(2, 'https://xkcd.com/',  'XKCD'),
(3, 'https://dilbert.com/', 'Dilbert'),
(4, 'https://www.bunicomic.com/', 'Hapi Buni');

DROP TABLE IF EXISTS `fe_comments`;
CREATE TABLE `fe_comments` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `comment` longtext NOT NULL,
  `comicId` int(11) NOT NULL,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `fe_comments` (`commentId`, `author`, `email`, `comment`, `comicId`) VALUES
(1, 'John', 'john@buni.com',  'Bat feeder! ;-)',  2),
(2, 'Jim',  'jim@buni.com', 'Fish escape!', 1),
(3, 'Jane', 'jane@buni.com',  'Funny fish!',  1);

