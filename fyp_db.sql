-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2015 at 07:17 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fyp_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE IF NOT EXISTS `brands` (
  `brand_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `name_zh` int(11) NOT NULL,
  `name_en` int(11) NOT NULL,
  `createddate` timestamp NOT NULL,
  `latmoddated` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `name_zh` varchar(200) DEFAULT NULL,
  `name_en` varchar(200) DEFAULT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `discount_prices`
--

CREATE TABLE IF NOT EXISTS `discount_prices` (
  `discount_price_id` int(10) NOT NULL AUTO_INCREMENT,
  `price` float NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `good_id` int(10) NOT NULL COMMENT 'FK_good',
  `shop_id` int(10) NOT NULL COMMENT 'FK_shop',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`discount_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE IF NOT EXISTS `goods` (
  `good_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `barcode` varchar(15) DEFAULT NULL,
  `name_zh` varchar(2000) DEFAULT NULL,
  `name_en` varchar(2000) DEFAULT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_link` varchar(2000) DEFAULT NULL,
  `brand_id` int(10) NOT NULL COMMENT 'FK_brands',
  PRIMARY KEY (`good_id`),
  UNIQUE KEY `brand_id` (`brand_id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `location_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `shop_id` int(10) NOT NULL COMMENT 'FK_shops',
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_id` (`location_id`),
  UNIQUE KEY `shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE IF NOT EXISTS `shops` (
  `shop_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `name_zh` varchar(200) DEFAULT NULL,
  `name_en` varchar(200) DEFAULT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`shop_id`),
  UNIQUE KEY `name_zh` (`name_zh`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `shop_goods`
--

CREATE TABLE IF NOT EXISTS `shop_goods` (
  `shop_goods_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `shop_id` int(10) NOT NULL COMMENT 'FK_shop',
  `good_id` int(10) NOT NULL COMMENT 'FK_good',
  `price` float DEFAULT NULL,
  `discount_price` float DEFAULT NULL,
  `discount_details` varchar(2000) DEFAULT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`shop_goods_id`),
  UNIQUE KEY `good_id` (`good_id`),
  UNIQUE KEY `shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `goods`
--
ALTER TABLE `goods`
  ADD CONSTRAINT `FK_goods_brands` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `FK_locations_shops` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `shop_goods`
--
ALTER TABLE `shop_goods`
  ADD CONSTRAINT `FK_shop_goods_goods` FOREIGN KEY (`good_id`) REFERENCES `goods` (`good_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_shop_goods_shops` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
