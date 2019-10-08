/*
SQLyog Community Edition- MySQL GUI v5.29
Host - 5.5.5-10.4.6-MariaDB : Database - maps
*********************************************************************
Server version : 5.5.5-10.4.6-MariaDB
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `maps`;

USE `maps`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `admin_owner` */

DROP TABLE IF EXISTS `admin_owner`;

CREATE TABLE `admin_owner` (
  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_fullname` varchar(64) NOT NULL,
  `admin_username` varchar(64) NOT NULL,
  `admin_password` varchar(64) NOT NULL,
  `admin_email` varchar(64) NOT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `create_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_username` (`admin_username`),
  UNIQUE KEY `admin_email` (`admin_email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `admin_owner` */

insert  into `admin_owner`(`admin_id`,`admin_fullname`,`admin_username`,`admin_password`,`admin_email`,`created_by`,`create_at`,`updated_at`) values (1,'Sony Darmawan','sonypiay','d5f3b4c238382e41fbe4b404e882cc73','pyscho30@gmail.com',NULL,'0000-00-00 00:00:00','2019-10-05 12:46:50'),(2,'Administrator','admin','21232f297a57a5a743894a0e4a801fc3','admin@mail.com',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00');

/*Table structure for table `city` */

DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `city_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city_name` varchar(128) NOT NULL,
  `city_slug` varchar(128) NOT NULL,
  `province_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`city_id`),
  KEY `fk_city_province_idx` (`province_id`),
  CONSTRAINT `fk_city_province_idx` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `city` */

insert  into `city`(`city_id`,`city_name`,`city_slug`,`province_id`) values (1,'Jakarta Pusat','jakarta-pusat',3),(2,'Jakarta Barat','jakarta-barat',3),(3,'Jakarta Timur','jakarta-timur',3),(4,'Jakarta Utara','jakarta-utara',3),(5,'Jakarta Selatan','jakarta-selatan',3),(6,'Bogor','bogor',2),(7,'Bekasi','bekasi',2),(8,'Depok','depok',2),(9,'Bandung','bandung',2),(10,'Serang','serang',1),(11,'Tangerang','tangerang',1),(12,'Tangerang Selatan','tangerang-selatan',1);

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(128) NOT NULL,
  `customer_email` varchar(128) NOT NULL,
  `customer_address` text DEFAULT NULL,
  `customer_city` int(10) unsigned DEFAULT NULL,
  `customer_phone_number` varchar(16) NOT NULL,
  `customer_username` varchar(64) NOT NULL,
  `customer_password` varchar(64) NOT NULL,
  `customer_photo` varchar(128) DEFAULT NULL,
  `status_verification` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_email` (`customer_email`),
  UNIQUE KEY `customer_username` (`customer_username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`customer_email`,`customer_address`,`customer_city`,`customer_phone_number`,`customer_username`,`customer_password`,`customer_photo`,`status_verification`,`created_at`,`updated_at`) values (1,'Sony Darmawan','sonypiay@mail.com','Jl. Meruya Selatan No. 7',1,'08561969052','sonypiay','d5f3b4c238382e41fbe4b404e882cc73',NULL,'Y','2019-09-27 21:19:47','2019-10-03 13:40:16'),(10,'Velvet Crowe','pyscho30@gmail.com','Jl. Blablabal',1,'08561969052','velvetcrowe','d5f3b4c238382e41fbe4b404e882cc73',NULL,'Y','2019-10-03 12:53:53','2019-10-03 13:37:54');

/*Table structure for table `developer_user` */

DROP TABLE IF EXISTS `developer_user`;

CREATE TABLE `developer_user` (
  `dev_user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dev_name` varchar(128) NOT NULL,
  `dev_ownername` varchar(255) NOT NULL,
  `dev_slug` text NOT NULL,
  `dev_address` text DEFAULT NULL,
  `dev_city` int(10) unsigned DEFAULT NULL,
  `dev_username` varchar(64) NOT NULL,
  `dev_password` varchar(64) NOT NULL,
  `dev_email` varchar(128) NOT NULL,
  `dev_biography` text DEFAULT NULL,
  `dev_phone_office` varchar(16) DEFAULT NULL,
  `dev_mobile_phone` varchar(16) DEFAULT NULL,
  `dev_ownership` enum('perusahaan','individu') DEFAULT NULL,
  `dev_logo` varchar(255) DEFAULT NULL,
  `status_verification` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dev_user_id`),
  UNIQUE KEY `dev_username` (`dev_username`),
  UNIQUE KEY `dev_email` (`dev_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_city`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_ownership`,`dev_logo`,`status_verification`,`created_at`,`updated_at`) values (1,'PT Agung Podomoro Land Tbk','PT Agung Podomoro Land Tbk','pt-agung-podomoro-land-tbk','APL Tower 43rd Floor, Podomoro City Jl. Let. Jend. S. Parman Kav. 28 Jakarta 11470 Indonesia',2,'podomoro','25d55ad283aa400af464c76d713c07ad','podomoro@gmail.com','PT Agung Podomoro Land Tbk. (APLN) is a leading integrated diversified real estate owner, developer and manager in the retail, commercial, and residential real estate segments with diversified holdings. We have an integrated property development model, from land acquisition and/or sourcing, to design and development, to project management, sales, commercial leasing and marketing, to the operation and management of our superblock developments, shopping malls, offices, hotels, and residential apartments and houses. We are known as a pioneer of the superblock development. Our high quality landmark projects, to name a few are Podomoro City, Kuningan City, and Senayan City.\n\n \n\nAPLN was established on July 30, 2004 under the name PT Tiara Metropolitan Jaya. In 2010, our shareholders completed a corporate restructuring, pursuant to which six developments and their holding companies were transferred to our control. APLN, is the flagship listed entity (IDX:APLN) of Agung Podomoro Group (APG), is one of the fastest growing and largest real estate developers in Indonesia with interests in superblocks, retail properties, office, apartments and residential, and hotels. APG established its first development, a housing complex in Simprug area, South Jakarta, in 1969 and completed its construction in 1973. From 1973 to present, members of APG completed or begun construction of more than 70 property projects, with majority addressed to middle class segments of society, with projects ranging from low cost apartments to high end apartments in South Jakarta, landed residentials, high end and the neighborhood mall, shop houses, hotels, soho and office towers.','622129034567','08561969052','perusahaan','E5J7mlIoEsknBfY1YRifZgs9JBwm3FFEuIi5CBNc.png','N','2019-09-19 17:02:30','2019-09-26 20:46:52');

/*Table structure for table `log_project_request` */

DROP TABLE IF EXISTS `log_project_request`;

CREATE TABLE `log_project_request` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_message` text DEFAULT NULL,
  `request_unique_id` varchar(18) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `fk_log_request_id` (`request_unique_id`),
  CONSTRAINT `fk_log_request_id` FOREIGN KEY (`request_unique_id`) REFERENCES `project_request` (`request_unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

insert  into `log_project_request`(`log_id`,`log_message`,`request_unique_id`,`created_at`,`updated_at`) values (1,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 6','REQ00001-20191001','2019-10-01 21:17:20','2019-10-01 21:17:20'),(2,'Marketing Agency Jakarta mengundang Sony Darmawan untuk meeting bersama.','REQ00001-20191001','2019-10-01 21:18:58','2019-10-01 21:18:58'),(3,'Sony Darmawan telah menerima undangan meeting.','REQ00001-20191001','2019-10-01 21:19:35','2019-10-01 21:19:35'),(4,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ00001-20191001','2019-10-01 21:21:08','2019-10-01 21:21:08'),(5,'Developer telah me-review pengajuan pemesanan unit.','REQ00001-20191001','2019-10-01 21:23:37','2019-10-01 21:23:37'),(6,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 7','REQ00002-20191001','2019-10-01 21:25:30','2019-10-01 21:25:30'),(7,'Marketing Agency Jakarta mengundang Sony Darmawan untuk meeting bersama.','REQ00002-20191001','2019-10-01 21:26:36','2019-10-01 21:26:36'),(8,'Sony Darmawan telah menolak undangan meeting.','REQ00002-20191001','2019-10-01 21:27:17','2019-10-01 21:27:17'),(9,'Marketing Agency Jakarta me-revisi jadwal undangan meeting.','REQ00002-20191001','2019-10-01 21:31:31','2019-10-01 21:31:31'),(10,'Sony Darmawan telah menerima undangan meeting.','REQ00002-20191001','2019-10-01 21:33:48','2019-10-01 21:33:48'),(11,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ00002-20191001','2019-10-01 21:37:15','2019-10-01 21:37:15'),(12,'Developer telah me-review pengajuan pemesanan unit.','REQ00002-20191001','2019-10-01 21:44:48','2019-10-01 21:44:48'),(13,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 8','REQ00003-20191001','2019-10-01 21:50:27','2019-10-01 21:50:27'),(14,'Sony Darmawan membatalkan pengajuan pemesanan unit','REQ00003-20191001','2019-10-01 21:52:14','2019-10-01 21:52:14'),(15,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 8','REQ00004-20191001','2019-10-01 21:52:24','2019-10-01 21:52:24'),(16,'Marketing Agency Jakarta mengundang Sony Darmawan untuk meeting bersama.','REQ00004-20191001','2019-10-01 21:53:25','2019-10-01 21:53:25'),(17,'Sony Darmawan telah menerima undangan meeting.','REQ00004-20191001','2019-10-01 21:54:52','2019-10-01 21:54:52'),(18,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ00004-20191001','2019-10-01 21:56:26','2019-10-01 21:56:26'),(19,'Developer telah me-review pengajuan pemesanan unit.','REQ00004-20191001','2019-10-01 21:58:17','2019-10-01 21:58:17'),(20,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 8','REQ00005-20191002','2019-10-02 09:02:45','2019-10-02 09:02:45'),(21,'Developer telah me-review pengajuan pemesanan unit.','REQ00005-20191002','2019-10-02 19:40:27','2019-10-02 19:40:27');

/*Table structure for table `marketing_user` */

DROP TABLE IF EXISTS `marketing_user`;

CREATE TABLE `marketing_user` (
  `mkt_user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mkt_fullname` varchar(128) NOT NULL,
  `mkt_email` varchar(128) NOT NULL,
  `mkt_username` varchar(64) NOT NULL,
  `mkt_password` varchar(64) NOT NULL,
  `mkt_phone_number` varchar(16) DEFAULT NULL,
  `mkt_mobile_phone` varchar(16) DEFAULT NULL,
  `mkt_city` int(10) unsigned DEFAULT NULL,
  `mkt_address` text DEFAULT NULL,
  `mkt_biography` text DEFAULT NULL,
  `mkt_profile_photo` varchar(255) DEFAULT NULL,
  `dev_user_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`mkt_user_id`),
  UNIQUE KEY `mkt_username` (`mkt_username`),
  UNIQUE KEY `mkt_email` (`mkt_email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `marketing_user` */

insert  into `marketing_user`(`mkt_user_id`,`mkt_fullname`,`mkt_email`,`mkt_username`,`mkt_password`,`mkt_phone_number`,`mkt_mobile_phone`,`mkt_city`,`mkt_address`,`mkt_biography`,`mkt_profile_photo`,`dev_user_id`,`created_at`,`updated_at`) values (1,'Marketing Agency Depok','mktdepok@agungpodomoro.com','podomoro_depok','25d55ad283aa400af464c76d713c07ad','02121129888','08561969052',8,NULL,NULL,NULL,1,'2019-09-26 17:30:11','2019-09-29 21:18:27'),(2,'Marketing Agency Jakarta','mktjakarta@agungpodomoro.com','podomoro_jakarta','25d55ad283aa400af464c76d713c07ad','02121292928','08561969052',2,NULL,NULL,NULL,1,'2019-09-26 17:58:35','2019-09-29 21:17:47');

/*Table structure for table `meeting_appointment` */

DROP TABLE IF EXISTS `meeting_appointment`;

CREATE TABLE `meeting_appointment` (
  `meeting_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_time` datetime NOT NULL,
  `meeting_status` enum('waiting_confirmation','accept','reject','revision','cancel','done') NOT NULL DEFAULT 'waiting_confirmation',
  `request_unique_id` varchar(18) NOT NULL,
  `meeting_note` text DEFAULT NULL,
  `meeting_result` text DEFAULT NULL,
  `document_file` varchar(128) DEFAULT NULL,
  `last_updated_by` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`meeting_id`),
  KEY `fk_meeting_request_idx` (`request_unique_id`),
  CONSTRAINT `fk_meeting_request_idx` FOREIGN KEY (`request_unique_id`) REFERENCES `project_request` (`request_unique_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

insert  into `meeting_appointment`(`meeting_id`,`meeting_time`,`meeting_status`,`request_unique_id`,`meeting_note`,`meeting_result`,`document_file`,`last_updated_by`,`created_at`,`updated_at`) values (1,'2019-10-01 09:00:00','done','REQ00001-20191001','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Park Bandung Tipe 6. Kami mengundang Anda untuk meeting sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Marketing','Meeting selesai','result_pqyVKIxg9VDacvRn14IufA7b6IpBCRjTzkeBnhHq.pdf','Marketing Agency Jakarta','2019-10-01 21:18:58','2019-10-01 21:21:07'),(2,'2019-10-06 13:00:00','done','REQ00002-20191001','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Park Bandung Tipe 7. Kami mengundang Anda untuk meeting sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Marketing','Meeting telah selesai dilakukan','result_bU9RSk8LM8Xmuoo6Jg3RfwB9EWustI0BD7d4wuhB.pdf','Marketing Agency Jakarta','2019-10-01 21:26:35','2019-10-01 21:37:15'),(3,'2019-10-01 10:00:00','done','REQ00004-20191001','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Park Bandung Tipe 8. Kami mengundang Anda untuk meeting sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Marketing','Meeting telah selesai dilakukan','result_tvp9JjuZBhl9VgHMs5JfUDhxmp1vKCJGZCCCQttG.pdf','Marketing Agency Jakarta','2019-10-01 21:53:25','2019-10-01 21:56:26');

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(128) NOT NULL,
  `gallery_description` text DEFAULT NULL,
  `project_unique_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_unique_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_unique_id`) REFERENCES `project_list` (`project_unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`gallery_description`,`project_unique_id`,`created_at`,`updated_at`) values (6,'oXBGYQuDxa9drfsBtVGw8jG1BcU5Z3TBroOWbiz1.jpeg',NULL,'PRY00001','2019-09-22 23:58:42','2019-09-22 23:58:42'),(8,'GI6LJNmTbc1HxHH16MMkhrHhf5UrIMu0DWJjAZFJ.jpeg',NULL,'PRY00001','2019-09-23 00:24:05','2019-09-23 00:24:05'),(9,'7hAp85CBQdIi3gjfRWUK7DCq0JxWGOu92qbDiBx5.jpeg',NULL,'PRY00001','2019-09-23 00:24:47','2019-09-23 00:24:47'),(10,'7EYltLPq8iJwzL2zBXRtOMw3kJ9wT98qvlXxGxcu.jpeg',NULL,'PRY00001','2019-09-23 00:24:58','2019-09-23 00:24:58'),(11,'dF0qeuw6r5cIdfZzl1aUYpfaheHz62QdGemi61Nu.jpeg',NULL,'PRY00001','2019-09-23 00:25:10','2019-09-23 00:25:10'),(13,'Gweoys7kDqtg8fO3p0tneiNEcgHDQSTqWvh9l66p.jpeg',NULL,'PRY00001','2019-09-23 00:25:40','2019-09-23 00:25:40'),(15,'VmIqsjAqwKJDx7lJ4NIbY5jUfEYofcKWHIpbUudS.jpeg',NULL,'PRY00002','2019-09-23 00:31:19','2019-09-23 00:31:19'),(16,'RkH8RKb9spsLVtqA1JiMaqQLovSpIajDkrANJnqp.jpeg',NULL,'PRY00002','2019-09-23 00:31:26','2019-09-23 00:31:26'),(17,'XglqAWirE7tJU37EetbxQyPbGmmeHid8Fw1Ly32f.jpeg',NULL,'PRY00002','2019-09-23 00:31:33','2019-09-23 00:31:33'),(18,'Dyp0Fv71GluOoaJQ12akxYviHVSpPBtjlZr45Dfo.jpeg',NULL,'PRY00002','2019-09-23 00:31:41','2019-09-23 00:31:41'),(19,'7t3eMacwpT3zaac1o2h0eh41lrLLqPIedubU62h3.jpeg',NULL,'PRY00002','2019-09-23 00:31:50','2019-09-23 00:31:50'),(20,'mxjkBGrC6PhPAbAQj9nr2S4JgweMrYZ6rTx9qheb.jpeg',NULL,'PRY00002','2019-09-23 00:31:57','2019-09-23 00:31:57'),(21,'q9RwHWjKgYnSr3b82x5a7AbFMFImLCieVJjxrtjZ.jpeg',NULL,'PRY00002','2019-09-23 00:32:30','2019-09-23 00:32:30'),(22,'JRxZR3JWmxourVcbA2rboDedMpiQ4pR0S7gIJKzn.jpeg',NULL,'PRY00002','2019-09-23 00:32:37','2019-09-23 00:32:37'),(23,'afKgJc1Aiyz3KJtMbhaIVMf5De5LvS5bBbWUlHk3.jpeg',NULL,'PRY00002','2019-09-23 00:32:45','2019-09-23 00:32:45'),(24,'T84G3fcFTTqxV4yij7kb8gooyPwYDdnUqvrmqmaH.jpeg',NULL,'PRY00002','2019-09-23 00:32:53','2019-09-23 00:32:53'),(25,'RF57Lo3Na2CUHdigoNDFcmn7Mq4rlWD3CztDWfLq.jpeg',NULL,'PRY00002','2019-09-23 00:33:00','2019-09-23 00:33:00'),(27,'WOHdsf8Y4CnvetJoUz4ospPJiXIXhEMLdd3STn3R.jpeg',NULL,'PRY00003','2019-10-02 18:38:48','2019-10-02 18:38:48'),(28,'o7PJ67vqXJKhAXNoCgGp6tEleBuke0tsiWsvz44P.jpeg',NULL,'PRY00003','2019-10-02 18:41:21','2019-10-02 18:41:21'),(29,'2ZXhjc2dGE9Eyopl5LWUSzDChCIxUuPNnCea6TSa.jpeg',NULL,'PRY00003','2019-10-02 18:41:28','2019-10-02 18:41:28'),(30,'DeoBHbZnYOEgoody4VHhdaWVu6spUqyG1tVRr9KR.jpeg',NULL,'PRY00003','2019-10-02 18:41:37','2019-10-02 18:41:37'),(31,'d9pOYyaGFYGClAH6oDkADDJ1xr8upBo7P6TOqXn5.jpeg',NULL,'PRY00003','2019-10-02 18:41:46','2019-10-02 18:41:46'),(32,'XhvoqmzrvZ77FILrJjUICme1wryv3f5kvhpuBy50.jpeg',NULL,'PRY00003','2019-10-02 18:41:54','2019-10-02 18:41:54'),(33,'wwA05wSSWiaHvNRbPcBFS8FB9fUNXCrJBDsQ2Jv2.jpeg',NULL,'PRY00003','2019-10-02 18:42:01','2019-10-02 18:42:01'),(34,'OiuHeargaKTYBqAvvxir3NNXjboc5mEO5lJ16sAT.jpeg',NULL,'PRY00003','2019-10-02 18:42:08','2019-10-02 18:42:08'),(35,'SBuS8t2XVUT87KxNjWzGm4Ja8Xa9D02lfnJi2Tcq.jpeg',NULL,'PRY00003','2019-10-02 18:42:16','2019-10-02 18:42:16'),(36,'pCgmODQTiLedJK8G7WhQlUYCyIX0OJLPNHuGeOub.jpeg',NULL,'PRY00005','2019-10-03 19:42:11','2019-10-03 19:42:11');

/*Table structure for table `project_list` */

DROP TABLE IF EXISTS `project_list`;

CREATE TABLE `project_list` (
  `project_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_unique_id` varchar(10) NOT NULL,
  `project_name` varchar(200) NOT NULL,
  `project_slug` text NOT NULL,
  `project_thumbnail` varchar(128) DEFAULT NULL,
  `project_description` text DEFAULT NULL,
  `project_address` text DEFAULT NULL,
  `project_city` int(10) unsigned NOT NULL,
  `project_link_map` tinytext DEFAULT NULL,
  `project_map_embed` text DEFAULT NULL,
  `project_site_plan` varchar(128) DEFAULT NULL,
  `project_type` enum('apartemen','residensial') NOT NULL DEFAULT 'residensial',
  `project_status` enum('available','sold','soon') NOT NULL DEFAULT 'available',
  `project_estimate_launch` year(4) DEFAULT NULL,
  `dev_user_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `project_unique_id` (`project_unique_id`),
  KEY `fk_project_dev_idx` (`dev_user_id`),
  CONSTRAINT `fk_project_dev_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_unique_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_city`,`project_link_map`,`project_map_embed`,`project_site_plan`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`) values (1,'PRY00001','Podomoro Park','podomoro-park','GI6LJNmTbc1HxHH16MMkhrHhf5UrIMu0DWJjAZFJ.jpeg','Agung Podomoro Land (APL) menghadirkan mahakarya terbarunya yaitu Podomoro Park Bandung, kawasan hunian yang terletak di tengah keindahan alam Bandung Selatan, seluas lebih dari 100 hektar. Konsep utama Podomoro Park terinsiprasi dari kawasan hunian berkelas dunia, yaitu Woodbrige di Irvine California serta desain masterplan dan landscape oleh Palmscape Singapore, sehingga Podomoro Park dapat dikategorikan sebagai world class home resort.\n\nPodomoro Park telah meraih penghargaan \"The Best Premium Home Resort in West Java\" dalam event Indonesia Property & Bank Award 2018. Ini membuktikan bahwa Podomoro Park memiliki konsep kawasan terbaik dengan menghadirkan kekuatan elemen alam, dan menjadikannya kawasan hunian resort terbaik di Jawa Barat. Maka tak heran bila antusias pasar sangat tinggi untuk memiliki hunian ini, hingga Podomoro Park menerima penghargaan “Most Favoured Premium Housing Estate” dalam event Housing Estate Award 2018.','Buahbatu, Bandung',9,NULL,NULL,NULL,'residensial','available',NULL,1,'2019-09-20 21:50:40','2019-09-25 21:05:59'),(2,'PRY00002','Podomoro River View','podomoro-river-view','7t3eMacwpT3zaac1o2h0eh41lrLLqPIedubU62h3.jpeg','<p><strong style=\"color: rgb(68, 68, 68);\">Podomoro River View&nbsp;</strong><span style=\"color: rgb(68, 68, 68);\">merupakan cluster perumahan baru di kawasan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">new city</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;Podomoro Golf View yang dikembangkan oleh developer ternama dan terpercaya,&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\">Agung Podomoro Land</strong><span style=\"color: rgb(68, 68, 68);\">. Didesain dengan konsep gaya hidup masa kini yang modern dan fleksibel, menghadirkan hunian dengan desain yang&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">simple</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;dan minimalis yang memberikan nilai lebih untuk Anda yang menginginkan hunian di kawasan kota baru yang hidup dan terintegrasi.</span></p><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Berada di kawasan&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\">Podomoro Golf View</strong><span style=\"color: rgb(68, 68, 68);\">&nbsp;yang merupakan pengembangan kota Baru di atas lahan seluas 60 Ha, perumahan ini dikelilingi oleh golf area dan berbatasan dengan aliran sungai Cikeas. Sehingga memberikan kawasan perumahan bernuansa hijau dengan udara yang segar.</span></p><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Sebagai hunian di kawasan terpadu yang megutamakan efisiensi, kawasan Podomoro Golf View menyediakan berbagai fasilitas penunjang yang lengkap serta akan terintegrasi dengan sarana transportasi umum&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Light Rail Transit&nbsp;</em><span style=\"color: rgb(68, 68, 68);\">(LRT) di dalam kawasan. Letaknya yang hanya 100 m dari exit tol Cimanggis juga memberikan kemudahan akses bagi penghuninya untuk mobilisasi sehari-hari.</span></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Keunggulan dari Podomoro River View:</strong></p><p><br></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Dikembangkan oleh developer terpercaya serta berpengalaman,&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\">Agung Podomoro Land</strong></li><li><span style=\"color: rgb(68, 68, 68);\">Lokasi yang sangat strategis, tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dibangun dengan konsep superblock dengan berbagai fasilitas penunjang yang lengkap</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</span></li><li><span style=\"color: rgb(68, 68, 68);\">Terintegrasi dengan Jalur Light Rail Transit (LRT)</span></li><li><span style=\"color: rgb(68, 68, 68);\">30 menit dari Bandara Halim Perdana Kusuma</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Lokasi:&nbsp;</strong><span style=\"color: rgb(68, 68, 68);\">Jalan Raya Tol Jagorawi KM 19, Cimanggis, Depok – Jawa Barat</span></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas yang terdapat pada Podomoro River View, yaitu:</strong></p><p><br></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Sistem satu gerbang</span></li><li><span style=\"color: rgb(68, 68, 68);\">CCTV 24 Jam</span></li><li><span style=\"color: rgb(68, 68, 68);\">Kolam renang</span></li><li><span style=\"color: rgb(68, 68, 68);\">Fitness Center</span></li><li><span style=\"color: rgb(68, 68, 68);\">Lapangan Basket</span></li><li><span style=\"color: rgb(68, 68, 68);\">Taman Bermain Anak</span></li><li><em style=\"color: rgb(68, 68, 68);\">Food and Beverage Riverside</em></li><li><em style=\"color: rgb(68, 68, 68);\">Foot Reflexology</em></li><li><em style=\"color: rgb(68, 68, 68);\">Club House</em></li><li><em style=\"color: rgb(68, 68, 68);\">Linear Park &amp; Garden</em></li><li><span style=\"color: rgb(68, 68, 68);\">Area Komersial</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tempat Ibadah</span></li><li><span style=\"color: rgb(68, 68, 68);\">Pasar Modern</span></li><li><span style=\"color: rgb(68, 68, 68);\">BBQ Area</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Tipe unit yang ditawarkan Podomoro River View, antara lain:</strong></p><p><br></p><ul><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Podomoro River View - Jupiter Tipe 6x12</span></li></ul><p><br></p>','Jalan Raya Tol Jagorawi KM 19',8,'https://goo.gl/maps/5T36eBaDyN4hdd987','<iframe src=\"https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15858.949688212939!2d106.8938815!3d-6.4277708!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x13e82aa7ed1d9f05!2sPodomoro%20Golf%20View!5e0!3m2!1sid!2sid!4v1570019255111!5m2!1sid!2sid\" width=\"800\" height=\"600\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>',NULL,'residensial','available',NULL,1,'2019-09-23 00:03:53','2019-10-02 19:28:03'),(4,'PRY00003','Podomoro Golf View','podomoro-golf-view','WOHdsf8Y4CnvetJoUz4ospPJiXIXhEMLdd3STn3R.jpeg','<p><strong style=\"color: rgb(68, 68, 68);\">Keunggulan Apartemen Podomoro Golf View :</strong></p><p><br></p><ul><li><strong style=\"color: rgb(68, 68, 68);\">Lokasi Podomoro Golf View Cimanggis</strong><span style=\"color: rgb(68, 68, 68);\">&nbsp;yang sangat strategis</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dibangun dengan konsep superblock</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dikembangkan oleh developer terpercaya serta berpengalaman, yaitu Agung Podomoro Land</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</span></li><li><span style=\"color: rgb(68, 68, 68);\">Terintegrasi dengan Jalur Light Rail Transit (LRT)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Bergabungnya Universitas Gunadarma sebagai pendukung fasilitas pendidikan dalam kawasan&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\">Perumahan Podomoro Golf View</strong></li><li><span style=\"color: rgb(68, 68, 68);\">30 menit dari Bandara Halim Perdana Kusuma</span></li></ul><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Bagi para pencari properti yang tertarik untuk memiliki hunian di kawasan penyanggah Ibukota, khususnya pada kawasan Cimanggis, Agung Podomoro Land menghadirkan opsi bermukim pada kawasan modern dan berkembang lewat Apartemen Podomoro Golf View (PGV) di selatan Jakarta. Berlokasi tepatnya di Jalan Raya Tol Jagorawi KM 19, Cimanggis, apartemen ekslusif ini dapat diakses hanya selangkah dari exit tol Cimanggis Jalan tol Jagorawi. Lebih lanjut, kestrategisan lokasi apartemen PGV dapat terlihat dari akses jarak ke Bandara terdekat hanya 30 menit saja (Bandara Halim Perdana Kusuma).</span></p><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Mengusung konsep \'</span><em style=\"background-color: transparent; color: rgb(68, 68, 68);\">New Home, New Hope, New City</em><span style=\"color: rgb(68, 68, 68);\">\', apartemen Podomoro Gold View menyajikan opsi bermukim yang dilengkapi oleh segala fasilitas penunjang kehidupan sehari-hari guna meningkatkan taraf hidup para pemukimnya. Dikelilingi oleh 3 lapangan golf dan sungai Cikeas, para pemukim akan merasakan nuansa asri dan hijau setiap harinya yang menciptakan ketentraman dan kenyamanan saat bermukim disana.</span></p><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Kawasan hunian vertikal diketahui berintegrasi dengan perkantoran, area komersial, serta pusat wisata kuliner baru (</span><em style=\"background-color: transparent; color: rgb(68, 68, 68);\">New Culinary Destination</em><span style=\"color: rgb(68, 68, 68);\">) terbesar di Cimanggis dengan nuansa seperti pada area kuliner Clarke Quay, Singapore atau San Antonio, AS. Selain destinasi kuliner, kawasan apartemen Podomoro Golf View juga akan menjadi kawasan pendidikan baru (</span><em style=\"background-color: transparent; color: rgb(68, 68, 68);\">New Education Destination</em><span style=\"color: rgb(68, 68, 68);\">) dan pusat belanja baru di Cimanggis (</span><em style=\"background-color: transparent; color: rgb(68, 68, 68);\">New Shopping Destination</em><span style=\"color: rgb(68, 68, 68);\">).</span></p><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Berdekatannya dengan beragam Universitas terbaik seperti UI, Universitas Pancasila, Gunadarma, dan sekolah Kolese Kanisius, tentu menjadikan apartemen Podomoro Golf View sebagai lahan peluang investasi sewa yang sangat besar untuk para investor dari masyarakat pengemban pendidikan tinggi pada kawasan tersebut.</span></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Podomoro Golf View Apartemen menawarkan 4 tipe unit hunian, yaitu :</strong></p><p><br></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe Studio (22 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 2 Bedroom (36 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 2 Bedroom Corner (37 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 3 Bedroom (52 m2)</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas yang terdapat pada Podomoro Golf View Apartemen, yaitu :</strong></p><p><br></p><ul><li><em style=\"color: rgb(68, 68, 68);\">Shuttle Bus</em></li><li><em style=\"color: rgb(68, 68, 68);\">Golf View 360ᵒ</em></li><li><span style=\"color: rgb(68, 68, 68);\">Area Komersial</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tempat Ibadah</span></li><li><span style=\"color: rgb(68, 68, 68);\">Pasar Modern</span></li><li><em style=\"color: rgb(68, 68, 68);\">Jogging Track</em></li><li><span style=\"color: rgb(68, 68, 68);\">Lapangan Badminton</span></li><li><span style=\"color: rgb(68, 68, 68);\">Area berkumpul untuk keluarga</span></li><li><em style=\"color: rgb(68, 68, 68);\">Infinity Swimming Pool</em></li><li><em style=\"color: rgb(68, 68, 68);\">BBQ Area</em></li><li><em style=\"color: rgb(68, 68, 68);\">Sky Garden</em></li><li><span style=\"color: rgb(68, 68, 68);\">Ruang Olahraga</span></li><li><em style=\"color: rgb(68, 68, 68);\">Sauna / Jacuzzi</em></li><li><em style=\"color: rgb(68, 68, 68);\">Minimart</em></li><li><em style=\"color: rgb(68, 68, 68);\">Light Rapid Transit</em></li></ul><p><br></p>','Cimanggis, Depok',8,'https://goo.gl/maps/vSBHcnRsk6r7CriP9','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3964.736797886865!2d106.88676511419558!3d-6.42785086464625!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69eadd7c10f133%3A0x8ef9da4ab2dfa20c!2sPodomoro%20Golf%20View!5e0!3m2!1sid!2sid!4v1570016213327!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>',NULL,'apartemen','available',NULL,1,'2019-09-28 00:53:44','2019-10-02 18:43:01'),(6,'PRY00005','Podomoro City Deli Medan','podomoro-city-deli-medan','pCgmODQTiLedJK8G7WhQlUYCyIX0OJLPNHuGeOub.jpeg','<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO PODOMORO CITY DELI MEDAN JULI 2019 : BOOKING FEE 25 JUTA DENGAN CICILAN 48X (DP 1,2,3 MASING-MASING 10%, SISA 70% BISA DICICIL 45X) (OFFICE) | CICILAN 30X (RESIDENCE)</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong style=\"background-color: transparent; color: rgb(68, 68, 68);\">Podomoro City Deli Medan&nbsp;</strong><span style=\"color: rgb(68, 68, 68);\">merupakan kawasan properti prestisius dengan skala pembangunan terbesar pertama di Medan, Sumatera Utara. Area properti terpadu yang dibangun pada kawasan superblok seluas 5,2 hektare di Jl. Guru Patimpus / Putri Hijau Blok OPQ No.1, Kesawan, Medan Barat, menghadirkan tidak hanya sektor hunian vertikal (kondominium, apartemen ekslusif, apartemen premium), namun juga office tower, tempat perbelanjaan mewah serta hotel berbintang. Dalam spesifikasinya, kawasan&nbsp;</span><strong style=\"background-color: transparent; color: rgb(68, 68, 68);\">Podomoro City Deli Medan</strong><span style=\"color: rgb(68, 68, 68);\">&nbsp;akan menghadirkan 7 buah tower hunian vertikal, 1 office tower dan 1 hotel tower di atas shopping Mall. Untuk ketinggian apartemen sangat bervariasi, sedangkan perkantoran terdapat 28 lantai dan hotel terdapat 14 lantai. Para pemukim juga disajikan area penghijauan yang sangat luas untuk menumbuhkan nuansa asri di tengah pengembangan kota modern yang menjadi ikon properti modern baru di Medan.</span></p><p><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Area properti modern dan ikonik dalam lokasi premium sebuah mahakarya dari developer ternama PT Agung Podomoro Land (APL), mengusung konsep \'</span><em style=\"background-color: transparent; color: rgb(68, 68, 68);\">One Stop Living, Working, &amp; Shopping</em><span style=\"color: rgb(68, 68, 68);\">\'. Dimana para pemukim dapat melakukan aktivitas sehari-harinya, baik bekerja ataupun berbelanja dalam satu kawasan yang berdekatan dengan hunian.</span></p><p><br></p><p><span style=\"color: rgb(68, 68, 68);\">Khusus hunian vertikal apartemen&nbsp;</span><strong style=\"background-color: transparent; color: rgb(68, 68, 68);\">Podomoro City Deli Medan</strong><span style=\"color: rgb(68, 68, 68);\">, banderolan harga cukup bersaing yakni mulai dari 900 jutaan hingga 3 milyar untuk sebuah hunian ekslusif di lokasi premium kota modern dengan kelengkapan fasilitas untuk beraktivitas sehari-hari.</span></p><p><br></p><p class=\"ql-align-justify\"><strong style=\"background-color: transparent; color: rgb(68, 68, 68);\">Keunggulan Podomoro City Deli Medan</strong></p><p class=\"ql-align-justify\"><br></p><ul><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Berada dalam kawasan superblok terpadu dan prestisius di kota Medan</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Dekat tempat perbelanjaan, perkantoran, dan sarana transportasi kereta cepat Medan</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Dilengkapi teknologi smart home system</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Pertumbuhan nilai sangat tinggi untuk investasi sewa</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Memiliki fasilitas berkelas internasional lengkap</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Podomoro City Deli Medan menawarkan beberapa tipe unit hunian, antara lain:</strong></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Exclusive Apartment :</strong></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe Studio (SGA : 32,48 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Deluxe A (SGA : 41,88 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Deluxe B&nbsp;(SGA : 41,01 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Superior A (SGA : 56 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Superior B (SGA : 56 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Superior C (SGA : 63,50 m2)</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Premium Apartment :</strong></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Deluxe (SGA : 59,01 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Deluxe A (SGA : 62,74 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Deluxe B (SGA : 62,74 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Superior (SGA : 87,16 m2)&nbsp;&nbsp;</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Suite A (SGA : 107,84 m2)</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Penthouse :</strong></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe PH - 1 (SGA : 116,77 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe PH – 2 (SGA : 153,72 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe PH – 3 (SGA : 172,72 m2)</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Tribeca Condominium :</strong></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Premier A (SGA : 101,03 m2)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Premier B (SGA : 101,57 m2)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Platinum A (SGA : 145,56 m2)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Luxurious Platinum B (SGA : 141,33 m2)</span></li></ul><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Premium Office Tower</strong><span style=\"color: rgb(68, 68, 68);\">&nbsp;(Luas SGA mulai dari 111,79 m2– 2133,47 m2)</span></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas :</strong><span style=\"color: rgb(68, 68, 68);\">&nbsp;Plaza, Lounge, BBQ Area</span></p>','Kesawan, Medan',6,NULL,NULL,NULL,'residensial','soon',2022,1,'2019-10-03 19:42:10','2019-10-03 19:42:10');

/*Table structure for table `project_request` */

DROP TABLE IF EXISTS `project_request`;

CREATE TABLE `project_request` (
  `request_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `request_unique_id` varchar(18) NOT NULL,
  `dev_user_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `unit_type_id` int(10) unsigned NOT NULL,
  `request_message` text NOT NULL,
  `request_note` text DEFAULT NULL,
  `status_request` enum('waiting_response','cancel','meeting','accept','reject') NOT NULL DEFAULT 'waiting_response',
  `isReviewed` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `request_unique_id` (`request_unique_id`),
  KEY `fk_req_unit_type_idx` (`unit_type_id`),
  KEY `fk_req_cust_idx` (`customer_id`),
  KEY `fk_req_dev_user_idx` (`dev_user_id`),
  CONSTRAINT `fk_req_cust_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_dev_user_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

insert  into `project_request`(`request_id`,`request_unique_id`,`dev_user_id`,`customer_id`,`unit_type_id`,`request_message`,`request_note`,`status_request`,`isReviewed`,`created_at`,`updated_at`) values (1,'REQ00001-20191001',1,1,1,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit.',NULL,'accept','Y','2019-10-01 21:17:20','2019-10-01 21:23:37'),(2,'REQ00002-20191001',1,1,4,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit.',NULL,'accept','Y','2019-10-01 21:25:30','2019-10-01 21:44:48'),(3,'REQ00003-20191001',1,1,5,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit.',NULL,'cancel','N','2019-10-01 21:50:27','2019-10-01 21:52:13'),(4,'REQ00004-20191001',1,1,5,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit.',NULL,'reject','Y','2019-10-01 21:52:24','2019-10-01 21:58:17'),(5,'REQ00005-20191002',1,1,5,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit Podomoro Park Bandung Tipe 8.',NULL,'reject','Y','2019-10-02 09:02:45','2019-10-02 19:40:27');

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(128) NOT NULL,
  `unit_type_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`unit_gallery_id`),
  KEY `fk_unit_gallery_unit_type_idx` (`unit_type_id`),
  CONSTRAINT `fk_unit_gallery_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`,`created_at`,`updated_at`) values (18,'unit-1de809ea5613f7.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(19,'unit-69e79c37eec14a.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(20,'unit-690e88870062bf.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(21,'unit-b790908329d2a8.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(22,'unit-73357fe46d7e8b.jpg',1,'2019-09-25 21:01:22','2019-09-25 21:01:22'),(23,'unit-7010c42484e51d.jpg',1,'2019-09-25 21:01:29','2019-09-25 21:01:29'),(24,'unit-ea0005ce42d60f.jpg',1,'2019-09-25 21:01:42','2019-09-25 21:01:42'),(25,'unit-1de809ea5613f7.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(26,'unit-1e8407a88e77d1.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(27,'unit-5be726ce55f731.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(28,'unit-69e79c37eec14a.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(29,'unit-690e88870062bf.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(30,'unit-853dac535cb8b0.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(31,'unit-6821e98a0c7b46.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(32,'unit-b790908329d2a8.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(33,'unit-ea0005ce42d60f.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(34,'unit-1d67e734ab780e.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(35,'unit-61f1538dd37557.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(36,'unit-95d5264c076083.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(37,'unit-208610fe35a61d.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(38,'unit-b2bf6dfddee69c.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(40,'unit-c048d3937cfb44.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(41,'unit-f56b12d2f24b3e.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(42,'unit-6fae022dc2ae30.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(43,'unit-9a614a9d3bef05.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(44,'unit-63a8891afbcc77.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(45,'unit-489e6c93204abc.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(46,'unit-5907beb03835a6.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(47,'unit-99844d10ea7652.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(48,'unit-a0e01bab280597.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(49,'unit-b715b84c0c3513.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(50,'unit-defb5e2a942d41.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(51,'unit-e2e9620f943b02.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(52,'unit-f44fffafda9b52.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(53,'unit-f608c6aa39c672.jpg',6,'2019-10-02 18:53:57','2019-10-02 18:53:57'),(54,'unit-b7734284967c86.jpg',7,'2019-10-02 19:05:02','2019-10-02 19:05:02'),(55,'unit-6fae022dc2ae30.jpg',7,'2019-10-02 19:05:18','2019-10-02 19:05:18'),(56,'unit-63a8891afbcc77.jpg',7,'2019-10-02 19:05:18','2019-10-02 19:05:18'),(57,'unit-489e6c93204abc.jpg',7,'2019-10-02 19:05:18','2019-10-02 19:05:18'),(58,'unit-99844d10ea7652.jpg',7,'2019-10-02 19:05:18','2019-10-02 19:05:18'),(59,'unit-defb5e2a942d41.jpg',7,'2019-10-02 19:05:18','2019-10-02 19:05:18'),(60,'unit-e2e9620f943b02.jpg',7,'2019-10-02 19:05:18','2019-10-02 19:05:18'),(61,'unit-5ae150840dcb35.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(62,'unit-5bd85208e64400.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(63,'unit-6b15c94be7968c.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(64,'unit-16e1d6e7b90c4f.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(65,'unit-361e30c07fa826.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(66,'unit-1357ce954bc88e.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(67,'unit-a4755ca1672348.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42'),(68,'unit-ab34ebaeb484dc.jpg',8,'2019-10-02 19:16:42','2019-10-02 19:16:42');

/*Table structure for table `project_unit_type` */

DROP TABLE IF EXISTS `project_unit_type`;

CREATE TABLE `project_unit_type` (
  `unit_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) NOT NULL,
  `unit_slug` varchar(255) NOT NULL,
  `unit_floor` tinyint(3) unsigned NOT NULL,
  `unit_lb` tinyint(3) unsigned NOT NULL,
  `unit_lt` tinyint(3) unsigned NOT NULL,
  `unit_kt` tinyint(3) unsigned NOT NULL,
  `unit_km` tinyint(3) unsigned NOT NULL,
  `unit_price` bigint(20) unsigned NOT NULL,
  `unit_description` longtext DEFAULT NULL,
  `unit_status` enum('available','sold','booked') NOT NULL DEFAULT 'available',
  `unit_watt` int(10) unsigned DEFAULT NULL,
  `unit_facility` text DEFAULT NULL,
  `unit_thumbnail` varchar(255) DEFAULT NULL,
  `project_unique_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`unit_type_id`),
  KEY `fk_unit_project_uidx` (`project_unique_id`),
  CONSTRAINT `fk_unit_project_uidx` FOREIGN KEY (`project_unique_id`) REFERENCES `project_list` (`project_unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_unique_id`,`created_at`,`updated_at`) values (1,'Podomoro Park Bandung Tipe 6','podomoro-park-bandung-tipe-6',2,94,90,2,3,1400000000,'<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">CLUSTER AMAGRIYA (DELUXE)</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 15 meter (Nalendra):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;90 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,4 milyar</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 17 meter (Kancana):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;102 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,5 milyar</span></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas premium yang disediakan oleh Podomoro Park Bandung, yaitu :</strong></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Club House</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Taman Bermain Anak</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Bike Lane</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Kolam Renang</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Community Garden</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gym</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gazebo</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Jogging Track</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Viewing Deck</em></p>','sold',3500,'Balkon, Kolam Renang','unit-ea0005ce42d60f.jpg','PRY00001','2019-09-24 22:13:41','2019-10-01 21:17:20'),(4,'Podomoro Park Bandung Tipe 7','podomoro-park-bandung-tipe-7',2,127,126,3,3,2000000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER AMAGRIYA (DELUXE)</strong></p><p>Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 7 x 18 meter (Sanjaya):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;126 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;127 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</p><p>Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 2 milyar</p>','sold',3500,'Air Panas,Kolam Renang','unit-69e79c37eec14a.jpg','PRY00001','2019-09-25 21:03:37','2019-10-01 21:44:48'),(5,'Podomoro Park Bandung Tipe 8','podomoro-park-bandung-tipe-8',2,156,160,4,3,3100000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER ANAPURI (PREMIUM)</strong></p><p class=\"ql-align-justify\">Suasana keasrian resort akan sangat terasa ketika memasuki&nbsp;<em>gate cluster</em>&nbsp;yang megah dengan dihiasi hamparan taman dengan berbagai variasi bunga indah. Hunian mewah ini memiliki desain fasad yang&nbsp;<em>elegant</em>,&nbsp;<em>carport</em>&nbsp;yang luas,&nbsp;<em>living room</em>&nbsp;yang nyaman dengan akses langsung menuju&nbsp;<em>backyard</em>, hingga kehangatan suasana akan semakin tercipta dengan adanya&nbsp;<em>collective garden</em>&nbsp;yang terdapat di sisi belakang rumah. Hunian ini memiliki akses yang sangat dekat menuju danau dan memiliki&nbsp;<em>view&nbsp;</em>yang sangat indah karena barisan pegunungan Bandung Selatan tampak jelas dihadapan.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 8 x 20 meter (Darmaraja):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;160 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;156 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4400 VA</p><p class=\"ql-align-justify\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 3,1 milyar</p><p><br></p>','available',4400,'Gym,Telepon','unit-208610fe35a61d.jpg','PRY00001','2019-09-25 21:34:51','2019-10-02 19:40:27'),(6,'Podomoro Golf View Tipe Studio','podomoro-golf-view-tipe-studio',1,22,22,1,1,285850000,'<p><strong>Podomoro Golf View Tipe Studio</strong>merupakan tipe apartemen yang dilengkapi dengan 1 kamar tidur, 1 kamar mandi. Tipe ini memiliki luas bangunan 22 m2.</p><p><strong>Keunggulan Podomoro Golf View :</strong></p><ul><li><strong>Lokasi Podomoro Golf View Cimanggis</strong>yang sangat strategis</li><li>Tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock</li><li>Dikembangkan oleh developer terpercaya serta berpengalaman, yaitu Agung Podomoro Land</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li>Bergabungnya Universitas Gunadarma sebagai pendukung fasilitas pendidikan dalam kawasan<strong>Perumahan Podomoro Golf View</strong></li><li>30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><strong>Fasilitas yang terdapat pada Podomoro Golf View Apartemen, yaitu :</strong></p><ul><li>Shuttle Bus</li><li>Golf View 360<em>?</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li>Jogging Track</li><li>Lapangan Badminton</li><li>Area berkumpul untuk keluarga</li><li>Infinity Swimming Pool</li><li>BBQ Area</li><li>Sky Garden</li><li>Ruang Olahraga</li><li>Sauna/Jacuzzi</li><li>Minimart</li><li>Light Rapid Transit</li></ul>','available',4400,'Taman,Taman Bermain Anak,Telepon','unit-6fae022dc2ae30.jpg','PRY00003','2019-09-28 10:47:29','2019-10-02 18:54:16'),(7,'Podomoro Golf View Tipe 2 Bedroom','podomoro-golf-view-tipe-2-bedroom',2,36,36,1,1,467570000,'<p><strong>Podomoro Golf View Tipe 2 Bedroom</strong>merupakan tipe apartemen yang dilengkapi dengan 2 kamar tidur, 1 kamar mandi. Tipe ini memiliki luas bangunan 36 m2.</p><p><strong>Keunggulan dari Podomoro Golf View :</strong></p><ul><li><strong>Lokasi Podomoro Golf View Cimanggis</strong>yang sangat strategis</li><li>Tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock</li><li>Dikembangkan oleh developer terpercaya serta berpengalaman, yaitu Agung Podomoro Land</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li>Bergabungnya Universitas Gunadarma sebagai pendukung fasilitas pendidikan dalam kawasan<strong>Perumahan Podomoro Golf View</strong></li><li>30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><strong>Fasilitas yang terdapat pada Podomoro Golf View Apartemen, yaitu :</strong></p><ul><li>Shuttle Bus</li><li>Golf View 360<em>ᵒ</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li>Jogging Track</li><li>Lapangan Badminton</li><li>Area berkumpul untuk keluarga</li><li>Infinity Swimming Pool</li><li>BBQ Area</li><li>Sky Garden</li><li>Ruang Olahraga</li><li>Sauna/Jacuzzi</li><li>Minimart</li><li>Light Rapid Transit</li></ul>','available',3300,'Gym,Telepon','unit-99844d10ea7652.jpg','PRY00003','2019-10-02 19:02:20','2019-10-02 19:06:37'),(8,'Podomoro River View – Jupiter Tipe 6x12','podomoro-river-view-jupiter-tipe-6x12',1,72,45,2,1,1111850000,'<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Podomoro River View – Jupiter Tipe 6x12&nbsp;</strong><span style=\"color: rgb(68, 68, 68);\">merupakan tipe rumah 1 lantai yang dilengkapi dengan;</span></p><ul><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan 45 m2</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah 72 m2</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">2 Kamar tidur</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">1 Kamar mandi</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Ruang tamu/keluarga</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Ruang makan</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Dapur</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Halaman belakang</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lantai mezzanine (optional)</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Carport untuk 1 mobil</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Harga mulai dari Rp. 1.111.850.000</span></li></ul><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Jupiter Tipe 6x12 terdiri dari 3 tipe desain hunian, yaitu:</strong></p><ul><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Tipe Wood</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Tipe Stone</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Tipe Cutting GRC</span></li></ul><p><strong style=\"color: rgb(68, 68, 68);\">Keunggulan dari Podomoro River View:</strong></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Dikembangkan oleh developer terpercaya serta berpengalaman,&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\">Agung Podomoro Land</strong></li><li><span style=\"color: rgb(68, 68, 68);\">Lokasi yang sangat strategis, tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dibangun dengan konsep superblock dengan berbagai fasilitas penunjang yang lengkap</span></li><li><span style=\"color: rgb(68, 68, 68);\">Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</span></li><li><span style=\"color: rgb(68, 68, 68);\">Terintegrasi dengan Jalur Light Rail Transit (LRT)</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">30 menit dari Bandara Halim Perdana Kusuma</span></li></ul><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas yang terdapat pada Podomoro River View, yaitu:</strong></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Sistem satu gerbang</span></li><li><span style=\"color: rgb(68, 68, 68);\">CCTV 24 Jam</span></li><li><span style=\"color: rgb(68, 68, 68);\">Kolam renang</span></li><li><span style=\"color: rgb(68, 68, 68);\">Fitness Center</span></li><li><span style=\"color: rgb(68, 68, 68);\">Lapangan Basket</span></li><li><span style=\"color: rgb(68, 68, 68);\">Taman Bermain Anak</span></li><li><em style=\"color: rgb(68, 68, 68);\">Golf View 360o</em></li><li><em style=\"color: rgb(68, 68, 68);\">Food and Beverage Riverside</em></li><li><em style=\"color: rgb(68, 68, 68);\">Foot Reflexology</em></li><li><em style=\"color: rgb(68, 68, 68);\">Club House</em></li><li><em style=\"color: rgb(68, 68, 68);\">Linear Park &amp; Garden</em></li><li><span style=\"color: rgb(68, 68, 68);\">Area Komersial</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tempat Ibadah</span></li><li><span style=\"color: rgb(68, 68, 68);\">Pasar Modern</span></li><li class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">BBQ Area</span></li></ul>','available',3300,'Gym,Kolam Renang,Telepon,Keamanan 24 Jam,Halaman Terbuka,Taman,Taman Bermain Anak','unit-5ae150840dcb35.jpg','PRY00002','2019-10-02 19:16:09','2019-10-02 19:32:14');

/*Table structure for table `province` */

DROP TABLE IF EXISTS `province`;

CREATE TABLE `province` (
  `province_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `province_name` varchar(128) NOT NULL,
  `province_slug` varchar(128) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `province` */

insert  into `province`(`province_id`,`province_name`,`province_slug`) values (1,'Banten','banten'),(2,'Jawa Barat','jawa-barat'),(3,'DKI Jakarta','dki-jakarta');

/*Table structure for table `unit_facility` */

DROP TABLE IF EXISTS `unit_facility`;

CREATE TABLE `unit_facility` (
  `id_facility` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `facility_name` varchar(128) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id_facility`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `unit_facility` */

insert  into `unit_facility`(`id_facility`,`facility_name`,`created_at`,`updated_at`) values (1,'Pendingin Ruangan (AC)','2019-09-23 20:12:15','2019-09-23 20:12:15'),(2,'Keamanan 24 Jam','2019-09-23 20:12:15','2019-09-23 20:12:15'),(3,'Air Panas','2019-09-23 20:12:15','2019-09-23 20:12:15'),(4,'Kolam Renang','2019-09-23 20:12:15','2019-09-23 20:12:15'),(5,'Telepon','2019-09-23 20:12:15','2019-09-23 20:12:15'),(6,'Balkon','2019-09-23 20:12:15','2019-09-23 20:12:15'),(7,'Taman','2019-09-23 20:12:15','2019-09-23 20:12:15'),(8,'Taman Bermain Anak','2019-09-23 20:12:15','2019-09-23 20:12:15'),(9,'Garasi','2019-09-23 20:12:15','2019-09-23 20:12:15'),(10,'Secure Parking','2019-09-23 20:12:15','2019-09-23 20:12:15'),(11,'Gym','2019-09-23 20:12:15','2019-09-23 20:12:15'),(12,'Halaman Terbuka','2019-09-23 20:12:15','2019-09-23 20:12:15');

/*Table structure for table `verification_customer` */

DROP TABLE IF EXISTS `verification_customer`;

CREATE TABLE `verification_customer` (
  `verify_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `hash_id` varchar(128) DEFAULT NULL,
  `expire_date` varchar(32) NOT NULL,
  `status_verify` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`verify_id`),
  KEY `fk_verify_customer_idx` (`customer_id`),
  CONSTRAINT `fk_verify_customer_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `verification_customer` */

insert  into `verification_customer`(`verify_id`,`customer_id`,`hash_id`,`expire_date`,`status_verify`,`created_at`,`updated_at`) values (1,10,'NWQ5NTk2ZmQ3MWY4Yg==','1570086405','Y','2019-10-03 12:53:54','2019-10-03 13:37:54'),(2,1,'NWQ5NTk3YWU5OGY1Mw==','1570086582','Y','2019-10-03 13:39:42','2019-10-03 13:40:16');

/*Table structure for table `verification_developer` */

DROP TABLE IF EXISTS `verification_developer`;

CREATE TABLE `verification_developer` (
  `verify_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dev_user_id` int(10) unsigned NOT NULL,
  `npwp_id` varchar(17) NOT NULL,
  `sertifikat` varchar(64) NOT NULL,
  `status_verification` enum('Y','N','R') DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`verify_id`),
  KEY `fk_verify_devuser_idx` (`dev_user_id`),
  CONSTRAINT `fk_verify_devuser_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `verification_developer` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
