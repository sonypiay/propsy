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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`customer_email`,`customer_address`,`customer_phone_number`,`customer_username`,`customer_password`,`customer_photo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('CUST0001','Sony Darmawan','sonypiay@mail.com','Jl. Kemanggisan','0856187468','sonypiay','$2y$12$fzBqOODJFFsh3bFm0piO7O0Xk.aLNG/Nj6Dl8zmgyXgIi7HiaLwiW','XrcNGK3NPwnATJlmtkVxsxKG0eDoKhpq82bPCt85.jpeg','JKP','Y','2019-10-23 17:16:23','2019-10-24 00:05:21',7),('CUST0008','Rizqy Caesario','rizqycaesario@gmail.com','Tambora','080989999','rizqycaesario','$2y$12$vOSpDBRIc9YNJVKeym.9OuxNve72l4zXMG.GCtJHvSmPdEKcKJO6i',NULL,'JKB','Y','2019-10-23 17:22:52','2019-10-23 17:23:28',8),('CUST0009','John Doe','johndoe@gmail.com','Little Tokyo, Jakarta Selatan','080989999','johndoe','$2y$12$GmBooXLF3qjTcb3mSFUlBO2PGIwVPIe6DciugOcvRAf4MT8bN11Ca',NULL,'JKP','Y','2019-10-23 17:26:30','2019-10-23 17:27:13',9),('CUST0010','Velvet Crowe','velvet@gmail.com','Sukabumi','080989999','velvet','$2y$12$xRHb1WhAub1LVRTqix3CYOh5X/WUs9wHhTMcneKWFIKqHDByQ08o.',NULL,'BGR','Y','2019-10-23 17:28:45','2019-10-23 17:29:16',10),('CUST0011','Muhammad Ilham','m.ilham@gmail.com','Pam 3','080989999','ilham272727','$2y$12$VEoUETHqjm1x28Vep71wF.x5pUNgQ0j1EZfg0.83WrcgkLsyYmA0O',NULL,'JKP','N','2019-10-23 17:37:06','2019-10-23 17:39:29',11),('CUST0012','Romi Herdian','romi.herdian@gmail.com','Sunter, Jakarta','085612876876','romiromi','$2y$12$250SeJZto908SlwX18T7KuUY0c0grR7wJdelLztoyr9suCQh/v81O',NULL,'JKP','N','2019-10-23 17:37:44','2019-10-23 17:38:07',12);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_logo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('DEV0001','PT Ummi Developer','PT Ummi Developer','pt-ummi-developer','Bogor','ummi_developer','$2y$12$bZnb1MP6Yk4YPL2v3c5So.yX4/sKuu1.jcosOMEho/iTDgU8WOBFy','ummi_developer@gmail.com','Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.','0214229239','080989999',NULL,'BGR','Y','2019-10-23 13:39:25','2019-10-23 14:10:04',6),('DEV0007','PT ABI Developer','PT ABI Developer','pt-abi-developer','Tambun, Bekasi','abi_developer','$2y$12$l7UWrzpWdTFbok6OGGDNX.uGb8eGAtfh4N58ss5L8jHJ3zXdJs62K','abi_dev@mail.com','Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.','021948484','080989999','lMnAzCx9Y556pBLdAsznDduXWIVedvRFffCA1LT2.png','BKS','Y','2019-10-23 14:04:16','2019-10-23 15:16:38',7);

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
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

insert  into `log_project_request`(`log_id`,`log_message`,`request_id`,`log_date`) values (98,'Sony Darmawan mengajukan pemesanan unit Abi Residence Tipe 1','REQ201910230001','2019-10-23 17:19:03'),(99,'Rizqy Caesario mengajukan pemesanan unit Abi Apartemen Tipe 2','REQ201910230025','2019-10-23 17:24:24'),(100,'Rizqy Caesario mengajukan pemesanan unit Abi Apartemen Tipe 1','REQ201910230026','2019-10-23 17:24:49'),(101,'Rizqy Caesario mengajukan pemesanan unit Abi Apartemen Tipe 3','REQ201910230027','2019-10-23 17:25:49'),(102,'John Doe mengajukan pemesanan unit Abi Apartemen Tipe 1','REQ201910230028','2019-10-23 17:27:49'),(103,'Velvet Crowe mengajukan pemesanan unit Abi Apartemen Tipe 3','REQ201910230029','2019-10-23 17:29:32'),(104,'Romi Herdian mengajukan pemesanan unit Ummi Residences Tipe 3','REQ201910230030','2019-10-23 17:38:47'),(105,'Muhammad Ilham mengajukan pemesanan unit Ummi Residences Tipe 3','REQ201910230031','2019-10-23 17:40:28'),(106,'Marketing Ummi Head Office mengundang Romi Herdian untuk meeting & survey lokasi bersama.','REQ201910230030','2019-10-23 17:42:25'),(107,'Marketing Ummi Head Office mengundang Muhammad Ilham untuk meeting & survey lokasi bersama.','REQ201910230031','2019-10-23 17:43:18'),(108,'Marketing Abi 1 mengundang Sony Darmawan untuk meeting & survey lokasi bersama.','REQ201910230001','2019-10-23 17:44:08'),(109,'Marketing Abi 1 mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910230025','2019-10-23 17:44:36'),(110,'Marketing Abi 1 mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910230026','2019-10-23 17:45:06'),(111,'Marketing Abi 1 mengundang John Doe untuk meeting & survey lokasi bersama.','REQ201910230028','2019-10-23 17:45:30'),(112,'Marketing Abi 1 mengundang Velvet Crowe untuk meeting & survey lokasi bersama.','REQ201910230029','2019-10-23 17:45:47'),(113,'Marketing Abi 1 mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910230027','2019-10-23 17:46:09'),(114,'Rizqy Caesario telah menerima undangan meeting.','REQ201910230027','2019-10-23 17:48:05'),(115,'Rizqy Caesario membatalkan pengajuan pemesanan unit','REQ201910230026','2019-10-23 17:48:44'),(116,'Rizqy Caesario membatalkan pengajuan pemesanan unit','REQ201910230025','2019-10-23 17:49:21'),(117,'Marketing Abi 1 telah membatalkan jadwal meeting.','REQ201910230026','2019-10-23 17:50:41'),(118,'Marketing Abi 1 telah membatalkan jadwal meeting.','REQ201910230025','2019-10-23 17:50:48'),(119,'Sony Darmawan telah menerima undangan meeting.','REQ201910230001','2019-10-23 17:52:27'),(120,'Velvet Crowe telah menerima undangan meeting.','REQ201910230029','2019-10-23 17:52:53'),(121,'John Doe telah menerima undangan meeting.','REQ201910230028','2019-10-23 17:53:20'),(122,'Muhammad Ilham telah menerima undangan meeting.','REQ201910230031','2019-10-23 17:54:34'),(123,'Romi Herdian telah menerima undangan meeting.','REQ201910230030','2019-10-23 17:54:56'),(124,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910230031','2019-10-23 20:35:40'),(125,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910230030','2019-10-23 20:36:07'),(126,'Developer menyetujui pesanan pelanggan. <br /> Unit telah dipesan.','REQ201910230030','2019-10-23 20:37:19'),(127,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910230001','2019-10-23 20:45:52'),(128,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910230028','2019-10-23 20:47:11'),(129,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910230029','2019-10-23 20:47:38'),(130,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910230027','2019-10-23 20:48:58'),(131,'Developer menyetujui pesanan pelanggan. <br /> Unit telah dipesan.','REQ201910230027','2019-10-23 20:50:00'),(132,'Developer menyetujui pesanan pelanggan. <br /> Unit telah dipesan.','REQ201910230028','2019-10-23 20:50:19'),(133,'Developer menyetujui pesanan pelanggan. <br /> Unit telah dipesan.','REQ201910230001','2019-10-23 21:02:36');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `marketing_user` */

insert  into `marketing_user`(`mkt_user_id`,`mkt_fullname`,`mkt_email`,`mkt_username`,`mkt_password`,`mkt_phone_number`,`mkt_mobile_phone`,`mkt_address`,`mkt_profile_photo`,`dev_user_id`,`city_id`,`created_at`,`updated_at`,`seqid`) values ('MKT0001','Marketing Abi 1','mkt_abi@gmail.com','mkt_abi','$2y$12$JlYDhS2wMZeNGxD5RZNoPOLZ0eXRXenOLyJwA2FYnGcjwP9liAUKC','02180899899','080989999','Bogor',NULL,'DEV0007','BGR','2019-10-23 17:31:20','2019-10-23 17:34:17',4),('MKT0005','Marketing Abi 2','mkt_abi2@gmail.com','mkt_abi2','$2y$12$YVOgNPV2FKU8/o48MHFdJeefkCy5./0aBZtYR3XeJoEQ4UgDyfQry','02199594599','08655065960','Bogor',NULL,'DEV0007','BGR','2019-10-23 17:34:05','2019-10-23 17:34:05',8),('MKT0009','Marketing Ummi Head Office','mkt_ummi@gmail.com','mkt_ummi','$2y$12$fjNJKcIQbOMlGgZZJ4CuxuYGQt88TYCOSqHqKj1ycmy0vJ69AwfUe','0128182798','0856192817','Depok',NULL,'DEV0001','DPK','2019-10-23 17:36:05','2019-10-24 00:02:32',9);

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

insert  into `meeting_appointment`(`meeting_id`,`meeting_time`,`meeting_status`,`request_id`,`meeting_note`,`meeting_result`,`document_file`,`created_by`,`updated_by`,`created_at`,`updated_at`,`seqid`) values ('MEETING1910230001','2019-10-24 14:00:00','done','REQ201910230030','Terima kasih atas ketertarikan Anda untuk membeli properti Ummi Residences Tipe 3. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','meeting selesai','result_I3yci8SKeuUqeb3WlRKrs7bqo9Qmfy68BLSx6tbS.pdf','Marketing Ummi Head Office','Marketing Ummi Head Office','2019-10-23 17:42:25','2019-10-23 20:36:07',21),('MEETING1910230022','2019-10-25 10:00:00','done','REQ201910230031','Terima kasih atas ketertarikan Anda untuk membeli properti Ummi Residences Tipe 3. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting selesai','result_WeZ4Og6kirROz9lXbjE6E9MCVo7aNoBbJjfuzsmX.pdf','Marketing Ummi Head Office','Marketing Ummi Head Office','2019-10-23 17:43:17','2019-10-23 20:35:40',22),('MEETING1910230023','2019-10-24 10:00:00','done','REQ201910230001','Terima kasih atas ketertarikan Anda untuk membeli properti Abi Residence Tipe 1. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai','result_xJ19Rw13JYOz46YHXEJhJpUjhh13eQb8L0qenvSS.pdf','Marketing Abi 1','Marketing Abi 1','2019-10-23 17:44:08','2019-10-23 20:45:52',23),('MEETING1910230024','2019-10-25 10:00:00','cancel','REQ201910230025','Terima kasih atas ketertarikan Anda untuk membeli properti Abi Apartemen Tipe 2. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing',NULL,NULL,'Marketing Abi 1','Marketing Abi 1','2019-10-23 17:44:36','2019-10-23 17:50:48',24),('MEETING1910230025','2019-10-25 10:00:00','cancel','REQ201910230026','Terima kasih atas ketertarikan Anda untuk membeli properti Abi Apartemen Tipe 1. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing',NULL,NULL,'Marketing Abi 1','Marketing Abi 1','2019-10-23 17:45:06','2019-10-23 17:50:41',25),('MEETING1910230026','2019-10-26 10:00:00','done','REQ201910230028','Terima kasih atas ketertarikan Anda untuk membeli properti Abi Apartemen Tipe 1. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai','result_nwJPod2DuAYVZCOpS5lxDhBhgaVEau1cieMiYtBH.pdf','Marketing Abi 1','Marketing Abi 1','2019-10-23 17:45:29','2019-10-23 20:47:11',26),('MEETING1910230027','2019-10-28 09:00:00','done','REQ201910230029','Terima kasih atas ketertarikan Anda untuk membeli properti Abi Apartemen Tipe 3. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai','result_zdb0jAMnTbTez6uPNu7SiyLlqtGoU7OfKRFv2DxJ.pdf','Marketing Abi 1','Marketing Abi 1','2019-10-23 17:45:47','2019-10-23 20:47:37',27),('MEETING1910230028','2019-10-25 10:00:00','done','REQ201910230027','Terima kasih atas ketertarikan Anda untuk membeli properti Abi Apartemen Tipe 3. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai','result_UlAL61tqBj2jRiFqi3ivhcXVoPHC6YgVPLohr8ue.pdf','Marketing Abi 1','Marketing Abi 1','2019-10-23 17:46:09','2019-10-23 20:48:58',28);

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

/*Data for the table `price_installment` */

insert  into `price_installment`(`id`,`unit_type_id`,`dp_price`,`installment_price`,`installment_tenor`) values (21,'UNIT0001',100000000,5800000,10),(22,'UNIT0001',50000000,3250000,24),(23,'UNIT0001',85000000,4580000,26),(24,'UNIT0016',150000000,6900000,36),(25,'UNIT0016',120000000,5350000,24),(26,'UNIT0016',89000000,7450000,20),(27,'UNIT0017',100000000,3840000,48),(28,'UNIT0017',50000000,1840000,128),(29,'UNIT0017',60000000,2840000,58),(30,'UNIT0018',100000000,10680000,55),(31,'UNIT0018',150000000,7680000,74),(32,'UNIT0018',200000000,6680000,84),(33,'UNIT0018',50000000,2680000,234),(34,'UNIT0021',300000000,5680000,82),(35,'UNIT0021',200000000,7680000,72),(36,'UNIT0021',176800000,4000000,132),(37,'UNIT0020',80000000,8000000,13),(38,'UNIT0020',40000000,4200000,34),(39,'UNIT0019',85000000,10000000,50),(40,'UNIT0019',100000000,6850000,66),(41,'UNIT0024',100000000,14500000,25),(42,'UNIT0024',120000000,15500000,23),(43,'UNIT0024',150000000,9450000,42),(44,'UNIT0023',200000000,8900000,72),(45,'UNIT0023',300000000,12890000,53),(46,'UNIT0023',150000000,6890000,105),(47,'UNIT0022',400000000,10600000,53),(48,'UNIT0022',300000000,8600000,77),(49,'UNIT0022',200000000,7600000,100),(50,'UNIT0022',100000000,5600000,154);

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(50) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`project_id`) values (21,'KiEFSLQpHdEZO9IaqEjtTjQ5OGR5Ps7TLavARV9D.jpeg','PRY0001'),(22,'dOunliDR7tAaul6qQsQDwmSfdAC9vBSgA2CTkNDz.jpeg','PRY0010'),(23,'G7vNG9aEhwJqtXDDqUWCApOf5RXmBXK5ZnRxtfeG.jpeg','PRY0011'),(24,'glzKRZu1FS5Uoc3LLTchpIV042xqx9xKEElRX4Wd.jpeg','PRY0012');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_link_map`,`project_map_embed`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`,`city_id`,`seqid`) values ('PRY0001','Abi Residences 1','abi-residences-1','KiEFSLQpHdEZO9IaqEjtTjQ5OGR5Ps7TLavARV9D.jpeg','<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','Karawang, Bekasi','https://goo.gl/maps/BJXb5MHPTPXA3cwo9','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.4105661231806!2d106.8186020141934!3d-6.209455262551319!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69f402523079bd%3A0x825ec6124e4cccf4!2sMidPlaza%202!5e0!3m2!1sid!2sid!4v1571814986816!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','residensial','available',NULL,'DEV0007','2019-10-23 14:17:20','2019-10-23 14:17:20','BKS',9),('PRY0010','Abi Apartemen 2','abi-apartemen-2','dOunliDR7tAaul6qQsQDwmSfdAC9vBSgA2CTkNDz.jpeg','<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','Bogor','https://goo.gl/maps/RsyzCeeKW3EPac57A','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15865.719364767934!2d106.82963755!3d-6.20689565!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69f402483f55d3%3A0x74fbaaecec85af9a!2sGrand%20Sahid%20Jaya!5e0!3m2!1sid!2sid!4v1571816457232!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','apartemen','available',NULL,'DEV0007','2019-10-23 14:41:28','2019-10-23 14:41:28','BGR',10),('PRY0011','Ummi Residences 1','ummi-residences-1','G7vNG9aEhwJqtXDDqUWCApOf5RXmBXK5ZnRxtfeG.jpeg','<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','Depok, Cimanggis','https://goo.gl/maps/vvDEopR2wVDayTr79','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3964.679419098327!2d106.89494461419564!3d-6.435206864718172!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69c30088000ed3%3A0xe794f80c0724e861!2sBiznet%20Technovillage!5e0!3m2!1sid!2sid!4v1571817512564!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','residensial','available',NULL,'DEV0001','2019-10-23 14:59:03','2019-10-23 14:59:03','DPK',11),('PRY0012','Ummi Apartemen Cluster','ummi-apartemen-cluster','glzKRZu1FS5Uoc3LLTchpIV042xqx9xKEElRX4Wd.jpeg','<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','Depok, Cimanggis','https://goo.gl/maps/vvDEopR2wVDayTr79','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3964.679419098327!2d106.89494461419564!3d-6.435206864718172!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69c30088000ed3%3A0xe794f80c0724e861!2sBiznet%20Technovillage!5e0!3m2!1sid!2sid!4v1571817512564!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','apartemen','available',NULL,'DEV0001','2019-10-23 15:00:18','2019-10-23 15:00:18','DPK',12);

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

insert  into `project_request`(`request_id`,`dev_user_id`,`customer_id`,`unit_type_id`,`request_message`,`status_request`,`isReviewed`,`created_at`,`updated_at`,`seqid`,`installment`) values ('REQ201910230001','DEV0007','CUST0001','UNIT0001','Halo PT ABI Developer, saya ingin mengajukan pemesenan unit Abi Residence Tipe 1.','accept','Y','2019-10-23 17:19:02','2019-10-23 21:02:36',24,22),('REQ201910230025','DEV0007','CUST0008','UNIT0020','Halo PT ABI Developer, saya ingin mengajukan pemesenan unit Abi Apartemen Tipe 2.','cancel','N','2019-10-23 17:24:24','2019-10-23 17:49:21',25,37),('REQ201910230026','DEV0007','CUST0008','UNIT0019','Halo PT ABI Developer, saya ingin mengajukan pemesenan unit Abi Apartemen Tipe 1.','reject','Y','2019-10-23 17:24:49','2019-10-23 20:50:19',26,39),('REQ201910230027','DEV0007','CUST0008','UNIT0021','Halo PT ABI Developer, saya ingin mengajukan pemesenan unit Abi Apartemen Tipe 3.','accept','Y','2019-10-23 17:25:49','2019-10-23 20:50:00',27,34),('REQ201910230028','DEV0007','CUST0009','UNIT0019','Halo PT ABI Developer, saya ingin mengajukan pemesenan unit Abi Apartemen Tipe 1.','accept','Y','2019-10-23 17:27:49','2019-10-23 20:50:19',28,40),('REQ201910230029','DEV0007','CUST0010','UNIT0021','Halo PT ABI Developer, saya ingin mengajukan pemesenan unit Abi Apartemen Tipe 3.','reject','Y','2019-10-23 17:29:32','2019-10-23 20:50:00',29,35),('REQ201910230030','DEV0001','CUST0012','UNIT0024','Halo PT Ummi Developer, saya ingin mengajukan pemesenan unit Ummi Residences Tipe 3.','accept','Y','2019-10-23 17:38:47','2019-10-23 20:37:20',30,42),('REQ201910230031','DEV0001','CUST0011','UNIT0024','Halo PT Ummi Developer, saya ingin mengajukan pemesenan unit Ummi Residences Tipe 3.','reject','Y','2019-10-23 17:40:28','2019-10-23 20:37:19',31,43);

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(60) NOT NULL,
  `unit_type_id` varchar(8) NOT NULL,
  PRIMARY KEY (`unit_gallery_id`),
  KEY `fk_unit_gallery_unit_type_idx` (`unit_type_id`),
  CONSTRAINT `fk_unit_gallery_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`) values (119,'unit-qv4GaCePSP9KTk6r5VY77jf01XSnRVFkczoQqqxe.jpeg','UNIT0001'),(120,'unit-W7iq3wKFCbfMwGxj5Zu4FNpuku94kzsr6KnxYCvw.jpeg','UNIT0001'),(121,'unit-Z2LLIQxlMrgROXTgBP1DX51DVoZoTAgebdJUcnLh.jpeg','UNIT0001'),(122,'unit-KKfcCmlyWe9evvBm0V12nuETCMaKK5xhUKqPQHXh.jpeg','UNIT0016'),(123,'unit-YLLAu6jf9MhTx7G5qM2tovCFjcQcINa1YyP7Uc7V.jpeg','UNIT0016'),(124,'unit-MUXFq36aHfnbTWqAWDy96aP44B6EbMUaueQuBkpv.jpeg','UNIT0016'),(125,'unit-yAKgYv5TWnMaxiVLdZgIpyYmeOWDsyCbGLdI39nE.jpeg','UNIT0016'),(126,'unit-zwKKNS6ps4XvnCojOG8ybvYyscAocM9xdThnWjzZ.jpeg','UNIT0017'),(127,'unit-WrPQ9FHL8NLDhrpZ9YIGZswn1n4VKBSL3hDbZXPq.jpeg','UNIT0017'),(128,'unit-fNsxYQDq3CVvTauxHy8WD4hUlIdQBVYBlYiQ7RQL.jpeg','UNIT0017'),(129,'unit-P6WXm4J27rvZLzLT5DTNqw0gjwXug0zLwRrNlyWB.jpeg','UNIT0017'),(130,'unit-yJa420mx8OCSEGbBzZ8BBTiBauasD80EhXnWwFdi.jpeg','UNIT0017'),(131,'unit-S4vqtBdqRCMQdSU9qFf6gpTHCGOmxDu616ZJfAUk.jpeg','UNIT0017'),(136,'unit-gwOO7EiWJOxpXoZ9enNojrr65yojcZh3ec7YlYqU.jpeg','UNIT0018'),(137,'unit-o16IQj01SWAgsQZdjlEPyTE3iwJlPjA0Znd48GTz.jpeg','UNIT0018'),(138,'unit-vwcjQEfN9aLv6w24kgl4xWv2eYO388aNqkErsjOR.jpeg','UNIT0018'),(139,'unit-dNpLirglKDu2oEeDgxqFzdhhS2FF5VlIzyTf89Kz.jpeg','UNIT0018'),(140,'unit-WZJJduFcQiw65qclvAXLCB9QjTXMnVA3EQYgp3Y4.jpeg','UNIT0021'),(141,'unit-JhSz266L7GznwvPCuWLddanbN4hY7F5dH92AUVSo.jpeg','UNIT0021'),(142,'unit-9W97EtssbBXEcNvgVgMrbLwUsrBJAN411HOF7paU.jpeg','UNIT0021'),(143,'unit-fsIb21hb5IFMw5yaXnvMaoVV3CFLsqAxGojUvvpp.jpeg','UNIT0021'),(144,'unit-Bla1rpvhjeo3XqfiDUur0V9i1SUuBuR8i4D2foG8.jpeg','UNIT0021'),(145,'unit-Cob33CEj7gOQpDAO2i3MmIotRZVPWdGBvJMe2tZK.jpeg','UNIT0021'),(146,'unit-lg9tMtcaFqf3C1AYZjF4AA30i9s9ajAIwJCNaHrl.jpeg','UNIT0021'),(147,'unit-nGhhPVvZ84TDQBZUmW9YCkAkQenxNw8cgYfzMkyp.jpeg','UNIT0021'),(148,'unit-36Edi9M5WLa5jNYuoVxtCvgpSvPvQ1t8jOU3RFrZ.jpeg','UNIT0020'),(149,'unit-rgDWJNvdIbp9DlBiYwvhrTMaMgixvZsKGuqMwxFB.jpeg','UNIT0020'),(150,'unit-KnWT8BjkcUZFnNR0wrv2AwndKeedRJW56lMvzzp6.jpeg','UNIT0020'),(151,'unit-NHYdyOuQpfMPPqJEf9iuOaHYZwWZP3G6RMyHSA4G.jpeg','UNIT0020'),(152,'unit-WSo388aPB8EPdt7aCvTPeWUh31O1DWULuHO53Xqq.jpeg','UNIT0020'),(153,'unit-Z1GlFYLGlzKDv5JnCn1PUD3fp713JDmRJWQkfree.jpeg','UNIT0020'),(154,'unit-1l1KwEZaSofe76QOanXdDEJrddM0Vy2kA83mAWjc.jpeg','UNIT0019'),(155,'unit-Us6Yarqs5CWk1dSLTOPAYZkcu4sAK7UpdMfF0sJd.jpeg','UNIT0019'),(156,'unit-33h1d6SUEQdCHfJXiitvchhcWT0WbK8DpvuSXG2b.jpeg','UNIT0019'),(157,'unit-hEGQgIZlBMmaoRIRu42U8ppeqQshuJ0ACejOUCul.jpeg','UNIT0019'),(158,'unit-y5TgUoT2prk0cxhoCeTwIdZUXvsj1A8kqAs0gBx4.jpeg','UNIT0019'),(159,'unit-i3V6fNETYci49FQnbb54iepnqBgcPSdZ7YRXowpb.jpeg','UNIT0024'),(160,'unit-K2sQQDIBfcZdhBZA3VLRHIvGtJILKmhRDUekLjkG.jpeg','UNIT0024'),(161,'unit-USLxWbKtuGNsg3uJvNkAKV364z2JCpM2gQl8oBNS.jpeg','UNIT0024'),(162,'unit-5qMTmCgw3QgVm02WhxeuXR9xKudLPO11CcjRPOQt.jpeg','UNIT0024'),(163,'unit-TZngwMfRlZmDUQSXnWb1SxiSolzMbcY8g9NsQMu6.jpeg','UNIT0024'),(164,'unit-f57RF7asYGILLfCJ8mQsfwohbjGDQYyadgLDn8ND.jpeg','UNIT0024'),(165,'unit-PXpRBTKzeGmViw9WFJ07dnoq8yPnRBIhzZRL8w5x.jpeg','UNIT0024'),(166,'unit-iLdvsyvOq7Nn1GXDtOnvazQen2UsQpVN4QYflkzB.jpeg','UNIT0023'),(167,'unit-GFWjnI0RloT1owL0K3BGefunul4v6mEns5SAL31L.jpeg','UNIT0023'),(168,'unit-bo6MEGU17VOvoo0FN8fff5ScEAmxq8VQKMrFKfz0.jpeg','UNIT0023'),(169,'unit-HWrNfE1ZC7XO6nj9ZzfB6Ax2Vu9IehOykvFv5oG2.jpeg','UNIT0023'),(170,'unit-AtZtSB2Anu6utjqO7wgJae6sXrhz6uIKk5tUwmcR.jpeg','UNIT0023'),(171,'unit-QnbeRwfTxFzvhaSKpW7rAq3cbB8CuiMgmnSKJn8o.jpeg','UNIT0023'),(172,'unit-tmOl8YZi6AnDlwLMD8ytQ1gisMRqP9zYD8ZVJkOQ.jpeg','UNIT0023'),(173,'unit-Kl1EruSF4O1S5fwbe8fzqGsmfWA2lUrowKFRkY3u.jpeg','UNIT0023'),(174,'unit-EF8Exgb1PDwDwufrYwYxIlobiAlMULEGeR7YOnnl.jpeg','UNIT0022'),(175,'unit-UaqXMmGAj2b94HmTtLRMVkLS4cAoosNGx4xjorQc.jpeg','UNIT0022'),(176,'unit-rMmCCF026tASIBhrKsLPRRvYmJjwJiQrnuub8mES.jpeg','UNIT0022'),(177,'unit-EZpK0q0XmblsU2snV2KmkizIdVYO997jxuPZ5Q5s.jpeg','UNIT0022'),(178,'unit-laHP1NtscsYh2oUeNmNQctjQhkz1sUGf9X92GFzJ.jpeg','UNIT0022'),(179,'unit-oJVsJKkO0UznkSkgbQ3ErrGJGAtKqyRysbQAT1vu.jpeg','UNIT0022'),(180,'unit-SoRDgQeobwePeDX1N7KGVoFaeTARbZByOH7hDfTC.jpeg','UNIT0022');

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_id`,`created_at`,`updated_at`,`seqid`) values ('UNIT0001','Abi Residence Tipe 1','abi-residence-tipe-1',2,60,60,2,2,158500000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','booked',2200,'Telepon,Akses Internet / Wifi,Pendingin Ruangan (AC),Taman Bermain Anak','unit-qv4GaCePSP9KTk6r5VY77jf01XSnRVFkczoQqqxe.jpeg','PRY0001','2019-10-23 14:18:43','2019-10-23 21:02:36',15),('UNIT0016','Abi Residences Tipe 2','abi-residences-tipe-2',2,90,90,3,2,328000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','available',3200,'Air Panas,Telepon,Akses Internet / Wifi,Kolam Renang,Pendingin Ruangan (AC),Garasi,Halaman Terbuka','unit-yAKgYv5TWnMaxiVLdZgIpyYmeOWDsyCbGLdI39nE.jpeg','PRY0001','2019-10-23 14:20:38','2019-10-23 14:21:02',16),('UNIT0017','Abi Residences Tipe 3','abi-residences-tipe-3',2,86,90,2,2,284000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','available',3300,'Telepon,Keamanan 24 Jam,Kolam Renang,Pendingin Ruangan (AC),Garasi,Halaman Terbuka,Akses Internet / Wifi','unit-S4vqtBdqRCMQdSU9qFf6gpTHCGOmxDu616ZJfAUk.jpeg','PRY0001','2019-10-23 14:22:16','2019-10-23 14:23:46',17),('UNIT0018','Abi Residences Tipe 4','abi-residences-tipe-4',2,90,90,3,2,685400000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','available',4400,'Air Panas,Telepon,Akses Internet / Wifi,Kolam Renang,Pendingin Ruangan (AC),Balkon,Garasi,Taman,Halaman Terbuka,Taman Bermain Anak','unit-gwOO7EiWJOxpXoZ9enNojrr65yojcZh3ec7YlYqU.jpeg','PRY0001','2019-10-23 14:23:16','2019-10-23 14:25:38',18),('UNIT0019','Abi Apartemen Tipe 1','abi-apartemen-tipe-1',1,48,NULL,2,1,585000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','sold',3800,'Telepon,Air Panas,Keamanan 24 Jam,Kolam Renang,Pendingin Ruangan (AC),Secure Parking,Taman Bermain Anak,Taman,Gym,Balkon','unit-y5TgUoT2prk0cxhoCeTwIdZUXvsj1A8kqAs0gBx4.jpeg','PRY0010','2019-10-23 14:43:03','2019-10-23 21:31:57',19),('UNIT0020','Abi Apartemen Tipe 2','abi-apartemen-tipe-2',1,32,NULL,1,1,180000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','available',2200,'Keamanan 24 Jam,Kolam Renang,Balkon,Pendingin Ruangan (AC),Secure Parking,Gym,Taman,Taman Bermain Anak,Halaman Terbuka','unit-Z1GlFYLGlzKDv5JnCn1PUD3fp713JDmRJWQkfree.jpeg','PRY0010','2019-10-23 14:44:17','2019-10-23 14:55:13',20),('UNIT0021','Abi Apartemen Tipe 3','abi-apartemen-tipe-3',1,68,NULL,3,2,768000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','sold',4400,'Air Panas,Keamanan 24 Jam,Telepon,Akses Internet / Wifi,Kolam Renang,Pendingin Ruangan (AC),Balkon,Secure Parking,Taman,Gym,Taman Bermain Anak,Halaman Terbuka','unit-9W97EtssbBXEcNvgVgMrbLwUsrBJAN411HOF7paU.jpeg','PRY0010','2019-10-23 14:45:23','2019-10-23 21:32:36',21),('UNIT0022','Ummi Residences Tipe 1','ummi-residences-tipe-1',2,90,90,3,2,960000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','available',4400,'Air Panas,Keamanan 24 Jam,Telepon,Akses Internet / Wifi,Kolam Renang,Pendingin Ruangan (AC),Balkon,Garasi,Gym,Taman,Taman Bermain Anak,Halaman Terbuka','unit-SoRDgQeobwePeDX1N7KGVoFaeTARbZByOH7hDfTC.jpeg','PRY0011','2019-10-23 15:01:20','2019-10-23 15:10:11',22),('UNIT0023','Ummi Residences Tipe 2','ummi-residences-tipe-2',2,90,90,3,2,890000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','available',4200,'Air Panas,Telepon,Akses Internet / Wifi,Keamanan 24 Jam,Pendingin Ruangan (AC),Garasi,Taman,Gym,Halaman Terbuka,Taman Bermain Anak','unit-Kl1EruSF4O1S5fwbe8fzqGsmfWA2lUrowKFRkY3u.jpeg','PRY0011','2019-10-23 15:02:07','2019-10-23 15:09:50',23),('UNIT0024','Ummi Residences Tipe 3','ummi-residences-tipe-3',1,68,60,2,1,450000000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','booked',3300,'Telepon,Keamanan 24 Jam,Pendingin Ruangan (AC),Halaman Terbuka,Akses Internet / Wifi,Taman','unit-f57RF7asYGILLfCJ8mQsfwohbjGDQYyadgLDn8ND.jpeg','PRY0011','2019-10-23 15:03:10','2019-10-23 20:37:20',24);

