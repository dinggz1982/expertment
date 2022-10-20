/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : 127.0.0.1:3306
 Source Schema         : exam-test

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 20/05/2021 22:47:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course_outline
-- ----------------------------
DROP TABLE IF EXISTS `course_outline`;
CREATE TABLE `course_outline`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT ' 主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大纲名称',
  `parent_id` int(0) NULL DEFAULT 0 COMMENT '父id',
  `textbook_id` int(0) NULL DEFAULT NULL COMMENT '教材id',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_outline
-- ----------------------------
INSERT INTO `course_outline` VALUES (106, 'java程序设计', 0, 1, b'0');
INSERT INTO `course_outline` VALUES (107, '面向对象程序设计基础', 106, 1, b'0');
INSERT INTO `course_outline` VALUES (108, 'java web开发基础', 106, 1, b'0');
INSERT INTO `course_outline` VALUES (109, '智能教学系统设计理论基础', 0, 1, b'0');

-- ----------------------------
-- Table structure for course_textbook
-- ----------------------------
DROP TABLE IF EXISTS `course_textbook`;
CREATE TABLE `course_textbook`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `press` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `study_team` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `subject_id` int(0) NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_textbook
-- ----------------------------
INSERT INTO `course_textbook` VALUES (1, '教学系统开发', NULL, '机械工业', '大学一年级', '1', 5, b'0');

-- ----------------------------
-- Table structure for im_message
-- ----------------------------
DROP TABLE IF EXISTS `im_message`;
CREATE TABLE `im_message`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT ' 主键',
  `from_id` int(0) NULL DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `from_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `to_id` int(0) NULL DEFAULT NULL,
  `to_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `to_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `msg_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `send_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 156 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_message
-- ----------------------------
INSERT INTO `im_message` VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 09:28:43');
INSERT INTO `im_message` VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 09:31:32');
INSERT INTO `im_message` VALUES (3, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:06:13');
INSERT INTO `im_message` VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:08:35');
INSERT INTO `im_message` VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:10:49');
INSERT INTO `im_message` VALUES (6, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:11:25');
INSERT INTO `im_message` VALUES (7, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:14:30');
INSERT INTO `im_message` VALUES (8, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:18:16');
INSERT INTO `im_message` VALUES (9, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:19:45');
INSERT INTO `im_message` VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:22:26');
INSERT INTO `im_message` VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:25:12');
INSERT INTO `im_message` VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:27:46');
INSERT INTO `im_message` VALUES (13, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:37:05');
INSERT INTO `im_message` VALUES (14, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:38:13');
INSERT INTO `im_message` VALUES (15, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:38:16');
INSERT INTO `im_message` VALUES (16, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:38:20');
INSERT INTO `im_message` VALUES (17, NULL, NULL, NULL, NULL, NULL, NULL, 'chatMessage', NULL, NULL, '2021-05-08 15:38:22');
INSERT INTO `im_message` VALUES (18, 1, 'admin', '/images/head.png', 1, 'admin', '/images/head.png', NULL, 'chatMessage', '123123', '2021-05-08 16:01:57');
INSERT INTO `im_message` VALUES (19, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sadas', '2021-05-08 23:46:17');
INSERT INTO `im_message` VALUES (20, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'adsd', '2021-05-08 23:47:32');
INSERT INTO `im_message` VALUES (21, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '123', '2021-05-08 23:48:30');
INSERT INTO `im_message` VALUES (22, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asda', '2021-05-08 23:51:53');
INSERT INTO `im_message` VALUES (23, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdad', '2021-05-08 23:55:08');
INSERT INTO `im_message` VALUES (24, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'wqeqwe', '2021-05-08 23:55:33');
INSERT INTO `im_message` VALUES (25, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asda', '2021-05-08 23:56:01');
INSERT INTO `im_message` VALUES (26, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sadas', '2021-05-08 23:58:29');
INSERT INTO `im_message` VALUES (27, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '32423', '2021-05-09 00:01:21');
INSERT INTO `im_message` VALUES (28, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sadas', '2021-05-09 00:02:51');
INSERT INTO `im_message` VALUES (29, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdas', '2021-05-09 00:05:41');
INSERT INTO `im_message` VALUES (30, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdasd', '2021-05-09 00:06:03');
INSERT INTO `im_message` VALUES (31, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '23123', '2021-05-09 00:07:29');
INSERT INTO `im_message` VALUES (32, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '12312', '2021-05-09 00:08:25');
INSERT INTO `im_message` VALUES (33, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '312', '2021-05-09 00:09:29');
INSERT INTO `im_message` VALUES (34, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'adad', '2021-05-09 00:09:54');
INSERT INTO `im_message` VALUES (35, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdasd', '2021-05-09 00:10:05');
INSERT INTO `im_message` VALUES (36, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '213231', '2021-05-09 00:10:19');
INSERT INTO `im_message` VALUES (37, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '21313', '2021-05-09 00:14:00');
INSERT INTO `im_message` VALUES (38, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'assd', '2021-05-09 00:14:17');
INSERT INTO `im_message` VALUES (39, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdasd', '2021-05-09 00:15:48');
INSERT INTO `im_message` VALUES (40, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdsad', '2021-05-09 00:20:03');
INSERT INTO `im_message` VALUES (41, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sadas', '2021-05-09 00:20:44');
INSERT INTO `im_message` VALUES (42, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'qwe', '2021-05-09 00:23:41');
INSERT INTO `im_message` VALUES (43, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '12312', '2021-05-09 00:31:15');
INSERT INTO `im_message` VALUES (44, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '啊实打实', '2021-05-09 00:32:41');
INSERT INTO `im_message` VALUES (45, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '3232', '2021-05-09 00:38:03');
INSERT INTO `im_message` VALUES (46, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿三大苏打', '2021-05-09 00:39:04');
INSERT INTO `im_message` VALUES (47, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '12312', '2021-05-09 11:36:11');
INSERT INTO `im_message` VALUES (48, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '231是', '2021-05-09 11:38:49');
INSERT INTO `im_message` VALUES (49, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 11:39:19');
INSERT INTO `im_message` VALUES (50, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 11:39:41');
INSERT INTO `im_message` VALUES (51, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大 ', '2021-05-09 11:40:17');
INSERT INTO `im_message` VALUES (52, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'as ', '2021-05-09 12:14:51');
INSERT INTO `im_message` VALUES (53, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdd', '2021-05-09 12:15:58');
INSERT INTO `im_message` VALUES (54, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asda', '2021-05-09 12:16:45');
INSERT INTO `im_message` VALUES (55, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdad', '2021-05-09 12:16:57');
INSERT INTO `im_message` VALUES (56, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdasd', '2021-05-09 12:17:06');
INSERT INTO `im_message` VALUES (57, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sadas', '2021-05-09 12:17:48');
INSERT INTO `im_message` VALUES (58, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asd', '2021-05-09 12:18:17');
INSERT INTO `im_message` VALUES (59, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'adsasd', '2021-05-09 12:18:49');
INSERT INTO `im_message` VALUES (60, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asd', '2021-05-09 12:19:12');
INSERT INTO `im_message` VALUES (61, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdas', '2021-05-09 12:20:06');
INSERT INTO `im_message` VALUES (62, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asda', '2021-05-09 12:21:17');
INSERT INTO `im_message` VALUES (63, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asdas', '2021-05-09 12:23:31');
INSERT INTO `im_message` VALUES (64, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '撒旦撒', '2021-05-09 12:25:21');
INSERT INTO `im_message` VALUES (65, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '撒大大 ', '2021-05-09 12:25:49');
INSERT INTO `im_message` VALUES (66, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿三大苏打', '2021-05-09 12:27:35');
INSERT INTO `im_message` VALUES (67, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 12:28:21');
INSERT INTO `im_message` VALUES (68, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 12:29:21');
INSERT INTO `im_message` VALUES (69, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '啊实打实', '2021-05-09 12:29:39');
INSERT INTO `im_message` VALUES (70, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '请问企鹅', '2021-05-09 12:33:33');
INSERT INTO `im_message` VALUES (71, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '发士大夫', '2021-05-09 12:33:52');
INSERT INTO `im_message` VALUES (72, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 12:34:30');
INSERT INTO `im_message` VALUES (73, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'SaaS', '2021-05-09 12:35:38');
INSERT INTO `im_message` VALUES (74, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 12:36:08');
INSERT INTO `im_message` VALUES (75, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 12:36:39');
INSERT INTO `im_message` VALUES (76, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 12:36:54');
INSERT INTO `im_message` VALUES (77, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '的', '2021-05-09 12:37:19');
INSERT INTO `im_message` VALUES (78, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 12:50:33');
INSERT INTO `im_message` VALUES (79, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 12:50:41');
INSERT INTO `im_message` VALUES (80, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '多对多', '2021-05-09 12:50:59');
INSERT INTO `im_message` VALUES (81, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 12:51:26');
INSERT INTO `im_message` VALUES (82, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '啊实打实', '2021-05-09 12:52:13');
INSERT INTO `im_message` VALUES (83, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '飒飒', '2021-05-09 12:52:32');
INSERT INTO `im_message` VALUES (84, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达撒', '2021-05-09 12:53:08');
INSERT INTO `im_message` VALUES (85, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 12:54:48');
INSERT INTO `im_message` VALUES (86, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 13:03:47');
INSERT INTO `im_message` VALUES (87, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 13:04:01');
INSERT INTO `im_message` VALUES (88, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 13:05:40');
INSERT INTO `im_message` VALUES (89, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '洒出', '2021-05-09 13:19:25');
INSERT INTO `im_message` VALUES (90, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '奥数', '2021-05-09 13:19:33');
INSERT INTO `im_message` VALUES (91, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '撒', '2021-05-09 13:19:40');
INSERT INTO `im_message` VALUES (92, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sad', '2021-05-09 13:21:19');
INSERT INTO `im_message` VALUES (93, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'adas', '2021-05-09 13:21:43');
INSERT INTO `im_message` VALUES (94, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'asd ', '2021-05-09 13:21:58');
INSERT INTO `im_message` VALUES (95, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'adaasd', '2021-05-09 13:22:35');
INSERT INTO `im_message` VALUES (96, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sdas', '2021-05-09 13:23:19');
INSERT INTO `im_message` VALUES (97, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'sadas', '2021-05-09 17:37:19');
INSERT INTO `im_message` VALUES (98, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '王琦', '2021-05-09 17:41:56');
INSERT INTO `im_message` VALUES (99, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:43:04');
INSERT INTO `im_message` VALUES (100, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:46:37');
INSERT INTO `im_message` VALUES (101, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:46:51');
INSERT INTO `im_message` VALUES (102, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:47:15');
INSERT INTO `im_message` VALUES (103, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大 ', '2021-05-09 17:47:24');
INSERT INTO `im_message` VALUES (104, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 17:47:55');
INSERT INTO `im_message` VALUES (105, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 17:49:12');
INSERT INTO `im_message` VALUES (106, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:49:22');
INSERT INTO `im_message` VALUES (107, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:49:31');
INSERT INTO `im_message` VALUES (108, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 17:50:12');
INSERT INTO `im_message` VALUES (109, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'face[失望] ', '2021-05-09 17:51:15');
INSERT INTO `im_message` VALUES (110, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 17:51:30');
INSERT INTO `im_message` VALUES (111, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '第三方', '2021-05-09 17:51:58');
INSERT INTO `im_message` VALUES (112, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿达', '2021-05-09 19:07:19');
INSERT INTO `im_message` VALUES (113, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '王琦', '2021-05-09 19:08:11');
INSERT INTO `im_message` VALUES (114, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:13:46');
INSERT INTO `im_message` VALUES (115, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:13:59');
INSERT INTO `im_message` VALUES (116, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:14:14');
INSERT INTO `im_message` VALUES (117, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:14:18');
INSERT INTO `im_message` VALUES (118, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '飒飒的', '2021-05-09 19:14:50');
INSERT INTO `im_message` VALUES (119, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:15:13');
INSERT INTO `im_message` VALUES (120, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '啊阿斯顿', '2021-05-09 19:17:20');
INSERT INTO `im_message` VALUES (121, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'AS啊', '2021-05-09 19:17:53');
INSERT INTO `im_message` VALUES (122, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:18:28');
INSERT INTO `im_message` VALUES (123, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 19:21:03');
INSERT INTO `im_message` VALUES (124, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:22:22');
INSERT INTO `im_message` VALUES (125, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大 ', '2021-05-09 19:27:54');
INSERT INTO `im_message` VALUES (126, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿大撒', '2021-05-09 19:30:23');
INSERT INTO `im_message` VALUES (127, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大', '2021-05-09 19:49:37');
INSERT INTO `im_message` VALUES (128, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '萨达', '2021-05-09 19:50:05');
INSERT INTO `im_message` VALUES (129, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '阿松大 ', '2021-05-09 19:50:55');
INSERT INTO `im_message` VALUES (130, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '李白是个伟大的诗人', '2021-05-09 19:52:01');
INSERT INTO `im_message` VALUES (131, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '上课好困', '2021-05-09 19:56:54');
INSERT INTO `im_message` VALUES (132, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '这个老师不厚道啊', '2021-05-09 19:57:10');
INSERT INTO `im_message` VALUES (133, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '好好学习，天天向上', '2021-05-09 19:57:23');
INSERT INTO `im_message` VALUES (134, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师好', '2021-05-09 20:10:19');
INSERT INTO `im_message` VALUES (135, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '不想听课', '2021-05-09 20:10:31');
INSERT INTO `im_message` VALUES (136, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师好', '2021-05-09 20:32:09');
INSERT INTO `im_message` VALUES (137, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师我饿了', '2021-05-09 20:32:33');
INSERT INTO `im_message` VALUES (138, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师什么时候上课', '2021-05-09 20:34:14');
INSERT INTO `im_message` VALUES (139, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师我不想上课', '2021-05-09 20:35:39');
INSERT INTO `im_message` VALUES (140, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '可以听歌吗', '2021-05-09 20:35:48');
INSERT INTO `im_message` VALUES (141, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '小丁', '2021-05-09 20:36:35');
INSERT INTO `im_message` VALUES (142, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '小刘', '2021-05-09 20:37:03');
INSERT INTO `im_message` VALUES (143, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '我想上课', '2021-05-09 20:37:33');
INSERT INTO `im_message` VALUES (144, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师你开心吗', '2021-05-09 20:37:49');
INSERT INTO `im_message` VALUES (145, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '你叫什么', '2021-05-09 20:38:23');
INSERT INTO `im_message` VALUES (146, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '今天天气怎么样', '2021-05-09 20:40:35');
INSERT INTO `im_message` VALUES (147, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '广州', '2021-05-09 20:40:45');
INSERT INTO `im_message` VALUES (148, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '广州的天气', '2021-05-09 20:40:55');
INSERT INTO `im_message` VALUES (149, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '老师，您好', '2021-05-12 10:50:14');
INSERT INTO `im_message` VALUES (150, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '在线学习是指什么呢？', '2021-05-12 10:51:01');
INSERT INTO `im_message` VALUES (151, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '码农是什么？', '2021-05-12 10:51:19');
INSERT INTO `im_message` VALUES (152, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '请解释', '2021-05-12 10:52:13');
INSERT INTO `im_message` VALUES (153, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '中国传统文化包括哪些？', '2021-05-12 10:52:49');
INSERT INTO `im_message` VALUES (154, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', '课堂教学如何开展', '2021-05-12 10:53:04');
INSERT INTO `im_message` VALUES (155, 1, 'admin', '/images/head.png', 1000001, '课堂教师', '/images/teacher.png', 'friend', 'chatMessage', 'face[good] ', '2021-05-12 10:53:26');

-- ----------------------------
-- Table structure for its_menu
-- ----------------------------
DROP TABLE IF EXISTS `its_menu`;
CREATE TABLE `its_menu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单/按钮的名字',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_number` int(0) NULL DEFAULT NULL COMMENT '排序',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1:按钮，0表示菜单',
  `parent_id` int(0) NULL DEFAULT 0 COMMENT '父菜单的id',
  `deleted` tinyint(0) NULL DEFAULT 0 COMMENT '逻辑删除',
  `open` bit(1) NULL DEFAULT b'1' COMMENT '默认菜单打开',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE,
  INDEX `parent_id_idx`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of its_menu
-- ----------------------------
INSERT INTO `its_menu` VALUES (1, '系统管理', 'layui-icon layui-icon-set', 1, NULL, '2021-04-07 10:26:20', 0, 0, 0, b'1');
INSERT INTO `its_menu` VALUES (2, '用户管理', '', 2, '/system/user/index', '2021-04-07 10:30:07', 0, 1, 0, b'1');
INSERT INTO `its_menu` VALUES (3, '角色管理', NULL, 3, '/system/role/index', '2021-04-07 10:30:36', 0, 1, 0, b'1');
INSERT INTO `its_menu` VALUES (4, '菜单管理', NULL, 4, '/system/menu/index', '2021-04-07 10:30:59', 0, 1, 0, b'1');
INSERT INTO `its_menu` VALUES (5, '知识管理', NULL, 5, '', '2021-04-07 10:31:41', 0, 0, 0, b'1');
INSERT INTO `its_menu` VALUES (6, '知识树', '', 6, '/knowledge/knowledge/', '2021-04-07 10:32:15', 0, 5, 0, b'1');
INSERT INTO `its_menu` VALUES (7, '知识关系', '', 8, '/knowledge/relation', NULL, 0, 5, 0, b'1');
INSERT INTO `its_menu` VALUES (8, '课程管理', '', 9, '', NULL, 0, 0, 0, b'1');
INSERT INTO `its_menu` VALUES (9, '课元管理', '', 10, '/course/metaCourse', NULL, 0, 8, 0, b'1');
INSERT INTO `its_menu` VALUES (10, '教学机构管理', '', 2, '', NULL, 0, 0, 0, b'1');
INSERT INTO `its_menu` VALUES (11, '学校管理', '', 1, '/org/school', NULL, 0, 10, 0, b'1');
INSERT INTO `its_menu` VALUES (12, '学习小组管理', '', 9, '/org/team', NULL, 0, 10, 0, b'1');
INSERT INTO `its_menu` VALUES (15, '传感器管理', '', 6, '', NULL, 0, 0, 0, b'1');
INSERT INTO `its_menu` VALUES (16, '传感器类型管理', '', 1, '/sensor/type', NULL, 0, 15, 0, b'1');
INSERT INTO `its_menu` VALUES (17, '学校-传感器', '', 2, '/sensor/sensor', NULL, 0, 15, 0, b'1');
INSERT INTO `its_menu` VALUES (18, '跨学科知识', '', 6, '', NULL, 0, 0, 0, b'1');
INSERT INTO `its_menu` VALUES (19, '实践知识', '', 1, '/mix-ko', NULL, 0, 18, 0, b'1');
INSERT INTO `its_menu` VALUES (20, '学科管理', '', 1, '/knowledge/subject', NULL, 0, 5, 0, b'1');
INSERT INTO `its_menu` VALUES (21, '传感器远程控制', '', 3, '/sensor/sensor/control', NULL, 0, 15, 0, b'1');
INSERT INTO `its_menu` VALUES (22, '学院管理', '', 2, '/org/college', NULL, 0, 10, 0, b'1');
INSERT INTO `its_menu` VALUES (23, '专业管理', '', 3, '/org/major', NULL, 0, 10, 0, b'1');
INSERT INTO `its_menu` VALUES (24, '物理知识', '', 3, '', NULL, 0, 18, 0, b'1');
INSERT INTO `its_menu` VALUES (25, '生物知识', '', 4, '', NULL, 0, 18, 0, b'1');
INSERT INTO `its_menu` VALUES (26, '班级管理', '', 4, '/org/classInfo', NULL, 0, 10, 0, b'1');
INSERT INTO `its_menu` VALUES (27, '教材管理', '', 1, '/course/textbook', NULL, 0, 8, 0, b'1');

