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
  `admin_password` varchar(60) NOT NULL,
  `admin_email` varchar(32) NOT NULL,
  `admin_gender` enum('L','P') NOT NULL DEFAULT 'L',
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_username` (`admin_username`),
  UNIQUE KEY `admin_email` (`admin_email`),
  UNIQUE KEY `seqid` (`seqid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `admin_owner` */

insert  into `admin_owner`(`admin_id`,`admin_fullname`,`admin_username`,`admin_password`,`admin_email`,`admin_gender`,`created_by`,`created_at`,`updated_at`,`seqid`) values ('ADM0001','Sony Darmawan','sonypiay','$2y$12$s3F4.Bp0DSTNt7HbU1S43enhY8yj.T7PwH1oNCK7fhGyZRGlBNOee','sonypiay@mail.com','L',NULL,'0000-00-00 00:00:00','2019-10-09 15:51:28',1),('ADM0002','Himawan Achmadi','himawan','$2y$12$xuzsq3.AG5fyIkHIp6ZUm.psZ9adGhxlCdPNQEcWoSS7a5Yaynl4S','himawanachmadi@gmail.com','L','Sony Darmawan','2019-10-09 15:49:46','2019-10-09 15:49:46',2),('ADM0003','Agus Riandi','agus_riandi','$2y$12$k/9Osh56yoJ1/DvJWshMo.mUtz/eAmJZCCqpGx7fp31zGby6tZfjS','agusrndi@gmail.com','L','Sony Darmawan','2019-10-09 15:50:23','2019-10-09 15:50:23',3),('ADM0004','Administrator','admin','$2y$12$QMbLPhAMPUn56IPcvmt8c.ToWw4KUyGO188/X1iId2z6JY0eAppIC','pyscho30@gmail.com','L','Sony Darmawan','2019-10-09 15:52:00','2019-10-09 15:52:00',4);

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

