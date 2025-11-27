-- MySQL dump 10.13  Distrib 9.5.0, for macos26.0 (arm64)
--
-- Host: localhost    Database: academic_erp
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--


--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Outreach',10),(2,'Admin',20),(3,'Accounts',15);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domains` (
  `domain_id` int NOT NULL AUTO_INCREMENT,
  `program` varchar(100) DEFAULT NULL,
  `batch` varchar(50) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domains`
--

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
INSERT INTO `domains` VALUES (1,'M.Tech CSE','2025',150,'B.Tech'),(2,'iM.Tech ECE','2025',60,'12th'),(3,'M.Sc Digital Society','2025',40,'B.Sc');
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `photograph_path` varchar(255) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `email` (`email`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Siddhesh','Abhang','iiitbbhai@gmail.com','Placement Officer','outreach321','OUTREACH',NULL,1),(2,'Baburao','Patil','admin@iiitb.ac.in','ADMIN','admin321','ADMIN',NULL,2);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisations`
--

DROP TABLE IF EXISTS `organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisations`
--

LOCK TABLES `organisations` WRITE;
/*!40000 ALTER TABLE `organisations` DISABLE KEYS */;
INSERT INTO `organisations` VALUES (1,'PhonePe','Cessna Business Park, Bangalore'),(2,'Nvidia','Bagmane Tech Park, Bangalore'),(3,'Cisco','Cessna Business Park, Bangalore'),(4,'Samsung R&D','Phoenix Tech Park, Bangalore'),(5,'Morgan Stanley','Embassy Golf Links, Bangalore');
/*!40000 ALTER TABLE `organisations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `placement`
--

DROP TABLE IF EXISTS `placement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `placement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `organisation_id` int DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `description` text,
  `intake` int DEFAULT NULL,
  `minimum_grade` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `placement_ibfk_1` FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placement`
--

LOCK TABLES `placement` WRITE;
/*!40000 ALTER TABLE `placement` DISABLE KEYS */;
INSERT INTO `placement` VALUES (1,1,'SDE-1 Backend','Java/Spring Boot Developer',10,3.5),(2,2,'System Software Engineer','C++/CUDA, Low level programming',5,3.6),(3,3,'Network Engineer','TCP/IP, Python scripting',15,3),(4,4,'AI Researcher','Computer Vision, NLP',6,3.2),(5,5,'Tech Analyst','FinTech, Full Stack',20,2.8);
/*!40000 ALTER TABLE `placement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `placement_filter`
--

DROP TABLE IF EXISTS `placement_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `placement_filter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placement_id` int DEFAULT NULL,
  `domain_id` int DEFAULT NULL,
  `specialisation_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `placement_id` (`placement_id`),
  KEY `domain_id` (`domain_id`),
  KEY `specialisation_id` (`specialisation_id`),
  CONSTRAINT `placement_filter_ibfk_1` FOREIGN KEY (`placement_id`) REFERENCES `placement` (`id`),
  CONSTRAINT `placement_filter_ibfk_2` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`),
  CONSTRAINT `placement_filter_ibfk_3` FOREIGN KEY (`specialisation_id`) REFERENCES `specialisation` (`specialisation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placement_filter`
--

LOCK TABLES `placement_filter` WRITE;
/*!40000 ALTER TABLE `placement_filter` DISABLE KEYS */;
INSERT INTO `placement_filter` VALUES (1,1,1,NULL),(2,2,NULL,1),(3,2,NULL,3),(4,3,NULL,4),(5,4,NULL,2);
/*!40000 ALTER TABLE `placement_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `placement_student`
--

DROP TABLE IF EXISTS `placement_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `placement_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placement_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `cv_application` varchar(255) DEFAULT NULL,
  `about` text,
  `acceptance` tinyint(1) DEFAULT '0',
  `comments` text,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `placement_id` (`placement_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `placement_student_ibfk_1` FOREIGN KEY (`placement_id`) REFERENCES `placement` (`id`),
  CONSTRAINT `placement_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placement_student`
--

LOCK TABLES `placement_student` WRITE;
/*!40000 ALTER TABLE `placement_student` DISABLE KEYS */;
INSERT INTO `placement_student` VALUES (1,1,1,'cv_arjun.pdf','Strong in Java',1,'Selected by Outreach','2025-10-01'),(2,1,2,'cv_priya.pdf','AI expert but loves backend',1,'Selected by Outreach Department','2025-10-01'),(3,2,1,'cv_arjun_nvidia.pdf','Excellent Systems knowledge',1,NULL,'2025-10-02'),(4,2,6,'cv_anjali.pdf','VLSI expert',1,'Selected by Outreach Department','2025-10-02'),(5,5,9,'cv_neha.pdf','Great analytical skills',0,NULL,'2025-10-05'),(6,5,4,'cv_sanya.pdf','Network engineer applying for analyst',0,NULL,'2025-10-05');
/*!40000 ALTER TABLE `placement_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialisation`
--

DROP TABLE IF EXISTS `specialisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialisation` (
  `specialisation_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `year` int DEFAULT NULL,
  `credits_required` int DEFAULT NULL,
  PRIMARY KEY (`specialisation_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialisation`
--

LOCK TABLES `specialisation` WRITE;
/*!40000 ALTER TABLE `specialisation` DISABLE KEYS */;
INSERT INTO `specialisation` VALUES (1,'TS','Theory & Systems','OS, Compilers, Architecture',2025,20),(2,'DS','Data Science','AI, ML, Big Data',2025,20),(3,'VLSI','VLSI Systems','Chip Design, FPGA',2025,20),(4,'NC','Networking','SDN, IoT, 5G',2025,20),(5,'DT','Digital Technologies','HCI, Policy',2025,16);
/*!40000 ALTER TABLE `specialisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `roll_number` varchar(50) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `photograph_path` varchar(255) DEFAULT NULL,
  `cgpa` float DEFAULT NULL,
  `total_credits` int DEFAULT NULL,
  `graduation_year` int DEFAULT NULL,
  `domain_id` int DEFAULT NULL,
  `specialisation_id` int DEFAULT NULL,
  `placement_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `roll_number` (`roll_number`),
  UNIQUE KEY `email` (`email`),
  KEY `domain_id` (`domain_id`),
  KEY `specialisation_id` (`specialisation_id`),
  KEY `placement_id` (`placement_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`),
  CONSTRAINT `students_ibfk_2` FOREIGN KEY (`specialisation_id`) REFERENCES `specialisation` (`specialisation_id`),
  CONSTRAINT `students_ibfk_3` FOREIGN KEY (`placement_id`) REFERENCES `placement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'MT2025001','Arjun','Reddy','arjun.reddy@iiitb.ac.in',NULL,3.8,NULL,NULL,1,1,NULL),(2,'MT2025002','Priya','Sharma','priya.sharma@iiitb.ac.in',NULL,3.9,NULL,NULL,1,2,NULL),(3,'MT2025003','Rohan','Mehta','rohan.mehta@iiitb.ac.in',NULL,3.4,NULL,NULL,1,1,NULL),(4,'MT2025004','Sanya','Iyer','sanya.iyer@iiitb.ac.in',NULL,2.9,NULL,NULL,1,4,NULL),(5,'MT2025005','Vikram','Singh','vikram.singh@iiitb.ac.in',NULL,3.1,NULL,NULL,1,2,NULL),(6,'IMT2025001','Anjali','Nair','anjali.nair@iiitb.ac.in',NULL,3.7,NULL,NULL,2,3,NULL),(7,'IMT2025002','Rahul','Verma','rahul.verma@iiitb.ac.in',NULL,3.5,NULL,NULL,2,3,NULL),(8,'IMT2025003','Karthik','Gowda','karthik.gowda@iiitb.ac.in',NULL,3.2,NULL,NULL,2,1,NULL),(9,'MS2025001','Neha','Kapoor','neha.kapoor@iiitb.ac.in',NULL,3.6,NULL,NULL,3,5,NULL),(10,'MS2025002','Amit','Joshi','amit.joshi@iiitb.ac.in',NULL,3,NULL,NULL,3,5,NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-25 10:37:19
