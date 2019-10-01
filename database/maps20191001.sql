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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`customer_email`,`customer_address`,`customer_city`,`customer_phone_number`,`customer_username`,`customer_password`,`customer_photo`,`status_verification`,`created_at`,`updated_at`) values (1,'Sony Darmawan','sonypiay@mail.com','Jl. Meruya Selatan No. 7',1,'08561969052','sonypiay','d5f3b4c238382e41fbe4b404e882cc73',NULL,'N','2019-09-27 21:19:47','2019-09-27 21:21:19');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

insert  into `log_project_request`(`log_id`,`log_message`,`request_unique_id`,`created_at`,`updated_at`) values (1,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 6','REQ00001-20190930','2019-09-30 00:42:06','2019-09-30 00:42:06'),(2,'Marketing Agency Jakarta mengundang Sony Darmawan untuk meeting.','REQ00001-20190930','2019-09-30 18:51:26','2019-09-30 18:51:26'),(3,'Marketing Agency Jakarta me-revisi jadwal undangan meeting.','REQ00001-20190930','2019-09-30 20:30:17','2019-09-30 20:30:17'),(4,'Sony Darmawan telah menerima undangan.','REQ00001-20190930','2019-09-30 21:59:12','2019-09-30 21:59:12'),(5,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ00001-20190930','2019-10-01 02:08:03','2019-10-01 02:08:03'),(6,'Developer telah me-review','REQ00001-20190930','2019-10-01 18:11:02','2019-10-01 18:11:02'),(7,'Sony Darmawan mengajukan pemesanan unit Podomoro Park Bandung Tipe 7','REQ00002-20191001','2019-10-01 18:22:56','2019-10-01 18:22:56');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

