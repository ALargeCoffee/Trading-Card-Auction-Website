CREATE DATABASE IF NOT EXISTS `trading_card_auction_website` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `trading_card_auction_website`;
-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: localhost    Database: trading_card_auction_website
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `phone_number` int DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `user_display_name` varchar(25) NOT NULL,
  `user_password` varchar(25) DEFAULT NULL,
  `auction_history` varchar(200) DEFAULT NULL,
  `userType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_display_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2019380917,'user@gmail.com','test_user','1234',NULL,'normal'),
(3567693402, 'user2@gmail.com', 'anotherFake', '333', NULL, 'normal'),
(1234567890,'adminemail@gmail.com','MainAdmin', 'testPass546',NULL,'admin'),
(4567890123,'cusrep@gmail.com','MainRep','pass234',NULL,'customerRep');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buying`
--

DROP TABLE IF EXISTS `buying`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buying` (
  `bid_price` int NOT NULL,
  `bid_time` datetime DEFAULT NULL,
  `autobid_upper_limit` varchar(9) DEFAULT NULL,
  `user_display_name` varchar(15) DEFAULT NULL,
  `auction_id` int NOT NULL,
  PRIMARY KEY (`auction_id`, `bid_price`),
  CONSTRAINT `buying_ibfk_1` FOREIGN KEY (`user_display_name`) REFERENCES `user` (`user_display_name`) ON UPDATE CASCADE,
  CONSTRAINT `buying_ibfk_2` FOREIGN KEY (`auction_id`) REFERENCES `item` (`auction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buying`
--

LOCK TABLES `buying` WRITE;
/*!40000 ALTER TABLE `buying` DISABLE KEYS */;
INSERT INTO `buying` VALUES (100, '2022-12-16 12:00:00', NULL, 'test_user', 10),
(200, '2022-12-16 4:00:00', NULL, 'test_user', 10),
(200, '2022-12-16 12:00:00', NULL, 'anotherFake', 11),
(3, '2022-12-16 12:00:00', NULL, 'test_user', 12),
(4, '2022-12-16 12:00:00', NULL, 'anotherFake', 13),
(5, '2022-12-16 12:00:00', NULL, 'test_user', 14),
(3, '2022-12-16 4:00:00', NULL, 'test_user', 14),
(350, '2022-12-16 12:00:00', NULL, 'anotherFake', 15);
/*!40000 ALTER TABLE `buying` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `min_price` float DEFAULT NULL,
  `initial_price` float DEFAULT NULL,
  `increments` float DEFAULT NULL,
  `auction_id` int NOT NULL,
  `category` varchar(200) DEFAULT NULL,
  `card_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`auction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES ('2022-12-16', '2023-1-18', 'An autographed 2021 Justin Fields (Chicago Bear) card', 300, 100, 50, 10, 'sport', 'Justin Fields'),
('2022-12-16', '2022-12-16', 'A 2019 Steph Curry (Golden State Warriors) card', 100, 50, 25, 11, 'sport', 'Steph Curry'),
('2022-12-16', '2023-1-18', 'A 2008 Lord of the Rings Gandalf card', 5, 3, 1, 12, 'movie', 'Gandalf'),
('2022-12-16', '2022-12-16', 'A 1978 Grease Sandy card', 3, 2, 1, 13, 'movie', 'Sandy'),
('2022-12-16', '2023-1-18', 'A common base set 2 Charmander card', 5, 4, 2, 14, 'game', 'Charmander'),
('2022-12-16', '2022-12-16', 'A FireRed/LeafGreen Ex Charizard card', 300, 200, 25, 15, 'game', 'Charizard');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selling`
--

DROP TABLE IF EXISTS `selling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selling` (
  `user_display_name` varchar(15) NOT NULL,
  `auction_id` int NOT NULL,
  `is_Sold` boolean DEFAULT FALSE,
  PRIMARY KEY (`user_display_name`,`auction_id`),
  CONSTRAINT `selling_ibfk_1` FOREIGN KEY (`user_display_name`) REFERENCES `user` (`user_display_name`) ON UPDATE CASCADE,
  CONSTRAINT `selling_ibfk_2` FOREIGN KEY (`auction_id`) REFERENCES `item` (`auction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selling`
--

LOCK TABLES `selling` WRITE;
/*!40000 ALTER TABLE `selling` DISABLE KEYS */;
INSERT INTO `selling` VALUES ('anotherFake', 10, FALSE),
('test_user', 11, TRUE),
('anotherFake', 12, FALSE),
('test_user', 13, TRUE),
('anotherFake', 14, FALSE),
('test_user', 15, TRUE);
/*!40000 ALTER TABLE `selling` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `questionsAsksResponds`;
CREATE TABLE `questionsAsksResponds` (
	`question` varchar(250) DEFAULT NULL,
    `response` varchar(400) DEFAULT NULL,
    `asker` varchar(25) DEFAULT NULL,
    `responder` varchar(25) DEFAULT NULL,
    `question_id` int NOT NULL,
    PRIMARY KEY (`question_id`),
    CONSTRAINT `questionsAsksResponds_ibfk_1` FOREIGN KEY (`asker`) REFERENCES `user` (`user_display_name`) ON UPDATE CASCADE,
    CONSTRAINT `questionsAsksResponds_ibfk_2` FOREIGN KEY (`responder`) REFERENCES `user` (`user_display_name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `questionsAsksResponds` WRITE;
INSERT INTO `questionsAsksResponds` VALUES ('Who made this website?', 'People.', 'test_user', 'MainRep', 11),
('How many items can I bid on?', 'As many as you want!', 'test_user', 'MainRep', 12),
('Can anybody answer this question?', NULL, 'test_user', NULL, 13);
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-14 13:38:55