insert  into `city`(`city_id`,`city_name`,`province_id`) values ('BGD','Bandung','JB'),('BGR','Bogor','JB'),('BKS','Bekasi','JB'),('CBN','Cirebon','JB'),('DPK','Depok','JB'),('JKB','Jakarta Barat','JK'),('JKP','Jakarta Pusat','JK'),('KWG','Karawang','JB'),('SRG','Serang','BT'),('TNG','Tangerang','BT'),('TSM','Tasikmalaya','JB');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` varchar(14) NOT NULL,
  `customer_name` varchar(64) NOT NULL,
  `customer_email` varchar(64) NOT NULL,
  `customer_address` text DEFAULT NULL,
  `customer_phone_number` varchar(16) NOT NULL,
  `customer_username` varchar(32) NOT NULL,
  `customer_password` varchar(60) NOT NULL,
  `customer_photo` varchar(50) DEFAULT NULL,
  `city_id` char(3) DEFAULT NULL,
  `status_verification` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_email` (`customer_email`),
  UNIQUE KEY `customer_username` (`customer_username`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_customer_city_id` (`city_id`),
  CONSTRAINT `fk_customer_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`customer_email`,`customer_address`,`customer_phone_number`,`customer_username`,`customer_password`,`customer_photo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('CUST0001','Sony Darmawan','sonypiay@mail.com','Jl. Intan Baiduri No. 28','08561969052','sonypiay','$2y$12$q2mcbtimnqFFUKSBcVViX.0MeX7j2kEBmaMpEkx8SwEsoZiPi7G3O','o7rXFSKErnKq8klnbqWaSZhvjody9Gd2mWjw0oob.jpeg','JKP','Y','2019-10-09 16:33:28','2019-10-09 16:41:10',1),('CUST0002','Rizqy Caesario','rizqycaesario@gmail.com','Tambora, Jakarta Barat','08998888','rizqycaesario','$2y$12$cP/TJagZ45itZ6Wksb8N4.w9ZSbHi42fOvi9Dvs4fBiw366hXhdT6','dNMJvMfDM5tF3N00q91lbbJbgW3pBpl3V7QZvSpb.jpeg','JKB','Y','2019-10-09 16:46:58','2019-10-10 23:31:30',2),('CUST0003','Nanami Okuhara','nanami.oku@gmail.com','Jl. Biznet Technovillage','08561969052','nanami','$2y$12$fLjT2vbCQExxM67H6vvw0eXfSGaAthz7XrPKgjKAml6EvhPYf86qa','P0e4h9q2dniXQvTJdyojUEB3jlYAK030zOinQbff.jpeg','DPK','Y','2019-10-10 23:36:32','2019-10-10 23:38:40',3),('CUST0004','John Doe','johndoe@example.com',NULL,'','johndoe','$2y$12$vgI4LbyDHnpXusjWwbr8FeDo6RiATxIj.7AaHj3R/xSu40sZpVt8e',NULL,'JKP','N','2019-10-15 14:38:06','2019-10-15 14:41:17',4),('CUST0005','Jane Doe','janedoe@example.com',NULL,'08561969052','janedoe','$2y$12$tDS7xVqTW0iHTbXlD79DsOHE3Y70LgRJfb1Ue0V.hkjiaUGjDq1WW',NULL,'JKP','N','2019-10-15 14:38:51','2019-10-15 23:30:44',5),('CUST0006','Velvet Crowe','velvet@example.com',NULL,'08561969052','velvet','$2y$12$I.c7.t/i50sAmNQTIwG3hutr4I7ZIeX2KJnvyCQGMMsrDT8fRul.K',NULL,'JKP','N','2019-10-15 23:05:38','2019-10-15 23:13:30',6);

/*Table structure for table `developer_user` */

DROP TABLE IF EXISTS `developer_user`;

CREATE TABLE `developer_user` (
  `dev_user_id` varchar(13) NOT NULL,
  `dev_name` varchar(32) NOT NULL,
  `dev_ownername` varchar(32) NOT NULL,
  `dev_slug` text NOT NULL,
  `dev_address` text DEFAULT NULL,
  `dev_username` varchar(32) NOT NULL,
  `dev_password` varchar(60) NOT NULL,
  `dev_email` varchar(64) NOT NULL,
  `dev_biography` text DEFAULT NULL,
  `dev_phone_office` varchar(16) DEFAULT NULL,
  `dev_mobile_phone` varchar(16) DEFAULT NULL,
  `dev_logo` varchar(50) DEFAULT NULL,
  `city_id` char(3) DEFAULT NULL,
  `status_verification` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`dev_user_id`),
  UNIQUE KEY `dev_username` (`dev_username`),
  UNIQUE KEY `dev_email` (`dev_email`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_dev_city_idx` (`city_id`),
  CONSTRAINT `fk_dev_city_idx` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_logo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('DEV0001','PT Agung Podomoro Land Tbk','John Doe','pt-agung-podomoro-land-tbk','APL Tower 43rd Floor, Podomoro City\nJl. Let. Jend. S. Parman Kav. 28\nJakarta 11470 Indonesia\nwww.agungpodomoroland.com','podomoro','$2y$12$WpZeMVZo7G1VvB6E/bHoyOcyxg892PAtVKtT1PKJpKK37jG6/mWri','podomoro@agungpodomoro.com','PT Agung Podomoro Land Tbk. (APLN) is a leading integrated diversified real estate owner, developer and manager in the retail, commercial, and residential real estate segments with diversified holdings. We have an integrated property development model, from land acquisition and/or sourcing, to design and development, to project management, sales, commercial leasing and marketing, to the operation and management of our superblock developments, shopping malls, offices, hotels, and residential apartments and houses. We are known as a pioneer of the superblock development. Our high quality landmark projects, to name a few are Podomoro City, Kuningan City, and Senayan City.\n\nAPLN was established on July 30, 2004 under the name PT Tiara Metropolitan Jaya. In 2010, our shareholders completed a corporate restructuring, pursuant to which six developments and their holding companies were transferred to our control. APLN, is the flagship listed entity (IDX:APLN) of Agung Podomoro Group (APG), is one of the fastest growing and largest real estate developers in Indonesia with interests in superblocks, retail properties, office, apartments and residential, and hotels. APG established its first development, a housing complex in Simprug area, South Jakarta, in 1969 and completed its construction in 1973. From 1973 to present, members of APG completed or begun construction of more than 70 property projects, with majority addressed to middle class segments of society, with projects ranging from low cost apartments to high end apartments in South Jakarta, landed residentials, high end and the neighborhood mall, shop houses, hotels, soho and office towers.\n\nAPLN combines a visionary approach to design with an emphasis on rapid execution and time to market. Drawing on the experience and resources of the Agung Podomoro Group, we have been responsible for bringing a number of landmark properties on the market such as our flagship Podomoro City Complex and the high profile Senayan City. We also pioneered the superblock concept, bringing together residential, retail, leisure and office space within one integrated high rise development complex to create a pleasant and extremely convenient urban living space, with both sale and lease components.\n\nOur superblocks provide consumers with an alternate way of living through our one-stop-living high quality Superblock developments, which offer the possibility for a balanced and pleasant urban lifestyle to thousands of consumers.\n\nCapitalizing on our network and good brand name, our strong and experienced marketing team is typically able to generate strong advance interest for cash generation through sales, deposits, and installments. We also pay close attention to the mix of revenues streams coming from sales versus recurring revenues.','622129034567',NULL,'O3cnoxGj1bNyCg7EoBCuRFQbgODhi1wLOMiUMT8C.png','JKB','N','2019-10-09 17:21:18','2019-10-09 17:31:40',1),('DEV0002','Sharia Land','Sharia Land','sharia-land','Jl. Daarul Quran Blok C9-10 Kel. Loji, Kec. Bogor Barat, Kota Bogor','sharia_land','$2y$12$z8ztWOTUnjjMS/ikmXV0xePgHZDCwW1sbFae1U6b30A6UUiHM7wDe','grahameruya@gmail.com','Sharia Land – Developer Property Syariah\n\nSharia Land adalah perusahaan yang bergerak di bidang property, khususnya property syariah. Dimana property syariah itu sendiri adalah skema kepemilikan rumah tanpa Riba dan tanpa bank.\n\nSalah satu tujuan Sharia Land hadir di Indonesia adalah agar umat Muslim di Indonesia memiliki pilihan untuk mendapatkan rumah Syariah penuh keberkahan dan tidak lagi terjebak dalam jerat transaksi Ribawi yang sangat menjerumuskan dan juga mengerikan dosanya.\n\nTujuan selanjutnya adalah, Sharia Land ingin menjadi solusi permasalahan umat muslim saat ini yang cukup nyata namun jarang kita sadari bersama.\nYaitu masalah pengangguran, kemiskinan, dan ketidakberdayaan.\nBukan hanya menjadi solusi untuk kepemilikan rumah tanpa riba dengan segala fasilitas unggulan di dalamnya, namun Sharia Land juga mempunyai impian untuk menjadi alternatif solusi untuk kemandirian umat. Terutama di bidang Ekonomi.','+622131103838','08561969052','jSfNarF3OH8VNO0MWFXyobn78uLFNSRSUhdrfYKy.png','BGR','Y','2019-10-09 23:10:44','2019-10-15 21:13:55',2),('DEV0003','PT Abi Properti Syariah','Abi Ainun Najib','pt-abi-properti-syariah',NULL,'abi_developer','$2y$12$qT34ccf2tLV0BtDQR82cfOlXvEULtG5J6r5W65VbIvs5U/GdUG3dG','abi_dev@example.com','Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.\n\nSekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.\n\nSegawon nyukani ulem-ulem cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.',NULL,NULL,NULL,'BGR','Y','2019-10-15 14:43:51','2019-10-15 22:35:39',3),('DEV0004','PT Ummi Developer','PT Ummi Developer','pt-ummi-developer',NULL,'ummi_developer','$2y$12$ZCm/BvTQ8gw1J4TB.tnab.zqRRsu6LivQM32SjEB/TMHlbolYgBCq','ummi_developer@example.com','Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.\n\nSekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.\n\nSegawon nyukani ulem-ulem cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.','021481912091','08561969052',NULL,'BGR','Y','2019-10-15 14:49:10','2019-10-15 22:36:40',4);

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

insert  into `log_project_request`(`log_id`,`log_message`,`request_id`,`log_date`) values (32,'Sony Darmawan mengajukan pemesanan unit Rumah Sharia Tipe 2','REQ201910110001','2019-10-11 22:46:08'),(33,'Marketing Sharia Land mengundang Sony Darmawan untuk meeting & survey lokasi bersama.','REQ201910110001','2019-10-12 08:48:11'),(34,'Sony Darmawan telah menerima undangan meeting.','REQ201910110001','2019-10-12 08:51:26'),(35,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910110001','2019-10-12 08:59:05'),(36,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910110001','2019-10-12 09:31:36'),(37,'Rizqy Caesario mengajukan pemesanan unit Rumah Sharia Tipe 1','REQ201910120009','2019-10-12 10:32:09'),(38,'Marketing Sharia Land mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910120009','2019-10-12 10:33:19'),(39,'Rizqy Caesario telah menerima undangan meeting.','REQ201910120009','2019-10-12 10:33:51'),(40,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910120009','2019-10-12 10:36:45'),(41,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910120009','2019-10-12 10:38:55'),(42,'Velvet Crowe mengajukan pemesanan unit Ummi Residence Tipe 1','REQ201910150010','2019-10-15 23:06:49'),(43,'Rizqy Caesario mengajukan pemesanan unit Ummi Residence Tipe 3','REQ201910150011','2019-10-15 23:12:12'),(44,'Ummi Marketing mengundang Velvet Crowe untuk meeting & survey lokasi bersama.','REQ201910150010','2019-10-15 23:15:18'),(45,'Ummi Marketing mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910150011','2019-10-15 23:15:45'),(46,'Velvet Crowe telah menerima undangan meeting.','REQ201910150010','2019-10-15 23:16:33'),(47,'Rizqy Caesario telah menerima undangan meeting.','REQ201910150011','2019-10-15 23:17:09'),(48,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910150011','2019-10-15 23:27:26'),(49,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910150010','2019-10-15 23:28:24'),(50,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910150011','2019-10-15 23:29:43'),(51,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910150010','2019-10-15 23:29:48'),(52,'Jane Doe mengajukan pemesanan unit Ummi Residence Tipe 2','REQ201910150012','2019-10-15 23:31:07'),(53,'Ummi Marketing mengundang Jane Doe untuk meeting & survey lokasi bersama.','REQ201910150012','2019-10-15 23:32:27'),(54,'Jane Doe telah menerima undangan meeting.','REQ201910150012','2019-10-15 23:33:01'),(55,'John Doe mengajukan pemesanan unit Podomoro Golf View Tipe 2 Bedroom','REQ201910150013','2019-10-15 23:34:20'),(56,'Marketing Gallery Head Office mengundang John Doe untuk meeting & survey lokasi bersama.','REQ201910150013','2019-10-15 23:35:31'),(57,'Velvet Crowe mengajukan pemesanan unit Podomoro Golf View Tipe Studio','REQ201910150014','2019-10-15 23:36:07');

/*Table structure for table `marketing_user` */

DROP TABLE IF EXISTS `marketing_user`;

CREATE TABLE `marketing_user` (
  `mkt_user_id` varchar(13) NOT NULL,
  `mkt_fullname` varchar(40) NOT NULL,
  `mkt_email` varchar(64) NOT NULL,
  `mkt_username` varchar(32) NOT NULL,
  `mkt_password` varchar(60) NOT NULL,
  `mkt_phone_number` varchar(16) DEFAULT NULL,
  `mkt_mobile_phone` varchar(16) DEFAULT NULL,
  `mkt_address` text DEFAULT NULL,
  `mkt_profile_photo` varchar(50) DEFAULT NULL,
  `dev_user_id` varchar(13) NOT NULL,
  `city_id` char(3) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`mkt_user_id`),
  UNIQUE KEY `mkt_username` (`mkt_username`),
  UNIQUE KEY `mkt_email` (`mkt_email`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_dev_user_idx` (`dev_user_id`),
  KEY `fk_mkt_city_idx` (`city_id`),
  CONSTRAINT `fk_dev_user_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mkt_city_idx` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `marketing_user` */

insert  into `marketing_user`(`mkt_user_id`,`mkt_fullname`,`mkt_email`,`mkt_username`,`mkt_password`,`mkt_phone_number`,`mkt_mobile_phone`,`mkt_address`,`mkt_profile_photo`,`dev_user_id`,`city_id`,`created_at`,`updated_at`,`seqid`) values ('MKT0001','Marketing Gallery Head Office','mkt.ho@agungpodomoroland.com','mkt_podomoro','$2y$12$LwmE7HeGAp38pOQx4VgFsOUF3dAwTZ3uDXDRLgcsD.BLtGXfsbFNe','02150088938','08561927949489','APL Tower 43rd Floor, Podomoro City Jl. Let. Jend. S. Parman Kav. 28 Jakarta 11470',NULL,'DEV0001','JKB','2019-10-09 23:26:17','2019-10-09 23:41:31',1),('MKT0002','Marketing Sharia Land','mkt_graha_meruya@grahameruya.com','mkt_sharia_land','$2y$12$e.vUrlk.AH8twNStlGo1DuGWsoPbfd7KUckYYCvxT0WiJctfBhQsm','02150088999','089898888',NULL,'wREP7AIValBbXa2hu1p345Srfkz52qNkzSZaYnAc.jpeg','DEV0002','BGR','2019-10-10 16:14:46','2019-10-11 22:04:28',2),('MKT0008','Ummi Marketing','ummi_marketing@example.com','ummi_marketing','$2y$12$yBomEnMttF8ssMS7POsNeuwrAIEnKbt4ZCrJlMnREuu8/4fRDCG1a','021482382736','0856195012987','Bogor',NULL,'DEV0004','BGR','2019-10-15 23:10:09','2019-10-15 23:10:09',3);

/*Table structure for table `meeting_appointment` */

DROP TABLE IF EXISTS `meeting_appointment`;

CREATE TABLE `meeting_appointment` (
  `meeting_id` varchar(17) NOT NULL,
  `meeting_time` datetime NOT NULL,
  `meeting_status` enum('waiting_confirmation','accept','reject','revision','cancel','done') NOT NULL DEFAULT 'waiting_confirmation',
  `request_id` varchar(18) NOT NULL,
  `meeting_note` tinytext DEFAULT NULL,
  `meeting_result` text DEFAULT NULL,
  `document_file` varchar(60) DEFAULT NULL,
  `created_by` varchar(40) NOT NULL,
  `updated_by` varchar(40) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`meeting_id`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_meeting_request_idx` (`request_id`),
  CONSTRAINT `fk_meeting_request_idx` FOREIGN KEY (`request_id`) REFERENCES `project_request` (`request_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

insert  into `meeting_appointment`(`meeting_id`,`meeting_time`,`meeting_status`,`request_id`,`meeting_note`,`meeting_result`,`document_file`,`created_by`,`updated_by`,`created_at`,`updated_at`,`seqid`) values ('MEETING1910120001','2019-10-12 09:00:00','done','REQ201910110001','Terima kasih atas ketertarikan Anda untuk membeli properti Rumah Sharia Tipe 2. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilakukan','result_6hpirKO9ZSE4joOmxYy2WIb8JXptlBHsWZa06mMg.pdf','Marketing Sharia Land','Marketing Sharia Land','2019-10-12 08:48:11','2019-10-12 08:59:05',6),('MEETING1910120007','2019-10-13 10:00:00','done','REQ201910120009','Terima kasih atas ketertarikan Anda untuk membeli properti Rumah Sharia Tipe 1. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing Sharia Land','Meeting telah selesai dilaksanakan.','result_2EdCnw6PN7hFLcifdP85ebP3xa3ZQZnpKZoO4iDd.pdf','Marketing Sharia Land','Marketing Sharia Land','2019-10-12 10:33:18','2019-10-12 10:36:45',7),('MEETING1910150008','2019-10-16 12:00:00','done','REQ201910150010','Terima kasih atas ketertarikan Anda untuk membeli properti Ummi Residence Tipe 1. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilaksanakan. Calon pembeli telah melengkapi persyaratan','result_IKUynx8rzvpDaxsTJGOw9J7vedgwMYKVAjIrQRBw.pdf','Ummi Marketing','Ummi Marketing','2019-10-15 23:15:18','2019-10-15 23:28:24',8),('MEETING1910150009','2019-10-17 10:00:00','done','REQ201910150011','Terima kasih atas ketertarikan Anda untuk membeli properti Ummi Residence Tipe 3. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilakukan. Calon pembeli telah melengkapi persyaratan','result_VtoUl06ilwXJ5Fwh2nF2bM95n1VLmjsvBJy0aHmd.pdf','Ummi Marketing','Ummi Marketing','2019-10-15 23:15:44','2019-10-15 23:27:25',9),('MEETING1910150010','2019-10-19 09:00:00','accept','REQ201910150012','Terima kasih atas ketertarikan Anda untuk membeli properti Ummi Residence Tipe 2. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing',NULL,NULL,'Ummi Marketing','Ummi Marketing','2019-10-15 23:32:27','2019-10-15 23:33:01',10),('MEETING1910150011','2019-10-17 12:00:00','waiting_confirmation','REQ201910150013','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Golf View Tipe 2 Bedroom. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing',NULL,NULL,'Marketing Gallery Head Office','Marketing Gallery Head Office','2019-10-15 23:35:31','2019-10-15 23:35:31',11);

/*Table structure for table `price_installment` */

DROP TABLE IF EXISTS `price_installment`;

CREATE TABLE `price_installment` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `unit_type_id` varchar(8) NOT NULL,
  `dp_price` int(10) unsigned NOT NULL,
  `installment_price` int(10) unsigned NOT NULL,
  `installment_tenor` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_installment_unit` (`unit_type_id`),
  CONSTRAINT `fk_installment_unit` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `price_installment` */

insert  into `price_installment`(`id`,`unit_type_id`,`dp_price`,`installment_price`,`installment_tenor`) values (5,'UNIT0001',50000000,4535416,24),(6,'UNIT0001',30000000,7158333,18),(7,'UNIT0001',100000000,4904166,12),(8,'UNIT0009',37500000,5953625,16),(9,'UNIT0009',43250000,3729500,24),(10,'UNIT0010',34500000,4560000,36),(11,'UNIT0010',48500000,5350000,24),(12,'UNIT0010',56400000,3850000,29),(13,'UNIT0011',150000000,5580000,36),(14,'UNIT0011',120000000,4580000,48),(15,'UNIT0012',350000000,7780000,48),(16,'UNIT0012',250000000,6850000,64),(17,'UNIT0013',100000000,5850000,26),(18,'UNIT0013',185000000,2850000,36),(19,'UNIT0014',167000000,5358000,48),(20,'UNIT0014',185000000,6750000,36);

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(50) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`project_id`) values (11,'H1RMhIxvpLFEFCgH5UOFk01bFLjUdQc3c8K5TA8P.jpeg','PRY0001'),(12,'fLCUD9YIDdg0EQUbaT7Y0QoMOvRYilyEqOeTYaYQ.jpeg','PRY0001'),(13,'b3UePYkaleu3qzpv83yUPLBBlxZ1xkjHN2gMBHAO.jpeg','PRY0001'),(14,'pFE2Umi82RNQ1FENBOPp1LipKOwsvq2hnccnqBXe.jpeg','PRY0001'),(15,'heGMbkRkVLFNoe2fA3ufHYAkRPppFpD5Dj0c2jId.jpeg','PRY0001'),(16,'nlI7ctQPaqYvKAsBnaRzjVAnPc9t1kAXT5eilJPv.jpeg','PRY0001'),(17,'4SmVbLGXFekwG4dc0Z5n0mp9gWcOkQxev6edJFtg.jpeg','PRY0007'),(18,'WKF2tfXQdXunVuHYXFQ45GwO7Y2bJKM781dgrS8F.jpeg','PRY0007'),(19,'XzAFZNZ7mhvjsxhDxZgTSWXxAgawNAzJKV24Ohw3.jpeg','PRY0007'),(20,'EALosU2hGu1VVyRco3h7J58zwlik0nkZzERi145k.jpeg','PRY0008');

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
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_project_dev_idx` (`dev_user_id`),
  KEY `fk_project_list_city_idx` (`city_id`),
  CONSTRAINT `fk_project_dev_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_list_city_idx` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_link_map`,`project_map_embed`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`,`city_id`,`seqid`) values ('PRY0001','Sharia Islamic Residence','sharia-islamic-residence','pFE2Umi82RNQ1FENBOPp1LipKOwsvq2hnccnqBXe.jpeg','<p>Tanah Kavling Yang Strategis dan Nyaman Untuk Tempat Tinggal Keluarga Anda</p><p>Mengingat lokasi&nbsp;Setu Bekasi&nbsp;sangat dekat sekali dengan kawasan industri MM 2100, Jababeka, Lippo Cikarang, Hyundai Comercial Estate, dll tentu akan diuntungkan dengan cepatnya pembangunan infrastruktur. Seperti : Tol Cimanggis – Cibitung (operating 2019), Tol layang Jakarta – Cikampek, Tol Cibitung -Cilincing (constructing 2018), LRT Bekasi Timur – Cikarang (constructing 2019).</p><p>Dengan banyaknya pembangunan infrastruktur yang di gagas pemerintah, akan semakin memudahkan penghuni<strong>&nbsp;</strong>untuk melakukan mobilisasi menuju pusat kota dan ibu kota Jakarta. Semakin lengkaplah hunian impian Anda selama ini.&nbsp;Dengan berbagai macam kemudahan dan lingkungan yang masih asri.</p>','Cikarang, Bekasi','https://goo.gl/maps/4WsqnkM8szCxR2xH6','<iframe src=\"https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15860.805823078828!2d107.020085!3d-6.3679697!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x375d548270d28b7b!2sSharia%20Islamic%20Residence!5e0!3m2!1sid!2sid!4v1570790050556!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','residensial','sold',NULL,'DEV0002','2019-10-11 17:10:36','2019-10-14 21:26:09','BKS',6),('PRY0007','Podomoro  Golf View','podomoro-golf-view','4SmVbLGXFekwG4dc0Z5n0mp9gWcOkQxev6edJFtg.jpeg','<p class=\"ql-align-justify\">Agung Podomoro Land sebagai salah satu pengembang terbesar dan terdepan di Indonesia mempersembahkan Podomoro Golf View, sebuah kawasan hunian&nbsp;terpadu di Depok dan Bogor dengan mengusung konsep&nbsp;<em>“Smart and affordable living in harmony”&nbsp;</em>.</p><p class=\"ql-align-justify\">Lewat pengembang PT GRAHA TUNAS SELARAS,&nbsp;Podomoro Golf View akan dibangun pada lahan seluas 60 hektar. Dengan mengutamakan efisiensi, rencananya Podomoro Golf view akan terintegrasi dengan sarana transportasi massal LRT (<em>Light Rail Transit</em>)&nbsp;hal tersebut ditujukan untuk mengedukasi masyarakat mengenai gaya hidup modern yang efisien serta dapat membantu mengurangi kemacetan yang selama ini menjadi masalah utama ibukota Jakarta. Selain itu Podomoro Golf View hanya berjarak 100m dari exit tol Cimanggis.</p><p class=\"ql-align-justify\">Podomoro Golf View adalah hunian yang di kelilingi oleh 360ᵒ&nbsp;<em>Golf View&nbsp;</em>dan berbatasan dengan aliran sungai Cikeas. Udara segar dan nuansa hijau padang golf sangat kental dan menjadi salah satu nilai tambah Podomoro Golf View. Pada sisi yang dilewati aliran sungai cikeas, akan dikembangkan “thematic F&amp;B Riverside”, suatu area wisata kuliner yang menyuguhkan suasana seperti di San Antonio , Amerika Serikat atau Clarke Quay, Singapore. Di lokasi sekitar sungai akan difasilitasi kafe-kafe tempat pengunjung menikmati makanan dan suasana sungai yang nyaman. Selain itu PGV dilengkapi berbagai&nbsp;fasiltas eksternal yang eksklusif&nbsp;seperti&nbsp;shuttle bus, area komersial, tempat ibadah, pasar modern, jogging track, lapangan badminton, children playground, serta taman dan area berkumpul bagi keluarga. Podomoro Golf View juga memikirkan area edukasi bagi penghuninya, maka akan dibangun sarana pendidikan Kolese Kanisius Jakarta&nbsp;(TK s/d SMA) yang akan dikembangkan dengan luas 20 Ha.</p><p class=\"ql-align-justify\">Segala aspek kebutuhan hidup, baik transportasi, pendidikan, rekreasi dan entertainment dikemas dalam suatu keharmonisan kawasan hunian.</p><p class=\"ql-align-justify\">Kawasan Cimanggis sendiri dipilih oleh Agung podomoro Land untuk menjadi lokasi Podomoro Golf View bukanlah kawasan sembarangan. Kawasan Cimanggis merupakan kawasan potensial yg memiliki prospek yang sangat cerah, harga dikawasan ini masih sangat terjangkau. Berdasarkan riset yang dilakukan Agung Podomoro land, jarak Cimanggis ke Jakarta masih lebih dekat dibandingkan dengan apartemen di daerah berkembang lainnya seputar Jakarta. Apartemen di Sentul dengan jarak ± 35Km dari Jakarta dengan harga Rp. 10-13 Juta/ m², Apartemen di Bogor ± 46Km dari Jakarta dengan harga Rp. 10-14 Juta/ m², Apartemen di Bekasi Cikarang ± 20Km dari Jakarta dengan harga Rp. 13-15 Juta/ m², Apartemen di Tangerang Serpong ± 35Km dari Jakarta dengan harga Rp. 17-20 Juta/m² sedangkan Podomoro Golf View memberikan harga yang sangat terjangkau dengan harga Rp. 9.4 Juta/m².</p><p class=\"ql-align-justify\">Dengan harga yang sangat terjangkau didukung oleh segala fasilitas dan kemudahan hidup menjadikan Podomoro Golf View sebuah&nbsp;<em>Smart Invesment</em>&nbsp;yang sangat menjanjikan.</p><p><strong style=\"color: rgb(68, 68, 68);\"><em>Podomoro Golf View, Smart and affordable living in harmony</em></strong></p>','JL. Bojong Nangka, Gunung Putri, Bogor','https://www.google.com/maps/d/viewer?mid=zxIATApiNpSk.kduLxZQmn8h0','<iframe src=\"https://www.google.com/maps/d/embed?mid=1yxZkHDt3ouCgwKwrvo1RAqTM024\" width=\"640\" height=\"480\"></iframe>','residensial','available',NULL,'DEV0001','2019-10-15 21:54:10','2019-10-15 21:54:10','BGR',7),('PRY0008','Ummi Residence','ummi-residence','EALosU2hGu1VVyRco3h7J58zwlik0nkZzERi145k.jpeg','<p>Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</p><p><br></p><p>Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</p><p><br></p><p>Segawon <a href=\"http://sikatsuket.blogspot.com/\" rel=\"noopener noreferrer\" target=\"_blank\">nyukani ulem-ulem</a> cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.</p>','Cimanggis, Depok',NULL,NULL,'residensial','available',NULL,'DEV0004','2019-10-15 22:39:01','2019-10-15 22:39:18','BGR',8);

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
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `installment` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_req_unit_type_idx` (`unit_type_id`),
  KEY `fk_req_cust_idx` (`customer_id`),
  KEY `fk_req_dev_user_idx` (`dev_user_id`),
  KEY `fk_request_installment` (`installment`),
  CONSTRAINT `fk_req_cust_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_dev_user_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_request_installment` FOREIGN KEY (`installment`) REFERENCES `price_installment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

insert  into `project_request`(`request_id`,`dev_user_id`,`customer_id`,`unit_type_id`,`request_message`,`status_request`,`isReviewed`,`created_at`,`updated_at`,`seqid`,`installment`) values ('REQ201910110001','DEV0002','CUST0001','UNIT0009','Halo Sharia Land, saya ingin mengajukan pemesenan unit Rumah Sharia Tipe 2.','accept','Y','2019-10-11 22:46:08','2019-10-12 09:31:36',8,9),('REQ201910120009','DEV0002','CUST0002','UNIT0001','Halo Sharia Land, saya ingin mengajukan pemesenan unit Rumah Sharia Tipe 1.','accept','Y','2019-10-12 10:32:08','2019-10-12 10:38:54',9,7),('REQ201910150010','DEV0004','CUST0006','UNIT0010','Halo PT Ummi Developer, saya ingin mengajukan pemesenan unit Ummi Residence Tipe 1.','accept','Y','2019-10-15 23:06:49','2019-10-15 23:29:48',10,10),('REQ201910150011','DEV0004','CUST0002','UNIT0012','Halo PT Ummi Developer, saya ingin mengajukan pemesenan unit Ummi Residence Tipe 3.','accept','Y','2019-10-15 23:12:12','2019-10-15 23:29:43',11,15),('REQ201910150012','DEV0004','CUST0005','UNIT0011','Halo PT Ummi Developer, saya ingin mengajukan pemesenan unit Ummi Residence Tipe 2.','meeting','N','2019-10-15 23:31:07','2019-10-15 23:32:27',12,13),('REQ201910150013','DEV0001','CUST0004','UNIT0014','Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit Podomoro Golf View Tipe 2 Bedroom.','meeting','N','2019-10-15 23:34:20','2019-10-15 23:35:31',13,20),('REQ201910150014','DEV0001','CUST0006','UNIT0013','Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit Podomoro Golf View Tipe Studio.','waiting_response','N','2019-10-15 23:36:07','2019-10-15 23:36:07',14,18);

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(60) NOT NULL,
  `unit_type_id` varchar(8) NOT NULL,
  PRIMARY KEY (`unit_gallery_id`),
  KEY `fk_unit_gallery_unit_type_idx` (`unit_type_id`),
  CONSTRAINT `fk_unit_gallery_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`) values (78,'unit-S1XfoNME0tdIairHqsgIyQWrpWZ4llbLPhu6fLdf.jpeg','UNIT0001'),(79,'unit-6HggPNknJmjFDBBiWtzfpcRvn6QUCil4jkc3w1oc.jpeg','UNIT0001'),(80,'unit-PYnNu2YnO68MGpXwhuEOJB081nWWUwFRKft5vgon.jpeg','UNIT0001'),(81,'unit-bt3ECrAXWIFdzhBPYwon5HTrMhixlozXxedvxu6i.jpeg','UNIT0001'),(82,'unit-k9yawXMBkpp3HB67QMIAY6H7p0BBx8kcWoQxoBG0.jpeg','UNIT0001'),(83,'unit-RPpPkQMGf9qg11ikaVHt9Lw7mumxlou815RUiEIM.jpeg','UNIT0001'),(84,'unit-U5ZXonc9gSNGDMMavRbhwqoFtOzVVYyItTmNFyLi.jpeg','UNIT0001'),(85,'unit-3ICbDqL8tcb6oPRXBWeQEk282BAhoHoPJLGIccaN.jpeg','UNIT0001'),(86,'unit-GtGboMey0JhWq0bf2dCA9AyyXf3HrJZFgzNjPT9X.jpeg','UNIT0009'),(87,'unit-Vi91qfJjY3FlPgtAQoI7xzqt6hzSXOskwZZx0IEm.jpeg','UNIT0009'),(88,'unit-Ev0cfhWgFP8eoB1gR4QKcmaKhEky8m7Q2HBjlmGR.jpeg','UNIT0009'),(89,'unit-mNHj9cvieRKNsJuQ17vwZ8jjNtXe3lsjDkuZs3wb.jpeg','UNIT0009'),(90,'unit-X9VGBGrtbeiyQ3F8qoEJdqL6VI3Bl0UOfldQOLc7.jpeg','UNIT0013'),(91,'unit-qXFZ0Uboys1dC8lgMp1Ikrm0cqjgkiLbUD1RMtfB.jpeg','UNIT0013'),(92,'unit-SZmGo13I8BOGLqZoMGjfCPMbSQSZvjCSRwwTKr7Y.jpeg','UNIT0013'),(93,'unit-Xil5EHMvTG8QlBAdsjKOUPLDsxKhTf3RVWyOcQjJ.jpeg','UNIT0013'),(94,'unit-JH9hh7NyXwmka3bF2L0gsrf8q68uB5ureMerHRCr.jpeg','UNIT0013'),(95,'unit-C8uG7vvxJ5iVknEjl1immXCz8STTkK1kE2BHccya.jpeg','UNIT0013'),(96,'unit-uu5QFUajGjnQZPI0ymB2XJ5b2pnItLCxGdiB12Ub.jpeg','UNIT0013'),(97,'unit-hi9aCbNxeN2GdzOOSZOaxMNbshU06sBBV4BEXvCM.jpeg','UNIT0013'),(98,'unit-1icWxuqAbXo6lUQQTCDvHp26KX6Sf1OFrwgcp9Xq.jpeg','UNIT0013'),(99,'unit-MkaARLrAjtiTBBxwc2NDGZizzCtEpNs24C18RH9k.jpeg','UNIT0013'),(100,'unit-TfZy5cGtTetUHuT4VbygMTc4WXuIOcwVuDd6ZHx7.jpeg','UNIT0013'),(101,'unit-DYaPVTvq5txxEeIPSR8fBEVImNB7Pdqm2hXrEqNm.jpeg','UNIT0013'),(102,'unit-T5x7ErOmAN6OuM2CyaUSgp7xKorsXu9e0duXb0uY.jpeg','UNIT0013'),(103,'unit-VEx52ep3JQaGkAShuFQYitWEtO7AAFHnueAZljDo.jpeg','UNIT0014'),(104,'unit-QsE7S8WKvJT7nSmHXd8yvGaTCa1Mm65kRltWvYuf.jpeg','UNIT0014'),(105,'unit-jbZPfL6CNt6J93yp0iAZYTSy4PP3f0k92to9RZP6.jpeg','UNIT0014'),(106,'unit-4jxtNE51tvlil445EvPSoUH3JpHe2aKABn38N71b.jpeg','UNIT0014'),(107,'unit-hzcOwucnNIaNvM7c3wCqVIrns5MzBZr5Njf36lCx.jpeg','UNIT0014'),(108,'unit-ONKxBl0f5m9SpmRZ4Wcnrab42eapndkNExs5KyQI.jpeg','UNIT0014'),(109,'unit-VyEAEJ4tMti4VBUfmJrlCBrDbBnHHQkQNDhHtsf8.jpeg','UNIT0014'),(110,'unit-YsWOKAhs40Wqw2H5oyjM9DxCXkcGR7WMOMr6Me8C.jpeg','UNIT0014'),(111,'unit-AmRhUVliorN1EOqX7Qfa9aXNY96QkpuJ9DqNM9Ei.jpeg','UNIT0014'),(112,'unit-8vUr8Oz2a3TCNjn941MCQsSrXh59iU9PkoNi0Eqi.jpeg','UNIT0014'),(113,'unit-AjowcK7Qg6UnspnmOaBltinRkBsCXcALszuckwaK.jpeg','UNIT0014'),(114,'unit-jJuN6t1y6fA79TtzGdbj2QFL4HUYWyX6plI3T66V.jpeg','UNIT0014'),(115,'unit-MyMCQd6EidBxUsvYKzu83SFWn0M5fTjxuuZzsan9.jpeg','UNIT0014');

/*Table structure for table `project_unit_type` */

DROP TABLE IF EXISTS `project_unit_type`;

CREATE TABLE `project_unit_type` (
  `unit_type_id` varchar(8) NOT NULL,
  `unit_name` varchar(128) NOT NULL,
  `unit_slug` tinytext NOT NULL,
  `unit_floor` tinyint(2) unsigned DEFAULT NULL,
  `unit_lb` smallint(3) unsigned DEFAULT NULL,
  `unit_lt` smallint(3) unsigned DEFAULT NULL,
  `unit_kt` tinyint(2) unsigned NOT NULL,
  `unit_km` tinyint(2) unsigned NOT NULL,
  `unit_price` bigint(13) unsigned NOT NULL,
  `unit_description` longtext DEFAULT NULL,
  `unit_status` enum('available','sold','booked') NOT NULL DEFAULT 'available',
  `unit_watt` smallint(5) unsigned DEFAULT NULL,
  `unit_facility` tinytext DEFAULT NULL,
  `unit_thumbnail` varchar(60) DEFAULT NULL,
  `project_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`unit_type_id`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_unit_project_idx` (`project_id`),
  CONSTRAINT `fk_unit_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_id`,`created_at`,`updated_at`,`seqid`) values ('UNIT0001','Rumah Sharia Tipe 1','rumah-sharia-tipe-1',2,56,60,3,2,158850000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','sold',3200,'Telepon,Air Panas,Akses Internet / Wifi,Pendingin Ruangan (AC),Garasi,Halaman Terbuka,Taman','unit-6HggPNknJmjFDBBiWtzfpcRvn6QUCil4jkc3w1oc.jpeg','PRY0001','2019-10-11 17:45:57','2019-10-12 10:38:54',8),('UNIT0009','Rumah Sharia Tipe 2','rumah-sharia-tipe-2',2,30,60,2,1,132758000,'<p>Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</p><p>Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</p><p>Segawon <a href=\"http://sikatsuket.blogspot.com/\" rel=\"noopener noreferrer\" target=\"_blank\">nyukani ulem-ulem</a> cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.</p>','sold',2200,'Telepon,Pendingin Ruangan (AC),Air Panas','unit-GtGboMey0JhWq0bf2dCA9AyyXf3HrJZFgzNjPT9X.jpeg','PRY0001','2019-10-11 21:19:26','2019-10-12 09:31:35',9),('UNIT0010','Ummi Residence Tipe 1','ummi-residence-tipe-1',2,60,56,3,2,360000000,'<p>Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</p><p><br></p><p>Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</p><p><br></p><p>Segawon <a href=\"http://sikatsuket.blogspot.com/\" rel=\"noopener noreferrer\" target=\"_blank\">nyukani ulem-ulem</a> cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.</p>','sold',3200,'Telepon,Akses Internet / Wifi,Pendingin Ruangan (AC),Halaman Terbuka',NULL,'PRY0008','2019-10-15 22:40:26','2019-10-15 23:29:48',10),('UNIT0011','Ummi Residence Tipe 2','ummi-residence-tipe-2',1,65,60,3,2,485000000,'<p>Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</p><p><br></p><p>Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</p><p><br></p><p>Segawon <a href=\"http://sikatsuket.blogspot.com/\" rel=\"noopener noreferrer\" target=\"_blank\">nyukani ulem-ulem</a> cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.</p>','booked',3300,'Telepon,Pendingin Ruangan (AC),Halaman Terbuka,Taman,Akses Internet / Wifi,Air Panas',NULL,'PRY0008','2019-10-15 22:43:16','2019-10-15 23:31:07',11),('UNIT0012','Ummi Residence Tipe 3','ummi-residence-tipe-3',2,76,70,4,2,785000000,'<p>Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</p><p><br></p><p>Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</p><p><br></p><p>Segawon <a href=\"http://sikatsuket.blogspot.com/\" rel=\"noopener noreferrer\" target=\"_blank\">nyukani ulem-ulem</a> cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.</p>','sold',4500,'Telepon,Keamanan 24 Jam,Kolam Renang,Akses Internet / Wifi,Pendingin Ruangan (AC),Taman',NULL,'PRY0008','2019-10-15 22:44:07','2019-10-15 23:29:43',12),('UNIT0013','Podomoro Golf View Tipe Studio','podomoro-golf-view-tipe-studio',1,22,22,1,1,285850000,'<p><strong>Podomoro Golf View Tipe Studio</strong>merupakan tipe apartemen yang dilengkapi dengan 1 kamar tidur, 1 kamar mandi. Tipe ini memiliki luas bangunan 22 m2.</p><p><strong>Keunggulan Podomoro Golf View :</strong></p><p><br></p><ul><li><strong>Lokasi Podomoro Golf View Cimanggis</strong>yang sangat strategis</li><li>Tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock</li><li>Dikembangkan oleh developer terpercaya serta berpengalaman, yaitu Agung Podomoro Land</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li>Bergabungnya Universitas Gunadarma sebagai pendukung fasilitas pendidikan dalam kawasan<strong>Perumahan Podomoro Golf View</strong></li><li>30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><strong>Fasilitas yang terdapat pada Podomoro Golf View Apartemen, yaitu :</strong></p><p><br></p><ul><li>Shuttle Bus</li><li>Golf View 360<em>ᵒ</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li>Jogging Track</li><li>Lapangan Badminton</li><li>Area berkumpul untuk keluarga</li><li>Infinity Swimming Pool</li><li>BBQ Area</li><li>Sky Garden</li><li>Ruang Olahraga</li><li>Sauna/Jacuzzi</li><li>Minimart</li><li>Light Rapid Transit</li></ul><p><br></p>','booked',3200,'Telepon,Air Panas,Kolam Renang,Balkon,Pendingin Ruangan (AC),Secure Parking,Gym,Taman Bermain Anak,Taman,Keamanan 24 Jam','unit-Xil5EHMvTG8QlBAdsjKOUPLDsxKhTf3RVWyOcQjJ.jpeg','PRY0007','2019-10-15 22:52:57','2019-10-15 23:36:07',13),('UNIT0014','Podomoro Golf View Tipe 2 Bedroom','podomoro-golf-view-tipe-2-bedroom',1,36,36,2,1,467570000,'<p><strong>Podomoro Golf View Tipe 2 Bedroom</strong>merupakan tipe apartemen yang dilengkapi dengan 2 kamar tidur, 1 kamar mandi. Tipe ini memiliki luas bangunan 36 m2.</p><p><strong>Keunggulan dari Podomoro Golf View :</strong></p><p><br></p><ul><li><strong>Lokasi Podomoro Golf View Cimanggis</strong>yang sangat strategis</li><li>Tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock</li><li>Dikembangkan oleh developer terpercaya serta berpengalaman, yaitu Agung Podomoro Land</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li>Bergabungnya Universitas Gunadarma sebagai pendukung fasilitas pendidikan dalam kawasan<strong>Perumahan Podomoro Golf View</strong></li><li>30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><strong>Fasilitas yang terdapat pada Podomoro Golf View Apartemen, yaitu :</strong></p><p><br></p><ul><li>Shuttle Bus</li><li>Golf View 360<em>ᵒ</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li>Jogging Track</li><li>Lapangan Badminton</li><li>Area berkumpul untuk keluarga</li><li>Infinity Swimming Pool</li><li>BBQ Area</li><li>Sky Garden</li><li>Ruang Olahraga</li><li>Sauna/Jacuzzi</li><li>Minimart</li><li>Light Rapid Transit</li></ul><p><br></p>','booked',3200,'Air Panas,Keamanan 24 Jam,Telepon,Balkon,Pendingin Ruangan (AC),Secure Parking,Taman,Gym,Halaman Terbuka,Taman Bermain Anak','unit-ONKxBl0f5m9SpmRZ4Wcnrab42eapndkNExs5KyQI.jpeg','PRY0007','2019-10-15 22:56:49','2019-10-15 23:34:20',14);

/*Table structure for table `province` */

DROP TABLE IF EXISTS `province`;

CREATE TABLE `province` (
  `province_id` char(2) NOT NULL,
  `province_name` varchar(128) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `province` */

insert  into `province`(`province_id`,`province_name`) values ('BT','Banten'),('JB','Jawa Barat'),('JK','DKI Jakarta'),('JT','Jawa Tengah');

/*Table structure for table `unit_facility` */

DROP TABLE IF EXISTS `unit_facility`;

CREATE TABLE `unit_facility` (
  `id_facility` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `facility_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_facility`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

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

insert  into `verification_customer`(`hash_id`,`customer_id`,`expire_date`,`status_verify`,`created_at`,`updated_at`) values ('0957ed454ccf853235d52fe829c0d24c004bdc9e','CUST0004',1571126887,'N','2019-10-15 14:38:07','2019-10-15 14:38:07'),('1d069b37d0844b05e5b67a11ca0a8f824618be9a','CUST0006',1571157338,'N','2019-10-15 23:05:38','2019-10-15 23:05:38'),('4e1e8179df3a4912f55bbc54aeaae1d62ef80b8e','CUST0002',1570616793,'Y','2019-10-09 16:46:58','2019-10-09 16:59:39'),('609646dde305c6aeb3d9a1af87219f3bfb57161f','CUST0005',1571126931,'N','2019-10-15 14:38:52','2019-10-15 14:38:52'),('75f173ce75ef81ca3727567d336e22a319f45f43','CUST0001',1570615409,'Y','2019-10-09 16:33:29','2019-10-09 16:37:40'),('783d7f1ac28a0d080f99dca5ec1bee79e0c295a7','CUST0003',1570727193,'Y','2019-10-10 23:36:33','2019-10-10 23:37:15');

/*Table structure for table `verification_developer` */

DROP TABLE IF EXISTS `verification_developer`;

CREATE TABLE `verification_developer` (
  `hash_id` varchar(40) NOT NULL,
  `dev_user_id` varchar(13) NOT NULL,
  `npwp_image` varchar(60) NOT NULL,
  `official_certificate` varchar(60) NOT NULL,
  `additional_document` varchar(60) DEFAULT NULL,
  `status_verification` enum('Y','N','R') DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `fk_verify_devuser_idx` (`dev_user_id`),
  CONSTRAINT `fk_verify_devuser_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `verification_developer` */

insert  into `verification_developer`(`hash_id`,`dev_user_id`,`npwp_image`,`official_certificate`,`additional_document`,`status_verification`,`created_at`,`updated_at`) values ('32203c642f030f0a671608ac3303f05353002cca','DEV0002','NPWP-W4RXeRELnHxXw2rBNdfIl6mVGBFFnuajO1lD4bUP.jpeg','Cert-C2757fBmMxYVl5TNpRWhZvqCZvc9o7rimou5QfDA.jpeg',NULL,'Y','2019-10-15 17:33:02','2019-10-15 21:13:54'),('6393419df372247c11fc091a43f640d42c82efdf','DEV0001','NPWP-IgehcdFWoAu4UGb2RImTF23ziqPZ9sa5Up18GmrV.jpeg','Cert-aQgYteH4u8JE9aEqzLZvci8Qjne8bP8RxSn1Tk6N.png',NULL,'R','2019-10-15 22:27:27','2019-10-15 22:35:45'),('c057db9d965989e9a100fbc1890def8be2f21ada','DEV0003','NPWP-Mco7sJHAz4ty8iSpeK1xEeKyUwifbTKgnd4HCSEV.jpeg','Cert-bEMiR3oBvxh7hZvmKetvo2WtUrDVv3b7cM0pr6To.png',NULL,'Y','2019-10-15 22:31:15','2019-10-15 22:35:39'),('c71d6b9b83bceb144754f8b72895900623281f9b','DEV0004','NPWP-aEO854TVqWAMCYENHKTonXEX2CNJ0qv4eZzcabqV.jpeg','Cert-jYz7QkcYtbBI4JRYGm3QHPB4AouDgqCP1t9RNQeU.png',NULL,'Y','2019-10-15 22:33:07','2019-10-15 22:35:33');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
