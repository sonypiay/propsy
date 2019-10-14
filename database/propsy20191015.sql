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

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_logo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('DEV0001','PT Agung Podomoro Land Tbk','John Doe','pt-agung-podomoro-land-tbk','APL Tower 43rd Floor, Podomoro City\nJl. Let. Jend. S. Parman Kav. 28\nJakarta 11470 Indonesia\nwww.agungpodomoroland.com','podomoro','$2y$12$WpZeMVZo7G1VvB6E/bHoyOcyxg892PAtVKtT1PKJpKK37jG6/mWri','podomoro@agungpodomoro.com','PT Agung Podomoro Land Tbk. (APLN) is a leading integrated diversified real estate owner, developer and manager in the retail, commercial, and residential real estate segments with diversified holdings. We have an integrated property development model, from land acquisition and/or sourcing, to design and development, to project management, sales, commercial leasing and marketing, to the operation and management of our superblock developments, shopping malls, offices, hotels, and residential apartments and houses. We are known as a pioneer of the superblock development. Our high quality landmark projects, to name a few are Podomoro City, Kuningan City, and Senayan City.\n\nAPLN was established on July 30, 2004 under the name PT Tiara Metropolitan Jaya. In 2010, our shareholders completed a corporate restructuring, pursuant to which six developments and their holding companies were transferred to our control. APLN, is the flagship listed entity (IDX:APLN) of Agung Podomoro Group (APG), is one of the fastest growing and largest real estate developers in Indonesia with interests in superblocks, retail properties, office, apartments and residential, and hotels. APG established its first development, a housing complex in Simprug area, South Jakarta, in 1969 and completed its construction in 1973. From 1973 to present, members of APG completed or begun construction of more than 70 property projects, with majority addressed to middle class segments of society, with projects ranging from low cost apartments to high end apartments in South Jakarta, landed residentials, high end and the neighborhood mall, shop houses, hotels, soho and office towers.\n\nAPLN combines a visionary approach to design with an emphasis on rapid execution and time to market. Drawing on the experience and resources of the Agung Podomoro Group, we have been responsible for bringing a number of landmark properties on the market such as our flagship Podomoro City Complex and the high profile Senayan City. We also pioneered the superblock concept, bringing together residential, retail, leisure and office space within one integrated high rise development complex to create a pleasant and extremely convenient urban living space, with both sale and lease components.\n\nOur superblocks provide consumers with an alternate way of living through our one-stop-living high quality Superblock developments, which offer the possibility for a balanced and pleasant urban lifestyle to thousands of consumers.\n\nCapitalizing on our network and good brand name, our strong and experienced marketing team is typically able to generate strong advance interest for cash generation through sales, deposits, and installments. We also pay close attention to the mix of revenues streams coming from sales versus recurring revenues.','622129034567',NULL,'O3cnoxGj1bNyCg7EoBCuRFQbgODhi1wLOMiUMT8C.png','JKB','N','2019-10-09 17:21:18','2019-10-09 17:31:40',1),('DEV0002','Sharia Land','Sharia Land','sharia-land','Jl. Daarul Quran Blok C9-10 Kel. Loji, Kec. Bogor Barat, Kota Bogor','sharia_land','$2y$12$z8ztWOTUnjjMS/ikmXV0xePgHZDCwW1sbFae1U6b30A6UUiHM7wDe','grahameruya@gmail.com','Sharia Land – Developer Property Syariah\n\nSharia Land adalah perusahaan yang bergerak di bidang property, khususnya property syariah. Dimana property syariah itu sendiri adalah skema kepemilikan rumah tanpa Riba dan tanpa bank.\n\nSalah satu tujuan Sharia Land hadir di Indonesia adalah agar umat Muslim di Indonesia memiliki pilihan untuk mendapatkan rumah Syariah penuh keberkahan dan tidak lagi terjebak dalam jerat transaksi Ribawi yang sangat menjerumuskan dan juga mengerikan dosanya.\n\nTujuan selanjutnya adalah, Sharia Land ingin menjadi solusi permasalahan umat muslim saat ini yang cukup nyata namun jarang kita sadari bersama.\nYaitu masalah pengangguran, kemiskinan, dan ketidakberdayaan.\nBukan hanya menjadi solusi untuk kepemilikan rumah tanpa riba dengan segala fasilitas unggulan di dalamnya, namun Sharia Land juga mempunyai impian untuk menjadi alternatif solusi untuk kemandirian umat. Terutama di bidang Ekonomi.','+622131103838','08561969052','jSfNarF3OH8VNO0MWFXyobn78uLFNSRSUhdrfYKy.png','BGR','N','2019-10-09 23:10:44','2019-10-14 22:53:28',2);

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*Data for the table `log_project_request` */

