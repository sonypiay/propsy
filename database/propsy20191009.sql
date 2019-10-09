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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`customer_email`,`customer_address`,`customer_phone_number`,`customer_username`,`customer_password`,`customer_photo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('CUST0001','Sony Darmawan','sonypiay@mail.com','Jl. Intan Baiduri No. 28','08561969052','sonypiay','$2y$12$q2mcbtimnqFFUKSBcVViX.0MeX7j2kEBmaMpEkx8SwEsoZiPi7G3O','o7rXFSKErnKq8klnbqWaSZhvjody9Gd2mWjw0oob.jpeg','JKP','Y','2019-10-09 16:33:28','2019-10-09 16:41:10',1),('CUST0002','Rizqy Caesario','rizqycaesario@gmail.com','Tambora, Jakarta Barat','08998888','rizqycaesario','$2y$12$cP/TJagZ45itZ6Wksb8N4.w9ZSbHi42fOvi9Dvs4fBiw366hXhdT6',NULL,'JKB','Y','2019-10-09 16:46:58','2019-10-09 16:59:39',2);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_logo`,`city_id`,`status_verification`,`created_at`,`updated_at`,`seqid`) values ('DEV0001','PT Agung Podomoro Land Tbk','John Doe','pt-agung-podomoro-land-tbk','APL Tower 43rd Floor, Podomoro City\nJl. Let. Jend. S. Parman Kav. 28\nJakarta 11470 Indonesia\nwww.agungpodomoroland.com','podomoro','$2y$12$WpZeMVZo7G1VvB6E/bHoyOcyxg892PAtVKtT1PKJpKK37jG6/mWri','podomoro@agungpodomoro.com','PT Agung Podomoro Land Tbk. (APLN) is a leading integrated diversified real estate owner, developer and manager in the retail, commercial, and residential real estate segments with diversified holdings. We have an integrated property development model, from land acquisition and/or sourcing, to design and development, to project management, sales, commercial leasing and marketing, to the operation and management of our superblock developments, shopping malls, offices, hotels, and residential apartments and houses. We are known as a pioneer of the superblock development. Our high quality landmark projects, to name a few are Podomoro City, Kuningan City, and Senayan City.\n\nAPLN was established on July 30, 2004 under the name PT Tiara Metropolitan Jaya. In 2010, our shareholders completed a corporate restructuring, pursuant to which six developments and their holding companies were transferred to our control. APLN, is the flagship listed entity (IDX:APLN) of Agung Podomoro Group (APG), is one of the fastest growing and largest real estate developers in Indonesia with interests in superblocks, retail properties, office, apartments and residential, and hotels. APG established its first development, a housing complex in Simprug area, South Jakarta, in 1969 and completed its construction in 1973. From 1973 to present, members of APG completed or begun construction of more than 70 property projects, with majority addressed to middle class segments of society, with projects ranging from low cost apartments to high end apartments in South Jakarta, landed residentials, high end and the neighborhood mall, shop houses, hotels, soho and office towers.\n\nAPLN combines a visionary approach to design with an emphasis on rapid execution and time to market. Drawing on the experience and resources of the Agung Podomoro Group, we have been responsible for bringing a number of landmark properties on the market such as our flagship Podomoro City Complex and the high profile Senayan City. We also pioneered the superblock concept, bringing together residential, retail, leisure and office space within one integrated high rise development complex to create a pleasant and extremely convenient urban living space, with both sale and lease components.\n\nOur superblocks provide consumers with an alternate way of living through our one-stop-living high quality Superblock developments, which offer the possibility for a balanced and pleasant urban lifestyle to thousands of consumers.\n\nCapitalizing on our network and good brand name, our strong and experienced marketing team is typically able to generate strong advance interest for cash generation through sales, deposits, and installments. We also pay close attention to the mix of revenues streams coming from sales versus recurring revenues.','622129034567',NULL,'O3cnoxGj1bNyCg7EoBCuRFQbgODhi1wLOMiUMT8C.png','JKB','N','2019-10-09 17:21:18','2019-10-09 17:31:40',1);

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
  `created_by` varchar(40) NOT NULL,
  `updated_by` varchar(40) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`meeting_id`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `fk_meeting_request_idx` (`request_id`),
  CONSTRAINT `fk_meeting_request_idx` FOREIGN KEY (`request_id`) REFERENCES `project_request` (`request_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `meeting_appointment` */

/*Table structure for table `project_gallery` */

DROP TABLE IF EXISTS `project_gallery`;

CREATE TABLE `project_gallery` (
  `gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_filename` varchar(50) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  PRIMARY KEY (`gallery_id`),
  KEY `fk_gallery_project_uidx` (`project_id`),
  CONSTRAINT `fk_gallery_project_uidx` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`project_id`) values (1,'s6m4RdYqOlcv4xXiYIVkzqCr6XoZrTd02DcARcK3.jpeg','PRY0001'),(3,'lCP5tm5VG7UpneM48dzG8ovf3Pm18qWAuY2reqRT.jpeg','PRY0002');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_link_map`,`project_map_embed`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`,`city_id`,`seqid`) values ('PRY0001','PODOMORO PARK','podomoro-park','s6m4RdYqOlcv4xXiYIVkzqCr6XoZrTd02DcARcK3.jpeg','<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Agung Podomoro Land (APL) menghadirkan mahakarya terbarunya yaitu Podomoro Park Bandung, kawasan hunian yang terletak di tengah keindahan alam Bandung Selatan, seluas lebih dari 100 hektar. Konsep utama Podomoro Park terinsiprasi dari kawasan hunian berkelas dunia, yaitu Woodbrige di Irvine California serta desain masterplan dan landscape oleh Palmscape Singapore, sehingga Podomoro Park dapat dikategorikan sebagai&nbsp;</span><strong style=\"color: rgb(68, 68, 68);\"><em>world class home resort</em></strong><span style=\"color: rgb(68, 68, 68);\">.</span></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Podomoro Park telah meraih penghargaan \"</span><strong style=\"color: rgb(68, 68, 68);\">The Best Premium Home Resort in West Java</strong><span style=\"color: rgb(68, 68, 68);\">\" dalam event Indonesia Property &amp; Bank Award 2018. Ini membuktikan bahwa Podomoro Park memiliki konsep kawasan terbaik dengan menghadirkan kekuatan elemen alam, dan menjadikannya kawasan hunian resort terbaik di Jawa Barat. Maka tak heran bila antusias pasar sangat tinggi untuk memiliki hunian ini, hingga Podomoro Park menerima penghargaan “</span><strong style=\"color: rgb(68, 68, 68);\">Most Favoured Premium Housing Estate</strong><span style=\"color: rgb(68, 68, 68);\">” dalam event Housing Estate Award 2018.</span></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Keunggulan Podomoro Park Bandung :</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">1.&nbsp;Konsep kawasan yang mengutamakan keselarasan dengan alam (</span><em style=\"color: rgb(68, 68, 68);\">harmony with nature</em><span style=\"color: rgb(68, 68, 68);\">)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">2. Memiliki 5 elemen alam sebagai hunian resort yaitu :</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Danau buatan yang membentang sepanjang 1 km di tengah kawasan</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Pepohonan rimbun dan collective garden</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Ruang terbuka hijau yang luas</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- View pegunungan Bandung Selatan</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Udara sejuk dari hembusan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">wind tunnel</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;pegunungan.</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">3.&nbsp;&nbsp;Fasilitas dan keamanan premium:</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;Memiliki&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">club house</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;yang dilengkapi dengan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">infinity pool, fitness center, jacuzzi,</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">tennis court</em><span style=\"color: rgb(68, 68, 68);\">,&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">basketball court, children play ground,</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;dan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">function hall</em></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Fasilitas Ibadah</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Tersedia&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">bike lane, jogging track by the lake, garden by the lake, viewing deck, gazebo</em><span style=\"color: rgb(68, 68, 68);\">,&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">shopshouse</em></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Commercial destination</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;seluas ±12 HA (Living Plaza, RS Awal Bros, Fasilitas Pendidikan, Pasar Modern (future development), dan lainnya)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">- Sistem penyediaan air bersih melalui PDAM</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;&nbsp;Memiliki instalasi&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">fiber optic</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;(telepon, TV kabel, &amp; internet)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">-&nbsp;&nbsp;Keamanan kawasan dikelola secara professional (CCTV, kamera pengawas, security patrol, dan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">panic button</em><span style=\"color: rgb(68, 68, 68);\">).</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">4.&nbsp;Lokasi strategis, hanya sekitar 10 menit dari exit tol Buahbatu, atau 9 KM dari pusat Kota Bandung (Gedung sate)</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">5.&nbsp;Percepatan pembangunan infrastruktur di wilayah Bandung Selatan menjadikannya sebagai kawasan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">sunrise</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;properti yang bernilai investasi tinggi. Kawasan Podomoro Park dilintasi jalur LRT Bandung Raya yang terintegrasi dengan kereta cepat Jakarta-Bandung</span></p><p><span style=\"color: rgb(68, 68, 68);\">6. Melalui keseluruhan konsep kawasan yang selaras dengan alam dan fasilitas yang disediakan, Podomoro Park memberikan experience living yang dapat meningkatkan&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">level of health and happiness</em><span style=\"color: rgb(68, 68, 68);\">&nbsp;keluarga Anda.</span></p><p><span style=\"color: rgb(68, 68, 68);\">7. Stasiun LRT depan Kawasan</span></p><p><br></p><p><strong style=\"color: rgb(68, 68, 68);\">Podomoro Park Bandung menawarkan 6 tipe unit hunian, antara lain :</strong></p><p><br></p><ul><li><span style=\"color: rgb(68, 68, 68);\">Tipe 6 (Cluster Amagriya)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 7 (Cluster Amagriya)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 8 (Cluster Anapuri)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe 9 (Cluster Anapuri)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Asoka (Cluster Padmagriya)</span></li><li><span style=\"color: rgb(68, 68, 68);\">Tipe Ayana (Cluster Padmagriya)</span></li></ul><p><br></p>','Buahbatu, Bandung',NULL,NULL,'residensial','available',NULL,'DEV0001','2019-10-09 17:45:22','2019-10-09 17:45:22','BGD',1),('PRY0002','PODOMORO RIVER VIEW','podomoro-river-view',NULL,'<p><strong>Podomoro River View&nbsp;</strong>merupakan cluster perumahan baru di kawasan&nbsp;<em>new city</em>&nbsp;Podomoro Golf View yang dikembangkan oleh developer ternama dan terpercaya,&nbsp;<strong>Agung Podomoro Land</strong>. Didesain dengan konsep gaya hidup masa kini yang modern dan fleksibel, menghadirkan hunian dengan desain yang&nbsp;<em>simple</em>&nbsp;dan minimalis yang memberikan nilai lebih untuk Anda yang menginginkan hunian di kawasan kota baru yang hidup dan terintegrasi.</p><p><br></p><p>Berada di kawasan&nbsp;<strong>Podomoro Golf View</strong>&nbsp;yang merupakan pengembangan kota Baru di atas lahan seluas 60 Ha, perumahan ini dikelilingi oleh golf area dan berbatasan dengan aliran sungai Cikeas. Sehingga memberikan kawasan perumahan bernuansa hijau dengan udara yang segar.</p><p><br></p><p>Sebagai hunian di kawasan terpadu yang megutamakan efisiensi, kawasan Podomoro Golf View menyediakan berbagai fasilitas penunjang yang lengkap serta akan terintegrasi dengan sarana transportasi umum&nbsp;<em>Light Rail Transit&nbsp;</em>(LRT) di dalam kawasan. Letaknya yang hanya 100 m dari exit tol Cimanggis juga memberikan kemudahan akses bagi penghuninya untuk mobilisasi sehari-hari.</p><p><br></p><p><strong>Keunggulan dari Podomoro River View:</strong></p><p><br></p><ul><li>Dikembangkan oleh developer terpercaya serta berpengalaman,&nbsp;<strong>Agung Podomoro Land</strong></li><li>Lokasi yang sangat strategis, tepat di depan exit tol Cimanggis (KM 19) - Tol Jagorawi</li><li>Dibangun dengan konsep superblock dengan berbagai fasilitas penunjang yang lengkap</li><li>Dikelilingi oleh area hijau, 3 lapangan golf dan Sungai Cikeas</li><li>Terintegrasi dengan Jalur Light Rail Transit (LRT)</li><li>30 menit dari Bandara Halim Perdana Kusuma</li></ul><p><br></p><p><strong>Lokasi:&nbsp;</strong>Jalan Raya Tol Jagorawi KM 19, Cimanggis, Depok – Jawa Barat</p><p><br></p><p><strong>Fasilitas yang terdapat pada Podomoro River View, yaitu:</strong></p><p><br></p><ul><li>Sistem satu gerbang</li><li>CCTV 24 Jam</li><li>Kolam renang</li><li>Fitness Center</li><li>Lapangan Basket</li><li>Taman Bermain Anak</li><li><em>Food and Beverage Riverside</em></li><li><em>Foot Reflexology</em></li><li><em>Club House</em></li><li><em>Linear Park &amp; Garden</em></li><li>Area Komersial</li><li>Tempat Ibadah</li><li>Pasar Modern</li><li>BBQ Area</li></ul><p><br></p><p><strong>Tipe unit yang ditawarkan Podomoro River View, antara lain:</strong></p><p><br></p><ul><li class=\"ql-align-justify\">Podomoro River View - Jupiter Tipe 6x12</li></ul><p><br></p>','Cimanggis, Depok',NULL,NULL,'residensial','available',NULL,'DEV0001','2019-10-09 17:55:24','2019-10-09 18:03:04','DPK',3);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(50) NOT NULL,
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
  `seqid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`unit_type_id`),
  UNIQUE KEY `seqid` (`seqid`),
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

insert  into `verification_customer`(`hash_id`,`customer_id`,`expire_date`,`status_verify`,`created_at`,`updated_at`) values ('4e1e8179df3a4912f55bbc54aeaae1d62ef80b8e','CUST0002',1570616793,'Y','2019-10-09 16:46:58','2019-10-09 16:59:39'),('75f173ce75ef81ca3727567d336e22a319f45f43','CUST0001',1570615409,'Y','2019-10-09 16:33:29','2019-10-09 16:37:40');

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