/*Table structure for table `province` */

DROP TABLE IF EXISTS `province`;

CREATE TABLE `province` (
  `province_id` char(2) NOT NULL,
  `province_name` varchar(128) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `province` */

insert  into `province`(`province_id`,`province_name`) values ('BT','Banten'),('JB','Jawa Barat'),('JK','DKI Jakarta'),('JT','Jawa Tengah');

/*Table structure for table `reset_password` */

DROP TABLE IF EXISTS `reset_password`;

CREATE TABLE `reset_password` (
  `token` varchar(60) NOT NULL,
  `useremail` varchar(64) NOT NULL,
  `usertype` enum('customer','developer','marketing') DEFAULT NULL,
  `expired_token` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `reset_password` */

insert  into `reset_password`(`token`,`useremail`,`usertype`,`expired_token`,`created_at`) values ('678456b9aabd35f78fc9b37336558df1fa43c25e','sonypiay@mail.com','customer',1571847932,'2019-10-23 22:55:32'),('978b81333c77e8ee1924d0d56dac7984c225bcd1','abi_dev@mail.com','developer',1571850958,'2019-10-23 23:45:58');

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

insert  into `verification_customer`(`hash_id`,`customer_id`,`expire_date`,`status_verify`,`created_at`,`updated_at`) values ('1c700214dcf407b725679dcad260900d46c0adb6','CUST0011',1571828822,'N','2019-10-23 17:37:06','2019-10-23 17:37:06'),('57a2fc71b87054dc690e3182b84689bf994e02ae','CUST0012',1571828860,'N','2019-10-23 17:37:44','2019-10-23 17:37:44'),('6689c35151ff4aa9c55ec877ef4863d942ffaa6d','CUST0009',1571828186,'Y','2019-10-23 17:26:30','2019-10-23 17:26:34'),('69eb93714693047b9ac570c3a33bef066d1de55e','CUST0001',1571827576,'Y','2019-10-23 17:16:23','2019-10-23 17:17:09'),('cac2c34c9b4ee5ff8c01bba112c403afb694923b','CUST0010',1571828321,'Y','2019-10-23 17:28:45','2019-10-23 17:28:49'),('da0700a04c65397031aa7ca893b137d39aeef70c','CUST0008',1571827967,'Y','2019-10-23 17:22:52','2019-10-23 17:22:58');

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

insert  into `verification_developer`(`hash_id`,`dev_user_id`,`npwp_image`,`official_certificate`,`additional_document`,`status_verification`,`created_at`,`updated_at`) values ('42546196c31815cecbb055c1278ac24dc6219900','DEV0007','NPWP-9w2Jsj7VvgjIloOP8FY6RnlaMrrMPFY2CQkyt3Hk.png','Cert-I0QM8kdioowuWMg5EVVObTHLbdsr8WEkuptCk8Ro.png',NULL,'Y','2019-10-23 14:56:41','2019-10-23 15:16:38'),('cf7d8279bcef14088b36162c4a77561d055e3b88','DEV0001','NPWP-POititRof8NtOjX48nS0B7Uvw9O3B8O24XMvJiEq.jpeg','Cert-N63R4hpkxlbImeTOdDjKJPcjGGdpA3NajqkwRS2F.png',NULL,'Y','2019-10-23 13:51:59','2019-10-23 14:10:04');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