insert  into `meeting_appointment`(`meeting_id`,`meeting_time`,`meeting_status`,`request_unique_id`,`meeting_note`,`meeting_result`,`document_file`,`last_updated_by`,`created_at`,`updated_at`) values (1,'2019-10-03 10:00:00','done','REQ00001-20190930','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Park Bandung Tipe 6. Kami mengundang Anda untuk meeting sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Marketing','Meeting telah selesai dilakukan. Calon pembeli telah melengkapi form dan bersedia mengikuti perjanjian yang berlaku. Terima kasih\n\nINI SUDAH DIEDIT KETIKA SELESAI','result_flCMwqAehArvCPTaUQ6tiqkF2ctT64phdgUxGec4.pdf','Marketing Agency Jakarta','2019-09-30 18:51:26','2019-10-01 02:38:55');

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`gallery_description`,`project_unique_id`,`created_at`,`updated_at`) values (6,'oXBGYQuDxa9drfsBtVGw8jG1BcU5Z3TBroOWbiz1.jpeg',NULL,'PRY00001','2019-09-22 23:58:42','2019-09-22 23:58:42'),(8,'GI6LJNmTbc1HxHH16MMkhrHhf5UrIMu0DWJjAZFJ.jpeg',NULL,'PRY00001','2019-09-23 00:24:05','2019-09-23 00:24:05'),(9,'7hAp85CBQdIi3gjfRWUK7DCq0JxWGOu92qbDiBx5.jpeg',NULL,'PRY00001','2019-09-23 00:24:47','2019-09-23 00:24:47'),(10,'7EYltLPq8iJwzL2zBXRtOMw3kJ9wT98qvlXxGxcu.jpeg',NULL,'PRY00001','2019-09-23 00:24:58','2019-09-23 00:24:58'),(11,'dF0qeuw6r5cIdfZzl1aUYpfaheHz62QdGemi61Nu.jpeg',NULL,'PRY00001','2019-09-23 00:25:10','2019-09-23 00:25:10'),(13,'Gweoys7kDqtg8fO3p0tneiNEcgHDQSTqWvh9l66p.jpeg',NULL,'PRY00001','2019-09-23 00:25:40','2019-09-23 00:25:40'),(15,'VmIqsjAqwKJDx7lJ4NIbY5jUfEYofcKWHIpbUudS.jpeg',NULL,'PRY00002','2019-09-23 00:31:19','2019-09-23 00:31:19'),(16,'RkH8RKb9spsLVtqA1JiMaqQLovSpIajDkrANJnqp.jpeg',NULL,'PRY00002','2019-09-23 00:31:26','2019-09-23 00:31:26'),(17,'XglqAWirE7tJU37EetbxQyPbGmmeHid8Fw1Ly32f.jpeg',NULL,'PRY00002','2019-09-23 00:31:33','2019-09-23 00:31:33'),(18,'Dyp0Fv71GluOoaJQ12akxYviHVSpPBtjlZr45Dfo.jpeg',NULL,'PRY00002','2019-09-23 00:31:41','2019-09-23 00:31:41'),(19,'7t3eMacwpT3zaac1o2h0eh41lrLLqPIedubU62h3.jpeg',NULL,'PRY00002','2019-09-23 00:31:50','2019-09-23 00:31:50'),(20,'mxjkBGrC6PhPAbAQj9nr2S4JgweMrYZ6rTx9qheb.jpeg',NULL,'PRY00002','2019-09-23 00:31:57','2019-09-23 00:31:57'),(21,'q9RwHWjKgYnSr3b82x5a7AbFMFImLCieVJjxrtjZ.jpeg',NULL,'PRY00002','2019-09-23 00:32:30','2019-09-23 00:32:30'),(22,'JRxZR3JWmxourVcbA2rboDedMpiQ4pR0S7gIJKzn.jpeg',NULL,'PRY00002','2019-09-23 00:32:37','2019-09-23 00:32:37'),(23,'afKgJc1Aiyz3KJtMbhaIVMf5De5LvS5bBbWUlHk3.jpeg',NULL,'PRY00002','2019-09-23 00:32:45','2019-09-23 00:32:45'),(24,'T84G3fcFTTqxV4yij7kb8gooyPwYDdnUqvrmqmaH.jpeg',NULL,'PRY00002','2019-09-23 00:32:53','2019-09-23 00:32:53'),(25,'RF57Lo3Na2CUHdigoNDFcmn7Mq4rlWD3CztDWfLq.jpeg',NULL,'PRY00002','2019-09-23 00:33:00','2019-09-23 00:33:00'),(26,'RLCWRb3qphz7LNM3WoQMmNVhl7zP5PXI7TNCix07.jpeg',NULL,'PRY00003','2019-09-28 00:53:44','2019-09-28 00:53:44');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_unique_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_city`,`project_link_map`,`project_map_embed`,`project_site_plan`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`) values (1,'PRY00001','Podomoro Park','podomoro-park','GI6LJNmTbc1HxHH16MMkhrHhf5UrIMu0DWJjAZFJ.jpeg','Agung Podomoro Land (APL) menghadirkan mahakarya terbarunya yaitu Podomoro Park Bandung, kawasan hunian yang terletak di tengah keindahan alam Bandung Selatan, seluas lebih dari 100 hektar. Konsep utama Podomoro Park terinsiprasi dari kawasan hunian berkelas dunia, yaitu Woodbrige di Irvine California serta desain masterplan dan landscape oleh Palmscape Singapore, sehingga Podomoro Park dapat dikategorikan sebagai world class home resort.\n\nPodomoro Park telah meraih penghargaan \"The Best Premium Home Resort in West Java\" dalam event Indonesia Property & Bank Award 2018. Ini membuktikan bahwa Podomoro Park memiliki konsep kawasan terbaik dengan menghadirkan kekuatan elemen alam, dan menjadikannya kawasan hunian resort terbaik di Jawa Barat. Maka tak heran bila antusias pasar sangat tinggi untuk memiliki hunian ini, hingga Podomoro Park menerima penghargaan “Most Favoured Premium Housing Estate” dalam event Housing Estate Award 2018.','Buahbatu, Bandung',9,NULL,NULL,NULL,'residensial','available',NULL,1,'2019-09-20 21:50:40','2019-09-25 21:05:59'),(2,'PRY00002','Podomoro Park View','podomoro-park-view','7t3eMacwpT3zaac1o2h0eh41lrLLqPIedubU62h3.jpeg','Podomoro River View merupakan cluster perumahan baru di kawasan new city Podomoro Golf View yang dikembangkan oleh developer ternama dan terpercaya, Agung Podomoro Land. Didesain dengan konsep gaya hidup masa kini yang modern dan fleksibel, menghadirkan hunian dengan desain yang simple dan minimalis yang memberikan nilai lebih untuk Anda yang menginginkan hunian di kawasan kota baru yang hidup dan terintegrasi.','Cimanggis, Depok',8,NULL,NULL,NULL,'residensial','available',NULL,1,'2019-09-23 00:03:53','2019-09-25 20:30:33'),(4,'PRY00003','Test Proyek','test-proyek','RLCWRb3qphz7LNM3WoQMmNVhl7zP5PXI7TNCix07.jpeg','Grand City, Depok','Grand City, Depok',8,NULL,NULL,NULL,'apartemen','soon',2021,1,'2019-09-28 00:53:44','2019-09-28 00:55:40'),(5,'PRY00005','Test Proyek 2','test-proyek-2',NULL,'TB Simatupang','TB Simatupang',5,NULL,NULL,NULL,'apartemen','soon',2021,1,'2019-09-28 00:54:44','2019-09-28 00:55:07');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

