CREATE DATABASE IF NOT EXISTS widget_demo;

USE widget_demo;

DROP TABLE IF EXISTS `WidgetEventLog`;
DROP TABLE IF EXISTS `_WidgetEventLog_del`;

CREATE TABLE IF NOT EXISTS `WidgetEventLog` (
  `eventId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `widgetId` int(10) unsigned NOT NULL DEFAULT '0',
  `userRef` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `eventType` enum('CLICK','VIEW','DRAG','DROP','HOVER','FOCUS','BLUR','CUSTOM') COLLATE utf8_unicode_ci NOT NULL,
  `eventTimestamp` datetime NOT NULL,
  `payloadJson` text COLLATE utf8_unicode_ci,
  `sourceIp` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `browserFingerprint` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sessionToken` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isSynthetic` tinyint(1) NOT NULL DEFAULT '0',
  `latencyMs` int(10) unsigned DEFAULT NULL,
  `errorCode` int(10) unsigned DEFAULT NULL,
  `extraInfo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eventId`),
  UNIQUE KEY `idx_widget_event_unique` (`widgetId`,`eventTimestamp`,`eventType`),
  KEY `idx_widget_userref` (`userRef`),
  KEY `idx_widget_eventtype` (`eventType`),
  KEY `idx_widget_createdAt` (`createdAt`)
) ENGINE=InnoDB AUTO_INCREMENT=50000 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
