/*
Navicat MySQL Data Transfer

Source Server         : LOKALAN_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : belajar

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-09-22 16:20:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for belajar_biodata
-- ----------------------------
DROP TABLE IF EXISTS `belajar_biodata`;
CREATE TABLE `belajar_biodata` (
  `id_biodata` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT '' COMMENT 'pake textfield',
  `umur` varchar(12) DEFAULT '' COMMENT 'pake textfield',
  `jenis_kelamin` varchar(12) DEFAULT '' COMMENT 'pake combo box',
  `alamat` text DEFAULT NULL COMMENT 'text field max line 5',
  `hobi` text DEFAULT NULL COMMENT 'pake checkbox',
  `is_delete` int(11) DEFAULT 0,
  PRIMARY KEY (`id_biodata`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of belajar_biodata
-- ----------------------------
INSERT INTO `belajar_biodata` VALUES ('1', 'Miranda', '21', 'Perempuan', 'Manahan', 'Menyanyi, Jalan jalan', '0');
