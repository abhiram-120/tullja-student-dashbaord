-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 3.124.111.213    Database: tulkka_live
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.22.04.1

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

--
-- Table structure for table `accounting`
--

DROP TABLE IF EXISTS `accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounting` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `creator_id` int DEFAULT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `meeting_time_id` int unsigned DEFAULT NULL,
  `subscribe_id` int unsigned DEFAULT NULL,
  `promotion_id` int unsigned DEFAULT NULL,
  `registration_package_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `tax` tinyint(1) NOT NULL DEFAULT '0',
  `amount` decimal(13,2) DEFAULT NULL,
  `type` enum('addiction','deduction') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_account` enum('income','asset','subscribe','promotion','registration_package') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_type` enum('automatic','manual') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'automatic',
  `referred_user_id` int unsigned DEFAULT NULL,
  `is_affiliate_amount` tinyint(1) NOT NULL DEFAULT '0',
  `is_affiliate_commission` tinyint(1) NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `webinar_id` (`webinar_id`) USING BTREE,
  KEY `meeting_time_id` (`meeting_time_id`) USING BTREE,
  KEY `subscribe_id` (`subscribe_id`) USING BTREE,
  KEY `promotion_id` (`promotion_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `achievements`
--

DROP TABLE IF EXISTS `achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `achievement_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `badge_icon_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `points_awarded` int DEFAULT '0',
  `earned_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_achievement_type` (`achievement_type`),
  CONSTRAINT `fk_achieve_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_type` enum('salary','compensation_group','group_level','bonus','penalty','payslip') NOT NULL,
  `entity_id` bigint unsigned DEFAULT NULL,
  `action_type` varchar(50) NOT NULL,
  `performed_by` bigint unsigned DEFAULT NULL,
  `before_value` json DEFAULT NULL,
  `after_value` json DEFAULT NULL,
  `action` json DEFAULT NULL,
  `source` enum('admin','system') NOT NULL DEFAULT 'admin',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adaptive_assessment_questions`
--

