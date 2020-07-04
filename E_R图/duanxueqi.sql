/*
Navicat MySQL Data Transfer

Source Server         : zxy
Source Server Version : 50514
Source Host           : localhost:3306
Source Database       : duanxueqi

Target Server Type    : MYSQL
Target Server Version : 50514
File Encoding         : 65001

Date: 2020-07-04 11:10:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for administratorinformationtable
-- ----------------------------
DROP TABLE IF EXISTS `administratorinformationtable`;
CREATE TABLE `administratorinformationtable` (
  `EmployeeNumber` int(11) NOT NULL,
  `EmployeeName` varchar(20) DEFAULT NULL,
  `LoginPassword` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`EmployeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of administratorinformationtable
-- ----------------------------

-- ----------------------------
-- Table structure for commodityinformation
-- ----------------------------
DROP TABLE IF EXISTS `commodityinformation`;
CREATE TABLE `commodityinformation` (
  `CommodityNumber` int(11) NOT NULL,
  `CategoryNumber` int(11) DEFAULT NULL,
  `CommodityName` varchar(20) DEFAULT NULL,
  `CommodityPrice` float(8,2) DEFAULT NULL,
  `MembershipPrice` float(8,2) DEFAULT NULL,
  `CommodityQuantity` int(11) DEFAULT NULL,
  `CommoditySpecification` varchar(20) DEFAULT NULL,
  `CommodityDetails` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CommodityNumber`),
  KEY `FK_leibieyushangpin` (`CategoryNumber`),
  CONSTRAINT `FK_leibieyushangpin` FOREIGN KEY (`CategoryNumber`) REFERENCES `freshcategoryinformation` (`CategoryNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodityinformation
-- ----------------------------

-- ----------------------------
-- Table structure for commodityorderform
-- ----------------------------
DROP TABLE IF EXISTS `commodityorderform`;
CREATE TABLE `commodityorderform` (
  `OrderNumber` int(11) NOT NULL,
  `UserNumber` int(11) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `OriginalAmount` float(8,2) DEFAULT NULL,
  `SettlementAmount` float(8,2) DEFAULT NULL,
  `RequiredDeliveryTime` datetime DEFAULT NULL,
  `OrderStatus` varchar(20) DEFAULT NULL,
  `EvaluationContent` varchar(100) DEFAULT NULL,
  `StarRating` int(11) DEFAULT NULL,
  `Photo` longblob,
  PRIMARY KEY (`OrderNumber`),
  KEY `FK_yonghuyudingdan` (`UserNumber`,`PhoneNumber`),
  CONSTRAINT `FK_yonghuyudingdan` FOREIGN KEY (`UserNumber`, `PhoneNumber`) REFERENCES `userinformationtable` (`UserNumber`, `PhoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodityorderform
-- ----------------------------

-- ----------------------------
-- Table structure for commoditypurchaselist
-- ----------------------------
DROP TABLE IF EXISTS `commoditypurchaselist`;
CREATE TABLE `commoditypurchaselist` (
  `PurchaseOrderNumber` int(11) NOT NULL,
  `EmployeeNumber` int(11) DEFAULT NULL,
  `CommodityNumber` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PurchaseOrderNumber`),
  KEY `FK_caigouyushangpin` (`CommodityNumber`),
  KEY `FK_guanliyuanyushangpin` (`EmployeeNumber`),
  CONSTRAINT `FK_guanliyuanyushangpin` FOREIGN KEY (`EmployeeNumber`) REFERENCES `administratorinformationtable` (`EmployeeNumber`),
  CONSTRAINT `FK_caigouyushangpin` FOREIGN KEY (`CommodityNumber`) REFERENCES `commodityinformation` (`CommodityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commoditypurchaselist
-- ----------------------------

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `CouponNumber` int(11) NOT NULL,
  `OrderNumber` int(11) DEFAULT NULL,
  `CouponContent` varchar(20) DEFAULT NULL,
  `ApplicableAmount` float(8,2) DEFAULT NULL,
  `DiscountAmount` float(8,2) DEFAULT NULL,
  `StartDate1` datetime DEFAULT NULL,
  `EndDate1` datetime DEFAULT NULL,
  PRIMARY KEY (`CouponNumber`),
  KEY `FK_dingdanyuyouhuiquan` (`OrderNumber`),
  CONSTRAINT `FK_dingdanyuyouhuiquan` FOREIGN KEY (`OrderNumber`) REFERENCES `commodityorderform` (`OrderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coupon
-- ----------------------------

-- ----------------------------
-- Table structure for deliveryaddresslist
-- ----------------------------
DROP TABLE IF EXISTS `deliveryaddresslist`;
CREATE TABLE `deliveryaddresslist` (
  `AddressNumber` int(11) NOT NULL,
  `UserNumber` int(11) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Province` varchar(20) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `District` varchar(20) DEFAULT NULL,
  `Address` varchar(20) DEFAULT NULL,
  `ContactPerson` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AddressNumber`),
  KEY `FK_yonghuyudizhi` (`UserNumber`,`PhoneNumber`),
  CONSTRAINT `FK_yonghuyudizhi` FOREIGN KEY (`UserNumber`, `PhoneNumber`) REFERENCES `userinformationtable` (`UserNumber`, `PhoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of deliveryaddresslist
-- ----------------------------

-- ----------------------------
-- Table structure for freshcategoryinformation
-- ----------------------------
DROP TABLE IF EXISTS `freshcategoryinformation`;
CREATE TABLE `freshcategoryinformation` (
  `CategoryNumber` int(11) NOT NULL,
  `CategoryName` varchar(20) DEFAULT NULL,
  `CategoryDescription` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CategoryNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of freshcategoryinformation
-- ----------------------------

-- ----------------------------
-- Table structure for fullfoldinformationsheet
-- ----------------------------
DROP TABLE IF EXISTS `fullfoldinformationsheet`;
CREATE TABLE `fullfoldinformationsheet` (
  `FullFoldNumber` int(11) NOT NULL,
  `FullFoldContent` varchar(20) DEFAULT NULL,
  `ApplicableQuantity` int(11) DEFAULT NULL,
  `Discount` float(8,2) DEFAULT NULL,
  PRIMARY KEY (`FullFoldNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fullfoldinformationsheet
-- ----------------------------

-- ----------------------------
-- Table structure for fullfolditemassociationtable
-- ----------------------------
DROP TABLE IF EXISTS `fullfolditemassociationtable`;
CREATE TABLE `fullfolditemassociationtable` (
  `CommodityNumber` int(11) NOT NULL,
  `FullFoldNumber` int(11) NOT NULL,
  `StartDate3` date DEFAULT NULL,
  `EndDate3` date DEFAULT NULL,
  PRIMARY KEY (`CommodityNumber`,`FullFoldNumber`),
  KEY `FK_FullFoldItemAssociationTable2` (`FullFoldNumber`),
  CONSTRAINT `FK_FullFoldItemAssociationTable2` FOREIGN KEY (`FullFoldNumber`) REFERENCES `fullfoldinformationsheet` (`FullFoldNumber`),
  CONSTRAINT `FK_FullFoldItemAssociationTable` FOREIGN KEY (`CommodityNumber`) REFERENCES `commodityinformation` (`CommodityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fullfolditemassociationtable
-- ----------------------------

-- ----------------------------
-- Table structure for limitedtimepromotioninformation
-- ----------------------------
DROP TABLE IF EXISTS `limitedtimepromotioninformation`;
CREATE TABLE `limitedtimepromotioninformation` (
  `PromotionNumber` int(11) NOT NULL,
  `CommodityNumber` int(11) DEFAULT NULL,
  `PromotionPrice` float(8,2) DEFAULT NULL,
  `PromotionQuantity` int(11) DEFAULT NULL,
  `StartDate4` datetime DEFAULT NULL,
  `EndDate4` datetime DEFAULT NULL,
  PRIMARY KEY (`PromotionNumber`),
  KEY `FK_shangpinyucuxiao` (`CommodityNumber`),
  CONSTRAINT `FK_shangpinyucuxiao` FOREIGN KEY (`CommodityNumber`) REFERENCES `commodityinformation` (`CommodityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of limitedtimepromotioninformation
-- ----------------------------

-- ----------------------------
-- Table structure for orderdetails
-- ----------------------------
DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails` (
  `CommodityNumber` int(11) NOT NULL,
  `OrderNumber` int(11) NOT NULL,
  `OrderQuantity` float(8,2) DEFAULT NULL,
  `OrderPrice` float(8,2) DEFAULT NULL,
  PRIMARY KEY (`CommodityNumber`,`OrderNumber`),
  KEY `FK_OrderDetails2` (`OrderNumber`),
  CONSTRAINT `FK_OrderDetails2` FOREIGN KEY (`OrderNumber`) REFERENCES `commodityorderform` (`OrderNumber`),
  CONSTRAINT `FK_OrderDetails` FOREIGN KEY (`CommodityNumber`) REFERENCES `commodityinformation` (`CommodityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderdetails
-- ----------------------------

-- ----------------------------
-- Table structure for productreciperecommendationform
-- ----------------------------
DROP TABLE IF EXISTS `productreciperecommendationform`;
CREATE TABLE `productreciperecommendationform` (
  `CommodityNumber` int(11) NOT NULL,
  `RecipeNumber` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CommodityNumber`,`RecipeNumber`),
  KEY `FK_ProductRecipeRecommendationForm2` (`RecipeNumber`),
  CONSTRAINT `FK_ProductRecipeRecommendationForm2` FOREIGN KEY (`RecipeNumber`) REFERENCES `recipeinformation` (`RecipeNumber`),
  CONSTRAINT `FK_ProductRecipeRecommendationForm` FOREIGN KEY (`CommodityNumber`) REFERENCES `commodityinformation` (`CommodityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of productreciperecommendationform
-- ----------------------------

-- ----------------------------
-- Table structure for recipeinformation
-- ----------------------------
DROP TABLE IF EXISTS `recipeinformation`;
CREATE TABLE `recipeinformation` (
  `RecipeNumber` int(11) NOT NULL,
  `RecipeName` varchar(20) DEFAULT NULL,
  `RecipeIngredients` varchar(100) DEFAULT NULL,
  `Steps` varchar(100) DEFAULT NULL,
  `Pictures` longblob,
  PRIMARY KEY (`RecipeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recipeinformation
-- ----------------------------

-- ----------------------------
-- Table structure for userinformationtable
-- ----------------------------
DROP TABLE IF EXISTS `userinformationtable`;
CREATE TABLE `userinformationtable` (
  `UserNumber` int(11) NOT NULL,
  `UserName` varchar(20) DEFAULT NULL,
  `UserSex` varchar(20) DEFAULT NULL,
  `UserPassword` varchar(20) DEFAULT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  `LiveCity` varchar(20) DEFAULT NULL,
  `RegistrationTime` datetime DEFAULT NULL,
  `Membership` tinyint(1) DEFAULT NULL,
  `MembershipDeadline` datetime DEFAULT NULL,
  PRIMARY KEY (`UserNumber`,`PhoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinformationtable
-- ----------------------------
