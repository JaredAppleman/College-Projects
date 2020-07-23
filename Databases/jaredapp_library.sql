-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: jaredapp_library
-- ------------------------------------------------------
-- Server version	10.1.41-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Camera`
--

DROP TABLE IF EXISTS `Camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Camera` (
  `rentalID` int(11) DEFAULT NULL,
  `brand` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Camera`
--

LOCK TABLES `Camera` WRITE;
/*!40000 ALTER TABLE `Camera` DISABLE KEYS */;
INSERT INTO `Camera` VALUES (13,'sony','photo canon 4z');
/*!40000 ALTER TABLE `Camera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ComputerStations`
--

DROP TABLE IF EXISTS `ComputerStations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ComputerStations` (
  `libraryID` int(11) DEFAULT NULL,
  `os` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ComputerStations`
--

LOCK TABLES `ComputerStations` WRITE;
/*!40000 ALTER TABLE `ComputerStations` DISABLE KEYS */;
INSERT INTO `ComputerStations` VALUES (50,'windows','microsoft Edge 4'),(51,'macintosh','gen7');
/*!40000 ALTER TABLE `ComputerStations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `userID` int(11) DEFAULT NULL,
  `jobID` int(11) DEFAULT NULL,
  `employeeID` int(11) DEFAULT NULL,
  `bankNumber` int(11) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (5,1,1000,2147483647,10,24),(6,1,1001,2147483647,10,19),(7,2,1002,2147483647,16,32),(8,2,1003,2147483647,18,14);
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Laptop`
--

DROP TABLE IF EXISTS `Laptop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Laptop` (
  `rentalID` int(11) DEFAULT NULL,
  `mac` varchar(20) DEFAULT NULL,
  `os` varchar(15) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Laptop`
--

LOCK TABLES `Laptop` WRITE;
/*!40000 ALTER TABLE `Laptop` DISABLE KEYS */;
INSERT INTO `Laptop` VALUES (11,'12:ae:fb:21:48','windows','gen6');
/*!40000 ALTER TABLE `Laptop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Media`
--

DROP TABLE IF EXISTS `Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Media` (
  `rentalID` int(11) DEFAULT NULL,
  `format` varchar(20) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `mediaType` varchar(20) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Media`
--

LOCK TABLES `Media` WRITE;
/*!40000 ALTER TABLE `Media` DISABLE KEYS */;
INSERT INTO `Media` VALUES (7,'dvd','Avengers','movie','GH74-B'),(8,'dvd','Ace Ventura','movie','GH56-B'),(9,'cd','Nickleback','album','FH12-B'),(10,'cd','Katie Perry','album','FH31-C');
/*!40000 ALTER TABLE `Media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NonRentals`
--

DROP TABLE IF EXISTS `NonRentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NonRentals` (
  `libraryID` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NonRentals`
--

LOCK TABLES `NonRentals` WRITE;
/*!40000 ALTER TABLE `NonRentals` DISABLE KEYS */;
INSERT INTO `NonRentals` VALUES (50,'computer'),(51,'computer'),(52,'artwork'),(53,'map'),(54,'printer'),(55,'artwork');
/*!40000 ALTER TABLE `NonRentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rentals`
--

DROP TABLE IF EXISTS `Rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rentals` (
  `rentalID` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `availability` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rentals`
--

LOCK TABLES `Rentals` WRITE;
/*!40000 ALTER TABLE `Rentals` DISABLE KEYS */;
INSERT INTO `Rentals` VALUES (1,'book','true'),(2,'periodical','true'),(3,'book','true'),(4,'book','false'),(5,'book','false'),(6,'periodical','true'),(7,'dvd','true'),(8,'dvd','false'),(9,'cd','true'),(10,'cd','true'),(11,'laptop','false'),(13,'camera','true'),(14,'room','true'),(15,'room','true'),(16,'book','true');
/*!40000 ALTER TABLE `Rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rented`
--

DROP TABLE IF EXISTS `Rented`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rented` (
  `RentalID` int(11) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  `date` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rented`
--

LOCK TABLES `Rented` WRITE;
/*!40000 ALTER TABLE `Rented` DISABLE KEYS */;
INSERT INTO `Rented` VALUES (4,1,'12-2-19'),(5,2,'12-5-19'),(8,2,'12-5-19'),(11,2,'12-5-19');
/*!40000 ALTER TABLE `Rented` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Role` (
  `role` varchar(15) DEFAULT NULL,
  `numOfBooks` int(11) DEFAULT NULL,
  `numOfDays` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES ('student',3,5),('faculty',8,14),('employee',8,21),('citizen',2,5);
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Services` (
  `jobID` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services` DISABLE KEYS */;
