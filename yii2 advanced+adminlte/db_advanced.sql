/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50625
Source Host           : localhost:3306
Source Database       : advanced

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2016-02-24 14:37:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `summary` text COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_assignment
-- ----------------------------

-- ----------------------------
-- Table structure for auth_item
-- ----------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_item
-- ----------------------------
INSERT INTO `auth_item` VALUES ('admin', '1', 'Administrator of this application', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('adminArticle', '2', 'Allows admin+ roles to manage articles', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('createArticle', '2', 'Allows editor+ roles to create articles', null, null, '1456298525', '1456298525');
INSERT INTO `auth_item` VALUES ('deleteArticle', '2', 'Allows admin+ roles to delete articles', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('editor', '1', 'Editor of this application', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('manageUsers', '2', 'Allows admin+ roles to manage users', null, null, '1456298525', '1456298525');
INSERT INTO `auth_item` VALUES ('member', '1', 'Registered users, members of this site', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('premium', '1', 'Premium members. They have more permissions than normal members', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('support', '1', 'Support staff', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('theCreator', '1', 'You!', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('updateArticle', '2', 'Allows editor+ roles to update articles', null, null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('updateOwnArticle', '2', 'Update own article', 'isAuthor', null, '1456298526', '1456298526');
INSERT INTO `auth_item` VALUES ('usePremiumContent', '2', 'Allows premium+ roles to use premium content', null, null, '1456298525', '1456298525');

-- ----------------------------
-- Table structure for auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_item_child
-- ----------------------------
INSERT INTO `auth_item_child` VALUES ('theCreator', 'admin');
INSERT INTO `auth_item_child` VALUES ('editor', 'adminArticle');
INSERT INTO `auth_item_child` VALUES ('editor', 'createArticle');
INSERT INTO `auth_item_child` VALUES ('admin', 'deleteArticle');
INSERT INTO `auth_item_child` VALUES ('admin', 'editor');
INSERT INTO `auth_item_child` VALUES ('admin', 'manageUsers');
INSERT INTO `auth_item_child` VALUES ('support', 'member');
INSERT INTO `auth_item_child` VALUES ('support', 'premium');
INSERT INTO `auth_item_child` VALUES ('editor', 'support');
INSERT INTO `auth_item_child` VALUES ('admin', 'updateArticle');
INSERT INTO `auth_item_child` VALUES ('updateOwnArticle', 'updateArticle');
INSERT INTO `auth_item_child` VALUES ('editor', 'updateOwnArticle');
INSERT INTO `auth_item_child` VALUES ('premium', 'usePremiumContent');

-- ----------------------------
-- Table structure for auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_rule
-- ----------------------------
INSERT INTO `auth_rule` VALUES ('isAuthor', 'O:28:\"common\\rbac\\rules\\AuthorRule\":3:{s:4:\"name\";s:8:\"isAuthor\";s:9:\"createdAt\";i:1456298525;s:9:\"updatedAt\";i:1456298525;}', '1456298525', '1456298525');

-- ----------------------------
-- Table structure for migration
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration
-- ----------------------------
INSERT INTO `migration` VALUES ('m000000_000000_base', '1456298512');
INSERT INTO `migration` VALUES ('m141022_115823_create_user_table', '1456298515');
INSERT INTO `migration` VALUES ('m141022_115912_create_rbac_tables', '1456298516');
INSERT INTO `migration` VALUES ('m141022_115922_create_session_table', '1456298517');
INSERT INTO `migration` VALUES ('m150104_153617_create_article_table', '1456298517');

-- ----------------------------
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `expire` int(11) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of session
-- ----------------------------
INSERT INTO `session` VALUES ('p4g95rb7iikshsnnv2hadvehr5', '1456300812', 0x5F5F666C6173687C613A303A7B7D5F5F636170746368612F736974652F636170746368617C733A363A22736967786468223B5F5F636170746368612F736974652F63617074636861636F756E747C693A313B);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_activation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
