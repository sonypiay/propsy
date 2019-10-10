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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`customer_email`,`customer_address`,`customer_phone_number`,`customer_username`,`customer_password`,`customer_photo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('CUST0001','Sony Darmawan','sonypiay@mail.com','Jl. Intan Baiduri No. 28','08561969052','sonypiay','$2y$12$q2mcbtimnqFFUKSBcVViX.0MeX7j2kEBmaMpEkx8SwEsoZiPi7G3O','o7rXFSKErnKq8klnbqWaSZhvjody9Gd2mWjw0oob.jpeg','JKP','Y','2019-10-09 16:33:28','2019-10-09 16:41:10',1),('CUST0002','Rizqy Caesario','rizqycaesario@gmail.com','Tambora, Jakarta Barat','08998888','rizqycaesario','$2y$12$cP/TJagZ45itZ6Wksb8N4.w9ZSbHi42fOvi9Dvs4fBiw366hXhdT6','dNMJvMfDM5tF3N00q91lbbJbgW3pBpl3V7QZvSpb.jpeg','JKB','Y','2019-10-09 16:46:58','2019-10-10 23:31:30',2),('CUST0003','Nanami Okuhara','nanami.oku@gmail.com','Jl. Biznet Technovillage','08561969052','nanami','$2y$12$fLjT2vbCQExxM67H6vvw0eXfSGaAthz7XrPKgjKAml6EvhPYf86qa','P0e4h9q2dniXQvTJdyojUEB3jlYAK030zOinQbff.jpeg','DPK','Y','2019-10-10 23:36:32','2019-10-10 23:38:40',3);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_logo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('DEV0001','PT Agung Podomoro Land Tbk','John Doe','pt-agung-podomoro-land-tbk','APL Tower 43rd Floor, Podomoro City\nJl. Let. Jend. S. Parman Kav. 28\nJakarta 11470 Indonesia\nwww.agungpodomoroland.com','podomoro','$2y$12$WpZeMVZo7G1VvB6E/bHoyOcyxg892PAtVKtT1PKJpKK37jG6/mWri','podomoro@agungpodomoro.com','PT Agung Podomoro Land Tbk. (APLN) is a leading integrated diversified real estate owner, developer and manager in the retail, commercial, and residential real estate segments with diversified holdings. We have an integrated property development model, from land acquisition and/or sourcing, to design and development, to project management, sales, commercial leasing and marketing, to the operation and management of our superblock developments, shopping malls, offices, hotels, and residential apartments and houses. We are known as a pioneer of the superblock development. Our high quality landmark projects, to name a few are Podomoro City, Kuningan City, and Senayan City.\n\nAPLN was established on July 30, 2004 under the name PT Tiara Metropolitan Jaya. In 2010, our shareholders completed a corporate restructuring, pursuant to which six developments and their holding companies were transferred to our control. APLN, is the flagship listed entity (IDX:APLN) of Agung Podomoro Group (APG), is one of the fastest growing and largest real estate developers in Indonesia with interests in superblocks, retail properties, office, apartments and residential, and hotels. APG established its first development, a housing complex in Simprug area, South Jakarta, in 1969 and completed its construction in 1973. From 1973 to present, members of APG completed or begun construction of more than 70 property projects, with majority addressed to middle class segments of society, with projects ranging from low cost apartments to high end apartments in South Jakarta, landed residentials, high end and the neighborhood mall, shop houses, hotels, soho and office towers.\n\nAPLN combines a visionary approach to design with an emphasis on rapid execution and time to market. Drawing on the experience and resources of the Agung Podomoro Group, we have been responsible for bringing a number of landmark properties on the market such as our flagship Podomoro City Complex and the high profile Senayan City. We also pioneered the superblock concept, bringing together residential, retail, leisure and office space within one integrated high rise development complex to create a pleasant and extremely convenient urban living space, with both sale and lease components.\n\nOur superblocks provide consumers with an alternate way of living through our one-stop-living high quality Superblock developments, which offer the possibility for a balanced and pleasant urban lifestyle to thousands of consumers.\n\nCapitalizing on our network and good brand name, our strong and experienced marketing team is typically able to generate strong advance interest for cash generation through sales, deposits, and installments. We also pay close attention to the mix of revenues streams coming from sales versus recurring revenues.','622129034567',NULL,'O3cnoxGj1bNyCg7EoBCuRFQbgODhi1wLOMiUMT8C.png','JKB','N','2019-10-09 17:21:18','2019-10-09 17:31:40',1),('DEV0002','PT Graha Meruya','PT Graha Meruya','pt-graha-meruya','Jalan Meruya Ilir No.88, Business Park, Gedung Kencana Tower','graha_meruya','$2y$12$z8ztWOTUnjjMS/ikmXV0xePgHZDCwW1sbFae1U6b30A6UUiHM7wDe','grahameruya@gmail.com','PT Graha Meruya telah dikenal sebagai sebuah perusahaan developer terpercaya yang portfolio nya termasuk antara lain Graha Kencana Kebon Jeruk, Ruko Business Park Kebon Jeruk, dan MAQNA Residence.\n\nBusiness Park Kebon Jeruk adalah sebuah tower perkantoran dengan 190 ruko, parkir basement, dan genset. MAQNA Residence adalah sebuah proyek residensial yang menarik oleh PT Graha Meruya yang terletak di dalam Business Park Kebon Jeruk, MAQNA Residence menawarkan sebuah hunian ekslusif dengan lokasi strategis tepat di jantung kota Jakarta Barat dengan fasilitas bintang lima dan fasilitas-fasilitas pendukung lainnya di sekitar apartemen.','02158900518',NULL,'Nc4OUd7rq0MnzOhNL7iOwCnZoFfco2T3pXVncpoE.jpeg','JKB','N','2019-10-09 23:10:44','2019-10-09 23:20:56',2);

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

insert  into `log_project_request`(`log_id`,`log_message`,`request_id`,`log_date`) values (1,'Sony Darmawan mengajukan pemesanan unit Apartemen Maqna Residence Tipe 2 Bedroom','REQ201910100001','2019-10-10 21:49:54'),(2,'Sony Darmawan membatalkan pengajuan pemesanan unit','REQ201910100001','2019-10-10 21:50:04'),(3,'Sony Darmawan mengajukan pemesanan unit Apartemen Maqna Residence Tipe 3 Bedroom','REQ201910100002','2019-10-10 21:50:17'),(4,'Marketing Graha Meruya mengundang Sony Darmawan untuk meeting & survey lokasi bersama.','REQ201910100002','2019-10-10 22:51:15'),(5,'Marketing Graha Meruya telah membatalkan jadwal meeting.','REQ201910100002','2019-10-10 22:52:04'),(6,'Marketing Graha Meruya me-revisi jadwal meeting.','REQ201910100002','2019-10-10 22:53:59'),(7,'Sony Darmawan telah menerima undangan meeting.','REQ201910100002','2019-10-10 22:55:14'),(8,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910100002','2019-10-10 22:56:36'),(9,'Developer menolak pesanan pelanggan.','REQ201910100002','2019-10-10 22:58:17'),(10,'Sony Darmawan mengajukan pemesanan unit Apartemen Maqna Residence Tipe 2 Bedroom','REQ201910100003','2019-10-10 23:13:51'),(11,'Marketing Graha Meruya mengundang Sony Darmawan untuk meeting & survey lokasi bersama.','REQ201910100003','2019-10-10 23:16:26'),(12,'Sony Darmawan telah menolak undangan meeting.','REQ201910100003','2019-10-10 23:17:00'),(13,'Marketing Graha Meruya me-revisi jadwal meeting.','REQ201910100003','2019-10-10 23:17:50'),(14,'Sony Darmawan telah menerima undangan meeting.','REQ201910100003','2019-10-10 23:18:26'),(15,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910100003','2019-10-10 23:20:35'),(16,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910100003','2019-10-10 23:23:01'),(17,'Rizqy Caesario mengajukan pemesanan unit Apartemen Maqna Residence Tipe 3 Bedroom','REQ201910100004','2019-10-10 23:26:31'),(18,'Marketing Graha Meruya mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910100004','2019-10-10 23:29:02'),(19,'Rizqy Caesario telah menerima undangan meeting.','REQ201910100004','2019-10-10 23:31:42'),(20,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910100004','2019-10-10 23:33:29'),(21,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910100004','2019-10-10 23:34:15'),(22,'Nanami Okuhara mengajukan pemesanan unit Podomoro Park Bandung Tipe 6','REQ201910100005','2019-10-10 23:40:21'),(23,'Marketing Gallery Head Office mengundang Nanami Okuhara untuk meeting & survey lokasi bersama.','REQ201910100005','2019-10-10 23:41:28'),(24,'Nanami Okuhara telah menerima undangan meeting.','REQ201910100005','2019-10-10 23:42:26'),(25,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910100005','2019-10-10 23:43:40'),(26,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910100005','2019-10-10 23:44:30'),(27,'Nanami Okuhara mengajukan pemesanan unit Podomoro Park Bandung Tipe 7','REQ201910100006','2019-10-10 23:46:41'),(28,'Marketing Gallery Head Office mengundang Nanami Okuhara untuk meeting & survey lokasi bersama.','REQ201910100006','2019-10-10 23:50:15'),(29,'Nanami Okuhara telah menerima undangan meeting.','REQ201910100006','2019-10-10 23:50:25'),(30,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910100006','2019-10-10 23:51:02'),(31,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910100006','2019-10-10 23:52:17');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `marketing_user` */

insert  into `marketing_user`(`mkt_user_id`,`mkt_fullname`,`mkt_email`,`mkt_username`,`mkt_password`,`mkt_phone_number`,`mkt_mobile_phone`,`mkt_address`,`mkt_profile_photo`,`dev_user_id`,`city_id`,`created_at`,`updated_at`,`seqid`) values ('MKT0001','Marketing Gallery Head Office','mkt.ho@agungpodomoroland.com','mkt_podomoro','$2y$12$LwmE7HeGAp38pOQx4VgFsOUF3dAwTZ3uDXDRLgcsD.BLtGXfsbFNe','02150088938','08561927949489','APL Tower 43rd Floor, Podomoro City Jl. Let. Jend. S. Parman Kav. 28 Jakarta 11470',NULL,'DEV0001','JKB','2019-10-09 23:26:17','2019-10-09 23:41:31',1),('MKT0002','Marketing Graha Meruya','mkt_graha_meruya@grahameruya.com','mkt_graha_meruya','$2y$12$e.vUrlk.AH8twNStlGo1DuGWsoPbfd7KUckYYCvxT0WiJctfBhQsm','02150088999','089898888',NULL,NULL,'DEV0002','JKB','2019-10-10 16:14:46','2019-10-10 16:14:46',2);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

insert  into `meeting_appointment`(`meeting_id`,`meeting_time`,`meeting_status`,`request_id`,`meeting_note`,`meeting_result`,`document_file`,`created_by`,`updated_by`,`created_at`,`updated_at`,`seqid`) values ('MEETING1910100001','2019-10-12 12:00:00','done','REQ201910100002','Terima kasih atas ketertarikan Anda untuk membeli properti Apartemen Maqna Residence Tipe 3 Bedroom. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilaksanakan.','result_tj4XiCBsN9l5vJVGSmbxktzua1OYJ2DABwW1AiEv.pdf','Marketing Graha Meruya','Marketing Graha Meruya','2019-10-10 22:51:15','2019-10-10 22:56:36',1),('MEETING1910100002','2019-10-12 14:00:00','done','REQ201910100003','Terima kasih atas ketertarikan Anda untuk membeli properti Apartemen Maqna Residence Tipe 2 Bedroom. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai','result_lH2CMG03zphkHtqrEIztmDY1yPN0Y79NyKGwEkWd.pdf','Marketing Graha Meruya','Marketing Graha Meruya','2019-10-10 23:16:26','2019-10-10 23:20:35',2),('MEETING1910100003','2019-10-12 13:00:00','done','REQ201910100004','Terima kasih atas ketertarikan Anda untuk membeli properti Apartemen Maqna Residence Tipe 3 Bedroom. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilakukan.','result_CB8oo3DF1cZyw6S4algQnBnJzetLYFAwRPYPFIEY.pdf','Marketing Graha Meruya','Marketing Graha Meruya','2019-10-10 23:29:01','2019-10-10 23:33:29',3),('MEETING1910100004','2019-10-10 13:00:00','done','REQ201910100005','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Park Bandung Tipe 6. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilakukan.','result_9pCBVhSCD6hnNgvULd8ovZDrbkNMrAmiM1CRVQsG.pdf','Marketing Gallery Head Office','Marketing Gallery Head Office','2019-10-10 23:41:28','2019-10-10 23:43:40',4),('MEETING1910100005','2019-10-10 09:00:00','done','REQ201910100006','Terima kasih atas ketertarikan Anda untuk membeli properti Podomoro Park Bandung Tipe 7. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilakukan','result_yJEvS6NjjFpuIaEbNGTqZafX07YrVo2lxeTHtZgS.pdf','Marketing Gallery Head Office','Marketing Gallery Head Office','2019-10-10 23:50:14','2019-10-10 23:51:02',5);

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(50) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`project_id`) values (1,'s6m4RdYqOlcv4xXiYIVkzqCr6XoZrTd02DcARcK3.jpeg','PRY0001'),(3,'lCP5tm5VG7UpneM48dzG8ovf3Pm18qWAuY2reqRT.jpeg','PRY0002'),(7,'2UFADswpA2pjI3KziGB6p9a8rIDJQ5aU9Wi0L3Yk.jpeg','PRY0004'),(8,'goMoYKigwenYPvhPqHOsbYEO26xOlrUBVrS2jkp3.jpeg','PRY0004');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_link_map`,`project_map_embed`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`,`city_id`,`seqid`) values ('PRY0001','PODOMORO PARK','podomoro-park','s6m4RdYqOlcv4xXiYIVkzqCr6XoZrTd02DcARcK3.jpeg','<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Agung Podomoro Land (APL) menghadirkan mahakarya terbarunya yaitu Podomoro Park Bandung, kawasan hunian yang terletak di tengah keindahan alam Bandung Selatan, seluas lebih dari 100 hektar. Konsep utama Podomoro Park terinsiprasi dari kawasan hunian berkelas dunia, yaitu Woodbrige di Irvine California serta desain masterplan dan landscape oleh Palmscape Singapore, sehingga Podomoro Park dapat dikategorikan sebagai&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\"><em>world class home resort</em></strong><span style=\"color: rgb(68, 68, 68);\">.</span></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Podomoro Park telah meraih penghargaan \"</span><strong style=\"color: rgb(68, 68, 68);\">The Best Premium Home Resort in West Java</strong><span style=\"color: rgb(68, 68, 68);\">\" dalam event Indonesia Property &amp; Bank Award 2018. Ini membuktikan bahwa Podomoro Park memiliki konsep kawasan terbaik dengan menghadirkan kekuatan elemen alam, dan menjadikannya kawasan hunian resort terbaik di Jawa Barat. Maka tak heran bila antusias pasar sangat tinggi untuk memiliki hunian ini, hingga Podomoro Park menerima penghargaan “</span><strong style=\"color: rgb(68, 68, 68);\">Most Favoured Premium Housing Estate</strong><span style=\"color: rgb(68, 68, 68);\">” dalam event Housing Estate Award 2018.</span></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Keunggulan Podomoro Park Bandung :</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">1.&nbsp;Konsep kawasan yang mengutamakan keselarasan dengan alam (</span><em style=\"color: rgb(68, 68, 68);\">harmony with nature</em><span style=\"color: rgb(68, 68, 68);\">)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">2. Memiliki 5 elemen alam sebagai hunian resort yaitu :</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Danau buatan yang membentang sepanjang 1 km di tengah kawasan</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Pepohonan rimbun dan collective garden</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Ruang terbuka hijau yang luas</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- View pegunungan Bandung Selatan</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Udara sejuk dari hembusan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">wind tunnel</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;pegunungan.</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">3.&nbsp;&nbsp;Fasilitas dan keamanan premium:</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;Memiliki&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">club house</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;yang dilengkapi dengan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">infinity pool, fitness center, jacuzzi,</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">tennis court</em><span style=\"color: rgb(68, 68, 68);\">,&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">basketball court, children play ground,</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;dan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">function hall</em></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Fasilitas Ibadah</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Tersedia&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">bike lane, jogging track by the lake, garden by the lake, viewing deck, gazebo</em><span style=\"color: rgb(68, 68, 68);\">,&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">shopshouse</em></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Commercial destination</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;seluas ±12 HA (Living Plaza, RS Awal Bros, Fasilitas Pendidikan, Pasar Modern (future development), dan lainnya)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Sistem penyediaan air bersih melalui PDAM</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;&nbsp;Memiliki instalasi&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">fiber optic</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;(telepon, TV kabel, &amp; internet)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;&nbsp;Keamanan kawasan dikelola secara professional (CCTV, kamera pengawas, security patrol, dan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">panic button</em><span style=\"color: rgb(68, 68, 68);\">).</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">4.&nbsp;Lokasi strategis, hanya sekitar 10 menit dari exit tol Buahbatu, atau 9 KM dari pusat Kota Bandung (Gedung sate)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">5.&nbsp;Percepatan pembangunan infrastruktur di wilayah Bandung Selatan menjadikannya sebagai kawasan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">sunrise</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;properti yang bernilai investasi tinggi. Kawasan Podomoro Park dilintasi jalur LRT Bandung Raya yang terintegrasi dengan kereta cepat Jakarta-Bandung</span></p><p><span style=\"color: rgb(68, 68, 68);\">6. Melalui keseluruhan konsep kawasan yang selaras dengan alam dan fasilitas yang disediakan, Podomoro Park memberikan experience living yang dapat meningkatkan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">level of health and happiness</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;keluarga Anda.</span></p><p><span style=\"color: rgb(68, 68, 68);\">7. Stasiun LRT depan Kawasan</span></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Podomoro Park Bandung menawarkan 6 tipe unit hunian, antara lain :</strong></p><p><br></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe 6 (Cluster Amagriya)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 7 (Cluster Amagriya)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 8 (Cluster Anapuri)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 9 (Cluster Anapuri)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Asoka (Cluster Padmagriya)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Ayana (Cluster Padmagriya)</span></li></ul><p><br></p>','Buahbatu, Bandung',NULL,NULL,'residensial','available',NULL,'DEV0001','2019-10-09 17:45:22','2019-10-09 17:45:22','BGD',1),('PRY0002','PODOMORO RIVER VIEW','podomoro-river-view',NULL,'<p><strong>Podomoro River View&nbsp;</strong>merupakan cluster perumahan baru di kawasan&nbsp;<em>new city</em>&nbsp;Podomoro Golf View yang dikembangkan oleh developer ternama dan terpercaya,&nbsp;<strong>Agung Podomoro Land</strong>. Didesain dengan konsep gaya hidup masa kini yang modern dan fleksibel, menghadirkan hunian dengan desain yang&nbsp;<em>simple</em>&nbsp;dan minimalis yang memberikan nilai lebih untuk Anda yang menginginkan hunian di kawasan kota baru yang hidup dan terintegrasi.</p><p><br></p><p>Berada di kawasan&nbsp;<strong>Podomoro Golf View</strong>&nbsp;yang merupakan pengembangan kota Baru di atas lahan seluas 60 Ha, perumahan ini dikelilingi oleh golf area dan berbatasan dengan aliran sungai Cikeas. Sehingga memberikan kawasan perumahan bernuansa hijau dengan udara yang segar.</p><p><br></p><p>Sebagai hunian di kawasan terpadu yang megutamakan efisiensi, kawasan Podomoro Golf View menyediakan berbagai fasilitas penunjang yang lengkap serta akan terintegrasi dengan sarana transportasi umum&nbsp;<em>Light Rail Transit&nbsp;</em>(LRT) di dalam kawasan. Letaknya yang hanya 100 m dari exit tol Cimanggis juga memberikan kemudahan akses bagi penghuninya untuk mobilisasi sehari-hari.</p><p><br></p><p><strong>Keunggulan dari Podomoro River View:</strong></p><p><br></p><ul><li>Dikembangkan oleh developer terpercaya serta berpengalaman,&nbsp;<strong>Agung Podomoro Land</strong></li><li>Lokasi yang sangat strategis, tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock dengan berbagai fasilitas penunjang yang lengkap</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li>30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><br></p><p><strong>Lokasi:&nbsp;</strong>Jalan Raya Tol Jagorawi KM 19, Cimanggis, Depok – Jawa Barat</p><p><br></p><p><strong>Fasilitas yang terdapat pada Podomoro River View, yaitu:</strong></p><p><br></p><ul><li>Sistem satu gerbang</li><li>CCTV 24 Jam</li><li>Kolam renang</li><li>Fitness Center</li><li>Lapangan Basket</li><li>Taman Bermain Anak</li><li><em>Food and Beverage Riverside</em></li><li><em>Foot Reflexology</em></li><li><em>Club House</em></li><li><em>Linear Park &amp; Garden</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li>BBQ Area</li></ul><p><br></p><p><strong>Tipe unit yang ditawarkan Podomoro River View, antara lain:</strong></p><p><br></p><ul><li class=\"ql-align-justify\">Podomoro River View - Jupiter Tipe 6x12</li></ul><p><br></p>','Cimanggis, Depok',NULL,NULL,'residensial','available',NULL,'DEV0001','2019-10-09 17:55:24','2019-10-09 18:03:04','DPK',3),('PRY0004','MAQNA RESIDENCE','maqna-residence','goMoYKigwenYPvhPqHOsbYEO26xOlrUBVrS2jkp3.jpeg','<p class=\"ql-align-justify\"><strong>Apartemen Maqna Residence</strong>&nbsp;adalah sebuah hunian eksklusif dan privat yang terletak di jantung pusat bisnis Jakarta Barat dengan akses mudah menuju tempat bisnis, bersantai, dan gaya hidup. Apartemen ini dikelilingi oleh mall, hotel, gedung kantor, rumah sakit internasional (Siloam Hospitals, Graha Kedoya, Pondok Indah Hospital Puri, Jakarta Eye Center, Bio Medika Kebon Jeruk), sekolah internasional (Sekolah Pelita Harapan, Bina Bangsa School, SIS, IPEKA Puri, IPEKA International School, Tunas Muda International School, universitas (Binus, Untar, UPH), restoran, cafe, salon, supermarket, dan bisnis lainnya.</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">Gedung apartemen Maqna Residence terletak di dalam Business Park Kebon Jeruk dan memiliki akses mudah ke beberapa jalan tol (tol Jakarta-Merak, tol JORR, dan tol dalam kota). Apartemen ini dibangun diatas lahan seluas 7000 m2 dengan jumlah unit 380 unit serta dilengkapi dengan fasilitas lengkap bintang 5. Maqna Residence menargetkan kelas menengah sebagai mayoritas penghuninya dengan menawarkan panorama kota Jakarta dari apartemen 22 lantai.</p><p class=\"ql-align-justify\"><br></p><p><strong>Keunggulan dari Apartemen Maqna Residence</strong></p><p><br></p><ul><li>Apartemen Tipe Mezanine Loft, konsep 2 lantai yang prestisius.</li><li>Lokasi strategis terletak di jantung kota Jakarta Barat.</li><li>Berada di komplek Business Park Kebon Jeruk.</li><li>5 menit ke Jalan Panjang.</li><li>10 menit ke Puri Indah.</li><li>10 menit ke Toll JORR, Tol Tomang.</li><li>Dilengkapi dengan sistem keamanan 24 jam serta parkir basement tersedia.</li><li>Didukung dengan fasilitas lengkap *5.</li></ul><p><br></p><p class=\"ql-align-justify\"><strong>Alamat Lokasi Maqna Residence :</strong>&nbsp;Jalan Meruya Ilir Raya No. 88, Meruya Utara, Kebon Jeruk – Jakarta Barat.</p><p class=\"ql-align-justify\"><br></p><p><strong>Apartemen Maqna Residence menawarkan 2 tipe unit hunian, yaitu :</strong></p><p><br></p><ul><li>Tipe 2 BR (SGA 76 m2 &amp; SGA 80 m2)</li><li>Tipe 3 BR (SGA 138,8 m2)</li></ul><p><br></p><p><strong>Fasilitas yang terdapat pada Apartemen Maqna Residence, yaitu :</strong></p><p><br></p><ul><li>Sky Terrace</li><li>Pusat Kebugaran</li><li>Ruang Serba Guna</li><li>Ruang Pertemuan</li><li>Restoran</li><li>Lounge</li><li>ATM Center</li><li>Kartu Akses</li><li>CCTV</li></ul><p><br></p>','Jl. Raya Meruya Ilir Kav. 88, Meruya Utara, Jakarta Barat 11620','https://goo.gl/maps/6zZnmFMzHFtSCtch8','<iframe src=\"https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15866.01621014589!2d106.7618527!3d-6.197031!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xde103bd9f5273f15!2sMAQNA%20Residence!5e0!3m2!1sid!2sid!4v1570637564066!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','apartemen','sold',NULL,'DEV0002','2019-10-09 23:13:20','2019-10-10 23:34:38','JKB',5);

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
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_req_unit_type_idx` (`unit_type_id`),
  KEY `fk_req_cust_idx` (`customer_id`),
  KEY `fk_req_dev_user_idx` (`dev_user_id`),
  CONSTRAINT `fk_req_cust_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_dev_user_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

insert  into `project_request`(`request_id`,`dev_user_id`,`customer_id`,`unit_type_id`,`request_message`,`status_request`,`isReviewed`,`created_at`,`updated_at`,`seqid`) values ('REQ201910100001','DEV0002','CUST0001','UNIT0007','Halo PT Graha Meruya, saya ingin mengajukan pemesenan unit Apartemen Maqna Residence Tipe 2 Bedroom.','cancel','N','2019-10-10 21:49:54','2019-10-10 21:50:04',1),('REQ201910100002','DEV0002','CUST0001','UNIT0006','Halo PT Graha Meruya, saya ingin mengajukan pemesenan unit Apartemen Maqna Residence Tipe 3 Bedroom.','reject','Y','2019-10-10 21:50:17','2019-10-10 22:58:17',2),('REQ201910100003','DEV0002','CUST0001','UNIT0007','Halo PT Graha Meruya, saya ingin mengajukan pemesenan unit Apartemen Maqna Residence Tipe 2 Bedroom.','accept','Y','2019-10-10 23:13:51','2019-10-10 23:23:01',3),('REQ201910100004','DEV0002','CUST0002','UNIT0006','Halo PT Graha Meruya, saya ingin mengajukan pemesenan unit Apartemen Maqna Residence Tipe 3 Bedroom.','accept','Y','2019-10-10 23:26:31','2019-10-10 23:34:15',4),('REQ201910100005','DEV0001','CUST0003','UNIT0001','Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit Podomoro Park Bandung Tipe 6.','accept','Y','2019-10-10 23:40:21','2019-10-10 23:44:30',5),('REQ201910100006','DEV0001','CUST0003','UNIT0004','Halo PT Agung Podomoro Land Tbk, saya ingin mengajukan pemesenan unit Podomoro Park Bandung Tipe 7.','accept','Y','2019-10-10 23:46:41','2019-10-10 23:52:17',6);

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(60) NOT NULL,
  `unit_type_id` varchar(8) NOT NULL,
  PRIMARY KEY (`unit_gallery_id`),
  KEY `fk_unit_gallery_unit_type_idx` (`unit_type_id`),
  CONSTRAINT `fk_unit_gallery_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`) values (1,'unit-mswNjqzepBYdzA4n2LRrTaLzjZolyTP8V8CpTI6v.jpeg','UNIT0001'),(2,'unit-1HE7PcPXQV9wo9FgZnEP6jy6k7xlaNrqzWDgS6hV.jpeg','UNIT0001'),(3,'unit-gh2vIAyLE7cA2ByYNkhxb8jSinAOvzMMCOkf7cti.jpeg','UNIT0001'),(4,'unit-6rbKqm9CaDoCqxUAD7RVaX506u0AdDNo9VcUROC1.jpeg','UNIT0001'),(5,'unit-CUH0RkTkvpzAsf4T3otl9GuqV7FXQoMCOopEerLB.jpeg','UNIT0001'),(6,'unit-cP3cnWRrZafn7wln9nPlNNjLrcBbYZTbUWB53lqN.jpeg','UNIT0001'),(40,'unit-LH5lSI6Nw6Iq5QPxGW3yl09t9Uoo0F1HEh8dnss7.jpeg','UNIT0004'),(41,'unit-BViGjvUfVyPPbJr1buNMen1YZGcuChCV8vEsKvHQ.jpeg','UNIT0004'),(42,'unit-Gvozgu2WHGF93wBZn1za15TQgJeFlgZ1c1xsDY2E.jpeg','UNIT0004'),(43,'unit-LFOdr71daW47QPKBnSfR3Q9cfwSPcQHVn6F9Jafv.jpeg','UNIT0004'),(44,'unit-h3QCx3JjsR2fefGLDZM8xeN35vKBTKPqVbk6dC8H.jpeg','UNIT0004'),(45,'unit-T8C06Ru7wZEehHJ8cBWJjcBX0kaXAVYjHa0chFLf.jpeg','UNIT0004'),(46,'unit-zOuODAz4jPYQR3kEdIDE9BaRUb3mKsRweg5ASdGE.jpeg','UNIT0004'),(47,'unit-pkihHv79Sc4a6nQfvJPt8G1r88QsopWr3yy5BL2w.jpeg','UNIT0004'),(48,'unit-5c0ECr42xIc4zj0L3aFxSPgm06jTj51HxvcppeR6.jpeg','UNIT0004'),(49,'unit-yvRilUQDNrCqHPNPpCtd7yCAu4LOEAzCILoukeNr.jpeg','UNIT0005'),(50,'unit-vmwzWVYG8zgXbaKStilhbsQBTfxkXb6i6SfFjqt4.jpeg','UNIT0005'),(51,'unit-rv2Ex5kFh75F1SzAtSUfk6zV8BUA6MlsUNN5tTpP.jpeg','UNIT0005'),(52,'unit-M33wXbfksg2F4p6VkCxljOMiPQQSbwd20Va5Xs19.jpeg','UNIT0005'),(53,'unit-20gdDjp1T276deNqxqRR4Ojm7gpBO0A3DAogJbUD.jpeg','UNIT0005'),(54,'unit-bF8thJ99UU2AhFRDSEoufJeY1Wcv5bduvXYoBCkT.jpeg','UNIT0005'),(55,'unit-rD0I5PCw3zyV1nZqQNoWmFj67wsZ2TEI1cwLIX0W.jpeg','UNIT0005'),(56,'unit-4l6NEyF1HDhDosv8izG6XQgLDfBY68y49A1JMUge.jpeg','UNIT0005'),(57,'unit-z7SAKmIwuGydAglDdm3wFE8DJeWtTcXGZ6KmeYbo.jpeg','UNIT0005'),(58,'unit-bOPvuh2EPeTVvExsJ73Y3dMXyiKaG6I8G7D09VlD.jpeg','UNIT0005'),(59,'unit-zN5LF1zOl915Zv49cQIsCkICk2pWDyVIfB82Kn9v.jpeg','UNIT0005'),(60,'unit-SJ8uw7VYWW3l3hZRMn6IivCyfw13ziVs6BJarXdM.jpeg','UNIT0006'),(61,'unit-oWOmmUcucrnbgRddNRbwYYm4vaCbNkRpuYCvFzcc.jpeg','UNIT0006'),(62,'unit-HeryuYlYeMaodou65pqoILbSY3hUMWAMJUykgxvl.jpeg','UNIT0006'),(63,'unit-AtGik9yZCZ9QcDuXbK0W72dQIPhRTvweavxYMCtG.jpeg','UNIT0006'),(64,'unit-2v3qK9X2MDiTc3kGNaYVZ8y1o6FFHbJLowlFQBHq.jpeg','UNIT0006'),(65,'unit-huM8uGIOFXYMWNQxYlrkMTvzwJ2aQovzob4jlegZ.jpeg','UNIT0006'),(66,'unit-oLfl5xVbB1B77TWEQjNB88MYhbnFH3ecb1Zpsl7d.jpeg','UNIT0006'),(67,'unit-7stkhDtePp3qSMqC3ylxMirxQYN96ibVqu7PLkvJ.jpeg','UNIT0006'),(68,'unit-gqqZcwRBuXZBVjeUapnEZVgIEh7B82tahgu98Ohn.jpeg','UNIT0006'),(69,'unit-VmuJNlooKRZEx1qn2gu39puECw7alnSkePdaUzob.jpeg','UNIT0006'),(70,'unit-nbdDnn36OExBbJKqC8E5JZzf5qBp9mRtVFjSz0ku.jpeg','UNIT0006'),(71,'unit-pTVQBdgBSpsvbmAMpLY6YkBsU1PYZeRS7r6jZzwd.jpeg','UNIT0006'),(72,'unit-tKtESL9ekB9IBm91gnBYlSOOj8lXcsmquFuwqaTL.jpeg','UNIT0007'),(73,'unit-vqNInXpzo8GzHrYyVOKAPgSA72IS2EHdNu2W2ocM.jpeg','UNIT0007'),(74,'unit-EHFSDRkjpa8C1WyrUm2Q8tXtY9ihgA6zkVOzhofg.jpeg','UNIT0007'),(75,'unit-EMmH5fEluJuC7wxtySqqjsXOb1wMxYrppvniY4y6.jpeg','UNIT0007'),(76,'unit-9J8LDGiBkhWcHheqRUB85WLclxFF8Qz0xpiLy4z4.jpeg','UNIT0007'),(77,'unit-GnFkx4RxJZmTXXCEvkis9A4LgtEfL7fD0MRNE31g.jpeg','UNIT0007');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_id`,`created_at`,`updated_at`,`seqid`) values ('UNIT0001','Podomoro Park Bandung Tipe 6','podomoro-park-bandung-tipe-6',2,94,90,2,3,1400000000,'<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">CLUSTER AMAGRIYA (DELUXE)</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 15 meter (Nalendra):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;90 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,4 milyar</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 17 meter (Kancana):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;102 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,5 milyar</span></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas premium yang disediakan oleh Podomoro Park Bandung, yaitu :</strong></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Club House</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Taman Bermain Anak</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Bike Lane</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Kolam Renang</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Community Garden</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gym</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gazebo</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Jogging Track</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Viewing Deck</em></p>','sold',3500,'Keamanan 24 Jam,Pendingin Ruangan (AC),Air Panas,Taman,Taman Bermain Anak,Halaman Terbuka,Telepon','unit-gh2vIAyLE7cA2ByYNkhxb8jSinAOvzMMCOkf7cti.jpeg','PRY0001','2019-10-09 21:33:19','2019-10-10 23:44:29',1),('UNIT0004','Podomoro Park Bandung Tipe 7','podomoro-park-bandung-tipe-7',2,127,126,3,3,2000000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER AMAGRIYA (DELUXE)</strong></p><p>Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 7 x 18 meter (Sanjaya):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;126 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;127 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</p><p>Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 2 milyar</p><p><strong>Fasilitas premium yang disediakan oleh Podomoro Park Bandung, yaitu :</strong></p><p>-&nbsp;<em>Club House</em></p><p>- Taman Bermain Anak</p><p>-&nbsp;<em>Bike Lane</em></p><p>- Kolam Renang</p><p>-&nbsp;<em>Community Garden</em></p><p>-&nbsp;<em>Gym</em></p><p>-&nbsp;<em>Gazebo</em></p><p>-&nbsp;<em>Jogging Track</em></p><p>-&nbsp;<em>Viewing Deck</em></p>','sold',3500,'Keamanan 24 Jam,Telepon,Pendingin Ruangan (AC),Kolam Renang,Air Panas,Balkon,Taman,Taman Bermain Anak','unit-5c0ECr42xIc4zj0L3aFxSPgm06jTj51HxvcppeR6.jpeg','PRY0001','2019-10-09 22:48:34','2019-10-10 23:52:17',4),('UNIT0005','Podomoro River View – Jupiter Tipe 6x12','podomoro-river-view-jupiter-tipe-6x12',1,74,45,2,1,1111850000,'<p class=\"ql-align-justify\"><strong>Podomoro River View – Jupiter Tipe 6x12&nbsp;</strong>merupakan tipe rumah 1 lantai yang dilengkapi dengan;</p><ul><li class=\"ql-align-justify\">Luas bangunan 45 m2</li><li class=\"ql-align-justify\">Luas tanah 72 m2</li><li class=\"ql-align-justify\">2 Kamar tidur</li><li class=\"ql-align-justify\">1 Kamar mandi</li><li class=\"ql-align-justify\">Ruang tamu/keluarga</li><li class=\"ql-align-justify\">Ruang makan</li><li class=\"ql-align-justify\">Dapur</li><li class=\"ql-align-justify\">Halaman belakang</li><li class=\"ql-align-justify\">Lantai mezzanine (optional)</li><li class=\"ql-align-justify\">Carport untuk 1 mobil</li><li class=\"ql-align-justify\">Harga mulai dari Rp. 1.111.850.000</li></ul><p class=\"ql-align-justify\"><strong>Jupiter Tipe 6x12 terdiri dari 3 tipe desain hunian, yaitu:</strong></p><ul><li class=\"ql-align-justify\">Tipe Wood</li><li class=\"ql-align-justify\">Tipe Stone</li><li class=\"ql-align-justify\">Tipe Cutting GRC</li></ul><p><strong>Keunggulan dari Podomoro River View:</strong></p><ul><li>Dikembangkan oleh developer terpercaya serta berpengalaman,&nbsp;<strong>Agung Podomoro Land</strong></li><li>Lokasi yang sangat strategis, tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock dengan berbagai fasilitas penunjang yang lengkap</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li class=\"ql-align-justify\">30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><strong>Fasilitas yang terdapat pada Podomoro River View, yaitu:</strong></p><ul><li>Sistem satu gerbang</li><li>CCTV 24 Jam</li><li>Kolam renang</li><li>Fitness Center</li><li>Lapangan Basket</li><li>Taman Bermain Anak</li><li><em>Golf View 360o</em></li><li><em>Food and Beverage Riverside</em></li><li><em>Foot Reflexology</em></li><li><em>Club House</em></li><li><em>Linear Park &amp; Garden</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li class=\"ql-align-justify\">BBQ Area</li></ul><p><br></p>','available',3300,'Keamanan 24 Jam,Telepon,Gym,Taman,Taman Bermain Anak,Kolam Renang,Halaman Terbuka','unit-rv2Ex5kFh75F1SzAtSUfk6zV8BUA6MlsUNN5tTpP.jpeg','PRY0002','2019-10-09 23:02:58','2019-10-09 23:03:33',5),('UNIT0006','Apartemen Maqna Residence Tipe 3 Bedroom','apartemen-maqna-residence-tipe-3-bedroom',1,127,NULL,3,2,3399900000,'<p class=\"ql-align-justify\"><strong>Apartemen Maqna Residence Tipe 3 Bedroom</strong>&nbsp;merupakan tipe apartemen mezanine loft dengan konsep 2 lantai yang memiliki 3 kamar tidur, 2 kamar mandi dengan luas bangunan semi gross 138,8 m2. Selain itu, dilengkapi dengan ruang tamu, ruang makan, dan pantry. Tipe ini memiliki kapasitas listrik sebesar 6600 watt.</p><ul><li>Harga yang ditawarkan mulai dari Rp. 3.399.900.000 - Rp. 3.475.500.000.</li></ul><p><strong>Keunggulan dari Apartemen Maqna Residence</strong></p><ul><li>Apartemen Tipe Mezanine Loft, konsep 2 lantai yang prestisius.</li><li>Lokasi strategis terletak di jantung kota Jakarta Barat.</li><li>Berada di komplek Business Park Kebon Jeruk.</li><li>5 menit ke Jalan Panjang.</li><li>10 menit ke Puri Indah.</li><li>10 menit ke Toll JORR, Tol Tomang.</li><li>Dilengkapi dengan sistem keamanan 24 jam serta parkir basement tersedia.</li><li>Didukung dengan fasilitas lengkap *5.</li></ul><p><strong>Fasilitas yang terdapat pada Apartemen Maqna Residence, yaitu :</strong></p><ul><li>Sky Terrace</li><li>Pusat Kebugaran</li><li>Ruang Serba Guna</li><li>Ruang Pertemuan</li><li>Restoran</li><li>Lounge</li><li>ATM Center</li><li>Kartu Akses</li><li>CCTV</li></ul><p><br></p>','sold',6600,'Telepon,Gym,Taman Bermain Anak,Secure Parking,Pendingin Ruangan (AC),Kolam Renang,Keamanan 24 Jam','unit-AtGik9yZCZ9QcDuXbK0W72dQIPhRTvweavxYMCtG.jpeg','PRY0004','2019-10-09 23:15:05','2019-10-10 23:34:15',6),('UNIT0007','Apartemen Maqna Residence Tipe 2 Bedroom','apartemen-maqna-residence-tipe-2-bedroom',1,NULL,NULL,2,2,1782900000,'<p class=\"ql-align-justify\"><strong>Maqna Residence Apartemen Tipe 2 Bedroom</strong>&nbsp;merupakan tipe apartemen mezanine loft dengan konsep 2 lantai yang memiliki 2 kamar tidur, 2 kamar mandi dengan luas bangunan semi gross yang bervariasi antara 76 m2 sampai dengan 80 m2. Selain itu, dilengkapi dengan ruang tamu, ruang makan, dan pantry. Tipe ini memiliki kapasitas listrik sebesar 4400 watt. Harga yang ditawarkan untuk tipe 2 bedroom, yaitu :</p><ul><li class=\"ql-align-justify\">2 BR (76 m2) ; Rp. 1.782.900.000 – Rp. 1.814.400.000</li><li>2 BR (80 m2) ; Rp. 1.876.350.000 – Rp. 1.971.900.000</li></ul><p><strong>Keunggulan dari Apartemen Maqna Residence</strong></p><ul><li>Apartemen Tipe Mezanine Loft, konsep 2 lantai yang prestisius.</li><li>Lokasi strategis terletak di jantung kota Jakarta Barat.</li><li>Berada di komplek Business Park Kebon Jeruk.</li><li>5 menit ke Jalan Panjang.</li><li>10 menit ke Puri Indah.</li><li>10 menit ke Toll JORR, Tol Tomang.</li><li>Dilengkapi dengan sistem keamanan 24 jam serta parkir basement tersedia.</li><li>Didukung dengan fasilitas lengkap *5.</li></ul><p><strong>Fasilitas yang terdapat pada Apartemen Maqna Residence, yaitu :</strong></p><ul><li>Sky Terrace</li><li>Pusat Kebugaran</li><li>Ruang Serba Guna</li><li>Ruang Pertemuan</li><li>Restoran</li><li>Lounge</li><li>ATM Center</li><li>Kartu Akses</li><li>CCTV</li></ul><p><br></p>','sold',4400,'Gym,Taman Bermain Anak,Secure Parking,Kolam Renang,Pendingin Ruangan (AC),Telepon,Keamanan 24 Jam','unit-tKtESL9ekB9IBm91gnBYlSOOj8lXcsmquFuwqaTL.jpeg','PRY0004','2019-10-09 23:17:32','2019-10-10 23:23:01',7);

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

insert  into `verification_customer`(`hash_id`,`customer_id`,`expire_date`,`status_verify`,`created_at`,`updated_at`) values ('4e1e8179df3a4912f55bbc54aeaae1d62ef80b8e','CUST0002',1570616793,'Y','2019-10-09 16:46:58','2019-10-09 16:59:39'),('75f173ce75ef81ca3727567d336e22a319f45f43','CUST0001',1570615409,'Y','2019-10-09 16:33:29','2019-10-09 16:37:40'),('783d7f1ac28a0d080f99dca5ec1bee79e0c295a7','CUST0003',1570727193,'Y','2019-10-10 23:36:33','2019-10-10 23:37:15');

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