insert  into `log_project_request`(`log_id`,`log_message`,`request_id`,`log_date`) values (32,'Sony Darmawan mengajukan pemesanan unit Rumah Sharia Tipe 2','REQ201910110001','2019-10-11 22:46:08'),(33,'Marketing Sharia Land mengundang Sony Darmawan untuk meeting & survey lokasi bersama.','REQ201910110001','2019-10-12 08:48:11'),(34,'Sony Darmawan telah menerima undangan meeting.','REQ201910110001','2019-10-12 08:51:26'),(35,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910110001','2019-10-12 08:59:05'),(36,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910110001','2019-10-12 09:31:36'),(37,'Rizqy Caesario mengajukan pemesanan unit Rumah Sharia Tipe 1','REQ201910120009','2019-10-12 10:32:09'),(38,'Marketing Sharia Land mengundang Rizqy Caesario untuk meeting & survey lokasi bersama.','REQ201910120009','2019-10-12 10:33:19'),(39,'Rizqy Caesario telah menerima undangan meeting.','REQ201910120009','2019-10-12 10:33:51'),(40,'Meeting telah selesai dilakukan. Dokumen telah diupload.','REQ201910120009','2019-10-12 10:36:45'),(41,'Developer menyetujui pesanan pelanggan. <br /> Unit telah terjual.','REQ201910120009','2019-10-12 10:38:55');

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

insert  into `marketing_user`(`mkt_user_id`,`mkt_fullname`,`mkt_email`,`mkt_username`,`mkt_password`,`mkt_phone_number`,`mkt_mobile_phone`,`mkt_address`,`mkt_profile_photo`,`dev_user_id`,`city_id`,`created_at`,`updated_at`,`seqid`) values ('MKT0001','Marketing Gallery Head Office','mkt.ho@agungpodomoroland.com','mkt_podomoro','$2y$12$LwmE7HeGAp38pOQx4VgFsOUF3dAwTZ3uDXDRLgcsD.BLtGXfsbFNe','02150088938','08561927949489','APL Tower 43rd Floor, Podomoro City Jl. Let. Jend. S. Parman Kav. 28 Jakarta 11470',NULL,'DEV0001','JKB','2019-10-09 23:26:17','2019-10-09 23:41:31',1),('MKT0002','Marketing Sharia Land','mkt_graha_meruya@grahameruya.com','mkt_sharia_land','$2y$12$e.vUrlk.AH8twNStlGo1DuGWsoPbfd7KUckYYCvxT0WiJctfBhQsm','02150088999','089898888',NULL,'wREP7AIValBbXa2hu1p345Srfkz52qNkzSZaYnAc.jpeg','DEV0002','BGR','2019-10-10 16:14:46','2019-10-11 22:04:28',2);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

insert  into `meeting_appointment`(`meeting_id`,`meeting_time`,`meeting_status`,`request_id`,`meeting_note`,`meeting_result`,`document_file`,`created_by`,`updated_by`,`created_at`,`updated_at`,`seqid`) values ('MEETING1910120001','2019-10-12 09:00:00','done','REQ201910110001','Terima kasih atas ketertarikan Anda untuk membeli properti Rumah Sharia Tipe 2. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing','Meeting telah selesai dilakukan','result_6hpirKO9ZSE4joOmxYy2WIb8JXptlBHsWZa06mMg.pdf','Marketing Sharia Land','Marketing Sharia Land','2019-10-12 08:48:11','2019-10-12 08:59:05',6),('MEETING1910120007','2019-10-13 10:00:00','done','REQ201910120009','Terima kasih atas ketertarikan Anda untuk membeli properti Rumah Sharia Tipe 1. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing Sharia Land','Meeting telah selesai dilaksanakan.','result_2EdCnw6PN7hFLcifdP85ebP3xa3ZQZnpKZoO4iDd.pdf','Marketing Sharia Land','Marketing Sharia Land','2019-10-12 10:33:18','2019-10-12 10:36:45',7);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `price_installment` */

