CREATE DATABASE IF NOT EXISTS rl_enhanced_report;

USE rl_enhanced_report;

DROP TABLE IF EXISTS `CampaignPerformanceByDeviceAndNetwork`;
DROP TABLE IF EXISTS `_CampaignPerformanceByDeviceAndNetwork_del`;


CREATE TABLE IF NOT EXISTS `CampaignPerformanceByDeviceAndNetwork` (
  `idCampaignPerformanceByDeviceAndNetwork` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idWebPublisher` int(10) unsigned NOT NULL DEFAULT '0',
  `idWebPublisherCampaign` int(10) unsigned NOT NULL DEFAULT '0',
  `report_date` date NOT NULL,
  `device` enum('MOBILE','DESKTOP','TABLET','UNKNOWN','CONNECTED_TV','OTHER','UNSPECIFIED') COLLATE utf8_unicode_ci NOT NULL,
  `network` enum('SEARCH','PARTNER','SEARCH_PARTNER','CONTENT','MIXED','UNKNOWN','UNSPECIFIED','YOUTUBE_SEARCH','YOUTUBE_WATCH','MSFT_SITES_AND_SELECT') COLLATE utf8_unicode_ci NOT NULL,
  `impressions` int(10) unsigned NOT NULL,
  `clicks` int(10) unsigned NOT NULL,
  `cost` decimal(12,2) NOT NULL,
  `avg_position` decimal(8,2) DEFAULT NULL,
  `search_budget_Lost_impression_share` decimal(5,2) DEFAULT NULL,
  `search_exact_match_impression_share` decimal(5,2) DEFAULT NULL,
  `search_impression_share` decimal(5,2) DEFAULT NULL,
  `search_rank_lost_impression_share` decimal(5,2) DEFAULT NULL,
  `publisher_identification_text` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `top_impressions_pct` decimal(8,5) DEFAULT NULL,
  `absolute_top_impressions_pct` decimal(8,5) DEFAULT NULL,
  PRIMARY KEY (`idCampaignPerformanceByDeviceAndNetwork`),
  UNIQUE KEY `idx_cpdn_uindex` (`idWebPublisherCampaign`,`report_date`,`device`,`network`),
  KEY `idx_cpdn_iwpcrd` (`idWebPublisherCampaign`,`report_date`),
  KEY `idx_cpdn_iwp` (`report_date`,`idWebPublisher`),
  KEY `idx_cpdn_ts` (`updated`)
) ENGINE=InnoDB AUTO_INCREMENT=40259832 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