DROP TABLE IF EXISTS `adaptive_assessment_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adaptive_assessment_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_text` text NOT NULL,
  `question_type` enum('multiple_choice','fill_blank','audio_response','ordering') NOT NULL,
  `difficulty_level` varchar(5) NOT NULL,
  `skill_focus` varchar(50) DEFAULT NULL,
  `correct_answer` text,
  `explanation` text,
  `imported_from_batch_id` int DEFAULT NULL,
  `options` json DEFAULT NULL,
  `next_question_if_correct` int DEFAULT NULL,
  `next_question_if_incorrect` int DEFAULT NULL,
  `average_time_seconds` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `next_question_if_correct` (`next_question_if_correct`),
  KEY `next_question_if_incorrect` (`next_question_if_incorrect`),
  KEY `idx_difficulty` (`difficulty_level`),
  KEY `idx_import_batch` (`imported_from_batch_id`),
  CONSTRAINT `adaptive_assessment_questions_ibfk_1` FOREIGN KEY (`next_question_if_correct`) REFERENCES `adaptive_assessment_questions` (`id`),
  CONSTRAINT `adaptive_assessment_questions_ibfk_2` FOREIGN KEY (`next_question_if_incorrect`) REFERENCES `adaptive_assessment_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `advertising_banners`
--

DROP TABLE IF EXISTS `advertising_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertising_banners` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `position` enum('home1','home2','course','course_sidebar','product_show','bundle','bundle_sidebar') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int unsigned NOT NULL DEFAULT '12',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `advertising_banners_translations`
--

DROP TABLE IF EXISTS `advertising_banners_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertising_banners_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `advertising_banner_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `advertising_banners_translations_advertising_banner_id_foreign` (`advertising_banner_id`),
  KEY `advertising_banners_translations_locale_index` (`locale`),
  CONSTRAINT `advertising_banners_translations_advertising_banner_id_foreign` FOREIGN KEY (`advertising_banner_id`) REFERENCES `advertising_banners` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `affiliates`
--

DROP TABLE IF EXISTS `affiliates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `affiliate_user_id` int unsigned NOT NULL,
  `referred_user_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `affiliates_affiliate_user_id_foreign` (`affiliate_user_id`),
  KEY `affiliates_referred_user_id_foreign` (`referred_user_id`),
  CONSTRAINT `affiliates_affiliate_user_id_foreign` FOREIGN KEY (`affiliate_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `affiliates_referred_user_id_foreign` FOREIGN KEY (`referred_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `affiliates_codes`
--

DROP TABLE IF EXISTS `affiliates_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliates_codes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `affiliates_codes_code_unique` (`code`),
  KEY `affiliates_codes_user_id_foreign` (`user_id`),
  CONSTRAINT `affiliates_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agora_history`
--

DROP TABLE IF EXISTS `agora_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agora_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int unsigned NOT NULL,
  `start_at` int unsigned NOT NULL,
  `end_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agora_history_session_id_foreign` (`session_id`),
  CONSTRAINT `agora_history_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_date` datetime NOT NULL COMMENT 'UTC datetime when announcement should stop being displayed',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Whether announcement is currently active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_last_date` (`last_date`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_active_and_valid` (`is_active`,`last_date`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table for storing announcements with expiration dates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audio_broadcasts`
--

DROP TABLE IF EXISTS `audio_broadcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_broadcasts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audio_file_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `audio_file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `upload_date` datetime DEFAULT NULL,
  `listens` int unsigned DEFAULT '0',
  `created_by` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `badge_translations`
--

DROP TABLE IF EXISTS `badge_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badge_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `badge_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `badge_translations_badge_id_foreign` (`badge_id`),
  KEY `badge_translations_locale_index` (`locale`),
  CONSTRAINT `badge_translations_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badges` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('register_date','course_count','course_rate','sale_count','support_rate','product_sale_count','make_topic','send_post_in_topic','instructor_blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `badges_type_index` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `become_instructors`
--

DROP TABLE IF EXISTS `become_instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `become_instructors` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `role` enum('teacher','organization') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_id` int unsigned DEFAULT NULL,
  `certificate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','accept','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `become_instructors_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `become_instructors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned DEFAULT NULL,
  `author_id` int unsigned NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visit_count` int unsigned DEFAULT '0',
  `enable_comment` tinyint(1) NOT NULL DEFAULT '1',
  `status` enum('pending','publish') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `blog_category_id_foreign` (`category_id`) USING BTREE,
  KEY `slug` (`slug`) USING BTREE,
  CONSTRAINT `blog_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog_categories`
--

DROP TABLE IF EXISTS `blog_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog_translations`
--

DROP TABLE IF EXISTS `blog_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_translations_blog_id_locale_unique` (`blog_id`,`locale`),
  KEY `blog_translations_locale_index` (`locale`),
  CONSTRAINT `blog_translations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_filter_option`
--

DROP TABLE IF EXISTS `bundle_filter_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bundle_filter_option` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bundle_id` int unsigned NOT NULL,
  `filter_option_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bundle_filter_option_bundle_id_foreign` (`bundle_id`),
  KEY `bundle_filter_option_filter_option_id_foreign` (`filter_option_id`),
  CONSTRAINT `bundle_filter_option_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bundle_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_translations`
--

DROP TABLE IF EXISTS `bundle_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bundle_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bundle_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `bundle_translations_bundle_id_foreign` (`bundle_id`),
  KEY `bundle_translations_locale_index` (`locale`),
  CONSTRAINT `bundle_translations_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_webinars`
--

DROP TABLE IF EXISTS `bundle_webinars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bundle_webinars` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `bundle_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `order` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bundle_webinars_bundle_id_foreign` (`bundle_id`),
  KEY `bundle_webinars_webinar_id_foreign` (`webinar_id`),
  CONSTRAINT `bundle_webinars_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bundle_webinars_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundles`
--

DROP TABLE IF EXISTS `bundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bundles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `teacher_id` int unsigned NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_demo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int DEFAULT NULL,
  `points` int DEFAULT NULL,
  `subscribe` tinyint(1) NOT NULL DEFAULT '0',
  `access_days` int unsigned DEFAULT NULL COMMENT 'Number of days to access the bundle',
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('active','pending','is_draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  `updated_at` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bundles_creator_id_foreign` (`creator_id`),
  KEY `bundles_teacher_id_foreign` (`teacher_id`),
  KEY `bundles_category_id_foreign` (`category_id`),
  KEY `bundles_slug_index` (`slug`),
  CONSTRAINT `bundles_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bundles_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bundles_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calibration_reports`
--

DROP TABLE IF EXISTS `calibration_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calibration_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total_questions` int NOT NULL,
  `questions_needing_review` int DEFAULT '0',
  `misclassified_questions` json DEFAULT NULL,
  `level_accuracy` json DEFAULT NULL,
  `recommendations` json DEFAULT NULL,
  `generated_at` datetime NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_generated_at` (`generated_at` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cancel_reasons`
--

DROP TABLE IF EXISTS `cancel_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancel_reasons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `cancellation_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cancellation_reason_categories`
--

DROP TABLE IF EXISTS `cancellation_reason_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancellation_reason_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `product_order_id` int unsigned DEFAULT NULL,
  `reserve_meeting_id` int unsigned DEFAULT NULL,
  `subscribe_id` int unsigned DEFAULT NULL,
  `promotion_id` int unsigned DEFAULT NULL,
  `ticket_id` int unsigned DEFAULT NULL,
  `special_offer_id` int unsigned DEFAULT NULL,
  `product_discount_id` int unsigned DEFAULT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cart_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `cart_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `cart_ticket_id_foreign` (`ticket_id`) USING BTREE,
  KEY `cart_reserve_meeting_id_foreign` (`reserve_meeting_id`) USING BTREE,
  KEY `cart_subscribe_id_foreign` (`subscribe_id`) USING BTREE,
  KEY `cart_promotion_id_foreign` (`promotion_id`) USING BTREE,
  KEY `cart_special_offer_id_foreign` (`special_offer_id`),
  KEY `cart_product_order_id_foreign` (`product_order_id`),
  KEY `cart_product_discount_id_foreign` (`product_discount_id`),
  KEY `cart_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `cart_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_product_discount_id_foreign` FOREIGN KEY (`product_discount_id`) REFERENCES `product_discounts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cart_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_reserve_meeting_id_foreign` FOREIGN KEY (`reserve_meeting_id`) REFERENCES `reserve_meetings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_special_offer_id_foreign` FOREIGN KEY (`special_offer_id`) REFERENCES `special_offers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=645 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_translations`
--

DROP TABLE IF EXISTS `category_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_translations_category_id_foreign` (`category_id`),
  KEY `category_translations_locale_index` (`locale`),
  CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificate_template_translations`
--

DROP TABLE IF EXISTS `certificate_template_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificate_template_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `certificate_template_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rtl` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificate_template_id` (`certificate_template_id`),
  KEY `certificate_template_translations_locale_index` (`locale`),
  CONSTRAINT `certificate_template_id` FOREIGN KEY (`certificate_template_id`) REFERENCES `certificates_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` int unsigned DEFAULT NULL,
  `quiz_result_id` int unsigned DEFAULT NULL,
  `student_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `user_grade` int unsigned DEFAULT NULL,
  `type` enum('quiz','course') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `certificates_quiz_id_foreign` (`quiz_id`) USING BTREE,
  KEY `certificates_quiz_result_id_foreign` (`quiz_result_id`) USING BTREE,
  KEY `certificates_student_id_foreign` (`student_id`) USING BTREE,
  KEY `certificates_webinar_id_foreign` (`webinar_id`),
  CONSTRAINT `certificates_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `certificates_quiz_result_id_foreign` FOREIGN KEY (`quiz_result_id`) REFERENCES `quizzes_results` (`id`) ON DELETE CASCADE,
  CONSTRAINT `certificates_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `certificates_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificates_templates`
--

DROP TABLE IF EXISTS `certificates_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificates_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('quiz','course') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_x` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position_y` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `font_size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','publish') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_attachments`
--

DROP TABLE IF EXISTS `class_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lesson_id` int DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_booking_failures`
--

DROP TABLE IF EXISTS `class_booking_failures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_booking_failures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `regular_class_id` int DEFAULT NULL,
  `student_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `attempted_meeting_start` datetime NOT NULL,
  `attempted_meeting_end` datetime NOT NULL,
  `failure_reason` varchar(100) NOT NULL,
  `detailed_reason` text,
  `batch_id` varchar(50) DEFAULT NULL,
  `data_json` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2747 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_reminders`
--

DROP TABLE IF EXISTS `class_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_reminders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lesson_id` int DEFAULT NULL,
  `notif_key` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `related` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_lesson_id` (`lesson_id`),
  KEY `idx_status` (`status`),
  KEY `idx_notif_key` (`notif_key`),
  KEY `idx_lesson_status` (`lesson_id`,`status`),
  KEY `idx_type` (`type`),
  KEY `idx_related` (`related`)
) ENGINE=InnoDB AUTO_INCREMENT=1616479 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_summaries`
--

DROP TABLE IF EXISTS `class_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_summaries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `summary_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `topics_detected` json DEFAULT NULL,
  `vocabulary_learned` json DEFAULT NULL,
  `grammar_concepts` json DEFAULT NULL,
  `strengths` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `areas_for_improvement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `engagement_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`),
  KEY `idx_class_created` (`class_id`,`created_at`),
  CONSTRAINT `fk_sum_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1873 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned DEFAULT NULL,
  `teacher_id` int unsigned NOT NULL,
  `feedback_id` int unsigned DEFAULT NULL,
  `meeting_start` datetime DEFAULT NULL,
  `meeting_end` datetime DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'pending' COMMENT 'Possible values: canceled - Class is canceled, pending - Class is scheduled but not yet held, ended - Class has been completed',
  `join_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `admin_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `zoom_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_goal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `student_goal_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `question_and_answer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_month_class_term` tinyint(1) NOT NULL DEFAULT '0',
  `bonus_class` tinyint(1) NOT NULL DEFAULT '0',
  `is_trial` tinyint(1) DEFAULT NULL,
  `subscription_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `booked_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Student',
  `canceled_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Student',
  `cancel_reason` text COLLATE utf8mb4_unicode_ci,
  `booked_by_admin_id` bigint unsigned DEFAULT NULL,
  `class_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'website',
  `batch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_regular_hide` tinyint NOT NULL DEFAULT '0',
  `demo_class_id` int unsigned DEFAULT NULL,
  `is_present` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 for absent, 1 for present',
  `cancellation_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Reason for cancellation if class was cancelled',
  `cancelled_by` int unsigned DEFAULT NULL COMMENT 'ID of user who cancelled the class',
  `cancelled_at` timestamp NULL DEFAULT NULL COMMENT 'Timestamp when the class was cancelled',
  `get_classes_for_extension` enum('updated','not_updated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not_updated' COMMENT 'Status for getClassesForExtension - whether the class has been updated or not',
  `recording_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'Status: pending, processing, completed, failed',
  `recording_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Zoom download URL',
  PRIMARY KEY (`id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_feedback_id` (`feedback_id`),
  KEY `idx_meeting_start` (`meeting_start`),
  KEY `idx_status` (`status`),
  KEY `idx_booked_by` (`booked_by`,`booked_by_admin_id`),
  KEY `idx_batch_id` (`batch_id`),
  KEY `idx_class_type` (`class_type`),
  KEY `idx_is_present` (`is_present`),
  KEY `idx_demo_class_id` (`demo_class_id`),
  KEY `cancelled_by` (`cancelled_by`),
  KEY `idx_classes_teacher_status` (`teacher_id`,`status`),
  KEY `idx_classes_student_status_meeting` (`student_id`,`status`,`meeting_start` DESC),
  KEY `idx_classes_student_meeting_teacher` (`student_id`,`meeting_start` DESC,`teacher_id`),
  KEY `idx_classes_status_start` (`status`,`meeting_start`),
  KEY `idx_student_status_start` (`student_id`,`status`,`meeting_start`),
  KEY `idx_teacher_time_overlap` (`teacher_id`,`meeting_start`,`meeting_end`,`status`),
  CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=250720 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cohort_retention`
--

DROP TABLE IF EXISTS `cohort_retention`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cohort_retention` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cohort_year` int NOT NULL,
  `cohort_month` int NOT NULL,
  `cohort_label` varchar(7) NOT NULL,
  `lead_source` varchar(50) DEFAULT NULL,
  `subscription_type` varchar(50) DEFAULT NULL,
  `sales_rep_id` bigint DEFAULT NULL,
  `trial_booked_by_type` varchar(50) DEFAULT NULL,
  `trial_coordinator_id` bigint DEFAULT NULL,
  `total_users` int NOT NULL DEFAULT '0',
  `month_1_active` int DEFAULT '0',
  `month_2_active` int DEFAULT '0',
  `month_3_active` int DEFAULT '0',
  `month_4_active` int DEFAULT '0',
  `month_5_active` int DEFAULT '0',
  `month_6_active` int DEFAULT '0',
  `month_7_active` int DEFAULT '0',
  `month_8_active` int DEFAULT '0',
  `month_9_active` int DEFAULT '0',
  `month_10_active` int DEFAULT '0',
  `month_11_active` int DEFAULT '0',
  `month_12_active` int DEFAULT '0',
  `month_1_percent` decimal(5,2) DEFAULT NULL,
  `month_2_percent` decimal(5,2) DEFAULT NULL,
  `month_3_percent` decimal(5,2) DEFAULT NULL,
  `month_4_percent` decimal(5,2) DEFAULT NULL,
  `month_5_percent` decimal(5,2) DEFAULT NULL,
  `month_6_percent` decimal(5,2) DEFAULT NULL,
  `month_7_percent` decimal(5,2) DEFAULT NULL,
  `month_8_percent` decimal(5,2) DEFAULT NULL,
  `month_9_percent` decimal(5,2) DEFAULT NULL,
  `month_10_percent` decimal(5,2) DEFAULT NULL,
  `month_11_percent` decimal(5,2) DEFAULT NULL,
  `month_12_percent` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cohort_retention_cohort` (`cohort_year`,`cohort_month`),
  KEY `idx_cohort_retention_sales_rep` (`sales_rep_id`),
  KEY `idx_cohort_retention_lead_source` (`lead_source`),
  KEY `idx_cohort_retention_subscription_type` (`subscription_type`),
  KEY `idx_cohort_retention_trial` (`trial_booked_by_type`,`trial_coordinator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8714 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `given_id` int unsigned DEFAULT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `blog_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `product_review_id` int unsigned DEFAULT NULL,
  `reply_id` int unsigned DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `report` tinyint(1) NOT NULL DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` int NOT NULL,
  `viewed_at` int unsigned DEFAULT NULL,
  `review_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `comments_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `comments_user_id_foreign` (`user_id`) USING BTREE,
  KEY `comments_review_id_foreign` (`review_id`) USING BTREE,
  KEY `comments_reply_id_foreign` (`reply_id`) USING BTREE,
  KEY `comments_product_id_foreign` (`product_id`),
  KEY `comments_bundle_id_foreign` (`bundle_id`),
  KEY `blog_id` (`blog_id`) USING BTREE,
  CONSTRAINT `comments_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_reply_id_foreign` FOREIGN KEY (`reply_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `webinar_reviews` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments_reports`
--

DROP TABLE IF EXISTS `comments_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_reports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `blog_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `comment_id` int unsigned NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `comments_reports_comment_id_foreign` (`comment_id`) USING BTREE,
  KEY `comments_reports_product_id_foreign` (`product_id`),
  CONSTRAINT `comments_reports_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_reports_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compensation_groups`
--

DROP TABLE IF EXISTS `compensation_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compensation_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `levels` json NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bonus_rules` json DEFAULT NULL COMMENT 'Bonus slabs with thresholds and amounts',
  `eligible_kpis` json NOT NULL COMMENT 'Eligibility KPIs per level (lessons, hours, retention rate)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_compensation_group_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','replied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_user` int DEFAULT NULL,
  `second_user` int DEFAULT NULL,
  `last_message_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_forum_answers`
--

DROP TABLE IF EXISTS `course_forum_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_forum_answers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT '0',
  `resolved` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_forum_answers_user_id_foreign` (`user_id`),
  KEY `course_forum_answers_forum_id_foreign` (`forum_id`),
  CONSTRAINT `course_forum_answers_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `course_forums` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_forum_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_forums`
--

DROP TABLE IF EXISTS `course_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_forums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_forums_webinar_id_foreign` (`webinar_id`),
  KEY `course_forums_user_id_foreign` (`user_id`),
  CONSTRAINT `course_forums_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_forums_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_learning`
--

DROP TABLE IF EXISTS `course_learning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_learning` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `text_lesson_id` int unsigned DEFAULT NULL,
  `file_id` int unsigned DEFAULT NULL,
  `session_id` int unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_learning_user_id_foreign` (`user_id`),
  KEY `course_learning_text_lesson_id_foreign` (`text_lesson_id`),
  KEY `course_learning_file_id_foreign` (`file_id`),
  KEY `course_learning_session_id_foreign` (`session_id`),
  CONSTRAINT `course_learning_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_learning_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_learning_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_learning_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_noticeboard_status`
--

DROP TABLE IF EXISTS `course_noticeboard_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_noticeboard_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `noticeboard_id` int unsigned NOT NULL,
  `seen_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_noticeboard_status_noticeboard_id_foreign` (`noticeboard_id`),
  CONSTRAINT `course_noticeboard_status_noticeboard_id_foreign` FOREIGN KEY (`noticeboard_id`) REFERENCES `course_noticeboards` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_noticeboards`
--

DROP TABLE IF EXISTS `course_noticeboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_noticeboards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `color` enum('warning','danger','neutral','info','success') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_noticeboards_creator_id_foreign` (`creator_id`),
  KEY `course_noticeboards_webinar_id_foreign` (`webinar_id`),
  CONSTRAINT `course_noticeboards_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_noticeboards_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_risk_calc_logs`
--

DROP TABLE IF EXISTS `daily_risk_calc_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_risk_calc_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `run_date` date NOT NULL,
  `start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` datetime DEFAULT NULL,
  `total_students` int NOT NULL DEFAULT '0',
  `affected_students` int NOT NULL DEFAULT '0',
  `created_events` int NOT NULL DEFAULT '0',
  `job_status` enum('completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'completed',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delete_account_requests`
--

DROP TABLE IF EXISTS `delete_account_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delete_account_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delete_account_requests_user_id_foreign` (`user_id`),
  CONSTRAINT `delete_account_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `democlasses`
--

DROP TABLE IF EXISTS `democlasses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `democlasses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teacher_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booked_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `whatsapp_notifications` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_notifications` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `regular_class_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_start` datetime NOT NULL,
  `meeting_end` datetime NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `language` enum('HE','EN','AR') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `trial_class_evaluation_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_full_name` (`full_name`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_mobile` (`mobile`),
  KEY `idx_email` (`email`),
  KEY `idx_status` (`status`),
  KEY `idx_meeting_start` (`meeting_start`),
  KEY `idx_meeting_end` (`meeting_end`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_trial_class_evaluation_id` (`trial_class_evaluation_id`),
  KEY `idx_teacher_status_start` (`teacher_id`,`status`,`meeting_start`),
  KEY `idx_language` (`language`),
  CONSTRAINT `democlasses_trial_class_evaluation_id_foreign` FOREIGN KEY (`trial_class_evaluation_id`) REFERENCES `trial_class_evaluations` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8443 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `direct_payment_customers`
--

DROP TABLE IF EXISTS `direct_payment_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_payment_customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_request_uid` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `country_code` varchar(10) NOT NULL DEFAULT '+972',
  `language` varchar(5) NOT NULL DEFAULT 'HE',
  `notes` text,
  `payment_amount` decimal(10,2) NOT NULL,
  `currency` varchar(5) NOT NULL DEFAULT 'ILS',
  `lesson_minutes` int NOT NULL,
  `lessons_per_month` int NOT NULL,
  `duration_months` int NOT NULL DEFAULT '1',
  `is_recurring` tinyint(1) DEFAULT '0',
  `plan_id` int DEFAULT NULL,
  `duration_type` varchar(50) DEFAULT NULL,
  `salesperson_id` int DEFAULT NULL,
  `payment_status` enum('pending','paid','failed','expired') DEFAULT 'pending',
  `payment_url` text,
  `payment_date` datetime DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_request_uid` (`page_request_uid`),
  KEY `idx_page_request_uid` (`page_request_uid`),
  KEY `idx_email` (`email`),
  KEY `idx_phone` (`phone`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_salesperson_id` (`salesperson_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_categories`
--

DROP TABLE IF EXISTS `discount_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `discount_categories_discount_id_foreign` (`discount_id`),
  KEY `discount_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `discount_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discount_categories_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_courses`
--

DROP TABLE IF EXISTS `discount_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_courses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` int unsigned NOT NULL,
  `course_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `discount_courses_discount_id_foreign` (`discount_id`),
  KEY `discount_courses_course_id_foreign` (`course_id`),
  CONSTRAINT `discount_courses_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discount_courses_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_groups`
--

DROP TABLE IF EXISTS `discount_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` int unsigned NOT NULL,
  `group_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `discount_groups_discount_id_foreign` (`discount_id`),
  KEY `discount_groups_group_id_foreign` (`group_id`),
  CONSTRAINT `discount_groups_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discount_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_users`
--

DROP TABLE IF EXISTS `discount_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `discount_users_discount_id_foreign` (`discount_id`) USING BTREE,
  KEY `discount_users_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `discount_users_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discount_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_type` enum('percentage','fixed_amount') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` enum('all','course','category','meeting','product') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `percent` int unsigned DEFAULT NULL,
  `amount` int unsigned DEFAULT NULL,
  `max_amount` int unsigned DEFAULT NULL,
  `minimum_order` int unsigned DEFAULT NULL,
  `count` int NOT NULL DEFAULT '1',
  `user_type` enum('all_users','special_users') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_type` enum('all','physical','virtual') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `for_first_purchase` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('active','disable') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `expired_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `discounts_code_unique` (`code`),
  KEY `discounts_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `discounts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dunning_schedules`
--

DROP TABLE IF EXISTS `dunning_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dunning_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `past_due_payment_id` int NOT NULL,
  `user_id` int unsigned NOT NULL,
  `is_enabled` tinyint(1) DEFAULT '1',
  `is_paused` tinyint(1) DEFAULT '0',
  `paused_until` datetime DEFAULT NULL,
  `paused_by_user_id` int unsigned DEFAULT NULL,
  `paused_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reminder_frequency` enum('daily','every_2_days','weekly') COLLATE utf8mb4_unicode_ci DEFAULT 'daily',
  `reminder_time` time DEFAULT '10:00:00',
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Asia/Jerusalem',
  `next_reminder_at` datetime DEFAULT NULL,
  `last_reminder_sent_at` datetime DEFAULT NULL,
  `total_reminders_sent` int DEFAULT '0',
  `max_reminders` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_past_due_payment_id` (`past_due_payment_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_next_reminder_at` (`next_reminder_at`),
  KEY `idx_is_enabled_paused` (`is_enabled`,`is_paused`),
  CONSTRAINT `dunning_schedules_ibfk_1` FOREIGN KEY (`past_due_payment_id`) REFERENCES `past_due_payments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dunning_schedules_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_login_attempts`
--

DROP TABLE IF EXISTS `failed_login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_login_attempts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failure_reason` enum('invalid_credentials','inactive_account','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'invalid_credentials',
  `additional_info` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12227 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `families`
--

DROP TABLE IF EXISTS `families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `families` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Full name of the parent/guardian',
  `parent_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Parent email address',
  `parent_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent phone number',
  `parent_country_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Country code for phone',
  `parent_address` text COLLATE utf8mb4_unicode_ci COMMENT 'Family address',
  `family_notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about the family',
  `status` enum('active','pending','suspended','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'Family account status',
  `created_by` int unsigned DEFAULT NULL COMMENT 'Sales person who created this family',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_parent_email` (`parent_email`),
  KEY `idx_created_by` (`created_by`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_parent_name` (`parent_name`),
  KEY `idx_status_created` (`status`,`created_at`),
  CONSTRAINT `families_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Main family/parent account information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_activity_log`
--

DROP TABLE IF EXISTS `family_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_activity_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `family_id` int unsigned DEFAULT NULL COMMENT 'Reference to families table',
  `child_id` int unsigned DEFAULT NULL COMMENT 'Reference to family_children table if child-specific',
  `user_id` int unsigned NOT NULL COMMENT 'User who performed the action',
  `action_type` enum('family_created','child_added','child_removed','child_status_changed','child_subscription_updated','payment_generated','payment_completed','subscription_modified','cart_updated','cart_subscription_configured') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of action performed',
  `action_description` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Human-readable description of the action',
  `old_values` json DEFAULT NULL COMMENT 'Previous values before change',
  `new_values` json DEFAULT NULL COMMENT 'New values after change',
  `metadata` json DEFAULT NULL COMMENT 'Additional metadata about the action',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_family_id` (`family_id`),
  KEY `idx_child_id` (`child_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_action_type` (`action_type`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `family_activity_log_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `family_children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_activity_log_family_id_foreign` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_activity_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Activity log for family account changes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_cart_items`
--

DROP TABLE IF EXISTS `family_cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_cart_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sales_user_id` int unsigned NOT NULL COMMENT 'Sales person who added to cart',
  `family_id` int unsigned NOT NULL COMMENT 'Reference to families table',
  `child_id` int unsigned NOT NULL COMMENT 'Reference to family_children table',
  `selected` tinyint(1) DEFAULT '1' COMMENT 'Whether this child is selected in cart',
  `cart_subscription_type` enum('monthly','quarterly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Subscription type selected in cart for payment generation',
  `cart_custom_amount` decimal(8,2) DEFAULT NULL COMMENT 'Custom amount set in cart for this child',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_cart_child` (`sales_user_id`,`child_id`),
  KEY `idx_sales_user_id` (`sales_user_id`),
  KEY `idx_family_id` (`family_id`),
  KEY `idx_child_id` (`child_id`),
  KEY `idx_selected` (`selected`),
  KEY `idx_cart_subscription_type` (`cart_subscription_type`),
  CONSTRAINT `family_cart_items_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `family_children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_cart_items_family_id_foreign` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_cart_items_sales_user_id_foreign` FOREIGN KEY (`sales_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cart system for selecting individual children for payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_children`
--

DROP TABLE IF EXISTS `family_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_children` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `family_id` int unsigned NOT NULL COMMENT 'Reference to families table',
  `child_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Child full name',
  `child_age` int NOT NULL COMMENT 'Child age',
  `relationship_to_parent` enum('son','daughter','stepson','stepdaughter','nephew','niece','grandson','granddaughter','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'son' COMMENT 'Relationship to parent/guardian',
  `subscription_type` enum('monthly','quarterly','yearly','custom') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Subscription billing type - set during payment generation',
  `durationmonths` int DEFAULT NULL COMMENT 'Duration Months',
  `monthly_amount` decimal(8,2) DEFAULT NULL COMMENT 'Monthly subscription amount for this child - set during payment',
  `custom_amount` decimal(8,2) DEFAULT NULL COMMENT 'Custom amount if different from standard pricing',
  `status` enum('active','paused','cancelled','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'Child subscription status',
  `payplus_subscription_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus subscription ID for this child',
  `subscription_start_date` date DEFAULT NULL COMMENT 'When subscription started',
  `next_payment_date` date DEFAULT NULL COMMENT 'Next payment due date',
  `last_payment_date` date DEFAULT NULL COMMENT 'Last successful payment date',
  `child_notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Notes specific to this child',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `child_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_family_id` (`family_id`),
  KEY `idx_status` (`status`),
  KEY `idx_subscription_type` (`subscription_type`),
  KEY `idx_payplus_subscription_id` (`payplus_subscription_id`),
  KEY `idx_child_name` (`child_name`),
  KEY `idx_next_payment_date` (`next_payment_date`),
  KEY `idx_relationship` (`relationship_to_parent`),
  KEY `idx_status_subscription` (`status`,`subscription_type`),
  CONSTRAINT `family_children_family_id_foreign` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Individual children under family accounts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_payment_links`
--

DROP TABLE IF EXISTS `family_payment_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_payment_links` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `link_token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique token for this payment link',
  `sales_user_id` int unsigned NOT NULL COMMENT 'Sales person who generated the link',
  `selected_children_ids` json DEFAULT NULL COMMENT 'Legacy field - replaced by selected_children_details',
  `selected_children_details` json NOT NULL COMMENT 'Array of selected children with their subscription details for payment',
  `total_amount` decimal(10,2) NOT NULL COMMENT 'Total payment amount',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'USD' COMMENT 'Payment currency',
  `payment_type` enum('one_time','recurring') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of payment',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Payment description',
  `custom_note` text COLLATE utf8mb4_unicode_ci COMMENT 'Custom note for the payment',
  `payplus_payment_url` text COLLATE utf8mb4_unicode_ci COMMENT 'PayPlus payment URL',
  `payplus_page_request_uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus page request UID',
  `payplus_qr_code` text COLLATE utf8mb4_unicode_ci COMMENT 'PayPlus QR code image URL',
  `status` enum('active','used','expired','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'active' COMMENT 'Payment link status',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'When the payment link expires',
  `used_at` timestamp NULL DEFAULT NULL COMMENT 'When the payment link was used',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_link_token` (`link_token`),
  KEY `idx_sales_user_id` (`sales_user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_payment_type` (`payment_type`),
  KEY `idx_expires_at` (`expires_at`),
  KEY `idx_payplus_page_request_uid` (`payplus_page_request_uid`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `family_payment_links_sales_user_id_foreign` FOREIGN KEY (`sales_user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='PayPlus payment links for family subscriptions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_payment_transactions`
--

DROP TABLE IF EXISTS `family_payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_payment_transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_link_id` int unsigned DEFAULT NULL COMMENT 'Reference to family_payment_links',
  `transaction_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique transaction token',
  `payplus_transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'PayPlus transaction ID',
  `family_id` int unsigned NOT NULL COMMENT 'Reference to families table',
  `paid_children_ids` json NOT NULL COMMENT 'Array of child IDs that were paid for',
  `amount` decimal(10,2) NOT NULL COMMENT 'Payment amount',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'USD' COMMENT 'Payment currency',
  `payment_type` enum('one_time','recurring') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of payment',
  `status` enum('success','failed','pending','refunded') COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'Transaction status',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Payment method used',
  `card_last_digits` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Last 4 digits of card',
  `payplus_response_data` json DEFAULT NULL COMMENT 'Full PayPlus response data',
  `error_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Error code if failed',
  `error_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Error message if failed',
  `processed_at` timestamp NULL DEFAULT NULL COMMENT 'When payment was processed',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paid_children_details` json DEFAULT NULL COMMENT 'Detailed information about paid children with their subscription types',
  `student_ids` json DEFAULT NULL COMMENT 'Array of student IDs associated with this payment transaction',
  `subscription_ids` json DEFAULT NULL COMMENT 'Array of UserSubscriptionDetails IDs created for this payment',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_transaction_token` (`transaction_token`),
  KEY `idx_payment_link_id` (`payment_link_id`),
  KEY `idx_payplus_transaction_id` (`payplus_transaction_id`),
  KEY `idx_family_id` (`family_id`),
  KEY `idx_status` (`status`),
  KEY `idx_payment_type` (`payment_type`),
  KEY `idx_processed_at` (`processed_at`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `family_payment_transactions_family_id_foreign` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_payment_transactions_payment_link_id_foreign` FOREIGN KEY (`payment_link_id`) REFERENCES `family_payment_links` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Completed payment transactions for families';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_subscription_modifications`
--

DROP TABLE IF EXISTS `family_subscription_modifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_subscription_modifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `family_id` int unsigned NOT NULL COMMENT 'Reference to families table',
  `child_id` int unsigned NOT NULL COMMENT 'Reference to family_children table',
  `old_subscription_type` enum('monthly','quarterly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous subscription type',
  `new_subscription_type` enum('monthly','quarterly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'New subscription type',
  `old_amount` decimal(8,2) DEFAULT NULL COMMENT 'Previous amount',
  `new_amount` decimal(8,2) DEFAULT NULL COMMENT 'New amount',
  `modification_reason` enum('parent_request','payment_failure','upgrade','downgrade','custom_pricing','other') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Reason for modification',
  `requested_by_user_id` int unsigned DEFAULT NULL COMMENT 'User who requested the change',
  `processed_by_user_id` int unsigned DEFAULT NULL COMMENT 'User who processed the change',
  `effective_date` date NOT NULL COMMENT 'When the change takes effect',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about the modification',
  `payplus_modification_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus modification reference',
  `status` enum('pending','approved','rejected','completed','failed') COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'Modification status',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_family_id` (`family_id`),
  KEY `idx_child_id` (`child_id`),
  KEY `idx_effective_date` (`effective_date`),
  KEY `idx_status` (`status`),
  KEY `idx_modification_reason` (`modification_reason`),
  KEY `family_subscription_modifications_requested_by_foreign` (`requested_by_user_id`),
  KEY `family_subscription_modifications_processed_by_foreign` (`processed_by_user_id`),
  CONSTRAINT `family_subscription_modifications_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `family_children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_subscription_modifications_family_id_foreign` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE,
  CONSTRAINT `family_subscription_modifications_processed_by_foreign` FOREIGN KEY (`processed_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `family_subscription_modifications_requested_by_foreign` FOREIGN KEY (`requested_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track subscription modifications for individual children';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `family_totals_view`
--

DROP TABLE IF EXISTS `family_totals_view`;
/*!50001 DROP VIEW IF EXISTS `family_totals_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `family_totals_view` AS SELECT 
 1 AS `family_id`,
 1 AS `parent_name`,
 1 AS `parent_email`,
 1 AS `family_status`,
 1 AS `total_children`,
 1 AS `active_children`,
 1 AS `total_monthly_amount`,
 1 AS `monthly_revenue`,
 1 AS `quarterly_monthly_equivalent`,
 1 AS `yearly_monthly_equivalent`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `faq_translations`
--

DROP TABLE IF EXISTS `faq_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `faq_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `faq_translations_faq_id_foreign` (`faq_id`),
  KEY `faq_translations_locale_index` (`locale`),
  CONSTRAINT `faq_translations_faq_id_foreign` FOREIGN KEY (`faq_id`) REFERENCES `faqs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `order` int unsigned DEFAULT NULL,
  `created_at` int unsigned DEFAULT NULL,
  `updated_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `faqs_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `faqs_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `faqs_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `faqs_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `faqs_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `faqs_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `favorites_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `favorites_user_id_foreign` (`user_id`) USING BTREE,
  KEY `favorites_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `favorites_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feature_webinar_translations`
--

DROP TABLE IF EXISTS `feature_webinar_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_webinar_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `feature_webinar_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `feature_webinar_translations_feature_webinar_id_foreign` (`feature_webinar_id`),
  KEY `feature_webinar_translations_locale_index` (`locale`),
  CONSTRAINT `feature_webinar_translations_feature_webinar_id_foreign` FOREIGN KEY (`feature_webinar_id`) REFERENCES `feature_webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feature_webinars`
--

DROP TABLE IF EXISTS `feature_webinars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature_webinars` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `page` enum('categories','home','home_categories') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('publish','pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `feature_webinars_webinar_id_index` (`webinar_id`) USING BTREE,
  CONSTRAINT `feature_webinars_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_translations`
--

DROP TABLE IF EXISTS `file_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `file_translations_file_id_foreign` (`file_id`),
  KEY `file_translations_locale_index` (`locale`),
  CONSTRAINT `file_translations_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `chapter_id` int unsigned DEFAULT NULL,
  `accessibility` enum('free','paid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `downloadable` tinyint(1) DEFAULT '0',
  `storage` enum('upload','youtube','vimeo','external_link','google_drive','dropbox','iframe','s3','upload_archive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `interactive_type` enum('adobe_captivate','i_spring','custom') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interactive_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interactive_file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT '0',
  `access_after_day` int unsigned DEFAULT NULL,
  `online_viewer` tinyint(1) NOT NULL DEFAULT '0',
  `order` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `files_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `files_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `files_chapter_id_foreign` (`chapter_id`),
  CONSTRAINT `files_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `files_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `files_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fill_blank_options`
--

DROP TABLE IF EXISTS `fill_blank_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fill_blank_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint unsigned NOT NULL,
  `option_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fill_blank_questions`
--

DROP TABLE IF EXISTS `fill_blank_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fill_blank_questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sentence` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `missing_word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `translation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `example` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `difficulty` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter_option_translations`
--

DROP TABLE IF EXISTS `filter_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filter_option_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `filter_option_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_option_translations_filter_option_id_foreign` (`filter_option_id`),
  KEY `filter_option_translations_locale_index` (`locale`),
  CONSTRAINT `filter_option_translations_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter_options`
--

DROP TABLE IF EXISTS `filter_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filter_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int unsigned NOT NULL,
  `order` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `filter_options_filter_id_foreign` (`filter_id`) USING BTREE,
  CONSTRAINT `filter_options_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter_translations`
--

DROP TABLE IF EXISTS `filter_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filter_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_translations_filter_id_foreign` (`filter_id`),
  KEY `filter_translations_locale_index` (`locale`),
  CONSTRAINT `filter_translations_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filters`
--

DROP TABLE IF EXISTS `filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `filters_category_id_foreign` (`category_id`) USING BTREE,
  CONSTRAINT `filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `find_teacher_results`
--

DROP TABLE IF EXISTS `find_teacher_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `find_teacher_results` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `filter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `teacher_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=543881 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `follower` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `status` enum('requested','accepted','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `follows_follower_foreign` (`follower`) USING BTREE,
  KEY `follows_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `follows_follower_foreign` FOREIGN KEY (`follower`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `follows_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_featured_topics`
--

DROP TABLE IF EXISTS `forum_featured_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_featured_topics` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int unsigned NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_featured_topics_topic_id_foreign` (`topic_id`),
  CONSTRAINT `forum_featured_topics_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_recommended_topic_items`
--

DROP TABLE IF EXISTS `forum_recommended_topic_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_recommended_topic_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `recommended_topic_id` int unsigned NOT NULL,
  `topic_id` int unsigned NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_recommended_topic_items_recommended_topic_id_foreign` (`recommended_topic_id`),
  KEY `forum_recommended_topic_items_topic_id_foreign` (`topic_id`),
  CONSTRAINT `forum_recommended_topic_items_recommended_topic_id_foreign` FOREIGN KEY (`recommended_topic_id`) REFERENCES `forum_recommended_topics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_recommended_topic_items_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_recommended_topics`
--

DROP TABLE IF EXISTS `forum_recommended_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_recommended_topics` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic_attachments`
--

DROP TABLE IF EXISTS `forum_topic_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic_attachments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `topic_id` int unsigned NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_topic_attachments_topic_id_foreign` (`topic_id`),
  KEY `forum_topic_attachments_creator_id_foreign` (`creator_id`),
  CONSTRAINT `forum_topic_attachments_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_attachments_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic_bookmarks`
--

DROP TABLE IF EXISTS `forum_topic_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic_bookmarks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `topic_id` int unsigned NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_topic_bookmarks_user_id_foreign` (`user_id`),
  KEY `forum_topic_bookmarks_topic_id_foreign` (`topic_id`),
  CONSTRAINT `forum_topic_bookmarks_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic_likes`
--

DROP TABLE IF EXISTS `forum_topic_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic_likes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `topic_id` int unsigned DEFAULT NULL,
  `topic_post_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_topic_likes_user_id_foreign` (`user_id`),
  KEY `forum_topic_likes_topic_id_foreign` (`topic_id`),
  KEY `forum_topic_likes_topic_post_id_foreign` (`topic_post_id`),
  CONSTRAINT `forum_topic_likes_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_likes_topic_post_id_foreign` FOREIGN KEY (`topic_post_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic_posts`
--

DROP TABLE IF EXISTS `forum_topic_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic_posts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `topic_id` int unsigned NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_topic_posts_user_id_foreign` (`user_id`),
  KEY `forum_topic_posts_topic_id_foreign` (`topic_id`),
  KEY `forum_topic_posts_parent_id_foreign` (`parent_id`),
  CONSTRAINT `forum_topic_posts_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `forum_topic_posts_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic_reports`
--

DROP TABLE IF EXISTS `forum_topic_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic_reports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `topic_id` int unsigned DEFAULT NULL,
  `topic_post_id` int unsigned DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_topic_reports_user_id_foreign` (`user_id`),
  KEY `forum_topic_reports_topic_id_foreign` (`topic_id`),
  KEY `forum_topic_reports_topic_post_id_foreign` (`topic_post_id`),
  CONSTRAINT `forum_topic_reports_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_reports_topic_post_id_foreign` FOREIGN KEY (`topic_post_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topic_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topics`
--

DROP TABLE IF EXISTS `forum_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topics` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `forum_id` int unsigned NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT '0',
  `close` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_topics_slug_unique` (`slug`),
  KEY `forum_topics_creator_id_foreign` (`creator_id`),
  KEY `forum_topics_forum_id_foreign` (`forum_id`),
  CONSTRAINT `forum_topics_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forum_topics_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_translations`
--

DROP TABLE IF EXISTS `forum_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `forum_translations_forum_id_foreign` (`forum_id`),
  KEY `forum_translations_locale_index` (`locale`),
  CONSTRAINT `forum_translations_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int unsigned DEFAULT NULL,
  `group_id` int unsigned DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `close` tinyint(1) NOT NULL DEFAULT '0',
  `order` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forums_slug_unique` (`slug`),
  KEY `forums_role_id_foreign` (`role_id`),
  KEY `forums_group_id_foreign` (`group_id`),
  CONSTRAINT `forums_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `forums_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `free_classes`
--

DROP TABLE IF EXISTS `free_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `free_classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `referred_user_id` int DEFAULT NULL,
  `count_free_class` int DEFAULT '0',
  `created_at` int DEFAULT (unix_timestamp()),
  `updated_at` int DEFAULT (unix_timestamp()),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_results`
--

DROP TABLE IF EXISTS `game_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_results` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `attempts` int DEFAULT '1',
  `time_spent_ms` int DEFAULT '0',
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `selected_answer` int DEFAULT NULL,
  `selected_answers` json DEFAULT NULL,
  `error_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_item_id` (`item_id`),
  CONSTRAINT `fk_results_sessions` FOREIGN KEY (`session_id`) REFERENCES `game_sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_sessions`
--

DROP TABLE IF EXISTS `game_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_sessions` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `game_type` enum('flashcards','spelling_bee','grammar_challenge','advanced_cloze','sentence_builder') COLLATE utf8mb4_unicode_ci NOT NULL,
  `mode` enum('topic','lesson','custom','mistakes') COLLATE utf8mb4_unicode_ci DEFAULT 'topic',
  `class_id` int DEFAULT NULL,
  `topic_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difficulty` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'CEFR level',
  `progress_current` int DEFAULT '0',
  `progress_total` int DEFAULT '0',
  `correct_count` int DEFAULT '0',
  `incorrect_count` int DEFAULT '0',
  `status` enum('active','completed','abandoned') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `started_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_game_type` (`game_type`),
  KEY `idx_status` (`status`),
  KEY `idx_class` (`class_id`),
  CONSTRAINT `fk_gamesess_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_id` int NOT NULL,
  `student_id` int unsigned NOT NULL,
  `exercise_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'flashcards, spelling, advanced_cloze, grammar_challenge, sentence_builder',
  `exercise_data` json NOT NULL COMMENT 'Single exercise content',
  `topic_id` int DEFAULT NULL COMMENT 'Link to topics_taught.id',
  `topic_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difficulty` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'B1' COMMENT 'CEFR: A1, A2, B1, B2, C1, C2',
  `hint` text COLLATE utf8mb4_unicode_ci COMMENT 'Optional hint',
  `explanation` text COLLATE utf8mb4_unicode_ci COMMENT 'Explanation of answer',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'pending, approved, rejected',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_class` (`class_id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_type` (`exercise_type`),
  KEY `idx_status` (`status`),
  KEY `idx_topic` (`topic_id`),
  KEY `idx_difficulty` (`difficulty`),
  KEY `idx_type_status` (`exercise_type`,`status`),
  CONSTRAINT `fk_games_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_games_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Solution D: Individual exercises (canonical source)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `google_tokens`
--

DROP TABLE IF EXISTS `google_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `google_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `access_token` text COLLATE utf8mb4_general_ci NOT NULL,
  `refresh_token` text COLLATE utf8mb4_general_ci,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_users`
--

DROP TABLE IF EXISTS `group_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `group_users_group_id_foreign` (`group_id`) USING BTREE,
  KEY `group_users_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `group_users_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `commission` int DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `groups_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `groups_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups_registration_packages`
--

DROP TABLE IF EXISTS `groups_registration_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups_registration_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `instructors_count` int DEFAULT NULL,
  `students_count` int DEFAULT NULL,
  `courses_capacity` int DEFAULT NULL,
  `courses_count` int DEFAULT NULL,
  `meeting_count` int DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `groups_registration_packages_group_id_foreign` (`group_id`),
  CONSTRAINT `groups_registration_packages_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `home_sections`
--

DROP TABLE IF EXISTS `home_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `home_sections` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` enum('featured_classes','latest_bundles','latest_classes','best_rates','trend_categories','full_advertising_banner','best_sellers','discount_classes','free_classes','store_products','testimonials','subscribes','find_instructors','reward_program','become_instructor','forum_section','video_or_image_section','instructors','half_advertising_banner','organizations','blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `home_sections_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `homeworks`
--

DROP TABLE IF EXISTS `homeworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homeworks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lesson_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `student_answers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `answer_attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` int DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `teacher_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `homeworkImage` varchar(210) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `toggle_attachment_for_student` tinyint NOT NULL DEFAULT '0',
  `toggle_description_for_student` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_student_status` (`student_id`,`status`),
  KEY `idx_lesson_id` (`lesson_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_status` (`status`),
  KEY `idx_result` (`result`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_toggle_attachment_description` (`toggle_attachment_for_student`,`toggle_description_for_student`),
  KEY `idx_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=87253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idempotency_keys`
--

DROP TABLE IF EXISTS `idempotency_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idempotency_keys` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idempotency_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `response_data` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_endpoint_key` (`user_id`,`endpoint`,`idempotency_key`),
  CONSTRAINT `fk_idempotency_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jazzcash_transactions`
--

DROP TABLE IF EXISTS `jazzcash_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jazzcash_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `txn_ref_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Order data fields and values',
  `request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Jazzcash request data fields and values',
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT 'Jazzcash response data fields and values',
  `status` enum('pending','error','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=447006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `is_registered` int unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lesson_feedback`
--

DROP TABLE IF EXISTS `lesson_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lesson_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lesson_feedbacks`
--

DROP TABLE IF EXISTS `lesson_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_feedbacks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `pronunciation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `speaking` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `grammar_rate` int DEFAULT NULL,
  `pronunciation_rate` int DEFAULT NULL,
  `speaking_rate` int DEFAULT NULL,
  `grammar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_lesson_id` (`lesson_id`),
  KEY `idx_teacher_student` (`teacher_id`,`student_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=89675 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lesson_lengths`
--

DROP TABLE IF EXISTS `lesson_lengths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_lengths` (
  `id` int NOT NULL AUTO_INCREMENT,
  `duration_id` int NOT NULL,
  `minutes` int NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `duration_id` (`duration_id`),
  CONSTRAINT `lesson_lengths_ibfk_1` FOREIGN KEY (`duration_id`) REFERENCES `subscription_durations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lessons_per_month`
--

DROP TABLE IF EXISTS `lessons_per_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessons_per_month` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lesson_length_id` int NOT NULL,
  `lessons` int NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `lesson_length_id` (`lesson_length_id`),
  CONSTRAINT `lessons_per_month_ibfk_1` FOREIGN KEY (`lesson_length_id`) REFERENCES `lesson_lengths` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `level_assessments`
--

DROP TABLE IF EXISTS `level_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level_assessments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `student_id` int unsigned NOT NULL,
  `detected_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `vocabulary_score` decimal(5,2) DEFAULT NULL,
  `grammar_score` decimal(5,2) DEFAULT NULL,
  `fluency_score` decimal(5,2) DEFAULT NULL,
  `level_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `assessed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_class_student` (`class_id`,`student_id`),
  KEY `idx_student_level` (`student_id`,`detected_level`),
  KEY `idx_assessed_at` (`assessed_at`),
  CONSTRAINT `fk_level_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_level_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1608 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ltm_translations`
--

DROP TABLE IF EXISTS `ltm_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ltm_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` int NOT NULL DEFAULT '0',
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_event_logs`
--

DROP TABLE IF EXISTS `manual_event_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manual_event_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int unsigned NOT NULL,
  `student_id` int unsigned NOT NULL,
  `event_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int unsigned NOT NULL,
  `action` enum('create','update','delete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'create',
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meeting_times`
--

DROP TABLE IF EXISTS `meeting_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting_times` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int unsigned NOT NULL,
  `meeting_type` enum('all','in_person','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
  `day_label` enum('saturday','sunday','monday','tuesday','wednesday','thursday','friday') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `meeting_times_meeting_id_foreign` (`meeting_id`) USING BTREE,
  CONSTRAINT `meeting_times_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `amount` int unsigned DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `in_person` tinyint(1) NOT NULL DEFAULT '0',
  `in_person_amount` int DEFAULT NULL,
  `group_meeting` tinyint(1) NOT NULL DEFAULT '0',
  `online_group_min_student` int DEFAULT NULL,
  `online_group_max_student` int DEFAULT NULL,
  `online_group_amount` int DEFAULT NULL,
  `in_person_group_min_student` int DEFAULT NULL,
  `in_person_group_max_student` int DEFAULT NULL,
  `in_person_group_amount` int DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `meetings_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `meetings_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `memory_game_progress`
--

DROP TABLE IF EXISTS `memory_game_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `memory_game_progress` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `pairs_found` int NOT NULL DEFAULT '0',
  `total_moves` int NOT NULL DEFAULT '0',
  `time_elapsed` int NOT NULL DEFAULT '0',
  `hints_used` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_user` int NOT NULL,
  `to_user` int DEFAULT NULL,
  `statu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `attachment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversation_id` int DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=532 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navbar_button_translations`
--

DROP TABLE IF EXISTS `navbar_button_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navbar_button_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `navbar_button_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navbar_button_translations_navbar_button_id_foreign` (`navbar_button_id`),
  KEY `navbar_button_translations_locale_index` (`locale`),
  CONSTRAINT `navbar_button_translations_navbar_button_id_foreign` FOREIGN KEY (`navbar_button_id`) REFERENCES `navbar_buttons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navbar_buttons`
--

DROP TABLE IF EXISTS `navbar_buttons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navbar_buttons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navbar_buttons_role_id_foreign` (`role_id`),
  CONSTRAINT `navbar_buttons_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `new_notifications`
--

DROP TABLE IF EXISTS `new_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `value_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `value_he` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `title_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `title_he` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsletters_history`
--

DROP TABLE IF EXISTS `newsletters_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletters_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_method` enum('send_to_all','send_to_bcc','send_to_excel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bcc_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_count` int DEFAULT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noticeboards`
--

DROP TABLE IF EXISTS `noticeboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `noticeboards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `organ_id` int unsigned DEFAULT NULL,
  `instructor_id` int unsigned DEFAULT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `type` enum('all','organizations','students','instructors','students_and_instructors') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `noticeboards_organ_id_foreign` (`organ_id`),
  KEY `noticeboards_user_id_foreign` (`user_id`),
  KEY `noticeboards_instructor_id_foreign` (`instructor_id`),
  KEY `noticeboards_webinar_id_foreign` (`webinar_id`),
  CONSTRAINT `noticeboards_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `noticeboards_organ_id_foreign` FOREIGN KEY (`organ_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `noticeboards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `noticeboards_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noticeboards_status`
--

DROP TABLE IF EXISTS `noticeboards_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `noticeboards_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `noticeboard_id` int unsigned NOT NULL,
  `seen_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `noticeboards_status_noticeboard_id_foreign` (`noticeboard_id`),
  CONSTRAINT `noticeboards_status_noticeboard_id_foreign` FOREIGN KEY (`noticeboard_id`) REFERENCES `noticeboards` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `sender_id` int unsigned DEFAULT NULL,
  `group_id` int unsigned DEFAULT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` enum('system','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'system',
  `type` enum('single','all_users','students','instructors','organizations','group','course_students') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `notifications_user_id_foreign` (`user_id`) USING BTREE,
  KEY `notifications_group_id_foreign` (`group_id`) USING BTREE,
  KEY `webinar_id` (`webinar_id`) USING BTREE,
  CONSTRAINT `notifications_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2773 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications_status`
--

DROP TABLE IF EXISTS `notifications_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `notification_id` int unsigned NOT NULL,
  `seen_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `notifications_status_notification_id_foreign` (`notification_id`) USING BTREE,
  CONSTRAINT `notifications_status_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offline_payments`
--

DROP TABLE IF EXISTS `offline_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offline_payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `amount` int NOT NULL,
  `bank` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('waiting','approved','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pay_date` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `offline_payments_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `offline_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `order_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `subscribe_id` int unsigned DEFAULT NULL,
  `promotion_id` int unsigned DEFAULT NULL,
  `registration_package_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `product_order_id` int unsigned DEFAULT NULL,
  `reserve_meeting_id` int unsigned DEFAULT NULL,
  `ticket_id` int unsigned DEFAULT NULL,
  `discount_id` int DEFAULT NULL,
  `become_instructor_id` int unsigned DEFAULT NULL,
  `amount` int unsigned DEFAULT NULL,
  `tax` int unsigned DEFAULT NULL,
  `tax_price` decimal(13,2) DEFAULT NULL,
  `commission` int unsigned DEFAULT NULL,
  `commission_price` decimal(13,2) DEFAULT NULL,
  `discount` decimal(13,2) DEFAULT NULL,
  `total_amount` decimal(13,2) DEFAULT NULL,
  `product_delivery_fee` decimal(13,2) DEFAULT NULL,
  `created_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_items_order_id_foreign` (`order_id`) USING BTREE,
  KEY `order_items_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `order_items_ticket_id_foreign` (`ticket_id`) USING BTREE,
  KEY `order_items_reserve_meeting_id_foreign` (`reserve_meeting_id`) USING BTREE,
  KEY `order_items_subscribe_id_foreign` (`subscribe_id`) USING BTREE,
  KEY `order_items_promotion_id_foreign` (`promotion_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `status` enum('pending','paying','paid','fail') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` enum('credit','payment_channel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_charge_account` tinyint(1) NOT NULL DEFAULT '0',
  `amount` int unsigned NOT NULL,
  `tax` decimal(13,2) DEFAULT NULL,
  `total_discount` decimal(13,2) DEFAULT NULL,
  `total_amount` decimal(13,2) DEFAULT NULL,
  `product_delivery_fee` decimal(13,2) DEFAULT NULL,
  `reference_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payment_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `orders_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_translations`
--

DROP TABLE IF EXISTS `page_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `page_translations_page_id_foreign` (`page_id`),
  KEY `page_translations_locale_index` (`locale`),
  CONSTRAINT `page_translations_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `robot` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('publish','draft') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_link_unique` (`link`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `past_due_payments`
--

DROP TABLE IF EXISTS `past_due_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `past_due_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `subscription_id` int DEFAULT NULL,
  `recurring_payment_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'ILS',
  `failed_at` datetime NOT NULL,
  `due_date` date NOT NULL,
  `grace_period_days` int DEFAULT '30',
  `grace_period_expires_at` datetime NOT NULL,
  `status` enum('past_due','resolved','canceled') COLLATE utf8mb4_unicode_ci DEFAULT 'past_due',
  `attempt_number` int DEFAULT '1',
  `last_reminder_sent_at` datetime DEFAULT NULL,
  `total_reminders_sent` int DEFAULT '0',
  `payment_link` text COLLATE utf8mb4_unicode_ci,
  `payplus_page_request_uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `resolved_transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canceled_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `failure_status_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus status code for the failed payment',
  `failure_message_description` text COLLATE utf8mb4_unicode_ci COMMENT 'PayPlus message description for the failed payment',
  `whatsapp_messages_sent` int DEFAULT '0' COMMENT 'Count of WhatsApp messages sent for this payment recovery',
  `resolved_payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Payment method used for manual resolution (free_gift, bit, bank_transfer, cash, other)',
  `cancellation_reason_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Category of cancellation reason',
  `cancellation_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Detailed cancellation reason text',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_grace_period_expires_at` (`grace_period_expires_at`),
  KEY `idx_due_date` (`due_date`),
  KEY `idx_past_due_whatsapp_stats` (`created_at`,`whatsapp_messages_sent`),
  CONSTRAINT `past_due_payments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payku_payments`
--

DROP TABLE IF EXISTS `payku_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payku_payments` (
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `media` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `verification_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorization_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_4_digits` int unsigned DEFAULT NULL,
  `installments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_parameters` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_date` datetime DEFAULT NULL,
  UNIQUE KEY `payku_payments_transaction_id_unique` (`transaction_id`),
  CONSTRAINT `payku_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `payku_transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payku_transactions`
--

DROP TABLE IF EXISTS `payku_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payku_transactions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `amount` int unsigned DEFAULT NULL,
  `notified_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `payku_transactions_id_unique` (`id`),
  UNIQUE KEY `payku_transactions_order_unique` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_channels`
--

DROP TABLE IF EXISTS `payment_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_channels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_details`
--

DROP TABLE IF EXISTS `payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_id` bigint NOT NULL,
  `cvv` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `exp_month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `exp_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_surname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_st1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_st2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_zip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_history`
--

DROP TABLE IF EXISTS `payment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_history` (
  `id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `code` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_links`
--

DROP TABLE IF EXISTS `payment_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `short_id` varchar(8) COLLATE utf8mb4_bin NOT NULL COMMENT 'Unique 8-character alphanumeric identifier',
  `payment_data` json NOT NULL COMMENT 'Encrypted payment information and metadata',
  `expires_at` datetime NOT NULL COMMENT 'Link expiration timestamp',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Record creation timestamp',
  `accessed_at` datetime DEFAULT NULL COMMENT 'Last access timestamp',
  `access_count` int NOT NULL DEFAULT '0' COMMENT 'Number of times link was accessed',
  `status` enum('active','expired','used') COLLATE utf8mb4_bin NOT NULL DEFAULT 'active' COMMENT 'Link status',
  PRIMARY KEY (`id`),
  UNIQUE KEY `short_id` (`short_id`),
  KEY `idx_short_id` (`short_id`),
  KEY `idx_expires_at` (`expires_at`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_status` (`status`),
  CONSTRAINT `chk_expires_at_future` CHECK ((`expires_at` > `created_at`)),
  CONSTRAINT `chk_short_id_length` CHECK ((char_length(`short_id`) = 8))
) ENGINE=InnoDB AUTO_INCREMENT=3505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Table for storing short payment link data with expiration and tracking';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_meshulam`
--

DROP TABLE IF EXISTS `payment_meshulam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_meshulam` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `page_code` varchar(50) NOT NULL,
  `processId` varchar(255) DEFAULT NULL,
  `processToken` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `transaction_token` varchar(100) DEFAULT NULL,
  `callback_data` text,
  `url` varchar(255) DEFAULT NULL,
  `pyament_status` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_transactions`
--

DROP TABLE IF EXISTS `payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Payment link token',
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tranzila transaction ID',
  `student_id` int DEFAULT NULL COMMENT 'User ID (NULL for non-registered users)',
  `student_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_new_email` varchar(125) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_old_email` varchar(125) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` int DEFAULT NULL COMMENT 'Subscription plan ID (if applicable)',
  `lessons_per_month` int DEFAULT NULL,
  `duration_type` int DEFAULT NULL,
  `lesson_minutes` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ILS',
  `is_recurring` tinyint(1) NOT NULL DEFAULT '0',
  `generated_by` int DEFAULT NULL COMMENT 'User ID of the person who generated the payment link',
  `status` enum('success','failed','pending','refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_digits` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processor` enum('tranzila','payplus') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'payplus' COMMENT 'Payment processor used for this transaction',
  `response_data` json DEFAULT NULL COMMENT 'Full response from payment gateway',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `custom_months` int DEFAULT NULL COMMENT 'Custom duration in months for custom plans',
  `payment_processor` enum('payplus') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'payplus' COMMENT 'Payment processor used for this transaction',
  `refund_amount` decimal(10,2) DEFAULT NULL COMMENT 'Amount refunded (last refund if multiple)',
  `refund_type` enum('full','partial') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Refund type',
  `refund_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Reason for refund',
  `refund_date` datetime DEFAULT NULL COMMENT 'Timestamp when refund was processed',
  `lessons_deducted` int DEFAULT '0' COMMENT 'Number of lessons deducted during refund',
  `subscription_action` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Action taken on subscription during refund (continue/cancel_immediate/cancel_renewal)',
  `refund_processed_by` int DEFAULT NULL COMMENT 'ID of admin who processed the refund',
  `refund_processed_by_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of admin who processed the refund',
  `email_notification_sent` tinyint(1) DEFAULT '0' COMMENT 'Whether refund email notification was sent',
  `custom_refund_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Custom reason provided for refund',
  `acknowledged_used_lessons` tinyint(1) DEFAULT '0' COMMENT 'Whether admin acknowledged student used some lessons being refunded',
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `token` (`token`),
  KEY `student_id` (`student_id`),
  KEY `student_email` (`student_email`),
  KEY `status` (`status`),
  KEY `generated_by` (`generated_by`),
  KEY `idx_payment_transactions_refund_status` (`status`,`refund_date`),
  KEY `idx_payment_transactions_processed_by` (`refund_processed_by`),
  KEY `idx_payment_student_created` (`student_id`,`created_at` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=7045 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_channel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `subscription_id` int unsigned NOT NULL,
  `amount` int NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `vendor_order_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payouts`
--

DROP TABLE IF EXISTS `payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payouts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `amount` decimal(13,2) NOT NULL,
  `account_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_bank_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('waiting','done','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `payouts_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `payouts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payplus_webhook_logs`
--

DROP TABLE IF EXISTS `payplus_webhook_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payplus_webhook_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus transaction unique identifier',
  `page_request_uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus page request unique identifier',
  `event_type` enum('payment_success','payment_failure','subscription_created','subscription_cancelled','refund','chargeback') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of webhook event received',
  `status_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus status code (000 = success)',
  `status_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus status description',
  `amount` decimal(10,2) DEFAULT NULL COMMENT 'Transaction amount',
  `currency_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Currency code (ILS, USD, EUR, GBP)',
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Customer name from PayPlus',
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Customer email from PayPlus',
  `customer_phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Customer phone from PayPlus',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Payment method used',
  `four_digits` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Last four digits of card',
  `approval_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus approval number',
  `invoice_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PayPlus invoice number',
  `more_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Additional info field from PayPlus',
  `more_info_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Additional info field 1 from PayPlus',
  `more_info_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Additional info field 2 from PayPlus',
  `more_info_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Additional info field 3 from PayPlus',
  `more_info_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Additional info field 4 from PayPlus',
  `more_info_5` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional info field 5 (encoded data) from PayPlus',
  `is_test` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether this is a test transaction',
  `raw_webhook_data` json NOT NULL COMMENT 'Complete raw webhook payload from PayPlus',
  `processed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether this webhook has been processed',
  `processing_error` text COLLATE utf8mb4_unicode_ci COMMENT 'Error message if processing failed',
  `linked_payment_transaction_id` int DEFAULT NULL COMMENT 'Reference to related payment transaction',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when webhook was received',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when webhook was last updated',
  PRIMARY KEY (`id`),
  KEY `idx_transaction_uid` (`transaction_uid`),
  KEY `idx_page_request_uid` (`page_request_uid`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_processed` (`processed`),
  KEY `idx_created_at` (`created_at`),
  KEY `fk_linked_payment_transaction` (`linked_payment_transaction_id`),
  CONSTRAINT `fk_linked_payment_transaction` FOREIGN KEY (`linked_payment_transaction_id`) REFERENCES `payment_transactions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7236 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores PayPlus webhook notifications for audit and processing';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payslip_exports`
--

DROP TABLE IF EXISTS `payslip_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_exports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `status` enum('processing','completed','failed') NOT NULL DEFAULT 'processing',
  `file_path` varchar(255) DEFAULT NULL,
  `error` text,
  `requested_by` bigint unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payu_transactions`
--

DROP TABLE IF EXISTS `payu_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payu_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `paid_for_id` bigint unsigned DEFAULT NULL,
  `paid_for_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','failed','successful','invalid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `verified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `payu_transactions_transaction_id_unique` (`transaction_id`) USING BTREE,
  KEY `payu_transactions_status_index` (`status`) USING BTREE,
  KEY `payu_transactions_verified_at_index` (`verified_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `penalties`
--

DROP TABLE IF EXISTS `penalties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penalties` (
  `id` int NOT NULL AUTO_INCREMENT,
  `penalty_type` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text,
  `penalty_month` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned DEFAULT NULL,
  `section_id` int unsigned DEFAULT NULL,
  `allow` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `permissions_role_id_index` (`role_id`) USING BTREE,
  KEY `permissions_section_id_index` (`section_id`) USING BTREE,
  CONSTRAINT `permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permissions_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12357 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `points_ledger`
--

DROP TABLE IF EXISTS `points_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `points_ledger` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `points` int NOT NULL,
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_source_lookup` (`source_type`,`source_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_points_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `practice_modes`
--

DROP TABLE IF EXISTS `practice_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_modes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `mode_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `practice_modes_mode_key_unique` (`mode_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `practice_questions`
--

DROP TABLE IF EXISTS `practice_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `question_type` enum('quiz','fill_blank') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_id` bigint unsigned NOT NULL,
  `user_answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int DEFAULT NULL COMMENT 'Seconds taken to answer',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `practice_results`
--

DROP TABLE IF EXISTS `practice_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_results` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `total_words` int NOT NULL DEFAULT '0',
  `remembered` int NOT NULL DEFAULT '0',
  `need_practice` int NOT NULL DEFAULT '0',
  `success_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `time_elapsed` int DEFAULT NULL COMMENT 'Seconds spent on practice',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `practice_sessions`
--

DROP TABLE IF EXISTS `practice_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `practice_mode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_id` bigint unsigned NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `hints_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prerequisites`
--

DROP TABLE IF EXISTS `prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prerequisites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `prerequisite_id` int unsigned NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `order` int unsigned DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `prerequisites_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `prerequisite_id` (`prerequisite_id`),
  CONSTRAINT `prerequisite_id` FOREIGN KEY (`prerequisite_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `prerequisites_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_category_translations`
--

DROP TABLE IF EXISTS `product_category_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_category_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_category_id` (`product_category_id`),
  KEY `product_category_translations_locale_index` (`locale`),
  CONSTRAINT `product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_discounts`
--

DROP TABLE IF EXISTS `product_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_discounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percent` int unsigned NOT NULL,
  `count` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` int unsigned NOT NULL,
  `end_date` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_discounts_creator_id_foreign` (`creator_id`),
  KEY `product_discounts_product_id_foreign` (`product_id`),
  CONSTRAINT `product_discounts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_discounts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_faq_translations`
--

DROP TABLE IF EXISTS `product_faq_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_faq_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_faq_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_faq_id` (`product_faq_id`),
  KEY `product_faq_translations_locale_index` (`locale`),
  CONSTRAINT `product_faq_id` FOREIGN KEY (`product_faq_id`) REFERENCES `product_faqs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_faqs`
--

DROP TABLE IF EXISTS `product_faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_faqs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `order` int unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_faqs_product_id_foreign` (`product_id`),
  KEY `product_faqs_creator_id_foreign` (`creator_id`),
  CONSTRAINT `product_faqs_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_faqs_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_file_translations`
--

DROP TABLE IF EXISTS `product_file_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_file_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_file_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_file_id` (`product_file_id`),
  KEY `product_file_translations_locale_index` (`locale`),
  CONSTRAINT `product_file_id` FOREIGN KEY (`product_file_id`) REFERENCES `product_files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_files`
--

DROP TABLE IF EXISTS `product_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_files` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `online_viewer` tinyint(1) NOT NULL DEFAULT '0',
  `order` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_product_id` (`product_id`),
  KEY `file_creator_id` (`creator_id`),
  CONSTRAINT `file_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `file_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_filter_option_translations`
--

DROP TABLE IF EXISTS `product_filter_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_filter_option_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_filter_option_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_filter_option_id` (`product_filter_option_id`),
  KEY `product_filter_option_translations_locale_index` (`locale`),
  CONSTRAINT `product_filter_option_id` FOREIGN KEY (`product_filter_option_id`) REFERENCES `product_filter_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_filter_options`
--

DROP TABLE IF EXISTS `product_filter_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_filter_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int unsigned NOT NULL,
  `order` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_filter_options_filter_id_foreign` (`filter_id`),
  CONSTRAINT `product_filter_options_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `product_filters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_filter_translations`
--

DROP TABLE IF EXISTS `product_filter_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_filter_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_filter_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_filter_id` (`product_filter_id`),
  KEY `product_filter_translations_locale_index` (`locale`),
  CONSTRAINT `product_filter_id` FOREIGN KEY (`product_filter_id`) REFERENCES `product_filters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_filters`
--

DROP TABLE IF EXISTS `product_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_filters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_filters_category_id_foreign` (`category_id`),
  CONSTRAINT `product_filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_media`
--

DROP TABLE IF EXISTS `product_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `type` enum('thumbnail','image','video') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `media_product_id` (`product_id`),
  KEY `media_creator_id` (`creator_id`),
  CONSTRAINT `media_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `media_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_orders`
--

DROP TABLE IF EXISTS `product_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `seller_id` int unsigned NOT NULL,
  `buyer_id` int unsigned NOT NULL,
  `sale_id` int unsigned DEFAULT NULL,
  `specifications` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `quantity` int unsigned NOT NULL,
  `discount_id` int unsigned DEFAULT NULL,
  `message_to_seller` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tracking_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','waiting_delivery','shipped','success','canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `product_quality` int unsigned NOT NULL,
  `purchase_worth` int unsigned NOT NULL,
  `delivery_quality` int unsigned NOT NULL,
  `seller_quality` int unsigned NOT NULL,
  `rates` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int unsigned NOT NULL,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_creator_id_foreign` (`creator_id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_selected_filter_options`
--

DROP TABLE IF EXISTS `product_selected_filter_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_selected_filter_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `filter_option_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_selected_filter_options_product_id_foreign` (`product_id`),
  KEY `product_selected_filter_options_filter_option_id_foreign` (`filter_option_id`),
  CONSTRAINT `product_selected_filter_options_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `product_filter_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_selected_filter_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_selected_specification_multi_values`
--

DROP TABLE IF EXISTS `product_selected_specification_multi_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_selected_specification_multi_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `selected_specification_id` int unsigned NOT NULL,
  `specification_multi_value_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selected_specification_id` (`selected_specification_id`),
  KEY `specification_multi_value_id` (`specification_multi_value_id`),
  CONSTRAINT `selected_specification_id` FOREIGN KEY (`selected_specification_id`) REFERENCES `product_selected_specifications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `specification_multi_value_id` FOREIGN KEY (`specification_multi_value_id`) REFERENCES `product_specification_multi_values` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_selected_specification_translations`
--

DROP TABLE IF EXISTS `product_selected_specification_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_selected_specification_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_selected_specification_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_selected_specification_id_translations` (`product_selected_specification_id`),
  KEY `product_selected_specification_translations_locale_index` (`locale`),
  CONSTRAINT `product_selected_specification_id_translations` FOREIGN KEY (`product_selected_specification_id`) REFERENCES `product_selected_specifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_selected_specifications`
--

DROP TABLE IF EXISTS `product_selected_specifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_selected_specifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `product_specification_id` int unsigned NOT NULL,
  `type` enum('textarea','multi_value') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_selection` tinyint(1) NOT NULL DEFAULT '0',
  `order` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_selected_specifications_creator_id_foreign` (`creator_id`),
  KEY `product_selected_specifications_product_id_foreign` (`product_id`),
  KEY `product_selected_specifications_product_specification_id_foreign` (`product_specification_id`),
  CONSTRAINT `product_selected_specifications_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_selected_specifications_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_selected_specifications_product_specification_id_foreign` FOREIGN KEY (`product_specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_specification_categories`
--

DROP TABLE IF EXISTS `product_specification_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specification_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `specification_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_specification_categories_specification_id_foreign` (`specification_id`),
  KEY `product_specification_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `product_specification_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_specification_categories_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_specification_multi_value_translations`
--

DROP TABLE IF EXISTS `product_specification_multi_value_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specification_multi_value_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_specification_multi_value_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_specification_multi_value_id` (`product_specification_multi_value_id`),
  KEY `product_specification_multi_value_translations_locale_index` (`locale`),
  CONSTRAINT `product_specification_multi_value_id` FOREIGN KEY (`product_specification_multi_value_id`) REFERENCES `product_specification_multi_values` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_specification_multi_values`
--

DROP TABLE IF EXISTS `product_specification_multi_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specification_multi_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `specification_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_specification_multi_values_specification_id_foreign` (`specification_id`),
  CONSTRAINT `product_specification_multi_values_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_specification_translations`
--

DROP TABLE IF EXISTS `product_specification_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specification_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_specification_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_specification_id` (`product_specification_id`),
  KEY `product_specification_translations_locale_index` (`locale`),
  CONSTRAINT `product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_specifications`
--

DROP TABLE IF EXISTS `product_specifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `input_type` enum('textarea','multi_value') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_translations`
--

DROP TABLE IF EXISTS `product_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_translations_locale_index` (`locale`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `type` enum('virtual','physical') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `price` bigint unsigned DEFAULT NULL,
  `point` bigint unsigned DEFAULT NULL,
  `unlimited_inventory` tinyint(1) NOT NULL DEFAULT '0',
  `ordering` tinyint(1) NOT NULL DEFAULT '0',
  `inventory` int unsigned DEFAULT NULL,
  `inventory_warning` int unsigned DEFAULT NULL,
  `inventory_updated_at` bigint unsigned DEFAULT NULL,
  `delivery_fee` bigint unsigned DEFAULT NULL,
  `delivery_estimated_time` int unsigned DEFAULT NULL,
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tax` int unsigned DEFAULT NULL,
  `commission` int unsigned DEFAULT NULL,
  `status` enum('active','pending','draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` bigint unsigned NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_creator_id_foreign` (`creator_id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_type_index` (`type`),
  KEY `products_slug_index` (`slug`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promotion_translations`
--

DROP TABLE IF EXISTS `promotion_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `promotion_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `promotion_translations_promotion_id_foreign` (`promotion_id`),
  KEY `promotion_translations_locale_index` (`locale`),
  CONSTRAINT `promotion_translations_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `days` int unsigned NOT NULL,
  `price` int unsigned NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pubnub_chat`
--

DROP TABLE IF EXISTS `pubnub_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pubnub_chat` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `channel_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_channel_name` (`channel_name`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_student_teacher` (`student_id`,`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purchases_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `purchases_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_bank`
--

DROP TABLE IF EXISTS `question_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_bank` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('single-choice','multiple-choice','checkbox','yes-no','text') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `question_order` int DEFAULT '0',
  `options` json DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_question_order` (`question_order`,`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_import_errors`
--

DROP TABLE IF EXISTS `question_import_errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_import_errors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `import_id` int NOT NULL,
  `row_num` int NOT NULL,
  `error_message` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_import_id` (`import_id`),
  KEY `idx_row_num` (`row_num`),
  CONSTRAINT `fk_question_import_errors_import` FOREIGN KEY (`import_id`) REFERENCES `question_import_history` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_import_history`
--

DROP TABLE IF EXISTS `question_import_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_import_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_by` varchar(100) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `total_rows` int NOT NULL,
  `successful_imports` int DEFAULT '0',
  `failed_imports` int DEFAULT '0',
  `import_status` enum('processing','completed','failed') DEFAULT 'processing',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_uploaded_by` (`uploaded_by`),
  KEY `idx_status` (`import_status`),
  KEY `idx_created_at` (`created_at` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_reclassification_history`
--

DROP TABLE IF EXISTS `question_reclassification_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_reclassification_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `old_level` varchar(5) NOT NULL,
  `new_level` varchar(5) NOT NULL,
  `reclassified_by` varchar(100) NOT NULL,
  `reason` text,
  `reclassified_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_question_id` (`question_id`),
  KEY `idx_reclassified_at` (`reclassified_at` DESC),
  CONSTRAINT `question_reclassification_history_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `adaptive_assessment_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_validation_metrics`
--

DROP TABLE IF EXISTS `question_validation_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_validation_metrics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `total_attempts` int DEFAULT '0',
  `correct_attempts` int DEFAULT '0',
  `accuracy_rate` decimal(5,2) DEFAULT '0.00',
  `avg_time_seconds` decimal(8,2) DEFAULT '0.00',
  `student_levels_attempted` json DEFAULT NULL,
  `expected_level` varchar(5) NOT NULL,
  `recommended_level` varchar(5) DEFAULT NULL,
  `confidence_score` decimal(5,2) DEFAULT '0.00',
  `needs_review` tinyint(1) DEFAULT '0',
  `last_calculated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_question` (`question_id`),
  KEY `idx_needs_review` (`needs_review`,`total_attempts`),
  KEY `idx_confidence` (`confidence_score`),
  CONSTRAINT `question_validation_metrics_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `adaptive_assessment_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionnaire_responses`
--

DROP TABLE IF EXISTS `questionnaire_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_responses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `learning_goals` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `preferred_style` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `availability` json DEFAULT NULL,
  `current_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_student` (`student_id`),
  CONSTRAINT `fk_ques_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quiz_images`
--

DROP TABLE IF EXISTS `quiz_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quizzes_new_id` int unsigned NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci,
  `quiz_question_and_answer_id` int unsigned NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_answer` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_quizzes_new_id` (`quizzes_new_id`),
  KEY `idx_quiz_question_and_answer_id` (`quiz_question_and_answer_id`),
  KEY `idx_quizzes_questions` (`quizzes_new_id`,`quiz_question_and_answer_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quiz_question_and_answers`
--

DROP TABLE IF EXISTS `quiz_question_and_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_question_and_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quizzes_new_id` int unsigned NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `mcq_options` text COLLATE utf8mb4_unicode_ci,
  `answer` tinyint NOT NULL DEFAULT '0',
  `student_answer` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_quizzes_new_id` (`quizzes_new_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_quiz_answer` (`quizzes_new_id`,`answer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quiz_question_translations`
--

DROP TABLE IF EXISTS `quiz_question_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_question_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quizzes_question_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correct` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `quiz_question_translations_quiz_question_id_foreign` (`quizzes_question_id`),
  KEY `quiz_question_translations_locale_index` (`locale`),
  CONSTRAINT `quiz_question_translations_quiz_question_id_foreign` FOREIGN KEY (`quizzes_question_id`) REFERENCES `quizzes_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quiz_translations`
--

DROP TABLE IF EXISTS `quiz_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_translations_quiz_id_foreign` (`quiz_id`),
  KEY `quiz_translations_locale_index` (`locale`),
  CONSTRAINT `quiz_translations_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned DEFAULT NULL,
  `teacher_id` int unsigned NOT NULL,
  `student_id` int DEFAULT NULL,
  `quiz_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `pass_mark` int NOT NULL,
  `certificate` tinyint(1) NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_mark` int unsigned DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  `chapter_id` int unsigned DEFAULT NULL,
  `webinar_title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` int DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quizzes_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `quizzes_creator_id_foreign` (`teacher_id`) USING BTREE,
  KEY `quizzes_chapter_id_foreign` (`chapter_id`),
  CONSTRAINT `quizzes_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_creator_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quizzes_new`
--

DROP TABLE IF EXISTS `quizzes_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_new` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lesson_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `student_answers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `answer_attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `teacher_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `attachment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `student_quiz_test_image_answer` int NOT NULL DEFAULT '0',
  `quiz_type` int NOT NULL DEFAULT '1',
  `student_mcq_right_answer` int NOT NULL DEFAULT '0',
  `subscription_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_lesson_id` (`lesson_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_lesson_student` (`lesson_id`,`student_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_subscription_id` (`subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quizzes_questions`
--

DROP TABLE IF EXISTS `quizzes_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_questions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` int unsigned NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('multiple','descriptive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `video` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quizzes_questions_quiz_id_foreign` (`quiz_id`) USING BTREE,
  KEY `quizzes_questions_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `quizzes_questions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quizzes_questions_answer_translations`
--

DROP TABLE IF EXISTS `quizzes_questions_answer_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_questions_answer_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quizzes_questions_answer_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `quizzes_questions_answer_id` (`quizzes_questions_answer_id`),
  KEY `quizzes_questions_answer_translations_locale_index` (`locale`),
  CONSTRAINT `quizzes_questions_answer_id` FOREIGN KEY (`quizzes_questions_answer_id`) REFERENCES `quizzes_questions_answers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quizzes_questions_answers`
--

DROP TABLE IF EXISTS `quizzes_questions_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_questions_answers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `question_id` int unsigned NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `correct` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quizzes_questions_answers_question_id_foreign` (`question_id`) USING BTREE,
  KEY `quizzes_questions_answers_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `quizzes_questions_answers_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_questions_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `quizzes_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quizzes_results`
--

DROP TABLE IF EXISTS `quizzes_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_results` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `results` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `user_grade` int DEFAULT NULL,
  `status` enum('passed','failed','waiting') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quizzes_results_quiz_id_foreign` (`quiz_id`) USING BTREE,
  KEY `quizzes_results_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `quizzes_results_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `rate` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rating_user_id_foreign` (`user_id`) USING BTREE,
  KEY `rating_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `rating_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `rating_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rating_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rating_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_payments`
--

DROP TABLE IF EXISTS `recurring_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `student_id` int unsigned NOT NULL COMMENT 'Student making the payment',
  `managed_by_id` int unsigned DEFAULT NULL COMMENT 'User (sales/admin/teacher) managing this student',
  `managed_by_role` enum('sales','admin','teacher') NOT NULL COMMENT 'Role managing the student',
  `subscription_id` int unsigned DEFAULT NULL COMMENT 'Linked subscription ID if applicable',
  `payplus_transaction_uid` varchar(255) DEFAULT NULL COMMENT 'PayPlus transaction unique identifier',
  `payplus_page_request_uid` varchar(255) DEFAULT NULL COMMENT 'PayPlus page request unique identifier',
  `amount` decimal(10,2) NOT NULL COMMENT 'Payment amount',
  `currency` varchar(10) NOT NULL DEFAULT 'ILS' COMMENT 'Currency code (ILS, USD, EUR, GBP)',
  `payment_date` date NOT NULL COMMENT 'Recurring deduction date',
  `status` enum('pending','paid','failed','cancelled','refunded') NOT NULL DEFAULT 'pending' COMMENT 'Recurring payment status',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Gateway transaction ID',
  `next_payment_date` date DEFAULT NULL COMMENT 'Next recurring billing date',
  `recurring_frequency` enum('daily','weekly','monthly','quarterly','yearly') DEFAULT 'monthly' COMMENT 'How often the payment recurs',
  `recurring_count` int DEFAULT '0' COMMENT 'Number of successful recurring payments made',
  `max_recurring_count` int DEFAULT NULL COMMENT 'Maximum number of recurring payments (null = unlimited)',
  `booked_monthly_classes` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = Not booked, 1 = Booked',
  `payment_method` varchar(50) DEFAULT NULL COMMENT 'Payment method used',
  `card_last_digits` varchar(10) DEFAULT NULL COMMENT 'Last 4 digits of card used',
  `failure_reason` text COMMENT 'Reason for payment failure',
  `failure_count` int DEFAULT '0' COMMENT 'Number of consecutive failures',
  `webhook_data` json DEFAULT NULL COMMENT 'PayPlus webhook data related to this payment',
  `pricing_info` json DEFAULT NULL,
  `remarks` text COMMENT 'Error message or notes',
  `is_active` tinyint(1) DEFAULT '1' COMMENT 'Whether this recurring payment is active',
  `cancelled_at` datetime DEFAULT NULL COMMENT 'When the recurring payment was cancelled',
  `cancelled_by` int unsigned DEFAULT NULL COMMENT 'User who cancelled the recurring payment',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Record creation timestamp',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record update timestamp',
  PRIMARY KEY (`id`),
  KEY `fk_student_id` (`student_id`),
  KEY `fk_managed_by_id` (`managed_by_id`),
  KEY `idx_payplus_transaction_uid` (`payplus_transaction_uid`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_cancelled_by` (`cancelled_by`),
  KEY `idx_recurring_next_date` (`next_payment_date`,`status`),
  CONSTRAINT `fk_managed_by_id` FOREIGN KEY (`managed_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_recurring_payments_cancelled_by` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_student_id` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2989 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_config`
--

DROP TABLE IF EXISTS `referral_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL,
  `config_value` json NOT NULL,
  `description` text,
  `updated_at` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_fraud_logs`
--

DROP TABLE IF EXISTS `referral_fraud_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_fraud_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `referee_id` int unsigned NOT NULL,
  `referrer_id` int unsigned NOT NULL,
  `fraud_type` enum('duplicate_email','duplicate_phone','duplicate_card','suspicious_pattern') NOT NULL,
  `fraud_score` int DEFAULT '0',
  `details` json DEFAULT NULL,
  `is_blocked` tinyint(1) DEFAULT '0',
  `reviewed_by` int unsigned DEFAULT NULL,
  `reviewed_at` bigint DEFAULT NULL,
  `created_at` bigint NOT NULL,
  `referral_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_referee_id` (`referee_id`),
  KEY `idx_fraud_type` (`fraud_type`),
  KEY `referrer_id` (`referrer_id`),
  KEY `reviewed_by` (`reviewed_by`),
  CONSTRAINT `referral_fraud_logs_ibfk_1` FOREIGN KEY (`referee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_fraud_logs_ibfk_2` FOREIGN KEY (`referrer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_fraud_logs_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_links`
--

DROP TABLE IF EXISTS `referral_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_links` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `invite_code` varchar(50) NOT NULL,
  `invite_url` varchar(500) NOT NULL,
  `created_at` bigint NOT NULL,
  `last_refreshed_at` bigint DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `refresh_count` int unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `invite_code` (`invite_code`),
  UNIQUE KEY `invite_url` (`invite_url`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_invite_code` (`invite_code`),
  CONSTRAINT `referral_links_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_notifications`
--

DROP TABLE IF EXISTS `referral_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `referral_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `notification_type` enum('whatsapp','in_app','popup') NOT NULL,
  `notification_event` enum('friend_joined','reward_received','tier_upgraded') NOT NULL,
  `status` enum('pending','sent','failed') DEFAULT 'pending',
  `sent_at` bigint DEFAULT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_referral_id` (`referral_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `referral_notifications_ibfk_1` FOREIGN KEY (`referral_id`) REFERENCES `referrals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_retention_tracking`
--

DROP TABLE IF EXISTS `referral_retention_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_retention_tracking` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `referee_id` int unsigned NOT NULL,
  `referrer_id` int unsigned NOT NULL,
  `subscription_start_date` bigint NOT NULL,
  `subscription_end_date` bigint DEFAULT NULL,
  `total_months_active` int DEFAULT '0',
  `total_revenue_generated` decimal(10,2) DEFAULT '0.00',
  `is_currently_active` tinyint(1) DEFAULT '1',
  `churn_date` bigint DEFAULT NULL,
  `updated_at` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_referee_id` (`referee_id`),
  KEY `idx_referrer_id` (`referrer_id`),
  CONSTRAINT `referral_retention_tracking_ibfk_1` FOREIGN KEY (`referee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_retention_tracking_ibfk_2` FOREIGN KEY (`referrer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_rewards`
--

DROP TABLE IF EXISTS `referral_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_rewards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `referral_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `user_type` enum('referrer','referee') NOT NULL,
  `reward_type` enum('free_lessons','free_months','discount','cash') NOT NULL,
  `reward_value` int NOT NULL,
  `tier_level` int NOT NULL,
  `status` enum('pending','granted','expired') DEFAULT 'pending',
  `granted_at` bigint DEFAULT NULL,
  `expires_at` bigint DEFAULT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_referral_id` (`referral_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `referral_rewards_ibfk_1` FOREIGN KEY (`referral_id`) REFERENCES `referrals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_rewards_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_tier_claims`
--

DROP TABLE IF EXISTS `referral_tier_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_tier_claims` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `tier_level` int NOT NULL,
  `tier_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_type` enum('free_lessons','free_months','discount','cash','cash_and_subscription') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_value` json NOT NULL COMMENT 'Stores reward details like {"count": 1} or {"amount": 200, "duration": "3_months"}',
  `claim_receipt_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `claimed_at` bigint NOT NULL,
  `created_at` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `claim_receipt_id` (`claim_receipt_id`),
  UNIQUE KEY `user_tier_unique` (`user_id`,`tier_level`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_claimed_at` (`claimed_at`),
  KEY `idx_receipt_id` (`claim_receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral_tiers`
--

DROP TABLE IF EXISTS `referral_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_tiers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(100) NOT NULL,
  `tier_level` int NOT NULL,
  `min_referrals` int NOT NULL,
  `max_referrals` int NOT NULL,
  `referee_reward_type` enum('free_lessons','free_months','discount','cash') NOT NULL,
  `referee_reward_value` int NOT NULL,
  `referrer_reward_type` enum('free_lessons','free_months','discount','cash') NOT NULL,
  `referrer_reward_value` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` bigint NOT NULL,
  `updated_at` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tier_level` (`tier_level`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referrals`
--

DROP TABLE IF EXISTS `referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referrals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `referrer_id` int unsigned NOT NULL,
  `referee_id` int unsigned NOT NULL,
  `invite_code` varchar(50) NOT NULL,
  `status` enum('pending','validated','rewarded','fraud') DEFAULT 'pending',
  `tier_at_signup` int DEFAULT NULL,
  `subscription_value` decimal(10,2) DEFAULT '0.00',
  `first_payment_at` bigint DEFAULT NULL,
  `is_paying_user` tinyint(1) DEFAULT '0',
  `fraud_flags` json DEFAULT NULL,
  `created_at` bigint NOT NULL,
  `updated_at` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_referrer_id` (`referrer_id`),
  KEY `idx_referee_id` (`referee_id`),
  KEY `idx_status` (`status`),
  KEY `invite_code` (`invite_code`),
  CONSTRAINT `referrals_ibfk_1` FOREIGN KEY (`referrer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referrals_ibfk_2` FOREIGN KEY (`referee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referrals_ibfk_3` FOREIGN KEY (`invite_code`) REFERENCES `referral_links` (`invite_code`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int unsigned DEFAULT NULL,
  `province_id` int unsigned DEFAULT NULL,
  `city_id` int unsigned DEFAULT NULL,
  `geo_center` point DEFAULT NULL,
  `type` enum('country','province','city','district') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `regions_country_id_foreign` (`country_id`),
  KEY `regions_province_id_foreign` (`province_id`),
  KEY `regions_city_id_foreign` (`city_id`),
  CONSTRAINT `regions_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `regions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `regions_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registration_packages`
--

DROP TABLE IF EXISTS `registration_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_packages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `days` int unsigned NOT NULL,
  `price` int unsigned NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('instructors','organizations') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `instructors_count` int DEFAULT NULL,
  `students_count` int DEFAULT NULL,
  `courses_capacity` int DEFAULT NULL,
  `courses_count` int DEFAULT NULL,
  `meeting_count` int DEFAULT NULL,
  `product_count` int unsigned DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `registration_packages_role_index` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registration_packages_translations`
--

DROP TABLE IF EXISTS `registration_packages_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_packages_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `registration_package_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `registration_package` (`registration_package_id`),
  KEY `registration_packages_translations_locale_index` (`locale`),
  CONSTRAINT `registration_package` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regular_class`
--

DROP TABLE IF EXISTS `regular_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regular_class` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `teacher_id` int unsigned NOT NULL,
  `day` text COLLATE utf8mb4_unicode_ci,
  `start_time` text COLLATE utf8mb4_unicode_ci,
  `end_time` text COLLATE utf8mb4_unicode_ci,
  `student_lesson_reset_at` timestamp NULL DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_day_time` (`day`(10),`start_time`(10),`end_time`(10)),
  KEY `idx_batch_id` (`batch_id`),
  KEY `idx_lesson_reset_at` (`student_lesson_reset_at`),
  KEY `idx_timezone` (`timezone`(10)),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=13961 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminder`
--

DROP TABLE IF EXISTS `reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `lesson_id` int NOT NULL,
  `reminder_time` datetime DEFAULT NULL,
  `reminder_type` text,
  `is_reminded` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=271552 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reserve_meetings`
--

DROP TABLE IF EXISTS `reserve_meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserve_meetings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int DEFAULT NULL,
  `sale_id` int unsigned DEFAULT NULL,
  `meeting_time_id` int unsigned NOT NULL,
  `day` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` int unsigned NOT NULL,
  `start_at` bigint unsigned NOT NULL,
  `end_at` bigint unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `paid_amount` decimal(13,2) NOT NULL,
  `meeting_type` enum('in_person','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'online',
  `student_count` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','open','finished','canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `locked_at` int DEFAULT NULL,
  `reserved_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `reserve_meetings_meeting_time_id_foreign` (`meeting_time_id`) USING BTREE,
  KEY `reserve_meetings_user_id_foreign` (`user_id`) USING BTREE,
  KEY `reserve_meetings_sale_id_foreign` (`sale_id`),
  CONSTRAINT `reserve_meetings_meeting_time_id_foreign` FOREIGN KEY (`meeting_time_id`) REFERENCES `meeting_times` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reserve_meetings_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reserve_meetings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewards`
--

DROP TABLE IF EXISTS `rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('account_charge','create_classes','buy','pass_the_quiz','certificate','comment','register','review_courses','instructor_meeting_reserve','student_meeting_reserve','newsletters','badge','referral','learning_progress_100','charge_wallet','buy_store_product','pass_assignment','send_post_in_topic','make_topic','create_blog_by_instructor','comment_for_instructor_blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int unsigned DEFAULT NULL,
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewards_accounting`
--

DROP TABLE IF EXISTS `rewards_accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards_accounting` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `item_id` int unsigned DEFAULT NULL,
  `type` enum('account_charge','create_classes','buy','pass_the_quiz','certificate','comment','register','review_courses','instructor_meeting_reserve','student_meeting_reserve','newsletters','badge','referral','learning_progress_100','charge_wallet','withdraw','buy_store_product','pass_assignment','send_post_in_topic','make_topic','create_blog_by_instructor','comment_for_instructor_blog') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int unsigned NOT NULL,
  `status` enum('addiction','deduction') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rewards_accounting_user_id_foreign` (`user_id`),
  CONSTRAINT `rewards_accounting_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_audit_logs`
--

DROP TABLE IF EXISTS `risk_audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_audit_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `risk_id` int unsigned DEFAULT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_by` int unsigned DEFAULT NULL,
  `previous_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_risk_id` (`risk_id`),
  CONSTRAINT `fk_risk_audit_logs_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `risk_table` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_rules`
--

DROP TABLE IF EXISTS `risk_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_rules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `event_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_points` int NOT NULL,
  `default_valid_days` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `impact_level` enum('low','medium','high','critical') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  `conditions` longtext COLLATE utf8mb4_unicode_ci,
  `is_auto` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_rules_audit`
--

DROP TABLE IF EXISTS `risk_rules_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_rules_audit` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `risk_rule_id` int unsigned NOT NULL,
  `action` enum('CREATE','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_by` int unsigned DEFAULT NULL,
  `previous_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_risk_rule_id` (`risk_rule_id`),
  CONSTRAINT `fk_risk_rules_audit_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `risk_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_table`
--

DROP TABLE IF EXISTS `risk_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_table` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `teacher_id` int unsigned DEFAULT NULL,
  `rep_id` int unsigned DEFAULT NULL,
  `risk_level` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  `risk_score` int NOT NULL DEFAULT '0',
  `recurring_risk` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_status` enum('not_contacted','whatsapp','called','no_answer','follow_up','resolved') COLLATE utf8mb4_unicode_ci DEFAULT 'not_contacted',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'unknown',
  `total_paid` decimal(10,2) DEFAULT '0.00',
  `recurring_lessons` tinyint(1) DEFAULT '0',
  `subscription_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `learning_duration` int DEFAULT NULL,
  `risk_events` json NOT NULL DEFAULT (json_array()),
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `family_linked` tinyint(1) NOT NULL DEFAULT '0',
  `next_class_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student` (`student_id`),
  UNIQUE KEY `unique_student_risk` (`student_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_risk_level` (`risk_level`),
  KEY `idx_is_active_risk` (`risk_score`)
) ENGINE=InnoDB AUTO_INCREMENT=3993 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_thresholds`
--

DROP TABLE IF EXISTS `risk_thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_thresholds` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `critical` float NOT NULL DEFAULT '100',
  `high` float NOT NULL DEFAULT '70',
  `medium` float NOT NULL DEFAULT '40',
  `low` float NOT NULL DEFAULT '20',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `caption` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `users_count` int unsigned NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `seller_id` int unsigned DEFAULT NULL,
  `buyer_id` int unsigned NOT NULL,
  `order_id` int unsigned DEFAULT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `meeting_id` int unsigned DEFAULT NULL,
  `subscribe_id` int unsigned DEFAULT NULL,
  `ticket_id` int unsigned DEFAULT NULL,
  `promotion_id` int unsigned DEFAULT NULL,
  `product_order_id` int unsigned DEFAULT NULL,
  `registration_package_id` int unsigned DEFAULT NULL,
  `type` enum('webinar','meeting','subscribe','promotion','registration_package','product','bundle') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` enum('credit','payment_channel','subscribe') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int unsigned NOT NULL,
  `tax` decimal(13,2) DEFAULT NULL,
  `commission` decimal(13,2) DEFAULT NULL,
  `discount` decimal(13,2) DEFAULT NULL,
  `total_amount` decimal(13,2) DEFAULT NULL,
  `product_delivery_fee` decimal(13,2) DEFAULT NULL,
  `manual_added` tinyint(1) NOT NULL DEFAULT '0',
  `access_to_purchased_item` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` int unsigned NOT NULL,
  `refund_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sales_order_id_foreign` (`order_id`) USING BTREE,
  KEY `sales_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `sales_meeting_id_foreign` (`meeting_id`) USING BTREE,
  KEY `sales_ticket_id_foreign` (`ticket_id`) USING BTREE,
  KEY `sales_buyer_id_foreign` (`buyer_id`) USING BTREE,
  KEY `sales_seller_id_foreign` (`seller_id`) USING BTREE,
  KEY `sales_promotion_id_foreign` (`promotion_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_agent_reviews`
--

DROP TABLE IF EXISTS `sales_agent_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_agent_reviews` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary key for the review',
  `sales_agent_id` int unsigned NOT NULL COMMENT 'ID of the sales agent being reviewed',
  `reviewer_id` int unsigned NOT NULL COMMENT 'ID of the user submitting the review',
  `reviewer_role` enum('teacher','student','admin','sales_appointment_setter','master_admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Role of the person submitting the review',
  `trial_class_id` bigint DEFAULT NULL COMMENT 'ID of the trial class this review is associated with (if applicable)',
  `communication_rating` int NOT NULL COMMENT 'Rating for communication skills (1-5 stars)',
  `behavior_rating` int NOT NULL COMMENT 'Rating for professional behavior (1-5 stars)',
  `support_quality_rating` int NOT NULL COMMENT 'Rating for quality of support provided (1-5 stars)',
  `responsiveness_rating` int NOT NULL COMMENT 'Rating for response time and availability (1-5 stars)',
  `knowledge_rating` int NOT NULL COMMENT 'Rating for product and course knowledge (1-5 stars)',
  `review_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Additional text comments provided with the review',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the review was created',
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when the review was last updated',
  `overall_rating` decimal(3,1) GENERATED ALWAYS AS ((((((`communication_rating` + `behavior_rating`) + `support_quality_rating`) + `responsiveness_rating`) + `knowledge_rating`) / 5.0)) STORED COMMENT 'Automatically calculated average of all rating criteria',
  PRIMARY KEY (`id`),
  KEY `idx_sales_agent_id` (`sales_agent_id`),
  KEY `idx_reviewer_id` (`reviewer_id`),
  KEY `idx_trial_class_id` (`trial_class_id`),
  CONSTRAINT `fk_sales_agent_reviews_reviewer` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_sales_agent_reviews_sales_agent` FOREIGN KEY (`sales_agent_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_sales_agent_reviews_trial_class` FOREIGN KEY (`trial_class_id`) REFERENCES `trial_class_registrations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores detailed reviews and ratings for sales agents across multiple criteria';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_log`
--

DROP TABLE IF EXISTS `sales_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` int unsigned NOT NULL,
  `viewed_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sales_status_sale_id_foreign` (`sale_id`),
  CONSTRAINT `sales_status_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesperson`
--

DROP TABLE IF EXISTS `salesperson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesperson` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `role_type` enum('sales_role','sales_appointment_setter') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_type` enum('trial_class','regular_class','subscription','payment_link','student_registration') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` int unsigned DEFAULT NULL,
  `class_id` int unsigned DEFAULT NULL,
  `subscription_id` int unsigned DEFAULT NULL,
  `subscription_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_value` decimal(10,2) DEFAULT NULL,
  `trial_converted` tinyint(1) DEFAULT '0',
  `conversion_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_time` datetime DEFAULT NULL,
  `appointment_duration` int unsigned DEFAULT NULL,
  `success_status` enum('successful','cancelled','no_show') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profitability_status` enum('profitable','not_profitable') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revenue_generated` decimal(10,2) DEFAULT '0.00',
  `commission_amount` decimal(10,2) DEFAULT NULL,
  `commission_percentage` decimal(5,2) DEFAULT NULL,
  `cost_incurred` decimal(10,2) DEFAULT '0.00',
  `meeting_type` enum('online','in_person') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `calls_made` int unsigned DEFAULT '0',
  `call_duration` int unsigned DEFAULT '0',
  `efficiency_score` int unsigned DEFAULT NULL,
  `peak_hour_status` tinyint(1) DEFAULT '0',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_sales_class_id` (`class_id`),
  CONSTRAINT `fk_sales_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16063 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saved_views`
--

DROP TABLE IF EXISTS `saved_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` json NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_saved_views_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_group_id` int unsigned DEFAULT NULL,
  `caption` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2036 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session_reminds`
--

DROP TABLE IF EXISTS `session_reminds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_reminds` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_reminds_session_id_foreign` (`session_id`),
  KEY `session_reminds_user_id_foreign` (`user_id`),
  CONSTRAINT `session_reminds_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `session_reminds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session_translations`
--

DROP TABLE IF EXISTS `session_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `session_translations_session_id_foreign` (`session_id`),
  KEY `session_translations_locale_index` (`locale`),
  CONSTRAINT `session_translations_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `chapter_id` int unsigned DEFAULT NULL,
  `date` int NOT NULL,
  `duration` int NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_time_to_join` int unsigned DEFAULT NULL COMMENT 'Specifies that the user can see the join button up to a few minutes after the start time of the webinar.',
  `zoom_start_link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `zoom_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session_api` enum('local','big_blue_button','zoom','agora') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `api_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moderator_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agora_settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT '0',
  `access_after_day` int unsigned DEFAULT NULL,
  `order` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sessions_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `sessions_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `sessions_chapter_id_foreign` (`chapter_id`),
  CONSTRAINT `sessions_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sessions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sessions_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setting_translations`
--

DROP TABLE IF EXISTS `setting_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `setting_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `setting_translations_setting_id_foreign` (`setting_id`),
  KEY `setting_translations_locale_index` (`locale`),
  CONSTRAINT `setting_translations_setting_id_foreign` FOREIGN KEY (`setting_id`) REFERENCES `settings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `page` enum('general','financial','personalization','notifications','seo','customization','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_verifications`
--

DROP TABLE IF EXISTS `sms_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_verifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `sms_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sms_verifications_user_id_uindex` (`user_id`),
  CONSTRAINT `sms_verifications_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `special_offers`
--

DROP TABLE IF EXISTS `special_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `special_offers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percent` int unsigned NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  `from_date` int unsigned NOT NULL,
  `to_date` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `special_offers_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `special_offers_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `special_offers_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `special_offers_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `special_offers_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `special_offers_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_assessment_responses`
--

DROP TABLE IF EXISTS `student_assessment_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_assessment_responses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `question_id` int NOT NULL,
  `question_sequence` int DEFAULT NULL,
  `student_answer` text,
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken_seconds` int DEFAULT NULL,
  `difficulty_at_question` varchar(5) DEFAULT NULL,
  `answered_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  KEY `idx_session` (`session_id`),
  CONSTRAINT `student_assessment_responses_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `student_assessment_sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_assessment_responses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `adaptive_assessment_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_assessment_sessions`
--

DROP TABLE IF EXISTS `student_assessment_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_assessment_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `session_type` enum('initial','periodic_retest') DEFAULT 'initial',
  `started_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `final_detected_level` varchar(5) DEFAULT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `questions_answered` int DEFAULT '0',
  `correct_answers` int DEFAULT '0',
  `total_time_seconds` int DEFAULT '0',
  `self_reported_level` varchar(5) DEFAULT NULL,
  `level_difference` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_session_type` (`session_type`),
  CONSTRAINT `student_assessment_sessions_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_class_queries`
--

DROP TABLE IF EXISTS `student_class_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_class_queries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `student_id` int NOT NULL,
  `query_text` text,
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `query_link` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_events`
--

DROP TABLE IF EXISTS `student_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_events` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `event_type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `points` int NOT NULL,
  `valid_until` int NOT NULL,
  `reported_by` varchar(255) NOT NULL,
  `event_source` varchar(255) NOT NULL DEFAULT 'auto',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_events_user` (`user_id`),
  CONSTRAINT `fk_student_events_user` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_labels`
--

DROP TABLE IF EXISTS `student_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_labels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `label_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valid_until` datetime NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_label_key` (`label_key`),
  CONSTRAINT `fk_student_labels_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_progress`
--

DROP TABLE IF EXISTS `student_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_progress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `current_level` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_points` int NOT NULL DEFAULT '0',
  `total_classes` int NOT NULL DEFAULT '0',
  `vocabulary_mastered` int NOT NULL DEFAULT '0',
  `grammar_concepts_learned` int NOT NULL DEFAULT '0',
  `games_played` int NOT NULL DEFAULT '0',
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`),
  KEY `idx_points_level` (`total_points`,`current_level`),
  CONSTRAINT `fk_prog_users` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_risk_history`
--

DROP TABLE IF EXISTS `student_risk_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_risk_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `risk_level` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_points` int NOT NULL,
  `snapshot_json` json NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_risk_level` (`risk_level`),
  CONSTRAINT `fk_student_risk_history_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscribe_reminds`
--

DROP TABLE IF EXISTS `subscribe_reminds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribe_reminds` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `subscribe_id` int unsigned NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subscribe_reminds_subscribe_id_foreign` (`subscribe_id`),
  KEY `subscribe_reminds_user_id_foreign` (`user_id`),
  CONSTRAINT `subscribe_reminds_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribe_reminds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscribe_translations`
--

DROP TABLE IF EXISTS `subscribe_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribe_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subscribe_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscribe_translations_subscribe_id_foreign` (`subscribe_id`),
  KEY `subscribe_translations_locale_index` (`locale`),
  CONSTRAINT `subscribe_translations_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscribe_uses`
--

DROP TABLE IF EXISTS `subscribe_uses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribe_uses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `subscribe_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `sale_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `subscribe_uses_user_id_foreign` (`user_id`) USING BTREE,
  KEY `subscribe_uses_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `subscribe_uses_subscribe_id_foreign` (`subscribe_id`) USING BTREE,
  KEY `subscribe_uses_sale_id_foreign` (`sale_id`) USING BTREE,
  KEY `subscribe_uses_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `subscribe_uses_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribe_uses_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribe_uses_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribe_uses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribe_uses_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscribes`
--

DROP TABLE IF EXISTS `subscribes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `usable_count` int unsigned NOT NULL,
  `days` int unsigned NOT NULL,
  `price` int unsigned NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT '0',
  `infinite_use` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_charge_skips`
--

DROP TABLE IF EXISTS `subscription_charge_skips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_charge_skips` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `subscription_id` int DEFAULT NULL,
  `skip_months` int NOT NULL,
  `skip_start_date` date NOT NULL,
  `skip_end_date` date NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by_user_id` int unsigned NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `skip_type` enum('months','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'months',
  `custom_start_date` date DEFAULT NULL,
  `custom_end_date` date DEFAULT NULL,
  `reason_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Category of skip reason (financial_issue, complete_existing_lessons, customer_request, technical_issue, other)',
  `lesson_policy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'no_new_lessons' COMMENT 'Lesson policy during skip period (no_new_lessons, continue_lessons)',
  `lesson_amount_during_skip` int DEFAULT NULL COMMENT 'Number of lessons per month during skip if continuing lessons',
  `admin_notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional admin notes for the charge skip',
  `notify_student` tinyint(1) DEFAULT '0' COMMENT 'Whether to notify student about the charge skip',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_skip_dates` (`skip_start_date`,`skip_end_date`),
  KEY `idx_is_active` (`is_active`),
  CONSTRAINT `subscription_charge_skips_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_custom_dates_logic` CHECK ((((`skip_type` = _utf8mb4'months') and (`custom_start_date` is null) and (`custom_end_date` is null)) or ((`skip_type` = _utf8mb4'custom') and (`custom_start_date` is not null) and (`custom_end_date` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_durations`
--

DROP TABLE IF EXISTS `subscription_durations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_durations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `months` int NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_plans`
--

DROP TABLE IF EXISTS `subscription_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `duration_id` int NOT NULL,
  `lesson_length_id` int NOT NULL,
  `lessons_per_month_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `duration_id` (`duration_id`),
  KEY `lesson_length_id` (`lesson_length_id`),
  KEY `lessons_per_month_id` (`lessons_per_month_id`),
  CONSTRAINT `subscription_plans_ibfk_1` FOREIGN KEY (`duration_id`) REFERENCES `subscription_durations` (`id`),
  CONSTRAINT `subscription_plans_ibfk_2` FOREIGN KEY (`lesson_length_id`) REFERENCES `lesson_lengths` (`id`),
  CONSTRAINT `subscription_plans_ibfk_3` FOREIGN KEY (`lessons_per_month_id`) REFERENCES `lessons_per_month` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_conversations`
--

DROP TABLE IF EXISTS `support_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_conversations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `support_id` int unsigned NOT NULL,
  `supporter_id` int unsigned DEFAULT NULL,
  `sender_id` int unsigned DEFAULT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `support_conversations_support_id_foreign` (`support_id`) USING BTREE,
  KEY `support_conversations_sender_id_foreign` (`sender_id`) USING BTREE,
  KEY `support_conversations_supporter_id_foreign` (`supporter_id`) USING BTREE,
  CONSTRAINT `support_conversations_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `support_conversations_support_id_foreign` FOREIGN KEY (`support_id`) REFERENCES `supports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_department_translations`
--

DROP TABLE IF EXISTS `support_department_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_department_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `support_department_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `support_department_id` (`support_department_id`),
  KEY `support_department_translations_locale_index` (`locale`),
  CONSTRAINT `support_department_id` FOREIGN KEY (`support_department_id`) REFERENCES `support_departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_departments`
--

DROP TABLE IF EXISTS `support_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_departments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_permissions`
--

DROP TABLE IF EXISTS `support_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` enum('create','read','update','delete') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` bigint NOT NULL DEFAULT (unix_timestamp()),
  `updated_at` bigint NOT NULL DEFAULT (unix_timestamp()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `support_permissions_resource_action_unique` (`resource`,`action`),
  KEY `support_permissions_resource_index` (`resource`),
  KEY `support_permissions_action_index` (`action`),
  KEY `support_permissions_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_user_permissions`
--

DROP TABLE IF EXISTS `support_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_user_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `permission_id` int unsigned DEFAULT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` enum('create','read','update','delete') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `granted` tinyint(1) NOT NULL DEFAULT '1',
  `granted_by` int unsigned DEFAULT NULL COMMENT 'ID of the admin who granted this permission',
  `granted_at` bigint DEFAULT NULL COMMENT 'Timestamp when permission was granted',
  `expires_at` bigint DEFAULT NULL COMMENT 'Optional expiration timestamp for temporary permissions',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Optional notes about why this permission was granted/denied',
  `created_at` bigint NOT NULL DEFAULT (unix_timestamp()),
  `updated_at` bigint NOT NULL DEFAULT (unix_timestamp()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `support_user_permissions_user_resource_action_unique` (`user_id`,`resource`,`action`),
  KEY `support_user_permissions_user_id_index` (`user_id`),
  KEY `support_user_permissions_permission_id_index` (`permission_id`),
  KEY `support_user_permissions_granted_by_index` (`granted_by`),
  KEY `support_user_permissions_expires_at_index` (`expires_at`),
  KEY `support_user_permissions_granted_index` (`granted`),
  CONSTRAINT `support_user_permissions_granted_by_foreign` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `support_user_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `support_permissions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `support_user_permissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supports`
--

DROP TABLE IF EXISTS `supports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `department_id` int unsigned DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','close','replied','supporter_replied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `created_at` int unsigned DEFAULT NULL,
  `updated_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `supports_user_id_foreign` (`user_id`) USING BTREE,
  KEY `supports_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `supports_department_id_foreign` (`department_id`) USING BTREE,
  CONSTRAINT `supports_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `support_departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supports_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tags_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `tags_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `tags_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_advanced_cash_requests`
--

DROP TABLE IF EXISTS `teacher_advanced_cash_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_advanced_cash_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` int unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `req_note` text COMMENT 'Note added by teacher while requesting advance',
  `res_note` text COMMENT 'Note added by admin while responding',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_teacher_advanced_cash_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_availability`
--

DROP TABLE IF EXISTS `teacher_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_availability` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `mon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `tue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `wed` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `thu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `sat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `sun` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`),
  KEY `idx_availability_mon` (`user_id`,`mon`(191)),
  KEY `idx_availability_tue` (`user_id`,`tue`(191)),
  KEY `idx_availability_wed` (`user_id`,`wed`(191)),
  KEY `idx_availability_thu` (`user_id`,`thu`(191)),
  KEY `idx_availability_fri` (`user_id`,`fri`(191)),
  KEY `idx_availability_sat` (`user_id`,`sat`(191)),
  KEY `idx_availability_sun` (`user_id`,`sun`(191))
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_availability_change_requests`
--

DROP TABLE IF EXISTS `teacher_availability_change_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_availability_change_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `admin_approval` enum('pending','accepted','rejected') COLLATE utf8mb4_bin NOT NULL DEFAULT 'pending',
  `added` json DEFAULT (json_array()),
  `dropped` json DEFAULT (json_array()),
  `changes_summary` json DEFAULT (json_object()),
  `teacher_note` text COLLATE utf8mb4_bin,
  `admin_feedback_note` text COLLATE utf8mb4_bin,
  `effective_from` datetime NOT NULL,
  `has_conflicts` tinyint(1) NOT NULL DEFAULT '0',
  `conflict_details` json DEFAULT (json_array()),
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_earning_history`
--

DROP TABLE IF EXISTS `teacher_earning_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_earning_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` bigint unsigned NOT NULL,
  `earning_date` date NOT NULL,
  `classes` json DEFAULT NULL COMMENT 'Stores class references for the day (regular & trial class IDs)',
  `base_rate` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bonus_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `penalty_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_teacher_day` (`teacher_id`,`earning_date`),
  KEY `idx_teacher_date` (`teacher_id`,`earning_date`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_holiday`
--

DROP TABLE IF EXISTS `teacher_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_holiday` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reason` text,
  `form_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `approver_id` int unsigned DEFAULT NULL COMMENT 'ID of the user who can accept or reject the request',
  `response` text COMMENT 'Admin response or feedback for the holiday request',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_holiday_dates` (`form_date`,`to_date`),
  KEY `idx_user_holiday_range` (`user_id`,`form_date`,`to_date`),
  KEY `user_id` (`user_id`),
  KEY `approver_id` (`approver_id`),
  CONSTRAINT `fk_teacher_holiday_approver` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_teacher_holiday_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2240 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_payslips`
--

DROP TABLE IF EXISTS `teacher_payslips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_payslips` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` bigint unsigned NOT NULL,
  `salary_profile_id` bigint unsigned NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `status` enum('draft','final','cancelled') NOT NULL DEFAULT 'draft',
  `base_salary` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bonus_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `penalty_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `classes` json DEFAULT NULL,
  `bonuses` json DEFAULT NULL,
  `penalties` json DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `finalized_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_recommendations`
--

DROP TABLE IF EXISTS `teacher_recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_recommendations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int NOT NULL,
  `teacher_id` int unsigned NOT NULL,
  `match_score` decimal(5,2) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  `reasoning` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_questionnaire` (`questionnaire_id`),
  KEY `idx_teacher` (`teacher_id`),
  CONSTRAINT `fk_rec_ques` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire_responses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rec_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_report`
--

DROP TABLE IF EXISTS `teacher_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_report` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_salary_adjustments`
--

DROP TABLE IF EXISTS `teacher_salary_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_salary_adjustments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` int unsigned NOT NULL,
  `type` enum('bonus','penalty') NOT NULL,
  `applied_date` date NOT NULL,
  `value` json NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_adjustment_teacher` (`teacher_id`),
  CONSTRAINT `fk_adjustment_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_salary_profiles`
--

DROP TABLE IF EXISTS `teacher_salary_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_salary_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` int unsigned NOT NULL,
  `salary_mode` enum('auto','manual') NOT NULL DEFAULT 'auto',
  `manual_start_date` date DEFAULT NULL,
  `manual_end_date` date DEFAULT NULL,
  `manual_hourly_rate` decimal(10,2) DEFAULT NULL,
  `compensation_group_id` bigint unsigned NOT NULL,
  `current_group` varchar(100) NOT NULL,
  `current_level` varchar(50) NOT NULL,
  `eligible_level` varchar(50) DEFAULT NULL,
  `level_locked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_teacher_salary_teacher` (`teacher_id`),
  KEY `fk_teacher_salary_group` (`compensation_group_id`),
  CONSTRAINT `fk_teacher_salary_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher_verifications`
--

DROP TABLE IF EXISTS `teacher_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_verifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `teacher_id` int unsigned NOT NULL,
  `verified_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_points` int DEFAULT NULL,
  `teacher_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `additional_topics` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`),
  KEY `idx_teacher` (`teacher_id`),
  KEY `idx_verified_at` (`verified_at`),
  CONSTRAINT `fk_verif_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_verif_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teachers_disabled_dates`
--

DROP TABLE IF EXISTS `teachers_disabled_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers_disabled_dates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int unsigned DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `is_every` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teachers_disabled_dates_users_id_fk` (`teacher_id`),
  CONSTRAINT `teachers_disabled_dates_users_id_fk` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testimonial_translations`
--

DROP TABLE IF EXISTS `testimonial_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonial_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `testimonial_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_bio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `testimonial_translations_testimonial_id_foreign` (`testimonial_id`),
  KEY `testimonial_translations_locale_index` (`locale`),
  CONSTRAINT `testimonial_translations_testimonial_id_foreign` FOREIGN KEY (`testimonial_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `status` enum('active','disable') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disable',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `text_lesson_translations`
--

DROP TABLE IF EXISTS `text_lesson_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `text_lesson_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `text_lesson_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `text_lesson_id` (`text_lesson_id`),
  KEY `text_lesson_translations_locale_index` (`locale`),
  CONSTRAINT `text_lesson_id` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `text_lessons`
--

DROP TABLE IF EXISTS `text_lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `text_lessons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `chapter_id` int unsigned DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `study_time` int unsigned DEFAULT NULL,
  `accessibility` enum('free','paid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT '0',
  `access_after_day` int unsigned DEFAULT NULL,
  `order` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int unsigned NOT NULL,
  `updated_at` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `text_lessons_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `text_lessons_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `text_lessons_chapter_id_foreign` (`chapter_id`),
  CONSTRAINT `text_lessons_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `text_lessons_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `text_lessons_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `text_lessons_attachments`
--

DROP TABLE IF EXISTS `text_lessons_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `text_lessons_attachments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `text_lesson_id` int unsigned NOT NULL,
  `file_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `text_lessons_attachments_text_lesson_id_foreign` (`text_lesson_id`) USING BTREE,
  KEY `text_lessons_attachments_file_id_foreign` (`file_id`) USING BTREE,
  CONSTRAINT `text_lessons_attachments_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `text_lessons_attachments_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `theme_colors`
--

DROP TABLE IF EXISTS `theme_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theme_colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `theme_id` int NOT NULL,
  `theme_type` enum('light','dark') NOT NULL,
  `color_name` varchar(50) NOT NULL,
  `color_value` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_theme_color` (`theme_id`,`theme_type`,`color_name`),
  KEY `idx_theme_type` (`theme_id`,`theme_type`),
  CONSTRAINT `theme_colors_ibfk_1` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `themes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(10) NOT NULL DEFAULT '1.0.0',
  `organization_id` varchar(50) NOT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `app_name` varchar(255) DEFAULT NULL,
  `support_email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `app_logo` varchar(255) DEFAULT NULL,
  `app_favicon` varchar(255) DEFAULT NULL,
  `about_app` text,
  `terms_conditions` text,
  PRIMARY KEY (`id`),
  KEY `idx_org_id` (`organization_id`),
  KEY `idx_last_updated` (`last_updated`),
  KEY `idx_app_name` (`app_name`),
  KEY `idx_support_email` (`support_email`),
  KEY `idx_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket_translations`
--

DROP TABLE IF EXISTS `ticket_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_translations_ticket_id_foreign` (`ticket_id`),
  KEY `ticket_translations_locale_index` (`locale`),
  CONSTRAINT `ticket_translations_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket_users`
--

DROP TABLE IF EXISTS `ticket_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ticket_users_ticket_id_foreign` (`ticket_id`) USING BTREE,
  KEY `ticket_users_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `ticket_users_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `start_date` int unsigned DEFAULT NULL,
  `end_date` int unsigned DEFAULT NULL,
  `discount` int NOT NULL,
  `capacity` int DEFAULT NULL,
  `order` int unsigned DEFAULT NULL,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tickets_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `tickets_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `tickets_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `tickets_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tickets_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tickets_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics_taught`
--

DROP TABLE IF EXISTS `topics_taught`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics_taught` (
  `id` int NOT NULL AUTO_INCREMENT,
  `summary_id` int NOT NULL,
  `topic_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `verified_by_teacher` tinyint(1) DEFAULT '0',
  `points_awarded` int DEFAULT '5',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_summary` (`summary_id`),
  KEY `idx_verified` (`verified_by_teacher`),
  CONSTRAINT `fk_topics_sum` FOREIGN KEY (`summary_id`) REFERENCES `class_summaries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11350 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transcriptions`
--

DROP TABLE IF EXISTS `transcriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transcriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `full_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `word_count` int DEFAULT NULL,
  `duration_seconds` int DEFAULT NULL,
  `language_detected` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`),
  KEY `idx_processed` (`processed_at`),
  CONSTRAINT `fk_trans_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1894 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tranzila_notifications`
--

DROP TABLE IF EXISTS `tranzila_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tranzila_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json NOT NULL,
  `status` enum('received','processed','failed','error') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'received',
  `processed_at` datetime DEFAULT NULL,
  `processing_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trend_categories`
--

DROP TABLE IF EXISTS `trend_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trend_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `trend_categories_category_id_index` (`category_id`) USING BTREE,
  CONSTRAINT `trend_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_class_evaluations`
--

DROP TABLE IF EXISTS `trial_class_evaluations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_class_evaluations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trial_class_registrations_id` bigint NOT NULL COMMENT 'Reference to trial_class_registrations table	',
  `demo_class_id` bigint unsigned DEFAULT NULL,
  `plan_recommendation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_evaluation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `student_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_plan_recommendation` (`plan_recommendation`),
  KEY `idx_student_level` (`student_level`),
  KEY `idx_demo_class_created_at` (`demo_class_id`,`created_at`),
  CONSTRAINT `trial_class_evaluations_demo_class_id_foreign` FOREIGN KEY (`demo_class_id`) REFERENCES `democlasses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_class_registrations`
--

DROP TABLE IF EXISTS `trial_class_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_class_registrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Full name of the student',
  `parent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of parent/guardian if applicable',
  `country_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Country code for phone number',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mobile number of student/parent',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email address for communications',
  `age` int NOT NULL COMMENT 'Age of the student',
  `status` enum('pending','confirmed','cancelled','completed','converted') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT 'Current status of trial class',
  `teacher_id` int unsigned NOT NULL COMMENT 'Reference to users table for teacher',
  `booked_by` int unsigned NOT NULL COMMENT 'Reference to users table for sales agent',
  `notification_preferences` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT 'JSON containing notification preferences',
  `class_id` int DEFAULT NULL COMMENT 'Reference to regular class if converted',
  `regular_class_id` int DEFAULT NULL COMMENT 'Reference to regular class series if applicable',
  `meeting_start` datetime NOT NULL COMMENT 'Start time of trial class in UTC',
  `meeting_end` datetime NOT NULL COMMENT 'End time of trial class in UTC',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes or requirements',
  `language` enum('HE','EN','AR') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN' COMMENT 'Preferred language for class',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Record creation timestamp',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record update timestamp',
  `cancellation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Reason for cancellation if class was cancelled',
  `cancelled_by` int unsigned DEFAULT NULL COMMENT 'ID of user who cancelled the class',
  `cancelled_at` timestamp NULL DEFAULT NULL COMMENT 'Timestamp when the class was cancelled',
  `trial_class_status` enum('trial_1','trial_2','trial_2_paid','trial_3','trial_3_paid','waiting_for_answer','payment_sent','new_enroll','follow_up','not_relevant','waiting_for_payment') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'trial_1' COMMENT 'trial_1: Trial Class 1, trial_2: Trial Class 2, trial_2_paid: Trial Class 2 (Paid), trial_3: Trial Class 3, trial_3_paid: Trial Class 3 (Paid), waiting_for_answer: Waiting for Answer, payment_sent: Payment Sent, new_enroll: New Enroll, follow_up: Follow-Up Needed, not_relevant: Not Relevant, waiting_for_payment: Waiting for Payment',
  `transfer_status` enum('not_transferred','transferred','transfer_accepted','transfer_rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not_transferred',
  `transferred_to` int unsigned DEFAULT NULL COMMENT 'Sales user ID student was transferred to',
  `transfer_date` datetime DEFAULT NULL COMMENT 'When the student was transferred',
  `status_change_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Notes and reason for trial class status changes',
  `family_id` int unsigned DEFAULT NULL COMMENT 'Reference to families table if booking is for family member',
  `child_id` int unsigned DEFAULT NULL COMMENT 'Reference to family_children table if booking is for family child',
  `booking_type` enum('new_customer','family_member') NOT NULL DEFAULT 'new_customer' COMMENT 'Whether this is a new customer or existing family member booking',
  PRIMARY KEY (`id`),
  KEY `idx_teacher_id` (`teacher_id`),
  KEY `idx_booked_by` (`booked_by`),
  KEY `idx_status` (`status`),
  KEY `idx_meeting_start` (`meeting_start`),
  KEY `fk_trial_class` (`class_id`),
  KEY `fk_regular_class` (`regular_class_id`),
  KEY `cancelled_by` (`cancelled_by`),
  KEY `idx_transfer_status` (`transfer_status`),
  KEY `idx_transferred_to` (`transferred_to`),
  KEY `idx_family_id` (`family_id`),
  KEY `idx_child_id` (`child_id`),
  KEY `idx_booking_type` (`booking_type`),
  KEY `idx_trial_duplicate_check` (`booked_by`,`student_name`,`teacher_id`,`meeting_start`,`meeting_end`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=8414 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_class_status_history`
--

DROP TABLE IF EXISTS `trial_class_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_class_status_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trial_class_id` bigint NOT NULL COMMENT 'Reference to trial_class_registrations table',
  `previous_status` enum('trial_1','trial_2','trial_2_paid','trial_3','trial_3_paid','waiting_for_answer','payment_sent','new_enroll','follow_up','not_relevant','waiting_for_payment','cancelled') DEFAULT NULL COMMENT 'Previous trial class status',
  `new_status` enum('trial_1','trial_2','trial_2_paid','trial_3','trial_3_paid','waiting_for_answer','payment_sent','new_enroll','follow_up','not_relevant','waiting_for_payment','cancelled') NOT NULL COMMENT 'New trial class status',
  `changed_by_id` int unsigned NOT NULL COMMENT 'ID of the user who made the change',
  `changed_by_type` enum('system','admin','sales_role','sales_appointment_setter') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin' COMMENT 'Type of user who made the change',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Optional notes about the status change',
  `attendance_change` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT 'JSON object containing attendance change details if applicable',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the status change was recorded',
  PRIMARY KEY (`id`),
  KEY `idx_trial_class_id` (`trial_class_id`),
  KEY `idx_changed_by_id` (`changed_by_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_trial_status_history` (`trial_class_id`,`created_at` DESC),
  CONSTRAINT `trial_class_status_history_ibfk_1` FOREIGN KEY (`trial_class_id`) REFERENCES `trial_class_registrations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trial_class_status_history_ibfk_2` FOREIGN KEY (`changed_by_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_payment_links`
--

DROP TABLE IF EXISTS `trial_payment_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_payment_links` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` bigint unsigned DEFAULT NULL COMMENT 'Reference to the trial_student_transfers table',
  `trial_class_id` bigint unsigned DEFAULT NULL COMMENT 'Reference to the trial_class_registrations table',
  `sales_user_id` int unsigned NOT NULL COMMENT 'Sales user who created the payment link',
  `subscription_plan_id` int DEFAULT NULL COMMENT 'The subscription plan being offered',
  `amount` decimal(10,2) NOT NULL COMMENT 'Amount to be paid',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'ILS' COMMENT 'Currency code',
  `link_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique token for the payment link',
  `payment_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Full URL of the payment link',
  `payment_status` enum('pending','paid','expired','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `sent_via_email` tinyint(1) DEFAULT '0' COMMENT 'Whether link was sent via email',
  `sent_via_whatsapp` tinyint(1) DEFAULT '0' COMMENT 'Whether link was sent via WhatsApp',
  `email_sent_at` datetime DEFAULT NULL COMMENT 'When the email was sent',
  `whatsapp_sent_at` datetime DEFAULT NULL COMMENT 'When the WhatsApp message was sent',
  `expiry_date` datetime NOT NULL COMMENT 'When the payment link expires',
  `payment_date` datetime DEFAULT NULL COMMENT 'When payment was completed',
  `payment_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Reference ID from payment processor',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_transfer_id` (`transfer_id`),
  KEY `idx_sales_user_id` (`sales_user_id`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_link_token` (`link_token`),
  KEY `idx_trial_class_id` (`trial_class_id`),
  CONSTRAINT `trial_payment_links_ibfk_1` FOREIGN KEY (`transfer_id`) REFERENCES `trial_student_transfers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trial_payment_links_ibfk_2` FOREIGN KEY (`sales_user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3014 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_student_transfers`
--

DROP TABLE IF EXISTS `trial_student_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_student_transfers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `trial_class_id` bigint NOT NULL COMMENT 'Reference to trial_class_registrations table',
  `appointment_setter_id` int unsigned NOT NULL COMMENT 'ID of the appointment setter who initiated the transfer',
  `sales_user_id` int unsigned NOT NULL COMMENT 'ID of the sales user the student is transferred to',
  `student_id` int unsigned DEFAULT NULL COMMENT 'Reference to users table if student already has an account',
  `student_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Name of the student being transferred',
  `student_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email of the student',
  `student_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Phone number of the student',
  `priority_level` enum('Low','Medium','High') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Medium' COMMENT 'Priority level for this transfer',
  `transfer_status` enum('pending','accepted','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `transfer_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When the transfer was initiated',
  `response_date` datetime DEFAULT NULL COMMENT 'When the sales user responded to the transfer',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Reason if the transfer was rejected',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about the transfer',
  `follow_up_date` date DEFAULT NULL COMMENT 'Date for follow-up if needed',
  `is_flagged` tinyint(1) DEFAULT '0' COMMENT 'Flag for special attention',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_trial_class_id` (`trial_class_id`),
  KEY `idx_appointment_setter_id` (`appointment_setter_id`),
  KEY `idx_sales_user_id` (`sales_user_id`),
  KEY `idx_transfer_status` (`transfer_status`),
  KEY `idx_transfer_date` (`transfer_date`),
  CONSTRAINT `trial_student_transfers_ibfk_1` FOREIGN KEY (`appointment_setter_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `trial_student_transfers_ibfk_2` FOREIGN KEY (`sales_user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `trial_student_transfers_ibfk_3` FOREIGN KEY (`trial_class_id`) REFERENCES `trial_class_registrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_transfer_activity_log`
--

DROP TABLE IF EXISTS `trial_transfer_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_transfer_activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` bigint unsigned NOT NULL COMMENT 'Reference to trial_student_transfers table',
  `user_id` int unsigned NOT NULL COMMENT 'User who performed the action',
  `user_role` enum('appointment_setter','sales_user','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of activity performed',
  `details` text COLLATE utf8mb4_unicode_ci COMMENT 'Details of the activity',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_transfer_id` (`transfer_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `trial_transfer_activity_log_ibfk_1` FOREIGN KEY (`transfer_id`) REFERENCES `trial_student_transfers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trial_transfer_activity_log_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trial_transfer_notifications`
--

DROP TABLE IF EXISTS `trial_transfer_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trial_transfer_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` bigint unsigned NOT NULL COMMENT 'Reference to trial_student_transfers table',
  `user_id` int unsigned NOT NULL COMMENT 'User receiving the notification',
  `user_role` enum('appointment_setter','sales_user','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_type` enum('new_transfer','transfer_accepted','transfer_rejected','payment_link_sent','payment_received','follow_up_reminder') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `transfer_id` (`transfer_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_read` (`is_read`),
  CONSTRAINT `trial_transfer_notifications_ibfk_1` FOREIGN KEY (`transfer_id`) REFERENCES `trial_student_transfers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trial_transfer_notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_goals`
--

DROP TABLE IF EXISTS `user_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_goals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `goal_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_mistakes`
--

DROP TABLE IF EXISTS `user_mistakes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_mistakes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `game_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `correct_answer` text COLLATE utf8mb4_unicode_ci,
  `mistake_count` int DEFAULT '1',
  `last_answered_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_game_item` (`user_id`,`game_type`,`item_id`),
  KEY `idx_user_game` (`user_id`,`game_type`),
  CONSTRAINT `fk_mistakes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_question_responses`
--

DROP TABLE IF EXISTS `user_question_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_question_responses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `question_id` int NOT NULL,
  `response_text` text COLLATE utf8mb4_unicode_ci,
  `selected_options` json DEFAULT NULL,
  `question_type` enum('single-choice','multiple-choice','checkbox','yes-no','text') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_question` (`user_id`,`question_id`),
  KEY `idx_user_responses_user_id` (`user_id`),
  KEY `idx_user_responses_question_id` (`question_id`),
  KEY `idx_user_responses_created_at` (`created_at`),
  CONSTRAINT `fk_user_response_question` FOREIGN KEY (`question_id`) REFERENCES `question_bank` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_response_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1258 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_referral_settings`
--

DROP TABLE IF EXISTS `user_referral_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_referral_settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `user_tag` enum('regular','partnership','custom') DEFAULT 'regular',
  `custom_rules` json DEFAULT NULL,
  `reward_multiplier` decimal(5,2) DEFAULT '1.00',
  `is_active` tinyint(1) DEFAULT '1',
  `notes` text,
  `created_at` bigint NOT NULL,
  `updated_at` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_tag` (`user_tag`),
  CONSTRAINT `user_referral_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_reviews`
--

DROP TABLE IF EXISTS `user_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `instructor_id` int unsigned DEFAULT NULL,
  `content_quality` int unsigned NOT NULL,
  `instructor_skills` int unsigned NOT NULL,
  `purchase_worth` int unsigned NOT NULL,
  `support_quality` int unsigned NOT NULL,
  `rates` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int unsigned NOT NULL,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_reviews_creator_id_foreign` (`creator_id`),
  KEY `user_reviews_instructor_id_foreign` (`instructor_id`),
  CONSTRAINT `user_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_reviews_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4514 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_subscription_details`
--

DROP TABLE IF EXISTS `user_subscription_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_subscription_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `plan_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `each_lesson` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `renew_date` datetime DEFAULT NULL,
  `weekly_comp_class` int DEFAULT '0',
  `how_often` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekly_lesson` int DEFAULT NULL,
  `status` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_cancel` tinyint NOT NULL DEFAULT '0',
  `cancellation_date` datetime DEFAULT NULL,
  `cancelled_by_user_id` int unsigned DEFAULT NULL,
  `cancellation_reason_category_id` int unsigned DEFAULT NULL COMMENT 'User-selected cancellation reason (FK)',
  `cancellation_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lesson_min` int DEFAULT NULL,
  `left_lessons` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `balance` decimal(10,0) DEFAULT '0',
  `lesson_reset_at` timestamp NULL DEFAULT NULL,
  `old_lesson_reset_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bonus_completed_class` int unsigned NOT NULL DEFAULT '0',
  `bonus_class` int unsigned NOT NULL DEFAULT '0',
  `data_of_bonus_class` json DEFAULT NULL,
  `discount_data` json DEFAULT NULL,
  `inactive_after_renew` tinyint(1) NOT NULL DEFAULT '0',
  `cost_per_lesson` decimal(10,0) DEFAULT '0',
  `offline_payment_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `offline_payment_admin_id` int unsigned DEFAULT NULL,
  `offline_payment_date` datetime DEFAULT NULL,
  `payment_status` enum('online','offline','pending','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'offline',
  `bonus_expire_date` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about the subscription',
  PRIMARY KEY (`id`),
  KEY `user_subscription_details_users_id_fk` (`user_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_renew_date` (`renew_date`),
  KEY `idx_is_cancel` (`is_cancel`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_balance` (`balance`),
  KEY `idx_bonus_expire_date` (`bonus_expire_date`),
  KEY `idx_user_status_renew` (`user_id`,`status`,`renew_date`),
  KEY `idx_lesson_reset_at` (`lesson_reset_at`),
  KEY `idx_old_lesson_reset_at` (`old_lesson_reset_at`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_offline_payment_admin` (`offline_payment_admin_id`),
  KEY `idx_user_subscription_bonus_expire` (`bonus_expire_date`),
  KEY `idx_user_subscription_bonus_class` (`bonus_class`),
  KEY `fk_user_subscription_details_cancellation_reason_category` (`cancellation_reason_category_id`),
  KEY `fk_user_subscription_payment` (`payment_id`),
  KEY `idx_user_created_desc` (`user_id`,`created_at` DESC),
  KEY `idx_subscription_user_status` (`user_id`,`status`),
  KEY `idx_subscription_created` (`created_at` DESC),
  KEY `idx_subscription_type` (`type`),
  KEY `idx_user_created` (`user_id`,`created_at`),
  CONSTRAINT `fk_user_subscription_details_cancellation_reason_category` FOREIGN KEY (`cancellation_reason_category_id`) REFERENCES `cancellation_reason_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_user_subscription_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment_transactions` (`id`),
  CONSTRAINT `user_subscription_details_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22841 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int unsigned NOT NULL,
  `organ_id` int DEFAULT NULL,
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '+91',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apple_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `financial_approval` tinyint(1) NOT NULL DEFAULT '0',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_settings` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_demo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_demo_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `province_id` int unsigned DEFAULT NULL,
  `city_id` int unsigned DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_id` int unsigned DEFAULT NULL,
  `location` point DEFAULT NULL,
  `level_of_training` bit(3) DEFAULT NULL,
  `meeting_type` enum('all','in_person','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
  `status` enum('active','pending','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `access_content` tinyint(1) NOT NULL DEFAULT '1',
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `public_message` tinyint(1) NOT NULL DEFAULT '0',
  `account_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iban` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_scan` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission` int unsigned DEFAULT NULL,
  `affiliate` tinyint(1) NOT NULL DEFAULT '1',
  `can_create_store` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Despite disabling the store feature in the settings, we can enable this feature for that user through the edit page of a user and turning on the store toggle.',
  `ban` tinyint(1) NOT NULL DEFAULT '0',
  `ban_start_at` int unsigned DEFAULT NULL,
  `ban_end_at` int unsigned DEFAULT NULL,
  `offline` tinyint(1) NOT NULL DEFAULT '0',
  `offline_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `subscription_id` int DEFAULT NULL,
  `trial_expired` tinyint(1) NOT NULL DEFAULT '0',
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_month_subscription` tinyint(1) NOT NULL DEFAULT '0',
  `next_year_subscription` tinyint(1) NOT NULL DEFAULT '0',
  `video_demo_thumb` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_hours` int DEFAULT '0',
  `notification_channels` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '["email"]',
  `lesson_notifications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '["24","1"]',
  `site_intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fcm_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `guardian` bigint unsigned DEFAULT NULL,
  `is_parent` tinyint NOT NULL DEFAULT '0',
  `enable_zoom_link` tinyint NOT NULL DEFAULT '0',
  `student_level` text COLLATE utf8mb4_unicode_ci,
  `add_zoom_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `add_zoom_link_meeting_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `add_zoom_link_access_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '+91',
  `age` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `what_learn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `education` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `eng_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `eng_study` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `availability` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experience` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '+91',
  `is_appointment_setter` tinyint(1) DEFAULT '0' COMMENT 'Whether user is an appointment setter',
  `is_sales_user` tinyint(1) DEFAULT '0' COMMENT 'Whether user is a sales user',
  `trial_transfers_count` int unsigned DEFAULT '0' COMMENT 'Count of trial transfers for appointment setters',
  `accepted_trial_transfers_count` int unsigned DEFAULT '0' COMMENT 'Count of accepted trial transfers',
  `rejected_trial_transfers_count` int unsigned DEFAULT '0' COMMENT 'Count of rejected trial transfers',
  `trial_conversion_rate` decimal(5,2) DEFAULT '0.00' COMMENT 'Percentage of trial conversions for sales users',
  `trial_user_id` bigint DEFAULT NULL COMMENT 'Reference to trial_class_registrations table',
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Gender of the user (for kid accounts)',
  `invite_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Invite code used during registration',
  `invite_by` int unsigned DEFAULT NULL COMMENT 'User ID who referred this user',
  `attribution` json DEFAULT NULL COMMENT 'UTM and marketing attribution data',
  `device_info` json DEFAULT NULL COMMENT 'Device information including platform, version, deviceId, and persistentDeviceId',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `users_email_unique` (`email`) USING BTREE,
  UNIQUE KEY `users_mobile_unique` (`mobile`) USING BTREE,
  KEY `users_country_id_foreign` (`country_id`),
  KEY `users_province_id_foreign` (`province_id`),
  KEY `users_city_id_foreign` (`city_id`),
  KEY `users_district_id_foreign` (`district_id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_organ_id` (`organ_id`),
  KEY `idx_mobile_country_code` (`mobile`,`country_code`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_role_status_organ` (`role_id`,`status`,`organ_id`),
  KEY `idx_trial_expired_ban` (`trial_expired`,`ban`),
  KEY `idx_timezone` (`timezone`),
  KEY `idx_is_parent` (`is_parent`),
  KEY `idx_teacher_lookup` (`id`,`role_name`,`status`),
  CONSTRAINT `users_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `users_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `users_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_badges`
--

DROP TABLE IF EXISTS `users_badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_badges` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `badge_id` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `users_badges_user_id_foreign` (`user_id`) USING BTREE,
  KEY `users_badges_badge_id_foreign` (`badge_id`) USING BTREE,
  CONSTRAINT `users_badges_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_badges_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_cookie_security`
--

DROP TABLE IF EXISTS `users_cookie_security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_cookie_security` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `type` enum('all','customize') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_cookie_security_user_id_foreign` (`user_id`),
  CONSTRAINT `users_cookie_security_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_manual_purchase`
--

DROP TABLE IF EXISTS `users_manual_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_manual_purchase` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `access` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_metas`
--

DROP TABLE IF EXISTS `users_metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_metas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_metas_user_id_foreign` (`user_id`),
  CONSTRAINT `users_metas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_occupations`
--

DROP TABLE IF EXISTS `users_occupations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_occupations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `users_occupations_user_id_foreign` (`user_id`) USING BTREE,
  KEY `users_occupations_category_id_foreign` (`category_id`) USING BTREE,
  CONSTRAINT `users_occupations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_occupations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_registration_packages`
--

DROP TABLE IF EXISTS `users_registration_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_registration_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `instructors_count` int DEFAULT NULL,
  `students_count` int DEFAULT NULL,
  `courses_capacity` int DEFAULT NULL,
  `courses_count` int DEFAULT NULL,
  `meeting_count` int DEFAULT NULL,
  `status` enum('disabled','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_registration_packages_user_id_foreign` (`user_id`),
  CONSTRAINT `users_registration_packages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_zoom_api`
--

DROP TABLE IF EXISTS `users_zoom_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_zoom_api` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `jwt_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_zoom_api_user_id_foreign` (`user_id`),
  CONSTRAINT `users_zoom_api_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verifications`
--

DROP TABLE IF EXISTS `verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `mobile` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified_at` int unsigned DEFAULT NULL,
  `expired_at` int unsigned DEFAULT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `verifications_user_id_foreign` (`user_id`) USING BTREE,
  CONSTRAINT `verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_assignment_attachments`
--

DROP TABLE IF EXISTS `webinar_assignment_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_assignment_attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `assignment_id` int unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attach` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_assignment_attachments_assignment_id_foreign` (`assignment_id`),
  CONSTRAINT `webinar_assignment_attachments_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_assignment_history`
--

DROP TABLE IF EXISTS `webinar_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_assignment_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `instructor_id` int unsigned NOT NULL,
  `student_id` int unsigned NOT NULL,
  `assignment_id` int unsigned NOT NULL,
  `grade` int unsigned DEFAULT NULL,
  `status` enum('pending','passed','not_passed','not_submitted') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_assignment_history_instructor_id_foreign` (`instructor_id`),
  KEY `webinar_assignment_history_student_id_foreign` (`student_id`),
  KEY `webinar_assignment_history_assignment_id_foreign` (`assignment_id`),
  CONSTRAINT `webinar_assignment_history_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_assignment_history_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_assignment_history_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_assignment_history_messages`
--

DROP TABLE IF EXISTS `webinar_assignment_history_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_assignment_history_messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `assignment_history_id` int unsigned NOT NULL,
  `sender_id` int unsigned NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_assignment_history_id` (`assignment_history_id`),
  CONSTRAINT `webinar_assignment_history_id` FOREIGN KEY (`assignment_history_id`) REFERENCES `webinar_assignment_history` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_assignment_translations`
--

DROP TABLE IF EXISTS `webinar_assignment_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_assignment_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `webinar_assignment_id` int unsigned NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_assignment_id_translate_foreign` (`webinar_assignment_id`),
  KEY `webinar_assignment_translations_locale_index` (`locale`),
  CONSTRAINT `webinar_assignment_id_translate_foreign` FOREIGN KEY (`webinar_assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_assignments`
--

DROP TABLE IF EXISTS `webinar_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_assignments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `chapter_id` int unsigned NOT NULL,
  `grade` int unsigned DEFAULT NULL,
  `pass_grade` int unsigned DEFAULT NULL,
  `deadline` int unsigned DEFAULT NULL,
  `attempts` int unsigned DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT '0',
  `access_after_day` int unsigned DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_assignments_creator_id_foreign` (`creator_id`),
  KEY `webinar_assignments_webinar_id_foreign` (`webinar_id`),
  KEY `webinar_assignments_chapter_id_foreign` (`chapter_id`),
  CONSTRAINT `webinar_assignments_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_assignments_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_assignments_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_chapter_items`
--

DROP TABLE IF EXISTS `webinar_chapter_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_chapter_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `chapter_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `type` enum('file','session','text_lesson','quiz','assignment') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int unsigned DEFAULT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_chapter_items_chapter_id_foreign` (`chapter_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_chapter_items_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_chapter_translations`
--

DROP TABLE IF EXISTS `webinar_chapter_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_chapter_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `webinar_chapter_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_chapter_id` (`webinar_chapter_id`),
  KEY `webinar_chapter_translations_locale_index` (`locale`),
  CONSTRAINT `webinar_chapter_id` FOREIGN KEY (`webinar_chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_chapters`
--

DROP TABLE IF EXISTS `webinar_chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_chapters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `order` int unsigned DEFAULT NULL,
  `check_all_contents_pass` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_chapters_user_id_foreign` (`user_id`),
  KEY `webinar_chapters_webinar_id_foreign` (`webinar_id`),
  CONSTRAINT `webinar_chapters_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_chapters_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_extra_description_translations`
--

DROP TABLE IF EXISTS `webinar_extra_description_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_extra_description_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `webinar_extra_description_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_extra_description_id_foreign` (`webinar_extra_description_id`),
  KEY `webinar_extra_description_translations_locale_index` (`locale`),
  CONSTRAINT `webinar_extra_description_id_foreign` FOREIGN KEY (`webinar_extra_description_id`) REFERENCES `webinar_extra_descriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_extra_descriptions`
--

DROP TABLE IF EXISTS `webinar_extra_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_extra_descriptions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `type` enum('learning_materials','company_logos','requirements') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int unsigned DEFAULT NULL,
  `created_at` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webinar_extra_descriptions_creator_id_foreign` (`creator_id`),
  KEY `webinar_extra_descriptions_webinar_id_foreign` (`webinar_id`),
  CONSTRAINT `webinar_extra_descriptions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_extra_descriptions_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_filter_option`
--

DROP TABLE IF EXISTS `webinar_filter_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_filter_option` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `filter_option_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `webinar_filter_option_filter_option_id_foreign` (`filter_option_id`) USING BTREE,
  KEY `webinar_filter_option_webinar_id_foreign` (`webinar_id`) USING BTREE,
  CONSTRAINT `webinar_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_filter_option_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_partner_teacher`
--

DROP TABLE IF EXISTS `webinar_partner_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_partner_teacher` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `teacher_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `webinar_partner_teacher_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `webinar_partner_teacher_teacher_id_foreign` (`teacher_id`) USING BTREE,
  CONSTRAINT `webinar_partner_teacher_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_partner_teacher_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_reports`
--

DROP TABLE IF EXISTS `webinar_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_reports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `webinar_id` int unsigned NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `webinar_reports_webinar_id_foreign` (`webinar_id`) USING BTREE,
  CONSTRAINT `webinar_reports_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_reviews`
--

DROP TABLE IF EXISTS `webinar_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int unsigned NOT NULL,
  `webinar_id` int unsigned DEFAULT NULL,
  `bundle_id` int unsigned DEFAULT NULL,
  `content_quality` int unsigned NOT NULL,
  `instructor_skills` int unsigned NOT NULL,
  `purchase_worth` int unsigned NOT NULL,
  `support_quality` int unsigned NOT NULL,
  `rates` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int unsigned NOT NULL,
  `status` enum('pending','active') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `webinar_reviews_webinar_id_foreign` (`webinar_id`) USING BTREE,
  KEY `webinar_reviews_creator_id_foreign` (`creator_id`) USING BTREE,
  KEY `webinar_reviews_bundle_id_foreign` (`bundle_id`),
  CONSTRAINT `webinar_reviews_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinar_reviews_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinar_translations`
--

DROP TABLE IF EXISTS `webinar_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinar_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `webinar_id` int unsigned NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `webinar_translations_webinar_id_foreign` (`webinar_id`),
  KEY `webinar_translations_locale_index` (`locale`),
  CONSTRAINT `webinar_translations_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webinars`
--

DROP TABLE IF EXISTS `webinars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webinars` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` int unsigned NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `type` enum('webinar','course','text_lesson') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` int DEFAULT NULL,
  `duration` int unsigned DEFAULT NULL,
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_demo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` int unsigned DEFAULT NULL,
  `price` int unsigned DEFAULT NULL,
  `organization_price` int unsigned DEFAULT NULL,
  `support` tinyint(1) DEFAULT '0',
  `certificate` tinyint(1) NOT NULL DEFAULT '0',
  `downloadable` tinyint(1) DEFAULT '0',
  `partner_instructor` tinyint(1) DEFAULT '0',
  `subscribe` tinyint(1) DEFAULT '0',
  `forum` tinyint(1) NOT NULL DEFAULT '0',
  `access_days` int unsigned DEFAULT NULL COMMENT 'Number of days to access the course',
  `points` int DEFAULT NULL,
  `message_for_reviewer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('active','pending','is_draft','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `webinars_slug_unique` (`slug`) USING BTREE,
  KEY `webinars_teacher_id_foreign` (`teacher_id`) USING BTREE,
  KEY `webinars_category_id_foreign` (`category_id`) USING BTREE,
  KEY `webinars_slug_index` (`slug`) USING BTREE,
  KEY `webinars_creator_id_foreign` (`creator_id`) USING BTREE,
  CONSTRAINT `webinars_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinars_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webinars_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2019 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_lists`
--

DROP TABLE IF EXISTS `word_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_lists` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_favorite` tinyint(1) DEFAULT '0',
  `word_count` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_favorite` (`user_id`,`is_favorite`),
  CONSTRAINT `fk_wordlists_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `words`
--

DROP TABLE IF EXISTS `words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `words` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `list_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `word` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `translation` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `is_favorite` tinyint(1) DEFAULT '0',
  `practice_count` int DEFAULT '0',
  `correct_count` int DEFAULT '0',
  `accuracy` int DEFAULT '0',
  `last_practiced` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_list_id` (`list_id`),
  KEY `idx_word` (`word`),
  CONSTRAINT `fk_words_lists` FOREIGN KEY (`list_id`) REFERENCES `word_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'tulkka_live'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `cleanup_expired_payment_links` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `cleanup_expired_payment_links` ON SCHEDULE EVERY 1 QUARTER STARTS '2025-08-04 10:52:49' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Delete expired links that are older than 90 days
    DELETE FROM payment_links 
    WHERE expires_at < DATE_SUB(NOW(), INTERVAL 90 DAY) 
    AND status IN ('expired', 'used');
    
    -- Update status of expired but not yet deleted links
    UPDATE payment_links 
    SET status = 'expired' 
    WHERE expires_at < NOW() 
    AND status = 'active';
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tulkka_live'
--

--
-- Final view structure for view `family_totals_view`
--

/*!50001 DROP VIEW IF EXISTS `family_totals_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `family_totals_view` AS select `f`.`id` AS `family_id`,`f`.`parent_name` AS `parent_name`,`f`.`parent_email` AS `parent_email`,`f`.`status` AS `family_status`,count(`fc`.`id`) AS `total_children`,count((case when (`fc`.`status` = 'active') then 1 end)) AS `active_children`,coalesce(sum((case when ((`fc`.`status` = 'active') and (`fc`.`monthly_amount` is not null)) then `fc`.`monthly_amount` else 0 end)),0) AS `total_monthly_amount`,coalesce(sum((case when ((`fc`.`status` = 'active') and (`fc`.`subscription_type` = 'monthly') and (`fc`.`monthly_amount` is not null)) then `fc`.`monthly_amount` else 0 end)),0) AS `monthly_revenue`,coalesce(sum((case when ((`fc`.`status` = 'active') and (`fc`.`subscription_type` = 'quarterly') and (`fc`.`monthly_amount` is not null)) then (`fc`.`monthly_amount` / 3) else 0 end)),0) AS `quarterly_monthly_equivalent`,coalesce(sum((case when ((`fc`.`status` = 'active') and (`fc`.`subscription_type` = 'yearly') and (`fc`.`monthly_amount` is not null)) then (`fc`.`monthly_amount` / 12) else 0 end)),0) AS `yearly_monthly_equivalent`,`f`.`created_at` AS `created_at`,`f`.`updated_at` AS `updated_at` from (`families` `f` left join `family_children` `fc` on((`f`.`id` = `fc`.`family_id`))) group by `f`.`id`,`f`.`parent_name`,`f`.`parent_email`,`f`.`status`,`f`.`created_at`,`f`.`updated_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-27 16:16:48
