/*
SQLyog Community Edition- MySQL GUI v5.29
Host - 5.5.5-10.4.6-MariaDB : Database - propsy
*********************************************************************
Server version : 5.5.5-10.4.6-MariaDB
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `propsy`;

USE `propsy`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `admin_owner` */

DROP TABLE IF EXISTS `admin_owner`;

CREATE TABLE `admin_owner` (
  `admin_id` varchar(7) NOT NULL,
  `admin_fullname` varchar(32) NOT NULL,
  `admin_username` varchar(32) NOT NULL,
  `admin_password` varchar(40) NOT NULL,
  `admin_email` varchar(32) NOT NULL,
  `admin_gender` enum('L','P') NOT NULL DEFAULT 'L',
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_username` (`admin_username`),
  UNIQUE KEY `admin_email` (`admin_email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `admin_owner` */

/*Table structure for table `city` */

DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `city_id` char(3) NOT NULL,
  `city_name` varchar(32) NOT NULL,
  `province_id` char(2) NOT NULL,
  PRIMARY KEY (`city_id`),
  KEY `fk_city_province_idx` (`province_id`),
  CONSTRAINT `fk_city_province_idx` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `city` */

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` varchar(14) NOT NULL,
  `customer_name` varchar(64) NOT NULL,
  `customer_email` varchar(64) NOT NULL,
  `customer_address` text DEFAULT NULL,
  `customer_phone_number` varchar(16) NOT NULL,
  `customer_username` varchar(32) NOT NULL,
  `customer_password` varchar(40) NOT NULL,
  `customer_photo` varchar(40) DEFAULT NULL,
  `city_id` char(3) DEFAULT NULL,
  `status_verification` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_email` (`customer_email`),
  UNIQUE KEY `customer_username` (`customer_username`),
  KEY `fk_customer_city_id` (`city_id`),
  CONSTRAINT `fk_customer_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

/*Table structure for table `developer_user` */

DROP TABLE IF EXISTS `developer_user`;

CREATE TABLE `developer_user` (
  `dev_user_id` varchar(13) NOT NULL,
  `dev_name` varchar(32) NOT NULL,
  `dev_ownername` varchar(32) NOT NULL,
  `dev_slug` text NOT NULL,
  `dev_address` text DEFAULT NULL,
  `dev_username` varchar(32) NOT NULL,
  `dev_password` varchar(40) NOT NULL,
  `dev_email` varchar(64) NOT NULL,
  `dev_biography` text DEFAULT NULL,
  `dev_phone_office` varchar(16) DEFAULT NULL,
  `dev_mobile_phone` varchar(16) DEFAULT NULL,
  `dev_logo` varchar(40) DEFAULT NULL,
  `city_id` char(3) DEFAULT NULL,
  `status_verification` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dev_user_id`),
  UNIQUE KEY `dev_username` (`dev_username`),
  UNIQUE KEY `dev_email` (`dev_email`),
  KEY `fk_dev_city_idx` (`city_id`),
  CONSTRAINT `fk_dev_city_idx` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

/*Table structure for table `log_project_request` */

DROP TABLE IF EXISTS `log_project_request`;

