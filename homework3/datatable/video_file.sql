/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50151
Source Host           : localhost:3306
Source Database       : ylxdb

Target Server Type    : MYSQL
Target Server Version : 50151
File Encoding         : 65001

Date: 2016-03-26 23:42:43
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `video_file`
-- ----------------------------
DROP TABLE IF EXISTS `video_file`;
CREATE TABLE `video_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT '',
  `device_name` varchar(255) DEFAULT NULL,
  `check_tag` int(10) DEFAULT '0',
  `checker` varchar(255) DEFAULT NULL,
  `check_time` datetime DEFAULT NULL,
  `gar_tag` int(10) DEFAULT NULL,
  `register` varchar(255) DEFAULT NULL,
  `register_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video_file
-- ----------------------------
INSERT INTO `video_file` VALUES ('13', 'GPG0001', '警A55003', '0', null, null, null, null, '2016-03-20 00:00:00');
INSERT INTO `video_file` VALUES ('15', 'GPS0002', '警K9K188', '0', null, null, null, null, '2016-03-26 00:00:00');
