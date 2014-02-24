CREATE DATABASE  IF NOT EXISTS `gw2rothchild` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `gw2rothchild`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 192.168.1.75    Database: gw2rothchild
-- ------------------------------------------------------
-- Server version	5.6.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `hashkey` varchar(255) NOT NULL,
  `prop` varchar(255) NOT NULL,
  `val` int(11) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `sendinterval` int(11) NOT NULL,
  `pastdue` bit(1) DEFAULT NULL,
  PRIMARY KEY (`alert_id`),
  KEY `FK589895C7E45A8FA` (`item_id`),
  KEY `FK589895CF7634DFA` (`user_id`),
  KEY `val` (`val`),
  KEY `updated` (`updated`),
  KEY `created` (`created`),
  KEY `prop` (`prop`),
  KEY `operator` (`operator`),
  KEY `sendinterval` (`sendinterval`),
  CONSTRAINT `FK589895C7E45A8FA` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `FK589895CF7634DFA` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alertlog`
--

DROP TABLE IF EXISTS `alertlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alertlog` (
  `alertlog_id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `successful` bit(1) DEFAULT b'1',
  `errors` longtext,
  PRIMARY KEY (`alertlog_id`),
  KEY `FK60494C68640FB41A` (`alert_id`),
  KEY `updated` (`updated`),
  KEY `created` (`created`),
  KEY `email` (`email`),
  CONSTRAINT `FK60494C68640FB41A` FOREIGN KEY (`alert_id`) REFERENCES `alert` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bonus`
--

DROP TABLE IF EXISTS `bonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bonus` (
  `bonus_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`bonus_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftdiscipline`
--