CREATE TABLE `log_project_request` (
  `log_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `log_message` text DEFAULT NULL,
  `request_id` varchar(18) NOT NULL,
  `log_date` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `fk_log_request_id` (`request_id`),
  CONSTRAINT `fk_log_request_id` FOREIGN KEY (`request_id`) REFERENCES `project_request` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

/*Table structure for table `marketing_user` */

DROP TABLE IF EXISTS `marketing_user`;

CREATE TABLE `marketing_user` (
  `mkt_user_id` varchar(13) NOT NULL,
  `mkt_fullname` varchar(40) NOT NULL,
  `mkt_email` varchar(64) NOT NULL,
  `mkt_username` varchar(32) NOT NULL,
  `mkt_password` varchar(40) NOT NULL,
  `mkt_phone_number` varchar(16) DEFAULT NULL,
  `mkt_mobile_phone` varchar(16) DEFAULT NULL,
  `mkt_address` text DEFAULT NULL,
  `mkt_biography` text DEFAULT NULL,
  `mkt_profile_photo` varchar(40) DEFAULT NULL,
  `dev_user_id` varchar(13) NOT NULL,
  `city_id` char(3) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`mkt_user_id`),
  UNIQUE KEY `mkt_username` (`mkt_username`),
  UNIQUE KEY `mkt_email` (`mkt_email`),
  KEY `fk_dev_user_idx` (`dev_user_id`),
  KEY `fk_mkt_city_idx` (`city_id`),
  CONSTRAINT `fk_dev_user_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mkt_city_idx` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `marketing_user` */

/*Table structure for table `meeting_appointment` */

DROP TABLE IF EXISTS `meeting_appointment`;

CREATE TABLE `meeting_appointment` (
  `meeting_id` varchar(17) NOT NULL,
  `meeting_time` datetime NOT NULL,
  `meeting_status` enum('waiting_confirmation','accept','reject','revision','cancel','done') NOT NULL DEFAULT 'waiting_confirmation',
  `request_id` varchar(18) NOT NULL,
  `meeting_note` tinytext DEFAULT NULL,
  `meeting_result` text DEFAULT NULL,
  `document_file` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`meeting_id`),
  KEY `fk_meeting_request_idx` (`request_id`),
  CONSTRAINT `fk_meeting_request_idx` FOREIGN KEY (`request_id`) REFERENCES `project_request` (`request_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(40) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

/*Table structure for table `project_list` */

DROP TABLE IF EXISTS `project_list`;

CREATE TABLE `project_list` (
  `project_id` varchar(10) NOT NULL,
  `project_name` varchar(200) NOT NULL,
  `project_slug` text NOT NULL,
  `project_thumbnail` varchar(128) DEFAULT NULL,
  `project_description` longtext DEFAULT NULL,
  `project_address` text DEFAULT NULL,
  `project_link_map` tinytext DEFAULT NULL,
  `project_map_embed` text DEFAULT NULL,
  `project_type` enum('apartemen','residensial') NOT NULL DEFAULT 'residensial',
  `project_status` enum('available','sold','soon') NOT NULL DEFAULT 'available',
  `project_estimate_launch` year(4) DEFAULT NULL,
  `dev_user_id` varchar(13) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `city_id` char(3) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `fk_project_dev_idx` (`dev_user_id`),
  CONSTRAINT `fk_project_dev_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

/*Table structure for table `project_request` */

DROP TABLE IF EXISTS `project_request`;

CREATE TABLE `project_request` (
  `request_id` varchar(18) NOT NULL,
  `dev_user_id` varchar(13) NOT NULL,
  `customer_id` varchar(14) NOT NULL,
  `unit_type_id` varchar(8) NOT NULL,
  `request_message` text NOT NULL,
  `status_request` enum('waiting_response','cancel','meeting','accept','reject') NOT NULL DEFAULT 'waiting_response',
  `isReviewed` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `fk_req_unit_type_idx` (`unit_type_id`),
  KEY `fk_req_cust_idx` (`customer_id`),
  KEY `fk_req_dev_user_idx` (`dev_user_id`),
  CONSTRAINT `fk_req_cust_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_dev_user_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(40) NOT NULL,
  `unit_type_id` varchar(8) NOT NULL,
  PRIMARY KEY (`unit_gallery_id`),
  KEY `fk_unit_gallery_unit_type_idx` (`unit_type_id`),
  CONSTRAINT `fk_unit_gallery_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

/*Table structure for table `project_unit_type` */

DROP TABLE IF EXISTS `project_unit_type`;

CREATE TABLE `project_unit_type` (
  `unit_type_id` varchar(8) NOT NULL,
  `unit_name` varchar(128) NOT NULL,
  `unit_slug` tinytext NOT NULL,
  `unit_floor` tinyint(2) unsigned NOT NULL,
  `unit_lb` tinyint(3) unsigned NOT NULL,
  `unit_lt` tinyint(3) unsigned NOT NULL,
  `unit_kt` tinyint(2) unsigned NOT NULL,
  `unit_km` tinyint(2) unsigned NOT NULL,
  `unit_price` bigint(13) unsigned NOT NULL,
  `unit_description` longtext DEFAULT NULL,
  `unit_status` enum('available','sold','booked') NOT NULL DEFAULT 'available',
  `unit_watt` smallint(5) unsigned DEFAULT NULL,
  `unit_facility` tinytext DEFAULT NULL,
  `unit_thumbnail` varchar(40) DEFAULT NULL,
  `project_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`unit_type_id`),
  KEY `fk_unit_project_idx` (`project_id`),
  CONSTRAINT `fk_unit_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

/*Table structure for table `province` */

DROP TABLE IF EXISTS `province`;

CREATE TABLE `province` (
  `province_id` char(2) NOT NULL,
  `province_name` varchar(128) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `province` */

/*Table structure for table `unit_facility` */

DROP TABLE IF EXISTS `unit_facility`;

CREATE TABLE `unit_facility` (
  `id_facility` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `facility_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_facility`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `unit_facility` */

insert  into `unit_facility`(`id_facility`,`facility_name`) values (1,'Pendingin Ruangan (AC)'),(2,'Keamanan 24 Jam'),(3,'Air Panas'),(4,'Kolam Renang'),(5,'Telepon'),(6,'Balkon'),(7,'Taman'),(8,'Taman Bermain Anak'),(9,'Garasi'),(10,'Secure Parking'),(11,'Gym'),(12,'Halaman Terbuka'),(15,'Akses Internet / Wifi');

/*Table structure for table `verification_customer` */

DROP TABLE IF EXISTS `verification_customer`;

CREATE TABLE `verification_customer` (
  `hash_id` varchar(40) NOT NULL,
  `customer_id` varchar(14) NOT NULL,
  `expire_date` int(10) unsigned NOT NULL,
  `status_verify` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `fk_verify_customer_idx` (`customer_id`),
  CONSTRAINT `fk_verify_customer_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `verification_customer` */

/*Table structure for table `verification_developer` */

DROP TABLE IF EXISTS `verification_developer`;

CREATE TABLE `verification_developer` (
  `hash_id` varchar(40) NOT NULL,
  `dev_user_id` varchar(13) NOT NULL,
  `npwp_image` varchar(40) NOT NULL,
  `official_certificate` varchar(40) NOT NULL,
  `additional_document` varchar(40) DEFAULT NULL,
  `status_verification` enum('Y','N','R') DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `fk_verify_devuser_idx` (`dev_user_id`),
  CONSTRAINT `fk_verify_devuser_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `verification_developer` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