INSERT INTO `Services` VALUES (1,'tutor'),(2,'research advisor'),(3,'library clerk');
/*!40000 ALTER TABLE `Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Students` (
  `userID` int(11) DEFAULT NULL,
  `catID` int(11) DEFAULT NULL,
  `classLevel` varchar(10) DEFAULT NULL,
  `major` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students` VALUES (1,525611,'senior','computer science'),(2,453732,'sophomore','physical education');
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Text`
--

DROP TABLE IF EXISTS `Text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Text` (
  `isbn` int(11) DEFAULT NULL,
  `rentalID` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `textType` varchar(20) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Text`
--

LOCK TABLES `Text` WRITE;
/*!40000 ALTER TABLE `Text` DISABLE KEYS */;
INSERT INTO `Text` VALUES (1,1,'The Darkest Minds','Alexandra Bracken','Disney-Hyperion',2012,'book','AB12-C'),(2,3,'Never Fade','Alexandra Bracken','Disney-Hyperion',2013,'book','AB25-R'),(3,4,'In the Afterlight','Alexandra Bracken','Disney-Hyperion',2014,'book','AC45-R'),(4,5,'The Happy Tree','Steve Leafington','Tree Stump Books',2011,'book','KD56-Y'),(10001,2,'The Project that needs to get Finished','Jared Appleman','Time Magazine',2016,'periodical','MA11-P'),(10002,6,'Big Cats','Steve Erwin','National Geographic',2000,'periodical','MA43-A'),(5343,16,'Warriors','Erin Hunter','Harper Collins',2011,'book','AB12-Z');
/*!40000 ALTER TABLE `Text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artwork`
--

DROP TABLE IF EXISTS `artwork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artwork` (
  `libraryID` int(11) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `artType` varchar(20) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artwork`
--

LOCK TABLES `artwork` WRITE;
/*!40000 ALTER TABLE `artwork` DISABLE KEYS */;
INSERT INTO `artwork` VALUES (52,'The Caged Cloud','Rammus Turtleton','sculpture',2011,'main entrance'),(55,'The Enlightened Shad','Sparky Cattington','painting',2019,'3rd floor lobby');
/*!40000 ALTER TABLE `artwork` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maps`
--

DROP TABLE IF EXISTS `maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maps` (
  `libraryID` int(11) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `year` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maps`
--

LOCK TABLES `maps` WRITE;
/*!40000 ALTER TABLE `maps` DISABLE KEYS */;
INSERT INTO `maps` VALUES (53,'South African Penins','1890');
/*!40000 ALTER TABLE `maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `userID` int(11) DEFAULT NULL,
  `firstName` varchar(30) DEFAULT NULL,
  `lastName` varchar(40) DEFAULT NULL,
  `role` varchar(15) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Jared','Appleman','student',2),(2,'Sam','Tabbyton','student',5),(3,'Dave','Johnson','faculty',0),(4,'mary','garcia','faculty',0),(5,'Steve','Wilson','employee',0),(6,'Matt','Timmer','employee',0),(7,'tony','stark','employee',0),(8,'Jacoby','Brissett','employee',0),(9,'Michael','Scott','citizen',0);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers` (
  `libraryID` int(11) DEFAULT NULL,
  `color` varchar(5) DEFAULT NULL,
  `scanner` varchar(5) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers`
--

LOCK TABLES `printers` WRITE;
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
INSERT INTO `printers` VALUES (54,'true','true','2-102');
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studyRoom`
--

DROP TABLE IF EXISTS `studyRoom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studyRoom` (
  `rentalID` int(11) DEFAULT NULL,
  `tv` varchar(5) DEFAULT NULL,
  `whiteboard` varchar(5) DEFAULT NULL,
  `computer` varchar(5) DEFAULT NULL,
  `roomLocation` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studyRoom`
--

LOCK TABLES `studyRoom` WRITE;
/*!40000 ALTER TABLE `studyRoom` DISABLE KEYS */;
INSERT INTO `studyRoom` VALUES (14,'false','true','true','2-113'),(15,'true','false','true','3-111');
/*!40000 ALTER TABLE `studyRoom` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-10  0:11:43