DROP TABLE IF EXISTS `craftdiscipline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftdiscipline` (
  `craftdiscipline_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`craftdiscipline_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftdiscipline_recipe_jn`
--

DROP TABLE IF EXISTS `craftdiscipline_recipe_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftdiscipline_recipe_jn` (
  `recipe_id` int(11) DEFAULT NULL,
  `craftdiscipline_id` int(11) DEFAULT NULL,
  KEY `FKEEE6A5A6C28ACB1A` (`recipe_id`),
  KEY `FKEEE6A5A6171B5BBA` (`craftdiscipline_id`),
  CONSTRAINT `FKEEE6A5A6171B5BBA` FOREIGN KEY (`craftdiscipline_id`) REFERENCES `craftdiscipline` (`craftdiscipline_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKEEE6A5A6C28ACB1A` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gametype`
--

DROP TABLE IF EXISTS `gametype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gametype` (
  `gametype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`gametype_id`),
  KEY `created` (`created`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `infusionslot`
--

DROP TABLE IF EXISTS `infusionslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infusionslot` (
  `infusionslot_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`infusionslot_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `icon_file_id` int(11) DEFAULT NULL,
  `icon_file_signature` varchar(250) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `vendor_value` int(11) DEFAULT NULL,
  `gw2db_external_id` int(11) DEFAULT '0',
  `img` varchar(250) DEFAULT NULL,
  `sub_type_id` int(11) DEFAULT '0',
  `type_id` int(11) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `rarity_id` int(11) DEFAULT NULL,
  `itemtype_id` int(11) DEFAULT NULL,
  `suffix_item_id` int(11) DEFAULT NULL,
  `upgradecomponent_price_difference` int(11) DEFAULT NULL,
  `last_max_offer` int(11) DEFAULT NULL,
  `last_min_sale` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `itemtype_id` (`itemtype_id`),
  KEY `level` (`level`),
  KEY `icon_file_signature` (`icon_file_signature`),
  KEY `updated` (`updated`),
  KEY `created` (`created`),
  KEY `gw2db_external_id` (`gw2db_external_id`),
  KEY `description` (`description`),
  KEY `name` (`name`),
  KEY `img` (`img`),
  KEY `vendor_value` (`vendor_value`),
  KEY `sub_type_id` (`sub_type_id`),
  KEY `type_id` (`type_id`),
  KEY `icon_file_id` (`icon_file_id`),
  KEY `FK317B133C9379FA` (`rarity_id`),
  KEY `FK317B1394257ADA` (`itemtype_id`),
  KEY `suffix_item_id` (`suffix_item_id`),
  KEY `upgradecomponent_price_difference` (`upgradecomponent_price_difference`),
  KEY `last_max_offer` (`last_max_offer`,`last_min_sale`),
  CONSTRAINT `FK317B133C9379FA` FOREIGN KEY (`rarity_id`) REFERENCES `rarity` (`rarity_id`),
  CONSTRAINT `FK317B1394257ADA` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `item_BUPD` BEFORE UPDATE ON item FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one
SET NEW.updated = UTC_TIMESTAMP */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `item_gametype_jn`
--

DROP TABLE IF EXISTS `item_gametype_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_gametype_jn` (
  `item_id` int(11) DEFAULT NULL,
  `gametype_id` int(11) DEFAULT NULL,
  KEY `FK236F750BFC600A7A` (`gametype_id`),
  KEY `FK236F750B7E45A8FA` (`item_id`),
  CONSTRAINT `FK236F750B7E45A8FA` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `FK236F750BFC600A7A` FOREIGN KEY (`gametype_id`) REFERENCES `gametype` (`gametype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_itemflag_jn`
--

DROP TABLE IF EXISTS `item_itemflag_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_itemflag_jn` (
  `item_id` int(11) DEFAULT NULL,
  `itemflag_id` int(11) DEFAULT NULL,
  KEY `FKFF979589886359A` (`itemflag_id`),
  KEY `FKFF979587E45A8FA` (`item_id`),
  CONSTRAINT `FKFF979587E45A8FA` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `FKFF979589886359A` FOREIGN KEY (`itemflag_id`) REFERENCES `itemflag` (`itemflag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_restriction_jn`
--

DROP TABLE IF EXISTS `item_restriction_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_restriction_jn` (
  `item_id` int(11) DEFAULT NULL,
  `restriction_id` int(11) DEFAULT NULL,
  KEY `FKB51645437E45A8FA` (`item_id`),
  KEY `FKB516454317EAF61A` (`restriction_id`),
  CONSTRAINT `FKB516454317EAF61A` FOREIGN KEY (`restriction_id`) REFERENCES `restriction` (`restriction_id`),
  CONSTRAINT `FKB51645437E45A8FA` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemattribute`
--

DROP TABLE IF EXISTS `itemattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemattribute` (
  `itemattribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(250) DEFAULT NULL,
  `modifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`itemattribute_id`),
  KEY `modifier` (`modifier`),
  KEY `attribute` (`attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=344187 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemflag`
--

DROP TABLE IF EXISTS `itemflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemflag` (
  `itemflag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`itemflag_id`),
  KEY `created` (`created`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype`
--

DROP TABLE IF EXISTS `itemtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype` (
  `itemtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(255) NOT NULL,
  PRIMARY KEY (`itemtype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=211100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_armor`
--

DROP TABLE IF EXISTS `itemtype_armor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_armor` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `weight_class` varchar(250) DEFAULT NULL,
  `defense` int(11) DEFAULT NULL,
  `suffix_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `defense` (`defense`),
  KEY `suffix_item_id` (`suffix_item_id`),
  KEY `weight_class` (`weight_class`),
  KEY `type` (`type`),
  KEY `FKE46E7F4D4DE4CAEC` (`itemtype_id`),
  CONSTRAINT `FKE46E7F4D4DE4CAEC` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_armor_infusionslot_jn`
--

DROP TABLE IF EXISTS `itemtype_armor_infusionslot_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_armor_infusionslot_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `infusionslot_id` int(11) DEFAULT NULL,
  KEY `FK7DCD78AA5CAF7C9A` (`infusionslot_id`),
  KEY `FK7DCD78AA4DE4CAEC` (`itemtype_id`),
  CONSTRAINT `FK7DCD78AA4DE4CAEC` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FK7DCD78AA5CAF7C9A` FOREIGN KEY (`infusionslot_id`) REFERENCES `infusionslot` (`infusionslot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_armor_itemattribute_jn`
--

DROP TABLE IF EXISTS `itemtype_armor_itemattribute_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_armor_itemattribute_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `itemattribute_id` int(11) DEFAULT NULL,
  KEY `FKDD5CAF0C63882CDA` (`itemattribute_id`),
  KEY `FKDD5CAF0C4DE4CAEC` (`itemtype_id`),
  CONSTRAINT `FKDD5CAF0C4DE4CAEC` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FKDD5CAF0C63882CDA` FOREIGN KEY (`itemattribute_id`) REFERENCES `itemattribute` (`itemattribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_back`
--

DROP TABLE IF EXISTS `itemtype_back`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_back` (
  `itemtype_id` int(11) NOT NULL,
  `suffix_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `suffix_item_id` (`suffix_item_id`),
  KEY `FK30A8ED194A3AD2D4` (`itemtype_id`),
  CONSTRAINT `FK30A8ED194A3AD2D4` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_back_infusionslot_jn`
--

DROP TABLE IF EXISTS `itemtype_back_infusionslot_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_back_infusionslot_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `infusionslot_id` int(11) DEFAULT NULL,
  KEY `FKB0EACE765CAF7C9A` (`infusionslot_id`),
  KEY `FKB0EACE764A3AD2D4` (`itemtype_id`),
  CONSTRAINT `FKB0EACE764A3AD2D4` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FKB0EACE765CAF7C9A` FOREIGN KEY (`infusionslot_id`) REFERENCES `infusionslot` (`infusionslot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_back_itemattribute_jn`
--

DROP TABLE IF EXISTS `itemtype_back_itemattribute_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_back_itemattribute_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `itemattribute_id` int(11) DEFAULT NULL,
  KEY `FKDEA12C063882CDA` (`itemattribute_id`),
  KEY `FKDEA12C04A3AD2D4` (`itemtype_id`),
  CONSTRAINT `FKDEA12C04A3AD2D4` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FKDEA12C063882CDA` FOREIGN KEY (`itemattribute_id`) REFERENCES `itemattribute` (`itemattribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_bag`
--

DROP TABLE IF EXISTS `itemtype_bag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_bag` (
  `itemtype_id` int(11) NOT NULL,
  `no_sell_or_sort` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `no_sell_or_sort` (`no_sell_or_sort`),
  KEY `size` (`size`),
  KEY `FKF94FC5964A1C5DB5` (`itemtype_id`),
  CONSTRAINT `FKF94FC5964A1C5DB5` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_consumable`
--

DROP TABLE IF EXISTS `itemtype_consumable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_consumable` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `duration_ms` int(11) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `unlock_type` varchar(250) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `recipe_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `color_id` (`color_id`),
  KEY `description` (`description`),
  KEY `duration_ms` (`duration_ms`),
  KEY `type` (`type`),
  KEY `unlock_type` (`unlock_type`),
  KEY `recipe_id` (`recipe_id`),
  KEY `FK5DB9D915B7029450` (`itemtype_id`),
  CONSTRAINT `FK5DB9D915B7029450` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_container`
--

DROP TABLE IF EXISTS `itemtype_container`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_container` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `type` (`type`),
  KEY `FK2CE9B38FA90EC62E` (`itemtype_id`),
  CONSTRAINT `FK2CE9B38FA90EC62E` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_craftingmaterial`
--

DROP TABLE IF EXISTS `itemtype_craftingmaterial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_craftingmaterial` (
  `itemtype_id` int(11) NOT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `FKB889321B374D06F6` (`itemtype_id`),
  CONSTRAINT `FKB889321B374D06F6` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_gathering`
--

DROP TABLE IF EXISTS `itemtype_gathering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_gathering` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `type` (`type`),
  KEY `FKF8D29B1574F7ADB4` (`itemtype_id`),
  CONSTRAINT `FKF8D29B1574F7ADB4` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_gizmo`
--

DROP TABLE IF EXISTS `itemtype_gizmo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_gizmo` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `type` (`type`),
  KEY `FKE4BF25884E357127` (`itemtype_id`),
  CONSTRAINT `FKE4BF25884E357127` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_minipet`
--

DROP TABLE IF EXISTS `itemtype_minipet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_minipet` (
  `itemtype_id` int(11) NOT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `FKEE466BF6ECC712F5` (`itemtype_id`),
  CONSTRAINT `FKEE466BF6ECC712F5` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_tool`
--

DROP TABLE IF EXISTS `itemtype_tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_tool` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `charges` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `charges` (`charges`),
  KEY `type` (`type`),
  KEY `FK30B151CA4A433785` (`itemtype_id`),
  CONSTRAINT `FK30B151CA4A433785` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_trinket`
--

DROP TABLE IF EXISTS `itemtype_trinket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_trinket` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `suffix_item_id` int(11) DEFAULT NULL,
  `suffix` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `suffix_item_id` (`suffix_item_id`),
  KEY `type` (`type`),
  KEY `suffix` (`suffix`),
  KEY `FK6FA965E56E2A8504` (`itemtype_id`),
  CONSTRAINT `FK6FA965E56E2A8504` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_trinket_infusionslot_jn`
--

DROP TABLE IF EXISTS `itemtype_trinket_infusionslot_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_trinket_infusionslot_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `infusionslot_id` int(11) DEFAULT NULL,
  KEY `FKD7582F425CAF7C9A` (`infusionslot_id`),
  KEY `FKD7582F426E2A8504` (`itemtype_id`),
  CONSTRAINT `FKD7582F425CAF7C9A` FOREIGN KEY (`infusionslot_id`) REFERENCES `infusionslot` (`infusionslot_id`),
  CONSTRAINT `FKD7582F426E2A8504` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_trinket_itemattribute_jn`
--

DROP TABLE IF EXISTS `itemtype_trinket_itemattribute_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_trinket_itemattribute_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `itemattribute_id` int(11) DEFAULT NULL,
  KEY `FKB528CB7463882CDA` (`itemattribute_id`),
  KEY `FKB528CB746E2A8504` (`itemtype_id`),
  CONSTRAINT `FKB528CB7463882CDA` FOREIGN KEY (`itemattribute_id`) REFERENCES `itemattribute` (`itemattribute_id`),
  CONSTRAINT `FKB528CB746E2A8504` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_trophy`
--

DROP TABLE IF EXISTS `itemtype_trophy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_trophy` (
  `itemtype_id` int(11) NOT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `FKC9CE69E2DFED0C1D` (`itemtype_id`),
  CONSTRAINT `FKC9CE69E2DFED0C1D` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_upgradecomponent`
--

DROP TABLE IF EXISTS `itemtype_upgradecomponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_upgradecomponent` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `suffix` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `type` (`type`),
  KEY `suffix` (`suffix`),
  KEY `FK3C624F932EBDE02E` (`itemtype_id`),
  CONSTRAINT `FK3C624F932EBDE02E` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_upgradecomponent_bonus_jn`
--

DROP TABLE IF EXISTS `itemtype_upgradecomponent_bonus_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_upgradecomponent_bonus_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `bonus_id` int(11) DEFAULT NULL,
  KEY `FKFDBA20907A38993A` (`bonus_id`),
  KEY `FKFDBA20902EBDE02E` (`itemtype_id`),
  CONSTRAINT `FKFDBA20902EBDE02E` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FKFDBA20907A38993A` FOREIGN KEY (`bonus_id`) REFERENCES `bonus` (`bonus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_upgradecomponent_infusionslot_jn`
--

DROP TABLE IF EXISTS `itemtype_upgradecomponent_infusionslot_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_upgradecomponent_infusionslot_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `infusionslot_id` int(11) DEFAULT NULL,
  KEY `FKA293FCF05CAF7C9A` (`infusionslot_id`),
  KEY `FKA293FCF02EBDE02E` (`itemtype_id`),
  CONSTRAINT `FKA293FCF02EBDE02E` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FKA293FCF05CAF7C9A` FOREIGN KEY (`infusionslot_id`) REFERENCES `infusionslot` (`infusionslot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_upgradecomponent_itemattribute_jn`
--

DROP TABLE IF EXISTS `itemtype_upgradecomponent_itemattribute_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_upgradecomponent_itemattribute_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `itemattribute_id` int(11) DEFAULT NULL,
  KEY `FK5166B38663882CDA` (`itemattribute_id`),
  KEY `FK5166B3862EBDE02E` (`itemtype_id`),
  CONSTRAINT `FK5166B3862EBDE02E` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`),
  CONSTRAINT `FK5166B38663882CDA` FOREIGN KEY (`itemattribute_id`) REFERENCES `itemattribute` (`itemattribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_weapon`
--

DROP TABLE IF EXISTS `itemtype_weapon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_weapon` (
  `itemtype_id` int(11) NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `damage_type` varchar(250) DEFAULT NULL,
  `min_power` int(11) DEFAULT NULL,
  `max_power` int(11) DEFAULT NULL,
  `defense` int(11) DEFAULT NULL,
  `suffix_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemtype_id`),
  KEY `defense` (`defense`),
  KEY `min_power` (`min_power`),
  KEY `suffix_item_id` (`suffix_item_id`),
  KEY `damage_type` (`damage_type`),
  KEY `type` (`type`),
  KEY `max_power` (`max_power`),
  KEY `FKCE2F65CEE44E0809` (`itemtype_id`),
  CONSTRAINT `FKCE2F65CEE44E0809` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtype_weapon_itemattribute_jn`
--

DROP TABLE IF EXISTS `itemtype_weapon_itemattribute_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtype_weapon_itemattribute_jn` (
  `itemtype_id` int(11) DEFAULT NULL,
  `itemattribute_id` int(11) DEFAULT NULL,
  KEY `FKCA477AAB63882CDA` (`itemattribute_id`),
  KEY `FKCA477AABE44E0809` (`itemtype_id`),
  CONSTRAINT `FKCA477AAB63882CDA` FOREIGN KEY (`itemattribute_id`) REFERENCES `itemattribute` (`itemattribute_id`),
  CONSTRAINT `FKCA477AABE44E0809` FOREIGN KEY (`itemtype_id`) REFERENCES `itemtype` (`itemtype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemupdate`
--

DROP TABLE IF EXISTS `itemupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemupdate` (
  `itemupdate_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated_count` int(11) DEFAULT NULL,
  `created_count` int(11) DEFAULT NULL,
  `successful` bit(1) DEFAULT b'0',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`itemupdate_id`),
  KEY `updated_count` (`updated_count`,`created_count`),
  KEY `created` (`created`),
  KEY `successful` (`successful`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` varchar(36) NOT NULL,
  `severity` varchar(10) NOT NULL,
  `category` varchar(100) NOT NULL,
  `logdate` datetime NOT NULL,
  `appendername` varchar(100) NOT NULL,
  `message` longtext,
  `extrainfo` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketdata`
--

DROP TABLE IF EXISTS `marketdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketdata` (
  `marketdata_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `max_offer_unit_price` int(11) DEFAULT NULL,
  `min_sale_unit_price` int(11) DEFAULT NULL,
  `offer_availability` int(11) DEFAULT NULL,
  `offer_price_change_last_hour` int(11) DEFAULT NULL,
  `price_last_changed` datetime DEFAULT NULL,
  `sale_availability` int(11) DEFAULT NULL,
  `sale_price_change_last_hour` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`marketdata_id`),
  UNIQUE KEY `duplicate_info` (`item_id`,`price_last_changed`),
  KEY `sale_price_change_last_hour` (`sale_price_change_last_hour`),
  KEY `max_offer_unit_price` (`max_offer_unit_price`),
  KEY `price_last_changed` (`price_last_changed`),
  KEY `sale_availability` (`sale_availability`),
  KEY `offer_price_change_last_hour` (`offer_price_change_last_hour`),
  KEY `offer_availability` (`offer_availability`),
  KEY `item_id` (`item_id`),
  KEY `min_sale_unit_price` (`min_sale_unit_price`),
  KEY `created` (`created`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24581123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `marketdata_BINS` BEFORE INSERT ON marketdata FOR EACH ROW
SET NEW.created = NOW() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `marketdata_AINS` AFTER INSERT ON marketdata FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one

BEGIN
DECLARE suffix_item_id int(11) DEFAULT 0;
SELECT item.suffix_item_id INTO @suffix_item_id FROM item WHERE item.item_id = NEW.item_id;
IF @suffix_item_id is not null THEN
        UPDATE item SET upgradecomponent_price_difference = (
                SELECT IFNULL(md.min_sale_unit_price,0)
                FROM marketdata md
                WHERE md.item_id = NEW.item_id
                ORDER BY md.created DESC LIMIT 1
        )
        -
        (
                SELECT IFNULL(md.max_offer_unit_price,0)
                FROM marketdata md
                WHERE md.item_id = @suffix_item_id
                ORDER BY md.created DESC LIMIT 1
        )
        WHERE item_id = NEW.item_id;
END IF;
UPDATE item SET last_max_offer = NEW.max_offer_unit_price, last_min_sale = NEW.min_sale_unit_price WHERE item_id = NEW.item_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `marketdataupdate`
--

DROP TABLE IF EXISTS `marketdataupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketdataupdate` (
  `marketdataupdate_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated_count` int(11) DEFAULT NULL,
  `created_count` int(11) DEFAULT NULL,
  `successful` bit(1) DEFAULT b'0',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`marketdataupdate_id`),
  KEY `updated_count` (`updated_count`,`created_count`),
  KEY `created` (`created`),
  KEY `successful` (`successful`)
) ENGINE=InnoDB AUTO_INCREMENT=3291 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `marketdataupdate_BINS` BEFORE INSERT ON marketdataupdate FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one
-- Full Trigger DDL Statements
-- Note: Only CREATE TRIGGER statements are allowed
SET NEW.created = UTC_TIMESTAMP */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rarity`
--

DROP TABLE IF EXISTS `rarity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rarity` (
  `rarity_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`rarity_id`),
  KEY `created` (`created`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe` (
  `recipe_id` int(11) NOT NULL,
  `min_rating` int(11) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `output_item_count` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `output_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `min_rating` (`min_rating`),
  KEY `updated` (`updated`),
  KEY `created` (`created`),
  KEY `output_item_count` (`output_item_count`),
  KEY `type` (`type`),
  KEY `FKC846558E7101D7BC` (`output_item_id`),
  CONSTRAINT `FKC846558E7101D7BC` FOREIGN KEY (`output_item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipeflag`
--

DROP TABLE IF EXISTS `recipeflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipeflag` (
  `recipeflag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`recipeflag_id`),
  KEY `created` (`created`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipeflag_recipe_jn`
--

DROP TABLE IF EXISTS `recipeflag_recipe_jn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipeflag_recipe_jn` (
  `recipe_id` int(11) DEFAULT NULL,
  `recipeflag_id` int(11) DEFAULT NULL,
  KEY `FKCFDBB190C28ACB1A` (`recipe_id`),
  KEY `FKCFDBB190132D47BA` (`recipeflag_id`),
  CONSTRAINT `FKCFDBB190132D47BA` FOREIGN KEY (`recipeflag_id`) REFERENCES `recipeflag` (`recipeflag_id`),
  CONSTRAINT `FKCFDBB190C28ACB1A` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipeingredient`
--

DROP TABLE IF EXISTS `recipeingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipeingredient` (
  `recipeingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `itemcount` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `recipe_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`recipeingredient_id`),
  KEY `itemcount` (`itemcount`),
  KEY `FK22ADADDFC28ACB1A` (`recipe_id`),
  KEY `FK22ADADDF7E45A8FA` (`item_id`),
  CONSTRAINT `FK22ADADDF7E45A8FA` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK22ADADDFC28ACB1A` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1795666 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipeupdate`
--

DROP TABLE IF EXISTS `recipeupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipeupdate` (
  `recipeupdate_id` int(11) NOT NULL AUTO_INCREMENT,
  `updated_count` int(11) DEFAULT NULL,
  `created_count` int(11) DEFAULT NULL,
  `successful` bit(1) DEFAULT b'0',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`recipeupdate_id`),
  KEY `updated_count` (`updated_count`,`created_count`),
  KEY `created` (`created`),
  KEY `successful` (`successful`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restriction`
--

DROP TABLE IF EXISTS `restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restriction` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`restriction_id`),
  KEY `created` (`created`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` varchar(255) NOT NULL,
  `email` varchar(250) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `updated` (`updated`),
  KEY `created` (`created`),
  KEY `email` (`email`),
  KEY `lastlogin` (`lastlogin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchlist` (
  `watchlist_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`watchlist_id`),
  KEY `FKEF5075ED7E45A8FA` (`item_id`),
  KEY `FKEF5075EDF7634DFA` (`user_id`),
  KEY `updated` (`updated`),
  KEY `created` (`created`),
  CONSTRAINT `FKEF5075ED7E45A8FA` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `FKEF5075EDF7634DFA` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `watchlist_BINS` BEFORE INSERT ON watchlist FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one
SET NEW.created = NOW(), NEW.updated = NOW() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'gw2rothchild'
--

--
-- Dumping routines for database 'gw2rothchild'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-23 21:48:51
