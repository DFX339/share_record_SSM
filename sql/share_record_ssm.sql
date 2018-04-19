/*
Navicat MySQL Data Transfer
Source Host     : localhost:3306
Source Database : share_record_ssm
Target Host     : localhost:3306
Target Database : share_record_ssm
Date: 2018-04-11 11:27:30
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for t_mail
-- ----------------------------
DROP TABLE IF EXISTS `t_mail`;
CREATE TABLE `t_mail` (
  `id` int(11) NOT NULL auto_increment,
  `sendid` int(11) NOT NULL,
  `recieveid` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(20000) NOT NULL,
  `createtime` datetime NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_mail
-- ----------------------------
INSERT INTO `t_mail` VALUES ('1', '28', '1', '清明节假期系统升级通知', '于2018年04月3日至2018年04月6日为国定节假日。系统准备在此期间进行升级。给您带来的不便敬请谅解！祝您生活愉快', '2018-04-09 11:18:43', '2');
INSERT INTO `t_mail` VALUES ('2', '28', '29', '清明节假期系统升级通知', '于2018年04月3日至2018年04月6日为国定节假日。系统准备在此期间进行升级。给您带来的不便敬请谅解！祝您生活愉快', '2018-04-09 11:18:44', '2');
INSERT INTO `t_mail` VALUES ('3', '1', '28', '测试发送邮件', '邮件能否正常发送呀', '2018-04-09 11:27:13', '2');
INSERT INTO `t_mail` VALUES ('4', '1', '29', '测试发送邮件', '邮件能否正常发送呀', '2018-04-09 11:27:13', '1');
INSERT INTO `t_mail` VALUES ('5', '29', '1', '银行业务分析', '了解银行业务知识吗？快去了解吧', '2018-04-09 11:43:39', '2');
INSERT INTO `t_mail` VALUES ('6', '29', '28', '银行业务分析', '了解银行业务知识吗？快去了解吧', '2018-04-09 11:43:39', '2');

-- ----------------------------
-- Table structure for t_meeting
-- ----------------------------
DROP TABLE IF EXISTS `t_meeting`;
CREATE TABLE `t_meeting` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `title` varchar(255) character set utf8 NOT NULL,
  `content` varchar(20000) NOT NULL,
  `createtime` datetime NOT NULL,
  `companynum` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_meeting
-- ----------------------------
INSERT INTO `t_meeting` VALUES ('1', '29', '财税库项目的第一次例会', '需要明确的步骤\r\n了解系统框架，熟悉系统使用流程\r\n确定需要修改的功能\r\n搭建系统环境', '2018-04-09 11:38:20', '1000');

-- ----------------------------
-- Table structure for t_meetingcomment
-- ----------------------------
DROP TABLE IF EXISTS `t_meetingcomment`;
CREATE TABLE `t_meetingcomment` (
  `id` int(11) NOT NULL auto_increment,
  `meetingid` int(11) NOT NULL,
  `meetinguserid` int(11) NOT NULL,
  `commentid` int(11) NOT NULL,
  `content` varchar(255) character set utf8 NOT NULL,
  `createtime` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_meetingcomment
-- ----------------------------
INSERT INTO `t_meetingcomment` VALUES ('1', '1', '29', '29', '还有一个是了解业务知识', '2018-04-09 11:38:49');

-- ----------------------------
-- Table structure for t_note
-- ----------------------------
DROP TABLE IF EXISTS `t_note`;
CREATE TABLE `t_note` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `title` varchar(255) character set utf8 NOT NULL,
  `content` varchar(20000) NOT NULL,
  `createtime` datetime NOT NULL,
  `state` varchar(255) character set utf8 NOT NULL COMMENT '记笔状态public表示公开，private表示私密',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_note
-- ----------------------------
INSERT INTO `t_note` VALUES ('10', '28', 'SpringMVC工作流程', 'DispatcherServlet：作为前端控制器，整个流程控制的中心.\r\n\r\nHandlerMapping：通过扩展处理器映射器实现不同的映射方式.\r\nHandlAdapter：通过扩展处理器适配器，支持更多类型的处理器。\r\n\r\nViewResolver：通过扩展视图解析器，支持更多类型的视图解析.', '2018-04-08 14:50:16', 'public');
INSERT INTO `t_note` VALUES ('12', '29', 'Spring请求方式', 'SpringMVC注解@RequestMapping注解除了params,header属性，\r\n还有一个非常重要的属性??method，method的四种取值\r\nGET,POST,DELETE,PUT方式刚好对应了SpringMVC的四种请求方式。\r\n', '2018-04-08 17:07:51', 'public');
INSERT INTO `t_note` VALUES ('13', '28', 'Springmvc乱码解决方法', '中文乱码可以通过设计编码拦截器去解决。\r\n当请为POST时，该方法有效。\r\n当请求为GET时，得另行方法。\r\n返回json数据可以通过配置springmvc配置文件去解决。', '2018-04-09 11:20:34', 'public');

-- ----------------------------
-- Table structure for t_notecomment
-- ----------------------------
DROP TABLE IF EXISTS `t_notecomment`;
CREATE TABLE `t_notecomment` (
  `id` int(11) NOT NULL auto_increment,
  `noteid` int(11) NOT NULL,
  `noteuserid` int(11) NOT NULL,
  `commentid` int(11) NOT NULL,
  `content` varchar(255) character set utf8 NOT NULL,
  `createtime` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_notecomment
-- ----------------------------
INSERT INTO `t_notecomment` VALUES ('1', '10', '28', '29', 'DispatcherServlet也叫做请求分派器', '2018-04-09 11:39:38');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(20000) NOT NULL,
  `createtime` datetime NOT NULL,
  `createid` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('44', '您好，欢迎使用笔记共享与会议记录系统，望你使用愉快！', '2018-04-08 15:39:26', '1');
INSERT INTO `t_notice` VALUES ('45', '系统于2018年4月8日至2018年4月11日进行整体升级，带来的不便敬请谅解。', '2018-04-08 15:43:12', '1');

-- ----------------------------
-- Table structure for t_person
-- ----------------------------
DROP TABLE IF EXISTS `t_person`;
CREATE TABLE `t_person` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键',
  `usernum` varchar(255) character set utf8 NOT NULL COMMENT '用户账号',
  `username` varchar(255) character set utf8 NOT NULL COMMENT '用户昵称',
  `password` varchar(255) character set utf8 NOT NULL COMMENT '用户密码',
  `identity` int(11) NOT NULL COMMENT '用户身份',
  `companynum` varchar(255) character set utf8 default NULL COMMENT '公司编号',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_person
-- ----------------------------
INSERT INTO `t_person` VALUES ('1', '10000', '管理员', '123', '3', null);
INSERT INTO `t_person` VALUES ('28', '10001', '普通-阿叮', '123', '1', '');
INSERT INTO `t_person` VALUES ('29', '10002', '企业-张三', '123', '2', '1000');

-- ----------------------------
-- Table structure for t_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_plan`;
CREATE TABLE `t_plan` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `content` varchar(20000) character set utf8 NOT NULL,
  `createtime` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of t_plan
-- ----------------------------
INSERT INTO `t_plan` VALUES ('5', '1', '做份笔记', '2018-04-08 16:08:40');
INSERT INTO `t_plan` VALUES ('6', '1', '哼', '2018-04-08 16:11:42');
INSERT INTO `t_plan` VALUES ('7', '1', '哦', '2018-04-08 16:14:14');
