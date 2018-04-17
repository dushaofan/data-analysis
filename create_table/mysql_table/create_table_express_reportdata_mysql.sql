create database express_reportdata character set utf8;

CREATE TABLE `express_increase_store_num_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `store_id` varchar(255) DEFAULT NULL COMMENT '店铺ID',
  `store_status` varchar(255) DEFAULT NULL COMMENT '状态',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `create_date` date DEFAULT NULL COMMENT '当天时间',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `express_num_abnormality` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `create_date` date DEFAULT NULL COMMENT '日期',
  `area_code` varchar(255) DEFAULT NULL COMMENT '区域编码',
  `store_name` varchar(255) DEFAULT NULL COMMENT '门店名称',
  `store_id` varchar(255) DEFAULT NULL COMMENT '门店id',
  `service_provider_name` varchar(255) DEFAULT NULL COMMENT '服务商',
  `area` varchar(255) DEFAULT NULL COMMENT '地区',
  `express_in_num` int(11) DEFAULT '0' COMMENT '总件量',
  `yesterday_in_num` int(11) DEFAULT '0' COMMENT '前日到店量',
  `yesterday_increase` double(10,2) DEFAULT '0.00' COMMENT '增长百分比',
  `yesterday_reduce` double(10,2) DEFAULT '0.00' COMMENT '减少百分比',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`),
  KEY `area_code` (`area_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;	


CREATE TABLE `express_store_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `area_code` varchar(255) DEFAULT NULL COMMENT '区域邮编',
  `date` date DEFAULT NULL COMMENT '快递记录创建时间',
  `province_code` varchar(255) DEFAULT NULL COMMENT '省邮编',
  `city_code` varchar(255) DEFAULT NULL COMMENT '城市邮编',
  `district_code` varchar(255) DEFAULT NULL COMMENT '区邮编',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  `store_id` varchar(255) DEFAULT NULL COMMENT '店铺ID',
  `store_name` varchar(255) DEFAULT NULL COMMENT '店铺名称',
  `join_time` date DEFAULT NULL COMMENT '店铺创建时间',
  `service_provider_id` varchar(255) DEFAULT NULL COMMENT '服务商ID',
  `service_provider_name` varchar(255) DEFAULT NULL COMMENT '服务商名称',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `district` varchar(255) DEFAULT NULL COMMENT '区域',
  `latitude` varchar(255) DEFAULT NULL COMMENT '纬度',
  `longitude` varchar(255) DEFAULT NULL COMMENT '经度',
  `latitude_and_longitude` varchar(255) DEFAULT NULL COMMENT '经纬度',
  `express_in_num` int(11) DEFAULT '0' COMMENT '入库量',
  `express_sign_num` int(11) DEFAULT '0' COMMENT '签收量',
  `today_express_sign_num` int(11) DEFAULT '0' COMMENT '今日签收量签收量',
  `send_message_num` int(11) DEFAULT '0' COMMENT '短信发送量(success)',
  `total_send_message_num` int(11) DEFAULT '0' COMMENT '总的短信发送量',
  `stagnation_num` int(11) DEFAULT '0' COMMENT '滞留件',
  `express_company_num` int(11) DEFAULT '0' COMMENT '日单量超过20的接入快递公司数',
  `express_company` varchar(255) DEFAULT NULL COMMENT '日单量超过20的接入快递公司名称',
  PRIMARY KEY (`id`),
  KEY `index_date` (`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;