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

/*Table structure for table `area` */

DROP TABLE IF EXISTS `area`;

CREATE TABLE `area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(45) NOT NULL,
  `area_level_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  KEY `fk_area_area_level1_idx` (`area_level_id`),
  KEY `fk_area_area1_idx` (`parent_id`),
  CONSTRAINT `fk_area_area1` FOREIGN KEY (`parent_id`) REFERENCES `area` (`area_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_area_area_level1` FOREIGN KEY (`area_level_id`) REFERENCES `area_level` (`area_level_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1375 DEFAULT CHARSET=utf8;

/*Data for the table `area` */

insert  into `area`(`area_id`,`area_name`,`area_level_id`,`parent_id`) values (1,'Aceh (NAD)',1,NULL),(2,'Bali',1,NULL),(3,'Banten',1,NULL),(4,'Bengkulu',1,NULL),(5,'DI Yogyakarta',1,NULL),(6,'DKI Jakarta',1,NULL),(7,'Gorontalo',1,NULL),(8,'Jambi',1,NULL),(9,'Jawa Barat',1,NULL),(10,'Jawa Tengah',1,NULL),(11,'Jawa Timur',1,NULL),(12,'Kalimantan Barat',1,NULL),(13,'Kalimantan Selatan',1,NULL),(14,'Kalimantan Tengah',1,NULL),(15,'Kalimantan Timur',1,NULL),(16,'Kalimantan Utara',1,NULL),(17,'Kepulauan Bangka Belitung',1,NULL),(18,'Kepulauan Riau',1,NULL),(19,'Lampung',1,NULL),(20,'Maluku',1,NULL),(21,'Maluku Utara',1,NULL),(22,'Nusa Tenggara Barat (NTB)',1,NULL),(23,'Nusa Tenggara Timur (NTT)',1,NULL),(24,'Papua',1,NULL),(25,'Papua Barat',1,NULL),(26,'Riau',1,NULL),(27,'Sulawesi Barat',1,NULL),(28,'Sulawesi Selatan',1,NULL),(29,'Sulawesi Tengah',1,NULL),(30,'Sulawesi Tenggara',1,NULL),(31,'Sulawesi Utara',1,NULL),(32,'Sumatera Barat',1,NULL),(33,'Sumatera Selatan',1,NULL),(34,'Sumatera Utara',1,NULL),(35,'Kab. Aceh Barat',2,1),(36,'Kab. Aceh Barat Daya',2,1),(37,'Kab. Aceh Besar',2,1),(38,'Kab. Aceh Jaya',2,1),(39,'Kab. Aceh Selatan',2,1),(40,'Kab. Aceh Singkil',2,1),(41,'Kab. Aceh Tamiang',2,1),(42,'Kab. Aceh Tengah',2,1),(43,'Kab. Aceh Tenggara',2,1),(44,'Kab. Aceh Timur',2,1),(45,'Kab. Aceh Utara',2,1),(46,'Kab. Agam',2,32),(47,'Kab. Alor',2,23),(48,'Kota Ambon',2,20),(49,'Kab. Asahan',2,34),(50,'Kab. Asmat',2,24),(51,'Kab. Badung',2,2),(52,'Kab. Balangan',2,13),(53,'Kota Balikpapan',2,15),(54,'Kota Banda Aceh',2,1),(55,'Kota Bandar Lampung',2,19),(56,'Kota Bandung',2,9),(57,'Kab. Bandung',2,9),(58,'Kab. Bandung Barat',2,9),(59,'Kab. Banggai',2,29),(60,'Kab. Banggai Kepulauan',2,29),(61,'Kab. Banggai Laut',2,29),(62,'Kab. Bangka',2,17),(63,'Kab. Bangka Barat',2,17),(64,'Kab. Bangka Selatan',2,17),(65,'Kab. Bangka Tengah',2,17),(66,'Kab. Bangkalan',2,11),(67,'Kab. Bangli',2,2),(68,'Kota Banjar',2,9),(69,'Kab. Banjar',2,13),(70,'Kota Banjarbaru',2,13),(71,'Kota Banjarmasin',2,13),(72,'Kab. Banjarnegara',2,10),(73,'Kab. Bantaeng',2,28),(74,'Kab. Bantul',2,5),(75,'Kab. Banyuasin',2,33),(76,'Kab. Banyumas',2,10),(77,'Kab. Banyuwangi',2,11),(78,'Kab. Barito Kuala',2,13),(79,'Kab. Barito Selatan',2,14),(80,'Kab. Barito Timur',2,14),(81,'Kab. Barito Utara',2,14),(82,'Kab. Barru',2,28),(83,'Kota Batam',2,18),(84,'Kab. Batang',2,10),(85,'Kab. Batang Hari',2,8),(86,'Kota Batu',2,11),(87,'Kab. Batu Bara',2,34),(88,'Kota Bau-Bau',2,30),(89,'Kota Bekasi',2,9),(90,'Kab. Bekasi',2,9),(91,'Kab. Belitung',2,17),(92,'Kab. Belitung Timur',2,17),(93,'Kab. Belu',2,23),(94,'Kab. Bener Meriah',2,1),(95,'Kab. Bengkalis',2,26),(96,'Kab. Bengkayang',2,12),(97,'Kota Bengkulu',2,4),(98,'Kab. Bengkulu Selatan',2,4),(99,'Kab. Bengkulu Tengah',2,4),(100,'Kab. Bengkulu Utara',2,4),(101,'Kab. Berau',2,15),(102,'Kab. Biak Numfor',2,24),(103,'Kab. Bima',2,22),(104,'Kota Bima',2,22),(105,'Kota Binjai',2,34),(106,'Kab. Bintan',2,18),(107,'Kab. Bireuen',2,1),(108,'Kota Bitung',2,31),(109,'Kab. Blitar',2,11),(110,'Kota Blitar',2,11),(111,'Kab. Blora',2,10),(112,'Kab. Boalemo',2,7),(113,'Kab. Bogor',2,9),(114,'Kota Bogor',2,9),(115,'Kab. Bojonegoro',2,11),(116,'Kab. Bolaang Mongondow',2,31),(117,'Kab. Bolaang Mongondow Selatan',2,31),(118,'Kab. Bolaang Mongondow Timur',2,31),(119,'Kab. Bolaang Mongondow Utara',2,31),(120,'Kab. Bombana',2,30),(121,'Kab. Bondowoso',2,11),(122,'Kab. Bone',2,28),(123,'Kab. Bone Bolango',2,7),(124,'Kota Bontang',2,15),(125,'Kab. Boven Digoel',2,24),(126,'Kab. Boyolali',2,10),(127,'Kab. Brebes',2,10),(128,'Kota Bukittinggi',2,32),(129,'Kab. Buleleng',2,2),(130,'Kab. Bulukumba',2,28),(131,'Kab. Bulungan',2,16),(132,'Kab. Bungo',2,8),(133,'Kab. Buol',2,29),(134,'Kab. Buru',2,20),(135,'Kab. Buru Selatan',2,20),(136,'Kab. Buton',2,30),(137,'Kab. Buton Selatan',2,30),(138,'Kab. Buton Tengah',2,30),(139,'Kab. Buton Utara',2,30),(140,'Kab. Ciamis',2,9),(141,'Kab. Cianjur',2,9),(142,'Kab. Cilacap',2,10),(143,'Kota Cilegon',2,3),(144,'Kota Cimahi',2,9),(145,'Kota Cirebon',2,9),(146,'Kab. Cirebon',2,9),(147,'Kab. Dairi',2,34),(148,'Kab. Deiyai',2,24),(149,'Kab. Deli Serdang',2,34),(150,'Kab. Demak',2,10),(151,'Kota Denpasar',2,2),(152,'Kota Depok',2,9),(153,'Kab. Dharmasraya',2,32),(154,'Kab. Dogiyai',2,24),(155,'Kab. Dompu',2,22),(156,'Kab. Donggala',2,29),(157,'Kota Dumai',2,26),(158,'Kab. Empat Lawang',2,33),(159,'Kab. Ende',2,23),(160,'Kab. Enrekang',2,28),(161,'Kab. Fakfak',2,25),(162,'Kab. Flores Timur',2,23),(163,'Kab. Garut',2,9),(164,'Kab. Gayo Lues',2,1),(165,'Kab. Gianyar',2,2),(166,'Kab. Gorontalo',2,7),(167,'Kota Gorontalo',2,7),(168,'Kab. Gorontalo Utara',2,7),(169,'Kab. Gowa',2,28),(170,'Kab. Gresik',2,11),(171,'Kab. Grobogan',2,10),(172,'Kab. Gunung Kidul',2,5),(173,'Kab. Gunung Mas',2,14),(174,'Kota Gunungsitoli',2,34),(175,'Kab. Halmahera Barat',2,21),(176,'Kab. Halmahera Selatan',2,21),(177,'Kab. Halmahera Tengah',2,21),(178,'Kab. Halmahera Timur',2,21),(179,'Kab. Halmahera Utara',2,21),(180,'Kab. Hulu Sungai Selatan',2,13),(181,'Kab. Hulu Sungai Tengah',2,13),(182,'Kab. Hulu Sungai Utara',2,13),(183,'Kab. Humbang Hasundutan',2,34),(184,'Kab. Indragiri Hilir',2,26),(185,'Kab. Indragiri Hulu',2,26),(186,'Kab. Indramayu',2,9),(187,'Kab. Intan Jaya',2,24),(188,'Kota Jakarta Barat',2,6),(189,'Kota Jakarta Pusat',2,6),(190,'Kota Jakarta Selatan',2,6),(191,'Kota Jakarta Timur',2,6),(192,'Kota Jakarta Utara',2,6),(193,'Kota Jambi',2,8),(194,'Kab. Jayapura',2,24),(195,'Kota Jayapura',2,24),(196,'Kab. Jayawijaya',2,24),(197,'Kab. Jember',2,11),(198,'Kab. Jembrana',2,2),(199,'Kab. Jeneponto',2,28),(200,'Kab. Jepara',2,10),(201,'Kab. Jombang',2,11),(202,'Kab. Kaimana',2,25),(203,'Kab. Kampar',2,26),(204,'Kab. Kapuas',2,14),(205,'Kab. Kapuas Hulu',2,12),(206,'Kab. Karanganyar',2,10),(207,'Kab. Karangasem',2,2),(208,'Kab. Karawang',2,9),(209,'Kab. Karimun',2,18),(210,'Kab. Karo',2,34),(211,'Kab. Katingan',2,14),(212,'Kab. Kaur',2,4),(213,'Kab. Kayong Utara',2,12),(214,'Kab. Kebumen',2,10),(215,'Kab. Kediri',2,11),(216,'Kota Kediri',2,11),(217,'Kab. Keerom',2,24),(218,'Kab. Kendal',2,10),(219,'Kota Kendari',2,30),(220,'Kab. Kepahiang',2,4),(221,'Kab. Kepulauan Anambas',2,18),(222,'Kab. Kepulauan Aru',2,20),(223,'Kab. Kepulauan Mentawai',2,32),(224,'Kab. Kepulauan Meranti',2,26),(225,'Kab. Kepulauan Sangihe',2,31),(226,'Kab. Kepulauan Selayar',2,28),(227,'Kab. Kepulauan Seribu',2,6),(228,'Kab. Kepulauan Siau Tagulandang Biaro (Sitaro',2,31),(229,'Kab. Kepulauan Sula',2,21),(230,'Kab. Kepulauan Talaud',2,31),(231,'Kab. Kepulauan Yapen',2,24),(232,'Kab. Kerinci',2,8),(233,'Kab. Ketapang',2,12),(234,'Kab. Klaten',2,10),(235,'Kab. Klungkung',2,2),(236,'Kab. Kolaka',2,30),(237,'Kab. Kolaka Timur',2,30),(238,'Kab. Kolaka Utara',2,30),(239,'Kab. Konawe',2,30),(240,'Kab. Konawe Kepulauan',2,30),(241,'Kab. Konawe Selatan',2,30),(242,'Kab. Konawe Utara',2,30),(243,'Kab. Kotabaru',2,13),(244,'Kota Kotamobagu',2,31),(245,'Kab. Kotawaringin Barat',2,14),(246,'Kab. Kotawaringin Timur',2,14),(247,'Kab. Kuantan Singingi',2,26),(248,'Kab. Kubu Raya',2,12),(249,'Kab. Kudus',2,10),(250,'Kab. Kulon Progo',2,5),(251,'Kab. Kuningan',2,9),(252,'Kab. Kupang',2,23),(253,'Kota Kupang',2,23),(254,'Kab. Kutai Barat',2,15),(255,'Kab. Kutai Kartanegara',2,15),(256,'Kab. Kutai Timur',2,15),(257,'Kab. Labuhanbatu',2,34),(258,'Kab. Labuhanbatu Selatan',2,34),(259,'Kab. Labuhanbatu Utara',2,34),(260,'Kab. Lahat',2,33),(261,'Kab. Lamandau',2,14),(262,'Kab. Lamongan',2,11),(263,'Kab. Lampung Barat',2,19),(264,'Kab. Lampung Selatan',2,19),(265,'Kab. Lampung Tengah',2,19),(266,'Kab. Lampung Timur',2,19),(267,'Kab. Lampung Utara',2,19),(268,'Kab. Landak',2,12),(269,'Kab. Langkat',2,34),(270,'Kota Langsa',2,1),(271,'Kab. Lanny Jaya',2,24),(272,'Kab. Lebak',2,3),(273,'Kab. Lebong',2,4),(274,'Kab. Lembata',2,23),(275,'Kota Lhokseumawe',2,1),(276,'Kab. Lima Puluh Kota',2,32),(277,'Kab. Lingga',2,18),(278,'Kab. Lombok Barat',2,22),(279,'Kab. Lombok Tengah',2,22),(280,'Kab. Lombok Timur',2,22),(281,'Kab. Lombok Utara',2,22),(282,'Kota Lubuk Linggau',2,33),(283,'Kab. Lumajang',2,11),(284,'Kab. Luwu',2,28),(285,'Kab. Luwu Timur',2,28),(286,'Kab. Luwu Utara',2,28),(287,'Kab. Madiun',2,11),(288,'Kota Madiun',2,11),(289,'Kab. Magelang',2,10),(290,'Kota Magelang',2,10),(291,'Kab. Magetan',2,11),(292,'Kab. Mahakam Ulu',2,15),(293,'Kab. Majalengka',2,9),(294,'Kab. Majene',2,27),(295,'Kota Makassar',2,28),(296,'Kab. Malaka',2,23),(297,'Kab. Malang',2,11),(298,'Kota Malang',2,11),(299,'Kab. Malinau',2,16),(300,'Kab. Maluku Barat Daya',2,20),(301,'Kab. Maluku Tengah',2,20),(302,'Kab. Maluku Tenggara',2,20),(303,'Kab. Maluku Tenggara Barat',2,20),(304,'Kab. Mamasa',2,27),(305,'Kab. Mamberamo Raya',2,24),(306,'Kab. Mamberamo Tengah',2,24),(307,'Kab. Mamuju',2,27),(308,'Kab. Mamuju Tengah',2,27),(309,'Kab. Mamuju Utara',2,27),(310,'Kota Manado',2,31),(311,'Kab. Mandailing Natal',2,34),(312,'Kab. Manggarai',2,23),(313,'Kab. Manggarai Barat',2,23),(314,'Kab. Manggarai Timur',2,23),(315,'Kab. Manokwari',2,25),(316,'Kab. Manokwari Selatan',2,25),(317,'Kab. Mappi',2,24),(318,'Kab. Maros',2,28),(319,'Kota Mataram',2,22),(320,'Kab. Maybrat',2,25),(321,'Kota Medan',2,34),(322,'Kab. Melawi',2,12),(323,'Kab. Mempawah',2,12),(324,'Kab. Merangin',2,8),(325,'Kab. Merauke',2,24),(326,'Kab. Mesuji',2,19),(327,'Kota Metro',2,19),(328,'Kab. Mimika',2,24),(329,'Kab. Minahasa',2,31),(330,'Kab. Minahasa Selatan',2,31),(331,'Kab. Minahasa Tenggara',2,31),(332,'Kab. Minahasa Utara',2,31),(333,'Kab. Mojokerto',2,11),(334,'Kota Mojokerto',2,11),(335,'Kab. Morowali',2,29),(336,'Kab. Morowali Utara',2,29),(337,'Kab. Muara Enim',2,33),(338,'Kab. Muaro Jambi',2,8),(339,'Kab. Muko Muko',2,4),(340,'Kab. Muna',2,30),(341,'Kab. Muna Barat',2,30),(342,'Kab. Murung Raya',2,14),(343,'Kab. Musi Banyuasin',2,33),(344,'Kab. Musi Rawas',2,33),(345,'Kab. Musi Rawas Utara',2,33),(346,'Kab. Nabire',2,24),(347,'Kab. Nagan Raya',2,1),(348,'Kab. Nagekeo',2,23),(349,'Kab. Natuna',2,18),(350,'Kab. Nduga',2,24),(351,'Kab. Ngada',2,23),(352,'Kab. Nganjuk',2,11),(353,'Kab. Ngawi',2,11),(354,'Kab. Nias',2,34),(355,'Kab. Nias Barat',2,34),(356,'Kab. Nias Selatan',2,34),(357,'Kab. Nias Utara',2,34),(358,'Kab. Nunukan',2,16),(359,'Kab. Ogan Ilir',2,33),(360,'Kab. Ogan Komering Ilir',2,33),(361,'Kab. Ogan Komering Ulu',2,33),(362,'Kab. Ogan Komering Ulu Selatan',2,33),(363,'Kab. Ogan Komering Ulu Timur',2,33),(364,'Kab. Pacitan',2,11),(365,'Kota Padang',2,32),(366,'Kab. Padang Lawas',2,34),(367,'Kab. Padang Lawas Utara',2,34),(368,'Kota Padang Panjang',2,32),(369,'Kab. Padang Pariaman',2,32),(370,'Kota Padang Sidempuan',2,34),(371,'Kota Pagar Alam',2,33),(372,'Kab. Pakpak Bharat',2,34),(373,'Kota Palangka Raya',2,14),(374,'Kota Palembang',2,33),(375,'Kota Palopo',2,28),(376,'Kota Palu',2,29),(377,'Kab. Pamekasan',2,11),(378,'Kab. Pandeglang',2,3),(379,'Kab. Pangandaran',2,9),(380,'Kab. Pangkajene Kepulauan',2,28),(381,'Kota Pangkal Pinang',2,17),(382,'Kab. Paniai',2,24),(383,'Kota Parepare',2,28),(384,'Kota Pariaman',2,32),(385,'Kab. Parigi Moutong',2,29),(386,'Kab. Pasaman',2,32),(387,'Kab. Pasaman Barat',2,32),(388,'Kab. Paser',2,15),(389,'Kab. Pasuruan',2,11),(390,'Kota Pasuruan',2,11),(391,'Kab. Pati',2,10),(392,'Kota Payakumbuh',2,32),(393,'Kab. Pegunungan Arfak',2,25),(394,'Kab. Pegunungan Bintang',2,24),(395,'Kab. Pekalongan',2,10),(396,'Kota Pekalongan',2,10),(397,'Kota Pekanbaru',2,26),(398,'Kab. Pelalawan',2,26),(399,'Kab. Pemalang',2,10),(400,'Kota Pematang Siantar',2,34),(401,'Kab. Penajam Paser Utara',2,15),(402,'Kab. Penukal Abab Lematang Ilir',2,33),(403,'Kab. Pesawaran',2,19),(404,'Kab. Pesisir Barat',2,19),(405,'Kab. Pesisir Selatan',2,32),(406,'Kab. Pidie',2,1),(407,'Kab. Pidie Jaya',2,1),(408,'Kab. Pinrang',2,28),(409,'Kab. Pohuwato',2,7),(410,'Kab. Polewali Mandar',2,27),(411,'Kab. Ponorogo',2,11),(412,'Kota Pontianak',2,12),(413,'Kab. Poso',2,29),(414,'Kota Prabumulih',2,33),(415,'Kab. Pringsewu',2,19),(416,'Kab. Probolinggo',2,11),(417,'Kota Probolinggo',2,11),(418,'Kab. Pulang Pisau',2,14),(419,'Kab. Pulau Morotai',2,21),(420,'Kab. Pulau Taliabu',2,21),(421,'Kab. Puncak',2,24),(422,'Kab. Puncak Jaya',2,24),(423,'Kab. Purbalingga',2,10),(424,'Kab. Purwakarta',2,9),(425,'Kab. Purworejo',2,10),(426,'Kab. Raja Ampat',2,25),(427,'Kab. Rejang Lebong',2,4),(428,'Kab. Rembang',2,10),(429,'Kab. Rokan Hilir',2,26),(430,'Kab. Rokan Hulu',2,26),(431,'Kab. Rote Ndao',2,23),(432,'Kota Sabang',2,1),(433,'Kab. Sabu Raijua',2,23),(434,'Kota Salatiga',2,10),(435,'Kota Samarinda',2,15),(436,'Kab. Sambas',2,12),(437,'Kab. Samosir',2,34),(438,'Kab. Sampang',2,11),(439,'Kab. Sanggau',2,12),(440,'Kab. Sarmi',2,24),(441,'Kab. Sarolangun',2,8),(442,'Kota Sawah Lunto',2,32),(443,'Kab. Sekadau',2,12),(444,'Kab. Seluma',2,4),(445,'Kab. Semarang',2,10),(446,'Kota Semarang',2,10),(447,'Kab. Seram Bagian Barat',2,20),(448,'Kab. Seram Bagian Timur',2,20),(449,'Kota Serang',2,3),(450,'Kab. Serang',2,3),(451,'Kab. Serdang Bedagai',2,34),(452,'Kab. Seruyan',2,14),(453,'Kab. Siak',2,26),(454,'Kota Sibolga',2,34),(455,'Kab. Sidenreng Rappang',2,28),(456,'Kab. Sidoarjo',2,11),(457,'Kab. Sigi',2,29),(458,'Kab. Sijunjung',2,32),(459,'Kab. Sikka',2,23),(460,'Kab. Simalungun',2,34),(461,'Kab. Simeulue',2,1),(462,'Kota Singkawang',2,12),(463,'Kab. Sinjai',2,28),(464,'Kab. Sintang',2,12),(465,'Kab. Situbondo',2,11),(466,'Kab. Sleman',2,5),(467,'Kab. Solok',2,32),(468,'Kota Solok',2,32),(469,'Kab. Solok Selatan',2,32),(470,'Kab. Soppeng',2,28),(471,'Kab. Sorong',2,25),(472,'Kota Sorong',2,25),(473,'Kab. Sorong Selatan',2,25),(474,'Kab. Sragen',2,10),(475,'Kab. Subang',2,9),(476,'Kota Subulussalam',2,1),(477,'Kota Sukabumi',2,9),(478,'Kab. Sukabumi',2,9),(479,'Kab. Sukamara',2,14),(480,'Kab. Sukoharjo',2,10),(481,'Kab. Sumba Barat',2,23),(482,'Kab. Sumba Barat Daya',2,23),(483,'Kab. Sumba Tengah',2,23),(484,'Kab. Sumba Timur',2,23),(485,'Kab. Sumbawa',2,22),(486,'Kab. Sumbawa Barat',2,22),(487,'Kab. Sumedang',2,9),(488,'Kab. Sumenep',2,11),(489,'Kota Sungaipenuh',2,8),(490,'Kab. Supiori',2,24),(491,'Kota Surabaya',2,11),(492,'Kota Surakarta',2,10),(493,'Kab. Tabalong',2,13),(494,'Kab. Tabanan',2,2),(495,'Kab. Takalar',2,28),(496,'Kab. Tambrauw',2,25),(497,'Kab. Tana Tidung',2,16),(498,'Kab. Tana Toraja',2,28),(499,'Kab. Tanah Bumbu',2,13),(500,'Kab. Tanah Datar',2,32),(501,'Kab. Tanah Laut',2,13),(502,'Kota Tangerang',2,3),(503,'Kab. Tangerang',2,3),(504,'Kota Tangerang Selatan',2,3),(505,'Kab. Tanggamus',2,19),(506,'Kota Tanjung Balai',2,34),(507,'Kab. Tanjung Jabung Barat',2,8),(508,'Kab. Tanjung Jabung Timur',2,8),(509,'Kota Tanjung Pinang',2,18),(510,'Kab. Tapanuli Selatan',2,34),(511,'Kab. Tapanuli Tengah',2,34),(512,'Kab. Tapanuli Utara',2,34),(513,'Kab. Tapin',2,13),(514,'Kota Tarakan',2,16),(515,'Kota Tasikmalaya',2,9),(516,'Kab. Tasikmalaya',2,9),(517,'Kota Tebing Tinggi',2,34),(518,'Kab. Tebo',2,8),(519,'Kab. Tegal',2,10),(520,'Kota Tegal',2,10),(521,'Kab. Teluk Bintuni',2,25),(522,'Kab. Teluk Wondama',2,25),(523,'Kab. Temanggung',2,10),(524,'Kota Ternate',2,21),(525,'Kota Tidore Kepulauan',2,21),(526,'Kab. Timor Tengah Selatan',2,23),(527,'Kab. Timor Tengah Utara',2,23),(528,'Kab. Toba Samosir',2,34),(529,'Kab. Tojo Una-Una',2,29),(530,'Kab. Toli-Toli',2,29),(531,'Kab. Tolikara',2,24),(532,'Kota Tomohon',2,31),(533,'Kab. Toraja Utara',2,28),(534,'Kab. Trenggalek',2,11),(535,'Kota Tual',2,20),(536,'Kab. Tuban',2,11),(537,'Kab. Tulang Bawang',2,19),(538,'Kab. Tulang Bawang Barat',2,19),(539,'Kab. Tulungagung',2,11),(540,'Kab. Wajo',2,28),(541,'Kab. Wakatobi',2,30),(542,'Kab. Waropen',2,24),(543,'Kab. Way Kanan',2,19),(544,'Kab. Wonogiri',2,10),(545,'Kab. Wonosobo',2,10),(546,'Kab. Yahukimo',2,24),(547,'Kab. Yalimo',2,24),(548,'Kota Yogyakarta',2,5),(549,'Cakung ',3,191),(550,'Cempaka Putih ',3,189),(551,'Cengkareng ',3,188),(552,'Cilandak ',3,190),(553,'Cilincing ',3,192),(554,'Cipayung ',3,191),(555,'Ciracas ',3,191),(556,'Duren Sawit ',3,191),(557,'Gambir ',3,189),(558,'Grogol Petamburan ',3,188),(559,'Jagakarsa ',3,190),(560,'Jatinegara ',3,191),(561,'Johar Baru ',3,189),(562,'Kalideres ',3,188),(563,'Kebayoran Baru ',3,190),(564,'Kebayoran Lama ',3,190),(565,'Kebon Jeruk ',3,188),(566,'Kelapa Gading ',3,192),(567,'Kemayoran ',3,189),(568,'Kembangan ',3,188),(569,'Kepulauan Seribu Selatan ',3,227),(570,'Kepulauan Seribu Utara ',3,227),(571,'Koja ',3,192),(572,'Kramat Jati ',3,191),(573,'Makasar ',3,191),(574,'Mampang Prapatan ',3,190),(575,'Matraman ',3,191),(576,'Menteng ',3,189),(577,'Pademangan ',3,192),(578,'Palmerah ',3,188),(579,'Pancoran ',3,190),(580,'Pasar Minggu ',3,190),(581,'Pasar Rebo ',3,191),(582,'Penjaringan ',3,192),(583,'Pesanggrahan ',3,190),(584,'Pulo Gadung ',3,191),(585,'Sawah Besar ',3,189),(586,'Senen ',3,189),(587,'Setia Budi ',3,190),(588,'Taman Sari ',3,188),(589,'Tambora ',3,188),(590,'Tanah Abang ',3,189),(591,'Tanjung Priok ',3,192),(592,'Tebet ',3,190),(593,'Agrabinta ',3,141),(594,'Andir ',3,56),(595,'Anjatan ',3,186),(596,'Antapani (Cicadas) ',3,56),(597,'Arahan ',3,186),(598,'Arcamanik ',3,56),(599,'Argapura ',3,293),(600,'Arjasari ',3,57),(601,'Arjawinangun ',3,146),(602,'Astana Anyar ',3,56),(603,'Astanajapura ',3,146),(604,'Babakan ',3,146),(605,'Babakan Ciparay ',3,56),(606,'Babakan Madang ',3,113),(607,'Babakancikao ',3,424),(608,'Babelan ',3,90),(609,'Baleendah ',3,57),(610,'Balongan ',3,186),(611,'Bandung Kidul ',3,56),(612,'Bandung Kulon ',3,56),(613,'Bandung Wetan ',3,56),(614,'Bangodua ',3,186),(615,'Banjar ',3,68),(616,'Banjaran ',3,57),(617,'Banjaran ',3,293),(618,'Banjaranyar ',3,140),(619,'Banjarsari ',3,140),(620,'Banjarwangi ',3,163),(621,'Bantar Gebang ',3,89),(622,'Bantargadung ',3,478),(623,'Bantarkalong ',3,516),(624,'Bantarujeg ',3,293),(625,'Banyuresmi ',3,163),(626,'Banyusari ',3,208),(627,'Baregbeg ',3,140),(628,'Baros ',3,477),(629,'Batujajar ',3,58),(630,'Batujaya ',3,208),(631,'Batununggal ',3,56),(632,'Bayongbong ',3,163),(633,'Beber ',3,146),(634,'Beji ',3,152),(635,'Bekasi Barat ',3,89),(636,'Bekasi Selatan ',3,89),(637,'Bekasi Timur ',3,89),(638,'Bekasi Utara ',3,89),(639,'Binong ',3,475),(640,'Blanakan ',3,475),(641,'Blubur Limbangan ',3,163),(642,'Bogor Barat ',3,114),(643,'Bogor Selatan ',3,114),(644,'Bogor Tengah ',3,114),(645,'Bogor Timur ',3,114),(646,'Bogor Utara ',3,114),(647,'Bojong ',3,424),(648,'Bojong Genteng ',3,478),(649,'Bojongasih ',3,516),(650,'Bojonggambir ',3,516),(651,'Bojonggede ',3,113),(652,'Bojongloa Kaler ',3,56),(653,'Bojongloa Kidul ',3,56),(654,'Bojongmangu ',3,90),(655,'Bojongpicung ',3,141),(656,'Bojongsari ',3,152),(657,'Bojongsoang ',3,57),(658,'Bongas ',3,186),(659,'Buahbatu (Margacinta) ',3,56),(660,'Buahdua ',3,487),(661,'Bungbulang ',3,163),(662,'Bungursari ',3,424),(663,'Bungursari ',3,515),(664,'Cabangbungin ',3,90),(665,'Campaka ',3,141),(666,'Campaka ',3,424),(667,'Campaka Mulya ',3,141),(668,'Cangkuang ',3,57),(669,'Cantigi ',3,186),(670,'Caringin ',3,113),(671,'Caringin ',3,163),(672,'Caringin ',3,478),(673,'Cariu ',3,113),(674,'Ciambar ',3,478),(675,'Ciamis ',3,140),(676,'Ciampea ',3,113),(677,'Ciampel ',3,208),(678,'Cianjur ',3,141),(679,'Ciasem ',3,475),(680,'Ciater ',3,475),(681,'Ciawi ',3,113),(682,'Ciawi ',3,516),(683,'Ciawigebang ',3,251),(684,'Cibadak ',3,478),(685,'Cibalong ',3,163),(686,'Cibalong ',3,516),(687,'Cibarusah ',3,90),(688,'Cibatu ',3,163),(689,'Cibatu ',3,424),(690,'Cibeber ',3,141),(691,'Cibeunying Kaler ',3,56),(692,'Cibeunying Kidul ',3,56),(693,'Cibeureum ',3,251),(694,'Cibeureum ',3,477),(695,'Cibeureum ',3,515),(696,'Cibingbin ',3,251),(697,'Cibinong ',3,113),(698,'Cibinong ',3,141),(699,'Cibiru ',3,56),(700,'Cibitung ',3,90),(701,'Cibitung ',3,478),(702,'Cibiuk ',3,163),(703,'Cibogo ',3,475),(704,'Cibuaya ',3,208),(705,'Cibugel ',3,487),(706,'Cibungbulang ',3,113),(707,'Cicalengka ',3,57),(708,'Cicantayan ',3,478),(709,'Cicendo ',3,56),(710,'Cicurug ',3,478),(711,'Cidadap ',3,56),(712,'Cidadap ',3,478),(713,'Cidahu ',3,251),(714,'Cidahu ',3,478),(715,'Cidaun ',3,141),(716,'Cidolog ',3,140),(717,'Cidolog ',3,478),(718,'Ciemas ',3,478),(719,'Cigalontang ',3,516),(720,'Cigandamekar ',3,251),(721,'Cigasong ',3,293),(722,'Cigedug ',3,163),(723,'Cigombong ',3,113),(724,'Cigudeg ',3,113),(725,'Cigugur ',3,379),(726,'Cigugur ',3,251),(727,'Cihampelas ',3,58),(728,'Cihaurbeuti ',3,140),(729,'Cihideung ',3,515),(730,'Cihurip ',3,163),(731,'Cijambe ',3,475),(732,'Cijati ',3,141),(733,'Cijeruk ',3,113),(734,'Cijeungjing ',3,140),(735,'Cijulang ',3,379),(736,'Cikadu ',3,141),(737,'Cikajang ',3,163),(738,'Cikakak ',3,478),(739,'Cikalong ',3,516),(740,'Cikalong Wetan ',3,58),(741,'Cikalongkulon ',3,141),(742,'Cikampek ',3,208),(743,'Cikancung ',3,57),(744,'Cikarang Barat ',3,90),(745,'Cikarang Pusat ',3,90),(746,'Cikarang Selatan ',3,90),(747,'Cikarang Timur ',3,90),(748,'Cikarang Utara ',3,90),(749,'Cikatomas ',3,516),(750,'Cikaum ',3,475),(751,'Cikedung ',3,186),(752,'Cikelet ',3,163),(753,'Cikembar ',3,478),(754,'Cikidang ',3,478),(755,'Cikijing ',3,293),(756,'Cikole ',3,477),(757,'Cikoneng ',3,140),(758,'Cilaku ',3,141),(759,'Cilamaya Kulon ',3,208),(760,'Cilamaya Wetan ',3,208),(761,'Cilawu ',3,163),(762,'Cilebak ',3,251),(763,'Cilebar ',3,208),(764,'Ciledug ',3,146),(765,'Cilengkrang ',3,57),(766,'Cileungsi ',3,113),(767,'Cileunyi ',3,57),(768,'Cililin ',3,58),(769,'Cilimus ',3,251),(770,'Cilodong ',3,152),(771,'Cimahi ',3,251),(772,'Cimahi Selatan ',3,144),(773,'Cimahi Tengah ',3,144),(774,'Cimahi Utara ',3,144),(775,'Cimalaka ',3,487),(776,'Cimanggis ',3,152),(777,'Cimanggu ',3,478),(778,'Cimanggung ',3,487),(779,'Cimaragas ',3,140),(780,'Cimaung ',3,57),(781,'Cimerak ',3,379),(782,'Cimeunyan ',3,57),(783,'Cinambo ',3,56),(784,'Cineam ',3,516),(785,'Cinere ',3,152),(786,'Cingambul ',3,293),(787,'Ciniru ',3,251),(788,'Ciomas ',3,113),(789,'Cipaku ',3,140),(790,'Cipanas ',3,141),(791,'Ciparay ',3,57),(792,'Cipatat ',3,58),(793,'Cipatujah ',3,516),(794,'Cipayung ',3,152),(795,'Cipedes ',3,515),(796,'Cipeundeuy ',3,58),(797,'Cipeundeuy ',3,475),(798,'Cipicung ',3,251),(799,'Cipongkor ',3,58),(800,'Cipunagara ',3,475),(801,'Ciracap ',3,478),(802,'Ciranjang ',3,141),(803,'Cireunghas ',3,478),(804,'Cisaat ',3,478),(805,'Cisaga ',3,140),(806,'Cisalak ',3,475),(807,'Cisarua ',3,58),(808,'Cisarua ',3,113),(809,'Cisarua ',3,487),(810,'Cisayong ',3,516),(811,'Ciseeng ',3,113),(812,'Cisewu ',3,163),(813,'Cisitu ',3,487),(814,'Cisolok ',3,478),(815,'Cisompet ',3,163),(816,'Cisurupan ',3,163),(817,'Citamiang ',3,477),(818,'Citeureup ',3,113),(819,'Ciwaringin ',3,146),(820,'Ciwaru ',3,251),(821,'Ciwidey ',3,57),(822,'Coblong ',3,56),(823,'Compreng ',3,475),(824,'Conggeang ',3,487),(825,'Cugenang ',3,141),(826,'Culamega ',3,516),(827,'Curugkembar ',3,478),(828,'Darangdan ',3,424),(829,'Darma ',3,251),(830,'Darmaraja ',3,487),(831,'Dawuan ',3,293),(832,'Dawuan ',3,475),(833,'Dayeuhkolot ',3,57),(834,'Depok ',3,146),(835,'Dramaga ',3,113),(836,'Dukupuntang ',3,146),(837,'Gabuswetan ',3,186),(838,'Ganeas ',3,487),(839,'Gantar ',3,186),(840,'Garawangi ',3,251),(841,'Garut Kota ',3,163),(842,'Gebang ',3,146),(843,'Gedebage ',3,56),(844,'Geger Bitung ',3,478),(845,'Gegesik ',3,146),(846,'Gekbrong ',3,141),(847,'Gempol ',3,146),(848,'Greged (Greget) ',3,146),(849,'Gunung Jati (Cirebon Utara) ',3,146),(850,'Gunung Putri ',3,113),(851,'Gunung Puyuh ',3,477),(852,'Gunung Sindur ',3,113),(853,'Gunung Tanjung ',3,516),(854,'Gunungguruh ',3,478),(855,'Gununghalu ',3,58),(856,'Hantara ',3,251),(857,'Harjamukti ',3,145),(858,'Haurgeulis ',3,186),(859,'Haurwangi ',3,141),(860,'Ibun ',3,57),(861,'Indihiang ',3,515),(862,'Indramayu ',3,186),(863,'Jalaksana ',3,251),(864,'Jalancagak ',3,475),(865,'Jamanis ',3,516),(866,'Jamblang ',3,146),(867,'Jampang Kulon ',3,478),(868,'Jampang Tengah ',3,478),(869,'Japara ',3,251),(870,'Jasinga ',3,113),(871,'Jati Sampurna ',3,89),(872,'Jatiasih ',3,89),(873,'Jatibarang ',3,186),(874,'Jatigede ',3,487),(875,'Jatiluhur ',3,424),(876,'Jatinagara ',3,140),(877,'Jatinangor ',3,487),(878,'Jatinunggal ',3,487),(879,'Jatisari ',3,208),(880,'Jatitujuh ',3,293),(881,'Jatiwangi ',3,293),(882,'Jatiwaras ',3,516),(883,'Jayakerta ',3,208),(884,'Jonggol ',3,113),(885,'Juntinyuat ',3,186),(886,'Kabandungan ',3,478),(887,'Kadipaten ',3,293),(888,'Kadipaten ',3,516),(889,'Kadudampit ',3,478),(890,'Kadugede ',3,251),(891,'Kadungora ',3,163),(892,'Kadupandak ',3,141),(893,'Kalapa Nunggal ',3,478),(894,'Kalibunder ',3,478),(895,'Kalijati ',3,475),(896,'Kalimanggis ',3,251),(897,'Kalipucang ',3,379),(898,'Kaliwedi ',3,146),(899,'Kandanghaur ',3,186),(900,'Kapetakan ',3,146),(901,'Karang Jaya ',3,516),(902,'Karangampel ',3,186),(903,'Karangbahagia ',3,90),(904,'Karangkancana ',3,251),(905,'Karangnunggal ',3,516),(906,'Karangpawitan ',3,163),(907,'Karangsembung ',3,146),(908,'Karangtengah ',3,141),(909,'Karangtengah ',3,163),(910,'Karangwareng ',3,146),(911,'Karawang Barat ',3,208),(912,'Karawang Timur ',3,208),(913,'Kasokandel ',3,293),(914,'Kasomalang ',3,475),(915,'Katapang ',3,57),(916,'Kawali ',3,140),(917,'Kawalu ',3,515),(918,'Kebonpedes ',3,478),(919,'Kedawung ',3,146),(920,'Kedokan Bunder ',3,186),(921,'Kedung Waringin ',3,90),(922,'Kejaksan ',3,145),(923,'Kemang ',3,113),(924,'Kersamanah ',3,163),(925,'Kertajati ',3,293),(926,'Kertasari ',3,57),(927,'Kertasemaya ',3,186),(928,'Kesambi ',3,145),(929,'Kiaracondong ',3,56),(930,'Kiarapedes ',3,424),(931,'Klangenan ',3,146),(932,'Klapanunggal ',3,113),(933,'Klari ',3,208),(934,'Kotabaru ',3,208),(935,'Kramat Mulya ',3,251),(936,'Krangkeng ',3,186),(937,'Kroya ',3,186),(938,'Kuningan ',3,251),(939,'Kutawaluya ',3,208),(940,'Kutawaringin ',3,57),(941,'Lakbok ',3,140),(942,'Langensari ',3,68),(943,'Langkaplancar ',3,379),(944,'Lebakwangi ',3,251),(945,'Legonkulon ',3,475),(946,'Lelea ',3,186),(947,'Leles ',3,141),(948,'Leles ',3,163),(949,'Lemahabang ',3,146),(950,'Lemahabang ',3,208),(951,'Lemahsugih ',3,293),(952,'Lemahwungkuk ',3,145),(953,'Lembang ',3,58),(954,'Lembursitu ',3,477),(955,'Lengkong ',3,56),(956,'Lengkong ',3,478),(957,'Leuwigoong ',3,163),(958,'Leuwiliang ',3,113),(959,'Leuwimunding ',3,293),(960,'Leuwisadeng ',3,113),(961,'Leuwisari ',3,516),(962,'Ligung ',3,293),(963,'Limo ',3,152),(964,'Lohbener ',3,186),(965,'Losarang ',3,186),(966,'Losari ',3,146),(967,'Lumbung ',3,140),(968,'Luragung ',3,251),(969,'Maja ',3,293),(970,'Majalaya ',3,57),(971,'Majalaya ',3,208),(972,'Majalengka ',3,293),(973,'Malangbong ',3,163),(974,'Malausma ',3,293),(975,'Maleber ',3,251),(976,'Mandalajati ',3,56),(977,'Mande ',3,141),(978,'Mandirancan ',3,251),(979,'Mangkubumi ',3,515),(980,'Mangunjaya ',3,379),(981,'Mangunreja ',3,516),(982,'Maniis ',3,424),(983,'Manonjaya ',3,516),(984,'Margaasih ',3,57),(985,'Margahayu ',3,57),(986,'Medan Satria ',3,89),(987,'Megamendung ',3,113),(988,'Mekarmukti ',3,163),(989,'Muara Gembong ',3,90),(990,'Mundu ',3,146),(991,'Mustika Jaya ',3,89),(992,'Nagrak ',3,478),(993,'Nagreg ',3,57),(994,'Nanggung ',3,113),(995,'Naringgul ',3,141),(996,'Ngamprah ',3,58),(997,'Nusaherang ',3,251),(998,'Nyalindung ',3,478),(999,'Pabedilan ',3,146),(1000,'Pabuaran ',3,146),(1001,'Pabuaran ',3,475),(1002,'Pabuaran ',3,478),(1003,'Pacet ',3,57),(1004,'Pacet ',3,141),(1005,'Padaherang ',3,379),(1006,'Padakembang ',3,516),(1007,'Padalarang ',3,58),(1008,'Pagaden ',3,475),(1009,'Pagaden Barat ',3,475),(1010,'Pagelaran ',3,141),(1011,'Pagerageung ',3,516),(1012,'Pakenjeng ',3,163),(1013,'Pakisjaya ',3,208),(1014,'Palasah ',3,293),(1015,'Palimanan ',3,146),(1016,'Pamanukan ',3,475),(1017,'Pamarican ',3,140),(1018,'Pameungpeuk ',3,57),(1019,'Pameungpeuk ',3,163),(1020,'Pamijahan ',3,113),(1021,'Pamulihan ',3,163),(1022,'Pamulihan ',3,487),(1023,'Panawangan ',3,140),(1024,'Pancalang ',3,251),(1025,'Pancatengah ',3,516),(1026,'Pancoran Mas ',3,152),(1027,'Pangalengan ',3,57),(1028,'Pangandaran ',3,379),(1029,'Pangatikan ',3,163),(1030,'Pangenan ',3,146),(1031,'Pangkalan ',3,208),(1032,'Panguragan ',3,146),(1033,'Panjalu ',3,140),(1034,'Panumbangan ',3,140),(1035,'Panyileukan ',3,56),(1036,'Panyingkiran ',3,293),(1037,'Parakan Salak ',3,478),(1038,'Parigi ',3,379),(1039,'Parongpong ',3,58),(1040,'Parung ',3,113),(1041,'Parung Kuda ',3,478),(1042,'Parung Panjang ',3,113),(1043,'Parungponteng ',3,516),(1044,'Pasaleman ',3,146),(1045,'Pasawahan ',3,251),(1046,'Pasawahan ',3,424),(1047,'Paseh ',3,57),(1048,'Paseh ',3,487),(1049,'Pasekan ',3,186),(1050,'Pasirjambu ',3,57),(1051,'Pasirkuda ',3,141),(1052,'Pasirwangi ',3,163),(1053,'Pataruman ',3,68),(1054,'Patokbeusi ',3,475),(1055,'Patrol ',3,186),(1056,'Pebayuran ',3,90),(1057,'Pedes ',3,208),(1058,'Pekalipan ',3,145),(1059,'Pelabuhanratu ',3,478),(1060,'Peundeuy ',3,163),(1061,'Plered ',3,146),(1062,'Plered ',3,424),(1063,'Plumbon ',3,146),(1064,'Pondok Gede ',3,89),(1065,'Pondok Melati ',3,89),(1066,'Pondoksalam ',3,424),(1067,'Purabaya ',3,478),(1068,'Purbaratu ',3,515),(1069,'Purwadadi ',3,140),(1070,'Purwadadi ',3,475),(1071,'Purwaharja ',3,68),(1072,'Purwakarta ',3,424),(1073,'Purwasari ',3,208),(1074,'Pusakajaya ',3,475),(1075,'Pusakanagara ',3,475),(1076,'Puspahiang ',3,516),(1077,'Rajadesa ',3,140),(1078,'Rajagaluh ',3,293),(1079,'Rajapolah ',3,516),(1080,'Ranca Bali ',3,57),(1081,'Ranca Bungur ',3,113),(1082,'Rancaekek ',3,57),(1083,'Rancah ',3,140),(1084,'Rancakalong ',3,487),(1085,'Rancasari ',3,56),(1086,'Rawalumbu ',3,89),(1087,'Rawamerta ',3,208),(1088,'Regol ',3,56),(1089,'Rengasdengklok ',3,208),(1090,'Rongga ',3,58),(1091,'Rumpin ',3,113),(1092,'Sadananya ',3,140),(1093,'Sagalaherang ',3,475),(1094,'Sagaranten ',3,478),(1095,'Saguling ',3,58),(1096,'Salawu ',3,516),(1097,'Salopa ',3,516),(1098,'Samarang ',3,163),(1099,'Sariwangi ',3,516),(1100,'Sawangan ',3,152),(1101,'Sedong ',3,146),(1102,'Selaawi ',3,163),(1103,'Selajambe ',3,251),(1104,'Serang Baru ',3,90),(1105,'Serangpanjang ',3,475),(1106,'Setu ',3,90),(1107,'Sidamulih ',3,379),(1108,'Simpenan ',3,478),(1109,'Sindang ',3,186),(1110,'Sindang ',3,293),(1111,'Sindangagung ',3,251),(1112,'Sindangbarang ',3,141),(1113,'Sindangkasih ',3,140),(1114,'Sindangkerta ',3,58),(1115,'Sindangwangi ',3,293),(1116,'Singajaya ',3,163),(1117,'Singaparna ',3,516),(1118,'Situraja ',3,487),(1119,'Sliyeg ',3,186),(1120,'Sodonghilir ',3,516),(1121,'Solokan Jeruk ',3,57),(1122,'Soreang ',3,57),(1123,'Subang ',3,251),(1124,'Subang ',3,475),(1125,'Sucinaraja ',3,163),(1126,'Sukabumi ',3,478),(1127,'Sukadana ',3,140),(1128,'Sukagumiwang ',3,186),(1129,'Sukahaji ',3,293),(1130,'Sukahening ',3,516),(1131,'Sukajadi ',3,56),(1132,'Sukajaya ',3,113),(1133,'Sukakarya ',3,90),(1134,'Sukalarang ',3,478),(1135,'Sukaluyu ',3,141),(1136,'Sukamakmur ',3,113),(1137,'Sukamantri ',3,140),(1138,'Sukanagara ',3,141),(1139,'Sukaraja ',3,113),(1140,'Sukaraja ',3,478),(1141,'Sukaraja ',3,516),(1142,'Sukarame ',3,516),(1143,'Sukaratu ',3,516),(1144,'Sukaresik ',3,516),(1145,'Sukaresmi ',3,141),(1146,'Sukaresmi ',3,163),(1147,'Sukasari ',3,56),(1148,'Sukasari ',3,424),(1149,'Sukasari ',3,475),(1150,'Sukasari ',3,487),(1151,'Sukatani ',3,90),(1152,'Sukatani ',3,424),(1153,'Sukawangi ',3,90),(1154,'Sukawening ',3,163),(1155,'Sukmajaya ',3,152),(1156,'Sukra ',3,186),(1157,'Sumber ',3,146),(1158,'Sumberjaya ',3,293),(1159,'Sumedang Selatan ',3,487),(1160,'Sumedang Utara ',3,487),(1161,'Sumur Bandung ',3,56),(1162,'Surade ',3,478),(1163,'Suranenggala ',3,146),(1164,'Surian ',3,487),(1165,'Susukan ',3,146),(1166,'Susukan Lebak ',3,146),(1167,'Tajurhalang ',3,113),(1168,'Takokak ',3,141),(1169,'Talaga ',3,293),(1170,'Talagasari ',3,208),(1171,'Talegong ',3,163),(1172,'Talun (Cirebon Selatan) ',3,146),(1173,'Tamansari ',3,113),(1174,'Tamansari ',3,515),(1175,'Tambakdahan ',3,475),(1176,'Tambaksari ',3,140),(1177,'Tambelang ',3,90),(1178,'Tambun Selatan ',3,90),(1179,'Tambun Utara ',3,90),(1180,'Tanah Sereal ',3,114),(1181,'Tanggeung ',3,141),(1182,'Tanjungjaya ',3,516),(1183,'Tanjungkerta ',3,487),(1184,'Tanjungmedar ',3,487),(1185,'Tanjungsari ',3,113),(1186,'Tanjungsari ',3,487),(1187,'Tanjungsiang ',3,475),(1188,'Tapos ',3,152),(1189,'Taraju ',3,516),(1190,'Tarogong Kaler ',3,163),(1191,'Tarogong Kidul ',3,163),(1192,'Tarumajaya ',3,90),(1193,'Tawang ',3,515),(1194,'Tegal Waru ',3,424),(1195,'Tegalbuleud ',3,478),(1196,'Tegalwaru ',3,208),(1197,'Telukjambe Barat ',3,208),(1198,'Telukjambe Timur ',3,208),(1199,'Tempuran ',3,208),(1200,'Tengah Tani ',3,146),(1201,'Tenjo ',3,113),(1202,'Tenjolaya ',3,113),(1203,'Tirtajaya ',3,208),(1204,'Tirtamulya ',3,208),(1205,'Tomo ',3,487),(1206,'Trisi/Terisi ',3,186),(1207,'Tukdana ',3,186),(1208,'Ujung Berung ',3,56),(1209,'Ujungjaya ',3,487),(1210,'Wado ',3,487),(1211,'Waled ',3,146),(1212,'Waluran ',3,478),(1213,'Wanaraja ',3,163),(1214,'Wanayasa ',3,424),(1215,'Warudoyong ',3,477),(1216,'Warungkiara ',3,478),(1217,'Warungkondang ',3,141),(1218,'Weru ',3,146),(1219,'Widasari ',3,186),(1220,'Angsana ',3,378),(1221,'Anyar ',3,450),(1222,'Balaraja ',3,503),(1223,'Bandung ',3,450),(1224,'Banjar ',3,378),(1225,'Banjarsari ',3,272),(1226,'Baros ',3,450),(1227,'Batuceper ',3,502),(1228,'Bayah ',3,272),(1229,'Benda ',3,502),(1230,'Binuang ',3,450),(1231,'Bojonegara ',3,450),(1232,'Bojong ',3,378),(1233,'Bojongmanik ',3,272),(1234,'Cadasari ',3,378),(1235,'Carenang (Cerenang) ',3,450),(1236,'Carita ',3,378),(1237,'Cibadak ',3,272),(1238,'Cibaliung ',3,378),(1239,'Cibeber ',3,143),(1240,'Cibeber ',3,272),(1241,'Cibitung ',3,378),(1242,'Cibodas ',3,502),(1243,'Cigemblong ',3,272),(1244,'Cigeulis ',3,378),(1245,'Cihara ',3,272),(1246,'Cijaku ',3,272),(1247,'Cikande ',3,450),(1248,'Cikeudal (Cikedal) ',3,378),(1249,'Cikeusal ',3,450),(1250,'Cikeusik ',3,378),(1251,'Cikulur ',3,272),(1252,'Cikupa ',3,503),(1253,'Ciledug ',3,502),(1254,'Cilegon ',3,143),(1255,'Cileles ',3,272),(1256,'Cilograng ',3,272),(1257,'Cimanggu ',3,378),(1258,'Cimanuk ',3,378),(1259,'Cimarga ',3,272),(1260,'Cinangka ',3,450),(1261,'Ciomas ',3,450),(1262,'Cipanas ',3,272),(1263,'Cipeucang ',3,378),(1264,'Cipocok Jaya ',3,449),(1265,'Cipondoh ',3,502),(1266,'Ciputat ',3,504),(1267,'Ciputat Timur ',3,504),(1268,'Cirinten ',3,272),(1269,'Ciruas ',3,450),(1270,'Cisata ',3,378),(1271,'Cisauk ',3,503),(1272,'Cisoka ',3,503),(1273,'Citangkil ',3,143),(1274,'Ciwandan ',3,143),(1275,'Curug ',3,449),(1276,'Curug ',3,503),(1277,'Curugbitung ',3,272),(1278,'Gerogol ',3,143),(1279,'Gunung Kaler ',3,503),(1280,'Gunung Kencana ',3,272),(1281,'Gunungsari ',3,450),(1282,'Jambe ',3,503),(1283,'Jatiuwung ',3,502),(1284,'Jawilan ',3,450),(1285,'Jayanti ',3,503),(1286,'Jiput ',3,378),(1287,'Jombang ',3,143),(1288,'Kaduhejo ',3,378),(1289,'Kalanganyar ',3,272),(1290,'Karang Tanjung ',3,378),(1291,'Karang Tengah ',3,502),(1292,'Karawaci ',3,502),(1293,'Kasemen ',3,449),(1294,'Kelapa Dua ',3,503),(1295,'Kemiri ',3,503),(1296,'Kibin ',3,450),(1297,'Kopo ',3,450),(1298,'Koroncong ',3,378),(1299,'Kosambi ',3,503),(1300,'Kragilan ',3,450),(1301,'Kramatwatu ',3,450),(1302,'Kresek ',3,503),(1303,'Kronjo ',3,503),(1304,'Labuan ',3,378),(1305,'Larangan ',3,502),(1306,'Lebak Wangi ',3,450),(1307,'Lebakgedong ',3,272),(1308,'Legok ',3,503),(1309,'Leuwidamar ',3,272),(1310,'Maja ',3,272),(1311,'Majasari ',3,378),(1312,'Malingping ',3,272),(1313,'Mancak ',3,450),(1314,'Mandalawangi ',3,378),(1315,'Mauk ',3,503),(1316,'Mekar Baru ',3,503),(1317,'Mekarjaya ',3,378),(1318,'Menes ',3,378),(1319,'Muncang ',3,272),(1320,'Munjul ',3,378),(1321,'Neglasari ',3,502),(1322,'Pabuaran ',3,450),(1323,'Padarincang ',3,450),(1324,'Pagedangan ',3,503),(1325,'Pagelaran ',3,378),(1326,'Pakuhaji ',3,503),(1327,'Pamarayan ',3,450),(1328,'Pamulang ',3,504),(1329,'Pandeglang ',3,378),(1330,'Panggarangan ',3,272),(1331,'Panimbang ',3,378),(1332,'Panongan ',3,503),(1333,'Pasar Kemis ',3,503),(1334,'Patia ',3,378),(1335,'Periuk ',3,502),(1336,'Petir ',3,450),(1337,'Picung ',3,378),(1338,'Pinang (Penang) ',3,502),(1339,'Pondok Aren ',3,504),(1340,'Pontang ',3,450),(1341,'Pulo Ampel ',3,450),(1342,'Pulomerak ',3,143),(1343,'Pulosari ',3,378),(1344,'Purwakarta ',3,143),(1345,'Rajeg ',3,503),(1346,'Rangkasbitung ',3,272),(1347,'Sajira ',3,272),(1348,'Saketi ',3,378),(1349,'Sepatan ',3,503),(1350,'Sepatan Timur ',3,503),(1351,'Serang ',3,449),(1352,'Serpong ',3,504),(1353,'Serpong Utara ',3,504),(1354,'Setu ',3,504),(1355,'Sindang Jaya ',3,503),(1356,'Sindangresmi ',3,378),(1357,'Sobang ',3,272),(1358,'Sobang ',3,378),(1359,'Solear ',3,503),(1360,'Sukadiri ',3,503),(1361,'Sukamulya ',3,503),(1362,'Sukaresmi ',3,378),(1363,'Sumur ',3,378),(1364,'Taktakan ',3,449),(1365,'Tanara ',3,450),(1366,'Tangerang ',3,502),(1367,'Teluknaga ',3,503),(1368,'Tigaraksa ',3,503),(1369,'Tirtayasa ',3,450),(1370,'Tunjung Teja ',3,450),(1371,'Walantaka ',3,449),(1372,'Wanasalam ',3,272),(1373,'Waringin Kurung ',3,450),(1374,'Warunggunung ',3,272);

/*Table structure for table `area_level` */

DROP TABLE IF EXISTS `area_level`;

CREATE TABLE `area_level` (
  `area_level_id` int(11) NOT NULL,
  `area_level_name` varchar(45) NOT NULL,
  PRIMARY KEY (`area_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `area_level` */

insert  into `area_level`(`area_level_id`,`area_level_name`) values (1,'Provinsi'),(2,'Kabupaten Kota'),(3,'Kecamatan'),(4,'Kelurahan/Desa');

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
  `customer_region` int(10) unsigned DEFAULT NULL,
  `customer_city` int(10) unsigned DEFAULT NULL,
  `customer_phone_number` varchar(16) NOT NULL,
  `customer_username` varchar(64) NOT NULL,
  `customer_password` varchar(64) NOT NULL,
  `customer_photo` varchar(128) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_email` (`customer_email`),
  UNIQUE KEY `customer_username` (`customer_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

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
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`dev_user_id`),
  UNIQUE KEY `dev_username` (`dev_username`),
  UNIQUE KEY `dev_email` (`dev_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `developer_user` */

insert  into `developer_user`(`dev_user_id`,`dev_name`,`dev_ownername`,`dev_slug`,`dev_address`,`dev_city`,`dev_username`,`dev_password`,`dev_email`,`dev_biography`,`dev_phone_office`,`dev_mobile_phone`,`dev_ownership`,`dev_logo`,`created_at`,`updated_at`) values (1,'PT Agung Podomoro Land Tbk','PT Agung Podomoro Land Tbk','pt-agung-podomoro-land-tbk','APL Tower 43rd Floor, Podomoro City Jl. Let. Jend. S. Parman Kav. 28 Jakarta 11470 Indonesia',2,'agungpodomoro','25d55ad283aa400af464c76d713c07ad','podomoro@gmail.com','PT Agung Podomoro Land Tbk. (APLN) is a leading integrated diversified real estate owner, developer and manager in the retail, commercial, and residential real estate segments with diversified holdings. We have an integrated property development model, from land acquisition and/or sourcing, to design and development, to project management, sales, commercial leasing and marketing, to the operation and management of our superblock developments, shopping malls, offices, hotels, and residential apartments and houses. We are known as a pioneer of the superblock development. Our high quality landmark projects, to name a few are Podomoro City, Kuningan City, and Senayan City.\n\n \n\nAPLN was established on July 30, 2004 under the name PT Tiara Metropolitan Jaya. In 2010, our shareholders completed a corporate restructuring, pursuant to which six developments and their holding companies were transferred to our control. APLN, is the flagship listed entity (IDX:APLN) of Agung Podomoro Group (APG), is one of the fastest growing and largest real estate developers in Indonesia with interests in superblocks, retail properties, office, apartments and residential, and hotels. APG established its first development, a housing complex in Simprug area, South Jakarta, in 1969 and completed its construction in 1973. From 1973 to present, members of APG completed or begun construction of more than 70 property projects, with majority addressed to middle class segments of society, with projects ranging from low cost apartments to high end apartments in South Jakarta, landed residentials, high end and the neighborhood mall, shop houses, hotels, soho and office towers.','622129034567',NULL,'perusahaan','E5J7mlIoEsknBfY1YRifZgs9JBwm3FFEuIi5CBNc.png','2019-09-19 17:02:30','2019-09-19 17:05:58');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `marketing_user` */

insert  into `marketing_user`(`mkt_user_id`,`mkt_fullname`,`mkt_email`,`mkt_username`,`mkt_password`,`mkt_phone_number`,`mkt_mobile_phone`,`mkt_city`,`mkt_address`,`mkt_biography`,`mkt_profile_photo`,`dev_user_id`,`created_at`,`updated_at`) values (1,'Jennifer Aryawinata','jennifer.winata@pijaru.com','jenniferwinata96','25d55ad283aa400af464c76d713c07ad','02121129888','08561969052',5,NULL,NULL,NULL,1,'2019-09-26 17:30:11','2019-09-26 17:51:14'),(2,'Getar Jagatraya','getar.jagatraya@pijaru.com','stickgetar','25d55ad283aa400af464c76d713c07ad','02121292928','08561969052',2,NULL,NULL,NULL,1,'2019-09-26 17:58:35','2019-09-26 17:58:35');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `project_gallery` */

insert  into `project_gallery`(`gallery_id`,`gallery_filename`,`gallery_description`,`project_unique_id`,`created_at`,`updated_at`) values (6,'oXBGYQuDxa9drfsBtVGw8jG1BcU5Z3TBroOWbiz1.jpeg',NULL,'PRY00001','2019-09-22 23:58:42','2019-09-22 23:58:42'),(8,'GI6LJNmTbc1HxHH16MMkhrHhf5UrIMu0DWJjAZFJ.jpeg',NULL,'PRY00001','2019-09-23 00:24:05','2019-09-23 00:24:05'),(9,'7hAp85CBQdIi3gjfRWUK7DCq0JxWGOu92qbDiBx5.jpeg',NULL,'PRY00001','2019-09-23 00:24:47','2019-09-23 00:24:47'),(10,'7EYltLPq8iJwzL2zBXRtOMw3kJ9wT98qvlXxGxcu.jpeg',NULL,'PRY00001','2019-09-23 00:24:58','2019-09-23 00:24:58'),(11,'dF0qeuw6r5cIdfZzl1aUYpfaheHz62QdGemi61Nu.jpeg',NULL,'PRY00001','2019-09-23 00:25:10','2019-09-23 00:25:10'),(13,'Gweoys7kDqtg8fO3p0tneiNEcgHDQSTqWvh9l66p.jpeg',NULL,'PRY00001','2019-09-23 00:25:40','2019-09-23 00:25:40'),(15,'VmIqsjAqwKJDx7lJ4NIbY5jUfEYofcKWHIpbUudS.jpeg',NULL,'PRY00002','2019-09-23 00:31:19','2019-09-23 00:31:19'),(16,'RkH8RKb9spsLVtqA1JiMaqQLovSpIajDkrANJnqp.jpeg',NULL,'PRY00002','2019-09-23 00:31:26','2019-09-23 00:31:26'),(17,'XglqAWirE7tJU37EetbxQyPbGmmeHid8Fw1Ly32f.jpeg',NULL,'PRY00002','2019-09-23 00:31:33','2019-09-23 00:31:33'),(18,'Dyp0Fv71GluOoaJQ12akxYviHVSpPBtjlZr45Dfo.jpeg',NULL,'PRY00002','2019-09-23 00:31:41','2019-09-23 00:31:41'),(19,'7t3eMacwpT3zaac1o2h0eh41lrLLqPIedubU62h3.jpeg',NULL,'PRY00002','2019-09-23 00:31:50','2019-09-23 00:31:50'),(20,'mxjkBGrC6PhPAbAQj9nr2S4JgweMrYZ6rTx9qheb.jpeg',NULL,'PRY00002','2019-09-23 00:31:57','2019-09-23 00:31:57'),(21,'q9RwHWjKgYnSr3b82x5a7AbFMFImLCieVJjxrtjZ.jpeg',NULL,'PRY00002','2019-09-23 00:32:30','2019-09-23 00:32:30'),(22,'JRxZR3JWmxourVcbA2rboDedMpiQ4pR0S7gIJKzn.jpeg',NULL,'PRY00002','2019-09-23 00:32:37','2019-09-23 00:32:37'),(23,'afKgJc1Aiyz3KJtMbhaIVMf5De5LvS5bBbWUlHk3.jpeg',NULL,'PRY00002','2019-09-23 00:32:45','2019-09-23 00:32:45'),(24,'T84G3fcFTTqxV4yij7kb8gooyPwYDdnUqvrmqmaH.jpeg',NULL,'PRY00002','2019-09-23 00:32:53','2019-09-23 00:32:53'),(25,'RF57Lo3Na2CUHdigoNDFcmn7Mq4rlWD3CztDWfLq.jpeg',NULL,'PRY00002','2019-09-23 00:33:00','2019-09-23 00:33:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `project_list` */

insert  into `project_list`(`project_id`,`project_unique_id`,`project_name`,`project_slug`,`project_thumbnail`,`project_description`,`project_address`,`project_city`,`project_link_map`,`project_map_embed`,`project_site_plan`,`project_type`,`project_status`,`project_estimate_launch`,`dev_user_id`,`created_at`,`updated_at`) values (2,'PRY00001','Podomoro Park','podomoro-park','GI6LJNmTbc1HxHH16MMkhrHhf5UrIMu0DWJjAZFJ.jpeg','Agung Podomoro Land (APL) menghadirkan mahakarya terbarunya yaitu Podomoro Park Bandung, kawasan hunian yang terletak di tengah keindahan alam Bandung Selatan, seluas lebih dari 100 hektar. Konsep utama Podomoro Park terinsiprasi dari kawasan hunian berkelas dunia, yaitu Woodbrige di Irvine California serta desain masterplan dan landscape oleh Palmscape Singapore, sehingga Podomoro Park dapat dikategorikan sebagai world class home resort.\n\nPodomoro Park telah meraih penghargaan \"The Best Premium Home Resort in West Java\" dalam event Indonesia Property & Bank Award 2018. Ini membuktikan bahwa Podomoro Park memiliki konsep kawasan terbaik dengan menghadirkan kekuatan elemen alam, dan menjadikannya kawasan hunian resort terbaik di Jawa Barat. Maka tak heran bila antusias pasar sangat tinggi untuk memiliki hunian ini, hingga Podomoro Park menerima penghargaan “Most Favoured Premium Housing Estate” dalam event Housing Estate Award 2018.','Buahbatu, Bandung',9,NULL,NULL,NULL,'residensial','available',NULL,1,'2019-09-20 21:50:40','2019-09-25 21:05:59'),(3,'PRY00002','Podomoro Park View','podomoro-park-view','7t3eMacwpT3zaac1o2h0eh41lrLLqPIedubU62h3.jpeg','Podomoro River View merupakan cluster perumahan baru di kawasan new city Podomoro Golf View yang dikembangkan oleh developer ternama dan terpercaya, Agung Podomoro Land. Didesain dengan konsep gaya hidup masa kini yang modern dan fleksibel, menghadirkan hunian dengan desain yang simple dan minimalis yang memberikan nilai lebih untuk Anda yang menginginkan hunian di kawasan kota baru yang hidup dan terintegrasi.','Cimanggis, Depok',8,NULL,NULL,NULL,'residensial','available',NULL,1,'2019-09-23 00:03:53','2019-09-25 20:30:33');

/*Table structure for table `project_marketing` */

DROP TABLE IF EXISTS `project_marketing`;

CREATE TABLE `project_marketing` (
  `project_marketing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dev_user_id` int(10) unsigned NOT NULL,
  `mkt_user_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`project_marketing_id`),
  KEY `fk_project_mkt_user_id` (`mkt_user_id`),
  KEY `fk_project_mkt_devuser_idx` (`dev_user_id`),
  CONSTRAINT `fk_project_mkt_devuser_idx` FOREIGN KEY (`dev_user_id`) REFERENCES `developer_user` (`dev_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_mkt_user_id` FOREIGN KEY (`mkt_user_id`) REFERENCES `marketing_user` (`mkt_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_marketing` */

/*Table structure for table `project_request` */

DROP TABLE IF EXISTS `project_request`;

CREATE TABLE `project_request` (
  `request_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mkt_user_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `project_unit_type_id` int(10) unsigned NOT NULL,
  `request_note` text NOT NULL,
  `status_request` enum('open','close') NOT NULL DEFAULT 'open',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `fk_req_unit_type_idx` (`project_unit_type_id`),
  KEY `fk_req_mkt_user_idx` (`mkt_user_id`),
  KEY `fk_req_cust_idx` (`customer_id`),
  CONSTRAINT `fk_req_cust_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_mkt_user_idx` FOREIGN KEY (`mkt_user_id`) REFERENCES `marketing_user` (`mkt_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_unit_type_idx` FOREIGN KEY (`project_unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_request` */

/*Table structure for table `project_siteplan` */

DROP TABLE IF EXISTS `project_siteplan`;

CREATE TABLE `project_siteplan` (
  `siteplan_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siteplan_map` varchar(128) NOT NULL,
  `project_unique_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`siteplan_id`),
  KEY `fk_siteplan_project_uidx` (`project_unique_id`),
  CONSTRAINT `fk_siteplan_project_uidx` FOREIGN KEY (`project_unique_id`) REFERENCES `project_list` (`project_unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `project_siteplan` */

insert  into `project_siteplan`(`siteplan_id`,`siteplan_map`,`project_unique_id`,`created_at`,`updated_at`) values (1,'xUqsejTtXLLNKc9Bu4S8B5pDv8lPjk8R5Lg5yr9C.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40'),(2,'TCGqkPmnurIfSBIFx1tpaLVLpQKleEUEYSWOWAzT.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40'),(3,'Xr45uD0jEQA4s2z8C5nZgUhqioWhlj6TQE8hH3Lw.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40'),(4,'SOf76OhuiHUJ15vgSu1S6IegxG1wbut6JHJP03JU.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40'),(5,'azbJXgXWYMwdrtJl8wEjHfah9jhaGgFOgPg3snD7.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40'),(6,'SVO8eDtfh0XpFWon5HvJsN60HTW1vRFqcb3w1SEd.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40'),(7,'K8bGilj7FIBVvBQ3Vnw6n4vyAI6DAgHu4d3ucJbj.jpeg','PRY00001','2019-09-20 21:50:40','2019-09-20 21:50:40');

/*Table structure for table `project_unit` */

DROP TABLE IF EXISTS `project_unit`;

CREATE TABLE `project_unit` (
  `project_unit_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_unit_name` varchar(128) NOT NULL,
  `project_unit_slug` varchar(128) NOT NULL,
  `project_unit_status` enum('available','booked') NOT NULL DEFAULT 'available',
  `project_unique_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`project_unit_id`),
  KEY `fk_project_unit_project_uidx` (`project_unique_id`),
  CONSTRAINT `fk_project_unit_project_uidx` FOREIGN KEY (`project_unique_id`) REFERENCES `project_list` (`project_unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_unit` */

/*Table structure for table `project_unit_gallery` */

DROP TABLE IF EXISTS `project_unit_gallery`;

CREATE TABLE `project_unit_gallery` (
  `unit_gallery_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_gallery_filename` varchar(128) NOT NULL,
  `unit_type_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`unit_gallery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_gallery` */

insert  into `project_unit_gallery`(`unit_gallery_id`,`unit_gallery_filename`,`unit_type_id`,`created_at`,`updated_at`) values (18,'unit-1de809ea5613f7.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(19,'unit-69e79c37eec14a.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(20,'unit-690e88870062bf.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(21,'unit-b790908329d2a8.jpg',1,'2019-09-25 21:01:08','2019-09-25 21:01:08'),(22,'unit-73357fe46d7e8b.jpg',1,'2019-09-25 21:01:22','2019-09-25 21:01:22'),(23,'unit-7010c42484e51d.jpg',1,'2019-09-25 21:01:29','2019-09-25 21:01:29'),(24,'unit-ea0005ce42d60f.jpg',1,'2019-09-25 21:01:42','2019-09-25 21:01:42'),(25,'unit-1de809ea5613f7.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(26,'unit-1e8407a88e77d1.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(27,'unit-5be726ce55f731.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(28,'unit-69e79c37eec14a.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(29,'unit-690e88870062bf.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(30,'unit-853dac535cb8b0.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(31,'unit-6821e98a0c7b46.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(32,'unit-b790908329d2a8.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(33,'unit-ea0005ce42d60f.jpg',4,'2019-09-25 21:04:41','2019-09-25 21:04:41'),(34,'unit-1d67e734ab780e.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(35,'unit-61f1538dd37557.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(36,'unit-95d5264c076083.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(37,'unit-208610fe35a61d.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(38,'unit-b2bf6dfddee69c.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(40,'unit-c048d3937cfb44.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50'),(41,'unit-f56b12d2f24b3e.jpg',5,'2019-09-25 21:37:50','2019-09-25 21:37:50');

/*Table structure for table `project_unit_installment` */

DROP TABLE IF EXISTS `project_unit_installment`;

CREATE TABLE `project_unit_installment` (
  `installment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `installment_dp` bigint(20) unsigned NOT NULL,
  `installment_price` bigint(20) unsigned NOT NULL,
  `installment_tenor` int(10) unsigned NOT NULL,
  `project_unit_type_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`installment_id`),
  KEY `fk_installment_unit_type_id` (`project_unit_type_id`),
  CONSTRAINT `fk_installment_unit_type_id` FOREIGN KEY (`project_unit_type_id`) REFERENCES `project_unit_type` (`unit_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_installment` */

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
  `unit_status` enum('available','sold') NOT NULL DEFAULT 'available',
  `unit_watt` int(10) unsigned DEFAULT NULL,
  `unit_facility` text DEFAULT NULL,
  `unit_thumbnail` varchar(255) DEFAULT NULL,
  `project_unique_id` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`unit_type_id`),
  KEY `fk_unit_project_uidx` (`project_unique_id`),
  CONSTRAINT `fk_unit_project_uidx` FOREIGN KEY (`project_unique_id`) REFERENCES `project_list` (`project_unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `project_unit_type` */

insert  into `project_unit_type`(`unit_type_id`,`unit_name`,`unit_slug`,`unit_floor`,`unit_lb`,`unit_lt`,`unit_kt`,`unit_km`,`unit_price`,`unit_description`,`unit_status`,`unit_watt`,`unit_facility`,`unit_thumbnail`,`project_unique_id`,`created_at`,`updated_at`) values (1,'Podomoro Park Bandung Tipe 6','podomoro-park-bandung-tipe-6',2,94,90,2,3,1400000000,'<p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">CLUSTER AMAGRIYA (DELUXE)</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 15 meter (Nalendra):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;90 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,4 milyar</span></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(68, 68, 68);\">Spesifikasi Type 6 x 17 meter (Kancana):</strong></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;102 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Luas bangunan&nbsp;94 m2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(68, 68, 68);\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</span></p><p><span style=\"color: rgb(68, 68, 68);\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 1,5 milyar</span></p><p><strong style=\"color: rgb(68, 68, 68);\">Fasilitas premium yang disediakan oleh Podomoro Park Bandung, yaitu :</strong></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Club House</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Taman Bermain Anak</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Bike Lane</em></p><p><span style=\"color: rgb(68, 68, 68);\">- Kolam Renang</span></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Community Garden</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gym</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Gazebo</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Jogging Track</em></p><p><span style=\"color: rgb(68, 68, 68);\">-&nbsp;</span><em style=\"color: rgb(68, 68, 68);\">Viewing Deck</em></p>','available',3500,'Air Panas,Balkon,Taman,Taman Bermain Anak,Telepon,Keamanan 24 Jam,Kolam Renang,Pendingin Ruangan (AC)','unit-ea0005ce42d60f.jpg','PRY00001','2019-09-24 22:13:41','2019-09-25 21:01:47'),(4,'Podomoro Park Bandung Tipe 7','podomoro-park-bandung-tipe-7',2,127,126,3,3,2000000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER AMAGRIYA (DELUXE)</strong></p><p>Sentuhan hijau di sekeliling kawasan cluster Amagriya menjadi keunggulan tersendiri yang memberikan keteduhan. Dilengkapi dengan ventilasi alamai yang menjaga sirkulasi udara tetap segar. Hadirnya fasilitas collective garden yangterletak di belakang hunian menambah kenyamanan serta menciptakan kualitas hidup yang lebih sehat.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 7 x 18 meter (Sanjaya):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;126 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;127 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3500 VA</p><p>Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 2 milyar</p>','available',3500,'Air Panas,Kolam Renang,Balkon,Pendingin Ruangan (AC),Telepon,Taman Bermain Anak,Keamanan 24 Jam,Taman','unit-69e79c37eec14a.jpg','PRY00001','2019-09-25 21:03:37','2019-09-25 21:05:14'),(5,'Podomoro Park Bandung Tipe 8','podomoro-park-bandung-tipe-8',2,156,160,4,3,3100000000,'<p><strong>PROMO KEMERDEKAAN PODOMORO PARK BANDUNG AGUSTUS 2019 : UNTUK 17 UNIT PERTAMA MENDAPATKAN DISC 17% HANYA SAMPAI TANGGAL 17 AGUSTUS</strong></p><p><strong>CLUSTER ANAPURI (PREMIUM)</strong></p><p class=\"ql-align-justify\">Suasana keasrian resort akan sangat terasa ketika memasuki&nbsp;<em>gate cluster</em>&nbsp;yang megah dengan dihiasi hamparan taman dengan berbagai variasi bunga indah. Hunian mewah ini memiliki desain fasad yang&nbsp;<em>elegant</em>,&nbsp;<em>carport</em>&nbsp;yang luas,&nbsp;<em>living room</em>&nbsp;yang nyaman dengan akses langsung menuju&nbsp;<em>backyard</em>, hingga kehangatan suasana akan semakin tercipta dengan adanya&nbsp;<em>collective garden</em>&nbsp;yang terdapat di sisi belakang rumah. Hunian ini memiliki akses yang sangat dekat menuju danau dan memiliki&nbsp;<em>view&nbsp;</em>yang sangat indah karena barisan pegunungan Bandung Selatan tampak jelas dihadapan.</p><p class=\"ql-align-justify\"><strong>Spesifikasi Type 8 x 20 meter (Darmaraja):</strong></p><p class=\"ql-align-justify\">Luas tanah&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;160 m2</p><p class=\"ql-align-justify\">Luas bangunan&nbsp;156 m2</p><p class=\"ql-align-justify\">Jumlah lantai&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Kamar tidur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 + 1</p><p class=\"ql-align-justify\">Kamar mandi&nbsp;&nbsp;&nbsp;&nbsp;3 + 1</p><p class=\"ql-align-justify\">Lahan parkir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</p><p class=\"ql-align-justify\">Watt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4400 VA</p><p class=\"ql-align-justify\">Harga&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mulai dari 3,1 milyar</p><p><br></p>','available',4400,'Air Panas,Pendingin Ruangan (AC),Balkon,Kolam Renang,Taman,Taman Bermain Anak,Keamanan 24 Jam,Telepon','unit-208610fe35a61d.jpg','PRY00001','2019-09-25 21:34:51','2019-09-26 14:09:24');

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

/*Table structure for table `survey_schedule` */

DROP TABLE IF EXISTS `survey_schedule`;

CREATE TABLE `survey_schedule` (
  `survey_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `survey_date` datetime NOT NULL,
  `mkt_user_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `request_id` int(10) unsigned NOT NULL,
  `status_survey` enum('open','close') NOT NULL DEFAULT 'open',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`survey_id`),
  KEY `fk_survey_req_idx` (`request_id`),
  KEY `fk_survey_mkt_user_idx` (`mkt_user_id`),
  KEY `fk_survey_cust_idx` (`customer_id`),
  CONSTRAINT `fk_survey_cust_idx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `fk_survey_mkt_user_idx` FOREIGN KEY (`mkt_user_id`) REFERENCES `marketing_user` (`mkt_user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_survey_req_idx` FOREIGN KEY (`request_id`) REFERENCES `project_request` (`request_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `survey_schedule` */

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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
