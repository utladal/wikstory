CREATE DATABASE IF NOT EXISTS wiki_dev;

CREATE USER IF NOT EXISTS 'devuser'@'%' IDENTIFIED BY 'devuser';

GRANT ALL PRIVILEGES ON wiki_dev.* TO 'devuser'@'%';

USE wiki_dev;

--
-- Table structure for table `blobs`
--

DROP TABLE IF EXISTS `blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `blobs` (
  `blob_hash` binary(20) NOT NULL,
  `dependencies` int(11) DEFAULT 1,
  `line_text` text NOT NULL,
  PRIMARY KEY (`blob_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commits`
--

DROP TABLE IF EXISTS `commits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `commits` (
  `hash` binary(20) NOT NULL,
  `parent_hash` binary(20) DEFAULT NULL,
  `line_changes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`line_changes`)),
  `author` varchar(14) NOT NULL,
  `commit_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`hash`),
  KEY `fk_parent_hash` (`parent_hash`),
  CONSTRAINT `fk_parent_hash` FOREIGN KEY (`parent_hash`) REFERENCES `commits` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `uri` varchar(64) NOT NULL,
  `current_commit_hash` binary(20) DEFAULT NULL,
  `file_text` text DEFAULT NULL,
  PRIMARY KEY (`uri`),
  KEY `fk_commit_hash` (`current_commit_hash`),
  CONSTRAINT `fk_commit_hash` FOREIGN KEY (`current_commit_hash`) REFERENCES `commits` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- Dump completed on 2026-08-29  0:29:59
