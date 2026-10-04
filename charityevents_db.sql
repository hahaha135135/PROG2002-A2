CREATE DATABASE  IF NOT EXISTS `charityevents_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `charityevents_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Fun Run','A community running event for all ages and fitness levels.'),(2,'Gala Dinner','An elegant evening of dining, entertainment, and fundraising.'),(3,'Silent Auction','Bid on exclusive items and experiences in a quiet auction setting.'),(4,'Concert','A live music performance to raise funds for a good cause.'),(5,'Charity Walk','A sponsored walk through scenic routes to support charity.');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(150) NOT NULL,
  `description` text,
  `event_date` date NOT NULL,
  `event_time` time DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `ticket_price` decimal(10,2) DEFAULT '0.00',
  `goal_amount` decimal(12,2) DEFAULT NULL,
  `raised_amount` decimal(12,2) DEFAULT '0.00',
  `status` enum('active','suspended') DEFAULT 'active',
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `org_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `category_id` (`category_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`org_id`) REFERENCES `organisations` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'City Fun Run 2026','Join us for a 5km fun run through the heart of the city. All proceeds go to local shelters.','2026-11-15','07:00:00','Centennial Park, Sydney',25.00,50000.00,12000.00,'active','images/funrun.png',1,1),(2,'Hope Gala Dinner 2026','An elegant evening with a three-course dinner, live music, and inspiring speeches.','2026-12-05','18:30:00','Grand Hyatt Ballroom, Sydney',150.00,100000.00,45000.00,'active','images/gala.png',2,1),(3,'Art for Good Silent Auction','Bid on paintings, sculptures, and experiences donated by local artists.','2026-10-25','17:00:00','Museum of Contemporary Art, Sydney',0.00,30000.00,8000.00,'active','images/auction.png',3,1),(4,'Charity Rock Concert','A night of live rock music featuring local bands. All ticket sales go to childrens hospitals.','2026-11-30','19:00:00','Enmore Theatre, Sydney',60.00,80000.00,22000.00,'active','images/concert.png',4,1),(5,'Coastal Charity Walk','A 10km sponsored walk along the beautiful coastline to support mental health services.','2026-10-18','08:00:00','Bondi to Coogee Coastal Walk',15.00,40000.00,9500.00,'active','images/walk.png',5,1),(6,'Community Fun Run for Kids','A family-friendly 2km run for children under 12. Free entry, donations welcome.','2026-11-22','09:00:00','Parramatta Park, Sydney',0.00,20000.00,3000.00,'active','images/kidsrun.png',1,1),(7,'Winter Gala Ball','A black-tie gala with auction and dinner to support homeless services.','2026-12-20','19:30:00','The Star Event Centre, Sydney',200.00,150000.00,60000.00,'active','images/wintergala.png',2,1),(8,'Online Silent Auction','An online auction featuring holiday packages, electronics, and more.','2026-10-10','12:00:00','Online Event',0.00,25000.00,5000.00,'active','images/onlineauction.png',3,1),(9,'Jazz Night for Charity','An intimate evening of jazz music with all proceeds going to cancer research.','2026-11-08','20:00:00','The Basement, Sydney',45.00,35000.00,11000.00,'active','images/jazz.png',4,1),(10,'Sunrise Charity Walk','A 5km walk at sunrise to raise awareness for diabetes research.','2026-10-05','06:00:00','Manly Beach, Sydney',10.00,30000.00,7000.00,'suspended','images/sunrise.png',5,1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisations`
--

DROP TABLE IF EXISTS `organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisations` (
  `org_id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(100) NOT NULL,
  `mission` text,
  `welcome_message` text,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisations`
--

LOCK TABLES `organisations` WRITE;
/*!40000 ALTER TABLE `organisations` DISABLE KEYS */;
INSERT INTO `organisations` VALUES (1,'Hope Foundation','To bring communities together through charitable events and raise funds for those in need.','Welcome to Hope Foundation! Join us in making a difference through our upcoming charity events.','info@hopefoundation.org','+61 2 1234 5678','123 Charity Lane, Sydney, NSW 2000');
/*!40000 ALTER TABLE `organisations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-05  0:47:56
