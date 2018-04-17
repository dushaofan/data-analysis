create database zhongbao_reportdata character set utf8;

CREATE TABLE `zhongbao_merchant_order_heat_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `district` varchar(255) DEFAULT NULL COMMENT '区域',
  `longitude` varchar(255) DEFAULT NULL COMMENT '精度',
  `latitude` varchar(255) DEFAULT NULL COMMENT '纬度',
  `finish_num` int(11) DEFAULT NULL COMMENT '完成单量',
  `cancel_num` int(11) DEFAULT NULL COMMENT '取消单量',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `zhongbao_platform_income_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `total_recharge_account` double(24,2) DEFAULT NULL COMMENT '商家充值',
  `total_deposit_account` double(24,2) DEFAULT NULL COMMENT '缴纳押金',
  `total_rider_fine_account` double(24,2) DEFAULT NULL COMMENT '骑手罚单',
  `total_insurance_account` double(24,2) DEFAULT NULL COMMENT '购买保险',
  `total_commission_account` double(24,2) DEFAULT NULL COMMENT '订单佣金',
  `total_gift_account` double(24,2) DEFAULT NULL COMMENT '充值满送',
  `total_rider_withdraw_account` double(24,2) DEFAULT NULL COMMENT '骑手提现',
  `total_create_num` int(11) DEFAULT NULL COMMENT '创搭单量',
  `total_finish_num` int(11) DEFAULT NULL COMMENT '完成单量',
  `income_total_amount` double(24,2) DEFAULT '0.00' COMMENT '平台总收入',
  `outcome_total_amount` double(24,2) DEFAULT '0.00' COMMENT '平台总支出',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `zhongbao_total_receiver_rider_ids_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `total_receiver_rider_ids` int(11) DEFAULT NULL COMMENT '接单骑手ID',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `zhongbao_total_recharge_merchant_ids_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `total_recharge_merchant_ids` int(11) DEFAULT NULL COMMENT '充值商家id',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `zhongbao_total_send_merchant_ids_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `total_send_merchant_ids` int(11) DEFAULT NULL COMMENT '发单商家',
  PRIMARY KEY (`id`),
  KEY `index_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