insert  into `project_request`(`request_id`,`request_unique_id`,`dev_user_id`,`customer_id`,`unit_type_id`,`request_message`,`request_note`,`status_request`,`isReviewed`,`created_at`,`updated_at`) values (1,'REQ00001-20190930',1,1,1,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit.',NULL,'accept','Y','2019-09-30 00:42:06','2019-10-01 18:11:02'),(2,'REQ00002-20191001',1,1,4,'Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit Podomoro Park Bandung Tipe 7',NULL,'waiting_response','N','2019-10-01 18:22:56','2019-10-01 18:22:56');

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`,`created_at`,`updated_at`) values (18,'unit-1de809ea5613f7.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(19,'unit-69e79c37eec14a.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(20,'unit-690e88870062bf.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(21,'unit-b790908329d2a8.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(22,'unit-73357fe46d7e8b.jpg',1,'2019-09-25 21:01:22','2019-09-25 21:01:22'),(23,'unit-7010c42484e51d.jpg',1,'2019-09-25 21:01:29','2019-09-25 21:01:29'),(24,'unit-ea0005ce42d60f.jpg',1,'2019-09-25 21:01:42','2019-09-25 21:01:42'),(25,'unit-1de809ea5613f7.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(26,'unit-1e8407a88e77d1.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(27,'unit-5be726ce55f731.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(28,'unit-69e79c37eec14a.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(29,'unit-690e88870062bf.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(30,'unit-853dac535cb8b0.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(31,'unit-6821e98a0c7b46.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(32,'unit-b790908329d2a8.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(33,'unit-ea0005ce42d60f.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(34,'unit-1d67e734ab780e.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(35,'unit-61f1538dd37557.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(36,'unit-95d5264c076083.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(37,'unit-208610fe35a61d.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(38,'unit-b2bf6dfddee69c.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(40,'unit-c048d3937cfb44.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(41,'unit-f56b12d2f24b3e.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_unique_id`,`created_at`,`updated_at`) values (1,'Podomoro Park Bandung Tipe 6','podomoro-park-bandung-tipe-6',2,94,90,2,3,1400000000,'<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">CLUSTER AMAGRIYA (DELUXE)</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 15 meter (Nalendra):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;90 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,4 milyar</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 17 meter (Kancana):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;102 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,5 milyar</span></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas premium yang disediakan oleh Podomoro Park Bandung, yaitu :</strong></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Club House</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Taman Bermain Anak</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Bike Lane</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Kolam Renang</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Community Garden</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gym</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gazebo</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Jogging Track</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Viewing Deck</em></p>','sold',3500,'Air Panas,Balkon,Taman,Taman Bermain Anak,Telepon,Keamanan 24 Jam,Kolam Renang,Pendingin Ruangan (AC)','unit-ea0005ce42d60f.jpg','PRY00001','2019-09-24 22:13:41','2019-09-25 21:01:47'),(4,'Podomoro Park Bandung Tipe 7','podomoro-park-bandung-tipe-7',2,127,126,3,3,2000000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER AMAGRIYA (DELUXE)</strong></p><p>Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 7 x 18 meter (Sanjaya):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;126 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;127 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</p><p>Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 2 milyar</p>','available',3500,'Air Panas,Kolam Renang,Balkon,Pendingin Ruangan (AC),Telepon,Taman Bermain Anak,Keamanan 24 Jam,Taman','unit-69e79c37eec14a.jpg','PRY00001','2019-09-25 21:03:37','2019-09-25 21:05:14'),(5,'Podomoro Park Bandung Tipe 8','podomoro-park-bandung-tipe-8',2,156,160,4,3,3100000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER ANAPURI (PREMIUM)</strong></p><p class=\"ql-align-justify\">Suasana keasrian resort akan sangat terasa ketika memasuki&nbsp;<em>gate cluster</em>&nbsp;yang megah dengan dihiasi hamparan taman dengan berbagai variasi bunga indah. Hunian mewah ini memiliki desain fasad yang&nbsp;<em>elegant</em>,&nbsp;<em>carport</em>&nbsp;yang luas,&nbsp;<em>living room</em>&nbsp;yang nyaman dengan akses langsung menuju&nbsp;<em>backyard</em>, hingga kehangatan suasana akan semakin tercipta dengan adanya&nbsp;<em>collective garden</em>&nbsp;yang terdapat di sisi belakang rumah. Hunian ini memiliki akses yang sangat dekat menuju danau dan memiliki&nbsp;<em>view&nbsp;</em>yang sangat indah karena barisan pegunungan Bandung Selatan tampak jelas dihadapan.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 8 x 20 meter (Darmaraja):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;160 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;156 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4400 VA</p><p class=\"ql-align-justify\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 3,1 milyar</p><p><br></p>','available',4400,'Air Panas,Pendingin Ruangan (AC),Balkon,Kolam Renang,Taman,Taman Bermain Anak,Keamanan 24 Jam,Telepon','unit-208610fe35a61d.jpg','PRY00001','2019-09-25 21:34:51','2019-09-26 14:09:24'),(6,'Test Tipe Unit','test-tipe-unit',2,126,120,3,2,3500000000,'<p>Testing</p>','available',4400,'Air Panas,Kolam Renang,Pendingin Ruangan (AC),Taman,Taman Bermain Anak,Keamanan 24 Jam,Telepon',NULL,'PRY00003','2019-09-28 10:47:29','2019-09-28 10:47:29');

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
  `expire_date` time DEFAULT NULL,
  `status_verify` enum('Y','N') DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`verify_id`),
  KEY `fk_verify_customer_idx` (`customer_id`),
  CONSTRAINT `fk_verify_customer_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `verification_customer` */

/*Table structure for table `verification_developer` */

DROP TABLE IF EXISTS `verification_developer`;

CREATE TABLE `verification_developer` (
  `verify_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dev_user_id` int(10) unsigned NOT NULL,
  `id_card` varchar(16) NOT NULL,
  `id_npwp` varchar(16) NOT NULL,
  `document_file` varchar(64) NOT NULL,
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
