-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: duranki_login
-- ------------------------------------------------------
-- Server version	12.3.2-MariaDB
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `church_branches`
--

DROP TABLE IF EXISTS `church_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `church_branches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `church_id` bigint(20) unsigned NOT NULL,
  `branch_name` varchar(255) NOT NULL,
  `branch_code` varchar(50) DEFAULT NULL,
  `pastor_name` varchar(200) DEFAULT NULL,
  `region` varchar(150) DEFAULT NULL,
  `province` varchar(150) DEFAULT NULL,
  `physical_address` varchar(255) DEFAULT NULL,
  `status` enum('ACTIVE','PENDING','SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`),
  KEY `fk_church_branches_church` (`church_id`),
  CONSTRAINT `fk_church_branches_church` FOREIGN KEY (`church_id`) REFERENCES `churches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `church_branches`
--

LOCK TABLES `church_branches` WRITE;
/*!40000 ALTER TABLE `church_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `church_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `churches`
--

DROP TABLE IF EXISTS `churches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `churches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `denomination` varchar(150) DEFAULT NULL,
  `region` varchar(150) DEFAULT NULL,
  `province` varchar(150) DEFAULT NULL,
  `status` enum('ACTIVE','PENDING','SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `churches`
--

LOCK TABLES `churches` WRITE;
/*!40000 ALTER TABLE `churches` DISABLE KEYS */;
/*!40000 ALTER TABLE `churches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direct_messages`
--

DROP TABLE IF EXISTS `direct_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_messages` (
  `id` char(36) NOT NULL,
  `conversation_id` varchar(64) NOT NULL,
  `sender_user_id` bigint(20) unsigned NOT NULL,
  `recipient_user_id` bigint(20) unsigned NOT NULL,
  `message_text` varchar(1000) NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_direct_messages_conversation` (`conversation_id`,`sent_at`),
  KEY `fk_direct_messages_sender` (`sender_user_id`),
  KEY `fk_direct_messages_recipient` (`recipient_user_id`),
  CONSTRAINT `fk_direct_messages_recipient` FOREIGN KEY (`recipient_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_direct_messages_sender` FOREIGN KEY (`sender_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direct_messages`
--

LOCK TABLES `direct_messages` WRITE;
/*!40000 ALTER TABLE `direct_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `direct_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_listings`
--

DROP TABLE IF EXISTS `job_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_listings` (
  `id` char(36) NOT NULL,
  `listed_by_user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `employment_type` varchar(50) DEFAULT NULL,
  `work_mode` varchar(50) DEFAULT NULL,
  `area` varchar(150) DEFAULT NULL,
  `payment_amount` decimal(14,2) DEFAULT NULL,
  `payment_frequency` varchar(50) DEFAULT NULL,
  `status` enum('OPEN','PAUSED','FILLED','CLOSED') NOT NULL DEFAULT 'OPEN',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_job_listings_user` (`listed_by_user_id`),
  CONSTRAINT `fk_job_listings_user` FOREIGN KEY (`listed_by_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_listings`
--

LOCK TABLES `job_listings` WRITE;
/*!40000 ALTER TABLE `job_listings` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legal_acceptances`
--

DROP TABLE IF EXISTS `legal_acceptances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_acceptances` (
  `id` char(36) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `member_name` varchar(255) NOT NULL,
  `member_telephone` varchar(20) DEFAULT NULL,
  `member_email` varchar(255) DEFAULT NULL,
  `service_code` varchar(50) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `plan_code` varchar(50) NOT NULL,
  `document_title` varchar(255) NOT NULL,
  `document_version` varchar(30) NOT NULL,
  `document_sha256` char(64) NOT NULL,
  `document_mime_type` varchar(100) NOT NULL,
  `document_source_file` varchar(255) DEFAULT NULL,
  `document_snapshot` longtext NOT NULL,
  `consent_statement` varchar(500) NOT NULL,
  `accepted_at` datetime(3) NOT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `user_agent` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ix_legal_acceptances_user` (`user_id`,`accepted_at`),
  KEY `ix_legal_acceptances_service` (`service_code`,`accepted_at`),
  CONSTRAINT `fk_legal_acceptances_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legal_acceptances`
--

LOCK TABLES `legal_acceptances` WRITE;
/*!40000 ALTER TABLE `legal_acceptances` DISABLE KEYS */;
/*!40000 ALTER TABLE `legal_acceptances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marketplace_listings`
--

DROP TABLE IF EXISTS `marketplace_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketplace_listings` (
  `id` char(36) NOT NULL,
  `seller_user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `item_condition` varchar(50) DEFAULT NULL,
  `price` decimal(14,2) NOT NULL,
  `area` varchar(150) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `status` enum('AVAILABLE','RESERVED','SOLD','REMOVED') NOT NULL DEFAULT 'AVAILABLE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_marketplace_listings_seller` (`seller_user_id`),
  CONSTRAINT `fk_marketplace_listings_seller` FOREIGN KEY (`seller_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketplace_listings`
--

LOCK TABLES `marketplace_listings` WRITE;
/*!40000 ALTER TABLE `marketplace_listings` DISABLE KEYS */;
/*!40000 ALTER TABLE `marketplace_listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_communities`
--

DROP TABLE IF EXISTS `member_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `church_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `fk_member_communities_church` (`church_id`),
  KEY `fk_member_communities_branch` (`branch_id`),
  CONSTRAINT `fk_member_communities_branch` FOREIGN KEY (`branch_id`) REFERENCES `church_branches` (`id`),
  CONSTRAINT `fk_member_communities_church` FOREIGN KEY (`church_id`) REFERENCES `churches` (`id`),
  CONSTRAINT `fk_member_communities_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_communities`
--

LOCK TABLES `member_communities` WRITE;
/*!40000 ALTER TABLE `member_communities` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_contacts`
--

DROP TABLE IF EXISTS `member_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_contacts` (
  `owner_user_id` bigint(20) unsigned NOT NULL,
  `contact_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`owner_user_id`,`contact_user_id`),
  KEY `fk_member_contacts_contact` (`contact_user_id`),
  CONSTRAINT `fk_member_contacts_contact` FOREIGN KEY (`contact_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_member_contacts_owner` FOREIGN KEY (`owner_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_contacts`
--

LOCK TABLES `member_contacts` WRITE;
/*!40000 ALTER TABLE `member_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_profiles`
--

DROP TABLE IF EXISTS `member_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `id_number` varchar(32) DEFAULT NULL,
  `telephone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `emergency_contact_name` varchar(200) DEFAULT NULL,
  `emergency_contact_number` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_member_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_profiles`
--

LOCK TABLES `member_profiles` WRITE;
/*!40000 ALTER TABLE `member_profiles` DISABLE KEYS */;
INSERT INTO `member_profiles` VALUES (2,NULL,'0782708321',NULL,'','','','','','2026-06-14 19:40:13');
/*!40000 ALTER TABLE `member_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referrals`
--

DROP TABLE IF EXISTS `referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referrals` (
  `id` char(36) NOT NULL,
  `referrer_user_id` bigint(20) unsigned NOT NULL,
  `referred_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('PENDING','ACCEPTED','DECLINED') NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `acknowledged_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_referrals_referrer` (`referrer_user_id`),
  KEY `fk_referrals_referred` (`referred_user_id`),
  CONSTRAINT `fk_referrals_referred` FOREIGN KEY (`referred_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_referrals_referrer` FOREIGN KEY (`referrer_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referrals`
--

LOCK TABLES `referrals` WRITE;
/*!40000 ALTER TABLE `referrals` DISABLE KEYS */;
/*!40000 ALTER TABLE `referrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_applications`
--

DROP TABLE IF EXISTS `service_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `service_code` varchar(50) NOT NULL,
  `status` enum('submitted','approved','declined') NOT NULL DEFAULT 'submitted',
  `bank_confirmation_path` varchar(500) NOT NULL,
  `id_document_path` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_service_application` (`user_id`,`service_code`),
  CONSTRAINT `fk_service_applications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_applications`
--

LOCK TABLES `service_applications` WRITE;
/*!40000 ALTER TABLE `service_applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_subscriptions`
--

DROP TABLE IF EXISTS `service_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `service_code` varchar(50) NOT NULL,
  `plan_code` varchar(50) NOT NULL,
  `amount_cents` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('active','cancelled') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_service` (`user_id`,`service_code`),
  CONSTRAINT `fk_service_subscriptions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_subscriptions`
--

LOCK TABLES `service_subscriptions` WRITE;
/*!40000 ALTER TABLE `service_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_code` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`role_code`),
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (2,'Member','2026-06-14 19:40:13');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_number_hash` char(64) NOT NULL,
  `id_number_last4` char(4) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive','locked') NOT NULL DEFAULT 'active',
  `membership_type` enum('free','paid') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_id_number_hash` (`id_number_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'22873670347ab53e942d1e7eaa24d20c79f6acc0a2ef5c04343b52ed4e4006c7','2086','Test','User','test.user@example.com','active',NULL,'2026-06-14 19:36:08','2026-06-14 19:36:08'),(2,'85d55e58d8c6f48d04ce9431e5ae3d411b1aa6b87155d491a4ab55d79bc8fd36','8321','Tebogo','Moremi',NULL,'active',NULL,'2026-06-14 19:40:13','2026-06-14 19:40:13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_transactions` (
  `id` char(36) NOT NULL,
  `wallet_id` char(36) NOT NULL,
  `transaction_type` varchar(50) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `direction` enum('IN','OUT') NOT NULL,
  `description` varchar(255) NOT NULL,
  `reference` varchar(100) NOT NULL,
  `status` enum('PENDING','SUCCESSFUL','FAILED') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ix_wallet_transactions_wallet` (`wallet_id`,`created_at`),
  CONSTRAINT `fk_wallet_transactions_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transactions`
--

LOCK TABLES `wallet_transactions` WRITE;
/*!40000 ALTER TABLE `wallet_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `id` char(36) NOT NULL,
  `owner_type` enum('MEMBER','CHURCH','KZNCC') NOT NULL,
  `owner_id` varchar(64) NOT NULL,
  `wallet_name` varchar(255) NOT NULL,
  `balance` decimal(14,2) NOT NULL DEFAULT 0.00,
  `available_balance` decimal(14,2) NOT NULL DEFAULT 0.00,
  `pending_balance` decimal(14,2) NOT NULL DEFAULT 0.00,
  `currency` char(3) NOT NULL DEFAULT 'ZAR',
  `status` enum('ACTIVE','SUSPENDED','CLOSED') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_wallet_owner` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` VALUES ('member-2','MEMBER','2','Tebogo Moremi Wallet',0.00,0.00,0.00,'ZAR','ACTIVE');
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-15  7:13:29