insert  into `price_installment`(`id`,`unit_type_id`,`dp_price`,`installment_price`,`installment_tenor`) values (5,'UNIT0001',50000000,4535416,24),(6,'UNIT0001',30000000,7158333,18),(7,'UNIT0001',100000000,4904166,12),(8,'UNIT0009',37500000,5953625,16),(9,'UNIT0009',43250000,3729500,24);

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(50) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`project_id`) values (11,'H1RMhIxvpLFEFCgH5UOFk01bFLjUdQc3c8K5TA8P.jpeg','PRY0001'),(12,'fLCUD9YIDdg0EQUbaT7Y0QoMOvRYilyEqOeTYaYQ.jpeg','PRY0001'),(13,'b3UePYkaleu3qzpv83yUPLBBlxZ1xkjHN2gMBHAO.jpeg','PRY0001'),(14,'pFE2Umi82RNQ1FENBOPp1LipKOwsvq2hnccnqBXe.jpeg','PRY0001'),(15,'heGMbkRkVLFNoe2fA3ufHYAkRPppFpD5Dj0c2jId.jpeg','PRY0001'),(16,'nlI7ctQPaqYvKAsBnaRzjVAnPc9t1kAXT5eilJPv.jpeg','PRY0001');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_link_map`,`project_map_embed`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`,`city_id`,`seqid`) values ('PRY0001','Sharia Islamic Residence','sharia-islamic-residence','pFE2Umi82RNQ1FENBOPp1LipKOwsvq2hnccnqBXe.jpeg','<p>Tanah Kavling Yang Strategis dan Nyaman Untuk Tempat Tinggal Keluarga Anda</p><p>Mengingat lokasi&nbsp;Setu Bekasi&nbsp;sangat dekat sekali dengan kawasan industri MM 2100, Jababeka, Lippo Cikarang, Hyundai Comercial Estate, dll tentu akan diuntungkan dengan cepatnya pembangunan infrastruktur. Seperti : Tol Cimanggis – Cibitung (operating 2019), Tol layang Jakarta – Cikampek, Tol Cibitung -Cilincing (constructing 2018), LRT Bekasi Timur – Cikarang (constructing 2019).</p><p>Dengan banyaknya pembangunan infrastruktur yang di gagas pemerintah, akan semakin memudahkan penghuni<strong>&nbsp;</strong>untuk melakukan mobilisasi menuju pusat kota dan ibu kota Jakarta. Semakin lengkaplah hunian impian Anda selama ini.&nbsp;Dengan berbagai macam kemudahan dan lingkungan yang masih asri.</p>','Cikarang, Bekasi','https://goo.gl/maps/4WsqnkM8szCxR2xH6','<iframe src=\"https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15860.805823078828!2d107.020085!3d-6.3679697!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x375d548270d28b7b!2sSharia%20Islamic%20Residence!5e0!3m2!1sid!2sid!4v1570790050556!5m2!1sid!2sid\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\"></iframe>','residensial','sold',NULL,'DEV0002','2019-10-11 17:10:36','2019-10-14 21:26:09','BKS',6);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

