CREATE TABLE `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `url` varchar(255) DEFAULT NULL,
  `feed_uri` varchar(255) DEFAULT NULL,
  `tweeter_id` int(11) DEFAULT NULL,
  `house` varchar(255) DEFAULT NULL,
  `bill_type` varchar(255) DEFAULT NULL,
  `categories` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bills_on_tweeter_id` (`tweeter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;

CREATE TABLE `entry_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `published_date` varchar(255) DEFAULT NULL,
  `published_time` datetime DEFAULT NULL,
  `content` text,
  `entry_query_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `entry_source_id` int(11) DEFAULT NULL,
  `twfy_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_entry_items_on_entry_query_id` (`entry_query_id`),
  KEY `index_entry_items_on_entry_source_id` (`entry_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4726 DEFAULT CHARSET=utf8;

CREATE TABLE `entry_queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `feed_uri` varchar(255) DEFAULT NULL,
  `query` varchar(255) DEFAULT NULL,
  `site_restriction` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_entry_queries_on_bill_id` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8;

CREATE TABLE `entry_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `author_uri` varchar(255) DEFAULT NULL,
  `author_name` varchar(255) DEFAULT NULL,
  `item_host_uri` varchar(255) DEFAULT NULL,
  `item_title_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_entry_sources_on_approved` (`approved`)
) ENGINE=InnoDB AUTO_INCREMENT=592 DEFAULT CHARSET=utf8;

CREATE TABLE `outgoing_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dm_to` varchar(255) DEFAULT NULL,
  `reply_to` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `tweeted` tinyint(1) DEFAULT NULL,
  `tweeted_at` datetime DEFAULT NULL,
  `tweeter_id` int(11) DEFAULT NULL,
  `tweet_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_outgoing_tweets_on_tweeter_id` (`tweeter_id`),
  KEY `index_outgoing_tweets_on_tweet_id` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `slugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sluggable_id` int(11) DEFAULT NULL,
  `sequence` int(11) NOT NULL DEFAULT '1',
  `sluggable_type` varchar(40) DEFAULT NULL,
  `scope` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_slugs_on_name_and_sluggable_type_and_scope_and_sequence` (`name`,`sluggable_type`,`scope`,`sequence`),
  KEY `index_slugs_on_sluggable_id` (`sluggable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8;

CREATE TABLE `tweeters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;

CREATE TABLE `tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dm_to` varchar(255) DEFAULT NULL,
  `reply_to` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `tweeted` tinyint(1) DEFAULT NULL,
  `tweeted_at` datetime DEFAULT NULL,
  `tweeter_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `entry_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_tweets_on_tweeter_id` (`tweeter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27958 DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090509164330');

INSERT INTO schema_migrations (version) VALUES ('20090509165329');

INSERT INTO schema_migrations (version) VALUES ('20090509165331');

INSERT INTO schema_migrations (version) VALUES ('20090509165332');

INSERT INTO schema_migrations (version) VALUES ('20090509165334');

INSERT INTO schema_migrations (version) VALUES ('20090509165336');

INSERT INTO schema_migrations (version) VALUES ('20090509213732');

INSERT INTO schema_migrations (version) VALUES ('20090510100458');

INSERT INTO schema_migrations (version) VALUES ('20090519174350');

INSERT INTO schema_migrations (version) VALUES ('20090525170339');

INSERT INTO schema_migrations (version) VALUES ('20091130193756');