-- ----------------------------
-- Table structure for its_role
-- ----------------------------
DROP TABLE IF EXISTS `its_role`;
CREATE TABLE `its_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of its_role
-- ----------------------------
INSERT INTO `its_role` VALUES (1, '管理员', NULL, b'0');
INSERT INTO `its_role` VALUES (2, '教师', NULL, b'0');
INSERT INTO `its_role` VALUES (3, '学生', '学生', b'0');

-- ----------------------------
-- Table structure for its_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `its_role_menu`;
CREATE TABLE `its_role_menu`  (
  `role_id` int(0) NOT NULL,
  `menu_id` int(0) NOT NULL,
  `id` int(0) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_id_idx`(`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of its_role_menu
-- ----------------------------
INSERT INTO `its_role_menu` VALUES (2, 1, 18);
INSERT INTO `its_role_menu` VALUES (2, 2, 19);
INSERT INTO `its_role_menu` VALUES (2, 3, 20);
INSERT INTO `its_role_menu` VALUES (2, 4, 21);
INSERT INTO `its_role_menu` VALUES (2, 5, 22);
INSERT INTO `its_role_menu` VALUES (2, 6, 23);
INSERT INTO `its_role_menu` VALUES (1, 1, 124);
INSERT INTO `its_role_menu` VALUES (1, 2, 125);
INSERT INTO `its_role_menu` VALUES (1, 3, 126);
INSERT INTO `its_role_menu` VALUES (1, 4, 127);
INSERT INTO `its_role_menu` VALUES (1, 5, 128);
INSERT INTO `its_role_menu` VALUES (1, 6, 129);
INSERT INTO `its_role_menu` VALUES (1, 7, 130);
INSERT INTO `its_role_menu` VALUES (1, 20, 131);
INSERT INTO `its_role_menu` VALUES (1, 8, 132);
INSERT INTO `its_role_menu` VALUES (1, 9, 133);
INSERT INTO `its_role_menu` VALUES (1, 27, 134);
INSERT INTO `its_role_menu` VALUES (1, 10, 135);
INSERT INTO `its_role_menu` VALUES (1, 11, 136);
INSERT INTO `its_role_menu` VALUES (1, 12, 137);
INSERT INTO `its_role_menu` VALUES (1, 22, 138);
INSERT INTO `its_role_menu` VALUES (1, 23, 139);
INSERT INTO `its_role_menu` VALUES (1, 26, 140);
INSERT INTO `its_role_menu` VALUES (1, 15, 141);
INSERT INTO `its_role_menu` VALUES (1, 16, 142);
INSERT INTO `its_role_menu` VALUES (1, 17, 143);
INSERT INTO `its_role_menu` VALUES (1, 21, 144);
INSERT INTO `its_role_menu` VALUES (1, 18, 145);
INSERT INTO `its_role_menu` VALUES (1, 19, 146);

-- ----------------------------
-- Table structure for its_user
-- ----------------------------
DROP TABLE IF EXISTS `its_user`;
CREATE TABLE `its_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3010 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of its_user
-- ----------------------------
INSERT INTO `its_user` VALUES (1, 'admin', '$2a$04$580D2v2b6JQHxVzOFQrlGuyFBNnMZeAQYNTaJT6PaIZIhKG1jd4RO', '管理员', '男', 0, 0);
INSERT INTO `its_user` VALUES (2, 'teacher', '$2a$04$U1zBO1oFxcEvg3jCov2cj.6Php8druyoYJMvXQ7aUSNFn2jUk68.a', '教师测试账号', '男', 0, NULL);
INSERT INTO `its_user` VALUES (3, 'student1', '$2a$04$5jX8tEu8UejoVeQ8PiCjSuq2h3JWnKN7Rz8zsFA.hQ0IkrtmwRKfC', '测试学生1', '男', 0, NULL);
INSERT INTO `its_user` VALUES (4, '小花', '$2a$04$0xVxt9jMgWat7JIDmCcJl.3I70xV9P4NKAKN9AbM/CvsjGRv5NLJe', '教师测试账号', '女', 0, NULL);
INSERT INTO `its_user` VALUES (6, 'test', '$2a$04$P1pGtj4vJ/9rsqujQzr8BOQN8a4Bo6VbxdAiT7Va.gIAPO89a/kFS', 'test', '男', 0, NULL);
INSERT INTO `its_user` VALUES (7, 'test2', '$2a$04$Z/Jtyo/tSz7gLKse7KY9O.SA4FuIz35QISqPzw499swHjwgFU0ege', '测试账号2', '男', 0, NULL);
INSERT INTO `its_user` VALUES (8, 'test3', '$2a$04$x6/lyW9ztbEeqzbq.6qGWOTa96K3jskQX6wX44dAABbSRwLqRfGU2', 'test3', '男', 1, NULL);
INSERT INTO `its_user` VALUES (9, '张三1', '1234', '张三1', '男', 0, NULL);
INSERT INTO `its_user` VALUES (10, '张三2', '1234', '张三2', '男', 0, NULL);
INSERT INTO `its_user` VALUES (11, '张三3', '1234', '张三3', '男', 0, NULL);
INSERT INTO `its_user` VALUES (12, '张三4', '1234', '张三4', '男', 0, NULL);
INSERT INTO `its_user` VALUES (13, '张三5', '1234', '张三5', '男', 0, NULL);
INSERT INTO `its_user` VALUES (14, '张三6', '1234', '张三6', '男', 0, NULL);
INSERT INTO `its_user` VALUES (15, '张三7', '1234', '张三7', '男', 0, NULL);
INSERT INTO `its_user` VALUES (16, '张三8', '1234', '张三8', '男', 0, NULL);
INSERT INTO `its_user` VALUES (17, '张三9', '1234', '张三9', '男', 0, NULL);
INSERT INTO `its_user` VALUES (18, '张三10', '1234', '张三10', '男', 0, NULL);
INSERT INTO `its_user` VALUES (19, '张三11', '1234', '张三11', '男', 0, NULL);
INSERT INTO `its_user` VALUES (20, '张三12', '1234', '张三12', '男', 0, NULL);
INSERT INTO `its_user` VALUES (21, '张三13', '1234', '张三13', '男', 0, NULL);
INSERT INTO `its_user` VALUES (22, '张三14', '1234', '张三14', '男', 0, NULL);
INSERT INTO `its_user` VALUES (23, '张三15', '1234', '张三15', '男', 0, NULL);
INSERT INTO `its_user` VALUES (24, '张三16', '1234', '张三16', '男', 0, NULL);
INSERT INTO `its_user` VALUES (25, '张三17', '1234', '张三17', '男', 0, NULL);
INSERT INTO `its_user` VALUES (26, '张三18', '1234', '张三18', '男', 0, NULL);
INSERT INTO `its_user` VALUES (27, '张三19', '1234', '张三19', '男', 0, NULL);
INSERT INTO `its_user` VALUES (28, '张三20', '1234', '张三20', '男', 0, NULL);
INSERT INTO `its_user` VALUES (29, '张三21', '1234', '张三21', '男', 0, NULL);
INSERT INTO `its_user` VALUES (30, '张三22', '1234', '张三22', '男', 0, NULL);
INSERT INTO `its_user` VALUES (31, '张三23', '1234', '张三23', '男', 0, NULL);
INSERT INTO `its_user` VALUES (32, '张三24', '1234', '张三24', '男', 0, NULL);
INSERT INTO `its_user` VALUES (33, '张三25', '1234', '张三25', '男', 0, NULL);
INSERT INTO `its_user` VALUES (34, '张三26', '1234', '张三26', '男', 0, NULL);
INSERT INTO `its_user` VALUES (35, '张三27', '1234', '张三27', '男', 0, NULL);
INSERT INTO `its_user` VALUES (36, '张三28', '1234', '张三28', '男', 0, NULL);
INSERT INTO `its_user` VALUES (37, '张三29', '1234', '张三29', '男', 0, NULL);
INSERT INTO `its_user` VALUES (38, '张三30', '1234', '张三30', '男', 0, NULL);
INSERT INTO `its_user` VALUES (39, '张三31', '1234', '张三31', '男', 0, NULL);
INSERT INTO `its_user` VALUES (40, '张三32', '1234', '张三32', '男', 0, NULL);
INSERT INTO `its_user` VALUES (41, '张三33', '1234', '张三33', '男', 0, NULL);
INSERT INTO `its_user` VALUES (42, '张三34', '1234', '张三34', '男', 0, NULL);
INSERT INTO `its_user` VALUES (43, '张三35', '1234', '张三35', '男', 0, NULL);
INSERT INTO `its_user` VALUES (44, '张三36', '1234', '张三36', '男', 0, NULL);
INSERT INTO `its_user` VALUES (45, '张三37', '1234', '张三37', '男', 0, NULL);
INSERT INTO `its_user` VALUES (46, '张三38', '1234', '张三38', '男', 0, NULL);
INSERT INTO `its_user` VALUES (47, '张三39', '1234', '张三39', '男', 0, NULL);
INSERT INTO `its_user` VALUES (48, '张三40', '1234', '张三40', '男', 0, NULL);
INSERT INTO `its_user` VALUES (49, '张三41', '1234', '张三41', '男', 0, NULL);
INSERT INTO `its_user` VALUES (50, '张三42', '1234', '张三42', '男', 0, NULL);
INSERT INTO `its_user` VALUES (51, '张三43', '1234', '张三43', '男', 0, NULL);
INSERT INTO `its_user` VALUES (52, '张三44', '1234', '张三44', '男', 0, NULL);
INSERT INTO `its_user` VALUES (53, '张三45', '1234', '张三45', '男', 0, NULL);
INSERT INTO `its_user` VALUES (54, '张三46', '1234', '张三46', '男', 0, NULL);
INSERT INTO `its_user` VALUES (55, '张三47', '1234', '张三47', '男', 0, NULL);
INSERT INTO `its_user` VALUES (56, '张三48', '1234', '张三48', '男', 0, NULL);
INSERT INTO `its_user` VALUES (57, '张三49', '1234', '张三49', '男', 0, NULL);
INSERT INTO `its_user` VALUES (58, '张三50', '1234', '张三50', '男', 0, NULL);
INSERT INTO `its_user` VALUES (59, '张三51', '1234', '张三51', '男', 0, NULL);
INSERT INTO `its_user` VALUES (60, '张三52', '1234', '张三52', '男', 0, NULL);
INSERT INTO `its_user` VALUES (61, '张三53', '1234', '张三53', '男', 0, NULL);
INSERT INTO `its_user` VALUES (62, '张三54', '1234', '张三54', '男', 0, NULL);
INSERT INTO `its_user` VALUES (63, '张三55', '1234', '张三55', '男', 0, NULL);
INSERT INTO `its_user` VALUES (64, '张三56', '1234', '张三56', '男', 0, NULL);
INSERT INTO `its_user` VALUES (65, '张三57', '1234', '张三57', '男', 0, NULL);
INSERT INTO `its_user` VALUES (66, '张三58', '1234', '张三58', '男', 0, NULL);
INSERT INTO `its_user` VALUES (67, '张三59', '1234', '张三59', '男', 0, NULL);
INSERT INTO `its_user` VALUES (68, '张三60', '1234', '张三60', '男', 0, NULL);
INSERT INTO `its_user` VALUES (69, '张三61', '1234', '张三61', '男', 0, NULL);
INSERT INTO `its_user` VALUES (70, '张三62', '1234', '张三62', '男', 0, NULL);
INSERT INTO `its_user` VALUES (71, '张三63', '1234', '张三63', '男', 0, NULL);
INSERT INTO `its_user` VALUES (72, '张三64', '1234', '张三64', '男', 0, NULL);
INSERT INTO `its_user` VALUES (73, '张三65', '1234', '张三65', '男', 0, NULL);
INSERT INTO `its_user` VALUES (74, '张三66', '1234', '张三66', '男', 0, NULL);
INSERT INTO `its_user` VALUES (75, '张三67', '1234', '张三67', '男', 0, NULL);
INSERT INTO `its_user` VALUES (76, '张三68', '1234', '张三68', '男', 0, NULL);
INSERT INTO `its_user` VALUES (77, '张三69', '1234', '张三69', '男', 0, NULL);
INSERT INTO `its_user` VALUES (78, '张三70', '1234', '张三70', '男', 0, NULL);
INSERT INTO `its_user` VALUES (79, '张三71', '1234', '张三71', '男', 0, NULL);
INSERT INTO `its_user` VALUES (80, '张三72', '1234', '张三72', '男', 0, NULL);
INSERT INTO `its_user` VALUES (81, '张三73', '1234', '张三73', '男', 0, NULL);
INSERT INTO `its_user` VALUES (82, '张三74', '1234', '张三74', '男', 0, NULL);
INSERT INTO `its_user` VALUES (83, '张三75', '1234', '张三75', '男', 0, NULL);
INSERT INTO `its_user` VALUES (84, '张三76', '1234', '张三76', '男', 0, NULL);
INSERT INTO `its_user` VALUES (85, '张三77', '1234', '张三77', '男', 0, NULL);
INSERT INTO `its_user` VALUES (86, '张三78', '1234', '张三78', '男', 0, NULL);
INSERT INTO `its_user` VALUES (87, '张三79', '1234', '张三79', '男', 0, NULL);
INSERT INTO `its_user` VALUES (88, '张三80', '1234', '张三80', '男', 0, NULL);
INSERT INTO `its_user` VALUES (89, '张三81', '1234', '张三81', '男', 0, NULL);
INSERT INTO `its_user` VALUES (90, '张三82', '1234', '张三82', '男', 0, NULL);
INSERT INTO `its_user` VALUES (91, '张三83', '1234', '张三83', '男', 0, NULL);
INSERT INTO `its_user` VALUES (92, '张三84', '1234', '张三84', '男', 0, NULL);
INSERT INTO `its_user` VALUES (93, '张三85', '1234', '张三85', '男', 0, NULL);
INSERT INTO `its_user` VALUES (94, '张三86', '1234', '张三86', '男', 0, NULL);
INSERT INTO `its_user` VALUES (95, '张三87', '1234', '张三87', '男', 0, NULL);
INSERT INTO `its_user` VALUES (96, '张三88', '1234', '张三88', '男', 0, NULL);
INSERT INTO `its_user` VALUES (97, '张三89', '1234', '张三89', '男', 0, NULL);
INSERT INTO `its_user` VALUES (98, '张三90', '1234', '张三90', '男', 0, NULL);
INSERT INTO `its_user` VALUES (99, '张三91', '1234', '张三91', '男', 0, NULL);
INSERT INTO `its_user` VALUES (100, '张三92', '1234', '张三92', '男', 0, NULL);
INSERT INTO `its_user` VALUES (101, '张三93', '1234', '张三93', '男', 0, NULL);
INSERT INTO `its_user` VALUES (102, '张三94', '1234', '张三94', '男', 0, NULL);
INSERT INTO `its_user` VALUES (103, '张三95', '1234', '张三95', '男', 0, NULL);
INSERT INTO `its_user` VALUES (104, '张三96', '1234', '张三96', '男', 0, NULL);
INSERT INTO `its_user` VALUES (105, '张三97', '1234', '张三97', '男', 0, NULL);
INSERT INTO `its_user` VALUES (106, '张三98', '1234', '张三98', '男', 0, NULL);
INSERT INTO `its_user` VALUES (107, '张三99', '1234', '张三99', '男', 0, NULL);
INSERT INTO `its_user` VALUES (108, '张三100', '1234', '张三100', '男', 0, NULL);
INSERT INTO `its_user` VALUES (109, '张三101', '1234', '张三101', '男', 0, NULL);
INSERT INTO `its_user` VALUES (110, '张三102', '1234', '张三102', '男', 0, NULL);
INSERT INTO `its_user` VALUES (111, '张三103', '1234', '张三103', '男', 0, NULL);
INSERT INTO `its_user` VALUES (112, '张三104', '1234', '张三104', '男', 0, NULL);
INSERT INTO `its_user` VALUES (113, '张三105', '1234', '张三105', '男', 0, NULL);
INSERT INTO `its_user` VALUES (114, '张三106', '1234', '张三106', '男', 0, NULL);
INSERT INTO `its_user` VALUES (115, '张三107', '1234', '张三107', '男', 0, NULL);
INSERT INTO `its_user` VALUES (116, '张三108', '1234', '张三108', '男', 0, NULL);
INSERT INTO `its_user` VALUES (117, '张三109', '1234', '张三109', '男', 0, NULL);
INSERT INTO `its_user` VALUES (118, '张三110', '1234', '张三110', '男', 0, NULL);
INSERT INTO `its_user` VALUES (119, '张三111', '1234', '张三111', '男', 0, NULL);
INSERT INTO `its_user` VALUES (120, '张三112', '1234', '张三112', '男', 0, NULL);
INSERT INTO `its_user` VALUES (121, '张三113', '1234', '张三113', '男', 0, NULL);
INSERT INTO `its_user` VALUES (122, '张三114', '1234', '张三114', '男', 0, NULL);
INSERT INTO `its_user` VALUES (123, '张三115', '1234', '张三115', '男', 0, NULL);
INSERT INTO `its_user` VALUES (124, '张三116', '1234', '张三116', '男', 0, NULL);
INSERT INTO `its_user` VALUES (125, '张三117', '1234', '张三117', '男', 0, NULL);
INSERT INTO `its_user` VALUES (126, '张三118', '1234', '张三118', '男', 0, NULL);
INSERT INTO `its_user` VALUES (127, '张三119', '1234', '张三119', '男', 0, NULL);
INSERT INTO `its_user` VALUES (128, '张三120', '1234', '张三120', '男', 0, NULL);
INSERT INTO `its_user` VALUES (129, '张三121', '1234', '张三121', '男', 0, NULL);
INSERT INTO `its_user` VALUES (130, '张三122', '1234', '张三122', '男', 0, NULL);
INSERT INTO `its_user` VALUES (131, '张三123', '1234', '张三123', '男', 0, NULL);
INSERT INTO `its_user` VALUES (132, '张三124', '1234', '张三124', '男', 0, NULL);
INSERT INTO `its_user` VALUES (133, '张三125', '1234', '张三125', '男', 0, NULL);
INSERT INTO `its_user` VALUES (134, '张三126', '1234', '张三126', '男', 0, NULL);
INSERT INTO `its_user` VALUES (135, '张三127', '1234', '张三127', '男', 0, NULL);
INSERT INTO `its_user` VALUES (136, '张三128', '1234', '张三128', '男', 0, NULL);
INSERT INTO `its_user` VALUES (137, '张三129', '1234', '张三129', '男', 0, NULL);
INSERT INTO `its_user` VALUES (138, '张三130', '1234', '张三130', '男', 0, NULL);
INSERT INTO `its_user` VALUES (139, '张三131', '1234', '张三131', '男', 0, NULL);
INSERT INTO `its_user` VALUES (140, '张三132', '1234', '张三132', '男', 0, NULL);
INSERT INTO `its_user` VALUES (141, '张三133', '1234', '张三133', '男', 0, NULL);
INSERT INTO `its_user` VALUES (142, '张三134', '1234', '张三134', '男', 0, NULL);
INSERT INTO `its_user` VALUES (143, '张三135', '1234', '张三135', '男', 0, NULL);
INSERT INTO `its_user` VALUES (144, '张三136', '1234', '张三136', '男', 0, NULL);
INSERT INTO `its_user` VALUES (145, '张三137', '1234', '张三137', '男', 0, NULL);
INSERT INTO `its_user` VALUES (146, '张三138', '1234', '张三138', '男', 0, NULL);
INSERT INTO `its_user` VALUES (147, '张三139', '1234', '张三139', '男', 0, NULL);
INSERT INTO `its_user` VALUES (148, '张三140', '1234', '张三140', '男', 0, NULL);
INSERT INTO `its_user` VALUES (149, '张三141', '1234', '张三141', '男', 0, NULL);
INSERT INTO `its_user` VALUES (150, '张三142', '1234', '张三142', '男', 0, NULL);
INSERT INTO `its_user` VALUES (151, '张三143', '1234', '张三143', '男', 0, NULL);
INSERT INTO `its_user` VALUES (152, '张三144', '1234', '张三144', '男', 0, NULL);
INSERT INTO `its_user` VALUES (153, '张三145', '1234', '张三145', '男', 0, NULL);
INSERT INTO `its_user` VALUES (154, '张三146', '1234', '张三146', '男', 0, NULL);
INSERT INTO `its_user` VALUES (155, '张三147', '1234', '张三147', '男', 0, NULL);
INSERT INTO `its_user` VALUES (156, '张三148', '1234', '张三148', '男', 0, NULL);
INSERT INTO `its_user` VALUES (157, '张三149', '1234', '张三149', '男', 0, NULL);
INSERT INTO `its_user` VALUES (158, '张三150', '1234', '张三150', '男', 0, NULL);
INSERT INTO `its_user` VALUES (159, '张三151', '1234', '张三151', '男', 0, NULL);
INSERT INTO `its_user` VALUES (160, '张三152', '1234', '张三152', '男', 0, NULL);
INSERT INTO `its_user` VALUES (161, '张三153', '1234', '张三153', '男', 0, NULL);
INSERT INTO `its_user` VALUES (162, '张三154', '1234', '张三154', '男', 0, NULL);
INSERT INTO `its_user` VALUES (163, '张三155', '1234', '张三155', '男', 0, NULL);
INSERT INTO `its_user` VALUES (164, '张三156', '1234', '张三156', '男', 0, NULL);
INSERT INTO `its_user` VALUES (165, '张三157', '1234', '张三157', '男', 0, NULL);
INSERT INTO `its_user` VALUES (166, '张三158', '1234', '张三158', '男', 0, NULL);
INSERT INTO `its_user` VALUES (167, '张三159', '1234', '张三159', '男', 0, NULL);
INSERT INTO `its_user` VALUES (168, '张三160', '1234', '张三160', '男', 0, NULL);
INSERT INTO `its_user` VALUES (169, '张三161', '1234', '张三161', '男', 0, NULL);
INSERT INTO `its_user` VALUES (170, '张三162', '1234', '张三162', '男', 0, NULL);
INSERT INTO `its_user` VALUES (171, '张三163', '1234', '张三163', '男', 0, NULL);
INSERT INTO `its_user` VALUES (172, '张三164', '1234', '张三164', '男', 0, NULL);
INSERT INTO `its_user` VALUES (173, '张三165', '1234', '张三165', '男', 0, NULL);
INSERT INTO `its_user` VALUES (174, '张三166', '1234', '张三166', '男', 0, NULL);
INSERT INTO `its_user` VALUES (175, '张三167', '1234', '张三167', '男', 0, NULL);
INSERT INTO `its_user` VALUES (176, '张三168', '1234', '张三168', '男', 0, NULL);
INSERT INTO `its_user` VALUES (177, '张三169', '1234', '张三169', '男', 0, NULL);
INSERT INTO `its_user` VALUES (178, '张三170', '1234', '张三170', '男', 0, NULL);
INSERT INTO `its_user` VALUES (179, '张三171', '1234', '张三171', '男', 0, NULL);
INSERT INTO `its_user` VALUES (180, '张三172', '1234', '张三172', '男', 0, NULL);
INSERT INTO `its_user` VALUES (181, '张三173', '1234', '张三173', '男', 0, NULL);
INSERT INTO `its_user` VALUES (182, '张三174', '1234', '张三174', '男', 0, NULL);
INSERT INTO `its_user` VALUES (183, '张三175', '1234', '张三175', '男', 0, NULL);
INSERT INTO `its_user` VALUES (184, '张三176', '1234', '张三176', '男', 0, NULL);
INSERT INTO `its_user` VALUES (185, '张三177', '1234', '张三177', '男', 0, NULL);
INSERT INTO `its_user` VALUES (186, '张三178', '1234', '张三178', '男', 0, NULL);
INSERT INTO `its_user` VALUES (187, '张三179', '1234', '张三179', '男', 0, NULL);
INSERT INTO `its_user` VALUES (188, '张三180', '1234', '张三180', '男', 0, NULL);
INSERT INTO `its_user` VALUES (189, '张三181', '1234', '张三181', '男', 0, NULL);
INSERT INTO `its_user` VALUES (190, '张三182', '1234', '张三182', '男', 0, NULL);
INSERT INTO `its_user` VALUES (191, '张三183', '1234', '张三183', '男', 0, NULL);
INSERT INTO `its_user` VALUES (192, '张三184', '1234', '张三184', '男', 0, NULL);
INSERT INTO `its_user` VALUES (193, '张三185', '1234', '张三185', '男', 0, NULL);
INSERT INTO `its_user` VALUES (194, '张三186', '1234', '张三186', '男', 0, NULL);
INSERT INTO `its_user` VALUES (195, '张三187', '1234', '张三187', '男', 0, NULL);
INSERT INTO `its_user` VALUES (196, '张三188', '1234', '张三188', '男', 0, NULL);
INSERT INTO `its_user` VALUES (197, '张三189', '1234', '张三189', '男', 0, NULL);
INSERT INTO `its_user` VALUES (198, '张三190', '1234', '张三190', '男', 0, NULL);
INSERT INTO `its_user` VALUES (199, '张三191', '1234', '张三191', '男', 0, NULL);
INSERT INTO `its_user` VALUES (200, '张三192', '1234', '张三192', '男', 0, NULL);
INSERT INTO `its_user` VALUES (201, '张三193', '1234', '张三193', '男', 0, NULL);
INSERT INTO `its_user` VALUES (202, '张三194', '1234', '张三194', '男', 0, NULL);
INSERT INTO `its_user` VALUES (203, '张三195', '1234', '张三195', '男', 0, NULL);
INSERT INTO `its_user` VALUES (204, '张三196', '1234', '张三196', '男', 0, NULL);
INSERT INTO `its_user` VALUES (205, '张三197', '1234', '张三197', '男', 0, NULL);
INSERT INTO `its_user` VALUES (206, '张三198', '1234', '张三198', '男', 0, NULL);
INSERT INTO `its_user` VALUES (207, '张三199', '1234', '张三199', '男', 0, NULL);
INSERT INTO `its_user` VALUES (208, '张三200', '1234', '张三200', '男', 0, NULL);
INSERT INTO `its_user` VALUES (209, '张三201', '1234', '张三201', '男', 0, NULL);
INSERT INTO `its_user` VALUES (210, '张三202', '1234', '张三202', '男', 0, NULL);
INSERT INTO `its_user` VALUES (211, '张三203', '1234', '张三203', '男', 0, NULL);
INSERT INTO `its_user` VALUES (212, '张三204', '1234', '张三204', '男', 0, NULL);
INSERT INTO `its_user` VALUES (213, '张三205', '1234', '张三205', '男', 0, NULL);
INSERT INTO `its_user` VALUES (214, '张三206', '1234', '张三206', '男', 0, NULL);
INSERT INTO `its_user` VALUES (215, '张三207', '1234', '张三207', '男', 0, NULL);
INSERT INTO `its_user` VALUES (216, '张三208', '1234', '张三208', '男', 0, NULL);
INSERT INTO `its_user` VALUES (217, '张三209', '1234', '张三209', '男', 0, NULL);
INSERT INTO `its_user` VALUES (218, '张三210', '1234', '张三210', '男', 0, NULL);
INSERT INTO `its_user` VALUES (219, '张三211', '1234', '张三211', '男', 0, NULL);
INSERT INTO `its_user` VALUES (220, '张三212', '1234', '张三212', '男', 0, NULL);
INSERT INTO `its_user` VALUES (221, '张三213', '1234', '张三213', '男', 0, NULL);
INSERT INTO `its_user` VALUES (222, '张三214', '1234', '张三214', '男', 0, NULL);
INSERT INTO `its_user` VALUES (223, '张三215', '1234', '张三215', '男', 0, NULL);
INSERT INTO `its_user` VALUES (224, '张三216', '1234', '张三216', '男', 0, NULL);
INSERT INTO `its_user` VALUES (225, '张三217', '1234', '张三217', '男', 0, NULL);
INSERT INTO `its_user` VALUES (226, '张三218', '1234', '张三218', '男', 0, NULL);
INSERT INTO `its_user` VALUES (227, '张三219', '1234', '张三219', '男', 0, NULL);
INSERT INTO `its_user` VALUES (228, '张三220', '1234', '张三220', '男', 0, NULL);
INSERT INTO `its_user` VALUES (229, '张三221', '1234', '张三221', '男', 0, NULL);
INSERT INTO `its_user` VALUES (230, '张三222', '1234', '张三222', '男', 0, NULL);
INSERT INTO `its_user` VALUES (231, '张三223', '1234', '张三223', '男', 0, NULL);
INSERT INTO `its_user` VALUES (232, '张三224', '1234', '张三224', '男', 0, NULL);
INSERT INTO `its_user` VALUES (233, '张三225', '1234', '张三225', '男', 0, NULL);
INSERT INTO `its_user` VALUES (234, '张三226', '1234', '张三226', '男', 0, NULL);
INSERT INTO `its_user` VALUES (235, '张三227', '1234', '张三227', '男', 0, NULL);
INSERT INTO `its_user` VALUES (236, '张三228', '1234', '张三228', '男', 0, NULL);
INSERT INTO `its_user` VALUES (237, '张三229', '1234', '张三229', '男', 0, NULL);
INSERT INTO `its_user` VALUES (238, '张三230', '1234', '张三230', '男', 0, NULL);
INSERT INTO `its_user` VALUES (239, '张三231', '1234', '张三231', '男', 0, NULL);
INSERT INTO `its_user` VALUES (240, '张三232', '1234', '张三232', '男', 0, NULL);
INSERT INTO `its_user` VALUES (241, '张三233', '1234', '张三233', '男', 0, NULL);
INSERT INTO `its_user` VALUES (242, '张三234', '1234', '张三234', '男', 0, NULL);
INSERT INTO `its_user` VALUES (243, '张三235', '1234', '张三235', '男', 0, NULL);
INSERT INTO `its_user` VALUES (244, '张三236', '1234', '张三236', '男', 0, NULL);
INSERT INTO `its_user` VALUES (245, '张三237', '1234', '张三237', '男', 0, NULL);
INSERT INTO `its_user` VALUES (246, '张三238', '1234', '张三238', '男', 0, NULL);
INSERT INTO `its_user` VALUES (247, '张三239', '1234', '张三239', '男', 0, NULL);
INSERT INTO `its_user` VALUES (248, '张三240', '1234', '张三240', '男', 0, NULL);
INSERT INTO `its_user` VALUES (249, '张三241', '1234', '张三241', '男', 0, NULL);
INSERT INTO `its_user` VALUES (250, '张三242', '1234', '张三242', '男', 0, NULL);
INSERT INTO `its_user` VALUES (251, '张三243', '1234', '张三243', '男', 0, NULL);
INSERT INTO `its_user` VALUES (252, '张三244', '1234', '张三244', '男', 0, NULL);
INSERT INTO `its_user` VALUES (253, '张三245', '1234', '张三245', '男', 0, NULL);
INSERT INTO `its_user` VALUES (254, '张三246', '1234', '张三246', '男', 0, NULL);
INSERT INTO `its_user` VALUES (255, '张三247', '1234', '张三247', '男', 0, NULL);
INSERT INTO `its_user` VALUES (256, '张三248', '1234', '张三248', '男', 0, NULL);
INSERT INTO `its_user` VALUES (257, '张三249', '1234', '张三249', '男', 0, NULL);
INSERT INTO `its_user` VALUES (258, '张三250', '1234', '张三250', '男', 0, NULL);
INSERT INTO `its_user` VALUES (259, '张三251', '1234', '张三251', '男', 0, NULL);
INSERT INTO `its_user` VALUES (260, '张三252', '1234', '张三252', '男', 0, NULL);
INSERT INTO `its_user` VALUES (261, '张三253', '1234', '张三253', '男', 0, NULL);
INSERT INTO `its_user` VALUES (262, '张三254', '1234', '张三254', '男', 0, NULL);
INSERT INTO `its_user` VALUES (263, '张三255', '1234', '张三255', '男', 0, NULL);
INSERT INTO `its_user` VALUES (264, '张三256', '1234', '张三256', '男', 0, NULL);
INSERT INTO `its_user` VALUES (265, '张三257', '1234', '张三257', '男', 0, NULL);
INSERT INTO `its_user` VALUES (266, '张三258', '1234', '张三258', '男', 0, NULL);
INSERT INTO `its_user` VALUES (267, '张三259', '1234', '张三259', '男', 0, NULL);
INSERT INTO `its_user` VALUES (268, '张三260', '1234', '张三260', '男', 0, NULL);
INSERT INTO `its_user` VALUES (269, '张三261', '1234', '张三261', '男', 0, NULL);
INSERT INTO `its_user` VALUES (270, '张三262', '1234', '张三262', '男', 0, NULL);
INSERT INTO `its_user` VALUES (271, '张三263', '1234', '张三263', '男', 0, NULL);
INSERT INTO `its_user` VALUES (272, '张三264', '1234', '张三264', '男', 0, NULL);
INSERT INTO `its_user` VALUES (273, '张三265', '1234', '张三265', '男', 0, NULL);
INSERT INTO `its_user` VALUES (274, '张三266', '1234', '张三266', '男', 0, NULL);
INSERT INTO `its_user` VALUES (275, '张三267', '1234', '张三267', '男', 0, NULL);
INSERT INTO `its_user` VALUES (276, '张三268', '1234', '张三268', '男', 0, NULL);
INSERT INTO `its_user` VALUES (277, '张三269', '1234', '张三269', '男', 0, NULL);
INSERT INTO `its_user` VALUES (278, '张三270', '1234', '张三270', '男', 0, NULL);
INSERT INTO `its_user` VALUES (279, '张三271', '1234', '张三271', '男', 0, NULL);
INSERT INTO `its_user` VALUES (280, '张三272', '1234', '张三272', '男', 0, NULL);
INSERT INTO `its_user` VALUES (281, '张三273', '1234', '张三273', '男', 0, NULL);
INSERT INTO `its_user` VALUES (282, '张三274', '1234', '张三274', '男', 0, NULL);
INSERT INTO `its_user` VALUES (283, '张三275', '1234', '张三275', '男', 0, NULL);
INSERT INTO `its_user` VALUES (284, '张三276', '1234', '张三276', '男', 0, NULL);
INSERT INTO `its_user` VALUES (285, '张三277', '1234', '张三277', '男', 0, NULL);
INSERT INTO `its_user` VALUES (286, '张三278', '1234', '张三278', '男', 0, NULL);
INSERT INTO `its_user` VALUES (287, '张三279', '1234', '张三279', '男', 0, NULL);
INSERT INTO `its_user` VALUES (288, '张三280', '1234', '张三280', '男', 0, NULL);
INSERT INTO `its_user` VALUES (289, '张三281', '1234', '张三281', '男', 0, NULL);
INSERT INTO `its_user` VALUES (290, '张三282', '1234', '张三282', '男', 0, NULL);
INSERT INTO `its_user` VALUES (291, '张三283', '1234', '张三283', '男', 0, NULL);
INSERT INTO `its_user` VALUES (292, '张三284', '1234', '张三284', '男', 0, NULL);
INSERT INTO `its_user` VALUES (293, '张三285', '1234', '张三285', '男', 0, NULL);
INSERT INTO `its_user` VALUES (294, '张三286', '1234', '张三286', '男', 0, NULL);
INSERT INTO `its_user` VALUES (295, '张三287', '1234', '张三287', '男', 0, NULL);
INSERT INTO `its_user` VALUES (296, '张三288', '1234', '张三288', '男', 0, NULL);
INSERT INTO `its_user` VALUES (297, '张三289', '1234', '张三289', '男', 0, NULL);
INSERT INTO `its_user` VALUES (298, '张三290', '1234', '张三290', '男', 0, NULL);
INSERT INTO `its_user` VALUES (299, '张三291', '1234', '张三291', '男', 0, NULL);
INSERT INTO `its_user` VALUES (300, '张三292', '1234', '张三292', '男', 0, NULL);
INSERT INTO `its_user` VALUES (301, '张三293', '1234', '张三293', '男', 0, NULL);
INSERT INTO `its_user` VALUES (302, '张三294', '1234', '张三294', '男', 0, NULL);
INSERT INTO `its_user` VALUES (303, '张三295', '1234', '张三295', '男', 0, NULL);
INSERT INTO `its_user` VALUES (304, '张三296', '1234', '张三296', '男', 0, NULL);
INSERT INTO `its_user` VALUES (305, '张三297', '1234', '张三297', '男', 0, NULL);
INSERT INTO `its_user` VALUES (306, '张三298', '1234', '张三298', '男', 0, NULL);
INSERT INTO `its_user` VALUES (307, '张三299', '1234', '张三299', '男', 0, NULL);
INSERT INTO `its_user` VALUES (308, '张三300', '1234', '张三300', '男', 0, NULL);
INSERT INTO `its_user` VALUES (309, '张三301', '1234', '张三301', '男', 0, NULL);
INSERT INTO `its_user` VALUES (310, '张三302', '1234', '张三302', '男', 0, NULL);
INSERT INTO `its_user` VALUES (311, '张三303', '1234', '张三303', '男', 0, NULL);
INSERT INTO `its_user` VALUES (312, '张三304', '1234', '张三304', '男', 0, NULL);
INSERT INTO `its_user` VALUES (313, '张三305', '1234', '张三305', '男', 0, NULL);
INSERT INTO `its_user` VALUES (314, '张三306', '1234', '张三306', '男', 0, NULL);
INSERT INTO `its_user` VALUES (315, '张三307', '1234', '张三307', '男', 0, NULL);
INSERT INTO `its_user` VALUES (316, '张三308', '1234', '张三308', '男', 0, NULL);
INSERT INTO `its_user` VALUES (317, '张三309', '1234', '张三309', '男', 0, NULL);
INSERT INTO `its_user` VALUES (318, '张三310', '1234', '张三310', '男', 0, NULL);
INSERT INTO `its_user` VALUES (319, '张三311', '1234', '张三311', '男', 0, NULL);
INSERT INTO `its_user` VALUES (320, '张三312', '1234', '张三312', '男', 0, NULL);
INSERT INTO `its_user` VALUES (321, '张三313', '1234', '张三313', '男', 0, NULL);
INSERT INTO `its_user` VALUES (322, '张三314', '1234', '张三314', '男', 0, NULL);
INSERT INTO `its_user` VALUES (323, '张三315', '1234', '张三315', '男', 0, NULL);
INSERT INTO `its_user` VALUES (324, '张三316', '1234', '张三316', '男', 0, NULL);
INSERT INTO `its_user` VALUES (325, '张三317', '1234', '张三317', '男', 0, NULL);
INSERT INTO `its_user` VALUES (326, '张三318', '1234', '张三318', '男', 0, NULL);
INSERT INTO `its_user` VALUES (327, '张三319', '1234', '张三319', '男', 0, NULL);
INSERT INTO `its_user` VALUES (328, '张三320', '1234', '张三320', '男', 0, NULL);
INSERT INTO `its_user` VALUES (329, '张三321', '1234', '张三321', '男', 0, NULL);
INSERT INTO `its_user` VALUES (330, '张三322', '1234', '张三322', '男', 0, NULL);
INSERT INTO `its_user` VALUES (331, '张三323', '1234', '张三323', '男', 0, NULL);
INSERT INTO `its_user` VALUES (332, '张三324', '1234', '张三324', '男', 0, NULL);
INSERT INTO `its_user` VALUES (333, '张三325', '1234', '张三325', '男', 0, NULL);
INSERT INTO `its_user` VALUES (334, '张三326', '1234', '张三326', '男', 0, NULL);
INSERT INTO `its_user` VALUES (335, '张三327', '1234', '张三327', '男', 0, NULL);
INSERT INTO `its_user` VALUES (336, '张三328', '1234', '张三328', '男', 0, NULL);
INSERT INTO `its_user` VALUES (337, '张三329', '1234', '张三329', '男', 0, NULL);
INSERT INTO `its_user` VALUES (338, '张三330', '1234', '张三330', '男', 0, NULL);
INSERT INTO `its_user` VALUES (339, '张三331', '1234', '张三331', '男', 0, NULL);
INSERT INTO `its_user` VALUES (340, '张三332', '1234', '张三332', '男', 0, NULL);
INSERT INTO `its_user` VALUES (341, '张三333', '1234', '张三333', '男', 0, NULL);
INSERT INTO `its_user` VALUES (342, '张三334', '1234', '张三334', '男', 0, NULL);
INSERT INTO `its_user` VALUES (343, '张三335', '1234', '张三335', '男', 0, NULL);
INSERT INTO `its_user` VALUES (344, '张三336', '1234', '张三336', '男', 0, NULL);
INSERT INTO `its_user` VALUES (345, '张三337', '1234', '张三337', '男', 0, NULL);
INSERT INTO `its_user` VALUES (346, '张三338', '1234', '张三338', '男', 0, NULL);
INSERT INTO `its_user` VALUES (347, '张三339', '1234', '张三339', '男', 0, NULL);
INSERT INTO `its_user` VALUES (348, '张三340', '1234', '张三340', '男', 0, NULL);
INSERT INTO `its_user` VALUES (349, '张三341', '1234', '张三341', '男', 0, NULL);
INSERT INTO `its_user` VALUES (350, '张三342', '1234', '张三342', '男', 0, NULL);
INSERT INTO `its_user` VALUES (351, '张三343', '1234', '张三343', '男', 0, NULL);
INSERT INTO `its_user` VALUES (352, '张三344', '1234', '张三344', '男', 0, NULL);
INSERT INTO `its_user` VALUES (353, '张三345', '1234', '张三345', '男', 0, NULL);
INSERT INTO `its_user` VALUES (354, '张三346', '1234', '张三346', '男', 0, NULL);
INSERT INTO `its_user` VALUES (355, '张三347', '1234', '张三347', '男', 0, NULL);
INSERT INTO `its_user` VALUES (356, '张三348', '1234', '张三348', '男', 0, NULL);
INSERT INTO `its_user` VALUES (357, '张三349', '1234', '张三349', '男', 0, NULL);
INSERT INTO `its_user` VALUES (358, '张三350', '1234', '张三350', '男', 0, NULL);
INSERT INTO `its_user` VALUES (359, '张三351', '1234', '张三351', '男', 0, NULL);
INSERT INTO `its_user` VALUES (360, '张三352', '1234', '张三352', '男', 0, NULL);
INSERT INTO `its_user` VALUES (361, '张三353', '1234', '张三353', '男', 0, NULL);
INSERT INTO `its_user` VALUES (362, '张三354', '1234', '张三354', '男', 0, NULL);
INSERT INTO `its_user` VALUES (363, '张三355', '1234', '张三355', '男', 0, NULL);
INSERT INTO `its_user` VALUES (364, '张三356', '1234', '张三356', '男', 0, NULL);
INSERT INTO `its_user` VALUES (365, '张三357', '1234', '张三357', '男', 0, NULL);
INSERT INTO `its_user` VALUES (366, '张三358', '1234', '张三358', '男', 0, NULL);
INSERT INTO `its_user` VALUES (367, '张三359', '1234', '张三359', '男', 0, NULL);
INSERT INTO `its_user` VALUES (368, '张三360', '1234', '张三360', '男', 0, NULL);
INSERT INTO `its_user` VALUES (369, '张三361', '1234', '张三361', '男', 0, NULL);
INSERT INTO `its_user` VALUES (370, '张三362', '1234', '张三362', '男', 0, NULL);
INSERT INTO `its_user` VALUES (371, '张三363', '1234', '张三363', '男', 0, NULL);
INSERT INTO `its_user` VALUES (372, '张三364', '1234', '张三364', '男', 0, NULL);
INSERT INTO `its_user` VALUES (373, '张三365', '1234', '张三365', '男', 0, NULL);
INSERT INTO `its_user` VALUES (374, '张三366', '1234', '张三366', '男', 0, NULL);
INSERT INTO `its_user` VALUES (375, '张三367', '1234', '张三367', '男', 0, NULL);
INSERT INTO `its_user` VALUES (376, '张三368', '1234', '张三368', '男', 0, NULL);
INSERT INTO `its_user` VALUES (377, '张三369', '1234', '张三369', '男', 0, NULL);
INSERT INTO `its_user` VALUES (378, '张三370', '1234', '张三370', '男', 0, NULL);
INSERT INTO `its_user` VALUES (379, '张三371', '1234', '张三371', '男', 0, NULL);
INSERT INTO `its_user` VALUES (380, '张三372', '1234', '张三372', '男', 0, NULL);
INSERT INTO `its_user` VALUES (381, '张三373', '1234', '张三373', '男', 0, NULL);
INSERT INTO `its_user` VALUES (382, '张三374', '1234', '张三374', '男', 0, NULL);
INSERT INTO `its_user` VALUES (383, '张三375', '1234', '张三375', '男', 0, NULL);
INSERT INTO `its_user` VALUES (384, '张三376', '1234', '张三376', '男', 0, NULL);
INSERT INTO `its_user` VALUES (385, '张三377', '1234', '张三377', '男', 0, NULL);
INSERT INTO `its_user` VALUES (386, '张三378', '1234', '张三378', '男', 0, NULL);
INSERT INTO `its_user` VALUES (387, '张三379', '1234', '张三379', '男', 0, NULL);
INSERT INTO `its_user` VALUES (388, '张三380', '1234', '张三380', '男', 0, NULL);
INSERT INTO `its_user` VALUES (389, '张三381', '1234', '张三381', '男', 0, NULL);
INSERT INTO `its_user` VALUES (390, '张三382', '1234', '张三382', '男', 0, NULL);
INSERT INTO `its_user` VALUES (391, '张三383', '1234', '张三383', '男', 0, NULL);
INSERT INTO `its_user` VALUES (392, '张三384', '1234', '张三384', '男', 0, NULL);
INSERT INTO `its_user` VALUES (393, '张三385', '1234', '张三385', '男', 0, NULL);
INSERT INTO `its_user` VALUES (394, '张三386', '1234', '张三386', '男', 0, NULL);
INSERT INTO `its_user` VALUES (395, '张三387', '1234', '张三387', '男', 0, NULL);
INSERT INTO `its_user` VALUES (396, '张三388', '1234', '张三388', '男', 0, NULL);
INSERT INTO `its_user` VALUES (397, '张三389', '1234', '张三389', '男', 0, NULL);
INSERT INTO `its_user` VALUES (398, '张三390', '1234', '张三390', '男', 0, NULL);
INSERT INTO `its_user` VALUES (399, '张三391', '1234', '张三391', '男', 0, NULL);
INSERT INTO `its_user` VALUES (400, '张三392', '1234', '张三392', '男', 0, NULL);
INSERT INTO `its_user` VALUES (401, '张三393', '1234', '张三393', '男', 0, NULL);
INSERT INTO `its_user` VALUES (402, '张三394', '1234', '张三394', '男', 0, NULL);
INSERT INTO `its_user` VALUES (403, '张三395', '1234', '张三395', '男', 0, NULL);
INSERT INTO `its_user` VALUES (404, '张三396', '1234', '张三396', '男', 0, NULL);
INSERT INTO `its_user` VALUES (405, '张三397', '1234', '张三397', '男', 0, NULL);
INSERT INTO `its_user` VALUES (406, '张三398', '1234', '张三398', '男', 0, NULL);
INSERT INTO `its_user` VALUES (407, '张三399', '1234', '张三399', '男', 0, NULL);
INSERT INTO `its_user` VALUES (408, '张三400', '1234', '张三400', '男', 0, NULL);
INSERT INTO `its_user` VALUES (409, '张三401', '1234', '张三401', '男', 0, NULL);
INSERT INTO `its_user` VALUES (410, '张三402', '1234', '张三402', '男', 0, NULL);
INSERT INTO `its_user` VALUES (411, '张三403', '1234', '张三403', '男', 0, NULL);
INSERT INTO `its_user` VALUES (412, '张三404', '1234', '张三404', '男', 0, NULL);
INSERT INTO `its_user` VALUES (413, '张三405', '1234', '张三405', '男', 0, NULL);
INSERT INTO `its_user` VALUES (414, '张三406', '1234', '张三406', '男', 0, NULL);
INSERT INTO `its_user` VALUES (415, '张三407', '1234', '张三407', '男', 0, NULL);
INSERT INTO `its_user` VALUES (416, '张三408', '1234', '张三408', '男', 0, NULL);
INSERT INTO `its_user` VALUES (417, '张三409', '1234', '张三409', '男', 0, NULL);
INSERT INTO `its_user` VALUES (418, '张三410', '1234', '张三410', '男', 0, NULL);
INSERT INTO `its_user` VALUES (419, '张三411', '1234', '张三411', '男', 0, NULL);
INSERT INTO `its_user` VALUES (420, '张三412', '1234', '张三412', '男', 0, NULL);
INSERT INTO `its_user` VALUES (421, '张三413', '1234', '张三413', '男', 0, NULL);
INSERT INTO `its_user` VALUES (422, '张三414', '1234', '张三414', '男', 0, NULL);
INSERT INTO `its_user` VALUES (423, '张三415', '1234', '张三415', '男', 0, NULL);
INSERT INTO `its_user` VALUES (424, '张三416', '1234', '张三416', '男', 0, NULL);
INSERT INTO `its_user` VALUES (425, '张三417', '1234', '张三417', '男', 0, NULL);
INSERT INTO `its_user` VALUES (426, '张三418', '1234', '张三418', '男', 0, NULL);
INSERT INTO `its_user` VALUES (427, '张三419', '1234', '张三419', '男', 0, NULL);
INSERT INTO `its_user` VALUES (428, '张三420', '1234', '张三420', '男', 0, NULL);
INSERT INTO `its_user` VALUES (429, '张三421', '1234', '张三421', '男', 0, NULL);
INSERT INTO `its_user` VALUES (430, '张三422', '1234', '张三422', '男', 0, NULL);
INSERT INTO `its_user` VALUES (431, '张三423', '1234', '张三423', '男', 0, NULL);
INSERT INTO `its_user` VALUES (432, '张三424', '1234', '张三424', '男', 0, NULL);
INSERT INTO `its_user` VALUES (433, '张三425', '1234', '张三425', '男', 0, NULL);
INSERT INTO `its_user` VALUES (434, '张三426', '1234', '张三426', '男', 0, NULL);
INSERT INTO `its_user` VALUES (435, '张三427', '1234', '张三427', '男', 0, NULL);
INSERT INTO `its_user` VALUES (436, '张三428', '1234', '张三428', '男', 0, NULL);
INSERT INTO `its_user` VALUES (437, '张三429', '1234', '张三429', '男', 0, NULL);
INSERT INTO `its_user` VALUES (438, '张三430', '1234', '张三430', '男', 0, NULL);
INSERT INTO `its_user` VALUES (439, '张三431', '1234', '张三431', '男', 0, NULL);
INSERT INTO `its_user` VALUES (440, '张三432', '1234', '张三432', '男', 0, NULL);
INSERT INTO `its_user` VALUES (441, '张三433', '1234', '张三433', '男', 0, NULL);
INSERT INTO `its_user` VALUES (442, '张三434', '1234', '张三434', '男', 0, NULL);
INSERT INTO `its_user` VALUES (443, '张三435', '1234', '张三435', '男', 0, NULL);
INSERT INTO `its_user` VALUES (444, '张三436', '1234', '张三436', '男', 0, NULL);
INSERT INTO `its_user` VALUES (445, '张三437', '1234', '张三437', '男', 0, NULL);
INSERT INTO `its_user` VALUES (446, '张三438', '1234', '张三438', '男', 0, NULL);
INSERT INTO `its_user` VALUES (447, '张三439', '1234', '张三439', '男', 0, NULL);
INSERT INTO `its_user` VALUES (448, '张三440', '1234', '张三440', '男', 0, NULL);
INSERT INTO `its_user` VALUES (449, '张三441', '1234', '张三441', '男', 0, NULL);
INSERT INTO `its_user` VALUES (450, '张三442', '1234', '张三442', '男', 0, NULL);
INSERT INTO `its_user` VALUES (451, '张三443', '1234', '张三443', '男', 0, NULL);
INSERT INTO `its_user` VALUES (452, '张三444', '1234', '张三444', '男', 0, NULL);
INSERT INTO `its_user` VALUES (453, '张三445', '1234', '张三445', '男', 0, NULL);
INSERT INTO `its_user` VALUES (454, '张三446', '1234', '张三446', '男', 0, NULL);
INSERT INTO `its_user` VALUES (455, '张三447', '1234', '张三447', '男', 0, NULL);
INSERT INTO `its_user` VALUES (456, '张三448', '1234', '张三448', '男', 0, NULL);
INSERT INTO `its_user` VALUES (457, '张三449', '1234', '张三449', '男', 0, NULL);
INSERT INTO `its_user` VALUES (458, '张三450', '1234', '张三450', '男', 0, NULL);
INSERT INTO `its_user` VALUES (459, '张三451', '1234', '张三451', '男', 0, NULL);
INSERT INTO `its_user` VALUES (460, '张三452', '1234', '张三452', '男', 0, NULL);
INSERT INTO `its_user` VALUES (461, '张三453', '1234', '张三453', '男', 0, NULL);
INSERT INTO `its_user` VALUES (462, '张三454', '1234', '张三454', '男', 0, NULL);
INSERT INTO `its_user` VALUES (463, '张三455', '1234', '张三455', '男', 0, NULL);
INSERT INTO `its_user` VALUES (464, '张三456', '1234', '张三456', '男', 0, NULL);
INSERT INTO `its_user` VALUES (465, '张三457', '1234', '张三457', '男', 0, NULL);
INSERT INTO `its_user` VALUES (466, '张三458', '1234', '张三458', '男', 0, NULL);
INSERT INTO `its_user` VALUES (467, '张三459', '1234', '张三459', '男', 0, NULL);
INSERT INTO `its_user` VALUES (468, '张三460', '1234', '张三460', '男', 0, NULL);
INSERT INTO `its_user` VALUES (469, '张三461', '1234', '张三461', '男', 0, NULL);
INSERT INTO `its_user` VALUES (470, '张三462', '1234', '张三462', '男', 0, NULL);
INSERT INTO `its_user` VALUES (471, '张三463', '1234', '张三463', '男', 0, NULL);
INSERT INTO `its_user` VALUES (472, '张三464', '1234', '张三464', '男', 0, NULL);
INSERT INTO `its_user` VALUES (473, '张三465', '1234', '张三465', '男', 0, NULL);
INSERT INTO `its_user` VALUES (474, '张三466', '1234', '张三466', '男', 0, NULL);
INSERT INTO `its_user` VALUES (475, '张三467', '1234', '张三467', '男', 0, NULL);
INSERT INTO `its_user` VALUES (476, '张三468', '1234', '张三468', '男', 0, NULL);
INSERT INTO `its_user` VALUES (477, '张三469', '1234', '张三469', '男', 0, NULL);
INSERT INTO `its_user` VALUES (478, '张三470', '1234', '张三470', '男', 0, NULL);
INSERT INTO `its_user` VALUES (479, '张三471', '1234', '张三471', '男', 0, NULL);
INSERT INTO `its_user` VALUES (480, '张三472', '1234', '张三472', '男', 0, NULL);
INSERT INTO `its_user` VALUES (481, '张三473', '1234', '张三473', '男', 0, NULL);
INSERT INTO `its_user` VALUES (482, '张三474', '1234', '张三474', '男', 0, NULL);
INSERT INTO `its_user` VALUES (483, '张三475', '1234', '张三475', '男', 0, NULL);
INSERT INTO `its_user` VALUES (484, '张三476', '1234', '张三476', '男', 0, NULL);
INSERT INTO `its_user` VALUES (485, '张三477', '1234', '张三477', '男', 0, NULL);
INSERT INTO `its_user` VALUES (486, '张三478', '1234', '张三478', '男', 0, NULL);
INSERT INTO `its_user` VALUES (487, '张三479', '1234', '张三479', '男', 0, NULL);
INSERT INTO `its_user` VALUES (488, '张三480', '1234', '张三480', '男', 0, NULL);
INSERT INTO `its_user` VALUES (489, '张三481', '1234', '张三481', '男', 0, NULL);
INSERT INTO `its_user` VALUES (490, '张三482', '1234', '张三482', '男', 0, NULL);
INSERT INTO `its_user` VALUES (491, '张三483', '1234', '张三483', '男', 0, NULL);
INSERT INTO `its_user` VALUES (492, '张三484', '1234', '张三484', '男', 0, NULL);
INSERT INTO `its_user` VALUES (493, '张三485', '1234', '张三485', '男', 0, NULL);
INSERT INTO `its_user` VALUES (494, '张三486', '1234', '张三486', '男', 0, NULL);
INSERT INTO `its_user` VALUES (495, '张三487', '1234', '张三487', '男', 0, NULL);
INSERT INTO `its_user` VALUES (496, '张三488', '1234', '张三488', '男', 0, NULL);
INSERT INTO `its_user` VALUES (497, '张三489', '1234', '张三489', '男', 0, NULL);
INSERT INTO `its_user` VALUES (498, '张三490', '1234', '张三490', '男', 0, NULL);
INSERT INTO `its_user` VALUES (499, '张三491', '1234', '张三491', '男', 0, NULL);
INSERT INTO `its_user` VALUES (500, '张三492', '1234', '张三492', '男', 0, NULL);
INSERT INTO `its_user` VALUES (501, '张三493', '1234', '张三493', '男', 0, NULL);
INSERT INTO `its_user` VALUES (502, '张三494', '1234', '张三494', '男', 0, NULL);
INSERT INTO `its_user` VALUES (503, '张三495', '1234', '张三495', '男', 0, NULL);
INSERT INTO `its_user` VALUES (504, '张三496', '1234', '张三496', '男', 0, NULL);
INSERT INTO `its_user` VALUES (505, '张三497', '1234', '张三497', '男', 0, NULL);
INSERT INTO `its_user` VALUES (506, '张三498', '1234', '张三498', '男', 0, NULL);
INSERT INTO `its_user` VALUES (507, '张三499', '1234', '张三499', '男', 0, NULL);
INSERT INTO `its_user` VALUES (508, '张三500', '1234', '张三500', '男', 0, NULL);
INSERT INTO `its_user` VALUES (509, '张三501', '1234', '张三501', '男', 0, NULL);
INSERT INTO `its_user` VALUES (510, '张三502', '1234', '张三502', '男', 0, NULL);
INSERT INTO `its_user` VALUES (511, '张三503', '1234', '张三503', '男', 0, NULL);
INSERT INTO `its_user` VALUES (512, '张三504', '1234', '张三504', '男', 0, NULL);
INSERT INTO `its_user` VALUES (513, '张三505', '1234', '张三505', '男', 0, NULL);
INSERT INTO `its_user` VALUES (514, '张三506', '1234', '张三506', '男', 0, NULL);
INSERT INTO `its_user` VALUES (515, '张三507', '1234', '张三507', '男', 0, NULL);
INSERT INTO `its_user` VALUES (516, '张三508', '1234', '张三508', '男', 0, NULL);
INSERT INTO `its_user` VALUES (517, '张三509', '1234', '张三509', '男', 0, NULL);
INSERT INTO `its_user` VALUES (518, '张三510', '1234', '张三510', '男', 0, NULL);
INSERT INTO `its_user` VALUES (519, '张三511', '1234', '张三511', '男', 0, NULL);
INSERT INTO `its_user` VALUES (520, '张三512', '1234', '张三512', '男', 0, NULL);
INSERT INTO `its_user` VALUES (521, '张三513', '1234', '张三513', '男', 0, NULL);
INSERT INTO `its_user` VALUES (522, '张三514', '1234', '张三514', '男', 0, NULL);
INSERT INTO `its_user` VALUES (523, '张三515', '1234', '张三515', '男', 0, NULL);
INSERT INTO `its_user` VALUES (524, '张三516', '1234', '张三516', '男', 0, NULL);
INSERT INTO `its_user` VALUES (525, '张三517', '1234', '张三517', '男', 0, NULL);
INSERT INTO `its_user` VALUES (526, '张三518', '1234', '张三518', '男', 0, NULL);
INSERT INTO `its_user` VALUES (527, '张三519', '1234', '张三519', '男', 0, NULL);
INSERT INTO `its_user` VALUES (528, '张三520', '1234', '张三520', '男', 0, NULL);
INSERT INTO `its_user` VALUES (529, '张三521', '1234', '张三521', '男', 0, NULL);
INSERT INTO `its_user` VALUES (530, '张三522', '1234', '张三522', '男', 0, NULL);
INSERT INTO `its_user` VALUES (531, '张三523', '1234', '张三523', '男', 0, NULL);
INSERT INTO `its_user` VALUES (532, '张三524', '1234', '张三524', '男', 0, NULL);
INSERT INTO `its_user` VALUES (533, '张三525', '1234', '张三525', '男', 0, NULL);
INSERT INTO `its_user` VALUES (534, '张三526', '1234', '张三526', '男', 0, NULL);
INSERT INTO `its_user` VALUES (535, '张三527', '1234', '张三527', '男', 0, NULL);
INSERT INTO `its_user` VALUES (536, '张三528', '1234', '张三528', '男', 0, NULL);
INSERT INTO `its_user` VALUES (537, '张三529', '1234', '张三529', '男', 0, NULL);
INSERT INTO `its_user` VALUES (538, '张三530', '1234', '张三530', '男', 0, NULL);
INSERT INTO `its_user` VALUES (539, '张三531', '1234', '张三531', '男', 0, NULL);
INSERT INTO `its_user` VALUES (540, '张三532', '1234', '张三532', '男', 0, NULL);
INSERT INTO `its_user` VALUES (541, '张三533', '1234', '张三533', '男', 0, NULL);
INSERT INTO `its_user` VALUES (542, '张三534', '1234', '张三534', '男', 0, NULL);
INSERT INTO `its_user` VALUES (543, '张三535', '1234', '张三535', '男', 0, NULL);
INSERT INTO `its_user` VALUES (544, '张三536', '1234', '张三536', '男', 0, NULL);
INSERT INTO `its_user` VALUES (545, '张三537', '1234', '张三537', '男', 0, NULL);
INSERT INTO `its_user` VALUES (546, '张三538', '1234', '张三538', '男', 0, NULL);
INSERT INTO `its_user` VALUES (547, '张三539', '1234', '张三539', '男', 0, NULL);
INSERT INTO `its_user` VALUES (548, '张三540', '1234', '张三540', '男', 0, NULL);
INSERT INTO `its_user` VALUES (549, '张三541', '1234', '张三541', '男', 0, NULL);
INSERT INTO `its_user` VALUES (550, '张三542', '1234', '张三542', '男', 0, NULL);
INSERT INTO `its_user` VALUES (551, '张三543', '1234', '张三543', '男', 0, NULL);
INSERT INTO `its_user` VALUES (552, '张三544', '1234', '张三544', '男', 0, NULL);
INSERT INTO `its_user` VALUES (553, '张三545', '1234', '张三545', '男', 0, NULL);
INSERT INTO `its_user` VALUES (554, '张三546', '1234', '张三546', '男', 0, NULL);
INSERT INTO `its_user` VALUES (555, '张三547', '1234', '张三547', '男', 0, NULL);
INSERT INTO `its_user` VALUES (556, '张三548', '1234', '张三548', '男', 0, NULL);
INSERT INTO `its_user` VALUES (557, '张三549', '1234', '张三549', '男', 0, NULL);
INSERT INTO `its_user` VALUES (558, '张三550', '1234', '张三550', '男', 0, NULL);
INSERT INTO `its_user` VALUES (559, '张三551', '1234', '张三551', '男', 0, NULL);
INSERT INTO `its_user` VALUES (560, '张三552', '1234', '张三552', '男', 0, NULL);
INSERT INTO `its_user` VALUES (561, '张三553', '1234', '张三553', '男', 0, NULL);
INSERT INTO `its_user` VALUES (562, '张三554', '1234', '张三554', '男', 0, NULL);
INSERT INTO `its_user` VALUES (563, '张三555', '1234', '张三555', '男', 0, NULL);
INSERT INTO `its_user` VALUES (564, '张三556', '1234', '张三556', '男', 0, NULL);
INSERT INTO `its_user` VALUES (565, '张三557', '1234', '张三557', '男', 0, NULL);
INSERT INTO `its_user` VALUES (566, '张三558', '1234', '张三558', '男', 0, NULL);
INSERT INTO `its_user` VALUES (567, '张三559', '1234', '张三559', '男', 0, NULL);
INSERT INTO `its_user` VALUES (568, '张三560', '1234', '张三560', '男', 0, NULL);
INSERT INTO `its_user` VALUES (569, '张三561', '1234', '张三561', '男', 0, NULL);
INSERT INTO `its_user` VALUES (570, '张三562', '1234', '张三562', '男', 0, NULL);
INSERT INTO `its_user` VALUES (571, '张三563', '1234', '张三563', '男', 0, NULL);
INSERT INTO `its_user` VALUES (572, '张三564', '1234', '张三564', '男', 0, NULL);
INSERT INTO `its_user` VALUES (573, '张三565', '1234', '张三565', '男', 0, NULL);
INSERT INTO `its_user` VALUES (574, '张三566', '1234', '张三566', '男', 0, NULL);
INSERT INTO `its_user` VALUES (575, '张三567', '1234', '张三567', '男', 0, NULL);
INSERT INTO `its_user` VALUES (576, '张三568', '1234', '张三568', '男', 0, NULL);
INSERT INTO `its_user` VALUES (577, '张三569', '1234', '张三569', '男', 0, NULL);
INSERT INTO `its_user` VALUES (578, '张三570', '1234', '张三570', '男', 0, NULL);
INSERT INTO `its_user` VALUES (579, '张三571', '1234', '张三571', '男', 0, NULL);
INSERT INTO `its_user` VALUES (580, '张三572', '1234', '张三572', '男', 0, NULL);
INSERT INTO `its_user` VALUES (581, '张三573', '1234', '张三573', '男', 0, NULL);
INSERT INTO `its_user` VALUES (582, '张三574', '1234', '张三574', '男', 0, NULL);
INSERT INTO `its_user` VALUES (583, '张三575', '1234', '张三575', '男', 0, NULL);
INSERT INTO `its_user` VALUES (584, '张三576', '1234', '张三576', '男', 0, NULL);
INSERT INTO `its_user` VALUES (585, '张三577', '1234', '张三577', '男', 0, NULL);
INSERT INTO `its_user` VALUES (586, '张三578', '1234', '张三578', '男', 0, NULL);
INSERT INTO `its_user` VALUES (587, '张三579', '1234', '张三579', '男', 0, NULL);
INSERT INTO `its_user` VALUES (588, '张三580', '1234', '张三580', '男', 0, NULL);
INSERT INTO `its_user` VALUES (589, '张三581', '1234', '张三581', '男', 0, NULL);
INSERT INTO `its_user` VALUES (590, '张三582', '1234', '张三582', '男', 0, NULL);
INSERT INTO `its_user` VALUES (591, '张三583', '1234', '张三583', '男', 0, NULL);
INSERT INTO `its_user` VALUES (592, '张三584', '1234', '张三584', '男', 0, NULL);
INSERT INTO `its_user` VALUES (593, '张三585', '1234', '张三585', '男', 0, NULL);
INSERT INTO `its_user` VALUES (594, '张三586', '1234', '张三586', '男', 0, NULL);
INSERT INTO `its_user` VALUES (595, '张三587', '1234', '张三587', '男', 0, NULL);
INSERT INTO `its_user` VALUES (596, '张三588', '1234', '张三588', '男', 0, NULL);
INSERT INTO `its_user` VALUES (597, '张三589', '1234', '张三589', '男', 0, NULL);
INSERT INTO `its_user` VALUES (598, '张三590', '1234', '张三590', '男', 0, NULL);
INSERT INTO `its_user` VALUES (599, '张三591', '1234', '张三591', '男', 0, NULL);
INSERT INTO `its_user` VALUES (600, '张三592', '1234', '张三592', '男', 0, NULL);
INSERT INTO `its_user` VALUES (601, '张三593', '1234', '张三593', '男', 0, NULL);
INSERT INTO `its_user` VALUES (602, '张三594', '1234', '张三594', '男', 0, NULL);
INSERT INTO `its_user` VALUES (603, '张三595', '1234', '张三595', '男', 0, NULL);
INSERT INTO `its_user` VALUES (604, '张三596', '1234', '张三596', '男', 0, NULL);
INSERT INTO `its_user` VALUES (605, '张三597', '1234', '张三597', '男', 0, NULL);
INSERT INTO `its_user` VALUES (606, '张三598', '1234', '张三598', '男', 0, NULL);
INSERT INTO `its_user` VALUES (607, '张三599', '1234', '张三599', '男', 0, NULL);
INSERT INTO `its_user` VALUES (608, '张三600', '1234', '张三600', '男', 0, NULL);
INSERT INTO `its_user` VALUES (609, '张三601', '1234', '张三601', '男', 0, NULL);
INSERT INTO `its_user` VALUES (610, '张三602', '1234', '张三602', '男', 0, NULL);
INSERT INTO `its_user` VALUES (611, '张三603', '1234', '张三603', '男', 0, NULL);
INSERT INTO `its_user` VALUES (612, '张三604', '1234', '张三604', '男', 0, NULL);
INSERT INTO `its_user` VALUES (613, '张三605', '1234', '张三605', '男', 0, NULL);
INSERT INTO `its_user` VALUES (614, '张三606', '1234', '张三606', '男', 0, NULL);
INSERT INTO `its_user` VALUES (615, '张三607', '1234', '张三607', '男', 0, NULL);
INSERT INTO `its_user` VALUES (616, '张三608', '1234', '张三608', '男', 0, NULL);
INSERT INTO `its_user` VALUES (617, '张三609', '1234', '张三609', '男', 0, NULL);
INSERT INTO `its_user` VALUES (618, '张三610', '1234', '张三610', '男', 0, NULL);
INSERT INTO `its_user` VALUES (619, '张三611', '1234', '张三611', '男', 0, NULL);
INSERT INTO `its_user` VALUES (620, '张三612', '1234', '张三612', '男', 0, NULL);
INSERT INTO `its_user` VALUES (621, '张三613', '1234', '张三613', '男', 0, NULL);
INSERT INTO `its_user` VALUES (622, '张三614', '1234', '张三614', '男', 0, NULL);
INSERT INTO `its_user` VALUES (623, '张三615', '1234', '张三615', '男', 0, NULL);
INSERT INTO `its_user` VALUES (624, '张三616', '1234', '张三616', '男', 0, NULL);
INSERT INTO `its_user` VALUES (625, '张三617', '1234', '张三617', '男', 0, NULL);
INSERT INTO `its_user` VALUES (626, '张三618', '1234', '张三618', '男', 0, NULL);
INSERT INTO `its_user` VALUES (627, '张三619', '1234', '张三619', '男', 0, NULL);
INSERT INTO `its_user` VALUES (628, '张三620', '1234', '张三620', '男', 0, NULL);
INSERT INTO `its_user` VALUES (629, '张三621', '1234', '张三621', '男', 0, NULL);
INSERT INTO `its_user` VALUES (630, '张三622', '1234', '张三622', '男', 0, NULL);
INSERT INTO `its_user` VALUES (631, '张三623', '1234', '张三623', '男', 0, NULL);
INSERT INTO `its_user` VALUES (632, '张三624', '1234', '张三624', '男', 0, NULL);
INSERT INTO `its_user` VALUES (633, '张三625', '1234', '张三625', '男', 0, NULL);
INSERT INTO `its_user` VALUES (634, '张三626', '1234', '张三626', '男', 0, NULL);
INSERT INTO `its_user` VALUES (635, '张三627', '1234', '张三627', '男', 0, NULL);
INSERT INTO `its_user` VALUES (636, '张三628', '1234', '张三628', '男', 0, NULL);
INSERT INTO `its_user` VALUES (637, '张三629', '1234', '张三629', '男', 0, NULL);
INSERT INTO `its_user` VALUES (638, '张三630', '1234', '张三630', '男', 0, NULL);
INSERT INTO `its_user` VALUES (639, '张三631', '1234', '张三631', '男', 0, NULL);
INSERT INTO `its_user` VALUES (640, '张三632', '1234', '张三632', '男', 0, NULL);
INSERT INTO `its_user` VALUES (641, '张三633', '1234', '张三633', '男', 0, NULL);
INSERT INTO `its_user` VALUES (642, '张三634', '1234', '张三634', '男', 0, NULL);
INSERT INTO `its_user` VALUES (643, '张三635', '1234', '张三635', '男', 0, NULL);
INSERT INTO `its_user` VALUES (644, '张三636', '1234', '张三636', '男', 0, NULL);
INSERT INTO `its_user` VALUES (645, '张三637', '1234', '张三637', '男', 0, NULL);
INSERT INTO `its_user` VALUES (646, '张三638', '1234', '张三638', '男', 0, NULL);
INSERT INTO `its_user` VALUES (647, '张三639', '1234', '张三639', '男', 0, NULL);
INSERT INTO `its_user` VALUES (648, '张三640', '1234', '张三640', '男', 0, NULL);
INSERT INTO `its_user` VALUES (649, '张三641', '1234', '张三641', '男', 0, NULL);
INSERT INTO `its_user` VALUES (650, '张三642', '1234', '张三642', '男', 0, NULL);
INSERT INTO `its_user` VALUES (651, '张三643', '1234', '张三643', '男', 0, NULL);
INSERT INTO `its_user` VALUES (652, '张三644', '1234', '张三644', '男', 0, NULL);
INSERT INTO `its_user` VALUES (653, '张三645', '1234', '张三645', '男', 0, NULL);
INSERT INTO `its_user` VALUES (654, '张三646', '1234', '张三646', '男', 0, NULL);
INSERT INTO `its_user` VALUES (655, '张三647', '1234', '张三647', '男', 0, NULL);
INSERT INTO `its_user` VALUES (656, '张三648', '1234', '张三648', '男', 0, NULL);
INSERT INTO `its_user` VALUES (657, '张三649', '1234', '张三649', '男', 0, NULL);
INSERT INTO `its_user` VALUES (658, '张三650', '1234', '张三650', '男', 0, NULL);
INSERT INTO `its_user` VALUES (659, '张三651', '1234', '张三651', '男', 0, NULL);
INSERT INTO `its_user` VALUES (660, '张三652', '1234', '张三652', '男', 0, NULL);
INSERT INTO `its_user` VALUES (661, '张三653', '1234', '张三653', '男', 0, NULL);
INSERT INTO `its_user` VALUES (662, '张三654', '1234', '张三654', '男', 0, NULL);
INSERT INTO `its_user` VALUES (663, '张三655', '1234', '张三655', '男', 0, NULL);
INSERT INTO `its_user` VALUES (664, '张三656', '1234', '张三656', '男', 0, NULL);
INSERT INTO `its_user` VALUES (665, '张三657', '1234', '张三657', '男', 0, NULL);
INSERT INTO `its_user` VALUES (666, '张三658', '1234', '张三658', '男', 0, NULL);
INSERT INTO `its_user` VALUES (667, '张三659', '1234', '张三659', '男', 0, NULL);
INSERT INTO `its_user` VALUES (668, '张三660', '1234', '张三660', '男', 0, NULL);
INSERT INTO `its_user` VALUES (669, '张三661', '1234', '张三661', '男', 0, NULL);
INSERT INTO `its_user` VALUES (670, '张三662', '1234', '张三662', '男', 0, NULL);
INSERT INTO `its_user` VALUES (671, '张三663', '1234', '张三663', '男', 0, NULL);
INSERT INTO `its_user` VALUES (672, '张三664', '1234', '张三664', '男', 0, NULL);
INSERT INTO `its_user` VALUES (673, '张三665', '1234', '张三665', '男', 0, NULL);
INSERT INTO `its_user` VALUES (674, '张三666', '1234', '张三666', '男', 0, NULL);
INSERT INTO `its_user` VALUES (675, '张三667', '1234', '张三667', '男', 0, NULL);
INSERT INTO `its_user` VALUES (676, '张三668', '1234', '张三668', '男', 0, NULL);
INSERT INTO `its_user` VALUES (677, '张三669', '1234', '张三669', '男', 0, NULL);
INSERT INTO `its_user` VALUES (678, '张三670', '1234', '张三670', '男', 0, NULL);
INSERT INTO `its_user` VALUES (679, '张三671', '1234', '张三671', '男', 0, NULL);
INSERT INTO `its_user` VALUES (680, '张三672', '1234', '张三672', '男', 0, NULL);
INSERT INTO `its_user` VALUES (681, '张三673', '1234', '张三673', '男', 0, NULL);
INSERT INTO `its_user` VALUES (682, '张三674', '1234', '张三674', '男', 0, NULL);
INSERT INTO `its_user` VALUES (683, '张三675', '1234', '张三675', '男', 0, NULL);
INSERT INTO `its_user` VALUES (684, '张三676', '1234', '张三676', '男', 0, NULL);
INSERT INTO `its_user` VALUES (685, '张三677', '1234', '张三677', '男', 0, NULL);
INSERT INTO `its_user` VALUES (686, '张三678', '1234', '张三678', '男', 0, NULL);
INSERT INTO `its_user` VALUES (687, '张三679', '1234', '张三679', '男', 0, NULL);
INSERT INTO `its_user` VALUES (688, '张三680', '1234', '张三680', '男', 0, NULL);
INSERT INTO `its_user` VALUES (689, '张三681', '1234', '张三681', '男', 0, NULL);
INSERT INTO `its_user` VALUES (690, '张三682', '1234', '张三682', '男', 0, NULL);
INSERT INTO `its_user` VALUES (691, '张三683', '1234', '张三683', '男', 0, NULL);
INSERT INTO `its_user` VALUES (692, '张三684', '1234', '张三684', '男', 0, NULL);
INSERT INTO `its_user` VALUES (693, '张三685', '1234', '张三685', '男', 0, NULL);
INSERT INTO `its_user` VALUES (694, '张三686', '1234', '张三686', '男', 0, NULL);
INSERT INTO `its_user` VALUES (695, '张三687', '1234', '张三687', '男', 0, NULL);
INSERT INTO `its_user` VALUES (696, '张三688', '1234', '张三688', '男', 0, NULL);
INSERT INTO `its_user` VALUES (697, '张三689', '1234', '张三689', '男', 0, NULL);
INSERT INTO `its_user` VALUES (698, '张三690', '1234', '张三690', '男', 0, NULL);
INSERT INTO `its_user` VALUES (699, '张三691', '1234', '张三691', '男', 0, NULL);
INSERT INTO `its_user` VALUES (700, '张三692', '1234', '张三692', '男', 0, NULL);
INSERT INTO `its_user` VALUES (701, '张三693', '1234', '张三693', '男', 0, NULL);
INSERT INTO `its_user` VALUES (702, '张三694', '1234', '张三694', '男', 0, NULL);
INSERT INTO `its_user` VALUES (703, '张三695', '1234', '张三695', '男', 0, NULL);
INSERT INTO `its_user` VALUES (704, '张三696', '1234', '张三696', '男', 0, NULL);
INSERT INTO `its_user` VALUES (705, '张三697', '1234', '张三697', '男', 0, NULL);
INSERT INTO `its_user` VALUES (706, '张三698', '1234', '张三698', '男', 0, NULL);
INSERT INTO `its_user` VALUES (707, '张三699', '1234', '张三699', '男', 0, NULL);
INSERT INTO `its_user` VALUES (708, '张三700', '1234', '张三700', '男', 0, NULL);
INSERT INTO `its_user` VALUES (709, '张三701', '1234', '张三701', '男', 0, NULL);
INSERT INTO `its_user` VALUES (710, '张三702', '1234', '张三702', '男', 0, NULL);
INSERT INTO `its_user` VALUES (711, '张三703', '1234', '张三703', '男', 0, NULL);
INSERT INTO `its_user` VALUES (712, '张三704', '1234', '张三704', '男', 0, NULL);
INSERT INTO `its_user` VALUES (713, '张三705', '1234', '张三705', '男', 0, NULL);
INSERT INTO `its_user` VALUES (714, '张三706', '1234', '张三706', '男', 0, NULL);
INSERT INTO `its_user` VALUES (715, '张三707', '1234', '张三707', '男', 0, NULL);
INSERT INTO `its_user` VALUES (716, '张三708', '1234', '张三708', '男', 0, NULL);
INSERT INTO `its_user` VALUES (717, '张三709', '1234', '张三709', '男', 0, NULL);
INSERT INTO `its_user` VALUES (718, '张三710', '1234', '张三710', '男', 0, NULL);
INSERT INTO `its_user` VALUES (719, '张三711', '1234', '张三711', '男', 0, NULL);
INSERT INTO `its_user` VALUES (720, '张三712', '1234', '张三712', '男', 0, NULL);
INSERT INTO `its_user` VALUES (721, '张三713', '1234', '张三713', '男', 0, NULL);
INSERT INTO `its_user` VALUES (722, '张三714', '1234', '张三714', '男', 0, NULL);
INSERT INTO `its_user` VALUES (723, '张三715', '1234', '张三715', '男', 0, NULL);
INSERT INTO `its_user` VALUES (724, '张三716', '1234', '张三716', '男', 0, NULL);
INSERT INTO `its_user` VALUES (725, '张三717', '1234', '张三717', '男', 0, NULL);
INSERT INTO `its_user` VALUES (726, '张三718', '1234', '张三718', '男', 0, NULL);
INSERT INTO `its_user` VALUES (727, '张三719', '1234', '张三719', '男', 0, NULL);
INSERT INTO `its_user` VALUES (728, '张三720', '1234', '张三720', '男', 0, NULL);
INSERT INTO `its_user` VALUES (729, '张三721', '1234', '张三721', '男', 0, NULL);
INSERT INTO `its_user` VALUES (730, '张三722', '1234', '张三722', '男', 0, NULL);
INSERT INTO `its_user` VALUES (731, '张三723', '1234', '张三723', '男', 0, NULL);
INSERT INTO `its_user` VALUES (732, '张三724', '1234', '张三724', '男', 0, NULL);
INSERT INTO `its_user` VALUES (733, '张三725', '1234', '张三725', '男', 0, NULL);
INSERT INTO `its_user` VALUES (734, '张三726', '1234', '张三726', '男', 0, NULL);
INSERT INTO `its_user` VALUES (735, '张三727', '1234', '张三727', '男', 0, NULL);
INSERT INTO `its_user` VALUES (736, '张三728', '1234', '张三728', '男', 0, NULL);
INSERT INTO `its_user` VALUES (737, '张三729', '1234', '张三729', '男', 0, NULL);
INSERT INTO `its_user` VALUES (738, '张三730', '1234', '张三730', '男', 0, NULL);
INSERT INTO `its_user` VALUES (739, '张三731', '1234', '张三731', '男', 0, NULL);
INSERT INTO `its_user` VALUES (740, '张三732', '1234', '张三732', '男', 0, NULL);
INSERT INTO `its_user` VALUES (741, '张三733', '1234', '张三733', '男', 0, NULL);
INSERT INTO `its_user` VALUES (742, '张三734', '1234', '张三734', '男', 0, NULL);
INSERT INTO `its_user` VALUES (743, '张三735', '1234', '张三735', '男', 0, NULL);
INSERT INTO `its_user` VALUES (744, '张三736', '1234', '张三736', '男', 0, NULL);
INSERT INTO `its_user` VALUES (745, '张三737', '1234', '张三737', '男', 0, NULL);
INSERT INTO `its_user` VALUES (746, '张三738', '1234', '张三738', '男', 0, NULL);
INSERT INTO `its_user` VALUES (747, '张三739', '1234', '张三739', '男', 0, NULL);
INSERT INTO `its_user` VALUES (748, '张三740', '1234', '张三740', '男', 0, NULL);
INSERT INTO `its_user` VALUES (749, '张三741', '1234', '张三741', '男', 0, NULL);
INSERT INTO `its_user` VALUES (750, '张三742', '1234', '张三742', '男', 0, NULL);
INSERT INTO `its_user` VALUES (751, '张三743', '1234', '张三743', '男', 0, NULL);
INSERT INTO `its_user` VALUES (752, '张三744', '1234', '张三744', '男', 0, NULL);
INSERT INTO `its_user` VALUES (753, '张三745', '1234', '张三745', '男', 0, NULL);
INSERT INTO `its_user` VALUES (754, '张三746', '1234', '张三746', '男', 0, NULL);
INSERT INTO `its_user` VALUES (755, '张三747', '1234', '张三747', '男', 0, NULL);
INSERT INTO `its_user` VALUES (756, '张三748', '1234', '张三748', '男', 0, NULL);
INSERT INTO `its_user` VALUES (757, '张三749', '1234', '张三749', '男', 0, NULL);
INSERT INTO `its_user` VALUES (758, '张三750', '1234', '张三750', '男', 0, NULL);
INSERT INTO `its_user` VALUES (759, '张三751', '1234', '张三751', '男', 0, NULL);
INSERT INTO `its_user` VALUES (760, '张三752', '1234', '张三752', '男', 0, NULL);
INSERT INTO `its_user` VALUES (761, '张三753', '1234', '张三753', '男', 0, NULL);
INSERT INTO `its_user` VALUES (762, '张三754', '1234', '张三754', '男', 0, NULL);
INSERT INTO `its_user` VALUES (763, '张三755', '1234', '张三755', '男', 0, NULL);
INSERT INTO `its_user` VALUES (764, '张三756', '1234', '张三756', '男', 0, NULL);
INSERT INTO `its_user` VALUES (765, '张三757', '1234', '张三757', '男', 0, NULL);
INSERT INTO `its_user` VALUES (766, '张三758', '1234', '张三758', '男', 0, NULL);
INSERT INTO `its_user` VALUES (767, '张三759', '1234', '张三759', '男', 0, NULL);
INSERT INTO `its_user` VALUES (768, '张三760', '1234', '张三760', '男', 0, NULL);
INSERT INTO `its_user` VALUES (769, '张三761', '1234', '张三761', '男', 0, NULL);
INSERT INTO `its_user` VALUES (770, '张三762', '1234', '张三762', '男', 0, NULL);
INSERT INTO `its_user` VALUES (771, '张三763', '1234', '张三763', '男', 0, NULL);
INSERT INTO `its_user` VALUES (772, '张三764', '1234', '张三764', '男', 0, NULL);
INSERT INTO `its_user` VALUES (773, '张三765', '1234', '张三765', '男', 0, NULL);
INSERT INTO `its_user` VALUES (774, '张三766', '1234', '张三766', '男', 0, NULL);
INSERT INTO `its_user` VALUES (775, '张三767', '1234', '张三767', '男', 0, NULL);
INSERT INTO `its_user` VALUES (776, '张三768', '1234', '张三768', '男', 0, NULL);
INSERT INTO `its_user` VALUES (777, '张三769', '1234', '张三769', '男', 0, NULL);
INSERT INTO `its_user` VALUES (778, '张三770', '1234', '张三770', '男', 0, NULL);
INSERT INTO `its_user` VALUES (779, '张三771', '1234', '张三771', '男', 0, NULL);
INSERT INTO `its_user` VALUES (780, '张三772', '1234', '张三772', '男', 0, NULL);
INSERT INTO `its_user` VALUES (781, '张三773', '1234', '张三773', '男', 0, NULL);
INSERT INTO `its_user` VALUES (782, '张三774', '1234', '张三774', '男', 0, NULL);
INSERT INTO `its_user` VALUES (783, '张三775', '1234', '张三775', '男', 0, NULL);
INSERT INTO `its_user` VALUES (784, '张三776', '1234', '张三776', '男', 0, NULL);
INSERT INTO `its_user` VALUES (785, '张三777', '1234', '张三777', '男', 0, NULL);
INSERT INTO `its_user` VALUES (786, '张三778', '1234', '张三778', '男', 0, NULL);
INSERT INTO `its_user` VALUES (787, '张三779', '1234', '张三779', '男', 0, NULL);
INSERT INTO `its_user` VALUES (788, '张三780', '1234', '张三780', '男', 0, NULL);
INSERT INTO `its_user` VALUES (789, '张三781', '1234', '张三781', '男', 0, NULL);
INSERT INTO `its_user` VALUES (790, '张三782', '1234', '张三782', '男', 0, NULL);
INSERT INTO `its_user` VALUES (791, '张三783', '1234', '张三783', '男', 0, NULL);
INSERT INTO `its_user` VALUES (792, '张三784', '1234', '张三784', '男', 0, NULL);
INSERT INTO `its_user` VALUES (793, '张三785', '1234', '张三785', '男', 0, NULL);
INSERT INTO `its_user` VALUES (794, '张三786', '1234', '张三786', '男', 0, NULL);
INSERT INTO `its_user` VALUES (795, '张三787', '1234', '张三787', '男', 0, NULL);
INSERT INTO `its_user` VALUES (796, '张三788', '1234', '张三788', '男', 0, NULL);
INSERT INTO `its_user` VALUES (797, '张三789', '1234', '张三789', '男', 0, NULL);
INSERT INTO `its_user` VALUES (798, '张三790', '1234', '张三790', '男', 0, NULL);
INSERT INTO `its_user` VALUES (799, '张三791', '1234', '张三791', '男', 0, NULL);
INSERT INTO `its_user` VALUES (800, '张三792', '1234', '张三792', '男', 0, NULL);
INSERT INTO `its_user` VALUES (801, '张三793', '1234', '张三793', '男', 0, NULL);
INSERT INTO `its_user` VALUES (802, '张三794', '1234', '张三794', '男', 0, NULL);
INSERT INTO `its_user` VALUES (803, '张三795', '1234', '张三795', '男', 0, NULL);
INSERT INTO `its_user` VALUES (804, '张三796', '1234', '张三796', '男', 0, NULL);
INSERT INTO `its_user` VALUES (805, '张三797', '1234', '张三797', '男', 0, NULL);
INSERT INTO `its_user` VALUES (806, '张三798', '1234', '张三798', '男', 0, NULL);
INSERT INTO `its_user` VALUES (807, '张三799', '1234', '张三799', '男', 0, NULL);
INSERT INTO `its_user` VALUES (808, '张三800', '1234', '张三800', '男', 0, NULL);
INSERT INTO `its_user` VALUES (809, '张三801', '1234', '张三801', '男', 0, NULL);
INSERT INTO `its_user` VALUES (810, '张三802', '1234', '张三802', '男', 0, NULL);
INSERT INTO `its_user` VALUES (811, '张三803', '1234', '张三803', '男', 0, NULL);
INSERT INTO `its_user` VALUES (812, '张三804', '1234', '张三804', '男', 0, NULL);
INSERT INTO `its_user` VALUES (813, '张三805', '1234', '张三805', '男', 0, NULL);
INSERT INTO `its_user` VALUES (814, '张三806', '1234', '张三806', '男', 0, NULL);
INSERT INTO `its_user` VALUES (815, '张三807', '1234', '张三807', '男', 0, NULL);
INSERT INTO `its_user` VALUES (816, '张三808', '1234', '张三808', '男', 0, NULL);
INSERT INTO `its_user` VALUES (817, '张三809', '1234', '张三809', '男', 0, NULL);
INSERT INTO `its_user` VALUES (818, '张三810', '1234', '张三810', '男', 0, NULL);
INSERT INTO `its_user` VALUES (819, '张三811', '1234', '张三811', '男', 0, NULL);
INSERT INTO `its_user` VALUES (820, '张三812', '1234', '张三812', '男', 0, NULL);
INSERT INTO `its_user` VALUES (821, '张三813', '1234', '张三813', '男', 0, NULL);
INSERT INTO `its_user` VALUES (822, '张三814', '1234', '张三814', '男', 0, NULL);
INSERT INTO `its_user` VALUES (823, '张三815', '1234', '张三815', '男', 0, NULL);
INSERT INTO `its_user` VALUES (824, '张三816', '1234', '张三816', '男', 0, NULL);
INSERT INTO `its_user` VALUES (825, '张三817', '1234', '张三817', '男', 0, NULL);
INSERT INTO `its_user` VALUES (826, '张三818', '1234', '张三818', '男', 0, NULL);
INSERT INTO `its_user` VALUES (827, '张三819', '1234', '张三819', '男', 0, NULL);
INSERT INTO `its_user` VALUES (828, '张三820', '1234', '张三820', '男', 0, NULL);
INSERT INTO `its_user` VALUES (829, '张三821', '1234', '张三821', '男', 0, NULL);
INSERT INTO `its_user` VALUES (830, '张三822', '1234', '张三822', '男', 0, NULL);
INSERT INTO `its_user` VALUES (831, '张三823', '1234', '张三823', '男', 0, NULL);
INSERT INTO `its_user` VALUES (832, '张三824', '1234', '张三824', '男', 0, NULL);
INSERT INTO `its_user` VALUES (833, '张三825', '1234', '张三825', '男', 0, NULL);
INSERT INTO `its_user` VALUES (834, '张三826', '1234', '张三826', '男', 0, NULL);
INSERT INTO `its_user` VALUES (835, '张三827', '1234', '张三827', '男', 0, NULL);
INSERT INTO `its_user` VALUES (836, '张三828', '1234', '张三828', '男', 0, NULL);
INSERT INTO `its_user` VALUES (837, '张三829', '1234', '张三829', '男', 0, NULL);
INSERT INTO `its_user` VALUES (838, '张三830', '1234', '张三830', '男', 0, NULL);
INSERT INTO `its_user` VALUES (839, '张三831', '1234', '张三831', '男', 0, NULL);
INSERT INTO `its_user` VALUES (840, '张三832', '1234', '张三832', '男', 0, NULL);
INSERT INTO `its_user` VALUES (841, '张三833', '1234', '张三833', '男', 0, NULL);
INSERT INTO `its_user` VALUES (842, '张三834', '1234', '张三834', '男', 0, NULL);
INSERT INTO `its_user` VALUES (843, '张三835', '1234', '张三835', '男', 0, NULL);
INSERT INTO `its_user` VALUES (844, '张三836', '1234', '张三836', '男', 0, NULL);
INSERT INTO `its_user` VALUES (845, '张三837', '1234', '张三837', '男', 0, NULL);
INSERT INTO `its_user` VALUES (846, '张三838', '1234', '张三838', '男', 0, NULL);
INSERT INTO `its_user` VALUES (847, '张三839', '1234', '张三839', '男', 0, NULL);
INSERT INTO `its_user` VALUES (848, '张三840', '1234', '张三840', '男', 0, NULL);
INSERT INTO `its_user` VALUES (849, '张三841', '1234', '张三841', '男', 0, NULL);
INSERT INTO `its_user` VALUES (850, '张三842', '1234', '张三842', '男', 0, NULL);
INSERT INTO `its_user` VALUES (851, '张三843', '1234', '张三843', '男', 0, NULL);
INSERT INTO `its_user` VALUES (852, '张三844', '1234', '张三844', '男', 0, NULL);
INSERT INTO `its_user` VALUES (853, '张三845', '1234', '张三845', '男', 0, NULL);
INSERT INTO `its_user` VALUES (854, '张三846', '1234', '张三846', '男', 0, NULL);
INSERT INTO `its_user` VALUES (855, '张三847', '1234', '张三847', '男', 0, NULL);
INSERT INTO `its_user` VALUES (856, '张三848', '1234', '张三848', '男', 0, NULL);
INSERT INTO `its_user` VALUES (857, '张三849', '1234', '张三849', '男', 0, NULL);
INSERT INTO `its_user` VALUES (858, '张三850', '1234', '张三850', '男', 0, NULL);
INSERT INTO `its_user` VALUES (859, '张三851', '1234', '张三851', '男', 0, NULL);
INSERT INTO `its_user` VALUES (860, '张三852', '1234', '张三852', '男', 0, NULL);
INSERT INTO `its_user` VALUES (861, '张三853', '1234', '张三853', '男', 0, NULL);
INSERT INTO `its_user` VALUES (862, '张三854', '1234', '张三854', '男', 0, NULL);
INSERT INTO `its_user` VALUES (863, '张三855', '1234', '张三855', '男', 0, NULL);
INSERT INTO `its_user` VALUES (864, '张三856', '1234', '张三856', '男', 0, NULL);
INSERT INTO `its_user` VALUES (865, '张三857', '1234', '张三857', '男', 0, NULL);
INSERT INTO `its_user` VALUES (866, '张三858', '1234', '张三858', '男', 0, NULL);
INSERT INTO `its_user` VALUES (867, '张三859', '1234', '张三859', '男', 0, NULL);
INSERT INTO `its_user` VALUES (868, '张三860', '1234', '张三860', '男', 0, NULL);
INSERT INTO `its_user` VALUES (869, '张三861', '1234', '张三861', '男', 0, NULL);
INSERT INTO `its_user` VALUES (870, '张三862', '1234', '张三862', '男', 0, NULL);
INSERT INTO `its_user` VALUES (871, '张三863', '1234', '张三863', '男', 0, NULL);
INSERT INTO `its_user` VALUES (872, '张三864', '1234', '张三864', '男', 0, NULL);
INSERT INTO `its_user` VALUES (873, '张三865', '1234', '张三865', '男', 0, NULL);
INSERT INTO `its_user` VALUES (874, '张三866', '1234', '张三866', '男', 0, NULL);
INSERT INTO `its_user` VALUES (875, '张三867', '1234', '张三867', '男', 0, NULL);
INSERT INTO `its_user` VALUES (876, '张三868', '1234', '张三868', '男', 0, NULL);
INSERT INTO `its_user` VALUES (877, '张三869', '1234', '张三869', '男', 0, NULL);
INSERT INTO `its_user` VALUES (878, '张三870', '1234', '张三870', '男', 0, NULL);
INSERT INTO `its_user` VALUES (879, '张三871', '1234', '张三871', '男', 0, NULL);
INSERT INTO `its_user` VALUES (880, '张三872', '1234', '张三872', '男', 0, NULL);
INSERT INTO `its_user` VALUES (881, '张三873', '1234', '张三873', '男', 0, NULL);
INSERT INTO `its_user` VALUES (882, '张三874', '1234', '张三874', '男', 0, NULL);
INSERT INTO `its_user` VALUES (883, '张三875', '1234', '张三875', '男', 0, NULL);
INSERT INTO `its_user` VALUES (884, '张三876', '1234', '张三876', '男', 0, NULL);
INSERT INTO `its_user` VALUES (885, '张三877', '1234', '张三877', '男', 0, NULL);
INSERT INTO `its_user` VALUES (886, '张三878', '1234', '张三878', '男', 0, NULL);
INSERT INTO `its_user` VALUES (887, '张三879', '1234', '张三879', '男', 0, NULL);
INSERT INTO `its_user` VALUES (888, '张三880', '1234', '张三880', '男', 0, NULL);
INSERT INTO `its_user` VALUES (889, '张三881', '1234', '张三881', '男', 0, NULL);
INSERT INTO `its_user` VALUES (890, '张三882', '1234', '张三882', '男', 0, NULL);
INSERT INTO `its_user` VALUES (891, '张三883', '1234', '张三883', '男', 0, NULL);
INSERT INTO `its_user` VALUES (892, '张三884', '1234', '张三884', '男', 0, NULL);
INSERT INTO `its_user` VALUES (893, '张三885', '1234', '张三885', '男', 0, NULL);
INSERT INTO `its_user` VALUES (894, '张三886', '1234', '张三886', '男', 0, NULL);
INSERT INTO `its_user` VALUES (895, '张三887', '1234', '张三887', '男', 0, NULL);
INSERT INTO `its_user` VALUES (896, '张三888', '1234', '张三888', '男', 0, NULL);
INSERT INTO `its_user` VALUES (897, '张三889', '1234', '张三889', '男', 0, NULL);
INSERT INTO `its_user` VALUES (898, '张三890', '1234', '张三890', '男', 0, NULL);
INSERT INTO `its_user` VALUES (899, '张三891', '1234', '张三891', '男', 0, NULL);
INSERT INTO `its_user` VALUES (900, '张三892', '1234', '张三892', '男', 0, NULL);
INSERT INTO `its_user` VALUES (901, '张三893', '1234', '张三893', '男', 0, NULL);
INSERT INTO `its_user` VALUES (902, '张三894', '1234', '张三894', '男', 0, NULL);
INSERT INTO `its_user` VALUES (903, '张三895', '1234', '张三895', '男', 0, NULL);
INSERT INTO `its_user` VALUES (904, '张三896', '1234', '张三896', '男', 0, NULL);
INSERT INTO `its_user` VALUES (905, '张三897', '1234', '张三897', '男', 0, NULL);
INSERT INTO `its_user` VALUES (906, '张三898', '1234', '张三898', '男', 0, NULL);
INSERT INTO `its_user` VALUES (907, '张三899', '1234', '张三899', '男', 0, NULL);
INSERT INTO `its_user` VALUES (908, '张三900', '1234', '张三900', '男', 0, NULL);
INSERT INTO `its_user` VALUES (909, '张三901', '1234', '张三901', '男', 0, NULL);
INSERT INTO `its_user` VALUES (910, '张三902', '1234', '张三902', '男', 0, NULL);
INSERT INTO `its_user` VALUES (911, '张三903', '1234', '张三903', '男', 0, NULL);
INSERT INTO `its_user` VALUES (912, '张三904', '1234', '张三904', '男', 0, NULL);
INSERT INTO `its_user` VALUES (913, '张三905', '1234', '张三905', '男', 0, NULL);
INSERT INTO `its_user` VALUES (914, '张三906', '1234', '张三906', '男', 0, NULL);
INSERT INTO `its_user` VALUES (915, '张三907', '1234', '张三907', '男', 0, NULL);
INSERT INTO `its_user` VALUES (916, '张三908', '1234', '张三908', '男', 0, NULL);
INSERT INTO `its_user` VALUES (917, '张三909', '1234', '张三909', '男', 0, NULL);
INSERT INTO `its_user` VALUES (918, '张三910', '1234', '张三910', '男', 0, NULL);
INSERT INTO `its_user` VALUES (919, '张三911', '1234', '张三911', '男', 0, NULL);
INSERT INTO `its_user` VALUES (920, '张三912', '1234', '张三912', '男', 0, NULL);
INSERT INTO `its_user` VALUES (921, '张三913', '1234', '张三913', '男', 0, NULL);
INSERT INTO `its_user` VALUES (922, '张三914', '1234', '张三914', '男', 0, NULL);
INSERT INTO `its_user` VALUES (923, '张三915', '1234', '张三915', '男', 0, NULL);
INSERT INTO `its_user` VALUES (924, '张三916', '1234', '张三916', '男', 0, NULL);
INSERT INTO `its_user` VALUES (925, '张三917', '1234', '张三917', '男', 0, NULL);
INSERT INTO `its_user` VALUES (926, '张三918', '1234', '张三918', '男', 0, NULL);
INSERT INTO `its_user` VALUES (927, '张三919', '1234', '张三919', '男', 0, NULL);
INSERT INTO `its_user` VALUES (928, '张三920', '1234', '张三920', '男', 0, NULL);
INSERT INTO `its_user` VALUES (929, '张三921', '1234', '张三921', '男', 0, NULL);
INSERT INTO `its_user` VALUES (930, '张三922', '1234', '张三922', '男', 0, NULL);
INSERT INTO `its_user` VALUES (931, '张三923', '1234', '张三923', '男', 0, NULL);
INSERT INTO `its_user` VALUES (932, '张三924', '1234', '张三924', '男', 0, NULL);
INSERT INTO `its_user` VALUES (933, '张三925', '1234', '张三925', '男', 0, NULL);
INSERT INTO `its_user` VALUES (934, '张三926', '1234', '张三926', '男', 0, NULL);
INSERT INTO `its_user` VALUES (935, '张三927', '1234', '张三927', '男', 0, NULL);
INSERT INTO `its_user` VALUES (936, '张三928', '1234', '张三928', '男', 0, NULL);
INSERT INTO `its_user` VALUES (937, '张三929', '1234', '张三929', '男', 0, NULL);
INSERT INTO `its_user` VALUES (938, '张三930', '1234', '张三930', '男', 0, NULL);
INSERT INTO `its_user` VALUES (939, '张三931', '1234', '张三931', '男', 0, NULL);
INSERT INTO `its_user` VALUES (940, '张三932', '1234', '张三932', '男', 0, NULL);
INSERT INTO `its_user` VALUES (941, '张三933', '1234', '张三933', '男', 0, NULL);
INSERT INTO `its_user` VALUES (942, '张三934', '1234', '张三934', '男', 0, NULL);
INSERT INTO `its_user` VALUES (943, '张三935', '1234', '张三935', '男', 0, NULL);
INSERT INTO `its_user` VALUES (944, '张三936', '1234', '张三936', '男', 0, NULL);
INSERT INTO `its_user` VALUES (945, '张三937', '1234', '张三937', '男', 0, NULL);
INSERT INTO `its_user` VALUES (946, '张三938', '1234', '张三938', '男', 0, NULL);
INSERT INTO `its_user` VALUES (947, '张三939', '1234', '张三939', '男', 0, NULL);
INSERT INTO `its_user` VALUES (948, '张三940', '1234', '张三940', '男', 0, NULL);
INSERT INTO `its_user` VALUES (949, '张三941', '1234', '张三941', '男', 0, NULL);
INSERT INTO `its_user` VALUES (950, '张三942', '1234', '张三942', '男', 0, NULL);
INSERT INTO `its_user` VALUES (951, '张三943', '1234', '张三943', '男', 0, NULL);
INSERT INTO `its_user` VALUES (952, '张三944', '1234', '张三944', '男', 0, NULL);
INSERT INTO `its_user` VALUES (953, '张三945', '1234', '张三945', '男', 0, NULL);
INSERT INTO `its_user` VALUES (954, '张三946', '1234', '张三946', '男', 0, NULL);
INSERT INTO `its_user` VALUES (955, '张三947', '1234', '张三947', '男', 0, NULL);
INSERT INTO `its_user` VALUES (956, '张三948', '1234', '张三948', '男', 0, NULL);
INSERT INTO `its_user` VALUES (957, '张三949', '1234', '张三949', '男', 0, NULL);
INSERT INTO `its_user` VALUES (958, '张三950', '1234', '张三950', '男', 0, NULL);
INSERT INTO `its_user` VALUES (959, '张三951', '1234', '张三951', '男', 0, NULL);
INSERT INTO `its_user` VALUES (960, '张三952', '1234', '张三952', '男', 0, NULL);
INSERT INTO `its_user` VALUES (961, '张三953', '1234', '张三953', '男', 0, NULL);
INSERT INTO `its_user` VALUES (962, '张三954', '1234', '张三954', '男', 0, NULL);
INSERT INTO `its_user` VALUES (963, '张三955', '1234', '张三955', '男', 0, NULL);
INSERT INTO `its_user` VALUES (964, '张三956', '1234', '张三956', '男', 0, NULL);
INSERT INTO `its_user` VALUES (965, '张三957', '1234', '张三957', '男', 0, NULL);
INSERT INTO `its_user` VALUES (966, '张三958', '1234', '张三958', '男', 0, NULL);
INSERT INTO `its_user` VALUES (967, '张三959', '1234', '张三959', '男', 0, NULL);
INSERT INTO `its_user` VALUES (968, '张三960', '1234', '张三960', '男', 0, NULL);
INSERT INTO `its_user` VALUES (969, '张三961', '1234', '张三961', '男', 0, NULL);
INSERT INTO `its_user` VALUES (970, '张三962', '1234', '张三962', '男', 0, NULL);
INSERT INTO `its_user` VALUES (971, '张三963', '1234', '张三963', '男', 0, NULL);
INSERT INTO `its_user` VALUES (972, '张三964', '1234', '张三964', '男', 0, NULL);
INSERT INTO `its_user` VALUES (973, '张三965', '1234', '张三965', '男', 0, NULL);
INSERT INTO `its_user` VALUES (974, '张三966', '1234', '张三966', '男', 0, NULL);
INSERT INTO `its_user` VALUES (975, '张三967', '1234', '张三967', '男', 0, NULL);
INSERT INTO `its_user` VALUES (976, '张三968', '1234', '张三968', '男', 0, NULL);
INSERT INTO `its_user` VALUES (977, '张三969', '1234', '张三969', '男', 0, NULL);
INSERT INTO `its_user` VALUES (978, '张三970', '1234', '张三970', '男', 0, NULL);
INSERT INTO `its_user` VALUES (979, '张三971', '1234', '张三971', '男', 0, NULL);
INSERT INTO `its_user` VALUES (980, '张三972', '1234', '张三972', '男', 0, NULL);
INSERT INTO `its_user` VALUES (981, '张三973', '1234', '张三973', '男', 0, NULL);
INSERT INTO `its_user` VALUES (982, '张三974', '1234', '张三974', '男', 0, NULL);
INSERT INTO `its_user` VALUES (983, '张三975', '1234', '张三975', '男', 0, NULL);
INSERT INTO `its_user` VALUES (984, '张三976', '1234', '张三976', '男', 0, NULL);
INSERT INTO `its_user` VALUES (985, '张三977', '1234', '张三977', '男', 0, NULL);
INSERT INTO `its_user` VALUES (986, '张三978', '1234', '张三978', '男', 0, NULL);
INSERT INTO `its_user` VALUES (987, '张三979', '1234', '张三979', '男', 0, NULL);
INSERT INTO `its_user` VALUES (988, '张三980', '1234', '张三980', '男', 0, NULL);
INSERT INTO `its_user` VALUES (989, '张三981', '1234', '张三981', '男', 0, NULL);
INSERT INTO `its_user` VALUES (990, '张三982', '1234', '张三982', '男', 0, NULL);
INSERT INTO `its_user` VALUES (991, '张三983', '1234', '张三983', '男', 0, NULL);
INSERT INTO `its_user` VALUES (992, '张三984', '1234', '张三984', '男', 0, NULL);
INSERT INTO `its_user` VALUES (993, '张三985', '1234', '张三985', '男', 0, NULL);
INSERT INTO `its_user` VALUES (994, '张三986', '1234', '张三986', '男', 0, NULL);
INSERT INTO `its_user` VALUES (995, '张三987', '1234', '张三987', '男', 0, NULL);
INSERT INTO `its_user` VALUES (996, '张三988', '1234', '张三988', '男', 0, NULL);
INSERT INTO `its_user` VALUES (997, '张三989', '1234', '张三989', '男', 0, NULL);
INSERT INTO `its_user` VALUES (998, '张三990', '1234', '张三990', '男', 0, NULL);
INSERT INTO `its_user` VALUES (999, '张三991', '1234', '张三991', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1000, '张三992', '1234', '张三992', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1001, '张三993', '1234', '张三993', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1002, '张三994', '1234', '张三994', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1003, '张三995', '1234', '张三995', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1004, '张三996', '1234', '张三996', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1005, '张三997', '1234', '张三997', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1006, '张三998', '1234', '张三998', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1007, '张三999', '1234', '张三999', '男', 0, NULL);
INSERT INTO `its_user` VALUES (1008, '张三1000', '$2a$04$QfnFqdeYT/K5.9OtzW2lyetUhho1CLLeHywwqWS8KvLgKrMkVBUvC', '张三1000', '男', 0, NULL);
INSERT INTO `its_user` VALUES (3009, 'lucien', '$2a$04$FprClwIqA.S0r6zTRzX2puNYDcyFujeZYzyjpnPKvymxfiCutFJA.', 'aaaa', '男', 0, 0);

-- ----------------------------
-- Table structure for its_user_role
-- ----------------------------
DROP TABLE IF EXISTS `its_user_role`;
CREATE TABLE `its_user_role`  (
  `user_id` int(0) NOT NULL,
  `role_id` int(0) NOT NULL,
  `id` int(0) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id_idx`(`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of its_user_role
-- ----------------------------
INSERT INTO `its_user_role` VALUES (1, 1, 1);
INSERT INTO `its_user_role` VALUES (1, 2, 2);
INSERT INTO `its_user_role` VALUES (2, 2, 3);
INSERT INTO `its_user_role` VALUES (3, 3, 4);
INSERT INTO `its_user_role` VALUES (6, 1, 5);
INSERT INTO `its_user_role` VALUES (6, 2, 6);
INSERT INTO `its_user_role` VALUES (6, 3, 7);
INSERT INTO `its_user_role` VALUES (8, 3, 8);
INSERT INTO `its_user_role` VALUES (1008, 2, 9);
INSERT INTO `its_user_role` VALUES (3009, 1, 10);
INSERT INTO `its_user_role` VALUES (3009, 1, 11);

-- ----------------------------
-- Table structure for knowledge_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_knowledge`;
CREATE TABLE `knowledge_knowledge`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT ' 主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '知识点名字',
  `parent_id` int(0) NULL DEFAULT 0 COMMENT '父id',
  `subject_id` int(0) NULL DEFAULT NULL COMMENT '学科id',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge_knowledge
-- ----------------------------
INSERT INTO `knowledge_knowledge` VALUES (1, '等高线', 0, 1, b'1');
INSERT INTO `knowledge_knowledge` VALUES (5, 'sub_等高线', 1, 1, b'1');
INSERT INTO `knowledge_knowledge` VALUES (6, '2', 0, 1, b'1');
INSERT INTO `knowledge_knowledge` VALUES (7, '22', 6, 1, b'1');
INSERT INTO `knowledge_knowledge` VALUES (8, '数学知识', 0, 2, b'0');
INSERT INTO `knowledge_knowledge` VALUES (9, '总星系', 54, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (10, '银河系', 9, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (11, '河外星系', 9, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (12, '太阳系', 10, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (13, '其它恒星系', 10, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (14, '天体系统', 54, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (15, '太阳', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (16, '水星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (17, '金星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (18, '地球', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (19, '火星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (20, '木星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (21, '土星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (22, '天王星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (23, '海王星', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (24, '小行星带', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (25, '类地行星', 34, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (26, '巨行星', 34, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (27, '远日行星', 34, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (28, '天体', 14, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (29, '天体的空间位置', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (30, '天体的物质形态', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (31, '天体的运转轨道', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (32, '星云', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (33, '恒星', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (34, '行星', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (35, '卫星', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (36, '彗星', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (37, '流星体', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (38, '星际物质', 28, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (39, '月球', 40, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (40, '地月系', 12, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (41, '绕日公转', 34, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (42, '同向性', 41, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (43, '共面性', 41, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (44, '近圆性', 41, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (45, '所处宇宙环境安全', 18, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (46, '适宜的温度', 18, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (47, '大气条件', 18, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (48, '液态水', 18, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (49, '日地距离适中', 46, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (50, '公转自转周期适当', 46, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (51, '质量体积适中', 47, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (52, '一元一次方程', 8, 2, b'0');
INSERT INTO `knowledge_knowledge` VALUES (53, '一元二次方程', 8, 2, b'0');
INSERT INTO `knowledge_knowledge` VALUES (54, '宇宙中的地球', 0, 1, b'0');
INSERT INTO `knowledge_knowledge` VALUES (55, '唐代知识', 0, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (56, '唐朝的建立', 55, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (57, '唐朝的繁荣发展', 55, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (58, '唐朝的衰落和灭亡', 55, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (59, '618年，唐高祖李渊太原起兵，建立唐朝', 56, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (60, '贞观之治', 57, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (61, '武周', 57, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (62, '开元盛世', 57, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (63, '唐朝的政治', 57, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (64, '天宝危机', 58, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (65, '安史之乱', 58, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (66, '618年，李渊太原起兵，建立唐朝', 59, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (67, '贞观之治', 60, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (68, '唐末农民战争', 58, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (69, '唐朝的经济', 57, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (70, '唐朝的对外交流', 57, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (71, '唐太宗李世明', 60, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (72, '唐太宗李世明贞观之治', 63, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (73, '三省六部制', 63, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (74, '武周', 57, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (75, '武周女皇武则天', 63, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (76, '唐玄宗李隆基开元盛世', 63, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (77, '科举制度', 63, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (78, '筒车', 69, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (79, '手工业', 69, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (80, '农业', 69, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (81, '商业', 69, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (82, '曲辕犁耕地，筒车灌溉', 80, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (83, '筒车灌溉', 80, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (84, '丝织（蜀锦）', 79, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (85, '制瓷', 79, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (86, '越窑青瓷邢窑白瓷', 85, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (87, '唐三彩', 85, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (88, '国际大都会（长安）', 81, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (89, '商业区（市）和居民区（坊）严格分开', 81, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (90, '鉴真东渡', 70, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (91, '玄奘西行', 70, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (92, '李林甫杨国忠乱国', 64, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (93, '安禄山、史思明叛乱', 65, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (94, '郭子仪平叛', 65, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (95, '黄巢起义', 58, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (96, '唐太宗李世明', 72, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (97, '中书拟诏', 73, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (98, '门下审核', 73, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (99, '尚书执行', 73, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (100, '工部、兵部、户部、刑部、礼部、吏部', 99, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (101, '无字碑', 75, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (102, '唐玄宗李隆基', 76, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (103, '武举出现', 75, 3, b'1');
INSERT INTO `knowledge_knowledge` VALUES (104, '分科考试', 77, 3, b'0');
INSERT INTO `knowledge_knowledge` VALUES (105, '武则天开创武举', 75, 3, b'0');

-- ----------------------------
-- Table structure for knowledge_relation
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_relation`;
CREATE TABLE `knowledge_relation`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ko_a` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '知识点A',
  `ko_a_id` int(0) NULL DEFAULT NULL COMMENT '知识点A的id',
  `ko_b` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '知识点B',
  `ko_b_id` int(0) NULL DEFAULT NULL COMMENT '知识点B的id',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `relation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge_relation
-- ----------------------------
INSERT INTO `knowledge_relation` VALUES (1, '等高线', 1, '数学知识', 8, b'1', '222');
INSERT INTO `knowledge_relation` VALUES (2, '银河系', 10, '总星系', 9, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (3, '河外星系', 11, '总星系', 9, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (4, '太阳系', 12, '银河系', 10, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (5, '其它恒星系', 13, '银河系', 10, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (6, '太阳', 15, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (7, '水星', 16, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (8, '金星', 17, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (9, '地球', 18, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (10, '火星', 19, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (11, '木星', 20, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (12, '土星', 21, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (13, '天王星', 22, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (14, '海王星', 23, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (15, '小行星带', 24, '太阳系', 12, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (16, '水星', 16, '类地行星', 25, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (17, '金星', 17, '类地行星', 25, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (18, '地球', 18, '类地行星', 25, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (19, '火星', 19, '类地行星', 25, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (20, '木星', 20, '巨行星', 26, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (21, '土星', 21, '巨行星', 26, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (22, '天王星', 22, '远日行星', 27, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (23, '海王星', 23, '远日行星', 27, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (24, '类地行星', 25, '行星', 34, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (25, '巨行星', 26, '行星', 34, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (26, '远日行星', 27, '行星', 34, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (27, '星云', 32, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (28, '恒星', 33, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (29, '行星', 34, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (30, '卫星', 35, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (31, '彗星', 36, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (32, '流星体', 37, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (33, '星际物质', 38, '天体', 28, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (34, '天体', 28, '天体系统', 14, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (35, '天体', 28, '天体的空间位置', 29, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (36, '天体', 28, '天体的物质形态', 30, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (37, '天体', 28, '天体的运转轨道', 31, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (38, '月球', 39, '卫星', 35, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (39, '太阳', 15, '恒星', 33, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (40, '地球', 18, '地月系', 40, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (41, '月球', 39, '地月系', 40, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (42, '行星', 34, '绕日公转', 41, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (43, '绕日公转', 41, '同向性', 42, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (44, '绕日公转', 41, '共面性', 43, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (45, '绕日公转', 41, '近圆性', 44, b'0', '具有属性');
INSERT INTO `knowledge_relation` VALUES (46, '地球', 18, '适宜的温度', 46, b'0', '具有特征');
INSERT INTO `knowledge_relation` VALUES (47, '地球', 18, '大气条件', 47, b'0', '具有特征');
INSERT INTO `knowledge_relation` VALUES (48, '地球', 18, '液态水', 48, b'0', '具有特征');
INSERT INTO `knowledge_relation` VALUES (49, '地球', 18, '所处宇宙环境安全', 45, b'0', '具有特征');
INSERT INTO `knowledge_relation` VALUES (50, '日地距离适中', 49, '适宜的温度', 46, b'0', '支持');
INSERT INTO `knowledge_relation` VALUES (51, '公转自转周期适当', 50, '适宜的温度', 46, b'0', '支持');
INSERT INTO `knowledge_relation` VALUES (52, '质量体积适中', 51, '大气条件', 47, b'0', '支持');
INSERT INTO `knowledge_relation` VALUES (53, NULL, 56, NULL, 55, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (54, NULL, 55, NULL, 56, b'1', '包含');
INSERT INTO `knowledge_relation` VALUES (55, NULL, 57, NULL, 55, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (56, NULL, 58, NULL, 55, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (57, NULL, 59, NULL, 56, b'1', '属于');
INSERT INTO `knowledge_relation` VALUES (58, NULL, 66, NULL, 56, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (59, NULL, 64, NULL, 58, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (60, NULL, 65, NULL, 58, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (61, NULL, 68, NULL, 58, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (62, NULL, 63, NULL, 57, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (63, NULL, 69, NULL, 57, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (64, NULL, 70, NULL, 57, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (65, NULL, 72, NULL, 63, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (66, NULL, 73, NULL, 63, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (67, NULL, 75, NULL, 63, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (68, NULL, 77, NULL, 63, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (69, NULL, 76, NULL, 63, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (70, NULL, 79, NULL, 69, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (71, NULL, 80, NULL, 69, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (72, NULL, 81, NULL, 69, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (73, NULL, 82, NULL, 80, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (74, NULL, 84, NULL, 79, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (75, NULL, 85, NULL, 79, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (76, NULL, 86, NULL, 85, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (77, NULL, 87, NULL, 85, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (78, NULL, 88, NULL, 81, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (79, NULL, 89, NULL, 81, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (80, NULL, 90, NULL, 70, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (81, NULL, 91, NULL, 70, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (82, NULL, 92, NULL, 64, b'0', '导致');
INSERT INTO `knowledge_relation` VALUES (83, NULL, 93, NULL, 65, b'0', '是');
INSERT INTO `knowledge_relation` VALUES (84, NULL, 94, NULL, 65, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (85, NULL, 95, NULL, 58, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (86, NULL, 97, NULL, 73, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (87, NULL, 98, NULL, 73, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (88, NULL, 99, NULL, 73, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (89, NULL, 100, NULL, 99, b'0', '构成');
INSERT INTO `knowledge_relation` VALUES (90, NULL, 101, NULL, 75, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (91, NULL, 104, NULL, 77, b'0', '属于');
INSERT INTO `knowledge_relation` VALUES (92, NULL, 105, NULL, 75, b'0', '属于');

-- ----------------------------
-- Table structure for knowledge_subject
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_subject`;
CREATE TABLE `knowledge_subject`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学科名称',
  `study_period` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学段',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge_subject
-- ----------------------------
INSERT INTO `knowledge_subject` VALUES (1, '地理', '3', b'0');
INSERT INTO `knowledge_subject` VALUES (2, '数学', '小学', b'0');
INSERT INTO `knowledge_subject` VALUES (3, '历史', '初中', b'0');
INSERT INTO `knowledge_subject` VALUES (4, '物理', '小学', b'0');
INSERT INTO `knowledge_subject` VALUES (5, '智能教学系统设计与开发', '本科', b'0');

-- ----------------------------
-- Table structure for log_info
-- ----------------------------
DROP TABLE IF EXISTS `log_info`;
CREATE TABLE `log_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '软删除标识',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `params` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `time` int(0) NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 596 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log_info
-- ----------------------------
INSERT INTO `log_info` VALUES (529, b'0', '2021-05-02 16:03:37', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'knowledge\' on field \'subjectId\': rejected value []; codes [typeMismatch.knowledge.subjectId,typeMismatch.subjectId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [knowledge.subjectId,subjectId]; arguments []; default message [subjectId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'subjectId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (530, b'0', '2021-05-02 16:05:27', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'knowledge\' on field \'subjectId\': rejected value []; codes [typeMismatch.knowledge.subjectId,typeMismatch.subjectId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [knowledge.subjectId,subjectId]; arguments []; default message [subjectId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'subjectId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (531, b'0', '2021-05-02 16:06:02', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'knowledge\' on field \'subjectId\': rejected value []; codes [typeMismatch.knowledge.subjectId,typeMismatch.subjectId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [knowledge.subjectId,subjectId]; arguments []; default message [subjectId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'subjectId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (532, b'0', '2021-05-02 16:08:55', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (533, b'0', '2021-05-02 16:09:30', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'knowledge\' on field \'subjectId\': rejected value []; codes [typeMismatch.knowledge.subjectId,typeMismatch.subjectId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [knowledge.subjectId,subjectId]; arguments []; default message [subjectId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'subjectId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (534, b'0', '2021-05-02 16:11:12', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (535, b'0', '2021-05-02 16:11:23', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'knowledge\' on field \'subjectId\': rejected value []; codes [typeMismatch.knowledge.subjectId,typeMismatch.subjectId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [knowledge.subjectId,subjectId]; arguments []; default message [subjectId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'subjectId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (536, b'0', '2021-05-02 16:12:37', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (537, b'0', '2021-05-02 16:12:47', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'knowledge\' on field \'subjectId\': rejected value []; codes [typeMismatch.knowledge.subjectId,typeMismatch.subjectId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [knowledge.subjectId,subjectId]; arguments []; default message [subjectId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'subjectId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (538, b'0', '2021-05-02 16:16:01', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (539, b'0', '2021-05-02 16:16:16', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (540, b'0', '2021-05-02 16:16:34', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (541, b'0', '2021-05-02 20:28:30', '127.0.0.1', 'Request method \'POST\' not supported', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/login', NULL);
INSERT INTO `log_info` VALUES (542, b'0', '2021-05-02 20:28:34', '127.0.0.1', 'Request method \'POST\' not supported', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/login', NULL);
INSERT INTO `log_info` VALUES (543, b'0', '2021-05-02 20:29:08', '127.0.0.1', 'Request method \'POST\' not supported', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/login', NULL);
INSERT INTO `log_info` VALUES (544, b'0', '2021-05-02 22:53:00', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/1', 'admin');
INSERT INTO `log_info` VALUES (545, b'0', '2021-05-02 22:53:07', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/1', 'admin');
INSERT INTO `log_info` VALUES (546, b'0', '2021-05-02 22:53:14', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/1', 'admin');
INSERT INTO `log_info` VALUES (547, b'0', '2021-05-02 22:53:26', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/1', 'admin');
INSERT INTO `log_info` VALUES (548, b'0', '2021-05-02 22:53:51', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (549, b'0', '2021-05-02 22:53:53', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (550, b'0', '2021-05-02 22:53:56', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\knowledge\\KnowledgeRelationMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select k.id,k.name from knowledge_relation k where k.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'k.name\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (551, b'0', '2021-05-02 22:54:47', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (552, b'0', '2021-05-02 22:54:49', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/1', 'admin');
INSERT INTO `log_info` VALUES (553, b'0', '2021-05-02 22:55:08', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/1', 'admin');
INSERT INTO `log_info` VALUES (554, b'0', '2021-05-02 22:55:10', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (555, b'0', '2021-05-02 22:55:17', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (556, b'0', '2021-05-02 22:55:20', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (557, b'0', '2021-05-02 22:55:23', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (558, b'0', '2021-05-02 22:55:38', '127.0.0.1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: Could not set property \'koA\' of \'class gzhu.edu.cn.exam.modules.knowledge.entity.KnowledgeRelation\' with value \'KnowledgeRelation(id=1, koA=null, koAId=0, koB=null, koBId=0, relation=null)\' Cause: java.lang.IllegalArgumentException: argument type mismatch', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/relation/graph/2', 'admin');
INSERT INTO `log_info` VALUES (559, b'0', '2021-05-02 23:03:49', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (560, b'0', '2021-05-02 23:03:53', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (561, b'0', '2021-05-05 14:55:07', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (562, b'0', '2021-05-05 14:58:18', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (563, b'0', '2021-05-05 14:58:21', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (564, b'0', '2021-05-05 14:58:23', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (565, b'0', '2021-05-05 15:00:24', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (566, b'0', '2021-05-05 15:04:57', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (567, b'0', '2021-05-05 15:11:04', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (568, b'0', '2021-05-05 15:27:21', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (569, b'0', '2021-05-05 15:28:58', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (570, b'0', '2021-05-05 15:31:56', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (571, b'0', '2021-05-05 15:32:38', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (572, b'0', '2021-05-05 15:33:11', '183.236.0.87', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/knowledge/knowledge/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (573, b'0', '2021-05-07 22:46:56', '127.0.0.1', 'Request method \'POST\' not supported', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/sensor/sensor/control', 'admin');
INSERT INTO `log_info` VALUES (574, b'0', '2021-05-07 22:47:44', '127.0.0.1', 'Request method \'POST\' not supported', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/sensor/sensor/operate', 'admin');
INSERT INTO `log_info` VALUES (575, b'0', '2021-05-07 23:01:25', '183.236.0.93', 'Request method \'GET\' not supported', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/sensor/sensor/operate', 'lucien');
INSERT INTO `log_info` VALUES (576, b'0', '2021-05-07 23:02:26', '183.236.0.93', 'Request method \'GET\' not supported', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/sensor/sensor/operate', 'lucien');
INSERT INTO `log_info` VALUES (577, b'0', '2021-05-07 23:02:32', '183.236.0.93', 'Request method \'GET\' not supported', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/sensor/sensor/operate', 'lucien');
INSERT INTO `log_info` VALUES (578, b'0', '2021-05-07 23:26:32', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'operate\' on field \'time\': rejected value [qq]; codes [typeMismatch.operate.time,typeMismatch.time,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [operate.time,time]; arguments []; default message [time]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'time\'; nested exception is java.lang.NumberFormatException: For input string: \"qq\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/sensor/sensor/operate', 'admin');
INSERT INTO `log_info` VALUES (579, b'0', '2021-05-08 18:44:20', '183.236.0.93', 'Request method \'GET\' not supported', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/sensor/sensor/operate', 'lucien');
INSERT INTO `log_info` VALUES (580, b'0', '2021-05-08 18:44:53', '183.236.0.93', 'Request method \'GET\' not supported', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/sensor/sensor/operate', 'lucien');
INSERT INTO `log_info` VALUES (581, b'0', '2021-05-08 20:49:57', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 2 errors\nField error in object \'sensor\' on field \'schoolId\': rejected value []; codes [typeMismatch.sensor.schoolId,typeMismatch.schoolId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [sensor.schoolId,schoolId]; arguments []; default message [schoolId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'schoolId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]\nField error in object \'sensor\' on field \'typeId\': rejected value []; codes [typeMismatch.sensor.typeId,typeMismatch.typeId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [sensor.typeId,typeId]; arguments []; default message [typeId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'typeId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/sensor/sensor/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (582, b'0', '2021-05-09 03:59:43', '86.236.65.215', 'Request method \'POST\' not supported', NULL, '异常页面', NULL, NULL, 'http://47.119.167.208:8081/', NULL);
INSERT INTO `log_info` VALUES (583, b'0', '2021-05-09 10:13:54', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 2 errors\nField error in object \'sensor\' on field \'schoolId\': rejected value []; codes [typeMismatch.sensor.schoolId,typeMismatch.schoolId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [sensor.schoolId,schoolId]; arguments []; default message [schoolId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'schoolId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]\nField error in object \'sensor\' on field \'typeId\': rejected value []; codes [typeMismatch.sensor.typeId,typeMismatch.typeId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [sensor.typeId,typeId]; arguments []; default message [typeId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'typeId\'; nested exception is java.lang.NumberFormatException: For input string: \"\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/sensor/sensor/saveOrUpdate', 'admin');
INSERT INTO `log_info` VALUES (584, b'0', '2021-05-09 12:58:16', '127.0.0.1', 'Optional int parameter \'page\' is present but cannot be translated into a null value due to being declared as a primitive type. Consider declaring it as object wrapper for the corresponding primitive type.', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/sensor/sensor/list.json', 'admin');
INSERT INTO `log_info` VALUES (585, b'0', '2021-05-11 21:32:26', '127.0.0.1', 'Optional int parameter \'page\' is present but cannot be translated into a null value due to being declared as a primitive type. Consider declaring it as object wrapper for the corresponding primitive type.', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/mobile/sensorData/list.json', 'admin');
INSERT INTO `log_info` VALUES (586, b'0', '2021-05-11 21:32:45', '127.0.0.1', 'Optional int parameter \'page\' is present but cannot be translated into a null value due to being declared as a primitive type. Consider declaring it as object wrapper for the corresponding primitive type.', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/sensor/sensor/list.json', 'admin');
INSERT INTO `log_info` VALUES (587, b'0', '2021-05-11 22:49:25', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/sensor/mapper/SensorDataMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  *  FROM sensor_data   WHERE  deleted=0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/mobile/sensorData', 'admin');
INSERT INTO `log_info` VALUES (588, b'0', '2021-05-11 22:52:44', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/sensor/mapper/SensorDataMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  *  FROM sensor_data   WHERE  deleted=0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/mobile/sensorData', 'admin');
INSERT INTO `log_info` VALUES (589, b'0', '2021-05-11 22:54:52', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/sensor/mapper/SensorDataMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  *  FROM sensor_data   WHERE  deleted=0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/mobile/sensorData', 'admin');
INSERT INTO `log_info` VALUES (590, b'0', '2021-05-11 22:56:27', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/sensor/mapper/SensorDataMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  *  FROM sensor_data   WHERE  deleted=0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/mobile/sensorData', 'admin');
INSERT INTO `log_info` VALUES (591, b'0', '2021-05-11 22:57:30', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/sensor/mapper/SensorDataMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  *  FROM sensor_data   WHERE  deleted=0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/mobile/sensorData', 'admin');
INSERT INTO `log_info` VALUES (592, b'0', '2021-05-11 23:29:35', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/sensor/mapper/SensorDataMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT COUNT(*) FROM sensor_data WHERE deleted = 0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8080/mobile/sensorData/list.json', 'admin');
INSERT INTO `log_info` VALUES (593, b'0', '2021-05-12 22:36:30', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/organization/mapper/CollegeMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT COUNT(*) FROM org_college WHERE deleted = 0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/org/college/list.json', 'admin');
INSERT INTO `log_info` VALUES (594, b'0', '2021-05-12 23:21:32', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown table \'c\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\organization\\MajorMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select c.* from org_college cs where c.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown table \'c\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown table \'c\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/org/major/list.json', 'admin');
INSERT INTO `log_info` VALUES (595, b'0', '2021-05-12 23:21:42', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown table \'c\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\organization\\MajorMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select c.* from org_college cs where c.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown table \'c\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown table \'c\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/org/major/list.json', 'admin');
INSERT INTO `log_info` VALUES (596, b'0', '2021-05-13 22:46:31', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\r\n### The error may exist in gzhu/edu/cn/exam/modules/organization/mapper/ClassInfoMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT COUNT(*) FROM org_class WHERE deleted = 0\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'deleted\' in \'where clause\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/org/classInfo/list.json', 'admin');
INSERT INTO `log_info` VALUES (597, b'0', '2021-05-20 22:35:21', '127.0.0.1', 'org.springframework.validation.BeanPropertyBindingResult: 1 errors\nField error in object \'outline\' on field \'textbookId\': rejected value [{$textbook.id}]; codes [typeMismatch.outline.textbookId,typeMismatch.textbookId,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [outline.textbookId,textbookId]; arguments []; default message [textbookId]]; default message [Failed to convert property value of type \'java.lang.String\' to required type \'int\' for property \'textbookId\'; nested exception is java.lang.NumberFormatException: For input string: \"{$textbook.id}\"]', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/saveOrUpdate/%7B$textbook.id%7D', 'admin');
INSERT INTO `log_info` VALUES (598, b'0', '2021-05-20 22:37:48', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (599, b'0', '2021-05-20 22:37:51', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_textbook o where o.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (600, b'0', '2021-05-20 22:37:54', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_textbook o where o.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (601, b'0', '2021-05-20 22:38:45', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_textbook o where o.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (602, b'0', '2021-05-20 22:40:02', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_textbook o where o.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (603, b'0', '2021-05-20 22:41:18', '127.0.0.1', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_textbook o where o.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'o.textbook_id\' in \'field list\'', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (604, b'0', '2021-05-20 22:42:33', '127.0.0.1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: java.lang.IllegalArgumentException: Mapped Statements collection does not contain value for gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper.getChildrenKnowledgeById\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper.findParnetOutlineById\r\n### The error occurred while handling results\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_outline o where o.id = ?\r\n### Cause: java.lang.IllegalArgumentException: Mapped Statements collection does not contain value for gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper.getChildrenKnowledgeById', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (605, b'0', '2021-05-20 22:43:02', '127.0.0.1', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: java.lang.IllegalArgumentException: Mapped Statements collection does not contain value for gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper.getChildrenKnowledgeById\r\n### The error may exist in file [D:\\eclipse-workspace\\mix-tech\\target\\classes\\mapper\\course\\OutlineMapper.xml]\r\n### The error may involve gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper.findParnetOutlineById\r\n### The error occurred while handling results\r\n### SQL: select o.id,o.name,o.textbook_id,o.parent_id from course_outline o where o.id = ?\r\n### Cause: java.lang.IllegalArgumentException: Mapped Statements collection does not contain value for gzhu.edu.cn.exam.modules.course.mapper.OutlineMapper.getChildrenKnowledgeById', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/1', 'admin');
INSERT INTO `log_info` VALUES (606, b'0', '2021-05-20 22:43:56', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/undefined', 'admin');
INSERT INTO `log_info` VALUES (607, b'0', '2021-05-20 22:44:19', '127.0.0.1', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \"undefined\"', NULL, '异常页面', NULL, NULL, 'http://127.0.0.1:8081/course/outline/tree/undefined', 'admin');

-- ----------------------------
-- Table structure for org_class
-- ----------------------------
DROP TABLE IF EXISTS `org_class`;
CREATE TABLE `org_class`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `school_id` int(0) NULL DEFAULT NULL,
  `college_id` int(0) NULL DEFAULT NULL,
  `major_id` int(0) NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of org_class
-- ----------------------------
INSERT INTO `org_class` VALUES (1, '教育技术201', NULL, 7, 1, 1, b'0');

-- ----------------------------
-- Table structure for org_college
-- ----------------------------
DROP TABLE IF EXISTS `org_college`;
CREATE TABLE `org_college`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `school_id` int(0) NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of org_college
-- ----------------------------
INSERT INTO `org_college` VALUES (1, '教育学院', '教育学院', 7, b'0');
INSERT INTO `org_college` VALUES (2, '计算机学院', '计算机学院', 7, b'0');
INSERT INTO `org_college` VALUES (3, '土木学院', '土木学院', 3, b'0');
INSERT INTO `org_college` VALUES (4, '外语学院', '外语学院', 7, b'0');
INSERT INTO `org_college` VALUES (5, '计算机学院', '计算机学院', 8, b'0');

-- ----------------------------
-- Table structure for org_major
-- ----------------------------
DROP TABLE IF EXISTS `org_major`;
CREATE TABLE `org_major`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  `college_id` int(0) NULL DEFAULT NULL,
  `school_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of org_major
-- ----------------------------
INSERT INTO `org_major` VALUES (1, '教育技术', '教育技术', b'0', 1, 7);
INSERT INTO `org_major` VALUES (2, '心理学', '心理学', b'0', 1, 7);
INSERT INTO `org_major` VALUES (3, '小学教育', '小学教育', b'0', 1, 7);

-- ----------------------------
-- Table structure for org_school
-- ----------------------------
DROP TABLE IF EXISTS `org_school`;
CREATE TABLE `org_school`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '学校表主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '软删除标识',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校名',
  `attention` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_api054l9hlys8qu58rwoi3c0h`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of org_school
-- ----------------------------
INSERT INTO `org_school` VALUES (3, b'0', '中心小学地址', '2021-05-01 19:50:03', '中心小学', '张三', '123456');
INSERT INTO `org_school` VALUES (4, b'0', '珠海七中地址', NULL, '珠海七中', '吴老师', '1234');
INSERT INTO `org_school` VALUES (5, b'1', '123', NULL, '321', '123', '123');
INSERT INTO `org_school` VALUES (6, b'0', '广大附小', NULL, '广大附小', '某老师', '123');
INSERT INTO `org_school` VALUES (7, b'0', '外环西路', NULL, '', '丁国柱', '123456');
INSERT INTO `org_school` VALUES (8, b'0', '五山', NULL, '华南理工', '李四', '123456');

-- ----------------------------
-- Table structure for sensor_data
-- ----------------------------
DROP TABLE IF EXISTS `sensor_data`;
CREATE TABLE `sensor_data`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据类型',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sensor_id` int(0) NULL DEFAULT NULL COMMENT '传感器id',
  `deleted` bit(1) NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensor_data
-- ----------------------------
INSERT INTO `sensor_data` VALUES (25, 'dht11', '24.00', '温度', '2021-05-01 22:26:43', 1, b'0');
INSERT INTO `sensor_data` VALUES (26, 'dht11', '51.00', '湿度', '2021-05-01 22:26:43', 1, b'0');
INSERT INTO `sensor_data` VALUES (27, 'rs485', '6.8', 'ph值', '2021-05-01 22:26:43', 4, b'0');
INSERT INTO `sensor_data` VALUES (28, 'rs485', '2', '氮', '2021-05-01 22:26:43', 4, b'0');
INSERT INTO `sensor_data` VALUES (29, 'rs485', '20', '磷', '2021-05-01 22:26:43', 4, b'0');
INSERT INTO `sensor_data` VALUES (30, 'rs485', '32', '钾', '2021-05-01 22:26:43', 4, b'0');
INSERT INTO `sensor_data` VALUES (31, 'dht11', '22.00', '温度', '2021-05-01 22:27:03', 1, b'0');
INSERT INTO `sensor_data` VALUES (32, 'dht11', '51.00', '湿度', '2021-05-01 22:27:03', 1, b'0');
INSERT INTO `sensor_data` VALUES (33, 'rs485', '6.4', 'ph值', '2021-05-01 22:27:03', 4, b'0');
INSERT INTO `sensor_data` VALUES (34, 'rs485', '6', '氮', '2021-05-01 22:27:03', 4, b'0');
INSERT INTO `sensor_data` VALUES (35, 'rs485', '8', '磷', '2021-05-01 22:27:03', 4, b'0');
INSERT INTO `sensor_data` VALUES (36, 'rs485', '20', '钾', '2021-05-01 22:27:03', 4, b'0');

-- ----------------------------
-- Table structure for sensor_sensor
-- ----------------------------
DROP TABLE IF EXISTS `sensor_sensor`;
CREATE TABLE `sensor_sensor`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT ' 主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传感器名称',
  `school_id` int(0) NULL DEFAULT NULL COMMENT '学校id',
  `type_id` int(0) NULL DEFAULT NULL COMMENT '传感器类别id',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除标识',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述信息',
  `is_online` bit(1) NULL DEFAULT b'0' COMMENT '是否在线',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensor_sensor
-- ----------------------------
INSERT INTO `sensor_sensor` VALUES (1, 'DHT11', 3, 2, b'0', '2021-05-01 21:52:03', NULL, b'0');
INSERT INTO `sensor_sensor` VALUES (2, '广大附小摄像头', 6, 4, b'0', NULL, NULL, b'0');
INSERT INTO `sensor_sensor` VALUES (3, '珠海七中洒水继电器', 3, 6, b'0', NULL, NULL, b'1');
INSERT INTO `sensor_sensor` VALUES (5, '土地传感器', 3, 3, b'0', NULL, NULL, b'0');

-- ----------------------------
-- Table structure for sensor_type
-- ----------------------------
DROP TABLE IF EXISTS `sensor_type`;
CREATE TABLE `sensor_type`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传感器类别名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传感器类别描述',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '传感器类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensor_type
-- ----------------------------
INSERT INTO `sensor_type` VALUES (1, '213', '                213', b'1');
INSERT INTO `sensor_type` VALUES (2, '温湿度', '  DHT11      ', b'0');
INSERT INTO `sensor_type` VALUES (3, '土壤氮磷钾', '土壤氮磷钾', b'0');
INSERT INTO `sensor_type` VALUES (4, '摄像头', '摄像头 ', b'0');
INSERT INTO `sensor_type` VALUES (5, '光敏传感器', '光敏传感器', b'0');
INSERT INTO `sensor_type` VALUES (6, '继电器（洒水）', '继电器（洒水）', b'0');

SET FOREIGN_KEY_CHECKS = 1;