insert  into `project_request`(`request_id`,`dev_user_id`,`customer_id`,`unit_type_id`,`request_message`,`status_request`,`isReviewed`,`created_at`,`updated_at`,`seqid`,`installment`) values ('REQ201910110001','DEV0002','CUST0001','UNIT0009','Halo Sharia Land, saya ingin mengajukan pemesenan unit Rumah Sharia Tipe 2.','accept','Y','2019-10-11 22:46:08','2019-10-12 09:31:36',8,9),('REQ201910120009','DEV0002','CUST0002','UNIT0001','Halo Sharia Land, saya ingin mengajukan pemesenan unit Rumah Sharia Tipe 1.','accept','Y','2019-10-12 10:32:08','2019-10-12 10:38:54',9,7);

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(60) NOT NULL,
  `unit_type_id` varchar(8) NOT NULL,
  PRIMARY KEY (`unit_gallery_id`),
  KEY `fk_unit_gallery_unit_type_idx` (`unit_type_id`),
  CONSTRAINT `fk_unit_gallery_unit_type_idx` FOREIGN KEY (`unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`) values (78,'unit-S1XfoNME0tdIairHqsgIyQWrpWZ4llbLPhu6fLdf.jpeg','UNIT0001'),(79,'unit-6HggPNknJmjFDBBiWtzfpcRvn6QUCil4jkc3w1oc.jpeg','UNIT0001'),(80,'unit-PYnNu2YnO68MGpXwhuEOJB081nWWUwFRKft5vgon.jpeg','UNIT0001'),(81,'unit-bt3ECrAXWIFdzhBPYwon5HTrMhixlozXxedvxu6i.jpeg','UNIT0001'),(82,'unit-k9yawXMBkpp3HB67QMIAY6H7p0BBx8kcWoQxoBG0.jpeg','UNIT0001'),(83,'unit-RPpPkQMGf9qg11ikaVHt9Lw7mumxlou815RUiEIM.jpeg','UNIT0001'),(84,'unit-U5ZXonc9gSNGDMMavRbhwqoFtOzVVYyItTmNFyLi.jpeg','UNIT0001'),(85,'unit-3ICbDqL8tcb6oPRXBWeQEk282BAhoHoPJLGIccaN.jpeg','UNIT0001'),(86,'unit-GtGboMey0JhWq0bf2dCA9AyyXf3HrJZFgzNjPT9X.jpeg','UNIT0009'),(87,'unit-Vi91qfJjY3FlPgtAQoI7xzqt6hzSXOskwZZx0IEm.jpeg','UNIT0009'),(88,'unit-Ev0cfhWgFP8eoB1gR4QKcmaKhEky8m7Q2HBjlmGR.jpeg','UNIT0009'),(89,'unit-mNHj9cvieRKNsJuQ17vwZ8jjNtXe3lsjDkuZs3wb.jpeg','UNIT0009');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_id`,`created_at`,`updated_at`,`seqid`) values ('UNIT0001','Rumah Sharia Tipe 1','rumah-sharia-tipe-1',2,56,60,3,2,158850000,'<p><span style=\"color: rgb(51, 51, 51);\">Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</span></p>','sold',3200,'Telepon,Air Panas,Akses Internet / Wifi,Pendingin Ruangan (AC),Garasi,Halaman Terbuka,Taman','unit-6HggPNknJmjFDBBiWtzfpcRvn6QUCil4jkc3w1oc.jpeg','PRY0001','2019-10-11 17:45:57','2019-10-12 10:38:54',8),('UNIT0009','Rumah Sharia Tipe 2','rumah-sharia-tipe-2',2,30,60,2,1,132758000,'<p>Jawa Ipsum gelung kalung ayam manah jawah, luh bebed kancing. Sapu sima peksi susu piring tuwi enjing mucal dipun pendhet wos? Peksi cariyos, sakit suku epek-epek ngulemi pedhang, untu manah nyukani maesa. Bidal minggat supena ngulemi? Peksi dhateng, kangge; kinten nyepeng ayam toya peksi, \"sima wilujeng maos sirah kuping ngadeg dolan makarya.\" Jejeran wawarat embok saweg mantun ajrih benang ningali gujeng pedhang tumut swanten awon.</p><p>Sekar inggih surya kangge; gegriya purun mripat aken kajang. Dangu dhateng iket cepeng kekesahan madeg ilat benter, gelung sima, cemeng. Supe tangan, dhuwung ningali pupak manah kepireng mangga nanem wiar epek-epek sumerep yatra sekar nanem tirah.</p><p>Segawon <a href=\"http://sikatsuket.blogspot.com/\" rel=\"noopener noreferrer\" target=\"_blank\">nyukani ulem-ulem</a> cawis kalung kula sirah; gujeng nedha. Cariyos nanem surya kathok nginten lenggah, tetak unyeng-unyeng wicanten gulu.</p>','sold',2200,'Telepon,Pendingin Ruangan (AC),Air Panas','unit-GtGboMey0JhWq0bf2dCA9AyyXf3HrJZFgzNjPT9X.jpeg','PRY0001','2019-10-11 21:19:26','2019-10-12 09:31:35',9);

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
